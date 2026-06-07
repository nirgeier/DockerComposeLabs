![](../../resources/logos.png)

---

# 🚀 Docker Compose Introduction

## 1. Overview

- Welcome to the Docker Compose Hands-on Labs!
- This introductory lab will guide you through the fundamentals of Docker Compose, its key features, and benefits.
- This lab is designed for beginners and those new to Docker Compose.

#### What is Docker Compose?

Docker Compose is a powerful tool for defining and running multi-container Docker applications. Instead of managing containers individually with complex `docker run` commands, Docker Compose lets you:

- Define your entire application stack in a single `docker-compose.yml` file
- Configure services, networks, and volumes declaratively using YAML
- Start, stop, and manage all containers with simple commands
- Share your application configuration easily across teams
- Ensure consistency across development, testing, and production environments

#### Why Docker Compose?

!!! example "Real-World Application Stack"

    Imagine running a web application that requires:

    - 🌐 A web server (Nginx)
    - ⚙️ An application backend (Node.js, Python, etc.)
    - 🗄️ A database (PostgreSQL, MySQL)
    - ⚡ A cache layer (Redis)

    #### Approaches to manage this stack:

    | Approach            | Reality                                                                  |
    |---------------------|--------------------------------------------------------------------------|
    | **With Docker**     | Multiple `docker run` commands, manual networking, dependency management |
    | **Without Compose** | Multiple terminal windows, complex docker commands                       |
    | **With Compose**    | Define once, run with: `docker compose up`                               |

## 2. Key Features & Benefits

| Feature                        | Benefit                                                  |
| ------------------------------ | -------------------------------------------------------- |
| **Single Configuration File**  | Define all services in one `docker-compose.yml` file     |
| **Multi-Container Management** | Start/stop entire application stacks with one command    |
| **Service Dependencies**       | Automatically manage startup order and dependencies      |
| **Network Isolation**          | Built-in networking between services with DNS resolution |
| **Volume Management**          | Persist data and share files between containers          |
| **Environment Variables**      | Easily configure services for different environments     |
| **Scaling Capabilities**       | Scale services up or down with simple commands           |
| **Development Workflow**       | Hot reload, file watching, and rapid iteration           |
| **Reproducibility**            | Same environment everywhere - dev, test, production      |

---

## 3. Prerequisites

- Before starting this lab, ensure you have:

* [ ] **Basic Docker Knowledge**: Understanding of containers, images, and basic Docker commands
* [ ] **Docker Installed**: Docker Engine or Docker Desktop installed on your system
* [ ] **Command Line Familiarity**: Comfortable using terminal/command prompt
* [ ] **Text Editor**: Any text editor for editing YAML files (VS Code, Vim, Nano, etc.)

---

## 4. Installation

