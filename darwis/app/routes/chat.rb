class App
  route do |r|
    r.on "api" do
      r.on "chat" do
        r.post do
          request_body = r.body.read
          payload = JSON.parse(request_body)
          raise ValidationError, "content is required" if payload['content'].blank?

          result = ChatService.send_message(
            session_id: payload['session_id'],
            content: payload['content']
          )

          r.json(result)
        end
      end

      r.on "sessions" do
        r.post do
          request_body = r.body.read
          payload = JSON.parse(request_body)
          result = ChatService.create_session(name: payload['name'])
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
            result = ChatService.delete_session(id)
            r.json({success: true})
          end
        end
      end
    end

    r.on "health" do
      r.get { {status: 'ok', message: 'Darwis API is running'} }
    end

    r.root do
      render 'index'
    end
  end
end
