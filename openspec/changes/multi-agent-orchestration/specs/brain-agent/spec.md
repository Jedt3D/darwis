## ADDED Requirements

### Requirement: Brain agent monitors OpenSpec changes
The system SHALL monitor OpenSpec changes and determine routing to specialized agents.

#### Scenario: Detect new change
- **WHEN** a new OpenSpec change is created
- **THEN** Brain agent analyzes change location and specs
- **AND** Brain agent determines appropriate specialized agent

#### Scenario: Route to Darwis server agent
- **WHEN** change is in darwis/ directory and contains chat-api specs
- **THEN** Brain agent routes to Darwis server agent
- **AND** Brain agent activates `darwis-server-agent` skill

#### Scenario: Route to Darwis-chat agent
- **WHEN** change is in darwis-chat/ directory and contains CLI specs
- **THEN** Brain agent routes to Darwis-chat agent
- **AND** Brain agent activates `darwis-chat-agent` skill

#### Scenario: Route to Z.ai SDK agent
- **WHEN** change is in z-ai-sdk-ruby directory or reports SDK bug
- **THEN** Brain agent routes to Z.ai SDK agent
- **AND** Brain agent activates `zai-sdk-maintenance` skill

### Requirement: Brain agent tracks agent states
The system SHALL maintain state for all agents including status, progress, dependencies.

#### Scenario: Update agent status
- **WHEN** agent starts working on a change
- **THEN** Brain agent updates status to "in-progress"
- **AND** Brain agent records progress percentage

#### Scenario: Mark agent completion
- **WHEN** agent completes a change
- **THEN** Brain agent updates status to "completed"
- **AND** Brain agent triggers documentation sync

#### Scenario: Track blocking issues
- **WHEN** agent encounters blocking issue
- **THEN** Brain agent records blocking issue
- **AND** Brain agent prevents dependent agents from starting

### Requirement: Brain agent updates documentation
The system SHALL update AGENTS.md and SESSION.md after each agent completion.

#### Scenario: Update AGENTS.md on server agent completion
- **WHEN** Darwis server agent completes a change
- **THEN** Brain agent updates AGENTS.md with new architecture details
- **AND** Brain agent verifies changes are accurate

#### Scenario: Update SESSION.md on chat agent completion
- **WHEN** Darwis-chat agent completes a change
- **THEN** Brain agent updates SESSION.md with workflow changes
- **AND** Brain agent commits documentation changes
