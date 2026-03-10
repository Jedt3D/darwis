## ADDED Requirements

### Requirement: Terminal-based chat interface
The system SHALL provide a terminal-based interface for sending and receiving text messages to an LLM.

#### Scenario: Send message and receive response
- **WHEN** user enters a text message at the prompt
- **THEN** system sends the message to the LLM
- **AND** system displays the LLM response to the user

#### Scenario: Display chat prompt
- **WHEN** application starts
- **THEN** system displays a prompt waiting for user input
- **AND** prompt format includes a clear indication of where to type (e.g., "You: ")

#### Scenario: Format AI responses
- **WHEN** LLM returns a response
- **THEN** system displays the response with a clear label (e.g., "AI: ")
- **AND** response is displayed as plain text

### Requirement: Handle empty input
The system SHALL handle empty input gracefully.

#### Scenario: Empty message submission
- **WHEN** user presses Enter without typing any text
- **THEN** system ignores the empty input
- **AND** system displays the prompt again

### Requirement: Support continuous conversation
The system SHALL support multiple message exchanges within a single session.

#### Scenario: Multiple message exchanges
- **WHEN** user sends multiple messages in sequence
- **THEN** system maintains conversation context
- **AND** each exchange includes user message and AI response
