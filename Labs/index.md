# Docker Compose Labs

## Lab Overview

Welcome to the hands-on Docker Compose labs! This comprehensive series of 17 labs guides you from basic setup through advanced topics like multi-network architecture, Helm charts, live reload, reusable configuration fragments, environment-aware profiles, init containers, variable substitution, merge strategies, integration testing, secrets management, and local development workflows.

---

## Available Labs

| # | Lab | Difficulty | Description |
|---|-----|-----------|-------------|
| 1 | [001 - Introduction](001-intro/README.md) | Beginner | Install Docker Compose and understand core concepts |
| 2 | [002 - Compose Demo](002-Compose-Demo/README.md) | Beginner | Multi-service app with web, app, and database tiers |
| 3 | [002 - Structure](002-Structure/README.md) | Intermediate | Complete docker-compose.yml syntax reference |
| 4 | [003 - Commands](003-Commands/README.md) | Intermediate | Master the Docker Compose CLI |
| 5 | [004 - Compose to Helm](004-Compose-2Helm/README.md) | Advanced | Package Compose apps as Helm charts for Kubernetes |
| 6 | [005 - Advanced Features](005-Compose-Advanced/README.md) | Advanced | `extends`, YAML anchors, and modular configs |
| 7 | [006 - Watch](006-Watch/README.md) | Intermediate | Live reload and file synchronization |
| 8 | [007 - Networks](007-Networks/README.md) | Advanced | Multi-network architecture with DMZ and security zones |
| 9 | [008 - Advanced Topics](008-Advanced/README.md) | Advanced | Profiles, secrets, configs, resource limits, logging, init, variable substitution, merge, include |
| 10 | [009 - Fragments](009-Fragments/README.md) | Advanced | Reusable fragments: logging, resources, healthchecks, networks, secrets, security, profiles |
| 11 | [010 - Profiles](010-Profiles/README.md) | Intermediate | Environment-aware service management with Docker Compose profiles |
| 12 | [011 - Init Containers](011-InitContainers/README.md) | Advanced | Startup orchestration with init containers and healthcheck chains |
| 13 | [012 - Variable Substitution](012-VariableSubstitution/README.md) | Intermediate | Environment variable substitution, defaults, and mandatory values |
| 14 | [013 - Merge & Override](013-MergeOverride/README.md) | Intermediate | Multi-file merge strategies and override patterns |
| 15 | [014 - Integration Testing](014-IntegrationTesting/README.md) | Advanced | Automated integration testing with Compose exit codes |
| 16 | [015 - Secrets & Configs](015-SecretsConfigs/README.md) | Advanced | Secure secrets and configuration management |
| 17 | [016 - Dev Workflows](016-DevWorkflows/README.md) | Intermediate | Local development hot-reload, profiles, and CI pipelines |

---

## Learning Paths

### Beginner Path

Start here if you're new to Docker Compose:

1. [Lab 001: Introduction](001-intro/README.md)
2. [Lab 002: Compose Demo](002-Compose-Demo/README.md)
3. [Lab 002: Structure](002-Structure/README.md)

### Intermediate Path

For those comfortable with Docker Compose basics:

1. [Lab 003: Commands](003-Commands/README.md)
2. [Lab 006: Watch](006-Watch/README.md)
3. [Lab 012: Variable Substitution](012-VariableSubstitution/README.md)
4. [Lab 013: Merge & Override](013-MergeOverride/README.md)
5. [Lab 016: Dev Workflows](016-DevWorkflows/README.md)

### Advanced Path

For experienced engineers:

1. [Lab 004: Compose to Helm](004-Compose-2Helm/README.md)
2. [Lab 005: Advanced Features](005-Compose-Advanced/README.md)
3. [Lab 007: Networks](007-Networks/README.md)
4. [Lab 008: Advanced Topics](008-Advanced/README.md)
5. [Lab 009: Fragments](009-Fragments/README.md)
6. [Lab 010: Profiles](010-Profiles/README.md)
7. [Lab 011: Init Containers](011-InitContainers/README.md)
8. [Lab 014: Integration Testing](014-IntegrationTesting/README.md)
9. [Lab 015: Secrets & Configs](015-SecretsConfigs/README.md)

---

## Tips for Success

- **Take your time**: Don't rush through the labs - understanding beats speed
- **Experiment**: Modify the compose files and observe the changes
- **Break and fix**: Intentionally break a service, then debug using `docker compose logs`
- **Read the config**: Use `docker compose config` to see the resolved configuration
- **Clean up**: Always run `docker compose down` after each lab

## Get Started

Ready to begin? Start with [Lab 001: Introduction](001-intro/README.md)!
