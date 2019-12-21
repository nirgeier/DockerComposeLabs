<!-- omit in toc -->
# Writing a Simple (Yet Comprehensive) `docker-compose.yml`

<!-- omit in toc -->
## Basic Docker Compose Command Guide

- This lab will walk you through creating a basic `docker-compose.yml` file, focusing on the most common features that allow you to easily define and manage complex multi-container application environments.
-
<!-- omit in toc -->
### Table of Contents

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

## Docker Compose Commands

- `docker compose` is the command-line interface for Docker Compose.
- It allows you to manage multi-container Docker applications defined in a `docker-compose.yml` file.
- Here are some of the most commonly used commands:

| Command                     | Explanation                                                                 |
|-----------------------------|-----------------------------------------------------------------------------|
| `docker compose up`         | Builds, (re)creates, starts, and attaches to containers for a service.      |
| `docker compose down`       | Stops containers and removes containers, networks, volumes, and images.     |
| `docker compose build`      | Builds or rebuilds services.                                                |
| `docker compose ps`         | Lists containers.                                                           |
| `docker compose logs`       | Displays log output from services.                                          |
| `docker compose exec`       | Executes a command in a running container.                                  |
| `docker compose pull`       | Pulls service images.                                                       |
| `docker compose restart`    | Restarts services.                                                          |
| `docker compose stop`       | Stops running containers without removing them.                             |
| `docker compose start`      | Starts existing containers for a service.                                   |

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
