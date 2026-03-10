class ChatService
  def self.send_message(session_id:, content:)
    session = find_or_create_session(session_id)
    create_message(session_id: session.id, role: "user", content: content)

    conversation = build_conversation_context(session.id)
    ai_content = call_zai_api(conversation)

    assistant_message = create_message(session_id: session.id, role: "assistant", content: ai_content)

    {
      id: assistant_message.id,
      session_id: session.id,
      role: assistant_message.role,
      content: assistant_message.content,
      created_at: assistant_message.created_at
    }
  end

  def self.create_session(name:)
    timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    session_name = name.presence || "Chat #{timestamp}"
    Session.create(name: session_name)
  end

  def self.get_session(id:)
    session = Session.includes(:messages).find_by(id: id)
    return nil unless session

    {
      id: session.id,
      name: session.name,
      created_at: session.created_at,
      updated_at: session.updated_at,
      messages: session.messages.chronological.map do |msg|
        {
          id: msg.id,
          role: msg.role,
          content: msg.content,
          created_at: msg.created_at
        }
      end
    }
  end

  def self.delete_session(id:)
    session = Session.find_by(id: id)
    return nil unless session

    session.destroy
  end

  def self.list_sessions
    Session.order(created_at: :desc).map do |session|
      {
        id: session.id,
        name: session.name,
        created_at: session.created_at,
        updated_at: session.updated_at
      }
    end
  end

  def self.get_session_messages(id:)
    session = Session.find_by(id: id)
    return [] unless session

    session.messages.chronological.map do |msg|
      {
        id: msg.id,
        session_id: msg.session_id,
        role: msg.role,
        content: msg.content,
        created_at: msg.created_at
      }
    end
  end

  def self.find_or_create_session(session_id)
    if session_id.present?
      Session.find(session_id)
    else
      create_session(name: nil)
    end
  end

  def self.create_message(session_id:, role:, content:)
    Message.create(
      session_id: session_id,
      role: role,
      content: content
    )
  end

  def self.build_conversation_context(session_id)
    messages = Message.where(session_id: session_id).chronological
    messages.map do |msg|
      {
        role: msg.role,
        content: msg.content
      }
    end
  end

  def self.call_zai_api(conversation)
    return "I'm sorry, but I'm having trouble connecting to the AI service right now." unless defined?(Z::AI)

    begin
      response = Z::AI.chat.completions.create(
        model: "glm-5",
        messages: conversation
      )
      response.choices&.first&.message&.content || "No response from AI"
    rescue Z::AI::APIAuthenticationError => e
      raise "AI API authentication error: #{e.message}"
    rescue Z::AI::APIRateLimitError => e
      raise "AI API rate limit error: #{e.message}"
    rescue Z::AI::APIStatusError => e
      raise "AI API status error: #{e.message}"
    rescue StandardError => e
      raise "AI API error: #{e.message}"
    end
  end
end
