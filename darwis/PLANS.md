# Project Plans

## Phase 1: Local Development Environment (Current)
**Status:** IN PROGRESS

**Original Goal:** Docker-based development environment
**Revised Goal:** Local Ruby development without Docker

**Tasks:**
- [x] Install Ruby 3.3.7 locally
- [x] Install bundler
- [x] Setup database locally
- [ ] Fix ActiveRecord database connection issues
- [ ] Test basic Roda app locally
- [ ] Run migrations locally
- [ ] Run RSpec tests locally
- [ ] Run Rubocop locally

**Issues Encountered:**
- Docker container startup failures (bundler can't find ffi)
- Database path confusion between Docker container and host
- Container exits with errors when running commands
- Complex debugging due to container isolation

**Decision:** Abandon Docker approach, use local development

---

## Phase 2: Basic API Endpoints (Next)
**Status:** PENDING

**Tasks:**
- [ ] Create users table locally
- [ ] Create User model with validations
- [ ] Implement users CRUD API endpoints
  - GET /api/users - List all users
  - GET /api/users/:id - Get user by ID
  - POST /api/users - Create user
  - PUT /api/users/:id - Update user
  - DELETE /api/users/:id - Delete user
- [ ] Write RSpec tests for users API
- [ ] Test endpoints locally with curl or httparty

---

## Phase 3: Chat API Integration (Future)
**Status:** PENDING

**Tasks:**
- [ ] Create Session model
- [ ] Create Message model
- [ ] Implement chat endpoints
  - POST /api/chat/send - Send message to AI
  - GET /api/sessions - List sessions
  - GET /api/sessions/:id - Get session with messages
  - POST /api/sessions - Create session
  - DELETE /api/sessions/:id - Delete session
  - GET /api/sessions/:id/messages - Get session messages
- [ ] Integrate Z.ai SDK (when available)
- [ ] Write tests for chat endpoints

---

## Phase 4: Darwis-Chat Client (Future)
**Status:** PENDING

**Prerequisites:** Phase 2 complete (chat API available)

**Tasks:**
- [ ] Set up CLI with TTY Toolkit
- [ ] Implement command history
- [ ] Implement HTTP client for server API
- [ ] Implement session management commands
- [ ] Test against running server
- [ ] Write tests for CLI functionality

---

## Phase 5: Z.ai SDK Integration (Future)
**Status:** PENDING

**Prerequisites:** Phase 2 complete, SDK available

**Tasks:**
- [ ] Install Z.ai Ruby SDK
- [ ] Configure SDK with API credentials
- [ ] Test SDK connection
- [ ] Integrate SDK in chat endpoints
- [ ] Handle SDK errors gracefully
- [ ] Write tests for SDK integration

---

## Deployment Plan (Revised)

### Local Development
```bash
# Install dependencies
bundle install

# Database setup
bundle exec rake db:migrate
bundle exec rake db:version

# Run tests
bundle exec rspec

# Run linting
bundle exec rubocop

# Start server
bundle exec rackup -p 9292
```

### Production Deployment (Future)
```bash
# Build Docker image when ready
docker build -t darwis .

# Run container
docker-compose up -d

# Or use PaaS (Heroku, Render, etc.)
```

---

## Agent Coordination Notes

### Current Agent: Darwis Server Agent
**Model:** GLM-5.0
**Tokens Used:** ~90,000 / 200,000
**Focus:** Local development, API endpoints, database

### Handoff Triggers
- **To Darwis-Chat Agent:** When Phase 2 complete (API endpoints working)
- **To Z.ai SDK Agent:** When SDK integration needed

### Success Criteria for Each Phase
- All tests passing
- Code committed
- Documentation updated
- No blocking issues
- Ready for next phase

---

## Known Issues & Solutions

### Issue 1: ActiveRecord Database Connection
**Problem:** Database path confusion between Docker and local
**Solution:** Use local path `db/development.sqlite3`

### Issue 2: Docker Container Startup
**Problem:** Bundler can't find ffi-1.17.3 in container
**Solution:** Abandon Docker, use local development

### Issue 3: Multi-Agent System
**Problem:** Never fully implemented
**Solution:** Self-agentic approach using session-state.yml

---

## Token Monitoring

**Session Start:** 2026-03-10
**Tokens Used:** ~90,000
**Remaining:** ~110,000 before checkpoint
**Tasks Completed:** Phase 1 (mostly), Phase 2 (pending)

**Next Steps:**
1. Fix local Ruby installation
2. Run migrations locally
3. Test Roda app locally
4. Proceed to Phase 2

---

## Questions for Decision Points

1. **Ruby Installation:** Should we use rbenv or install Ruby directly?
2. **Database:** Keep SQLite3 or switch to PostgreSQL?
3. **Testing:** Should we add FactoryBot for testing?
4. **API Documentation:** Should we add OpenAPI/Swagger specs?
