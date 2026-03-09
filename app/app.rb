require 'roda'
require 'json'

class App < Roda
  plugin :render, engine: 'erb', views: 'app/views'
  plugin :static, root: 'app/public', urls: ['/css', '/js', '/images']

  route do |r|
    r.on "api" do
      r.on "health" do
        r.get do
          {status: 'ok', message: 'Darwis API is running'}.to_json
        end
      end
    end

    r.root do
      render 'index'
    end
  end
end
