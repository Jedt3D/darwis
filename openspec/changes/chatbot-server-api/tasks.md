## 1. Project Setup

- [ ] 1.1 Add Z.ai Ruby SDK to darwis/Gemfile from local path
- [ ] 1.2 Add dotenv gem for environment variable loading
- [ ] 1.3 Run bundle install in darwis/ directory
- [ ] 1.4 Update darwis/.env.example with ZAI_API_KEY placeholder
- [ ] 1.5 Create darwis/.env file with ZAI_API_KEY (for development)

## 2. Database Migrations

- [ ] 2.1 Create migration: darwis/db/migrate/002_create_sessions.rb
- [ ] 2.2 Create migration: darwis/db/migrate/003_create_messages.rb
- [ ] 2.3 Create migration: darwis/db/migrate/004_add_indexes.rb
- [ ] 2.4 Run rake db:migrate in darwis/ directory
- [ ] 2.5 Verify tables created correctly

## 3. Models

- [ ] 3.1 Create darwis/app/models/session.rb ActiveRecord model
- [ ] 3.2 Create darwis/app/models/message.rb ActiveRecord model
- [ ] 3.3 Add Session validations (name presence)
- [ ] 3.4 Add Message validations (session_id, role inclusion, content presence)
- [ ] 3.5 Add Session has_many :messages association
- [ ] 3.6 Add Message belongs_to :session association
- [ ] 3.7 Add dependent: :destroy to Session model
- [ ] 3.8 Add Message role check constraint in migration

## 4. Z.ai SDK Integration

- [ ] 4.1 Create darwis/config/initializers/z_ai.rb
- [ ] 4.2 Configure Z::AI global client with ZAI_API_KEY
- [ ] 4.3 Set default model to 'glm-5'
- [ ] 4.4 Add error handling for missing API key
- [ ] 4.5 Test Z.ai SDK initialization with valid API key
- [ ] 4.6 Test Z.ai SDK initialization with missing API key

## 5. Service Layer

- [ ] 5.1 Create darwis/app/services/chat_service.rb
- [ ] 5.2 Implement ChatService.send_message(session_id, content)
- [ ] 5.3 Implement ChatService.create_session(name)
- [ ] 5.4 Implement ChatService.get_session(id)
- [ ] 5.5 Implement ChatService.delete_session(id)
- [ ] 5.6 Implement ChatService.list_sessions
- [ ] 5.7 Implement ChatService.get_session_messages(id)
- [ ] 5.8 Add conversation context retrieval logic
- [ ] 5.9 Add Z.ai SDK API call logic
- [ ] 5.10 Add error handling for Z.ai SDK failures

## 6. API Routes

- [ ] 6.1 Update darwis/app/app.rb to load dotenv
- [ ] 6.2 Update darwis/app/app.rb to load Z.ai SDK
- [ ] 6.3 Add JSON response plugin
- [ ] 6.4 Add error handler plugin for exceptions
- [ ] 6.5 Create darwis/app/routes/chat.rb
- [ ] 6.6 Create darwis/app/routes/sessions.rb
- [ ] 6.7 Implement POST /api/chat/send route in chat.rb
- [ ] 6.8 Implement POST /api/sessions route in sessions.rb
- [ ] 6.9 Implement GET /api/sessions route in sessions.rb
- [ ] 6.10 Implement GET /api/sessions/:id route in sessions.rb
- [ ] 6.11 Implement DELETE /api/sessions/:id route in sessions.rb
- [ ] 6.12 Implement GET /api/sessions/:id/messages route in sessions.rb
- [ ] 6.13 Update darwis/app/app.rb to mount chat and sessions routes

## 7. Error Handling

- [ ] 7.1 Create custom error classes for API errors
- [ ] 7.2 Add JSON error response helper method
- [ ] 7.3 Add error handler for ValidationError
- [ ] 7.4 Add error handler for NotFoundError
- [ ] 7.5 Add error handler for Z::AI::APIAuthenticationError
- [ ] 7.6 Add error handler for Z::AI::APIRateLimitError
- [ ] 7.7 Add error handler for Z::AI::APIStatusError
- [ ] 7.8 Add generic error handler for unexpected errors

## 8. Testing

- [ ] 8.1 Create darwis/spec/models/session_spec.rb
- [ ] 8.2 Create darwis/spec/models/message_spec.rb
- [ ] 8.3 Create darwis/spec/services/chat_service_spec.rb
- [ ] 8.4 Create darwis/spec/routes/chat_spec.rb
- [ ] 8.5 Create darwis/spec/routes/sessions_spec.rb
- [ ] 8.6 Mock Z.ai SDK in tests
- [ ] 8.7 Add integration tests for API endpoints
- [ ] 8.8 Run bundle exec rspec in darwis/ directory
- [ ] 8.9 Ensure >80% code coverage

## 9. Documentation

- [ ] 9.1 Generate API documentation
- [ ] 9.2 Document environment variables in darwis/README.md
- [ ] 9.3 Document API endpoints with examples
- [ ] 9.4 Document error response formats
- [ ] 9.5 Document database schema
- [ ] 9.6 Update darwis/.env.example with comments

## 10. Final Verification

- [ ] 10.1 Test API endpoints with curl/Postman
- [ ] 10.2 Verify Z.ai SDK integration with real API
- [ ] 10.3 Verify conversation context handling
- [ ] 10.4 Verify error handling for all scenarios
- [ ] 10.5 Run all tests: bundle exec rspec, verify 100% pass
- [ ] 10.6 Run linter: bundle exec rubocop in darwis/ directory
- [ ] 10.7 Fix any rubocop issues
- [ ] 10.8 Start server: rackup -p 9292
- [ ] 10.9 Verify server is running on http://localhost:9292
- [ ] 10.10 Test /api/health endpoint still works