=== "🪟 Windows & macOS"

    **✨ Good News!** If you're using Docker Desktop, Docker Compose is already included!

    Docker Desktop for Windows and macOS comes with Docker Compose pre-installed. No additional setup required.

    **Installation Steps:**

    1. Download Docker Desktop from [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
    2. Install Docker Desktop following the installation wizard
    3. Start Docker Desktop
    4. Verify installation (see section below)

=== "🐧 Linux"

    For Linux users, Docker Compose needs to be installed separately. Choose one of the following methods:

    **Method 1: Using Package Manager (Recommended for Ubuntu/Debian)**

    ```bash
    # Update package index
    sudo apt-get update

    # Install Docker Compose
    sudo apt-get install docker-compose-plugin

    # Alternative for older systems
    sudo apt-get install docker-compose
    ```

    **Method 2: Manual Installation from GitHub**

    ```bash
    # Download the latest version
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

    # Make it executable
    sudo chmod +x /usr/local/bin/docker-compose

    # Create symbolic link (optional, for docker-compose command)
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    ```

    **Method 3: Using pip (Python)**

    ```bash
    # Install using Python pip
    pip install docker-compose
    ```

=== "🍺 macOS (Homebrew)"

    If you prefer Homebrew over Docker Desktop:

    ```bash
    # Install Docker Compose using Homebrew
    brew install docker-compose

    # Check the installation
    brew info docker-compose
    ```

    **Note:** After Homebrew installation, configure Docker to recognize the plugin:

    Add to `~/.docker/config.json`:

    ```json
    {
      "cliPluginsExtraDirs": ["/opt/homebrew/lib/docker/cli-plugins"]
    }
    ```

### 4.1 Verify Installation

- After installation, verify Docker Compose is working:

```bash
# Modern Docker Compose (V2) - Recommended
docker compose version

# Output example:
# Docker Compose version v2.36.0

# Legacy Docker Compose (V1) - Still supported
docker-compose --version

# Output example:
# docker-compose version 1.29.2, build 5becea4c
```

**Test with a simple command:**

```bash
# Check available commands
docker compose --help
```

---

## 5. Common Commands Reference

- Here's a comprehensive reference of Docker Compose commands you'll use regularly:

### 5.1 Core Commands

| Command                  | Description                                       | Common Usage             |
| ------------------------ | ------------------------------------------------- | ------------------------ |
| `docker compose up`      | Create and start all services                     | `docker compose up`      |
| `docker compose up -d`   | Start services in detached (background) mode      | `docker compose up -d`   |
| `docker compose down`    | Stop and remove containers, networks              | `docker compose down`    |
| `docker compose down -v` | Stop and remove containers, networks, and volumes | `docker compose down -v` |
| `docker compose start`   | Start existing stopped services                   | `docker compose start`   |
| `docker compose stop`    | Stop running services without removing            | `docker compose stop`    |
| `docker compose restart` | Restart services                                  | `docker compose restart` |
| `docker compose pause`   | Pause running services                            | `docker compose pause`   |
| `docker compose unpause` | Unpause services                                  | `docker compose unpause` |

### 5.2 Build & Image Management

| Command                           | Description                       | Common Usage                      |
| --------------------------------- | --------------------------------- | --------------------------------- |
| `docker compose build`            | Build or rebuild service images   | `docker compose build`            |
| `docker compose build --no-cache` | Build without using cache         | `docker compose build --no-cache` |
| `docker compose pull`             | Pull service images from registry | `docker compose pull`             |
| `docker compose push`             | Push service images to registry   | `docker compose push`             |

### 5.3 Monitoring & Debugging

| Command                          | Description                      | Common Usage                    |
| -------------------------------- | -------------------------------- | ------------------------------- |
| `docker compose ps`              | List containers and their status | `docker compose ps`             |
| `docker compose logs`            | View output from all services    | `docker compose logs`           |
| `docker compose logs -f`         | Follow log output (live tail)    | `docker compose logs -f app`    |
| `docker compose logs --tail=100` | Show last N lines of logs        | `docker compose logs --tail=50` |
| `docker compose top`             | Display running processes        | `docker compose top`            |
| `docker compose events`          | Receive real-time events         | `docker compose events`         |

### 5.4 Service Management

| Command                | Description                          | Common Usage                      |
| ---------------------- | ------------------------------------ | --------------------------------- |
| `docker compose exec`  | Execute command in running container | `docker compose exec web bash`    |
| `docker compose run`   | Run one-off command in new container | `docker compose run app npm test` |
| `docker compose scale` | Scale services to specified number   | `docker compose scale web=3`      |
| `docker compose port`  | Print public port for a port binding | `docker compose port web 80`      |

### 5.5 Configuration & Validation

| Command                            | Description                              | Common Usage                       |
| ---------------------------------- | ---------------------------------------- | ---------------------------------- |
| `docker compose config`            | Validate and view composed configuration | `docker compose config`            |
| `docker compose config --services` | List all services in compose file        | `docker compose config --services` |
| `docker compose version`           | Show Docker Compose version              | `docker compose version`           |

### 5.6 Advanced Operations

| Command                 | Description                                        | Common Usage                            |
| ----------------------- | -------------------------------------------------- | --------------------------------------- |
| `docker compose cp`     | Copy files between service and local filesystem    | `docker compose cp web:/app/file.txt .` |
| `docker compose create` | Create containers without starting                 | `docker compose create`                 |
| `docker compose kill`   | Force stop service containers                      | `docker compose kill`                   |
| `docker compose rm`     | Remove stopped service containers                  | `docker compose rm`                     |
| `docker compose watch`  | Watch build context and rebuild/refresh containers | `docker compose watch`                  |

---

### 5.7 Examples

```bash
# Start fresh - remove everything and rebuild
docker compose down -v && docker compose up --build

# View logs from specific service
docker compose logs -f service_name

# Execute interactive shell in running container
docker compose exec service_name /bin/bash
docker compose exec service_name sh

# Run database migrations
docker compose exec app python manage.py migrate

# Check resource usage
docker compose stats

# View differences in configuration
docker compose config --resolve-image-digests
```

---

## 6. Your First Steps

- Now that you have Docker Compose installed, let's understand the basic workflow:

### 6.1 Project Directory

- Create a new directory for your Docker Compose project and navigate into it:
  ```bash
  # Create and navigate to your project directory
  mkdir my-first-compose
  cd my-first-compose
  ```

### 6.2 docker-compose.yml

- This is the heart of Docker Compose. Here's a simple example:
- Save this content in a file named `docker-compose.yml` inside your project directory.
  ```yaml
  version: "3.8"
  services:
    web:
      image: nginx:latest
      ports:
        - "8080:80"
  ```

### 6.3 Start Your Application

- Start your services using the following command:
  ```bash
  # Start the services
  docker compose up
  ```

### 6.4 View Running Services

- Verify everything is running smoothly:

      ```bash
      # In another terminal, check status
      docker compose ps

      # View logs
      docker compose logs

      # Access the application
      # Open browser: http://localhost:8080
      ```

### 6.5 Clean Up

- Stop Your Application

      ```bash
      # Stop and remove containers
      docker compose down
      ```

**🎉 Congratulations!** You've just run your first Docker Compose application!

---

## 7. What will we cover?

- Throughout this Docker Compose labs series, you'll master:

### 📚 Fundamentals

- Creating and structuring `docker-compose.yml` files
- Defining services, networks, and volumes
- Understanding YAML syntax and best practices

### 🏗️ Service Configuration

- Building custom images
- Setting environment variables
- Configuring health checks
- Managing dependencies between services

### 🌐 Networking

- Default bridge networks
- Custom network creation
- Service discovery and DNS
- Network isolation patterns

### 💾 Data Management

- Named volumes vs bind mounts
- Persisting data across container restarts
- Sharing data between services

### 🚀 Advanced Features

- Multi-stage builds
- Scaling services
- Using profiles for different environments
- Docker Compose Watch for development
- Converting to Kubernetes (Helm)

### 🔧 Production Readiness

- Environment-specific configurations
- Security best practices
- Monitoring and logging
- CI/CD integration

### 🛠️ Fragments

- Reusable configuration snippets
- Using `extends` and YAML anchors
- Modularizing large Compose files
- Managing complex applications
- Debugging and troubleshooting tips
- Performance optimization strategies
- Real-world case studies and examples

---

## 8. Next Steps

#### Before moving to the next lab, ensure you can:

- [ ] Execute `docker compose version` successfully
- [ ] Understand what Docker Compose does
- [ ] Know the basic commands (up, down, ps, logs)
- [ ] Have a text editor ready for YAML files
