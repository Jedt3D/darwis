# Darwis Server Agent

## Trigger Conditions
This skill activates when:
- OpenSpec change is in `darwis/` directory
- Change contains specs: chat-api-endpoints, session-persistence, zai-sdk-integration
- Brain agent routes to this agent
- User explicitly invokes: "Use darwis-server agent"

## Responsibilities

### API Development
- Implement RESTful API endpoints using Roda
- Generate API documentation (OpenAPI/Swagger)
- Ensure JSON response formats
- Implement error handling

### Database Management
- Create ActiveRecord migrations
- Design database schemas
- Implement model validations
- Optimize queries

### Z.ai SDK Integration
- Integrate Z.ai Ruby SDK from local path: /home/worajedt/RubymineProjects/z-ai-sdk-ruby
- Handle SDK errors
- Test API calls
- Report SDK bugs to Brain agent (routes to Z.ai SDK Agent)

### Server Operations
- Run server for client testing
- Ensure Docker compatibility
- Monitor server logs
- Handle deployment

### Testing
- Write RSpec tests for routes, models, services
- Mock Z.ai SDK in tests
- Run integration tests
- Ensure >80% code coverage

## Dependencies
- Z.ai Ruby SDK functional
- Database migrations run
- Docker environment working

## Handoff Protocols

### To Brain Agent
- On completion: Report change completion
- Provide: change ID, artifacts created, any blocking issues
- Include: API documentation location, server endpoint
- Trigger: AGENTS.md and SESSION.md update

### On SDK Bug
- Report SDK bug to Brain agent
- Include: bug description, reproduction steps, expected behavior
- Brain agent routes to Z.ai SDK Agent

## Model
- **Model:** GLM-5.0 Coding Plan
- **Primary Focus:** Server-side API and database
- **Base Directory:** /home/worajedt/RubymineProjects/darwis/darwis/
