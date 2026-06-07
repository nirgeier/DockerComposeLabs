<!-- header start -->

<a href="https://stackoverflow.com/users/1755598/codewizard"><img src="https://stackoverflow.com/users/flair/1755598.png" width="208" height="58" alt="profile for CodeWizard at Stack Overflow, Q&amp;A for professional and enthusiast programmers" title="profile for CodeWizard at Stack Overflow, Q&amp;A for professional and enthusiast programmers"></a>&emsp;&emsp;[![Linkedin Badge](https://img.shields.io/badge/-nirgeier-blue?style=flat&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/nirgeier/)](https://www.linkedin.com/in/nirgeier/)&emsp;[![Gmail Badge](https://img.shields.io/badge/-nirgeier@gmail.com-fcc624?style=flat&logo=Gmail&logoColor=red&link=mailto:nirgeier@gmail.com)](mailto:nirgeier@gmail.com)&emsp;[![Outlook Badge](https://img.shields.io/badge/-nirg@codewizard.co.il-fcc624?style=flat&logo=microsoftoutlook&logoColor=blue&link=mailto:nirg@codewizard.co.il)](mailto:nirg@codewizard.co.il)

<!-- header end -->

---

# Docker Compose Advanced Topics

- This lab covers **advanced Docker Compose features** that are essential for production-ready deployments.
- Learn about **profiles**, **secrets**, **configs**, **resource constraints**, **logging drivers**, **init containers**, **variable substitution**, and more.
- Each topic includes practical examples and hands-on tasks.

---

![](../../resources/lab.jpg)

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/nirgeier/DockerComposeLabs)

**<kbd>CTRL</kbd> + click to open in new window**

---

# Docker Compose Advanced Topics

This lab explores the advanced features of Docker Compose that transform simple multi-container setups into production-grade, secure, and efficient deployments. You'll learn patterns used in real-world applications to manage complexity, enforce security, and optimize resource usage.

## Description

This lab covers 9 advanced Docker Compose topics, each demonstrated with practical examples and hands-on exercises. The topics range from service profiles to variable substitution, and from security patterns to the modern `include:` feature.

## Prerequisites

- Docker and Docker Compose installed (v2.20+ recommended for `include:` feature)
- Completion of the basic Docker Compose labs (001-003)
- Familiarity with YAML syntax
- Basic Linux command-line skills

---

## What You'll Learn

By the end of this lab, you will be able to:

- [ ] Use **`profiles`** to conditionally enable services
- [ ] Manage **secrets** securely in compose files
- [ ] Use **configs** for external configuration
- [ ] Set **resource constraints** (CPU/memory) per service
- [ ] Configure **logging drivers** for different environments
- [ ] Use **init containers** for startup dependencies
- [ ] Master **variable substitution** with defaults and validation
- [ ] **Merge and override** multiple compose files
- [ ] Use the modern **`include:`** feature to compose modular apps

---

## Table of Contents

1. [Profiles](#1-profiles)
2. [Secrets Management](#2-secrets-management)
3. [Configs](#3-configs)
4. [Resource Constraints](#4-resource-constraints)
5. [Logging Drivers](#5-logging-drivers)
6. [Init Containers](#6-init-containers)
7. [Variable Substitution Deep Dive](#7-variable-substitution-deep-dive)
8. [Merge and Override Multiple Compose Files](#8-merge-and-override-multiple-compose-files)
9. [Include Feature](#9-include-feature)

---

## 1. Profiles

Profiles allow you to define which services start based on the environment or use case. Services with matching `--profile` flags are included.

```yaml
# docker-compose.yml
version: "3.8"
services:
  app:
    image: nginx:alpine
    profiles:
      - dev
      - staging
      - production

  db:
    image: postgres:16-alpine
    profiles:
      - dev
      - staging

  monitoring:
    image: prom/prometheus
    profiles:
      - staging
      - production
      - monitoring

  debug-tool:
    image: busybox
    profiles:
      - debug
    command: sleep 3600
```

### Profile Behavior

| Command | Services Started |
|---------|-----------------|
| `docker compose up` | None (all have profiles) |
| `docker compose --profile dev up` | app, db |
| `docker compose --profile staging up` | app, db, monitoring |
| `docker compose --profile production up` | app, monitoring |
| `docker compose --profile monitoring up` | monitoring |
| `docker compose --profile dev --profile debug up` | app, db, debug-tool |
| `docker compose --profile "*" up` | All services |

!!! tip "Profile Best Practices"
    Use profiles to separate **development**, **staging**, and **production** dependencies. Monitoring and debugging tools should only start when explicitly requested.

### Hands-On Task 1: Profiles

1. Create a `docker-compose.yml` with 4 services: `web`, `db`, `redis`, `monitoring`
2. Assign profiles: `web` → dev/production, `db` → dev/staging/production, `redis` → dev/staging, `monitoring` → staging/production
3. Start only the dev services: `docker compose --profile dev up -d`
4. Verify which services are running: `docker compose ps`
5. Add the monitoring profile: `docker compose --profile dev --profile monitoring up -d`
6. Stop and clean up: `docker compose down`

**Expected Outcome:** You can selectively start subsets of services based on profile flags.

---

## 2. Secrets Management

Docker Compose supports secrets for sensitive data like passwords, API keys, and TLS certificates. Secrets are mounted as files inside containers.

```yaml
# docker-compose.yml
version: "3.8"
services:
  app:
    image: nginx:alpine
    secrets:
      - db_password
      - api_key
    environment:
      DB_PASSWORD_FILE: /run/secrets/db_password
      API_KEY_FILE: /run/secrets/api_key

secrets:
  db_password:
    file: ./secrets/db_password.txt
  api_key:
    file: ./secrets/api_key.txt
```

```bash
# Create the secret files
mkdir -p ./secrets
echo "SuperSecretPassword123!" > ./secrets/db_password.txt
echo "sk-abc123def456" > ./secrets/api_key.txt
```

### Secret Types

| Type | Syntax | Use Case |
|------|--------|----------|
| File-based | `file: ./path/to/secret` | Local development, self-contained |
| External | `external: true` | Production (Docker Swarm, K8s) |
| External with name | `external: true, name: my-secret` | When external name differs |

!!! warning "Security Best Practices"
    - Never commit secret files to version control (add `secrets/` to `.gitignore`)
    - Use external secrets in production (Docker Swarm secrets, HashiCorp Vault)
    - Mount secret files, never pass secrets as environment variables
    - Use `DB_PASSWORD_FILE` pattern instead of `DB_PASSWORD`

### Hands-On Task 2: Secrets

1. Create the `secrets/` directory with `db_password.txt` and `api_key.txt`
2. Write a `docker-compose.yml` with a `postgres` service that uses a secret for `POSTGRES_PASSWORD`
3. Verify the secret is mounted: `docker compose exec postgres cat /run/secrets/db_password`
4. Update the secret value and recreate: `docker compose up -d`
5. Clean up: `docker compose down`

**Expected Outcome:** Secrets are securely mounted as files, not exposed in environment variables.

---

## 3. Configs

Configs allow you to manage non-sensitive configuration files externally, similar to secrets but without encryption.

```yaml
# docker-compose.yml
version: "3.8"
services:
  nginx:
    image: nginx:alpine
    configs:
      - source: nginx_conf
        target: /etc/nginx/conf.d/default.conf
      - source: app_settings
        target: /etc/nginx/app.conf

configs:
  nginx_conf:
    file: ./config/nginx.conf
  app_settings:
    file: ./config/app.json
```

```bash
mkdir -p ./config
cat > ./config/nginx.conf << 'EOF'
server {
    listen 80;
    server_name example.com;
    location / {
        proxy_pass http://app:3000;
    }
}
EOF
```

### Configs vs Volumes

| Aspect | Configs | Bind Mount Volumes |
|--------|---------|-------------------|
| **Purpose** | Static config files | Dynamic data |
| **Update** | Requires service recreation | Live updates |
| **Swarm support** | Native | Manual |
| **Encryption** | No | No |
| **Best for** | Config files that rarely change | Development, live-reload |

### Hands-On Task 3: Configs

1. Create a `config/` directory with `nginx.conf` and `app.json`
2. Write a `docker-compose.yml` with an `nginx` service that mounts both configs
3. Verify the configs are mounted: `docker compose exec nginx cat /etc/nginx/conf.d/default.conf`
4. Modify a config and recreate the service
5. Clean up

**Expected Outcome:** Config files are mounted into the container at specified paths.

---

## 4. Resource Constraints

Docker Compose allows you to limit CPU and memory usage per service using the `deploy.resources` section.

```yaml
# docker-compose.yml
version: "3.8"
services:
  web:
    image: nginx:alpine
    deploy:
      resources:
        limits:
          cpus: "0.5"
          memory: "256M"
        reservations:
          cpus: "0.25"
          memory: "128M"

  heavy-worker:
    image: alpine
    deploy:
      resources:
        limits:
          cpus: "2"
          memory: "1G"
    command: dd if=/dev/zero of=/dev/null bs=1M count=1000
```

### Resource Units

| Unit | Example | Meaning |
|------|---------|---------|
| CPU | `"0.5"` | Half a CPU core |
| CPU | `"2"` | Two full CPU cores |
| Memory | `"128M"` | 128 Megabytes |
| Memory | `"1G"` | 1 Gigabyte |
| Memory | `"512m"` | 512 Megabytes (alternative) |

!!! tip "Resource Planning"
    - `limits`: Hard cap - the container cannot exceed these resources
    - `reservations`: Guaranteed minimum - Docker ensures these resources are available
    - Always set limits to prevent a single service from consuming all host resources
    - Use reservations for critical services that need guaranteed performance

### Hands-On Task 4: Resource Constraints

1. Write a `docker-compose.yml` with two services: `web` (limited) and `stress` (CPU-intensive)
2. Run `docker stats` in another terminal and observe the resource usage
3. Start the stress service: `docker compose up -d stress`
4. Observe that `web` stays within its 0.5 CPU limit while `stress` may consume more
5. Clean up

**Expected Outcome:** Services respect their configured CPU and memory limits.

---

## 5. Logging Drivers

Docker Compose supports multiple logging drivers to control how container logs are collected and stored.

```yaml
# docker-compose.yml
version: "3.8"
services:
  app:
    image: nginx:alpine
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"

  web:
    image: nginx:alpine
    logging:
      driver: "local"
      options:
        max-size: "10m"
        max-file: "3"

# Global logging defaults
x-logging: &default-logging
  logging:
    driver: "json-file"
    options:
      max-size: "10m"
      max-file: "3"
```

### Logging Driver Comparison

| Driver | Description | Best For |
|--------|-------------|----------|
| `json-file` | Default, JSON-formatted logs to disk | Development, small deployments |
| `local` | Efficient binary log storage | Production, less disk I/O |
| `syslog` | Send logs to syslog server | Centralized logging |
| `gelf` | Graylog Extended Log Format | Graylog / ELK stacks |
| `fluentd` | Forward to fluentd | Log aggregation pipelines |
| `awslogs` | Amazon CloudWatch | AWS deployments |
| `gcplogs` | Google Cloud Logging | GCP deployments |
| `none` | Disable logging | Minimal containers, CI |

### Hands-On Task 5: Logging Drivers

1. Create a `docker-compose.yml` with 3 nginx services using different drivers: `json-file`, `local`, and `none`
2. Generate some traffic: `curl http://localhost:8080`
3. Compare log output:
   - `docker compose logs json-svc` → shows formatted JSON logs
   - `docker compose logs local-svc` → shows logs from local driver
   - `docker compose logs none-svc` → no logs (driver: none)
4. Check disk usage: `docker system df`
5. Clean up

**Expected Outcome:** Different logging drivers produce different log formats and storage footprints.

---

## 6. Init Containers

Init containers run to completion before the main service starts, ideal for database migrations, schema setup, or waiting for dependencies.

```yaml
# docker-compose.yml
version: "3.8"
services:
  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: myapp
      POSTGRES_PASSWORD: secret
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 5s
      retries: 10

  app:
    image: nginx:alpine
    depends_on:
      app-init:
        condition: service_completed_successfully
      db:
        condition: service_healthy
    ports:
      - "8080:80"

  app-init:
    image: busybox:1.36
    command: >
      sh -c "echo 'Running migrations...' && sleep 5 && echo 'Migrations complete!'"
    depends_on:
      db:
        condition: service_healthy
```

### Init Container Patterns

| Pattern | Command | Use Case |
|---------|---------|----------|
| Wait for DB | `until nc -z db 5432; do sleep 2; done` | Block until database is ready |
| Run migrations | `npm run migrate` | Apply database schema changes |
| Seed data | `psql -h db -U user -d myapp -f /seed.sql` | Populate initial data |
| Create directories | `mkdir -p /data/uploads /data/cache` | Prepare shared volumes |
| Validate config | `nginx -t` | Verify configuration before starting |

!!! tip "depends_on Conditions"
    - `service_started` (default) - waits for container to start
    - `service_healthy` - waits for healthcheck to pass
    - `service_completed_successfully` - waits for container to exit with code 0

### Hands-On Task 6: Init Containers

1. Write a `docker-compose.yml` with: `db` (postgres with healthcheck), `db-migrate` (init container that depends on healthy db), and `app` (depends on completed migration)
2. Start: `docker compose up -d`
3. Verify startup order: `docker compose logs db-migrate`
4. Check that `app` only starts after `db-migrate` completes
5. Clean up

**Expected Outcome:** Services start in the correct order: db → db-migrate → app.

---

## 7. Variable Substitution Deep Dive

Docker Compose supports powerful variable substitution in YAML files.

```yaml
# docker-compose.yml
version: "3.8"
services:
  app:
    image: ${IMAGE_NAME:-nginx:alpine}
    ports:
      - "${APP_PORT:-8080}:80"
    environment:
      - ENV_NAME=${ENV_NAME:-development}
      - DB_URL=${DB_URL:?error: DB_URL is required}
      - LOG_LEVEL=${LOG_LEVEL:-info}
      - ESCAPED_DOLLAR=$${not_a_variable}
```

```bash
# Variable precedence (lowest to highest):
# 1. Shell environment variables
# 2. .env file in project directory
# 3. --env-file flag
# 4. environment: section in compose file
```

### Variable Substitution Syntax

| Syntax | Behavior | Example |
|--------|----------|---------|
| `$VAR` or `${VAR}` | Substitute value | `image: ${IMAGE}` |
| `${VAR:-default}` | Use default if unset or empty | `port: ${PORT:-8080}` |
| `${VAR-default}` | Use default only if unset | `tag: ${VERSION-latest}` |
| `${VAR:?error}` | Fail with error if unset or empty | `db: ${DB_NAME:?DB_NAME required}` |
| `${VAR?error}` | Fail with error only if unset | `api: ${API_KEY?Missing key}` |
| `$$` | Escape to literal `$` | `config: $${DOLLAR}` |

### .env File Resolution Order

```
Project root (.env)          ← Lowest priority
  └── --env-file FILE        ← Explicit env file
       └── Shell env vars    ← From the current shell
            └── compose file environment: section  ← Highest priority
```

### Hands-On Task 7: Variable Substitution

1. Create a `.env` file with: `APP_PORT=9090`, `LOG_LEVEL=debug`
2. Write a `docker-compose.yml` using `${APP_PORT:-8080}`, `${LOG_LEVEL:-info}`, and `${DB_URL:?error}`
3. Start without `DB_URL` set → should fail with error message
4. Set `DB_URL=postgres://localhost:5432/mydb` and retry
5. Override with shell: `APP_PORT=7070 docker compose up -d`
6. Verify the port: `docker compose port app 80`
7. Clean up

**Expected Outcome:** Variable substitution works with defaults, required variables, and shell overrides.

---

## 8. Merge and Override Multiple Compose Files

Docker Compose allows you to split configurations across multiple files and merge them.

```yaml
# docker-compose.yml (base)
version: "3.8"
services:
  app:
    image: nginx:alpine
    ports:
      - "80:80"
    environment:
      - ENV=production

  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: myapp
```

```yaml
# docker-compose.override.yml (dev overrides)
services:
  app:
    ports:
      - "8080:80"
    environment:
      - ENV=development
    volumes:
      - ./src:/usr/share/nginx/html

  db:
    environment:
      POSTGRES_PASSWORD: devpassword
    ports:
      - "5432:5432"
```

```yaml
# docker-compose.prod.yml (production additions)
services:
  app:
    restart: always
    deploy:
      resources:
        limits:
          memory: "512M"

  db:
    restart: always
    volumes:
      - db_data:/var/lib/postgresql/data

volumes:
  db_data:
```

### Merge Rules

| Element | Behavior |
|---------|----------|
| **Scalars** (strings, numbers) | Later file wins |
| **Lists** (ports, env, volumes) | Replaced entirely (not merged) |
| **Maps** (services, labels, deploy) | Deep merged (nested keys merged) |
| **New keys** | Added to the final configuration |

```bash
# Usage patterns
docker compose up -d                          # Uses docker-compose.yml + docker-compose.override.yml
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d   # Custom merge
docker compose -f docker-compose.yml -f docker-compose.prod.yml -p myapp up -d  # With project name
```

!!! tip "Override Patterns"
    - `docker-compose.override.yml` is **automatically loaded** (do not commit to git - add to `.gitignore`)
    - Use a separate file for production overrides and pass it explicitly with `-f`
    - The `-p` flag sets the project name (affects container/network naming)

### Hands-On Task 8: Merge Files

1. Create `docker-compose.yml` (base: app + db)
2. Create `docker-compose.override.yml` (dev: add volumes, change ports)
3. Start: `docker compose up -d` → automatically uses override
4. Verify: `docker compose config` shows merged config
5. Now start without override: `docker compose -f docker-compose.yml up -d`
6. Compare: `docker compose ps` shows different ports
7. Create `docker-compose.prod.yml` and merge all three: `docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d`
8. Clean up

**Expected Outcome:** Multiple compose files merge together, with later files taking precedence.

---

## 9. Include Feature

The `include:` feature (Docker Compose v2.20+) allows you to compose applications from separate compose files, similar to `extends:` but more powerful.

```yaml
# docker-compose.yml
include:
  - path: ./web/docker-compose.yml
  - path: ./api/docker-compose.yml
  - path: ./db/docker-compose.yml

services:
  proxy:
    image: nginx:alpine
    ports:
      - "80:80"
    depends_on:
      web:
        condition: service_started
```

```yaml
# ./web/docker-compose.yml
services:
  web:
    image: nginx:alpine
    ports:
      - "8080:80"
```

```yaml
# ./api/docker-compose.yml
services:
  api:
    image: node:20-alpine
    command: node server.js
```

```yaml
# ./db/docker-compose.yml
services:
  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_PASSWORD: secret
```

### Include vs Extends

| Feature | `include:` | `extends:` |
|---------|-----------|------------|
| **Introduced** | v2.20+ | v1.x (legacy) |
| **Scope** | Includes entire files | Extends a single service |
| **Networks** | Auto-connected | Manual configuration |
| **Variables** | Shared `.env` | Separate env files |
| **Future** | Modern approach | Deprecated (still works) |

!!! tip "When to Use Each"
    - Use `include:` when you want to **compose independent microservices** into a larger app
    - Use `extends:` when you want to **reuse service definitions** across projects
    - `include:` auto-connects services on the same network; `extends:` does not

### Hands-On Task 9: Include

1. Create directory structure:

   ```
   ├── docker-compose.yml (main, uses include)
   ├── web/docker-compose.yml
   ├── api/docker-compose.yml
   └── db/docker-compose.yml
   ```

2. Each sub-compose file defines one service with basic configuration
3. The main file includes all three and adds a proxy service
4. Start: `docker compose up -d`
5. Verify all services are running: `docker compose ps`
6. Test cross-service connectivity: `docker compose exec proxy curl http://web:8080`
7. Clean up

**Expected Outcome:** Services from included files are composed together, with automatic network connectivity.

---

## Hands-On Tasks Summary

| # | Task | Topic | Est. Time |
|---|------|-------|-----------|
| 1 | Profile-based service selection | Profiles | 10 min |
| 2 | Secret file creation and mounting | Secrets | 10 min |
| 3 | External config file management | Configs | 10 min |
| 4 | CPU and memory limit testing | Resource Constraints | 15 min |
| 5 | Logging driver comparison | Logging Drivers | 10 min |
| 6 | Init container for DB migrations | Init Containers | 15 min |
| 7 | Variable substitution with defaults | Variable Substitution | 10 min |
| 8 | Multi-file compose merge | Merge/Override | 15 min |
| 9 | Modular app with include: | Include Feature | 15 min |

---

## Verification Checklist

- [ ] Profiles control which services start based on environment
- [ ] Secrets are mounted as files, not exposed in env vars
- [ ] Configs provide external configuration without encryption overhead
- [ ] Resource constraints limit CPU and memory per service
- [ ] Different logging drivers produce different output formats
- [ ] Init containers run to completion before dependent services start
- [ ] Variable substitution supports defaults and required variables
- [ ] Multiple compose files merge with the correct precedence
- [ ] Included compose files create a unified application

---

## Additional Resources

- [Docker Compose Profiles Documentation](https://docs.docker.com/compose/profiles/)
- [Docker Compose Secrets Documentation](https://docs.docker.com/compose/use-secrets/)
- [Docker Compose Configs Documentation](https://docs.docker.com/compose/configs/)
- [Docker Compose Resource Constraints](https://docs.docker.com/compose/compose-file/deploy/#resources)
- [Docker Compose Logging Drivers](https://docs.docker.com/compose/compose-file/compose-file-v3/#logging)
- [Docker Compose Include Reference](https://docs.docker.com/compose/multiple-compose-files/include/)
- [Docker Compose Variable Substitution](https://docs.docker.com/compose/compose-file/compose-file-v3/#variable-substitution)

---

## Cleanup

```bash
# Stop and remove all containers, networks, and volumes
docker compose down --volumes --remove-orphans

# Remove any created directories
rm -rf ./secrets ./config ./web ./api ./db
```


