## ADDED Requirements

### Requirement: Agent completion notification
The system SHALL notify Brain agent when specialized agents complete their work.

#### Scenario: Darwis server agent completion
- **WHEN** Darwis server agent completes change
- **THEN** agent sends completion notification to Brain agent
- **AND** notification includes: change ID, artifacts created, any blocking issues

#### Scenario: Darwis-chat agent completion
- **WHEN** Darwis-chat agent completes change
- **THEN** agent sends completion notification to Brain agent
- **AND** Brain agent determines next steps

#### Scenario: Z.ai SDK agent completion
- **WHEN** Z.ai SDK agent completes fix
- **THEN** agent sends completion notification with version info
- **AND** Brain agent notifies dependent agents

### Requirement: Agent handoff coordination
The system SHALL coordinate handoffs between agents when dependencies exist.

#### Scenario: Server to client handoff
- **WHEN** Darwis server agent completes API implementation
- **THEN** Brain agent notifies Darwis-chat agent
- **AND** Brain agent includes API documentation location

#### Scenario: SDK bug fix handoff
- **WHEN** Z.ai SDK agent fixes bug
- **THEN** Brain agent notifies Darwis server agent
- **AND** Brain agent includes SDK version information

### Requirement: Blocking issue handling
The system SHALL prevent dependent agents from starting when blocking issues exist.

#### Scenario: Block dependent agent
- **WHEN** agent has blocking issue
- **THEN** Brain agent marks dependent agents as "blocked"
- **AND** dependent agents cannot start until issue resolved

#### Scenario: Unblock dependent agent
- **WHEN** blocking issue is resolved
- **THEN** Brain agent marks dependent agents as "ready"
- **AND** dependent agents can now start
