# Darwis Project - Agent Configuration

## Project Overview
Ruby 3.4.8 Roda framework app with SQLite3, Docker, RSpec TDD, Rubocop. Multi-agent orchestration system with Brain agent coordinating Darwis server, Darwis-Chat client, and Z.ai SDK agents.

## Multi-Agent Architecture

### Agent System

The Darwis project uses a multi-agent system for coordinated development:

```
┌─────────────────────────────────────────────────────────────┐
│                    Brain Agent (GLM-4.7)               │
│  - Monitors OpenSpec changes                               │
│  - Routes tasks to specialized agents                         │
│  - Coordinates handoffs                                       │
│  - Updates AGENTS.md and SESSION.md after each completion   │
└────────────┬────────────────────────────────────────────────┘
             │
    ┌────────┼────────┬───────────────────────┐
    │        │        │                       │
┌───▼────┐ ┌─▼──────┐  ┌──────────▼────────┐
│ Darwis  │ │ Darwis  │  │  Z.ai SDK         │
│ Server  │ │ -Chat   │  │  Maintenance       │
│ (GLM-5.0) │  (GLM-4.7) │  (GLM-5.0)         │
└────────┘ └────────┘  └───────────────────┘
```

### Agent Responsibilities

#### Brain Agent (GLM-4.7 Coding Plan)
- Orchestrates all development activities
- Routes OpenSpec changes to specialized agents based on location and specs
- Monitors agent states and progress
- Coordinates handoffs between agents
- Implements token monitoring (estimated per task)
- Triggers checkpoints at ~175,000 tokens
- Updates AGENTS.md and SESSION.md after EACH agent completion
- Maintains `.opencode/brain-state.yaml` for state tracking

#### Darwis Server Agent (GLM-5.0 Coding Plan)
- Implements RESTful API endpoints using Roda
- Creates database migrations and models
- Integrates Z.ai Ruby SDK from `/home/worajedt/RubymineProjects/z-ai-sdk-ruby`
- Generates API documentation
- Runs server for client testing
- Reports SDK bugs to Brain agent
- **Base Directory:** `/home/worajedt/RubymineProjects/darwis/darwis/`

#### Darwis-Chat Agent (GLM-4.7 Coding Plan)
- Implements CLI with TTY Toolkit
- Adds per-session command history
- Creates HTTP client for server communication
- Implements session management commands (/new, /switch, /list, /exit)
- Tests against running Darwis server
- **Base Directory:** `/home/worajedt/RubymineProjects/darwis/darwis-chat/`

#### Z.ai SDK Maintenance Agent (GLM-5.0 Coding Plan)
- Fixes bugs reported by Darwis server agent
- Adds new features to SDK
- Maintains version control and release notes
- Pushes updates to GitHub
- **Base Directory:** `/home/worajedt/RubymineProjects/z-ai-sdk-ruby/`

### Skill-Based Agent Activation

Each agent has a `.opencode/skills/<agent-name>/SKILL.md` file that defines:
- **Trigger Conditions:** When the agent should activate
- **Responsibilities:** What the agent does
- **Dependencies:** Required systems or agents
- **Handoff Protocols:** How to communicate with Brain agent

Skills are **instructions** that agents can adapt to, not strict rules.

### Agent Routing Logic

Brain agent routes OpenSpec changes based on:
1. **Change location:**
   - `darwis/openspec/changes/` → Darwis Server Agent
   - `darwis-chat/openspec/changes/` → Darwis-Chat Agent
   - `/home/worajedt/RubymineProjects/z-ai-sdk-ruby/openspec/changes/` → Z.ai SDK Agent

2. **Change specs:**
   - Contains `chat-api-endpoints`, `session-persistence`, `zai-sdk-integration` → Server Agent
   - Contains `terminal-interface`, `command-history`, `api-client`, `session-management` → Chat Agent
   - SDK bug report or feature request → SDK Agent

3. **Dependencies:**
   - Agents cannot start until dependencies are completed
   - Blocking issues prevent dependent agents from starting

### Token Monitoring & Session Management

- **Token Budget:** 200,000 tokens per session
- **Checkpoint Threshold:** ~175,000 tokens (estimated per task completion)
- **Checkpoint Actions:**
  1. Save all work in progress
  2. Commit code with "checkpoint" message
  3. Update SESSION.md with next steps
  4. Close OpenCode session
  5. User resumes by loading `.opencode/brain-state.yaml`
  6. Continue from next task (auto-resume)

### State Management

Brain agent maintains state in `.opencode/brain-state.yaml`:
- Agent statuses (idle, in-progress, completed, blocked)
- Progress percentages
- Current changes and dependencies
- Blocking issues
- Token usage estimates
- Documentation update status

### OpenSpec as Task Queue

- OpenSpec changes serve as task units
- Each change has: proposal, design, specs, tasks
- Agents execute via `/opsx-apply`
- Status tracked by OpenSpec
- Brain agent monitors and routes changes

### Documentation Sync

Brain agent updates documentation after **EACH** agent completion:
- **AGENTS.md:** Architecture, agent responsibilities, routing logic
- **SESSION.md:** Workflow changes, progress, token usage

## Essential Commands

### Build
```bash
cd darwis                      # Navigate to darwis directory
bundle install                  # Install deps (resolve bundler permissions first)
docker build -t darwis .          # Build image
docker-compose up -d             # Start services
docker-compose down              # Stop services
```

### Lint
```bash
bundle exec rubocop                                    # Check style
bundle exec rubocop --auto-correct                     # Auto-fix
```

