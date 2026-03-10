## ADDED Requirements

### Requirement: Automatic routing based on change location
The system SHALL route OpenSpec changes to specialized agents based on change directory and specs.

#### Scenario: Darwis server routing
- **WHEN** change is in `darwis/openspec/changes/`
- **THEN** system routes to Darwis server agent
- **AND** system activates `darwis-server-agent` skill

#### Scenario: Darwis-chat routing
- **WHEN** change is in `darwis-chat/openspec/changes/`
- **THEN** system routes to Darwis-chat agent
- **AND** system activates `darwis-chat-agent` skill

#### Scenario: Z.ai SDK routing
- **WHEN** change is in `/home/worajedt/RubymineProjects/z-ai-sdk-ruby/openspec/changes/`
- **THEN** system routes to Z.ai SDK agent
- **AND** system activates `zai-sdk-maintenance` skill

#### Scenario: Change outside known locations
- **WHEN** change is not in known agent directories
- **THEN** Brain agent logs routing ambiguity
- **AND** Brain agent requests manual routing from user

### Requirement: Skill-based activation
The system SHALL activate appropriate `.opencode/skills/` based on routing decision.

#### Scenario: Load skill definition
- **WHEN** agent is routed
- **THEN** system loads corresponding `SKILL.md` file
- **AND** system reads trigger conditions and responsibilities

#### Scenario: Activate skill
- **WHEN** skill file is loaded
- **THEN** system activates skill with change context
- **AND** agent executes according to skill instructions (can adapt to context)
