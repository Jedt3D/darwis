require "spec_helper"

RSpec.describe ChatService do
  describe ".create_session" do
    it "creates a session with the given name" do
      session = ChatService.create_session(name: "My Chat")

      expect(session).to be_a(Hash)
      expect(session[:name]).to eq("My Chat")
      expect(session[:id]).to be_present
      expect(session[:created_at]).to be_present
    end

    it "creates a session with default name when name is nil" do
      session = ChatService.create_session(name: nil)

      expect(session[:name]).to match(/Chat \d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/)
    end

    it "creates a session with default name when name is empty string" do
      session = ChatService.create_session(name: "")

      expect(session[:name]).to match(/Chat \d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/)
    end
  end

  describe ".get_session" do
    let!(:session) { Session.create!(name: "Test Session") }
    let!(:message1) { session.messages.create!(role: "user", content: "Hello") }
    let!(:message2) { session.messages.create!(role: "assistant", content: "Hi") }

    it "returns session with messages" do
      result = ChatService.get_session(id: session.id)

      expect(result).to be_a(Hash)
      expect(result[:id]).to eq(session.id)
      expect(result[:name]).to eq("Test Session")
      expect(result[:messages]).to be_an(Array)
      expect(result[:messages].size).to eq(2)
    end

    it "returns nil for non-existent session" do
      result = ChatService.get_session(id: 999_999)

      expect(result).to be_nil
    end

    it "returns messages in chronological order" do
      result = ChatService.get_session(id: session.id)

      expect(result[:messages].first[:role]).to eq("user")
      expect(result[:messages].last[:role]).to eq("assistant")
    end
  end

  describe ".delete_session" do
    let!(:session) { Session.create!(name: "Test Session") }

    it "deletes the session" do
      ChatService.delete_session(id: session.id)

      expect(Session.find_by(id: session.id)).to be_nil
    end

    it "returns nil for non-existent session" do
      result = ChatService.delete_session(id: 999_999)

      expect(result).to be_nil
    end

    it "deletes associated messages" do
      message = session.messages.create!(role: "user", content: "Hello")
      message_id = message.id

      ChatService.delete_session(id: session.id)

      expect(Message.find_by(id: message_id)).to be_nil
    end
  end

  describe ".list_sessions" do
    let!(:session1) { Session.create!(name: "Session 1", created_at: 1.day.ago) }
    let!(:session2) { Session.create!(name: "Session 2", created_at: 2.days.ago) }

    it "returns all sessions" do
      sessions = ChatService.list_sessions

      expect(sessions).to be_an(Array)
      expect(sessions.size).to eq(2)
    end

    it "returns sessions in descending order by created_at" do
      sessions = ChatService.list_sessions

      expect(sessions.first[:name]).to eq("Session 1")
      expect(sessions.last[:name]).to eq("Session 2")
    end
  end

  describe ".get_session_messages" do
    let!(:session) { Session.create!(name: "Test Session") }
    let!(:message1) { session.messages.create!(role: "user", content: "First") }
    let!(:message2) { session.messages.create!(role: "assistant", content: "Second") }

    it "returns all messages for a session" do
      messages = ChatService.get_session_messages(id: session.id)

      expect(messages).to be_an(Array)
      expect(messages.size).to eq(2)
    end

    it "returns empty array for non-existent session" do
      messages = ChatService.get_session_messages(id: 999_999)

      expect(messages).to eq([])
    end

    it "returns messages in chronological order" do
      messages = ChatService.get_session_messages(id: session.id)

      expect(messages.first[:content]).to eq("First")
      expect(messages.last[:content]).to eq("Second")
    end
  end

  describe ".send_message" do
    let!(:session) { Session.create!(name: "Test Session") }

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

    it "creates user message" do
      ChatService.send_message(session_id: session.id, content: "Hello")

      user_message = Message.find_by(session_id: session.id, role: "user", content: "Hello")
      expect(user_message).to be_present
    end

    it "creates assistant message with AI response" do
      ChatService.send_message(session_id: session.id, content: "Hello")

      assistant_message = Message.find_by(session_id: session.id, role: "assistant")
      expect(assistant_message).to be_present
      expect(assistant_message.content).to eq("AI response")
    end

    it "returns assistant message data" do
      result = ChatService.send_message(session_id: session.id, content: "Hello")

      expect(result[:role]).to eq("assistant")
      expect(result[:content]).to eq("AI response")
      expect(result[:session_id]).to eq(session.id)
    end

    it "creates new session if session_id is nil" do
      initial_count = Session.count
      ChatService.send_message(session_id: nil, content: "Hello")

      expect(Session.count).to eq(initial_count + 1)
    end

    it "includes conversation history in API call" do
      session.messages.create!(role: "user", content: "Previous message")

      expect(Z::AI.chat.completions).to receive(:create).with(
        hash_including(messages: a_kind_of(Array))
      ).and_call_original

      ChatService.send_message(session_id: session.id, content: "New message")
    end
  end
end
