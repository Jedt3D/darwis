## ADDED Requirements

### Requirement: Create chat sessions
The system SHALL create new chat sessions that can contain multiple messages.

#### Scenario: Create new session
- **WHEN** application starts
- **THEN** system creates a new session in the database
- **AND** session has a unique identifier and timestamp

#### Scenario: Session name generation
- **WHEN** creating a new session
- **THEN** system assigns a default name (e.g., "Chat <timestamp>")
- **AND** session name can be customized

### Requirement: Store messages in sessions
The system SHALL store each user message and AI response in the associated session.

#### Scenario: Store user message
- **WHEN** user sends a message
- **THEN** system stores the message with role "user" in the database
- **AND** message is associated with the current session

#### Scenario: Store AI response
- **WHEN** LLM returns a response
- **THEN** system stores the response with role "assistant" in the database
- **AND** response is associated with the current session

#### Scenario: Message timestamp
- **WHEN** a message is stored
- **THEN** system records the timestamp of when the message was created

### Requirement: Retrieve session history
The system SHALL retrieve and display message history from a session.

#### Scenario: Load existing session
- **WHEN** user requests to view session history
- **THEN** system retrieves all messages for that session
- **AND** system displays messages in chronological order

### Requirement: Database schema for sessions
The system SHALL maintain a sessions table with appropriate schema.

#### Scenario: Sessions table structure
- **WHEN** sessions table exists
- **THEN** table includes id (primary key), name (string), created_at (timestamp), updated_at (timestamp)
- **AND** id is auto-incrementing

### Requirement: Database schema for messages
The system SHALL maintain a messages table with appropriate schema.

#### Scenario: Messages table structure
- **WHEN** messages table exists
- **THEN** table includes id (primary key), session_id (foreign key), role (string), content (text), created_at (timestamp)
- **AND** session_id references sessions table
- **AND** content supports long text responses

### Requirement: Message role validation
The system SHALL validate that message roles are either "user" or "assistant".

#### Scenario: Valid role
- **WHEN** storing a message with role "user" or "assistant"
- **THEN** system accepts the message

#### Scenario: Invalid role
- **WHEN** attempting to store a message with invalid role
- **THEN** system rejects the message
- **AND** system returns validation error

### Requirement: Foreign key constraints
The system SHALL enforce foreign key constraints on messages table.

#### Scenario: Valid session_id
- **WHEN** storing a message with valid session_id
- **THEN** system accepts the message

#### Scenario: Invalid session_id
- **WHEN** attempting to store a message with non-existent session_id
- **THEN** system rejects the message
- **AND** system returns foreign key constraint error

### Requirement: Index for query performance
The system SHALL maintain appropriate indexes on database tables.

#### Scenario: Session_id index
- **WHEN** querying messages by session_id
- **THEN** system uses index on session_id column for efficient retrieval

### Requirement: Database migration system
The system SHALL support database migrations for schema changes.

#### Scenario: Create initial schema
- **WHEN** running migrations
- **THEN** system creates sessions and messages tables with proper schema
- **AND** system records migration version in schema_migrations table

#### Scenario: Rollback migration
- **WHEN** rolling back a migration
- **THEN** system reverses the schema changes
- **AND** data is not affected if migration is reversible
