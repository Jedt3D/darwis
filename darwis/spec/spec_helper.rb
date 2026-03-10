require "roda"
require "rack/test"
require "active_record"
require "database_cleaner/active_record"

ENV["RACK_ENV"] = "test"

class ValidationError < StandardError; end
class NotFoundError < StandardError; end

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)

ActiveRecord::Schema.define do
  create_table :sessions, force: true do |t|
    t.string :name, null: false
    t.timestamps
  end

  create_table :messages, force: true do |t|
    t.references :session, null: false, foreign_key: true
    t.string :role, null: false
    t.text :content, null: false
    t.timestamps
  end
end

DatabaseCleaner.strategy = :transaction

RSpec.configure do |config|
  config.expect_with :rspec
  config.mock_with :rspec
  config.color = true
  config.warnings = false
  config.filter_run_when_matching :focus
  config.order = :random
  config.run_all_when_everything_filtered = true
  config.default_formatter = "doc"

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.include Rack::Test::Methods
end

require_relative "../app/models/session"
require_relative "../app/models/message"
require_relative "../app/services/chat_service"
require_relative "../app/app"

def app
  App
end
