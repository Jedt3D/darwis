## Context

The Darwis project involves three main components: Darwis server (Roda + Z.ai SDK), Darwis-Chat client (CLI with TTY), and Z.ai Ruby SDK (external dependency). Current development lacks coordination between these components. This change introduces a Brain agent (using GLM-4.7 Coding Plan) to orchestrate development using OpenSpec as a task queue and coordination layer.

## Goals / Non-Goals

**Goals:**
- Implement Brain agent as central orchestrator
- Create skill-based agent activation system
- Establish routing logic for OpenSpec changes
- Set up agent communication and handoff protocols
- Track agent states and progress
- Implement token monitoring for session management
- Update documentation automatically
- Enable cooperative multi-agent development

**Non-Goals:**
- Implement actual agents (server, chat, SDK) in this phase
- Create automated test runners
- Build real-time monitoring dashboards
- Implement complex dependency resolution (manual handoffs initially)

## Decisions

**Brain Agent as Orchestrator**
- Brain agent (GLM-4.7 Coding Plan) monitors all changes
- Routes tasks to specialized agents based on change location and specs
- Maintains state and coordinates handoffs
- Alternative: Distributed coordination system. Rejected due to complexity for MVP.

**OpenSpec as Task Queue**
- OpenSpec changes serve as task units
- Each change has artifacts (proposal, design, specs, tasks)
- Agents execute tasks via `/opsx-apply`
- Status tracked by OpenSpec
- Alternative: Custom task queue. Rejected due to reinventing the wheel.

**Skill-Based Agent Activation**
- Each agent has `.opencode/skills/<agent-name>/SKILL.md`
- Skills define trigger conditions and responsibilities
- Brain agent loads and activates appropriate skills
- Skills are "instructions" that agents can adapt to (not strict rules)
- Alternative: Hard-coded routing logic. Rejected for flexibility.

**State Management with YAML**
- Brain agent maintains state in `.opencode/brain-state.yaml`
- Tracks: agent status, progress, dependencies, blocking issues
- Updated on agent completion
- Alternative: Database. Rejected due to complexity for single-session workflow.

**Token Monitoring**
- Track total tokens used in current session (estimated based on task completion)
- When ~175,000 tokens reached: save session, commit code, close OpenCode
- User resumes session by loading `.opencode/brain-state.yaml`
- Continue from next task
- Alternative: Ignore token limits. Rejected due to session constraints.

**Documentation Sync**
- Brain agent updates AGENTS.md and SESSION.md after EACH agent completion
- Ensures documentation reflects current state
- Alternative: Manual updates. Rejected for automation.

**Agent Handoff Protocols**
- Specialized agents report completion to Brain agent
- Brain agent evaluates next steps and routes appropriately
- Blocking issues prevent dependent agents from starting
- Alternative: Direct agent-to-agent communication. Rejected for centralization.

**Model Assignments**
- Brain agent: GLM-4.7 Coding Plan (orchestration, coordination)
- Darwis Server agent: GLM-5.0 Coding Plan (server, API, database)
- Darwis-Chat agent: GLM-4.7 Coding Plan (CLI, TUI, HTTP client)
- Z.ai SDK agent: GLM-5.0 Coding Plan (SDK maintenance, bug fixes)

## Risks / Trade-offs

[Token Limit Reached During Implementation] → Save partial progress, commit with "checkpoint" message, document next steps in SESSION.md, resume in new session by loading `.opencode/brain-state.yaml`

[Agent Routing Conflicts] → Brain agent logs conflicts, requests manual resolution, updates routing rules based on user feedback

[Skill Definition Complexity] → Start with simple trigger conditions, evolve skills iteratively based on usage patterns

[State Management Errors] → Brain agent validates YAML before saving, maintains backup of previous state

[Documentation Inconsistency] → Brain agent reviews updates before committing, verifies AGENTS.md and SESSION.md are consistent

[Token Estimation Inaccuracy] → Rough approximation based on task completion; checkpoint may trigger earlier or later than exact limit; acceptable trade-off for simplicity

## Migration Plan

1. Archive existing `chatbot-with-history` change
2. Create `.opencode/skills/` directory structure
3. Create skill files for all agents:
   - `brain-orchestration/SKILL.md`
   - `darwis-server-agent/SKILL.md`
   - `darwis-chat-agent/SKILL.md`
   - `zai-sdk-maintenance/SKILL.md`
4. Implement Brain agent routing logic
5. Create state management system (`.opencode/brain-state.yaml`)
6. Implement token monitoring (estimated based on task completion)
7. Update AGENTS.md with multi-agent architecture
8. Update SESSION.md with agent workflow
9. Test agent routing and handoffs
10. Document usage and protocols

**Rollback Strategy:**
- Remove `.opencode/skills/` directory if needed
- Revert AGENTS.md and SESSION.md changes
- Archive multi-agent-orchestration change if critical issues arise
- No changes to existing code (server, client, SDK), so rollback is safe

## Open Questions

- None at this time; architecture is well-defined for MVP
