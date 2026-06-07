<!-- header start -->

<a href="https://stackoverflow.com/users/1755598/codewizard"><img src="https://stackoverflow.com/users/flair/1755598.png" width="208" height="58" alt="profile for CodeWizard at Stack Overflow, Q&amp;A for professional and enthusiast programmers" title="profile for CodeWizard at Stack Overflow, Q&amp;A for professional and enthusiast programmers"></a>&emsp;&emsp;[![Linkedin Badge](https://img.shields.io/badge/-nirgeier-blue?style=flat&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/nirgeier/)](https://www.linkedin.com/in/nirgeier/)&emsp;[![Gmail Badge](https://img.shields.io/badge/-nirgeier@gmail.com-fcc624?style=flat&logo=Gmail&logoColor=red&link=mailto:nirgeier@gmail.com)](mailto:nirgeier@gmail.com)&emsp;[![Outlook Badge](https://img.shields.io/badge/-nirg@codewizard.co.il-fcc624?style=flat&logo=microsoftoutlook&logoColor=blue&link=mailto:nirg@codewizard.co.il)](mailto:nirg@codewizard.co.il)&emsp;![Visitor Badge](https://visitor-badge.laobi.icu/badge?page_id=nirgeier)

<!-- header end -->

---

## 📚 [View Documentation Site](https://nirgeier.github.io/DockerComposeLabs/)

---

![](./resources/logos.png)

---

<div align="center">
  <a href="https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/nirgeier/DockerComposeLabs">
    <img src="https://gstatic.com/cloudssh/images/open-btn.svg" alt="Open in Cloud Shell">
  </a>
  <br>
  <sub><kbd>CTRL</kbd> + click to open in new window</sub>
</div>

---

# Docker Compose Hands-on Labs

A comprehensive, hands-on collection of Docker Compose labs - from **beginner fundamentals** to **production-grade multi-network architectures**. Each lab is self-contained and can be completed independently.

---

## At a Glance

| # | Lab | Difficulty | Est. Time | Tasks | Key Topics |
|---|-----|-----------|-----------|-------|------------|
| 1 | [001-intro](./Labs/001-intro/) | ⭐ Beginner | 15 min | 4 | Installation, basic concepts |
| 2 | [002-Compose-Demo](./Labs/002-Compose-Demo/) | ⭐ Beginner | 30 min | 6 | Multi-service app, dependencies |
| 3 | [002-Structure](./Labs/002-Structure/) | ⭐⭐ Intermediate | 45 min | 8 | YAML syntax, all config options |
| 4 | [003-Commands](./Labs/003-Commands/) | ⭐⭐ Intermediate | 30 min | 8 | CLI commands, lifecycle mgmt |
| 5 | [004-Compose-2Helm](./Labs/004-Compose-2Helm/) | ⭐⭐⭐ Advanced | 60 min | 6 | Helm charts, K8s deployment |
| 6 | [005-Compose-Advanced](./Labs/005-Compose-Advanced/) | ⭐⭐⭐ Advanced | 45 min | 8 | `extends`, YAML anchors, DRY |
| 7 | [006-Watch](./Labs/006-Watch/) | ⭐⭐ Intermediate | 40 min | 8 | Live reload, sync, dev workflow |
| 8 | [007-Networks](./Labs/007-Networks/) | ⭐⭐⭐ Advanced | 60 min | 10 | Multi-network, security, DMZ |
| 9 | [008-Advanced](./Labs/008-Advanced/) | ⭐⭐⭐ Advanced | 60 min | 9 | Profiles, secrets, resource limits, logging, merge, include |
| 10 | [009-Fragments](./Labs/009-Fragments/) | ⭐⭐⭐ Advanced | 60 min | 10 | YAML anchors, `extends`, reusable fragments |
| 11 | [010-Profiles](./Labs/010-Profiles/) | ⭐⭐ Intermediate | 45 min | 10 | Environment-aware service selection |
| 12 | [011-InitContainers](./Labs/011-InitContainers/) | ⭐⭐⭐ Advanced | 50 min | 10 | Init containers, startup orchestration, healthcheck chains |
| 13 | [012-VariableSubstitution](./Labs/012-VariableSubstitution/) | ⭐⭐ Intermediate | 45 min | 10 | Variable substitution, defaults, mandatory vars |
| 14 | [013-MergeOverride](./Labs/013-MergeOverride/) | ⭐⭐ Intermediate | 45 min | 8 | Multi-file merge, override patterns |
| 15 | [014-IntegrationTesting](./Labs/014-IntegrationTesting/) | ⭐⭐⭐ Advanced | 50 min | 10 | Integration testing, exit codes, CI pipelines |
| 16 | [015-SecretsConfigs](./Labs/015-SecretsConfigs/) | ⭐⭐⭐ Advanced | 45 min | 9 | Secrets management, configs, Swarm |
| 17 | [016-DevWorkflows](./Labs/016-DevWorkflows/) | ⭐⭐ Intermediate | 50 min | 10 | Hot reload, DB proxy, CI pipelines, profiles |

---

## Prerequisites

| Requirement | Details |
|------------|---------|
| **Docker** | Installed (Desktop or Engine) |
| **Docker Compose** | Included with Docker Desktop v2+ / `docker compose` plugin |
| **Basic Docker knowledge** | `docker run`, `docker ps`, container concepts |
| **YAML familiarity** | Helpful but not required - learn as you go |

> **Tip:** Lab 001 covers Docker Compose installation if you need it.

---

## Recommended Learning Path

```
Beginner ─────────────────────────────────────────────────────► Advanced

  001-intro
    |
    ▼
  002-Compose-Demo
    |
    +──► 002-Structure
    |         |
    |         ▼
    |     003-Commands
    |         |
    |         +──► 005-Compose-Advanced
    |         |         |
    |         |         ▼
    |         |     006-Watch
    |         |         |
    |         |         ▼
    |         |     009-Fragments
    |         |         |
    |         |         ▼
    |         |     010-Profiles
    |         |
    |         +──► 004-Compose-2Helm
    |         |
    |         +──► 008-Advanced
    |         |         |
    |         |         ▼
    |         |     011-InitContainers
    |         |         |
    |         |         ▼
    |         |     012-VariableSubstitution
    |         |         |
    |         |         ▼
    |         |     013-MergeOverride
    |         |         |
    |         |         ▼
    |         |     014-IntegrationTesting
    |         |         |
    |         |         ▼
    |         |     015-SecretsConfigs
    |         |
    |         +──► 016-DevWorkflows
    |
    +──► 007-Networks
```

---

## Detailed Lab Descriptions

### [001-intro -- Getting Started](./Labs/001-intro/)

Install Docker Compose across platforms and understand the core concepts.

**Skills you'll gain:**
- Install Docker Compose on Windows, macOS, and Linux
- Verify the installation and understand the toolchain
- Grasp the value proposition of multi-container orchestration

**Hands-On Tasks:** 4 (Verify install, test version, brew info, create first YAML)

### [002-Compose-Demo -- Your First Multi-Container App](./Labs/002-Compose-Demo/)

Walk through a real docker-compose.yml with web, app, and database tiers.

**Skills you'll gain:**
- Define multi-service applications in YAML
- Configure `depends_on`, networks, volumes, and ports
- Understand service startup order and data persistence

**Hands-On Tasks:** 6 (Examine YAML, trace dependencies, run the stack, test connectivity, modify config, clean up)

### [002-Structure -- Compose File Anatomy](./Labs/002-Structure/)

Deep dive into every configuration option available in docker-compose.yml.

**Skills you'll gain:**
- Master `build`, `image`, `ports`, `volumes`, `environment`
- Use `healthcheck`, `restart` policies, and `depends_on`
- Structure production-grade compose files

**Hands-On Tasks:** 8 (Everything from build context to health checks, secrets, and custom extensions)

### [003-Commands -- CLI Mastery](./Labs/003-Commands/)

Master the Docker Compose CLI for daily development and production operations.

**Skills you'll gain:**
- Manage the full application lifecycle (up/down/restart)
- Debug with `logs`, `exec`, `ps`, `config`
- Use advanced flags: `-f`, `-p`, `--env-file`, `--profile`

**Hands-On Tasks:** 8 (Startup lifecycle, build/down/recreate, exec/bash, logs/top, config inspect, detached/attached, targeted restart, cleanup)

### [004-Compose-2Helm -- From Compose to Kubernetes](./Labs/004-Compose-2Helm/)

Learn how to package and deploy Docker Compose applications as Helm charts on Kubernetes.

**Skills you'll gain:**
- Scaffold a Helm chart with `helm create`
- Customize `values.yaml` and templates
- Install, upgrade, rollback, and uninstall releases

**Hands-On Tasks:** 6 (Scaffold chart, customize values, package, deploy, upgrade & rollback, uninstall)

### [005-Compose-Advanced -- Modular & DRY Configs](./Labs/005-Compose-Advanced/)

Explore advanced patterns: the `extends` keyword and YAML anchors for reusable configurations.

**Skills you'll gain:**
- Split service definitions into reusable files with `extends`
- Use YAML anchors (`&`) and aliases (`<<: *`) for DRY config
- Build a complete monitoring stack (Prometheus, Grafana, Loki, Portainer)

**Hands-On Tasks:** 8 (Compare extends vs anchors, add a service, modify env vars, test inter-service communication, add health checks, use YAML anchors, build custom image, configure networks)

### [006-Watch -- Live Reload for Development](./Labs/006-Watch/)

Set up Docker Compose Watch for automatic file sync, rebuild, and restart during development.

**Skills you'll gain:**
- Configure `develop.watch` with `sync`, `rebuild`, `restart` actions
- Speed up development feedback loops
- Combine watch with multi-service architectures

**Hands-On Tasks:** 8 (Basic sync, rebuild actions, multi-service watch, configuration restart, custom demo script, performance comparison, troubleshooting, exclude patterns)

### [007-Networks -- Production Network Architecture](./Labs/007-Networks/)

Design a secure, segmented microservices network with 8 isolated networks.

**Skills you'll gain:**
- Create multi-network architectures with IPAM and subnets
- Implement DMZ, security zones, and least-privilege networking
- Use network aliases and cross-network monitoring

**Hands-On Tasks:** 10 (Network inspection, service discovery, isolation testing, alias configuration, IPAM customization, cross-network monitoring, external networks, label usage, health checks, full network diagram)

### [008-Advanced -- Advanced Topics](./Labs/008-Advanced/)

Master production-grade Docker Compose features: profiles, secrets, configs, resource constraints, and the modern `include:` pattern.

**Skills you'll gain:**
- Use profiles for environment-specific service selection
- Manage secrets and configs securely
- Set CPU/memory limits and configure logging drivers
- Master variable substitution with defaults and validation
- Merge and override multiple compose files

**Hands-On Tasks:** 9 (Profiles, secrets, configs, resource constraints, logging drivers, init containers, variable substitution, merge/override, include)

### [009-Fragments -- Reusable Configuration Patterns](./Labs/009-Fragments/)

Learn Docker Compose fragments using YAML anchors, aliases, and the `extends` mechanism for reusable configuration blocks.

**Skills you'll gain:**
- Define reusable fragments for logging, resources, healthchecks, networks, secrets, security, and profiles
- Use YAML anchors (`&`) and aliases (`<<: *`) for DRY config within a single file
- Use `extends` to inherit full service definitions from external files
- Build a complete monitoring stack (Prometheus, Grafana, Loki, Portainer)

**Hands-On Tasks:** 10 (Create fragment library, profile-based switching, healthcheck dependency chain, combine all fragments, extends from external files)

### [010-Profiles -- Environment-Aware Service Management](./Labs/010-Profiles/)

Master Docker Compose profiles to control which services start in different environments from a single compose file.

**Skills you'll gain:**
- Define profiles using `x-` fragments for reusable profile definitions
- Start services with `docker compose --profile <name> up`
- Combine multiple profiles and use `COMPOSE_PROFILES` in `.env`
- Design environment-based (dev/staging/prod), team-based, and CI/CD pipeline profiles

**Hands-On Tasks:** 10 (Basic profile separation, environment switching, CI/CD pipeline stages, COMPOSE_PROFILES in .env, multi-file profiles, diagnose which services start)

### [011-InitContainers -- Startup Orchestration](./Labs/011-InitContainers/)

Learn init containers for startup orchestration: run database migrations, seed data, warm caches, and validate config before main services start.

**Skills you'll gain:**
- Use `init: true` for proper signal handling in one-shot services
- Chain init containers with `depends_on: condition: service_completed_successfully`
- Combine healthchecks (`service_healthy`) with init containers for ordered startup
- Create reusable init container fragments with YAML anchors
- Compare wait strategies: healthcheck, netcat, curl, pg_isready, custom scripts, time-based

**Hands-On Tasks:** 10 (Basic init container pipeline, multi-stage orchestration, compare wait strategies, build pipeline with reusable fragments, combine with healthchecks)

### [012-VariableSubstitution -- Variable Substitution Deep Dive](./Labs/012-VariableSubstitution/)

Deep-dive into Docker Compose variable substitution: `${VAR}`, `${VAR:-default}`, `${VAR:?error}`, `${VAR:+replacement}`, `$$` escaping, and multi-file env strategies.

**Skills you'll gain:**
- Master all five substitution syntax forms with practical examples
- Understand `.env` loading order and precedence (shell > .env > env_file > environment > defaults)
- Use `env_file` with multiple files for layered configuration
- Build environment-specific config with dynamic `env_file` paths

**Hands-On Tasks:** 10 (Run basics example, enforce mandatory variables, explore advanced techniques, multi-file environment strategy, build your own multi-env setup)

### [013-MergeOverride -- Merge & Override Strategies](./Labs/013-MergeOverride/)

Learn how Docker Compose merges multiple compose files: default override (`docker-compose.override.yaml`), explicit multi-file with `-f`, and merge rules for maps, lists, and sequences.

**Skills you'll gain:**
- Understand map merge (last writer wins), list replace (not merged), sequence merge (by key)
- Use `docker compose config` to verify merged results
- Switch environments with `-f base.yaml -f env.yaml`
- Combine `extends` and YAML anchors with override files

**Hands-On Tasks:** 8 (Default override pattern, multi-file environment switching, verify merge rules, custom override chain)

### [014-IntegrationTesting -- Integration Testing](./Labs/014-IntegrationTesting/)

Run integration tests inside Docker Compose: test services, exit code propagation, healthcheck chaining, parallel execution, and CI pipeline patterns.

**Skills you'll gain:**
- Design tests as services with `--exit-code-from` for CI pass/fail
- Use `service_completed_successfully` for ordered test dependencies
- Chain healthchecks for reliable startup (db → healthy → api → test)
- Run parallel test suites for faster feedback

**Hands-On Tasks:** 10 (Run basic test, observe exit code propagation, chained healthcheck dependencies, parallel test execution, build CI pipeline test)

### [015-SecretsConfigs -- Secrets & Configs Management](./Labs/015-SecretsConfigs/)

Manage sensitive data (passwords, API keys, TLS certs) and non-sensitive configs using Docker Compose `secrets:` and `configs:`.

**Skills you'll gain:**
- Use file-based secrets (`file:`) and external secrets (`external: true` for Swarm)
- Configure custom target paths and file modes (`mode: 0400`)
- Distinguish secrets (tmpfs, sensitive) from configs (regular files, non-sensitive)
- Use `env_file` as a simpler alternative for non-sensitive data

**Hands-On Tasks:** 9 (File-based secrets basics, external secrets with Swarm, advanced target paths/modes/configs, external configs, env_file alternative)

### [016-DevWorkflows -- Local Development Workflows](./Labs/016-DevWorkflows/)

Build efficient local development workflows: hot reload with volume mounts, database proxy with socat, CI pipeline chaining, service profiles, and multi-stage development.

**Skills you'll gain:**
- Hot reload with `nodemon` and read-only volume mounts
- Proxy containerized databases to host with `socat` for local GUI tools
- Chain CI pipeline stages (lint → test → build) with `depends_on` + completion conditions
- Use profiles for core/full/debug/CI environment separation
- Share `node_modules` via named volumes across build, dev, test, lint stages

**Hands-On Tasks:** 10 (Hot reload a Node app, chain a CI pipeline, profile-based switching, multi-stage workflow, combine profiles with hot reload)

---

## Getting Started

```bash
# 1. Clone the repository
git clone https://github.com/nirgeier/DockerComposeLabs.git
cd DockerComposeLabs

# 2. Verify Docker Compose is installed
docker compose version

# 3. Start with Lab 1
cd Labs/001-intro
```

---

## Quick Reference: Common Commands

| Command | Description |
|---------|-------------|
| `docker compose up -d` | Start services in detached mode |
| `docker compose down` | Stop and remove containers + networks |
| `docker compose down --volumes` | Also remove named volumes |
| `docker compose ps` | List running containers |
| `docker compose logs -f` | Follow logs from all services |
| `docker compose exec <svc> bash` | Open shell in a running container |
| `docker compose build` | Build or rebuild images |
| `docker compose restart <svc>` | Restart a specific service |
| `docker compose config` | Validate and view the resolved config |
| `docker compose watch` | Start with file watching enabled |

---

## Repository Structure

```
DockerComposeLabs/
+-- Labs/                          # All lab directories
|   +-- 001-intro/                 #   Getting Started
|   +-- 002-Compose-Demo/          #   First Multi-Container App
|   +-- 002-Structure/             #   Compose File Anatomy
|   +-- 003-Commands/              #   CLI Mastery
|   +-- 004-Compose-2Helm/         #   Compose to Helm
|   +-- 005-Compose-Advanced/      #   Modular & DRY Configs
|   +-- 006-Watch/                 #   Live Reload
|   +-- 007-Networks/              #   Network Architecture
|   +-- 008-Advanced/              #   Advanced Topics
|   +-- 009-Fragments/             #   Reusable Fragments
|   +-- 010-Profiles/              #   Environment-Aware Profiles
|   +-- 011-InitContainers/        #   Startup Orchestration
|   +-- 012-VariableSubstitution/  #   Variable Substitution
|   +-- 013-MergeOverride/         #   Merge & Override
|   +-- 014-IntegrationTesting/    #   Integration Testing
|   +-- 015-SecretsConfigs/        #   Secrets & Configs
|   +-- 016-DevWorkflows/          #   Local Dev Workflows
+-- resources/                     # Shared configs and media
|   +-- compose/                   #   Reusable YAML fragments
|   +-- configs/                   #   Prometheus, Loki, Grafana, etc.
|   +-- *.png / *.jpg              #   Images
+-- server/                        # Demo Node.js app
|   +-- Dockerfile
|   +-- server.js
+-- README.md                      # This file
```

---

## Learning Outcomes

By completing all labs, you will be able to:

| Area | Skill |
|------|-------|
| **Fundamentals** | Install, configure, and verify Docker Compose on any platform |
| **Application Design** | Define multi-service apps with networks, volumes, and dependencies |
| **Configuration** | Master every `docker-compose.yml` directive (build, healthcheck, secrets, etc.) |
| **CLI Proficiency** | Manage the full lifecycle: build, run, debug, tear down |
| **Kubernetes** | Package Compose apps as Helm charts for K8s deployment |
| **Advanced Patterns** | Use `extends`, YAML anchors, and external config files |
| **Development Workflow** | Implement live reload with Docker Compose Watch |
| **Network Security** | Design segmented networks with DMZ, isolation, and monitoring |
| **Advanced Topics** | Use profiles, secrets, configs, resource limits, logging drivers, init containers, variable substitution, and the `include:` pattern |
| **Reusable Fragments** | Build modular configs with YAML anchors, aliases, and `extends` |
| **Profile Management** | Control service startup per environment with Docker Compose profiles |
| **Startup Orchestration** | Chain init containers with healthchecks for deterministic startup |
| **Variable Mastery** | Master substitution syntax, defaults, mandatory vars, and env file layering |
| **Multi-File Composing** | Merge and override compose files with correct precedence rules |
| **Integration Testing** | Run test suites in Compose with exit code propagation for CI |
| **Secrets & Configs** | Securely manage sensitive and non-sensitive runtime data |
| **Local Dev Workflows** | Hot reload, DB proxy, CI pipelines, profiles, and multi-stage dev |

---

## Best Practices

- **Version pinning**: Lock service images to specific tags (not `:latest`) in production
- **Health checks**: Always define `healthcheck` for services that depend on each other
- **Network isolation**: Connect services only to the networks they need (least privilege)
- **Volume hygiene**: Use named volumes for data you want to persist; bind mounts for config
- **Environment separation**: Use `.env` files and `--env-file` for different environments
- **Compose Watch**: Use `sync` for code, `rebuild` for dependencies, `restart` for configs

---

**Happy Learning!**