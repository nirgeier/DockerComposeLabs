
![](../../resources/lab.jpg)
[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/nirgeier/DockerComposeLabs)

### **<kbd>CTRL</kbd> + click to open in new window**

---

# Docker Compose Watch

Docker Compose Watch is a powerful tool for monitoring changes in your Docker Compose setup and automatically rebuilding or restarting services when changes are detected. This lab demonstrates how to implement and use Docker Compose Watch for streamlined development workflows.

## Description

This lab explores Docker Compose Watch functionality, which observes changes in project files such as `Dockerfile`, `docker-compose.yaml`, or application code, and triggers automated actions like rebuilding images or restarting containers. This is particularly valuable in development environments where frequent code changes occur.

## Prerequisites

- Docker and Docker Compose installed
- Basic understanding of Docker Compose
- Familiarity with file watching concepts
- Linux/macOS environment (for inotify-tools examples)

## What is Docker Compose Watch?

Docker Compose Watch is a mechanism that monitors file system changes and automatically triggers container rebuilds or restarts. It eliminates the need for manual intervention when iterating on containerized applications, significantly improving development efficiency.

## Key Benefits

- **Efficiency**: Automates rebuilding and restarting processes
- **Consistency**: Ensures changes are immediately reflected in containers
- **Productivity**: Allows developers to focus on coding instead of container management
- **Reduced Downtime**: Minimizes delays through automatic service restarts
- **Improved Feedback Loop**: Provides immediate reflection of changes

## Use Cases

### 1. Web Application Development

Automatically reloads applications when code changes are detected in source files.

### 2. Microservices Development

Keeps multiple services synchronized during development cycles.

### 3. Configuration Management

Applies configuration file changes without requiring manual restarts.

### 4. Rapid Testing

Facilitates quick testing of changes in isolated container environments.

## Implementation Examples

### Example 1: Basic Application Code Watching

```yaml
version: '3.8'
services:
  app:
    build: .
    volumes:
      - ./app:/usr/src/app
    command: npm start
    develop:
      watch:
        - action: rebuild
          path: ./package.json
        - action: sync
          path: ./app
          target: /usr/src/app
```

### Example 2: Configuration File Watching

```yaml
version: '3.8'
services:
  app:
    build: .
    volumes:
      - ./config:/usr/src/app/config
    command: npm start
    develop:
      watch:
        - action: restart
          path: ./config
```

### Example 3: Multi-Service Watch Setup

```yaml
version: '3.8'
services:
  frontend:
    build: ./frontend
    develop:
      watch:
        - action: sync
          path: ./frontend/src
          target: /app/src
  
  backend:
    build: ./backend
    develop:
      watch:
        - action: rebuild
          path: ./backend/requirements.txt
        - action: sync
          path: ./backend/app
          target: /app
```

## Demo: File Watching with Python

### Bash Script (`watch_demo.sh`)

```bash
#!/bin/bash

# Initialize the counter file
counter_file="counter.txt"
if [ ! -f "$counter_file" ]; then
  echo 0 > "$counter_file"
fi

# Watch for changes in the counter file
while inotifywait -e modify "$counter_file"; do
  echo "Change detected in $counter_file. Running Python script..."
  python3 print_counter.py
done
```

### Python Script (`print_counter.py`)

```python
import os
import time

# Specify the counter file
counter_file = 'counter.txt'

# Infinite loop to print the version and sleep for 3 seconds
while True:
    # Check if the file exists
    if os.path.exists(counter_file):
        with open(counter_file, 'r') as file:
            counter = int(file.read().strip())
            print(f"Current counter value: {counter}")

        # Increment the counter and write back to the file
        with open(counter_file, 'w') as file:
            file.write(str(counter + 1))
    else:
        print(f"File '{counter_file}' does not exist.")

    # Sleep for 3 seconds
    time.sleep(3)
```

## Tools for Docker Compose Watch

### Built-in Docker Compose Watch

- Native support in Docker Compose v2.22+
- Uses the `develop.watch` configuration
- Supports `sync`, `rebuild`, and `restart` actions

### External Tools

- **docker-compose-watch**: Dedicated third-party tool
- **entr**: General-purpose file watcher for triggering Docker commands
- **inotify-tools**: Linux utilities for monitoring file system changes
- **watchman**: Facebook's file watching service

## Watch Actions

### Sync

- Synchronizes files between host and container
- Fastest option for code changes
- Ideal for interpreted languages

### Rebuild

- Rebuilds the Docker image when dependencies change
- Used for package.json, requirements.txt changes
- Maintains container state when possible

### Restart

- Restarts the entire container
- Used for configuration changes
- Most comprehensive but slowest option

## Lab Exercises

1. **Basic Setup**: Create a simple web application with Docker Compose Watch
2. **Multi-Action Watch**: Configure different watch actions for different file types
3. **Performance Testing**: Compare development speed with and without watch functionality
4. **Custom Scripting**: Implement custom file watching using bash scripts and inotify
5. **Troubleshooting**: Practice debugging watch configuration issues

## Best Practices

- Use `sync` for frequently changing source code
- Use `rebuild` for dependency files
- Use `restart` for configuration changes
- Exclude unnecessary files using `.dockerignore`
- Monitor resource usage during development
- Test watch configuration in team environments

## When to Use Docker Compose Watch

Docker Compose Watch is ideal for:

- Development environments with frequent code changes
- Projects with complex multi-service dependencies
- Teams requiring rapid collaboration and testing
- Applications with mixed programming languages
- Scenarios requiring immediate feedback on changes

## Usage

### Sample Files Available

This lab includes practical sample files:

- **`docker-compose.yml`**: Comprehensive example with multiple services and watch configurations
- **`docker-compose-simple.yml`**: Simplified version focusing on core watch features from README examples
- **`demo.sh`**: Interactive script that creates a sample project structure and provides usage instructions

### Starting Watch Mode

```bash
# Start services with watch enabled
docker compose watch

# Start specific services with watch
docker compose watch [service-name]

# Combine with other commands
docker compose up --watch

# Use the simple example
docker compose -f docker-compose-simple.yml up --watch

# Run the demo script to set up a complete example
./demo.sh
```

### Monitoring Watch Activity

```bash
# View logs to monitor watch events
docker compose logs -f

# Check watch configuration
docker compose config
```

## Learning Outcomes

After completing this lab, you will understand:

- How to configure Docker Compose Watch for different scenarios
- The differences between sync, rebuild, and restart actions
- Best practices for optimizing development workflows
- Integration techniques with existing development tools
- Performance considerations and troubleshooting methods

## Navigation

[← Previous: 005-Compose-Advanced](../005-Compose-Advanced) | [Next: (End of Labs) →](../)
