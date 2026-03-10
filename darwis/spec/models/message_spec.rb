require "spec_helper"

RSpec.describe Message do
  describe "validations" do
    let(:session) { Session.create!(name: "Test Session") }

    it "is valid with a session, role, and content" do
      message = Message.new(
        session: session,
        role: "user",
        content: "Hello"
      )
      expect(message).to be_valid
    end

    it "is invalid without a session" do
      message = Message.new(
        role: "user",
        content: "Hello"
      )
      expect(message).not_to be_valid
      expect(message.errors[:session]).to include("must exist")
    end

    it "is invalid without a role" do
      message = Message.new(
        session: session,
        content: "Hello"
      )
      expect(message).not_to be_valid
      expect(message.errors[:role]).to include("can't be blank")
    end

    it "is invalid without content" do
      message = Message.new(
        session: session,
        role: "user"
      )
      expect(message).not_to be_valid
      expect(message.errors[:content]).to include("can't be blank")
    end

    it "is valid with user role" do
      message = Message.new(
        session: session,
        role: "user",
        content: "Hello"
      )
      expect(message).to be_valid
    end

    it "is valid with assistant role" do
      message = Message.new(
        session: session,
        role: "assistant",
        content: "Hi there"
      )
      expect(message).to be_valid
    end

    it "is invalid with invalid role" do
      message = Message.new(
        session: session,
        role: "invalid",
        content: "Hello"
      )
      expect(message).not_to be_valid
      expect(message.errors[:role]).to include("is not included in the list")
    end
  end

  describe "associations" do
    it "belongs to a session" do
      session = Session.create!(name: "Test Session")
      message = session.messages.create!(role: "user", content: "Hello")

      expect(message.session).to eq(session)
    end
  end

  describe "scopes" do
    let(:session) { Session.create!(name: "Test Session") }

    it "returns messages in chronological order" do
      message1 = session.messages.create!(role: "user", content: "First")
      message2 = session.messages.create!(role: "assistant", content: "Second")
      message3 = session.messages.create!(role: "user", content: "Third")

      expect(session.messages.chronological).to eq([message1, message2, message3])
    end
  end
end
