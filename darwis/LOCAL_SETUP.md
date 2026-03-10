# Local Development Environment Setup

## Prerequisites

### Ruby Installation
Install Ruby 3.4.8 or use system Ruby

### Dependencies
```bash
# Install bundler
gem install bundler -v 2.5.22

# Install project dependencies
cd /path/to/darwis
bundle install
```

## Database Setup

### Create Database Directory
```bash
mkdir -p db/migrate
```

### Configure Database
```bash
# Create .env file
echo "DATABASE_PATH=db/development.sqlite3" > .env
```

### Run Migrations
```bash
# Create database
bundle exec rake db:create

# Run migrations
bundle exec rake db:migrate

# Check migration version
bundle exec rake db:version
```

## Development Workflow

### Start Server
```bash
bundle exec rackup -p 9292
```

### Run Tests
```bash
# All tests
bundle exec rspec

# Specific file
bundle exec rspec spec/models/user_spec.rb

# With coverage
bundle exec rspec --format documentation
```

### Linting
```bash
# Check style
bundle exec rubocop

# Auto-fix issues
bundle exec rubocop --autocorrect
```

## API Testing

### Test Health Endpoint
```bash
curl http://localhost:9292/api/health
```

### Test User Endpoints (after implementation)
```bash
# List users
curl http://localhost:9292/api/users

# Create user
curl -X POST http://localhost:9292/api/users \
  -H "Content-Type: application/json" \
  -d '{"name": "John Doe", "email": "john@example.com"}'

# Get user by ID
curl http://localhost:9292/api/users/1
```

## Troubleshooting

### Database Issues
```bash
# Reset database
bundle exec rake db:reset

# Check database file
ls -la db/*.sqlite3
```

### Server Issues
```bash
# Check if port is in use
lsof -i :9292

# Check server logs
bundle exec rackup -p 9292
```

### Migration Issues
```bash
# Rollback last migration
bundle exec rake db:rollback

# Check migration status
bundle exec rake db:version
```

## Environment Variables

Required:
- `DATABASE_PATH` - Path to SQLite database (default: db/development.sqlite3)
- `SESSION_SECRET` - Session encryption secret (development can use any string)
- `RACK_ENV` - Environment (development/test/production)

Optional:
- `DB_LOG` - Set to "true" for database query logging
- `ZAI_API_KEY` - Z.ai API key (when SDK is integrated)
- `ZAI_BASE_URL` - Z.ai API base URL
- `ZAI_TIMEOUT` - API timeout in seconds

## File Structure

```
darwis/
├── .env                    # Environment variables
├── .env.example             # Template for .env
├── Gemfile
├── Rakefile
├── config.ru
├── app/
│   ├── app.rb              # Main Roda application
│   ├── models/
│   │   ├── user.rb
│   │   ├── session.rb
│   │   └── message.rb
│   ├── routes/
│   │   ├── root.rb
│   │   ├── users.rb
│   │   ├── chat.rb
│   │   └ └ sessions.rb
│   └── views/
│       └── index.erb
├── db/
│   ├── development.sqlite3  # Created by migrations
│   └── migrate/
└── spec/
    ├── spec_helper.rb
    ├── models/
    ├── routes/
    └── support/
```

## Next Steps

1. Fix Ruby installation
2. Run `bundle install`
3. Run `bundle exec rake db:migrate`
4. Start server: `bundle exec rackup -p 9292`
5. Test endpoints with curl
6. Write RSpec tests
7. Document API in README.md

## Migration Management

### Create Migration
```bash
bundle exec rake g:migration NAME=add_users_table
```

### Run Migration
```bash
bundle exec rake db:migrate
```

### Rollback Migration
```bash
bundle exec rake db:rollback
```

### Reset Database
```bash
bundle exec rake db:reset
```

## Checkpoint Protocol

When tokens_used reaches ~175,000:
1. Commit all work
2. Update SESSION.md with progress
3. Save session-state.yml
4. Document next steps
5. Close session for resume

---

*Last Updated: 2026-03-10*
*Current Focus: Local development, Phase 1*
*Removed: Docker dependency, simplified approach*
