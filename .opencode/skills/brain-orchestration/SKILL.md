# Brain Agent (Orchestrator)

## Trigger Conditions
This skill activates when:
- OpenSpec change is created
- Agent completion is reported
- Token monitoring triggers checkpoint
- User explicitly invokes: "Use brain agent"

## Responsibilities

### Monitoring
- Monitor OpenSpec changes in all project directories
- Track agent states and progress
- Monitor token usage (estimated per task completion) and trigger checkpoints

### Routing
- Analyze change location and specs
- Route changes to appropriate specialized agents:
  - darwis/ + chat-api specs → Darwis Server Agent (GLM-5.0 Coding Plan)
  - darwis-chat/ + CLI specs → Darwis-Chat Agent (GLM-4.7 Coding Plan)
  - z-ai-sdk-ruby/ + bug report → Z.ai SDK Agent (GLM-5.0 Coding Plan)
- Activate corresponding skill files
- Skills are instructions that agents can adapt to (not strict rules)

### Coordination
- Coordinate agent handoffs
- Manage dependencies between agents
- Handle blocking issues

### Documentation
- Update AGENTS.md after EACH agent completion
- Update SESSION.md with workflow changes
- Create and manage skill files

## Dependencies
- OpenSpec system
- All specialized agent skills
- Token monitoring system

## Handoff Protocols

### To Darwis Server Agent
- Route server-related OpenSpec changes
- Provide context: current agent states, dependencies
- On completion: Receive notification, update state, route next steps
- Update AGENTS.md and SESSION.md after completion

### To Darwis-Chat Agent
- Route client-related OpenSpec changes
- Provide context: server API documentation location
- On completion: Receive notification, update state
- Update AGENTS.md and SESSION.md after completion

### To Z.ai SDK Agent
- Route SDK bug fixes and enhancements
- Provide context: bug report or feature request
- On completion: Receive notification, inform dependent agents
- Update AGENTS.md and SESSION.md after completion

## Model
- **Model:** GLM-4.7 Coding Plan
- **Primary Focus:** Coordination and orchestration
- **Token Budget:** 200,000 tokens per session, checkpoint at ~175,000
