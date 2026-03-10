## ADDED Requirements

### Requirement: Return JSON error responses
The system SHALL return all API errors in JSON format.

#### Scenario: JSON error format
- **WHEN** system returns error response
- **THEN** response Content-Type is application/json
- **AND** response body contains {"error": "message", "code": "ERROR_CODE"}

### Requirement: Use HTTP status codes appropriately
The system SHALL use appropriate HTTP status codes for errors.

#### Scenario: Bad request (400)
- **WHEN** client sends invalid request data
- **THEN** system returns 400 status
- **AND** response indicates validation error

#### Scenario: Not found (404)
- **WHEN** resource does not exist
- **THEN** system returns 404 status
- **AND** response indicates resource not found

#### Scenario: Internal server error (500)
- **WHEN** unexpected error occurs
- **THEN** system returns 500 status
- **AND** response indicates server error

### Requirement: Handle Z.ai SDK errors
The system SHALL convert Z.ai SDK errors to API error responses.

#### Scenario: Z.ai authentication error
- **WHEN** Z::AI::APIAuthenticationError is raised
- **THEN** system logs error details
- **AND** system returns 500 status with error message

#### Scenario: Z.ai rate limit error
- **WHEN** Z::AI::APIRateLimitError is raised
- **THEN** system logs error details
- **AND** system returns 500 status with rate limit message

#### Scenario: Z.ai connectivity error
- **WHEN** Z::AI::APIStatusError is raised
- **THEN** system logs error details
- **AND** system returns 500 status with connectivity message

### Requirement: Log errors without exposing stack traces
The system SHALL log errors without exposing stack traces in production.

#### Scenario: Error logging
- **WHEN** API error occurs
- **THEN** system logs error message
- **AND** system does not include stack trace in API response
- **AND** system does not expose internal implementation details
