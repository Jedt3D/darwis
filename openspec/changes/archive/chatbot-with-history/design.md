## Context

The darwis project currently contains a Roda web application with SQLite database, Docker containerization, and RSpec testing. This change introduces a new standalone chatbot application in a separate `darwis-chat/` directory that will not use Docker but will share the same Ruby/Roda/ActiveRecord stack. The application needs to provide a terminal-based interface for interacting with an LLM via RubyLLM's ZAI provider.

## Goals / Non-Goals

**Goals:**
- Create standalone terminal-based chat interface with message exchange
- Implement command history navigation using arrow keys
- Integrate RubyLLM with ZAI provider for AI responses
- Persist chat sessions and messages to SQLite database
- Support environment-based API key configuration
- Maintain code consistency with existing darwis project patterns

**Non-Goals:**
- Web-based chat interface
- Docker containerization for chatbot
- User authentication or authorization
- Multi-user session management
- Export or sharing of chat sessions
- Streaming responses (initial implementation will be request/response)

## Decisions

**Use RubyLLM for AI Integration**
- RubyLLM provides a unified Ruby interface for multiple LLM providers
- Supports ZAI provider which is already configured in the environment
- Alternative: Direct API calls to ZAI endpoint. Rejected due to complexity and lack of unified interface.

**Use Readline Library for Command History**
- Standard Ruby library with built-in line editing and history
- Provides up/down arrow navigation automatically
- Alternative: Curses library. Rejected due to higher complexity and overkill for simple chat interface.

**Standalone Directory Structure (darwis-chat/)**
- Separates chatbot concerns from existing web app
- Allows independent Gemfile and dependencies
- Shares common patterns from darwis project (RSpec, Rubocop, ActiveRecord)
- Alternative: Integrate into existing app. Rejected to avoid污染 of web application with terminal-specific concerns.

**ActiveRecord for Database**
- Consistent with existing darwis project stack
- Simple migration system
- Alternative: Sequel. Rejected for consistency with existing codebase.

**Simple Request/Response Model**
- Send user message, wait for complete AI response
- Alternative: Streaming responses. Rejected for initial simplicity; can be added later if needed.

**Database Schema Design**
- Sessions table: id, name, created_at, updated_at
- Messages table: id, session_id, role (user/assistant), content, created_at
- Foreign key relationship from messages to sessions
- Index on session_id for query performance

## Risks / Trade-offs

[API Key Exposure in Environment] → Document security best practices in README, add .env to .gitignore

[Terminal Input Buffer Issues with Readline] → Use Readline's built-in history management with configurable size limit

[RubyLLM ZAI Provider Compatibility] → Add initial integration test to verify API connectivity, document version requirements

[No Streaming Responses] → Users may experience latency with long responses. Mitigation: Add loading indicator or async processing in future iteration

[Standalone App Code Duplication] → Some configuration and setup code will duplicate darwis project patterns. Trade-off for separation of concerns is acceptable.

## Migration Plan

1. Create darwis-chat/ directory structure
2. Set up Gemfile with RubyLLM and required dependencies
3. Create database migrations for sessions and messages tables
4. Implement models with ActiveRecord validations
5. Create Roda app with chat routes
6. Implement terminal interface using Readline
7. Add RSpec tests for models and routes
8. Create configuration for ZAI_API_KEY from environment
9. Test end-to-end chat flow
10. Document usage in README

**Rollback Strategy:**
- Remove darwis-chat/ directory if needed
- No changes to existing darwis codebase, so rollback is safe

## Open Questions

- What should be the default session name format? (e.g., "Chat <timestamp>", "Untitled Session")
- Maximum message history size limit to prevent database bloat?
- Should commands like `/clear` or `/new` be supported for session management?
- How to handle API errors or rate limiting from ZAI provider?
