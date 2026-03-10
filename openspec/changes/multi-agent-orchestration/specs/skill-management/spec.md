## ADDED Requirements

### Requirement: Create skill files
The system SHALL create skill definition files for all agents in `.opencode/skills/`.

#### Scenario: Create Brain agent skill
- **WHEN** multi-agent-orchestration is implemented
- **THEN** system creates `.opencode/skills/brain-orchestration/SKILL.md`
- **AND** skill defines Brain agent trigger conditions and responsibilities

#### Scenario: Create Darwis server agent skill
- **WHEN** multi-agent-orchestration is implemented
- **THEN** system creates `.opencode/skills/darwis-server-agent/SKILL.md`
- **AND** skill defines server agent scope and handoff protocols

#### Scenario: Create Darwis-chat agent skill
- **WHEN** multi-agent-orchestration is implemented
- **THEN** system creates `.opencode/skills/darwis-chat-agent/SKILL.md`
- **AND** skill defines chat agent responsibilities and dependencies

#### Scenario: Create Z.ai SDK agent skill
- **WHEN** multi-agent-orchestration is implemented
- **THEN** system creates `.opencode/skills/zai-sdk-maintenance/SKILL.md`
- **AND** skill defines SDK agent scope and communication protocols

### Requirement: Skill activation
The system SHALL activate skills when their trigger conditions are met.

#### Scenario: Activate server agent skill
- **WHEN** change is routed to Darwis server agent
- **THEN** system activates `darwis-server-agent` skill
- **AND** agent executes according to skill instructions

#### Scenario: Activate chat agent skill
- **WHEN** change is routed to Darwis-chat agent
- **THEN** system activates `darwis-chat-agent` skill
- **AND** agent executes according to skill instructions

### Requirement: Skill definition format
The system SHALL use consistent format for all skill files.

#### Scenario: Skill file structure
- **WHEN** skill file is created
- **THEN** file contains: Trigger Conditions, Responsibilities, Dependencies, Handoff Protocols
- **AND** format is consistent across all skills
