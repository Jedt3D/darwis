## ADDED Requirements

### Requirement: Load ZAI_API_KEY
The system SHALL load Z.ai API key from ZAI_API_KEY environment variable.

#### Scenario: API key present
- **WHEN** ZAI_API_KEY is set in environment
- **THEN** Z.ai SDK initializes with that key
- **AND** application starts successfully

#### Scenario: API key missing
- **WHEN** ZAI_API_KEY is not set
- **THEN** application displays error message
- **AND** application exits with status 1

### Requirement: Load DATABASE_URL
The system SHALL load database connection string from DATABASE_URL environment variable.

#### Scenario: Database URL present
- **WHEN** DATABASE_URL is set
- **THEN** ActiveRecord connects to specified database
- **AND** migrations run successfully

#### Scenario: Database URL missing
- **WHEN** DATABASE_URL is not set
- **THEN** application uses default sqlite:///db/development.sqlite3

### Requirement: Configure server port
The system SHALL allow server port configuration via PORT environment variable.

#### Scenario: PORT set
- **WHEN** PORT is set
- **THEN** server listens on specified port
- **AND** default remains 9292 if not set

### Requirement: Environment variable precedence
The system SHALL prioritize environment variables over default values.

#### Scenario: Environment override
- **WHEN** an environment variable is set
- **THEN** system uses the environment variable value
- **AND** system ignores default or hardcoded values

### Requirement: Update .env.example
The system SHALL update .env.example file with new environment variables.

#### Scenario: .env.example includes all variables
- **WHEN** .env.example is updated
- **THEN** file includes ZAI_API_KEY with placeholder
- **AND** file includes DATABASE_URL with default value
- **AND** file includes PORT with default value
- **AND** file includes comments explaining each variable
