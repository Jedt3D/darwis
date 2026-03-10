## ADDED Requirements

### Requirement: Session model
The system SHALL provide Session model for managing chat sessions.

#### Scenario: Create session
- **WHEN** system creates Session with name
- **THEN** session saves to database
- **AND** session has id, name, created_at, updated_at

#### Scenario: Session name validation
- **WHEN** system creates Session without name
- **THEN** validation fails
- **AND** error indicates name is required

### Requirement: Message model
The system SHALL provide Message model for storing chat messages.

#### Scenario: Create message
- **WHEN** system creates Message with session_id, role, content
- **THEN** message saves to database
- **AND** message has id, session_id, role, content, created_at

#### Scenario: Message role validation
- **WHEN** system creates Message with role not in ['user', 'assistant']
- **THEN** validation fails
- **AND** error indicates invalid role

#### Scenario: Message content validation
- **WHEN** system creates Message without content
- **THEN** validation fails
- **AND** error indicates content is required

### Requirement: Session-Message association
The system SHALL provide association between Session and Message models.

#### Scenario: Session has many messages
- **WHEN** session has associated messages
- **THEN** session.messages returns array of Message objects
- **AND** messages ordered by created_at ASC

#### Scenario: Message belongs to session
- **WHEN** message has session_id
- **THEN** message.session returns Session object

### Requirement: Cascade delete
The system SHALL delete all messages when session is deleted.

#### Scenario: Delete session cascades to messages
- **WHEN** system deletes session with messages
- **THEN** all associated messages are deleted
- **AND** no orphaned messages remain

### Requirement: Database migrations
The system SHALL provide migrations for creating sessions and messages tables.

#### Scenario: Create sessions table
- **WHEN** migration 002_create_sessions.rb runs
- **THEN** sessions table is created with id, name, created_at, updated_at columns
- **AND** id is auto-incrementing primary key

#### Scenario: Create messages table
- **WHEN** migration 003_create_messages.rb runs
- **THEN** messages table is created with id, session_id, role, content, created_at columns
- **AND** foreign key constraint on session_id references sessions table
- **AND** index on session_id for query performance
- **AND** role check constraint for 'user' and 'assistant' values
