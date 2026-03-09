require 'spec_helper'
require 'rack/test'

RSpec.describe 'Root route' do
  let(:app) { App.freeze.app }

  context 'GET /' do
    it 'returns 200 status' do
      response = app.call(Rack::MockRequest.env_for('/'))
      expect(response[0]).to eq(200)
    end

    it 'returns welcome message' do
      response = app.call(Rack::MockRequest.env_for('/'))
      body = response[2].join
      expect(body).to include('Welcome to Darwis')
    end
  end

  context 'GET /api/health' do
    it 'returns 200 status' do
      response = app.call(Rack::MockRequest.env_for('/api/health'))
      expect(response[0]).to eq(200)
    end

    it 'returns JSON response' do
      response = app.call(Rack::MockRequest.env_for('/api/health'))
      body = response[2].join
      data = JSON.parse(body)
      expect(data['status']).to eq('ok')
    end
  end
end
