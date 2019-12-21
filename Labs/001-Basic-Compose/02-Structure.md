<!-- omit in toc -->
# Writing a Simple (Yet Comprehensive) `docker-compose.yml`

<!-- omit in toc -->
## Basic `docker-compose.yml` Structure

<!-- omit in toc -->
### Table of Contents

- [Common Docker Compose Service Features](#common-docker-compose-service-features)
- [Feature Details](#feature-details)
  - [`version`](#version)
  - [`services`](#services)
  - [`build` (Building an Image)](#build-building-an-image)
  - [`image` (Using an Existing Image)](#image-using-an-existing-image)
  - [`command` and `entrypoint`](#command-and-entrypoint)
  - [`ports` (Port Mapping)](#ports-port-mapping)
  - [`volumes` (Volume Management)](#volumes-volume-management)
  - [`environment` (Environment Variables)](#environment-environment-variables)
  - [`depends_on` (Service Dependencies)](#depends_on-service-dependencies)
  - [`networks` (Defining Networks)](#networks-defining-networks)

### Example of a `docker-compose.yml` file structure
  
- Here is a simple example of a `docker-compose.yml` file structure:

```yaml
version: '3.8' # Compose file format version

services:
  # Here we define our services (containers)
  myservice:
    # configurations for myservice

  another_service:
    # configurations for another_service

volumes:
  # Global volume definitions (if any)

networks:
  # Global network definitions (if any)
```

## Common Docker Compose Service Features

Now, let's detail the most common features you can use within each service definition:

| Feature       | Description                                                                 |
|---------------|-----------------------------------------------------------------------------|
| `build`       | Specifies the build context or Dockerfile for creating container images.   |
| `command`     | Overrides the default command defined in the image.                        |
| `configs`     | Defines configuration files for services. Configs let services to adapt their behavior **without the need to rebuild** a Docker image.                                   |
| `container_name` | Assigns a custom name to the container.                                 |
| `depends_on`  | Defines service dependencies, controlling startup order.                   |
| `entrypoint`  | Overrides the default entry point defined in the image.                    |
| `environment` | Sets environment variables for services.                                   |
| `healthcheck` | Defines commands to check the health of a service.                         |
| `image`       | Specifies an existing Docker image to use.                                  |
| `links`       | **(Legacy)** Links services; replaced by `networks`.                        |
| `networks`    | Defines custom networks for your containers.                                |
| `ports`       | Maps container ports to host machine ports.                                |
| `restart`     | Configures restart policies for containers (e.g., `always`, `on-failure`). |
| `secrets`     | Defines secrets for sensitive data (e.g., passwords, API keys).            |
| `version`     | Specifies the Compose file format version.                                  |
| `volumes`     | Defines volumes used for persistent data storage.                           |
| `x-<feature_name>` | Custom extension fields for reusable configurations. |

## Feature Details

### `version`

- **Purpose:** Specifies the Compose file format version. Each version has specific features and rules. It's recommended to use recent 3.x versions.
- **Example:**

    ```yaml
    version: '3.8'
    ```

### `services`

- **Purpose:** The top-level key that defines all the different containers that make up your application. Each key under `services` is your service name.
- **Example:**

    ```yaml
    services:
      web:
        # configurations for the web service
      db:
        # configurations for the db service
    ```

### `build` (Building an Image)

- **Purpose:** Instead of using an existing image, `build` instructs Compose to build a new image from a `Dockerfile` located at the specified path.
- **Options:**
  - `context`: The path to the directory containing the `Dockerfile` and other files needed for the build.
  - `dockerfile` (optional): The name of the Dockerfile if it's not `Dockerfile` (e.g., `Dockerfile.dev`).
  - `args` (optional): Build arguments that will be passed to the `Dockerfile` during the build process (like `ARG`).
  - `target` (optional): A specific build stage to target from a multi-stage `Dockerfile`.
- **Example:**

    ```yaml
    services:
      webapp:
        build:
          context: ./my_app # Builds an image from the 'my_app' directory (where Dockerfile resides)
          dockerfile: Dockerfile.dev # Uses Dockerfile.dev file
          args:
            NODE_VERSION: "18"
        ports:
          - "80:80"
    ```

### `image` (Using an Existing Image)

- **Purpose:** Instructs Compose to pull and use an existing Docker image from a registry like Docker Hub.
- **Example:**

    ```yaml
    services:
      database:
        image: postgres:15 # Uses the Postgres image at version 15
        environment:
          POSTGRES_DB: mydatabase
          POSTGRES_USER: user
          POSTGRES_PASSWORD: password
    ```

### `command` and `entrypoint`

- **`command`**:
  - **Purpose:** Defines the command that will be executed when the container starts. This command overrides the `CMD` defined in the image's `Dockerfile`.
  - **Example:**

        ```yaml
        services:
          worker:
            image: my_worker_image
            command: ["python", "worker.py", "--queue", "high"] # Executes a Python script with arguments
        ```

- **`entrypoint`**:
  - **Purpose:** Defines the entry point for the container. The `command` (or `CMD` from the `Dockerfile`) will be passed as an argument to the `entrypoint`. This overrides the `ENTRYPOINT` defined in the `Dockerfile`.
  - **Example:**

        ```yaml
        services:
          script_runner:
            image: ubuntu
            entrypoint: ["bash", "-c"] # Entry point will be running bash
            command: ["echo Hello from Docker Compose!"] # The command will be passed as an argument to bash -c
        ```

### `ports` (Port Mapping)

- **Purpose:** Maps ports from the container to ports on the host machine, allowing access to the service from outside the container.
- **Formats:**
  - `"HOST_PORT:CONTAINER_PORT"`: Maps a specific port.
  - `"CONTAINER_PORT"`: A random available host port will be mapped to `CONTAINER_PORT`.
- **Example:**

    ```yaml
    services:
      web:
        image: nginx:latest
        ports:
          - "80:80"     # Host port 80 maps to container port 80
          - "443:443"   # Host port 443 maps to container port 443
          - "8080"      # Container port 8080 maps to a random host port
    ```

### `volumes` (Volume Management)

- **Purpose:** Allows for persistent data storage, ensuring data remains even if the container is recreated or removed. You can map files/directories from the host machine into the container (bind mounts) or use Docker-managed volumes (named volumes).
- **Formats:**
  - `"HOST_PATH:CONTAINER_PATH"`: Bind mount.
  - `"VOLUME_NAME:CONTAINER_PATH"`: Named volume.
- **Example:**

    ```yaml
    services:
      db:
        image: postgres:15
        volumes:
          - db_data:/var/lib/postgresql/data # Named volume for persistent DB data
          - ./app/config:/etc/app/config     # Bind mount: maps host folder to container (for config files)

    ```

volumes: \# Global volume definitions
db\_data:
driver: local \# Volume driver (default)
\# You can also add options or driver\_opts for advanced configurations,
\# e.g., driver\_opts: {type: nfs, o: "addr=192.168.1.100,nolock,rw", device: ":/export/data"}
\# but this is less common for a simple guide.
\`\`\`

### `environment` (Environment Variables)

- **Purpose:** Defines environment variables for the container. Useful for passing configuration details like passwords, API keys, or environment settings (development/production).
- **Formats:**
  - List of `KEY=VALUE` strings.
  - Map of `KEY: VALUE` pairs.
- **Example:**

    ```yaml
    services:
      api:
        image: my_api_image
        environment:
          API_KEY: your_api_key
          DATABASE_URL: postgres://user:password@db:5432/mydb
          NODE_ENV: development
          - DEBUG=true # Another format for lists
    ```

    *Tip: For sensitive variables, consider using a `.env` file (in the same directory as your `docker-compose.yml`) or Docker Secrets.*

### `depends_on` (Service Dependencies)

- **Purpose:** Defines the startup order between services. Services will only start after the services they depend on have been started. *Important: `depends_on` ensures the container has started, but not necessarily that the service within it is ready to accept connections (e.g., a database fully booted and listening).*
- **Example:**

    ```yaml
    services:
      web:
        image: my_web_app
        depends_on:
          - api # The web service will start only after the api service has started
          - db  # And the db service has started
        ports:
          - "80:80"
      api:
        image: my_api_service
        depends_on:
          - db # The api service will start only after the db service has started
        ports:
          - "3000:3000"
      db:
        image: postgres:15
    ```

### `networks` (Defining Networks)

- **Purpose:** Allows you to define custom networks so that services can communicate with each other. Services on the same network can communicate using their service names (DNS resolution).
- **Example:**

    ```yaml
    services:
      web:
        image: nginx
        ports:
          - "80:80"
        networks:
          - frontend_network # Connected to frontend_network
          - backend_network  # Connected to backend_network
      api:
        image: my_api_app
        networks:
          - backend_network  # Connected to backend_network
      db:
        image: postgres:15
        networks:
          - db_network # Connected to db_network

    networks:  # Global network definitions
    frontend_network:
      # driver: bridge (default)
    backend_network:
      # driver: bridge
    db_network:
      internal: true # Internal network only (not accessible from the host)
      # ipam:
      #   config:
      #     - subnet: 172.20.0.0/24 # Defines an IP range for the network for the  
   ```

### `links` (Linking Services - Legacy)

- **Purpose:** Allows linking older services (pre-Compose v2) and provides aliases for hostnames. **It is highly recommended to use `networks` instead of `links` in newer Compose versions (v2 and above), as `links` is considered legacy.**
- **Example (Not recommended for new usage):**

    ```yaml
    services:
      web:
        image: my_web_app
        links:
          - db:database_alias # Links to 'db' and gives it an alias 'database_alias'
    ```

### `container_name` (Custom Container Name)

- **Purpose:** Allows you to specify a custom name for the running container, instead of the name Docker Compose automatically generates (usually `project_service_index`).
- **Example:**

    ```yaml
    services:
      my_web:
        image: nginx
        container_name: my_nginx_server # The container will be named 'my_nginx_server'
        ports:
          - "80:80"
    ```

### `restart` (Restart Policy)

- **Purpose:** Determines how the container will be restarted if it exits or crashes.
- **Options:**
  - `no`: Does not restart (default).
  - `on-failure`: Restarts only if the container exits with a non-zero exit code.
  - `always`: Always restarts, even if the container exits successfully.
  - `unless-stopped`: Always restarts unless it is explicitly stopped.
- **Example:**

    ```yaml
    services:
      app:
        image: my_app
        restart: unless-stopped # Always restarts, unless manually stopped
    ```

### `healthcheck` (Health Check)

- **Purpose:** Defines how Docker can check if the container (and the service within it) is healthy and functional. This is particularly useful in conjunction with `depends_on` to ensure a dependent service is truly ready before other services connect to it.
- **Options:**
  - `test`: The command to be executed for the health check.
  - `interval`: How often to run the check (default: 30s).
  - `timeout`: Maximum time allowed for a single check to complete (default: 30s).
  - `retries`: How many consecutive failures are needed to consider the container unhealthy (default: 3).
  - `start_period`: Initialization time to allow a container to bootstrap. During this period, health check failures will not count towards the maximum retries (default: 0s).
- **Example:**

    ```yaml
    services:
      web:
        image: my_web_app
        ports:
          - "80:80"
        depends_on:
          api:
            condition: service_healthy # The web service will only start after 'api' is healthy
        healthcheck:
          # Checks if web server responds
          test: ["CMD-SHELL", "curl -f http://localhost/ || exit 1"] 
          interval: 10s
          timeout: 5s
          retries: 3
          # Give the service 20 seconds to start up initially
          # before starting health checks
          start_period: 20s api:
        image: my_api_service
        ports:
          - "3000:3000"
        healthcheck:
          # Checks a health endpoint
          test: ["CMD-SHELL", "curl -f http://localhost:3000/health || exit 1"] 
          interval: 5s
          timeout: 3s
          retries: 5
    ```

---

## Complete `docker-compose.yml` Example

Here's an example combining many of the features discussed, illustrating a simple web application with a backend API and a database:

```yaml
version: '3.8'

services:
  web:
    build:
      context: ./frontend # Assumes a frontend application in ./frontend with its Dockerfile
      dockerfile: Dockerfile
    container_name: my-webapp-frontend
    ports:
      - "80:80"
    environment:
      API_URL: http://api:3000 # Connects to the 'api' service within the Docker network
    networks:
      - app_network
    depends_on:
      api:
        condition: service_healthy # Ensures API is healthy before starting web
    restart: unless_stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost/"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 10s

  api:
    build:
      context: ./backend # Assumes a backend API application in ./backend with its Dockerfile
    container_name: my-api-backend
    ports:
      - "3000:3000"
    environment:
      DB_HOST: db # Connects to the 'db' service within the Docker network
      DB_USER: user
      DB_PASSWORD: password
      DB_NAME: mydatabase
      NODE_ENV: production
    volumes:
      - api_logs:/var/log/my_app # Mounts a named volume for API logs
    networks:
      - app_network
      - db_network # Connects to both app and db networks
    depends_on:
      db:
        condition: service_healthy # Ensures DB is healthy before starting API
    restart: on_failure
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 15s
      timeout: 5s
      retries: 5
      start_period: 15s

  db:
    image: postgres:15
    container_name: my-postgres-db
    environment:
      POSTGRES_DB: mydatabase
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - db_data:/var/lib/postgresql/data # Mounts a named volume for persistent DB data
    networks:
      - db_network # Only connected to the database network
    restart: always
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user -d mydatabase"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  db_data: # Definition of the named volume for database data
  api_logs: # Definition of the named volume for API logs

networks:
  app_network: # Network for web and API communication
  db_network:  # Network for API and DB communication (can be internal for better isolation)
    internal: true # Makes this network only accessible by containers connected to it, not from the host directly
```

---

:arrow_backward:  [01-Intro.md](./01-Intro.md) &emsp; :arrow_forward: [03-Commands.md](./03-Commands.md)

&copy; CodeWizard
