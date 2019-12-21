![](../../resources/lab.jpg)
[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/nirgeier/DockerComposeLabs)

### **<kbd>CTRL</kbd> + click to open in new window**

---

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Advanced Docker Compose Configuration](#advanced-docker-compose-configuration)
  - [Description](#description)
  - [Prerequisites](#prerequisites)
  - [Services Overview](#services-overview)
    - [1. **Grafana**](#1-grafana)
    - [2. **Loki**](#2-loki)
    - [3. **Node Exporter**](#3-node-exporter)
    - [4. **Portainer**](#4-portainer)
    - [5. **Prometheus**](#5-prometheus)
    - [6. **Server**](#6-server)
  - [Key Features Demonstrated](#key-features-demonstrated)
    - [Docker Compose `extends` Feature](#docker-compose-extends-feature)
    - [YAML Anchors and Aliases (v1 file)](#yaml-anchors-and-aliases-v1-file)
    - [External Configuration](#external-configuration)
  - [File Structure](#file-structure)
  - [Usage](#usage)
    - [Running the Standard Configuration](#running-the-standard-configuration)
    - [Running the YAML Anchors Version](#running-the-yaml-anchors-version)
    - [Running the Demo Script](#running-the-demo-script)
  - [Lab Exercises](#lab-exercises)
  - [Learning Outcomes](#learning-outcomes)
  - [Volumes](#volumes)
  - [Networks](#networks)
  - [Navigation](#navigation-)

---

# Advanced Docker Compose Configuration

This lab demonstrates advanced Docker Compose features including the `extends` functionality, YAML anchors, and modular service definitions for a complete monitoring stack.

## Description

This lab showcases two different approaches to creating a comprehensive monitoring and management stack using Docker Compose:

1. **`docker-compose.yaml`** - Demonstrates the `extends` feature for modular service definitions
2. **`docker-compose-v1.yaml`** - Shows YAML anchors and aliases for DRY (Don't Repeat Yourself) configuration

## Prerequisites

- Docker and Docker Compose installed
- Basic understanding of Docker Compose concepts
- Familiarity with monitoring tools (optional but helpful)

## Services Overview

The monitoring stack includes the following services:

### 1. **Grafana**

- **Purpose**: Data visualization and monitoring dashboard
- **Configuration**: Extends from `../../resources/compose/grafana.yaml`
- **Access**: Web-based dashboard for metrics visualization

### 2. **Loki**

- **Purpose**: Log aggregation system for centralized logging
- **Configuration**: Extends from `../../resources/compose/loki.yaml`
- **Integration**: Works with Grafana for log visualization

### 3. **Node Exporter**

- **Purpose**: Hardware and OS metrics exporter for Prometheus
- **Configuration**: Extends from `../../resources/compose/node-exporter.yaml`
- **Function**: Collects system-level metrics

### 4. **Portainer**

- **Purpose**: Docker container management web interface
- **Configuration**: Extends from `../../resources/compose/portainer.yaml`
- **Access**: Web UI for Docker management

### 5. **Prometheus**

- **Purpose**: Time-series metrics collection and monitoring system
- **Configuration**: Extends from `../../resources/compose/prometheus.yaml`
- **Function**: Central metrics collection and alerting

### 6. **Server**

- **Purpose**: Custom application server
- **Configuration**: Extends from `../../resources/compose/server.yaml`
- **Function**: Demo application for monitoring

## Key Features Demonstrated

### Docker Compose `extends` Feature

- **Modularity**: Service definitions are split into separate YAML files
- **Reusability**: Base configurations can be shared across environments
- **Maintainability**: Changes to base services affect all environments

### YAML Anchors and Aliases (v1 file)

- **DRY Principle**: Common configuration defined once with `x-common-config`
- **Consistency**: All services share the same network and environment settings
- **Efficiency**: Reduces repetition and potential for configuration drift

### External Configuration

- **Environment Files**: Shared `.env` file for environment variables
- **Network Configuration**: Custom bridge network for service communication
- **Volume Management**: Named volumes for persistent data storage

## File Structure

```
005-Compose-Advanced/
├── docker-compose.yaml          # Main compose file using extends
├── docker-compose-v1.yaml       # Alternative using YAML anchors
├── demo.sh                      # Demo script
└── README.md                    # This file
```

## Usage

### Running the Standard Configuration

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### Running the YAML Anchors Version

```bash
# Start with the alternative configuration
docker-compose -f docker-compose-v1.yaml up -d

# Stop services
docker-compose -f docker-compose-v1.yaml down
```

### Running the Demo Script

```bash
# Execute the provided demo script
./demo.sh
```

## Lab Exercises

1. **Compare Configurations**: Study both Docker Compose files and identify the differences in approach
2. **Modify Services**: Try adding a new service to both files and observe the configuration differences
3. **Environment Variables**: Explore the shared environment file and understand variable inheritance
4. **Network Communication**: Test inter-service communication within the custom network
5. **Volume Persistence**: Verify that Portainer data persists across container restarts

## Learning Outcomes

After completing this lab, you will understand:

- How to use Docker Compose `extends` for modular configurations
- YAML anchors and aliases for reducing configuration repetition
- Best practices for organizing complex multi-service applications
- Environment variable management in Docker Compose
- Network and volume configuration for production-like setups

## Volumes

- **`portainer_data`**: Local volume for Portainer configuration and data persistence

## Networks

- **`app_network`** (v1 only): Custom bridge network enabling isolated service communication

## Navigation <!-- omit in docs -->

[← Previous: docker-compose.yaml](./docker-compose.yaml) | [Next: demo.sh →](./demo.sh)
