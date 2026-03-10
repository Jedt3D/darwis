## ADDED Requirements

### Requirement: Track token usage
The system SHALL monitor total tokens used in current session (estimated based on task completion).

#### Scenario: Track tokens per task completion
- **WHEN** agent completes a major task
- **THEN** system estimates token usage for that task
- **AND** system adds estimated amount to session total

#### Scenario: Monitor token limit
- **WHEN** session reaches ~175,000 tokens (estimated)
- **THEN** system triggers checkpoint process
- **AND** system saves session state

### Requirement: Checkpoint and resume
The system SHALL save session state and commit code when token limit is approached.

#### Scenario: Save session checkpoint
- **WHEN** token count reaches ~175,000 (estimated)
- **THEN** system saves all work in progress
- **AND** system commits code with "checkpoint" message
- **AND** system documents next steps in SESSION.md
- **AND** system closes OpenCode session

#### Scenario: Resume from checkpoint
- **WHEN** user starts new session
- **THEN** system reads `.opencode/brain-state.yaml`
- **AND** system loads previous checkpoint state
- **AND** system continues from next task (auto-resume)

### Requirement: Token usage reporting
The system SHALL report current token usage to user.

#### Scenario: Display token count
- **WHEN** agent completes a major task
- **THEN** system displays current estimated token usage
- **AND** system displays remaining tokens before checkpoint

#### Scenario: Warning before checkpoint
- **WHEN** token usage approaches limit
- **THEN** system displays warning message
- **AND** system indicates checkpoint will occur soon
