## Why

Implement a multi-agent orchestration system for Darwis chatbot project to enable coordinated development across server (Darwis), client (Darwis-Chat), and SDK (Z.ai Ruby SDK) components. This system will use OpenSpec as a task queue and coordination layer, with a Brain agent orchestrating task routing between specialized agents.

## What Changes

- Archive existing `chatbot-with-history` change to `archive/`
- Create `.opencode/skills/` directory structure
- Implement Brain agent as orchestrator (GLM-4.7 Coding Plan)
- Create skill definitions for all agents
- Implement agent routing logic based on change location and specs
- Set up agent communication protocols and handoffs
- Create state management system for tracking agent progress
- Update AGENTS.md with multi-agent architecture documentation
- Update SESSION.md with agent workflow

## Capabilities

### New Capabilities

- `brain-agent`: Central orchestrator that monitors changes and routes tasks to specialized agents
- `agent-routing`: Automatic routing of OpenSpec changes to appropriate agents based on change scope
- `skill-management`: Creation and management of `.opencode/skills/` for agent behavior definitions
- `agent-communication`: Handoff protocols and notification system between agents
- `state-management`: Tracking agent states, progress, dependencies, and blocking issues
- `documentation-sync`: Automatic updates to AGENTS.md and SESSION.md on agent completion
- `token-monitoring`: Track token usage and implement session checkpoint mechanism

### Modified Capabilities

None - this is a foundational orchestration system

## Impact

- New directory: `.opencode/skills/` with skill definitions
- New Brain agent logic for orchestration
- Updated AGENTS.md and SESSION.md with multi-agent documentation
- Token monitoring system for session management
- No breaking changes to existing code
