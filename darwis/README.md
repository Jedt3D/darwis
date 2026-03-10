# Darwis API

A Ruby Roda-based API server for the Darwis chatbot application with Z.ai SDK integration.

## Environment Variables

Create a `.env` file in the project root:

```bash
# Required: Z.ai API key for AI chat functionality
ZAI_API_KEY=your_api_key_here

# Optional: Z.ai API base URL (default: https://api.z.ai/api/paas/v4/)
ZAI_BASE_URL=https://api.z.ai/api/paas/v4/

# Optional: API timeout in seconds (default: 30)
ZAI_TIMEOUT=30
```

See `.env.example` for a template.

## Database Setup

```bash
# Create and migrate the database
bundle exec rake db:migrate

# Reset the database (drop and recreate)
bundle exec rake db:reset

# Rollback the last migration
bundle exec rake db:rollback
```

## Running the Server

```bash
# Start the server
rackup -p 9292

# The API will be available at http://localhost:9292
```

## API Endpoints

### Health Check

```
GET /api/health
```

Returns server status.

**Response:**
```json
{
  "status": "ok",
  "message": "Darwis API is running"
}
```

### Send Chat Message

```
POST /api/chat/send
```

Send a message to the AI and receive a response.

**Request Body:**
```json
{
  "session_id": 1,
  "content": "Hello, how are you?"
}
```

- `session_id` (optional): ID of an existing session. If not provided, a new session will be created.
- `content` (required): The message content to send to the AI.

**Response:**
```json
{
  "id": 2,
  "session_id": 1,
  "role": "assistant",
  "content": "I'm doing well, thank you!",
  "created_at": "2026-03-10T12:00:00.000Z"
}
```

### Create Session

```
POST /api/sessions
```

Create a new chat session.

**Request Body:**
```json
{
  "name": "My Conversation"
}
```

- `name` (optional): Session name. If not provided, a default name will be generated.

**Response:**
```json
{
  "id": 1,
  "name": "My Conversation",
  "created_at": "2026-03-10T12:00:00.000Z",
  "updated_at": "2026-03-10T12:00:00.000Z"
}
```

### List Sessions

```
GET /api/sessions
```

List all chat sessions, ordered by creation date (newest first).

**Response:**
```json
[
  {
    "id": 2,
    "name": "Recent Chat",
    "created_at": "2026-03-10T13:00:00.000Z",
    "updated_at": "2026-03-10T13:00:00.000Z"
  },
  {
    "id": 1,
    "name": "Old Chat",
    "created_at": "2026-03-10T12:00:00.000Z",
    "updated_at": "2026-03-10T12:00:00.000Z"
  }
]
```

### Get Session

```
GET /api/sessions/:id
```

Get a session with all its messages.

**Response:**
```json
{
  "id": 1,
  "name": "My Conversation",
  "created_at": "2026-03-10T12:00:00.000Z",
  "updated_at": "2026-03-10T12:00:00.000Z",
  "messages": [
    {
      "id": 1,
      "role": "user",
      "content": "Hello",
      "created_at": "2026-03-10T12:00:00.000Z"
    },
    {
      "id": 2,
      "role": "assistant",
      "content": "Hi there!",
      "created_at": "2026-03-10T12:00:10.000Z"
    }
  ]
}
```

### Delete Session

```
DELETE /api/sessions/:id
```

Delete a session and all its messages.

**Response:**
```json
{
  "success": true
}
```

### Get Session Messages

```
GET /api/sessions/:id/messages
```

Get all messages for a specific session, ordered chronologically.

**Response:**
```json
[
  {
    "id": 1,
    "session_id": 1,
    "role": "user",
    "content": "Hello",
    "created_at": "2026-03-10T12:00:00.000Z"
  },
  {
    "id": 2,
    "session_id": 1,
    "role": "assistant",
    "content": "Hi there!",
    "created_at": "2026-03-10T12:00:10.000Z"
  }
]
```

## Error Responses

All errors follow this format:

```json
{
  "error": "Error message",
  "code": "ERROR_CODE"
}
```

### Error Codes

- `INVALID_INPUT` (400): Invalid request parameters
- `NOT_FOUND` (404): Resource not found
- `AI_AUTH_ERROR` (500): AI API authentication failed
- `AI_RATE_LIMIT` (500): AI API rate limit exceeded
- `AI_CONNECTION_ERROR` (500): AI API connection error
- `INTERNAL_ERROR` (500): Internal server error

## Database Schema

### Sessions Table

| Column | Type | Constraints |
|--------|------|-------------|
| id | INTEGER | PRIMARY KEY |
| name | STRING | NOT NULL |
| created_at | DATETIME | NOT NULL |
| updated_at | DATETIME | NOT NULL |

### Messages Table

| Column | Type | Constraints |
|--------|------|-------------|
| id | INTEGER | PRIMARY KEY |
| session_id | INTEGER | NOT NULL, FOREIGN KEY (sessions) |
| role | STRING | NOT NULL, CHECK (IN ('user', 'assistant')) |
| content | TEXT | NOT NULL |
| created_at | DATETIME | NOT NULL |
| updated_at | DATETIME | NOT NULL |

## Testing

```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/session_spec.rb

# Run with verbose output
bundle exec rspec --format documentation

# Run with coverage
bundle exec rspec --format documentation
```

## Linting

```bash
# Check code style
bundle exec rubocop

# Auto-fix issues
bundle exec rubocop --auto-correct
```

## Development

```bash
# Install dependencies
bundle install

# Run tests
bundle exec rake

# Start development server with auto-reload
rerun rackup -p 9292
```

## Docker

```bash
# Build the image
docker build -t darwis .

# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f
```
