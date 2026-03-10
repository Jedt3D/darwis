App.route do |r|
  r.on "api" do
    r.on "chat" do
      r.post do
        request_body = r.body.read
        payload = JSON.parse(request_body)
        raise ValidationError, "content is required" if payload["content"].blank?

        result = ChatService.send_message(
          session_id: payload["session_id"],
          content: payload["content"]
        )

        r.json(result)
      end
    end
  end
end
