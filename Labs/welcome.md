<!-- header start -->
<div markdown class="center">
# Docker Compose Hands-on Labs

</div>

---

!!! success "Getting Started Tip"
Choose the preferred way to run the labs. If you encounter any issues, please contact your instructor.

<div class="grid cards" markdown style="text-align: center;border-radius: 20px;">

- ![](assets/images/docker-compose-logo.png)

  ```bash
  cd 001-intro
  ```

- [![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/nirgeier/DockerComposeLabs)

</div>

## Intro

- This tutorial teaches Docker Compose through hands-on labs designed as practical exercises.
- Each lab is packaged in its own folder and includes the files, manifests, and assets required to complete the lab.
- Every lab folder includes a `README` that describes the lab's objectives, tasks, and how to verify the solution.
- The Docker Compose Labs are a series of exercises designed to teach players Docker Compose skills and features.
- The inspiration for this project is to provide practical learning experiences for container orchestration and multi-service applications.

## Pre-Requirements

- You should be familiar with the following topics:
  - Basic Docker concepts (`docker run`, `docker ps`, `docker build`)
  - Basic Linux commands and shell scripting
  - Basic knowledge of YAML
  - Basic Git knowledge
- Docker installed on your system
- Docker Compose (included with Docker Desktop)

## Usage

- There are several ways to run the Docker Compose Labs.
- Choose the method that works best for you.
  - Local environment with Docker Desktop (Recommended)
  - Using Google Cloud Shell

=== "Local environment (Recommended)"

    The easiest way to get started locally:

    ```bash
    # Clone the repository
    git clone https://github.com/nirgeier/DockerComposeLabs.git
    cd DockerComposeLabs

    # Start with Lab 1
    cd Labs/001-intro
    ```

    **Prerequisites:**

    - Docker installed and running
    - Docker Compose installed

=== "Google Cloud Shell"

    - Google Cloud Shell provides a free, browser-based environment with Docker tools pre-installed.
    - Click on the `Open in Google Cloud Shell` button below:

      [![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/nirgeier/DockerComposeLabs)

    - The repository will automatically be cloned into a free Cloud instance.
    - Use **<kbd>CTRL</kbd>** + click to open it in a new window.
    - Follow the instructions in the README of each lab.

---

!!! warning "" - Ensure you have the necessary permissions to create Docker containers and networks. - Enjoy, and don't forget to star the project on GitHub!

## Preface

### What is Docker Compose?

- `Docker Compose` is a tool for defining and running multi-container Docker applications.
- With Compose, you use a `YAML` file to configure your application's services, networks, and volumes.
- Then, with a single command, you create and start all the services from your configuration.

### Key Benefits

- **Single command orchestration**: `docker compose up` starts your entire stack
- **Declarative config**: Your infrastructure is version-controlled in a YAML file
- **Environment consistency**: Same setup across dev, CI, staging, and production
- **Service isolation**: Independent networks and dependency management

### What You'll Learn

By completing all labs, you will be able to:

1. **Install and configure** Docker Compose on any platform
2. **Define multi-service applications** with networks, volumes, and dependencies
3. **Master every compose file directive** (build, healthcheck, secrets, etc.)
4. **Manage the full lifecycle**: build, run, debug, tear down
5. **Package Compose apps as Helm charts** for Kubernetes deployment
6. **Use advanced patterns** like `extends` and YAML anchors
7. **Implement live reload** with Docker Compose Watch
8. **Design secure, segmented networks** with DMZ and isolation
