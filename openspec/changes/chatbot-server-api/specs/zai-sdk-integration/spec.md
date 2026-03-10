## ADDED Requirements

### Requirement: Initialize Z.ai SDK client
The system SHALL initialize Z.ai SDK client using API key from ZAI_API_KEY environment variable.

#### Scenario: Successful initialization
- **WHEN** application starts and ZAI_API_KEY is set
- **THEN** system configures Z::AI::Client with API key
- **AND** client is available for chat operations

#### Scenario: Missing API key
- **WHEN** application starts without ZAI_API_KEY
- **THEN** system logs error message
- **AND** application exits with non-zero status

### Requirement: Send chat completion request
The system SHALL send chat completion requests to Z.ai API with conversation context.

#### Scenario: Send request with messages
- **WHEN** system sends chat completion request
- **THEN** request includes all messages from session in chronological order
- **AND** request uses model 'glm-5'
- **AND** system awaits response

#### Scenario: Receive AI response
- **WHEN** Z.ai API returns response
- **THEN** system extracts message content from response.choices[0].message.content
- **AND** system returns content to caller

### Requirement: Handle Z.ai SDK errors
The system SHALL handle Z.ai SDK errors gracefully.

#### Scenario: Authentication error
- **WHEN** Z.ai API returns authentication error
- **THEN** system raises or catches Z::AI::APIAuthenticationError
- **AND** error message indicates invalid API key

#### Scenario: Rate limit error
- **WHEN** Z.ai API returns rate limit error
- **THEN** system raises or catches Z::AI::APIRateLimitError
- **AND** error includes retry recommendation

#### Scenario: Connectivity error
- **WHEN** Z.ai API is unreachable
- **THEN** system raises or catches Z::AI::APIStatusError
- **AND** error indicates connectivity failure

### Requirement: Maintain conversation context
The system SHALL maintain conversation context across multiple message exchanges.

#### Scenario: Context persistence
- **WHEN** user sends multiple messages in sequence
- **THEN** system includes previous conversation history with each API request
- **AND** LLM responds with awareness of previous messages

#### Scenario: Context includes assistant messages
- **WHEN** retrieving conversation context
- **THEN** system includes both user and assistant messages
- **AND** messages are ordered chronologically
