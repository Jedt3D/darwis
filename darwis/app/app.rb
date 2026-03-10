require "roda"
require "json"
require "dotenv/load"
require "active_record"

Dotenv.load

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ENV.fetch("DATABASE_PATH", "db/development.sqlite3")
)

class App < Roda
  plugin :render, engine: "erb", views: "app/views"
  plugin :static, root: "app/public", urls: ["/css", "/js", "/images"]
  plugin :json

  route do |r|
    r.on "api" do
      r.on "health" do
        r.get do
          {status: "ok", message: "Darwis API is running"}.to_json
        end
      end
    end

    r.root do
      render "index"
    end
  end
end