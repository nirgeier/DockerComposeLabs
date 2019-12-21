<a href="https://stackoverflow.com/users/1755598"><img src="https://stackexchange.com/users/flair/1951642.png" width="208" height="58" alt="profile for CodeWizard on Stack Exchange, a network of free, community-driven Q&amp;A sites" title="profile for CodeWizard on Stack Exchange, a network of free, community-driven Q&amp;A sites"></a>

![Visitor Badge](https://visitor-badge.laobi.icu/badge?page_id=nirgeier)
[![Linkedin Badge](https://img.shields.io/badge/-nirgeier-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/nirgeier/)](https://www.linkedin.com/in/nirgeier/)
[![Gmail Badge](https://img.shields.io/badge/-nirgeier@gmail.com-fcc624?style=flat-square&logo=Gmail&logoColor=red&link=mailto:nirgeier@gmail.com)](mailto:nirgeier@gmail.com)
[![Outlook Badge](https://img.shields.io/badge/-nirg@codewizard.co.il-fcc624?style=flat-square&logo=microsoftoutlook&logoColor=blue&link=mailto:nirg@codewizard.co.il)](mailto:nirg@codewizard.co.il)

---

![](./resources/logos.png)

---

# Docker Compose Hands-on Repository

- A collection of Hands-on Docker Compose labs.
- Each lab is a standalone lab and does not require to complete the previous labs.

## Pre-Requirements

- Docker installation
- Docker Compose (included with Docker Desktop)

---

![](./resources/lab.jpg)

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/nirgeier/DockerComposeLabs)

### **<kbd>CTRL</kbd> + click to open in new window**

---

### Preface

- Docker Compose is a tool for defining and running multi-container Docker applications
- With Compose, you use a YAML file to configure your application's services
- Then, with a single command, you create and start all the services from your configuration
- Docker Compose simplifies the development, testing, and deployment of complex applications

---

## Docker Compose Overview

- Docker Compose allows you to `define multiple services` in a single YAML file.
- Services can be `linked together` through networks and dependencies.
- Compose manages the `entire application lifecycle`.

### Key Benefits

- **Simplified Multi-Container Management**: Define and run multiple containers with a single command
- **Environment Consistency**: Ensure the same environment across development, testing, and production
- **Service Dependencies**: Control the startup order and dependencies between services
- **Network Isolation**: Create isolated networks for your application components
- **Volume Management**: Persist data and share files between containers and the host

### Docker Compose File Structure

- A `docker-compose.yml` file defines your application's services, networks, and volumes
- **Services**: Define the containers that make up your application
- **Networks**: Create custom networks for service communication
- **Volumes**: Manage data persistence and sharing

### Core Concepts

#### `version`

- Specifies the Compose file format version
- Different versions support different features
- Latest version provides the most features and compatibility

#### `services`

- The main section where you define your application containers
- Each service represents a single container
- Services can be built from Dockerfiles or use existing images

#### `networks`

- Define custom networks for service communication
- Services on the same network can communicate using service names
- Provides isolation between different application components

#### `volumes`

- Define named volumes for data persistence
- Share data between containers
- Persist data beyond container lifecycle

---

## Lab Structure

The repository contains the following hands-on labs:

### [001-intro](./Labs/001-intro/)

- Introduction to Docker Compose
- Installation and basic concepts
- Understanding the benefits of multi-container orchestration

### [002-Compose-Demo](./Labs/002-Compose-Demo/)

- Basic docker-compose.yml file structure
- Multi-service application example
- Web server, application, and database integration

### [002-Structure](./Labs/002-Structure/)

- Detailed docker-compose.yml structure
- Common service configurations
- Best practices for service definition

### [003-Commands](./Labs/003-Commands/)

- Essential Docker Compose commands
- Managing application lifecycle
- Debugging and troubleshooting

### [004-Compose-2Helm](./Labs/004-Compose-2Helm/)

- Converting Docker Compose to Helm charts
- Kubernetes deployment strategies
- Migration from development to production

### [005-Compose-Advanced](./Labs/005-Compose-Advanced/)

- Advanced Docker Compose features
- Complex service configurations
- Production-ready setups

### [006-Watch](./Labs/006-Watch/)

- Docker Compose Watch feature
- Live reload and development workflows
- File synchronization and hot reloading

### [007-Networks](./Labs/007-Networks/)

- Advanced multi-network architecture
- Network segmentation and security
- Service discovery and isolation patterns
- DMZ and monitoring network configurations

---

## Getting Started

1. **Clone the repository**

   ```bash
   git clone https://github.com/nirgeier/DockerComposeLabs.git
   cd DockerComposeLabs
   ```

2. **Verify Docker Compose installation**

   ```bash
   docker-compose --version
   # or
   docker compose version
   ```

3. **Navigate to any lab directory**

   ```bash
   cd Labs/001-intro
   ```

4. **Follow the lab instructions**
   - Each lab contains detailed README files
   - Step-by-step instructions are provided
   - Code examples and explanations included

---

## Common Docker Compose Commands

- `docker-compose up`: Create and start containers
- `docker-compose up -d`: Start containers in detached mode
- `docker-compose down`: Stop and remove containers
- `docker-compose ps`: List running containers
- `docker-compose logs`: View container logs
- `docker-compose exec`: Execute commands in running containers
- `docker-compose build`: Build or rebuild services

---

## Resources

The `resources` directory contains:

- Configuration files for various services
- Sample YAML files for different scenarios
- Supporting materials and documentation
- Server application examples

---

## Additional Features

### Docker Compose Watch

- Automatic file synchronization
- Live reload capabilities
- Enhanced development experience
- Real-time updates without rebuilding

### Service Orchestration

- Health checks and dependency management
- Scaling services up or down
- Load balancing and service discovery
- Rolling updates and zero-downtime deployments

### Production Considerations

- Security best practices
- Performance optimization
- Monitoring and logging
- Backup and recovery strategies

---

## Support

- Each lab is self-contained with detailed explanations
- Common issues and solutions are documented
- Best practices and tips are included throughout
- Real-world examples and use cases provided

---

**Happy Learning! 🐳**
