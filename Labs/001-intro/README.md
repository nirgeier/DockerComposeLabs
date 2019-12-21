![](../../resources/logos.png)

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/nirgeier/DockerComposeLabs)

### **<kbd>CTRL</kbd> + click to open in new window**

---

<!-- omit in toc -->
## Table of Contents

- [Docker Compose Introduction](#docker-compose-introduction)
  - [Description](#description)
  - [Prerequisites](#prerequisites)
  - [What You'll Learn](#what-youll-learn)
  - [Key Concepts Covered](#key-concepts-covered)
  - [Installation Methods](#installation-methods)
  - [Quick Start](#quick-start)
  - [1. What is Docker Compose?](#1-what-is-docker-compose)
  - [2. Installing Docker Compose](#2-installing-docker-compose)
    - [2.1. Docker-Desktop for Windows and macOS](#21-docker-desktop-for-windows-and-macos)
    - [2.2. Linux](#22-linux)
    - [2.3. Install on MacOS using Homebrew](#23-install-on-macos-using-homebrew)

# Docker Compose Introduction

## Description

- This lab provides a comprehensive introduction to Docker Compose, a tool for defining and running multi-container Docker applications.
- You'll learn the fundamentals of Docker Compose and how to set it up on different operating systems.

## Prerequisites

- Basic understanding of Docker concepts
- Docker installed on your system

## What You'll Learn

- What Docker Compose is and its benefits
- How to install Docker Compose on different platforms
- Basic concepts of multi-container orchestration

## Key Concepts Covered

- **Multi-container Applications**: Understanding how Docker Compose simplifies managing multiple containers
- **YAML Configuration**: Introduction to the docker-compose.yml file structure
- **Service Orchestration**: How containers work together in a composed application
- **Development Workflow**: Using Docker Compose for local development environments

## Installation Methods

1. **Docker Desktop** (Windows/macOS): Included by default
2. **Linux Package Managers**: Using apt-get or yum
3. **Manual Installation**: Downloading from GitHub releases
4. **Homebrew** (macOS): Using the brew package manager

## Quick Start

After completing this lab, you'll be ready to:

- Create your first docker-compose.yml file
- Understand service definitions
- Manage multi-container applications
- Move on to more advanced Docker Compose features

---

## 1. What is Docker Compose?

- Docker Compose is a :wrench: tool for defining and :running: running multi-container `Docker` applications.
- With `Docker Compose`, you use a `YAML` file to configure your application's services.
- Then, with a simple command(s), you create and start all the services from your configuration.
- This greatly simplifies the development, testing, and deployment of complex applications.
- It allows you to define the services, networks, and volumes your application needs in a single file (`docker-compose.yml`), making it easy to manage and share your application setup.
- Docker Compose is particularly useful for local development, `CI/CD pipelines`, and orchestrating **multi-container** applications.

## 2. Installing Docker Compose

### 2.1. Docker-Desktop for Windows and macOS

- If you are using Docker Desktop for Windows or macOS, Docker Compose is included by default.

### 2.2. Linux

- If you are using Linux, you might need to install it separately.
- Please refer to the official Docker documentation for installation instructions: [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)
- You can install it using the official Docker Compose package for your Linux distribution.
- For example, on Ubuntu, you can run:

```bash
# Install Docker Compose using apt-get
sudo apt-get install docker-compose
```

- Or, if you prefer to install it manually, you can download the binary from the official GitHub repository:

```bash
# Install from GitHub repository and move it to /usr/local/bin
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

- Verify your installation by running:

    ```bash
    # Verify Docker Compose installation
    docker compose version

    # For older versions
    docker-compose --version

    # Or if using macos and installing using brew
    brew info docker-compose

    ### Output
    Isolated development environments using Docker
    https://docs.docker.com/compose/
    Installed
    /opt/homebrew/Cellar/docker-compose/2.36.0 (8 files, 59.7MB) *
    Poured from bottle using the formulae.brew.sh API on 2025-05-08 at 11:23:08
    From: https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/d/docker-compose.rb
    License: Apache-2.0
    ==> Dependencies
    Build: go ✘
    ==> Options
    --HEAD
    Install HEAD version
    ==> Caveats
    Compose is a Docker plugin. For Docker to find the plugin, add "cliPluginsExtraDirs" to ~/.docker/config.json:
    "cliPluginsExtraDirs": [
        "/opt/homebrew/lib/docker/cli-plugins"
    ]
    ==> Analytics
    install-on-request: 28,379 (30 days), 85,181 (90 days), 325,794 (365 days)
    build-error: 65 (30 days)
    ```

### 2.3. Install on MacOS using Homebrew

- If you are using macOS, you can install Docker Compose using Homebrew:

```bash
# Install Docker Compose using Homebrew
brew install docker-compose

# After installation, you can verify it by running:

# Verify Docker Compose installation
docker compose version  
```

## Navigation <!-- omit in toc -->

[Next: 002-Compose-Demo →](../002-Compose-Demo/README.md)
