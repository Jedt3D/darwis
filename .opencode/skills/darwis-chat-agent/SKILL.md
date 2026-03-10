# Darwis-Chat Agent

## Trigger Conditions
This skill activates when:
- OpenSpec change is in `darwis-chat/` directory
- Change contains specs: terminal-interface, command-history, api-client, session-management
- Brain agent routes to this agent (after server completion)
- User explicitly invokes: "Use darwis-chat agent"

## Responsibilities

### CLI Development
- Implement terminal UI using TTY Toolkit
- Add color-coded output
- Implement prompts and menus
- Handle user input

### Command History
- Implement per-session command history
- Support arrow key navigation
- Limit history size (100 commands)
- Persist history to session

### HTTP Client
- Implement API calls to Darwis server (DARWIS_SERVER_URL)
- Handle HTTP errors (400, 404, 500)
- Implement retry logic
- Parse JSON responses

### Session Management
- Implement commands: /new, /switch, /list, /exit
- Manage active session state
- Handle session errors
- Persist session configuration

### Testing
- Write tests for CLI interface
- Mock HTTP calls to server
- Test against running server
- Ensure command history works

## Dependencies
- Darwis server API functional
- API documentation available
- TTY Toolkit installed
- Server running on DARWIS_SERVER_URL (default: http://localhost:9292)

## Handoff Protocols

### To Brain Agent
- On completion: Report change completion
- Provide: change ID, artifacts created, any blocking issues
- Trigger: AGENTS.md and SESSION.md update

### On Server Issue
- Report API issues to Brain agent
- Include: error details, expected behavior, affected endpoint

## Model
- **Model:** GLM-4.7 Coding Plan
- **Primary Focus:** CLI client and TUI
- **Base Directory:** /home/worajedt/RubymineProjects/darwis/darwis-chat/

## TUI Libraries
- `tty-prompt` (~> 0.23)
- `tty-spinner` (~> 0.9)
- `tty-progressbar` (~> 0.18)
- `tty-color` (~> 0.5)
- `tty-table` (~> 0.12)
