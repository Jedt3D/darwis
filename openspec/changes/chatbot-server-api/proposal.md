## Why

Create a RESTful API server for the Darwis chatbot using Roda framework and Z.ai Ruby SDK. This server will handle chat sessions, message persistence, and AI interactions, providing a trusted API for CLI clients. The server needs to be running before the Darwis-Chat client can be developed and tested.

## What Changes

- Add Z.ai Ruby SDK dependency from local path: `/home/worajedt/RubymineProjects/z-ai-sdk-ruby`
- Create database schema for chat sessions and messages
- Implement RESTful API endpoints for chat operations
- Add business logic layer for chat operations
- Configure environment variables for API key and database
- Add RSpec tests for all components
- Generate API documentation

## Capabilities

### New Capabilities

- `zai-sdk-integration`: Connect to Z.ai API using Z.ai Ruby SDK from local path
- `chat-api-endpoints`: REST endpoints for sending messages and managing sessions
- `session-persistence`: Database models and migrations for sessions/messages
- `api-error-handling`: Standard HTTP status codes (400, 404, 500) with JSON error responses
- `environment-configuration`: ZAI_API_KEY, DATABASE_URL, PORT configuration

### Modified Capabilities

None - this is a new server implementation for the darwis/ directory

## Impact

- New dependencies: Z.ai Ruby SDK from local path
- New database tables: sessions, messages
- New API routes under /api/chat/* and /api/sessions/*
- No breaking changes to existing darwis application code
- Server will run on port 9292 (configurable via PORT env var)
