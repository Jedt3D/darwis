# Z.ai Ruby SDK Maintenance

## Trigger Conditions
This skill activates when:
- OpenSpec change is in `/home/worajedt/RubymineProjects/z-ai-sdk-ruby/openspec/changes/`
- Darwis server agent reports SDK bug
- User explicitly invokes: "Use zai-sdk agent"

## Responsibilities

### Bug Fixing
- Fix bugs reported by Darwis server agent
- Update test cases to cover bug scenarios
- Ensure backward compatibility
- Run full test suite

### SDK Enhancements
- Add new features requested by server
- Improve API ergonomics
- Update documentation
- Performance optimizations

### Version Management
- Bump version numbers (semver)
- Create release notes
- Push to GitHub
- Maintain CHANGELOG.md

### Testing
- Run full RSpec test suite
- Add integration tests for fixes
- Test with different Ruby versions
- Ensure >90% code coverage

## Dependencies
- OpenSpec system in SDK repository
- Bug reports from Darwis server agent
- GitHub repository access

## Handoff Protocols

### To Brain Agent
- On completion: Report change completion
- Provide: change ID, version bump, breaking changes
- Include: GitHub commit hash, release notes
- Trigger: AGENTS.md and SESSION.md update

### Breaking Changes
- Document all breaking changes
- Notify Darwis server agent via Brain agent
- Provide migration guide

## Model
- **Model:** GLM-5.0 Coding Plan
- **Primary Focus:** SDK maintenance and bug fixes
- **Base Directory:** /home/worajedt/RubymineProjects/z-ai-sdk-ruby/
