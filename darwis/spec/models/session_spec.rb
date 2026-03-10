require "spec_helper"

RSpec.describe Session do
  describe "validations" do
    it "is valid with a name" do
      session = Session.new(name: "Test Session")
      expect(session).to be_valid
    end

    it "is invalid without a name" do
      session = Session.new(name: nil)
      expect(session).not_to be_valid
      expect(session.errors[:name]).to include("can't be blank")
    end
  end

  describe "associations" do
    it "has many messages" do
      session = Session.create!(name: "Test Session")
      message1 = session.messages.create!(role: "user", content: "Hello")
      message2 = session.messages.create!(role: "assistant", content: "Hi there")

      expect(session.messages).to include(message1, message2)
    end

    it "destroys associated messages when destroyed" do
      session = Session.create!(name: "Test Session")
      message = session.messages.create!(role: "user", content: "Hello")
      message_id = message.id

      session.destroy

      expect { Message.find(message_id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
