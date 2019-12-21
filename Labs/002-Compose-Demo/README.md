# Explanation of the Docker Compose File

This `docker-compose-sample.yml` file defines a multi-container application with three services: `web`, `app`, and `db`. Below is a detailed explanation of each section:

---

## Version

The Compose file uses version `3.9`, which is compatible with the latest Docker Compose features.

---

## Services

### 1. `web` Service

- **Image**: Uses the official `nginx:latest` image.
- **Container Name**: The container is named `web-container`.
- **Ports**: Maps port `8080` on the host to port `80` in the container.
- **Environment Variables**:
  - `NGINX_HOST`: Set to `localhost`.
  - `NGINX_PORT`: Set to `80`.
- **Volumes**: Mounts the `./web-data` directory on the host to `/usr/share/nginx/html` in the container, allowing you to serve custom static files.
- **Networks**: Connects to the `webnet` network.
- **Restart Policy**: Always restarts the container if it stops.

### 2. `app` Service

- **Build**: Builds the image from a Dockerfile located in the `./app` directory.
- **Container Name**: The container is named `app-container`.
- **Ports**: Maps port `3000` on the host to port `3000` in the container.
- **Environment Variables**:
  - `NODE_ENV`: Set to `production`.
- **Dependencies**: Depends on the `db` service, ensuring the database starts before the app.
- **Networks**: Connects to both `webnet` and `dbnet` networks.
- **Restart Policy**: Restarts the container on failure.

### 3. `db` Service

- **Image**: Uses the official `postgres:latest` image.
- **Container Name**: The container is named `db-container`.
- **Environment Variables**:
  - `POSTGRES_USER`: Set to `user`.
  - `POSTGRES_PASSWORD`: Set to `password`.
  - `POSTGRES_DB`: Set to `mydb`.
- **Volumes**: Mounts a named volume `db-data` to `/var/lib/postgresql/data` in the container, persisting database data.
- **Networks**: Connects to the `dbnet` network.
- **Restart Policy**: Restarts the container unless stopped manually.

---

## Volumes

- **`db-data`**: A named volume used by the `db` service to persist PostgreSQL data.

---

## Networks

- **`webnet`**: A custom network used by the `web` and `app` services to communicate.
- **`dbnet`**: A custom network used by the `app` and `db` services to communicate.

---

This Compose file demonstrates how to define services, manage dependencies, and configure networks and volumes for a multi-container application.