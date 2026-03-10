# Agent Instructions

## Current Role
Acting as: **Darwis Server Agent**

## Trigger Conditions
Activate this role when:
- Working in `/home/worajedt/RubymineProjects/darwis/darwis/`
- Changes involve `app/`, `db/`, `config/` directories
- OpenSpec changes in `darwis/openspec/changes/`
- Tasks involve: API endpoints, database migrations, SDK integration

## Responsibilities

### API Development
- Implement RESTful API endpoints using Roda framework
- Follow RESTful conventions (GET, POST, PUT, DELETE)
- Return JSON responses with proper status codes
- Implement error handling with meaningful messages
- Add request validation and parameter parsing

### Database Management
- Create ActiveRecord migrations using Rake tasks
- Design database schemas with proper indexes
- Implement model validations (presence, uniqueness, format)
- Use reversible migration methods (create_table, add_column)
- Never modify migrations after running them

### Z.ai SDK Integration
- Integrate Z.ai Ruby SDK from local path: `/home/worajedt/RubymineProjects/z-ai-sdk-ruby`
- Handle SDK errors gracefully with try/catch
- Test API calls to Z.ai service
- Report SDK bugs by updating session-state.yml under `zai-sdk-maintenance`
- Log SDK interactions for debugging

### Server Operations
- Run server on port 9292 (development)
- Ensure Docker compatibility
- Monitor server logs for errors
- Implement graceful shutdown handling
- Handle concurrent requests safely

### Testing
- Write RSpec tests for routes, models, services
- Mock Z.ai SDK in test environment
- Use DatabaseCleaner for test isolation
- Ensure >80% code coverage
- Test both happy path and error scenarios

### Documentation
- Update README.md with API documentation
- Add OpenAPI/Swagger specs for endpoints
- Document database schema changes
- Keep AGENTS.md updated with architectural changes

## Handoff Triggers

### Switch to **Darwis-Chat Agent** when:
- All API endpoints are implemented and tested
- Server is running successfully on port 9292
- OpenSpec changes exist in `darwis-chat/openspec/changes/`
- Working on CLI, HTTP client, or session management
- Ready to test server API with client

### Switch to **Z.ai SDK Agent** when:
- SDK bug is reported with reproduction steps
- SDK feature is requested for server integration
- OpenSpec changes exist in `/home/worajedt/RubymineProjects/z-ai-sdk-ruby/openspec/changes/`
- SDK integration is blocking server development

### Update **Session State** after each task:
- Increment `tokens_used` by estimated amount (typically 5000-10000)
- Update `task_id` with next task number
- Update `progress` percentage
- Add completed task to `recent_work` array
- Check for blocking issues and add to `blocking_issues` array

### Trigger **Checkpoint** when `tokens_used` reaches 175000:
- Commit all current work to git
- Update SESSION.md with current progress
- Document next steps clearly
- Inform user to close session and resume later

## Model
- **Model:** GLM-5.0 Coding Plan
- **Primary Focus:** Server-side API and database development
- **Base Directory:** `/home/worajedt/RubymineProjects/darwis/darwis/`
- **Token Budget:** 200,000 tokens per session
- **Checkpoint Threshold:** 175,000 tokens

## Workflow

1. **Start Session:**
   - Read `.opencode/session-state.yml`
   - Confirm current agent role
   - Review pending tasks in OpenSpec changes

2. **Execute Task:**
   - Work on assigned task
   - Follow TDD approach (write tests first)
   - Run tests: `bundle exec rspec`
   - Run linting: `bundle exec rubocop`
   - Commit when feature is complete

3. **Update State:**
   - Edit `.opencode/session-state.yml`
   - Increment tokens_used estimate
   - Add completed task to recent_work
   - Update progress percentage

4. **Check for Handoff:**
   - Is current task complete?
   - Are there blocking issues?
   - Should we switch to another agent?
   - Update current_agent if handoff needed

5. **At Checkpoint:**
   - Commit all changes with "checkpoint" message
   - Update SESSION.md with session summary
   - Save current state for resume
   - Close session instruction

## Available Commands

### Database
```bash
bundle exec rake db:migrate      # Run migrations
bundle exec rake db:rollback     # Rollback last migration
bundle exec rake db:reset        # Reset database
bundle exec rake db:version      # Check migration version
bundle exec rake g:migration NAME=add_table  # Generate migration
```

### Testing
```bash
bundle exec rspec                              # Run all tests
bundle exec rspec spec/models/user_spec.rb      # Run specific test file
bundle exec rspec --tag integration            # Run tagged tests
```

### Linting
```bash
bundle exec rubocop              # Check style
bundle exec rubocop --auto-correct  # Auto-fix issues
```

### Docker
```bash
docker-compose up -d             # Start container
docker-compose down              # Stop container
docker-compose logs -f             # View logs
docker-compose exec web <cmd>    # Execute in container
```

## Success Criteria

A task is complete when:
- ✅ All RSpec tests pass
- ✅ Rubocop shows no offenses
- ✅ Code is committed to git
- ✅ Documentation is updated (README, AGENTS.md, SESSION.md)
- ✅ Session state is updated
- ✅ No blocking issues remain

## Error Handling

If encountering blocking issues:
1. Document the issue in `blocking_issues` array in session-state.yml
2. Include: error description, reproduction steps, attempted fixes
3. Determine which agent can unblock this issue
4. Update `pending_changes` with dependency tracking
5. Inform user about the blocking issue

## Communication Protocol

### To User
- Report progress updates (every 20-30 minutes of work)
- Inform about checkpoint approaching (when tokens_used > 150000)
- Alert on blocking issues immediately
- Summarize completed work in SESSION.md

### To Other Agents
Via session-state.yml:
- `dependencies` section shows agent dependencies
- `pending_changes` shows what needs to be done
- `recent_work` shows what's been completed
- `blocking_issues` shows what's blocking progress

## Quality Standards

- Follow Roda framework conventions
- Use ActiveRecord best practices
- Ensure RESTful API design
- Maintain >80% test coverage
- Follow Rubocop Ruby style guidelines
- Document all API endpoints in README.md
