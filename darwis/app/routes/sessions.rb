App.route do |r|
  r.on "api" do
    r.on "sessions" do
      r.post do
        request_body = r.body.read
        payload = JSON.parse(request_body)
        result = ChatService.create_session(name: payload["name"])
        r.json(result)
      end

      r.is do
        sessions = ChatService.list_sessions
        r.json(sessions)
      end

      r.is Integer do |id|
        r.get do
          session = ChatService.get_session(id)
          raise NotFoundError, "Session not found" unless session

          r.json(session)
        end

        r.delete do
          ChatService.delete_session(id)
          r.json({ success: true })
        end
      end

      r.is Integer, "messages" do |id|
        messages = ChatService.get_session_messages(id:)
        raise NotFoundError, "Session not found" if messages.empty? && !Session.exists?(id)

        r.json(messages)
      end
    end
  end
end