### Test
```bash
bundle exec rspec                              # All tests
bundle exec rspec spec/routes/root_spec.rb     # Single file
bundle exec rspec --tag integration            # Tagged tests
bundle exec rspec --format documentation      # Verbose
```

### Git
```bash
git checkout -b feature/feature-name
git checkout -b bugfix/issue-description
git checkout -b hotfix/critical-fix
git push -u origin branch-name
```

### Rake Tasks
```bash
bundle exec rake -T              # List all tasks
bundle exec rake                 # Run default task (tests + lint)
bundle exec rake lint            # Run Rubocop only
bundle exec rake spec            # Run RSpec only

# Database Tasks
bundle exec rake db:create       # Create database
bundle exec rake db:migrate      # Run migrations
bundle exec rake db:rollback    # Rollback last migration
bundle exec rake db:reset       # Drop and recreate database
bundle exec rake db:seed        # Seed database
bundle exec rake db:version     # Show current migration version
```

## Code Style Guidelines

### Ruby 3.3+ Syntax
- Pattern matching: `case shape in {x:, y:} then ...`
- Hash shorthand: `{x:, y:}` instead of `{x: x, y: y}`
- Endless methods: `def greet = "Hello"`
- Numbered params: `array.each { _1.to_s }`
- Safe navigation: `&.` instead of `try`

### Roda Conventions
- Use routing tree: `route { |r| ... }`
- Load plugins at class level
- Use `r.root` for root path
- Nest routes: `r.on "path" do ... end`
- Use `r.get`, `r.post` for HTTP methods
- `r.is "path"` for exact, `r.on "path"` for prefix
- Keep routes thin, delegate to services

### Import Order
1. Ruby stdlib
2. External gems
3. Internal files
4. Test helpers (specs)

### Naming Conventions
- Classes: PascalCase - `class UserService`
- Methods/Variables: snake_case - `def get_user`, `user_name`
- Constants: SCREAMING_SNAKE_CASE - `MAX_RETRIES`
- Files: snake_case - `user_service.rb`
- Test files: append `_spec.rb` - `user_spec.rb`

### Error Handling
- Custom errors: `class AuthenticationError < StandardError; end`
- Roda handlers: `handle_exception(AuthenticationError) { |e| ... }`
- Raise with descriptive messages
- Use pattern matching in rescue blocks
- Never expose stack traces in production

### Rubocop Plugins Installed
- `rubocop-rake` - Rake task best practices
- `rubocop-rails` - ActiveRecord/Rails best practices
- `rubocop-thread_safety` - Thread safety (lenient configuration)
- `rubocop-capybara` - Capybara testing (disabled until tests exist)

### Thread Safety Configuration
Thread safety checks are configured leniently:
- New thread creation checks: Disabled
- Shared global variable checks: Disabled
- Instance variable in class methods: Disabled
Enable specific checks as needed for concurrent code.

## Roda Patterns

### Essential Plugins
- `:render` - Template rendering (ERB, Haml)
- `:session` - Session management
- `:csrf` - CSRF protection
- `:h` - HTML escaping helpers
- `:static` - Serve static assets

### Route Structure
```ruby
class App < Roda
  plugin :render, engine: 'erb'
  plugin :session, secret: ENV.fetch('SESSION_SECRET')
  plugin :csrf
  plugin :h

  route do |r|
    r.on "api" do
      r.on "users" do
        r.is Integer do |id|
          r.get { show_user(id) }
          r.post { update_user(id) }
        end
      end
    end
    r.root { render 'index' }
  end
end
```

### Plugin Usage
- Load once at class level
- Configure immediately after loading
- Avoid in route blocks

## Database & Docker

### SQLite3 + ActiveRecord
- Store in `db/` directory
- Use ActiveRecord ORM
- Migrations in `db/migrate/`
- Use `bundle exec rake db:migrate` to run migrations
- Use `bundle exec rake db:rollback` to rollback
- Use `bundle exec rake db:reset` to drop and recreate

### ActiveRecord Best Practices
- Use `ActiveRecord::Migration[7.2]` class name
- Define `change` method (not up/down)
- Use reversible migration methods (create_table, add_column, etc.)
- Use `rake db:g:migration NAME=add_table` to generate migrations
- Never modify migrations after they're run

### Docker
- Multi-stage builds for production
- Volume mount for dev hot-reload
- Use Alpine images

## RSpec Config

### Testing Patterns
- `describe` for subjects, `context` for scenarios, `it` for examples
- Use `let` and `subject` for data
- `before`/`after` hooks for setup

### Structure
```
spec/
├── routes/          # Route tests
├── models/          # Model tests
├── services/        # Service tests
├── support/         # Helpers
└── spec_helper.rb   # Config
```

### Current Settings
- `expect_with: :rspec`, `mock_with: :rspec`
- `color: true`, `warnings: false`
- `filter_run_when_matching: :focus`
- `order: :random`, `aggregate_failures: true`
- `run_all_when_everything_filtered: true`
- `default_formatter: 'doc'`

### Best Practices
- Independent tests (use DatabaseCleaner)
- >80% code coverage
- Test happy/error paths and edge cases
- Describe behavior, not implementation
- Use `it "returns user data"` not `it "calls the database"`

## GitHub

Repository: github.com/Jedt3D/darwis.git

### Commit Format
```
type(scope): brief description

- bullet points

Types: feat, fix, refactor, test, docs, chore
```

## Workflow

1. Create feature branch
2. Write failing tests (TDD)
3. Implement feature
4. Run tests: `bundle exec rspec`
5. Run linter: `bundle exec rubocop`
6. Commit with descriptive message
7. Push to remote
8. Create pull request
