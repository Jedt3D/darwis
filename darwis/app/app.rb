require "roda"
require "json"
require_relative "models/session"
require_relative "models/message"
require_relative "services/chat_service"

class ValidationError < StandardError; end
class NotFoundError < StandardError; end

class App < Roda
  plugin :render, engine: "erb", views: "app/views"
  plugin :static, root: "app/public", urls: ["/css", "/js", "/images"]
  plugin :json

  plugin :error_handler do |e|
    case e
    when ValidationError
      response.status = 400
      { error: e.message, code: "INVALID_INPUT" }
    when NotFoundError
      response.status = 404
      { error: e.message, code: "NOT_FOUND" }
    when Z::AI::APIAuthenticationError
      response.status = 500
      { error: "AI API authentication failed", code: "AI_AUTH_ERROR" }
    when Z::AI::APIRateLimitError
      response.status = 500
      { error: "AI API rate limit exceeded", code: "AI_RATE_LIMIT" }
    when Z::AI::APIStatusError
      response.status = 500
      { error: "AI API connectivity error", code: "AI_CONNECTION_ERROR" }
    else
      response.status = 500
      { error: "Internal server error", code: "INTERNAL_ERROR" }
    end
  end

  route do |r|
    load "app/routes/chat.rb"
    load "app/routes/sessions.rb"

    r.on "health" do
      r.get { { status: "ok", message: "Darwis API is running" } }
    end

    r.root do
      render "index"
    end
  end
end
