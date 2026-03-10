require "spec_helper"

RSpec.describe "Sessions Routes" do
  describe "POST /api/sessions" do
    it "creates a new session" do
      expect do
        post "/api/sessions", { name: "My Chat" }.to_json, { "CONTENT_TYPE" => "application/json" }
      end.to change { Session.count }.by(1)
    end

    it "returns the created session" do
      post "/api/sessions", { name: "My Chat" }.to_json, { "CONTENT_TYPE" => "application/json" }

      expect(last_response.status).to eq(200)
      json = JSON.parse(last_response.body)
      expect(json["name"]).to eq("My Chat")
      expect(json["id"]).to be_present
    end

    it "creates session with default name when name is not provided" do
      post "/api/sessions", {}.to_json, { "CONTENT_TYPE" => "application/json" }

      expect(last_response.status).to eq(200)
      json = JSON.parse(last_response.body)
      expect(json["name"]).to match(/Chat \d{4}-\d{2}-\d{2}/)
    end
  end

  describe "GET /api/sessions" do
    let!(:session1) { Session.create!(name: "Session 1", created_at: 1.day.ago) }
    let!(:session2) { Session.create!(name: "Session 2", created_at: 2.days.ago) }

    it "returns all sessions" do
      get "/api/sessions"

      expect(last_response.status).to eq(200)
      json = JSON.parse(last_response.body)
      expect(json.size).to eq(2)
    end

    it "returns sessions in descending order by created_at" do
      get "/api/sessions"

      json = JSON.parse(last_response.body)
      expect(json.first["name"]).to eq("Session 1")
      expect(json.last["name"]).to eq("Session 2")
    end
  end

  describe "GET /api/sessions/:id" do
    let!(:session) { Session.create!(name: "Test Session") }
    let!(:message1) { session.messages.create!(role: "user", content: "Hello") }
    let!(:message2) { session.messages.create!(role: "assistant", content: "Hi") }

    it "returns the session with messages" do
      get "/api/sessions/#{session.id}"

      expect(last_response.status).to eq(200)
      json = JSON.parse(last_response.body)
      expect(json["id"]).to eq(session.id)
      expect(json["name"]).to eq("Test Session")
      expect(json["messages"].size).to eq(2)
    end

    it "returns 404 for non-existent session" do
      get "/api/sessions/999999"

      expect(last_response.status).to eq(404)
      json = JSON.parse(last_response.body)
      expect(json["code"]).to eq("NOT_FOUND")
    end
  end

  describe "DELETE /api/sessions/:id" do
    let!(:session) { Session.create!(name: "Test Session") }

    it "deletes the session" do
      expect do
        delete "/api/sessions/#{session.id}"
      end.to change { Session.count }.by(-1)
    end

    it "returns success message" do
      delete "/api/sessions/#{session.id}"

      expect(last_response.status).to eq(200)
      json = JSON.parse(last_response.body)
      expect(json["success"]).to be true
    end

    it "deletes associated messages" do
      message = session.messages.create!(role: "user", content: "Hello")

      delete "/api/sessions/#{session.id}"

      expect(Message.find_by(id: message.id)).to be_nil
    end
  end

  describe "GET /api/sessions/:id/messages" do
    let!(:session) { Session.create!(name: "Test Session") }
    let!(:message1) { session.messages.create!(role: "user", content: "First") }
    let!(:message2) { session.messages.create!(role: "assistant", content: "Second") }

    it "returns all messages for the session" do
      get "/api/sessions/#{session.id}/messages"

      expect(last_response.status).to eq(200)
      json = JSON.parse(last_response.body)
      expect(json.size).to eq(2)
    end

    it "returns messages in chronological order" do
      get "/api/sessions/#{session.id}/messages"

      json = JSON.parse(last_response.body)
      expect(json.first["content"]).to eq("First")
      expect(json.last["content"]).to eq("Second")
    end

    it "returns 404 for non-existent session" do
      get "/api/sessions/999999/messages"

      expect(last_response.status).to eq(404)
    end
  end
end
