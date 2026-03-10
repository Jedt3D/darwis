## Context

The Darwis server application is currently a basic Roda application with SQLite database and RSpec testing. This change introduces RESTful API endpoints for chatbot functionality, Z.ai SDK integration for AI responses, and database persistence for chat sessions and messages. The server will be used by the Darwis-Chat client (to be developed in Phase 3).

## Goals / Non-Goals

**Goals:**
- Integrate Z.ai Ruby SDK from local path for AI responses
- Create database schema for chat sessions and messages
- Implement RESTful API endpoints for chat operations
- Add business logic layer (ChatService) for orchestrating chat operations
- Implement proper error handling with HTTP status codes
- Generate API documentation for client developers
- Ensure >80% test coverage with RSpec
- Support environment configuration (ZAI_API_KEY, DATABASE_URL, PORT)

**Non-Goals:**
- Web-based chat interface (will be provided by Darwis-Chat client)
- User authentication or authorization (trusted client only)
- Multi-user session management (global sessions for now)
- Streaming responses (initial implementation will be request/response)
- Real-time monitoring dashboards

## Decisions

**Z.ai SDK Integration from Local Path**
- Source: `/home/worajedt/RubymineProjects/z-ai-sdk-ruby`
- Method: Add to Gemfile with `gem 'zai-ruby-sdk', path: '../z-ai-sdk-ruby'`
- Alternative: Install from RubyGems. Rejected to avoid version mismatches and use local development version.

**RESTful API Design**
- Base path: `/api/`
- Authentication: Trusted only (no tokens in MVP)
- Content-Type: `application/json`
- Error format: `{"error": "message", "code": "ERROR_CODE"}`
- Alternative: GraphQL. Rejected for simplicity and quick implementation.

**Database Schema with ActiveRecord**
- Use existing SQLite3 database in `darwis/db/`
- Migrations in `darwis/db/migrate/`
- Cascade delete: Delete messages when session is deleted
- Index on messages.session_id for query performance
- Alternative: NoSQL database. Rejected for simplicity and Alpine compatibility.

**Service Layer Architecture**
- ChatService encapsulates business logic
- Models handle database operations
- Routes delegate to ChatService
- Routes remain thin (delegate to services)
- Alternative: Business logic in routes. Rejected for testability and separation of concerns.

**Error Handling with HTTP Status Codes**
- 400 Bad Request: Invalid input, missing required fields
- 404 Not Found: Session/message not found
- 500 Internal Server Error: Unexpected errors, Z.ai API failures
- All errors return JSON with `error` and `code` fields
- Alternative: Custom error codes only. Rejected for HTTP standards compliance.

**Conversation Context Management**
- When user sends message: Retrieve all messages from session
- Build message array for Z.ai SDK: `[{role: 'user', content: ...}, ...]`
- Include both user and assistant messages for context
- Send to Z.ai, receive response, save both to database
- Alternative: No context (stateless). Rejected for conversational AI experience.

**API Documentation**
- Use inline documentation in route handlers
- Generate OpenAPI/Swagger spec (optional, for Phase 3)
- Include example requests/responses in documentation
- Alternative: External documentation tool. Rejected for simplicity in MVP.

**Environment Configuration**
- ZAI_API_KEY: Required for Z.ai SDK
- DATABASE_URL: SQLite database path (default: `sqlite:///db/development.sqlite3`)
- PORT: Server port (default: 9292)
- Alternative: Configuration files. Rejected for 12-factor app compliance.

## Risks / Trade-offs

[Z.ai SDK Integration Errors] → Add error handling for SDK initialization failures, provide clear error messages, log SDK version for debugging

[Database Migration Failures] → Use reversible migration methods, test migrations in isolation, provide rollback strategy via `rake db:rollback`

[API Rate Limiting from Z.ai] → Implement retry logic with exponential backoff, log rate limit errors, provide user-facing error messages

[Conversation Context Size] → Monitor message history size, implement truncation if exceeds limits, document context size limits in API docs

[No Streaming Responses] → Users may experience latency with long responses. Mitigation: Add loading indicator in client (Phase 3), implement streaming in future iteration

[Trusted Client Only] → No authentication for MVP. Document security implications, add authentication in future phase if needed

[SQLite Performance] → Use indexes on foreign keys, optimize queries with includes, monitor query performance, consider PostgreSQL for production if needed

## Migration Plan

1. Update darwis/Gemfile with Z.ai SDK dependency
2. Run `bundle install` in darwis/ directory
3. Create database migrations in `darwis/db/migrate/`
4. Run `rake db:migrate` to create tables
5. Create models in `darwis/app/models/`
6. Create ChatService in `darwis/app/services/`
7. Add API routes in `darwis/app/routes/`
8. Update darwis/app/app.rb to mount routes
9. Add configuration initializer for Z.ai SDK
10. Update .env.example with ZAI_API_KEY
11. Write RSpec tests for models, services, routes
12. Run `bundle exec rspec` to verify tests pass
13. Run `bundle exec rubocop` to check style
14. Generate API documentation
15. Test server with curl or Postman

**Rollback Strategy:**
- Remove database migrations via `rake db:rollback`
- Delete new models, services, routes if critical issues
- Revert Gemfile changes
- No changes to existing darwis code (root route, health endpoint), so rollback is safe

## Open Questions

- Should there be a maximum message history size limit per session?
- Should we implement session expiration (TTL)?
- What should be the default session name format (e.g., "Chat <timestamp>", "Untitled Session")?
