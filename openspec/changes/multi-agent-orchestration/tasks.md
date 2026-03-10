## 1. Archive Old Change

- [ ] 1.1 Move `openspec/changes/chatbot-with-history/` to `openspec/changes/archive/chatbot-with-history/`
- [ ] 1.2 Verify directory structure after move

## 2. Create Skill Directory Structure

- [ ] 2.1 Create `.opencode/skills/` directory
- [ ] 2.2 Create `.opencode/skills/brain-orchestration/` directory
- [ ] 2.3 Create `.opencode/skills/darwis-server-agent/` directory
- [ ] 2.4 Create `.opencode/skills/darwis-chat-agent/` directory
- [ ] 2.5 Create `.opencode/skills/zai-sdk-maintenance/` directory

## 3. Create Skill Files

- [ ] 3.1 Create `.opencode/skills/brain-orchestration/SKILL.md`
- [ ] 3.2 Create `.opencode/skills/darwis-server-agent/SKILL.md`
- [ ] 3.3 Create `.opencode/skills/darwis-chat-agent/SKILL.md`
- [ ] 3.4 Create `.opencode/skills/zai-sdk-maintenance/SKILL.md`
- [ ] 3.5 Verify all skill files follow consistent format

## 4. Implement Agent Routing Logic

- [ ] 4.1 Design routing decision tree
- [ ] 4.2 Create routing logic for change location analysis
- [ ] 4.3 Implement routing to Darwis server agent
- [ ] 4.4 Implement routing to Darwis-chat agent
- [ ] 4.5 Implement routing to Z.ai SDK agent
- [ ] 4.6 Add fallback for unknown locations

## 5. Implement State Management

- [ ] 5.1 Create `.opencode/brain-state.yaml` structure
- [ ] 5.2 Define agent state schema (status, progress, dependencies, blocking issues)
- [ ] 5.3 Implement state update logic
- [ ] 5.4 Add state persistence on agent completion
- [ ] 5.5 Add state loading on session resume

## 6. Implement Token Monitoring

- [ ] 6.1 Create token tracking mechanism (estimated per task completion)
- [ ] 6.2 Add token counting per major task completion
- [ ] 6.3 Implement checkpoint trigger at ~175,000 tokens
- [ ] 6.4 Add session save logic
- [ ] 6.5 Add code commit logic with "checkpoint" message
- [ ] 6.6 Add SESSION.md update with next steps
- [ ] 6.7 Add session resume logic (auto-load from brain-state.yaml)
- [ ] 6.8 Add token usage reporting display

## 7. Implement Agent Communication

- [ ] 7.1 Define completion notification format
- [ ] 7.2 Implement completion handling for all agents
- [ ] 7.3 Add handoff coordination logic
- [ ] 7.4 Implement blocking issue tracking
- [ ] 7.5 Add blocking issue resolution logic

## 8. Update Documentation

- [ ] 8.1 Update AGENTS.md with multi-agent architecture
- [ ] 8.2 Document Brain agent responsibilities
- [ ] 8.3 Document agent routing logic
- [ ] 8.4 Document agent handoff protocols
- [ ] 8.5 Update SESSION.md with agent workflow
- [ ] 8.6 Add token monitoring documentation
- [ ] 8.7 Add checkpoint and resume documentation

## 9. Testing

- [ ] 9.1 Test agent routing for all agent types
- [ ] 9.2 Test skill activation and execution
- [ ] 9.3 Test state management (save, load, update)
- [ ] 9.4 Test agent communication and handoffs
- [ ] 9.5 Test token monitoring and checkpoint
- [ ] 9.6 Test session resume from checkpoint
- [ ] 9.7 Verify documentation accuracy

## 10. Final Verification

- [ ] 10.1 Verify all skill files created
- [ ] 10.2 Verify routing logic works
- [ ] 10.3 Verify state management functional
- [ ] 10.4 Verify token monitoring operational
- [ ] 10.5 Verify documentation updated
- [ ] 10.6 Run rubocop and fix any issues
