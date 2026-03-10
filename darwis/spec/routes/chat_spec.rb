require "spec_helper"

RSpec.describe "Chat Routes" do
  describe "POST /api/chat/send" do
    context "with valid input" do
      let(:session) { Session.create!(name: "Test Session") }

      before do
        allow(Z::AI).to receive(:chat).and_return(
          double(
            completions: double(
              create: double(
                choices: [
                  double(message: double(content: "AI response"))
                ]
              )
            )
          )
        )
      end

      it "creates user and assistant messages" do
        expect do
          post "/api/chat/send", { session_id: session.id, content: "Hello" }.to_json,
               { "CONTENT_TYPE" => "application/json" }
        end.to change { session.messages.count }.by(2)
      end

      it "returns assistant message" do
        post "/api/chat/send", { session_id: session.id, content: "Hello" }.to_json,
             { "CONTENT_TYPE" => "application/json" }

        expect(last_response.status).to eq(200)
        json = JSON.parse(last_response.body)
        expect(json["role"]).to eq("assistant")
        expect(json["content"]).to eq("AI response")
      end

      it "creates new session if session_id is not provided" do
        expect do
          post "/api/chat/send", { content: "Hello" }.to_json, { "CONTENT_TYPE" => "application/json" }
        end.to change { Session.count }.by(1)
      end
    end

    context "with invalid input" do
      it "returns 400 when content is missing" do
        post "/api/chat/send", { session_id: 1 }.to_json, { "CONTENT_TYPE" => "application/json" }

        expect(last_response.status).to eq(400)
        json = JSON.parse(last_response.body)
        expect(json["code"]).to eq("INVALID_INPUT")
      end
    end

    context "AI API errors" do
      let(:session) { Session.create!(name: "Test Session") }

      before do
        allow(Z::AI).to receive(:chat).and_raise(Z::AI::APIAuthenticationError, "Auth failed")
      end

      it "returns 500 for authentication error" do
        post "/api/chat/send", { session_id: session.id, content: "Hello" }.to_json,
             { "CONTENT_TYPE" => "application/json" }

        expect(last_response.status).to eq(500)
        json = JSON.parse(last_response.body)
        expect(json["code"]).to eq("AI_AUTH_ERROR")
      end
    end
  end
end
