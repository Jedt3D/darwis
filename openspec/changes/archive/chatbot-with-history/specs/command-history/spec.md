## ADDED Requirements

### Requirement: Command history navigation
The system SHALL provide arrow key navigation to browse and resubmit previous commands.

#### Scenario: Navigate to previous command
- **WHEN** user presses the UP arrow key
- **THEN** system displays the previous command in the input line
- **AND** user can edit the command before submission

#### Scenario: Navigate to next command
- **WHEN** user presses the DOWN arrow key
- **THEN** system displays the next command in the input line
- **AND** after the most recent command, system displays an empty line

#### Scenario: Resubmit command from history
- **WHEN** user navigates to a previous command and presses Enter
- **THEN** system submits that command for processing
- **AND** system processes the command as if it were new input

### Requirement: Maintain command history order
The system SHALL maintain commands in chronological order with most recent at the end.

#### Scenario: History order preservation
- **WHEN** user enters commands A, B, C in sequence
- **THEN** pressing UP arrow shows C first, then B, then A

### Requirement: History persists within session
The system SHALL maintain command history throughout the current chat session.

#### Scenario: Access history after multiple messages
- **WHEN** user has sent multiple messages during a session
- **THEN** user can navigate through all messages sent in that session
- **AND** history includes all messages up to the current point

### Requirement: Limit history size
The system SHALL limit command history to prevent memory issues.

#### Scenario: History size limit
- **WHEN** user enters more commands than the configured history limit
- **THEN** system keeps only the most recent N commands
- **AND** oldest commands are removed first
