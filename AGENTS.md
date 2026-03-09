# Darwis Project - Agent Configuration

## Project Overview
Ruby 3.3.x Roda framework application with SQLite3 database, Docker deployment, TDD with RSpec, and Rubocop for code quality. Integrates OpenSpec and RubyLLM for AI/LLM capabilities.

## Essential Commands

### Build Commands
```bash
bundle install                    # Install Ruby dependencies
docker build -t darwis .          # Build Docker image
docker-compose up                 # Start all services
docker-compose up -d             # Start in detached mode
docker-compose down              # Stop all services
docker-compose logs -f           # Follow logs
```

### Linting
```bash
bundle exec rubocop                                    # Check code style
bundle exec rubocop --auto-correct                     # Auto-fix issues
bundle exec rubocop --format json --out rubocop.json   # JSON output
```

### Testing
```bash
bundle exec rspec                              # Run all tests
bundle exec rspec spec/routes/root_spec.rb     # Run single test file
bundle exec rspec --tag integration            # Run tagged tests
bundle exec rspec --format documentation      # Verbose output
bundle exec rspec --only-failures             # Rerun failed tests
```

### Git Workflow
```bash
git checkout -b feature/feature-name
git checkout -b bugfix/issue-description
git checkout -b hotfix/critical-fix
git push -u origin branch-name
```

## Code Style Guidelines

### Ruby 3.3+ Syntax
- Use pattern matching: `case shape in {x:, y:} then ...`
- Hash shorthand syntax: `{x:, y:}` instead of `{x: x, y: y}`
- Endless methods: `def greet = "Hello"`
- Numbered parameters: `array.each { _1.to_s }`
- Squiggly heredocs for indentation: `<<~~TEXT`
- Use safe navigation (`&.`) instead of `try`

### Roda Conventions
- Use routing tree with `route { |r| ... }` block
- Load plugins at class level, not in route block
- Use `r.root` for root path
- Nest routes logically with `r.on "path" do ... end`
- Use `r.get`, `r.post` for HTTP method matching
- Use `r.is "path"` for exact path matching
- Use `r.on "path"` for prefix matching
- Keep routes thin, delegate business logic to services

### Import Organization
Order of imports:
1. Ruby standard library
2. External gems
3. Internal application files
4. Test helpers (in specs)

Example:
```ruby
require 'json'
require 'roda'
require 'sequel'

require_relative './models/user'
require_relative './services/auth_service'

RSpec.configure do |config|
  # configuration
end
```

### Naming Conventions
- Classes: PascalCase - `class UserService`
- Methods: snake_case - `def get_user(id)`
- Variables: snake_case - `user_name`
- Constants: SCREAMING_SNAKE_CASE - `MAX_RETRIES`
- Files: snake_case - `user_service.rb`
- Test files: append `_spec.rb` - `user_spec.rb`

### Error Handling
- Create custom error classes inheriting from `StandardError`
- Use Roda's error handling with `handle_exception`
- Raise exceptions with descriptive messages
- Use pattern matching in rescue blocks when appropriate
- Never expose stack traces in production

```ruby
class AuthenticationError < StandardError; end

handle_exception(AuthenticationError) do |e|
  response.status = 401
  {error: e.message}.to_json
end
```

## Roda-Specific Patterns

### Essential Plugins
- `:render` - Template rendering (ERB, Haml, etc.)
- `:session` - Session management with cookies
- `:csrf` - CSRF protection for forms
- `:h` - HTML escaping helpers
- `:static` - Serve static assets

### Route Block Structure
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

    r.root do
      render 'index'
    end
  end
end
```

### Plugin Usage
- Load plugins once at class level
- Configure plugins immediately after loading
- Avoid plugin loading in route blocks
- Use plugin-specific methods as documented

## Database & Docker

### SQLite3 Setup
- Store database in `db/` directory
- Use Sequel ORM with SQLite3 adapter
- Create migration files in `db/migrations/`
- Store development/test data separately

### Docker Workflow
- Use multi-stage builds for production
- Volume mount for development hot-reload
- Keep database volume persistent
- Use Alpine-based images for smaller size

## RSpec Configuration

### Testing Patterns
- Use `describe` for test subjects (classes, methods)
- Use `context` for different scenarios/conditions
- Use `it` for single behavior examples
- Keep tests independent (no shared state)
- Use `let` and `subject` for test data
- Use `before`/`after` hooks for setup/teardown

### Spec Organization
```
spec/
├── routes/          # Route handler tests
├── models/          # Model tests
├── services/        # Service object tests
├── support/         # Shared contexts, helpers
└── spec_helper.rb   # Global configuration
```

### Current Configuration
- `expect_with: :rspec` - Modern expectation syntax
- `mock_with: :rspec` - RSpec mocking framework
- `syntax: :expect` - Enforce expect syntax
- `color: true` - Colored output
- `profile: 10` - Show slowest 10 examples
- `warnings: false` - Suppress warnings
- `filter_run_when_matching: :focus` - Focus tag support
- `order: :random` - Random test order
- `aggregate_failures: true` - Show all failures

## Testing Best Practices

### Test Isolation
- Each test should be independent
- Use `DatabaseCleaner` for database cleanup
- Mock external API calls
- Avoid shared state between examples

### Test Coverage
- Aim for >80% code coverage
- Test happy path and error paths
- Test edge cases and boundary conditions
- Use shared contexts for repeated setup

### Naming
- Describe the behavior, not the implementation
- Use `it "returns user data"` not `it "calls the database"`
- Context names should describe conditions
- Group related tests together

## GitHub Integration

Repository: github.com/Jedt3D/darwis.git

### Commit Format
```
type(scope): brief description

Detailed explanation if needed

- bullet point
- another bullet point
```

Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`

## Development Workflow

1. Create feature branch
2. Write failing tests (TDD)
3. Implement feature
4. Run tests: `bundle exec rspec`
5. Run linter: `bundle exec rubocop`
6. Fix any issues
7. Commit with descriptive message
8. Push to remote
9. Create pull request
