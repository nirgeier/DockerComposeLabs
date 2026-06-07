# Docker Compose Labs - Tasks

Welcome to the Docker Compose Labs Tasks section.  
Each folder below contains a hands-on task/exercise that you can complete independently to practice specific Docker Compose skills.  
Follow the README file in each task for detailed instructions and solutions.

## Task Index

### Core Docker Compose

| Task | Description |
|------|-------------|
| [01. Basic Compose Tasks](01-Basic-Compose-Tasks/README.md) | Fundamental Docker Compose exercises: services, images, ports, environment variables, and basic commands. |
| [02. Network Tasks](02-Network-Tasks/README.md) | Hands-on exercises for Docker Compose networking: custom networks, service discovery, internal/external communication. |
| [03. Volume Tasks](03-Volume-Tasks/README.md) | Practice with volumes: named volumes, bind mounts, tmpfs, volume drivers, and data persistence patterns. |
| [04. Advanced Compose Tasks](04-Advanced-Compose-Tasks/README.md) | Advanced topics: profiles, configs/secrets, healthchecks, resource limits, deploy configs, and multi-file compose. |

### Quick Reference

| Command | Description |
|---------|-------------|
| `docker compose up -d` | Start services in detached mode |
| `docker compose down` | Stop and remove containers, networks |
| `docker compose ps` | List running services |
| `docker compose logs -f` | Follow logs from all services |
| `docker compose exec <service> <cmd>` | Execute command in running container |
| `docker compose config` | Validate and view resolved config |
| `docker compose build` | Build or rebuild services |

---

Happy learning and hacking with Docker Compose!