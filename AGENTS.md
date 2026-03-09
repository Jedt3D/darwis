# Darwis Project - Agent Configuration

## Project Overview
Ruby 3.3.x Roda framework app with SQLite3, Docker, RSpec TDD, Rubocop. Integrates OpenSpec and RubyLLM.

## Essential Commands

### Build
```bash
bundle install                    # Install deps
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

### SQLite3
- Store in `db/` directory
- Use Sequel ORM
- Migrations in `db/migrations/`

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
- `syntax: :expect`, `color: true`, `profile: 10`
- `filter_run_when_matching: :focus`
- `order: :random`, `aggregate_failures: true`

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
