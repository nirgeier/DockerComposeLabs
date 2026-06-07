![](../../resources/logos.png)

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/nirgeier/DockerComposeLabs)

---

# Docker Compose Commands - Essential CLI Reference

## Description

This lab provides a comprehensive guide to Docker Compose command-line interface. You'll master all the essential commands needed to manage multi-container applications effectively, from basic startup and shutdown to advanced debugging and maintenance operations.

## Prerequisites

- Completion of previous labs (001-intro, 002-Compose-Demo, 002-Structure)
- Docker and Docker Compose installed
- Basic understanding of Docker Compose file structure

## Lab Overview

This comprehensive command guide covers the Docker Compose CLI, focusing on the most common and powerful commands that allow you to easily manage complex multi-container application environments.

## Table of Contents

- [Docker Compose Commands - Essential CLI Reference](#docker-compose-commands---essential-cli-reference)
  - [Description](#description)
  - [Prerequisites](#prerequisites)
  - [Lab Overview](#lab-overview)
  - [Table of Contents](#table-of-contents)
  - [Docker Compose Commands](#docker-compose-commands)
  - [Command Examples](#command-examples)
    - [Explanation and Examples for Commands](#explanation-and-examples-for-commands)
      - [`docker compose up`](#docker-compose-up)
      - [`docker compose down`](#docker-compose-down)
      - [`docker compose build`](#docker-compose-build)
      - [`docker compose ps`](#docker-compose-ps)
      - [`docker compose logs`](#docker-compose-logs)
      - [`docker compose exec`](#docker-compose-exec)
      - [`docker compose pull`](#docker-compose-pull)
      - [`docker compose restart`](#docker-compose-restart)
      - [`docker compose stop`](#docker-compose-stop)
      - [`docker compose start`](#docker-compose-start)
  - [Command Categories and Use Cases](#command-categories-and-use-cases)
    - [Development Workflow Commands](#development-workflow-commands)
    - [Build and Update Commands](#build-and-update-commands)
    - [Maintenance Commands](#maintenance-commands)
  - [Advanced Command Options](#advanced-command-options)
    - [Common Flags and Options](#common-flags-and-options)
    - [Examples with Advanced Options](#examples-with-advanced-options)
  - [Troubleshooting Commands](#troubleshooting-commands)
    - [Debugging Issues](#debugging-issues)
  - [Key Learning Outcomes](#key-learning-outcomes)
  - [Best Practices](#best-practices)

## Docker Compose Commands

- `docker compose` is the command-line interface for Docker Compose.
- It allows you to manage multi-container Docker applications defined in a `docker-compose.yml` file.
- Here are some of the most commonly used commands:

| Command                  | Explanation                                                             |
| ------------------------ | ----------------------------------------------------------------------- |
| `docker compose up`      | Builds, (re)creates, starts, and attaches to containers for a service.  |
| `docker compose down`    | Stops containers and removes containers, networks, volumes, and images. |
| `docker compose build`   | Builds or rebuilds services.                                            |
| `docker compose ps`      | Lists containers.                                                       |
| `docker compose logs`    | Displays log output from services.                                      |
| `docker compose exec`    | Executes a command in a running container.                              |
| `docker compose pull`    | Pulls service images.                                                   |
| `docker compose restart` | Restarts services.                                                      |
| `docker compose stop`    | Stops running containers without removing them.                         |
| `docker compose start`   | Starts existing containers for a service.                               |

---

## Command Examples

### Explanation and Examples for Commands

#### `docker compose up`

- **Explanation**: Builds, (re)creates, starts, and attaches to containers for a service.
- **Example**:

  ```bash
  # Start the application defined in docker-compose.yml
  # -d = Runs the containers in detached mode.
  docker compose up -d
  ```

#### `docker compose down`

- **Explanation**: Stops containers and removes containers, networks, volumes, and images created by `up`.
- **Example**:

  ```bash
  # Stops and removes containers along with associated volumes.
  docker compose down --volumes
  ```

#### `docker compose build`

- **Explanation**: Builds or rebuilds services defined in the `docker-compose.yml` file.
- **Example**:

  ```bash
  # Builds all services.
  docker compose build
  ```

#### `docker compose ps`

- **Explanation**: Lists containers for the application defined in the `docker-compose.yml` file.
- **Example**:

  ```bash
  # Displays the status of all containers.
  docker compose ps
  ```

#### `docker compose logs`

- **Explanation**: Displays log output from services.
- **Example**:

  ```sh
  # Follows the logs of all running services.
  docker compose logs -f
  ```

#### `docker compose exec`

- **Explanation**: Executes a command in a running container.
- **Example**:

  ```sh
  # Opens a bash shell in the `web` service container.
  docker compose exec web bash
  ```

#### `docker compose pull`

- **Explanation**: Pulls service images defined in the `docker-compose.yml` file.
- **Example**:

  ```bash
  # Pulls the latest images for all services.
  docker compose pull
  ```

#### `docker compose restart`

- **Explanation**: Restarts services.
- **Example**:

  ```bash
  # Restarts the `web` service.
  docker compose restart web
  ```

#### `docker compose stop`

- **Explanation**: Stops running containers without removing them.
- **Example**:

  ```bash
  # Stops all running containers.
  docker compose stop
  ```

#### `docker compose start`

- **Explanation**: Starts existing containers for a service.
- **Example**:

  ```bash
  # Starts the `web` service container.
  docker compose start web
  ```

---

## Command Categories and Use Cases

### Development Workflow Commands

- **`docker compose up -d`**: Start development environment in background
- **`docker compose logs -f [service]`**: Monitor application logs during development
- **`docker compose exec [service] bash`**: Debug issues by accessing container shell
- **`docker compose down`**: Clean shutdown of development environment

### Build and Update Commands

- **`docker compose build`**: Rebuild images after code changes
- **`docker compose pull`**: Update to latest base images
- **`docker compose up --build`**: Rebuild and restart in one command

### Maintenance Commands

- **`docker compose ps`**: Check service status and health
- **`docker compose restart [service]`**: Restart specific problematic services
- **`docker compose stop/start`**: Pause and resume without losing data

## Advanced Command Options

### Common Flags and Options

- **`-f, --file`**: Specify custom compose file name
- **`-p, --project-name`**: Override project name
- **`--env-file`**: Specify environment file
- **`--profile`**: Activate specific service profiles

### Examples with Advanced Options

```bash
# Use custom compose file
docker compose -f docker-compose.prod.yml up -d

# Set custom project name
docker compose -p myproject up -d

# Use specific environment file
docker compose --env-file .env.production up -d
```

## Troubleshooting Commands

### Debugging Issues

```bash
# View detailed container information
docker compose ps -a

# Check logs for specific service
docker compose logs web

# Follow logs in real-time
docker compose logs -f --tail=50

# Inspect container configuration
docker compose config

# View resource usage
docker compose top
```

## Key Learning Outcomes

After mastering these commands, you'll be able to:

- **Manage Application Lifecycle**: Start, stop, and restart multi-container applications efficiently
- **Debug and Monitor**: Access logs, execute commands, and troubleshoot issues in running containers
- **Development Workflow**: Integrate Docker Compose into your daily development routine
- **Build Management**: Handle image building and updates effectively
- **Production Operations**: Perform maintenance and updates on running applications

## Best Practices

- **Use detached mode (`-d`)** for long-running services
- **Follow logs regularly** to monitor application health
- **Clean up resources** with `docker compose down` when done
- **Use specific service names** for targeted operations
- **Combine commands** for efficient workflows (e.g., `up --build`)

---

## Hands-On Tasks

### Task 1: Application Lifecycle

Practice the full lifecycle of a multi-service application using the `docker-compose-sample.yml` from `Labs/002-Compose-Demo/`.

```bash
# Copy the sample compose file to this lab
cp ../002-Compose-Demo/docker-compose-sample.yml docker-compose.yml

# 1. Start all services
docker compose up -d

# 2. Verify all services are running
docker compose ps

# 3. View the resolved configuration
docker compose config

# 4. Stop all services (without removing)
docker compose stop

# 5. Verify stopped status
docker compose ps

# 6. Restart all services
docker compose start

# 7. Full cleanup
docker compose down --volumes
```

**Expected Outcome:** You can manage the full container lifecycle: start → verify → stop → restart → clean up.

---

### Task 2: Logs and Debugging

Practice monitoring and debugging using Docker Compose commands.

```bash
# 1. Start the sample application
docker compose up -d

# 2. Follow all logs (Ctrl+C to exit)
docker compose logs -f

# 3. View last 20 lines for a specific service
docker compose logs --tail=20 web

# 4. Execute a command in a running container
docker compose exec db psql -U postgres -c "SELECT 1 as test;"

# 5. Enter a shell in the web container
docker compose exec web sh

# 6. View running processes inside containers
docker compose top

# 7. Clean up
docker compose down
```

**Expected Outcome:** You can access logs, execute commands inside containers, and inspect processes.

---

### Task 3: Build and Update

Practice rebuilding services and updating images.

```bash
# 1. Start services
docker compose up -d

# 2. Build without starting (if Dockerfile exists)
docker compose build

# 3. Rebuild and start in one command
docker compose up --build -d

# 4. Pull latest images for all services
docker compose pull

# 5. Restart a specific service
docker compose restart web

# 6. Clean up
docker compose down
```

**Expected Outcome:** You can rebuild, pull updates, and restart specific services without affecting others.

---

### Task 4: Advanced Flags

Practice using advanced Docker Compose flags.

```bash
# 1. Start with a custom project name
docker compose -p myapp up -d

# 2. Verify the project name in container names
docker compose -p myapp ps

# 3. Use a custom compose file
docker compose -f docker-compose.yml up -d

# 4. Use both custom file and project name
docker compose -f docker-compose.yml -p custom-app up -d

# 5. Use an environment file
echo "APP_PORT=9090" > .env
docker compose --env-file .env up -d

# 6. Clean up all projects
docker compose -p myapp down
docker compose -p custom-app down
docker compose down
rm -f .env
```

**Expected Outcome:** You can control project naming, file selection, and environment configuration via flags.

---

### Task 5: Troubleshooting Scenarios

Practice diagnosing common issues.

```bash
# Scenario A: Port conflict
# 1. Start the application
docker compose up -d

# 2. Try to start another container on the same port
docker run -d --rm -p 80:80 nginx:alpine || echo "Port conflict detected!"

# 3. Check logs for the failing service
docker compose logs

# 4. Stop the conflicting container and restart
docker compose down

# Scenario B: Inspect config
# 1. Check the resolved configuration for errors
docker compose config

# 2. View the config in JSON format
docker compose config --format json

# 3. Check which images are in use
docker compose images

# 4. Clean up
docker compose down --volumes --remove-orphans
```

**Expected Outcome:** You can diagnose port conflicts, inspect configuration, and clean up orphaned resources.

---

## Verification Checklist

- [ ] I can start and stop all services with `up` / `down` / `stop` / `start`
- [ ] I can view logs with `logs -f --tail=N`
- [ ] I can execute commands inside containers with `exec`
- [ ] I can rebuild services with `build` and `up --build`
- [ ] I can pull latest images with `pull`
- [ ] I can use advanced flags: `-f`, `-p`, `--env-file`
- [ ] I can inspect configuration with `config` and processes with `top`
- [ ] I can clean up resources with `down --volumes --remove-orphans`

---

## Navigation <!-- omit in toc -->

[← Previous: 002-Structure](../002-Structure/README.md) | [Next: 004-Compose-2Helm →](../004-Compose-2Helm/README.md)
