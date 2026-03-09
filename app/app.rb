require 'roda'
require 'sequel'

class App < Roda
  plugin :render, engine: 'erb', views: 'app/views'
  plugin :session, secret: ENV.fetch('SESSION_SECRET')
  plugin :csrf
  plugin :h
  plugin :static, root: 'app/public', urls: ['/css', '/js', '/images']

  DB = Sequel.connect(ENV.fetch('DATABASE_URL', 'sqlite:///db/development.sqlite3'))

  route do |r|
    r.on "api" do
      r.on "health" do
        r.get do
          {status: 'ok', message: 'Darwis API is running'}.to_json
        end
      end
    end

    r.root do
      response.write "Hello from Darwis!"
    end
  end
end
