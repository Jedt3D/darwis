## 1. Project Setup

- [ ] 1.1 Create darwis-chat/ directory structure with subdirectories (app, db, spec, lib)
- [ ] 1.2 Create Gemfile with Ruby 3.3.7, Roda, SQLite3, ActiveRecord, RubyLLM, dotenv, rake, rspec, rubocop
- [ ] 1.3 Create .env.example with ZAI_API_KEY placeholder
- [ ] 1.4 Create .ruby-version file with 3.3.7
- [ ] 1.5 Create config.ru for Rack application startup
- [ ] 1.6 Create Rakefile with database tasks (db:create, db:migrate, db:rollback, db:reset)
- [ ] 1.7 Create .rubocop.yml configuration file
- [ ] 1.8 Run bundle install to install dependencies
- [ ] 1.9 Create .rspec configuration file
- [ ] 1.10 Create spec/spec_helper.rb with RSpec configuration

## 2. Database Setup

- [ ] 2.1 Create db/migrate/001_create_sessions.rb migration
- [ ] 2.2 Create db/migrate/002_create_messages.rb migration
- [ ] 2.3 Run rake db:create to create SQLite database file
- [ ] 2.4 Run rake db:migrate to create sessions and messages tables

## 3. Models

- [ ] 3.1 Create app/models/session.rb ActiveRecord model with name, created_at, updated_at
- [ ] 3.2 Create app/models/message.rb ActiveRecord model with session_id, role, content, created_at
- [ ] 3.3 Add validations: Session name presence, Message role inclusion (user/assistant), Message content presence
- [ ] 3.4 Add associations: Session has_many messages, Message belongs_to session
- [ ] 3.5 Add database indexes: messages.session_id for query performance

## 4. Roda Application Structure

- [ ] 4.1 Create app/app.rb Roda application class
- [ ] 4.2 Load required gems (dotenv, roda, activerecord)
- [ ] 4.3 Configure ActiveRecord database connection from DATABASE_URL
- [ ] 4.4 Create route structure for chat endpoints
- [ ] 4.5 Add root route handler
- [ ] 4.6 Add /chat route for message submission
- [ ] 4.7 Add /history route for session history retrieval

## 5. Terminal Interface

- [ ] 5.1 Create lib/chat_interface.rb with Readline-based terminal UI
- [ ] 5.2 Implement prompt display (e.g., "You: ")
- [ ] 5.3 Implement Readline configuration for command history
- [ ] 5.4 Implement message input handling with arrow key navigation
- [ ] 5.5 Implement AI response display (e.g., "AI: ")
- [ ] 5.6 Handle empty input (ignore and show prompt again)
- [ ] 5.7 Add support for exit command (/exit or /quit)

## 6. RubyLLM Integration

- [ ] 6.1 Create lib/llm_service.rb for RubyLLM integration
- [ ] 6.2 Implement RubyLLM client initialization with ZAI provider
- [ ] 6.3 Read ZAI_API_KEY from environment variables
- [ ] 6.4 Implement error handling for missing API key
- [ ] 6.5 Implement message sending to LLM via RubyLLM
- [ ] 6.6 Implement response extraction and text formatting
- [ ] 6.7 Add conversation context management across message exchanges
- [ ] 6.8 Handle API errors (authentication, rate limit, connectivity)

## 7. Service Layer

- [ ] 7.1 Create app/services/chat_service.rb for chat business logic
- [ ] 7.2 Implement session creation (generate default name)
- [ ] 7.3 Implement message persistence (store user messages and AI responses)
- [ ] 7.4 Implement message retrieval by session
- [ ] 7.5 Integrate with LLM service for AI responses

## 8. Application Startup

- [ ] 8.1 Create bin/chat executable script
- [ ] 8.2 Make bin/chat executable with proper shebang
- [ ] 8.3 Implement environment loading with dotenv
- [ ] 8.4 Add ZAI_API_KEY validation on startup
- [ ] 8.5 Initialize database connection
- [ ] 8.6 Start terminal chat interface

## 9. Testing

- [ ] 9.1 Create spec/models/session_spec.rb with model validations and associations tests
- [ ] 9.2 Create spec/models/message_spec.rb with model validations and associations tests
- [ ] 9.3 Create spec/services/chat_service_spec.rb with business logic tests
- [ ] 9.4 Create spec/lib/llm_service_spec.rb with RubyLLM integration tests (mock API calls)
- [ ] 9.5 Create spec/lib/chat_interface_spec.rb with terminal interface tests
- [ ] 9.6 Create spec/routes/chat_spec.rb with route handler tests
- [ ] 9.7 Run bundle exec rspec to verify all tests pass

## 10. Documentation

- [ ] 10.1 Create README.md with project overview
- [ ] 10.2 Document installation instructions (bundle install)
- [ ] 10.3 Document configuration (ZAI_API_KEY in .env)
- [ ] 10.4 Document usage (running bin/chat)
- [ ] 10.5 Document command history features (arrow keys)
- [ ] 10.6 Add example .env file with comments
- [ ] 10.7 Document database schema and models
- [ ] 10.8 Document testing approach (bundle exec rspec)

## 11. Lint and Quality

- [ ] 11.1 Run bundle exec rubocop to check code style
- [ ] 11.2 Fix any Rubocop issues
- [ ] 11.3 Ensure code follows Ruby 3.3+ syntax conventions
- [ ] 11.4 Verify all files use proper naming conventions
- [ ] 11.5 Ensure proper require order in all files

## 12. Final Verification

- [ ] 12.1 Test chatbot end-to-end: send message, receive response, check history
- [ ] 12.2 Verify command history: send multiple messages, navigate with arrow keys
- [ ] 12.3 Verify session persistence: check database for saved messages
- [ ] 12.4 Test error handling: run without ZAI_API_KEY, verify error message
- [ ] 12.5 Test API error handling: mock API failures, verify error messages
- [ ] 12.6 Run all tests: bundle exec rspec, verify 100% pass
- [ ] 12.7 Run linter: bundle exec rubocop, verify no issues
