## Why

Create a standalone text-based chatbot application that provides a simple terminal-based interface for interacting with an LLM via RubyLLM. This enables quick, interactive conversations with AI without needing a full web interface or Docker containerization.

## What Changes

- Create new standalone Roda application in `darwis-chat/` directory
- Add RubyLLM gem dependency for AI API communication
- Implement terminal-based chat interface with real-time message exchange
- Add command history feature using up/down arrow keys to navigate previous messages
- Configure environment variable support for ZAI_API_KEY authentication
- Create database schema for persisting chat sessions and message history
- Add routes for chat interactions and history retrieval

## Capabilities

### New Capabilities

- `chat-interface`: Terminal-based text chat UI for sending/receiving messages to LLM
- `command-history`: Arrow key navigation to browse and resubmit previous commands
- `rubyllm-integration`: Communication with AI API using RubyLLM with ZAI provider
- `environment-configuration`: Support for ZAI_API_KEY environment variable
- `session-persistence`: Store chat sessions and messages in SQLite database

### Modified Capabilities

None - this is a new standalone application

## Impact

- New dependencies: RubyLLM gem
- New directory: `darwis-chat/` with standalone Roda application
- No changes to existing darwis application code
- New database tables for sessions and messages in `darwis-chat/db/`
- Environment configuration for API key in `.env` file
