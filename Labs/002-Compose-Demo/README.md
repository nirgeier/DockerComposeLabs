# Docker Compose Demo - Multi-Container Application

[![](https://img.shields.io/static/v1?label=&message=Docker%20Compose%20Docs&color=2496ED&logo=docker&logoColor=FFFFFF)](https://docs.docker.com/compose/)

---

## Overview

- This lab demonstrates a **production-ready multi-container application** using Docker Compose.
- You'll learn how to orchestrate three interconnected services (web server, application, and database) with proper networking, volume management, and service dependencies.

#### What You'll Build

- A complete 3-tier application architecture:

      | Layer                 | Technology | Description                                          |
      |-----------------------|------------|------------------------------------------------------|
      | **Frontend Layer**    | Nginx      | High-performance web server and reverse proxy        |
      | **Application Layer** | Node.js    | JavaScript runtime for scalable network applications |
      | **Database Layer**    | PostgreSQL | Advanced relational database with ACID compliance    |

#### Key Features

- Multi-container orchestration with Docker Compose
- Isolated networks for frontend and backend communication
- Persistent data storage using Docker volumes
- Service dependencies to ensure proper startup order
- Environment variable configuration for flexibility
- Restart policies for high availability
- Detailed explanations of each section of the Docker Compose file
- Hands-on exercises to deploy and test the application
- Best practices for production-ready Docker Compose setups

## Learning Objectives

By the end of this lab, you will:

- [x] Understand the complete structure of a Docker Compose file
- [x] Master service definitions and configuration
- [x] Implement multi-network architecture for security
- [x] Configure persistent data storage with volumes
- [x] Manage service dependencies and startup order
- [x] Apply best practices for environment variables
- [x] Understand restart policies for high availability

---

## Prerequisites

Before starting this lab, ensure you have:

- Docker Engine 19.03.0+ installed
- Docker Compose v1.27+ or Docker Compose V2
- Completed Lab 001-intro
- Basic understanding of web applications
- Text editor for viewing YAML files

## Architecture Overview

- Our sample application uses a **3-tier architecture** with network isolation:

```mermaid
graph LR
    Client[👤 Client]

    subgraph Frontend["Frontend Layer<br/>webnet Network"]
        web[**Nginx**<br/>Web Server<br/>Port 8080]
        app1[**Node.js**<br/>Application<br/>Port 3000]
    end

    subgraph Backend["Backend Layer<br/>dbnet Network"]
        app2[**Node.js**<br/>Application<br/>Port 3000]
        db[**PostgreSQL**<br/>Database<br/>Port 5432]
    end

    subgraph Storage["Data Layer"]
        volume[**db-data**<br/><br/>Volume<br/>Persistent Storage]
    end

    Client --> web
    Client --> app1
    web --> app1
    app1 -.Same Container.-> app2
    app2 --> db
    db --> volume

    style Frontend fill:none,stroke:#2196f3,stroke-width:3px,padding:10px
    style Backend fill:none,stroke:#00c853,stroke-width:3px,padding:10px
    style Storage fill:none,stroke:#7c4dff,stroke-width:3px,padding:10px
```

#### Key Design Principles:

!!! info "Network Segmentation"

    **Isolation Strategy**: Our architecture implements separate networks for different application tiers to enhance security and performance.

    ##### Benefits

    - **Security Boundaries**: Web and database tiers are isolated, preventing direct access
    - **Traffic Control**: Network policies can be applied at each layer
    - **Fault Isolation**: Issues in one network don't affect others
    - **Scalability**: Each network can be scaled independently

    ##### Implementation
    * The `webnet` network handles frontend communication, while `dbnet` secures backend database access.
    * This creates a defense-in-depth strategy where the database is shielded from direct external access.

!!! success "Service Isolation"

    **Security First**: The database is not directly accessible from the web service, enforcing the principle of least privilege.

    ##### Architecture Benefits

    - **Attack Surface Reduction**: Database cannot be reached directly from the internet
    - **Access Control**: Only the application layer can communicate with the database
    - **Audit Trail**: All database access flows through the application, enabling logging
    - **Compliance**: Meets security standards for multi-tier applications

    ##### Real-world Impact:
    * If the web service is compromised, attackers cannot directly access the database.
    * They must first breach the application layer, providing an additional security boundary.

!!! tip "Data Persistence"

    **Reliability**: Named volumes ensure your data survives container restarts, updates, and even host migrations.

    ##### Persistence Features:

    - **Container Independence**: Data persists even when containers are deleted
    - **Easy Backups**: Docker provides built-in tools for volume backup and restore
    - **Performance**: Optimized for database workloads with efficient I/O
    - **Portability**: Volumes can be moved between hosts

    ##### Use Cases:
    * Perfect for databases, user uploads, application state, logs, and any data that must survive container lifecycle events.
    * Our PostgreSQL data is stored in the `db-data` volume, ensuring no data loss during updates or restarts.

!!! example "Scalability"

    **Growth Ready**: Each service can be independently scaled based on demand, allowing efficient resource utilization.

    ##### Scaling Strategies:

    - **Horizontal Scaling**: Add more web or app instances behind a load balancer
    - **Vertical Scaling**: Increase resources (CPU/RAM) for specific services
    - **Independent Scaling**: Scale services without affecting others
    - **Resource Optimization**: Allocate resources where they're needed most

    ##### Example Scenario:
    * During high traffic, scale up web and app services while keeping a single database instance.
    * Use `docker-compose up --scale app=3` to run three application instances, all connecting to the same database through the shared network.

---

## Docker Compose File Structure

A Docker Compose file is structured into several key sections, each serving a specific purpose in defining your multi-container application:

| Section        | Purpose                                              | Required    | Key Properties                                                                           |
| -------------- | ---------------------------------------------------- | ----------- | ---------------------------------------------------------------------------------------- |
| **`version`**  | Declares Compose file format version                 | ✅ Yes      | Version number (`3.9`, `3.8`, etc.)                                                      |
| **`services`** | Defines all containers in your application           | ✅ Yes      | `image`, `build`, `ports`, `environment`, `volumes`, `networks`, `depends_on`, `restart` |
| **`networks`** | Creates custom networks for service communication    | ❌ Optional | Network name, `driver`, `ipam`, `internal`                                               |
| **`volumes`**  | Defines named volumes for data persistence           | ❌ Optional | Volume name, `driver`, `driver_opts`, `external`                                         |
| **`configs`**  | Manages configuration files as first-class resources | ❌ Optional | Config name, `file`, `external`                                                          |
| **`secrets`**  | Stores sensitive data (passwords, tokens, keys)      | ❌ Optional | Secret name, `file`, `external`                                                          |

---

### Section Details

**`services`** - The core of your Compose file where you define each container:

- Each service can use an `image` from a registry or be `build` from a Dockerfile
- Configure container behavior with environment variables, volumes, networks, and restart policies
- Define dependencies between services using `depends_on`

**`networks`** - Create isolated network segments:

- Services on the same network can communicate using service names
- Implements network segmentation for security
- Default bridge driver for single-host deployments

**`volumes`** - Persistent data storage:

- Data survives container restarts and removals
- Managed by Docker with automatic cleanup capabilities
- Better performance than bind mounts on Mac/Windows

**`configs` & `secrets`** - Secure configuration management:

- Configs for non-sensitive configuration files
- Secrets for sensitive data with encryption at rest
- Both are mounted into containers as files

Let's break down the `docker-compose-sample.yml` file section by section:

### File Version Declaration

- **Purpose**: Declares the Compose file format version

      ```yaml
      version: "3.9"
      ```

- **Details**:

      - Version `3.9` supports all modern Docker Compose features
      - Compatible with Docker Engine 19.03.0+
      - Enables features like `depends_on`, custom networks, and named volumes
      - Higher versions support additional features (GPU access, device mapping, etc.)

- **Version Compatibility**:

      | Version | Docker Engine | Key Features                    |
      | ------- | ------------- | ------------------------------- |
      | 3.9     | 19.03.0+      | Full feature set, build secrets |
      | 3.8     | 19.03.0+      | Max memory, CPU limits          |
      | 3.7     | 18.06.0+      | Init process, isolation modes   |
      | 3.0-3.6 | 1.13.0+       | Basic orchestration             |

### Services Section

- **Purpose**: The `services` section defines all containers in your application

      ```yaml
      services:
        web:
          # Web service configuration
        app:
          # Application service configuration
        db:
          # Database service configuration
      ```

---

### Web Service (Nginx)

- **Purpose**: Serves as a reverse proxy and static content server

      ```yaml
      web:
        image: nginx:latest
        ports:
          - "8080:80"
        environment:
          - NGINX_HOST=localhost
          - NGINX_PORT=80
        volumes:
          - ./web-data:/usr/share/nginx/html
        networks:
          - webnet
        restart: always
      ```

- **Configuration Breakdown**:

      | Property      | Value                              | Description                            |
      | ------------- | ---------------------------------- | -------------------------------------- |
      | `image`       | `nginx:latest`                     | Official Nginx image from Docker Hub   |
      | `ports`       | `8080:80`                          | Map host port 8080 → container port 80 |
      | `environment` | `NGINX_HOST`, `NGINX_PORT`         | Runtime configuration variables        |
      | `volumes`     | `./web-data:/usr/share/nginx/html` | Mount local files for serving          |
      | `networks`    | `webnet`                           | Connect to frontend network            |
      | `restart`     | `always`                           | Always restart if stopped              |

- **Environment Variables**:

      - `NGINX_HOST=localhost`: Sets the server name in Nginx configuration
      - `NGINX_PORT=80`: Internal port Nginx listens on

- **Volume Mount Explained**:

      ```
      Host Path: ./web-data Container Path: /usr/share/nginx/html
      │ │
      ├── index.html ───────────────►   ├── index.html
      ├── styles.css ───────────────►   ├── styles.css
      └── images/    ───────────────►   └── images/
      ```

- **Port Mapping**:

      ```
      Host Machine Container
      Port 8080  ←→ Port 80 (Nginx)
       (External)   (Internal)
      ```

- **Access URL**: `http://localhost:8080`

---

### App Service (Node.js Application)

- **Purpose**: The application layer that handles business logic

      ```yaml
      app:
        build:
          context: ./app
          dockerfile: Dockerfile
        container_name: app-container
        ports:
          - "3000:3000"
        environment:
          - NODE_ENV=production
        depends_on:
          - db
        networks:
          - webnet
          - dbnet
        restart: on-failure
      ```

- **Configuration Breakdown**:

      | Property           | Value                 | Description                              |
      | ------------------ | --------------------- | ---------------------------------------- |
      | `build.context`    | `./app`               | Directory containing Dockerfile          |
      | `build.dockerfile` | `Dockerfile`          | Dockerfile name (optional if default)    |
      | `container_name`   | `app-container`       | Custom name for easy identification      |
      | `ports`            | `3000:3000`           | Map host port 3000 → container port 3000 |
      | `environment`      | `NODE_ENV=production` | Set Node.js to production mode           |
      | `depends_on`       | `db`                  | Wait for database container to start     |
      | `networks`         | `webnet`, `dbnet`     | Connect to both networks                 |
      | `restart`          | `on-failure`          | Only restart on error                    |

- **Build Context Explained**:

      ```
      ./app/
        ├── Dockerfile         ← Build instructions
        ├── package.json       ← Dependencies
        ├── package-lock.json
        └── src/
            └── index.js       ← Application code
      ```

- **Multi-Network Configuration**:

      - **`webnet`**: Communicates with Nginx (receives HTTP requests)
      - **`dbnet`**: Communicates with PostgreSQL (database queries)

- **Depends On Behavior**:

      ```
      Start Order:
        1. db service starts
        2. Docker waits for db container to be running
        3. app service starts

      Note: depends_on only waits for container start,
            not for service readiness (e.g., DB accepting connections)
      ```

- **Environment Variable Usage**:

      ```javascript
      // In Node.js application
      const env = process.env.NODE_ENV; // 'production'

      if (env === "production") {
        // Enable optimizations
        // Disable debug logging
        // Use production database
      }
      ```

- **Access URL**: `http://localhost:3000`

---

### Database Service (PostgreSQL)

- **Purpose**: Persistent data storage layer

      ```yaml
      db:
        image: postgres:latest
        container_name: db-container
        environment:
          POSTGRES_USER: user
          POSTGRES_PASSWORD: password
          POSTGRES_DB: mydb
        volumes:
          - db-data:/var/lib/postgresql/data
        networks:
          - dbnet
        restart: unless-stopped
      ```

- **Configuration Breakdown**:

      | Property         | Value                  | Description                                   |
      | ---------------- | ---------------------- | --------------------------------------------- |
      | `image`          | `postgres:latest`      | Official PostgreSQL image                     |
      | `container_name` | `db-container`         | Custom container name                         |
      | `environment`    | PostgreSQL credentials | Initial database setup                        |
      | `volumes`        | `db-data` volume       | Persistent data storage                       |
      | `networks`       | `dbnet`                | Backend network only                          |
      | `restart`        | `unless-stopped`       | Restart automatically unless manually stopped |

- **PostgreSQL Environment Variables**:

      ```yaml
      environment:
        POSTGRES_USER: user # Database admin username
        POSTGRES_PASSWORD: password # Admin password (CHANGE IN PRODUCTION!)
        POSTGRES_DB: mydb # Initial database name
      ```

- **Security Best Practice**:

      ```yaml
      # Production-ready approach using secrets:
      environment:
        POSTGRES_USER: ${DB_USER} # From .env file
        POSTGRES_PASSWORD_FILE: /run/secrets/db_password # From Docker secrets
        POSTGRES_DB: ${DB_NAME}

      secrets:
        db_password:
          file: ./secrets/db_password.txt
      ```

- **Volume Persistence**:

      ```mermaid
      graph TB
          Create[Create Container]
          Stop[Stop Container]
          Remove[Remove Container]
          Recreate[Recreate Container]

          Write[Data written to<br/>/var/lib/postgresql/data]
          Volume[(db-data<br/>Volume)]
          Persists[Data persists!]
          Restore[Data restored<br/>from volume]

          Create --> Write
          Create --> Stop
          Stop --> Remove
          Remove --> Recreate

          Write --> Volume
          Volume --> Persists
          Persists --> Restore
          Restore --> Recreate

          style Create stroke:#ff6f00,stroke-width:2px
          style Stop stroke:#c2185b,stroke-width:2px
          style Remove stroke:#7b1fa2,stroke-width:2px
          style Recreate stroke:#2e7d32,stroke-width:2px
          style Write stroke:#1565c0,stroke-width:2px
          style Volume stroke:#0288d1,stroke-width:3px
          style Persists stroke:#388e3c,stroke-width:2px
          style Restore stroke:#f57f17,stroke-width:2px
      ```

- **Connection String** (from app service):

      ```javascript
      const connectionString = "postgresql://user:password@db-container:5432/mydb";
      //                                    ↑       ↑         ↑          ↑     ↑
      //                                  User   Password  Hostname   Port  Database
      ```

---

### Volumes Section

- **Purpose**: Named volumes for data persistence

      ```yaml
      volumes:
        db-data:
      ```

- **Volume Details**:

      | Property         | Description                                     |
      | ---------------- | ----------------------------------------------- |
      | `db-data`        | Named volume managed by Docker                  |
      | Storage Location | `/var/lib/docker/volumes/db-data/_data` (Linux) |
      | Lifecycle        | Survives container deletion                     |
      | Backup           | Can be backed up using `docker volume` commands |

- **Volume Operations**:

      ```bash
      # List volumes
      docker volume ls

      # Inspect volume
      docker volume inspect 002-compose-demo_db-data

      # Backup volume
      docker run --rm -v 002-compose-demo_db-data:/source -v $(pwd):/backup \
        alpine tar czf /backup/db-backup.tar.gz -C /source .

      # Restore volume
      docker run --rm -v 002-compose-demo_db-data:/target -v $(pwd):/backup \
        alpine tar xzf /backup/db-backup.tar.gz -C /target
      ```

- **Volume vs Bind Mount**:

      | Feature           | Named Volume               | Bind Mount                |
      | ----------------- | -------------------------- | ------------------------- |
      | Managed by Docker | ✅ Yes                     | ❌ No                     |
      | Location          | Docker-managed             | User-specified path       |
      | Backup tools      | Built-in                   | Manual                    |
      | Performance       | Better on Mac/Windows      | Better on Linux           |
      | Use case          | Databases, persistent data | Development, code sharing |

---

### Networks Section

- **Purpose**: Custom networks for service communication and isolation

      ```yaml
      networks:
        webnet:
        dbnet:
      ```

- **Network Architecture**:

      ```mermaid
      graph TB
          subgraph DockerHost["🐳 Docker Host"]
              subgraph Webnet["webnet (bridge network)<br/>Subnet: 172.18.0.0/16"]
                  web1["**web:8080**<br/>172.18.0.2"]
                  app1["**app:3000**<br/>172.18.0.3"]
                  web1 <--> app1
              end
              
              subgraph Dbnet["dbnet (bridge network)<br/>Subnet: 172.19.0.0/16"]
                  app2["**app:3000**<br/>172.19.0.2"]
                  db["**db:5432**<br/>172.19.0.3"]
                  app2 <--> db
              end
              
              app1 -.Same Container.-> app2
          end

          style DockerHost fill:none,stroke:#424242,stroke-width:3px,stroke-dasharray: 5 5
          style Webnet fill:#e3f2fd,stroke:#2196f3,stroke-width:2px
          style Dbnet fill:#e8f5e9,stroke:#4caf50,stroke-width:2px
          style web1 fill:#bbdefb,stroke:#1976d2,stroke-width:2px
          style app1 fill:#c8e6c9,stroke:#388e3c,stroke-width:2px
          style app2 fill:#c8e6c9,stroke:#388e3c,stroke-width:2px
          style db fill:#fff9c4,stroke:#f57f17,stroke-width:2px
      ```

- **Network Benefits**:

      - **DNS Resolution**: Services can communicate using service names

            ```bash
            # From app container
            curl http://db:5432  # Resolves to db container IP
            ```

      - **Isolation**: `web` and `db` services cannot directly communicate

            ```bash
            # From web container
            curl http://db:5432  # ❌ Cannot resolve - not on same network
            ```

      - **Security**: Database is only accessible through the application layer

- **Network Communication Table**:

      | From Service | To Service | Network | Can Communicate? |
      | ------------ | ---------- | ------- | ---------------- |
      | web          | app        | webnet  | ✅ Yes           |
      | app          | web        | webnet  | ✅ Yes           |
      | app          | db         | dbnet   | ✅ Yes           |
      | db           | app        | dbnet   | ✅ Yes           |
      | web          | db         | N/A     | ❌ No            |
      | db           | web        | N/A     | ❌ No            |

- **Custom Network Configuration** (Advanced):

      ```yaml
      networks:
        webnet:
          driver: bridge
          ipam:
            config:
              - subnet: 172.20.0.0/16
                gateway: 172.20.0.1
        dbnet:
          driver: bridge
          internal: true # No external access
      ```

---

## Hands-On Exercises

### Exercise 1: Deploy the Application

**Step 1**: Navigate to the lab directory

```bash
cd Labs/002-Compose-Demo
```

**Step 2**: Start all services

```bash
docker-compose -f docker-compose-sample.yml up -d
```

**Expected Output**:

```
Creating network "002-compose-demo_webnet" ... done
Creating network "002-compose-demo_dbnet" ... done
Creating volume "002-compose-demo_db-data" ... done
Creating db-container ... done
Creating app-container ... done
Creating 002-compose-demo_web_1 ... done
```

**Step 3**: Verify all services are running

```bash
docker-compose -f docker-compose-sample.yml ps
```

**Expected Output**:

```
Name                    Command               State           Ports
-------------------------------------------------------------------------
app-container          node server.js            Up      0.0.0.0:3000->3000/tcp
db-container           postgres                  Up      5432/tcp
002-compose-demo_web_1 nginx -g daemon off;      Up      0.0.0.0:8080->80/tcp
```

---

### Exercise 2: Test Service Communication

**Test Web Service**:

```bash
curl http://localhost:8080.md-typeset__table
# Should return Nginx default page or your custom HTML
```

**Test App Service**:

```bash
curl http://localhost:3000
# Should return application response
```

**Check Logs**:

```bash
# All services
docker-compose -f docker-compose-sample.yml logs

# Specific service
docker-compose -f docker-compose-sample.yml logs app

# Follow logs in real-time
docker-compose -f docker-compose-sample.yml logs -f app
```

---

### Exercise 3: Inspect Networks

**List networks**:

```bash
docker network ls | grep 002-compose-demo
```

**Inspect webnet**:

```bash
docker network inspect 002-compose-demo_webnet
```

**Verify network connectivity**:

```bash
# From app container, ping web service
docker exec app-container ping -c 3 web

# From app container, check database connectivity
docker exec app-container pg_isready -h db -U user
```

---

### Exercise 4: Data Persistence Test

**Step 1**: Create sample data in database

```bash
docker exec -it db-container psql -U user -d mydb
```

```sql
-- Create a test table
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100)
);

-- Insert sample data
INSERT INTO users (name, email) VALUES
  ('John Doe', 'john@example.com'),
  ('Jane Smith', 'jane@example.com');

-- Verify data
SELECT * FROM users;

-- Exit psql
\q
```

**Step 2**: Stop and remove containers

```bash
docker-compose -f docker-compose-sample.yml down
```

**Step 3**: Restart services

```bash
docker-compose -f docker-compose-sample.yml up -d
```

**Step 4**: Verify data persists

```bash
docker exec -it db-container psql -U user -d mydb -c "SELECT * FROM users;"
```

**Expected**: Your data should still be there! ✅

---

### Exercise 5: Environment Variable Management

**Create `.env` file**:

```bash
cat > .env << 'EOF'
# Database Configuration
DB_USER=myuser
DB_PASSWORD=securepassword123
DB_NAME=production_db

# Application Configuration
NODE_ENV=production
APP_PORT=3000

# Nginx Configuration
NGINX_HOST=myapp.local
NGINX_PORT=80
EOF
```

**Update docker-compose.yml** to use variables:

```yaml
db:
  environment:
    POSTGRES_USER: ${DB_USER}
    POSTGRES_PASSWORD: ${DB_PASSWORD}
    POSTGRES_DB: ${DB_NAME}
```

**Deploy with environment variables**:

```bash
docker-compose -f docker-compose-sample.yml --env-file .env up -d
```

---

## 🔧 Troubleshooting Guide

### Issue 1: Port Already in Use

**Error**:

```
Error starting userland proxy: listen tcp 0.0.0.0:8080: bind: address already in use
```

**Solution**:

```bash
# Find process using port 8080
lsof -i :8080

# Kill the process
kill -9 <PID>

# Or change port in docker-compose.yml
ports:
  - "8081:80"  # Use different host port
```

---

### Issue 2: Database Connection Failed

**Error**:

```
Error: connect ECONNREFUSED db:5432
```

**Solutions**:

1. **Check if database is ready**:

```bash
docker exec db-container pg_isready
```

2. **Add healthcheck** to docker-compose.yml:

```yaml
db:
  healthcheck:
    test: ["CMD-SHELL", "pg_isready -U user"]
    interval: 10s
    timeout: 5s
    retries: 5
```

3. **Update depends_on** with condition:

```yaml
app:
  depends_on:
    db:
      condition: service_healthy
```

---

### Issue 3: Volume Permission Issues

**Error**:

```
Permission denied: '/var/lib/postgresql/data'
```

**Solution**:

```yaml
db:
  volumes:
    - db-data:/var/lib/postgresql/data
  user: "999:999" # PostgreSQL user:group
```

---

## 📊 Service Management Commands

### Start/Stop Services

```bash
# Start all services
docker-compose -f docker-compose-sample.yml up -d

# Start specific service
docker-compose -f docker-compose-sample.yml up -d web

# Stop all services
docker-compose -f docker-compose-sample.yml stop

# Stop specific service
docker-compose -f docker-compose-sample.yml stop app

# Restart service
docker-compose -f docker-compose-sample.yml restart app
```

### View Status and Logs

```bash
# View running services
docker-compose -f docker-compose-sample.yml ps

# View logs
docker-compose -f docker-compose-sample.yml logs

# Follow logs
docker-compose -f docker-compose-sample.yml logs -f app

# View resource usage
docker stats app-container db-container
```

### Clean Up

```bash
# Stop and remove containers
docker-compose -f docker-compose-sample.yml down

# Remove containers and volumes
docker-compose -f docker-compose-sample.yml down -v

# Remove everything including images
docker-compose -f docker-compose-sample.yml down -v --rmi all
```

---

## 🎓 Key Takeaways

After completing this lab, you should understand:

✅ **Complete Compose File Structure**

- Version declaration and compatibility
- Service definitions and configuration
- Volume and network management

✅ **Service Configuration**

- Image-based vs build-based services
- Port mapping and networking
- Environment variable management
- Container naming and identification

✅ **Networking Architecture**

- Multi-network design for security
- Service discovery and DNS resolution
- Network isolation patterns

✅ **Data Persistence**

- Named volumes vs bind mounts
- Volume lifecycle management
- Backup and restore strategies

✅ **Dependency Management**

- Service startup order with `depends_on`
- Health checks for service readiness
- Graceful shutdown handling

✅ **Production Best Practices**

- Environment-based configuration
- Restart policies for reliability
- Security considerations

---

## 🔗 Additional Resources

- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Compose File Reference](https://docs.docker.com/compose/compose-file/)
- [Docker Networking Guide](https://docs.docker.com/network/)
- [Volume Management](https://docs.docker.com/storage/volumes/)
- [Best Practices for Compose](https://docs.docker.com/compose/production/)

---

## ➡️ Next Steps

Now that you understand multi-container applications, proceed to:

- **Lab 003**: Deep dive into Docker Compose file structure
- **Lab 004**: Advanced networking configurations
- **Lab 005**: Production deployment strategies

---

## 📝 Navigation

[← Previous: 001-intro](../001-intro/README.md) | [Next: 002-Structure →](../002-Structure/README.md)
