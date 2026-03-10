## ADDED Requirements

### Requirement: POST /api/chat/send endpoint
The system SHALL provide endpoint for sending chat messages and receiving AI responses.

#### Scenario: Send message in existing session
- **WHEN** client POSTs to /api/chat/send with session_id and content
- **THEN** system saves user message to database
- **AND** system retrieves session conversation context
- **AND** system sends to Z.ai SDK
- **AND** system saves AI response to database
- **AND** system returns 200 status with AI message object

#### Scenario: Send message without session_id
- **WHEN** client POSTs to /api/chat/send with only content
- **THEN** system creates new session with default name
- **AND** system processes message in new session
- **AND** system returns 200 status with AI message object

#### Scenario: Invalid request data
- **WHEN** client POSTs to /api/chat/send without content
- **THEN** system returns 400 status
- **AND** response contains JSON error {"error": "content is required", "code": "INVALID_INPUT"}

### Requirement: POST /api/sessions endpoint
The system SHALL provide endpoint for creating new chat sessions.

#### Scenario: Create session with name
- **WHEN** client POSTs to /api/sessions with {"name": "My Chat"}
- **THEN** system creates session with provided name
- **AND** system returns 201 status with session object

#### Scenario: Create session without name
- **WHEN** client POSTs to /api/sessions with {}
- **THEN** system creates session with default name "Chat <timestamp>"
- **AND** system returns 201 status with session object

### Requirement: GET /api/sessions endpoint
The system SHALL provide endpoint for listing all sessions.

#### Scenario: List all sessions
- **WHEN** client GETs /api/sessions
- **THEN** system returns 200 status
- **AND** response contains array of session objects ordered by created_at DESC

### Requirement: GET /api/sessions/:id endpoint
The system SHALL provide endpoint for retrieving session with messages.

#### Scenario: Retrieve existing session
- **WHEN** client GETs /api/sessions/:id with valid session_id
- **THEN** system returns 200 status
- **AND** response contains session object with messages array
- **AND** messages are ordered by created_at ASC

#### Scenario: Retrieve non-existent session
- **WHEN** client GETs /api/sessions/:id with invalid session_id
- **THEN** system returns 404 status
- **AND** response contains {"error": "Session not found", "code": "NOT_FOUND"}

### Requirement: DELETE /api/sessions/:id endpoint
The system SHALL provide endpoint for deleting sessions.

#### Scenario: Delete existing session
- **WHEN** client DELETEs /api/sessions/:id with valid session_id
- **THEN** system deletes session and all associated messages
- **AND** system returns 200 status with {"success": true}

### Requirement: GET /api/sessions/:id/messages endpoint
The system SHALL provide endpoint for retrieving messages from session.

#### Scenario: Retrieve session messages
- **WHEN** client GETs /api/sessions/:id/messages
- **THEN** system returns 200 status
- **AND** response contains array of messages ordered by created_at ASC
