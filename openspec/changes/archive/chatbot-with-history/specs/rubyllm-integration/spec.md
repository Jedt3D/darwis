## ADDED Requirements

### Requirement: Initialize RubyLLM with ZAI provider
The system SHALL initialize RubyLLM using the ZAI provider with API key from environment.

#### Scenario: Initialize RubyLLM client
- **WHEN** application starts
- **THEN** system reads ZAI_API_KEY from environment
- **AND** system initializes RubyLLM client with ZAI provider configuration

#### Scenario: Missing API key error
- **WHEN** ZAI_API_KEY environment variable is not set
- **THEN** system displays an error message
- **AND** system exits gracefully

### Requirement: Send messages to LLM
The system SHALL send user messages to the LLM via RubyLLM.

#### Scenario: Send user message
- **WHEN** user submits a message
- **THEN** system sends the message to RubyLLM with appropriate context
- **AND** system awaits the LLM response

### Requirement: Handle LLM responses
The system SHALL process and display LLM responses returned by RubyLLM.

#### Scenario: Receive LLM response
- **WHEN** RubyLLM returns a response from the LLM
- **THEN** system extracts the text content
- **AND** system displays the response to the user

### Requirement: Handle API errors
The system SHALL handle errors returned by the ZAI API.

#### Scenario: API authentication failure
- **WHEN** ZAI API returns authentication error
- **THEN** system displays an error message indicating invalid API key
- **AND** system continues to accept new messages

#### Scenario: API rate limit exceeded
- **WHEN** ZAI API returns rate limit error
- **THEN** system displays rate limit error message
- **AND** system waits or prompts user to retry

#### Scenario: API connectivity failure
- **WHEN** ZAI API is unreachable
- **THEN** system displays connectivity error message
- **AND** system continues to accept new messages for later retry

### Requirement: Maintain conversation context
The system SHALL maintain conversation context across multiple message exchanges.

#### Scenario: Context persistence
- **WHEN** user sends multiple messages in sequence
- **THEN** system includes previous conversation history with each API request
- **AND** LLM responds with awareness of previous messages

### Requirement: Configure LLM parameters
The system SHALL allow configuration of LLM parameters (model, temperature, etc.).

#### Scenario: Default parameters
- **WHEN** sending messages to LLM
- **THEN** system uses default model and temperature settings
- **AND** settings can be configured via environment variables or configuration file
