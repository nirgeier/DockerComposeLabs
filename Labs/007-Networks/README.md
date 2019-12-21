![](../../resources/lab.jpg)
[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/nirgeier/DockerComposeLabs)

### **<kbd>CTRL</kbd> + click to open in new window**

---

# Docker Compose Multi-Network Architecture

This lab demonstrates advanced Docker Compose networking concepts through a comprehensive multi-tier application architecture. You'll learn how to design, implement, and manage complex network topologies using multiple custom networks with different configurations.

## Description

This lab showcases a production-like microservices architecture with proper network segmentation, security boundaries, and service isolation. The example includes 8 different networks, each serving specific purposes and demonstrating various networking patterns used in enterprise applications.

## Prerequisites

- Docker and Docker Compose installed
- Basic understanding of Docker networking concepts
- Familiarity with microservices architecture
- Knowledge of network security principles

## Architecture Overview

The application demonstrates a multi-tier architecture with the following layers:

### Network Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                          DMZ Network                            │
│  ┌─────────────┐                    ┌─────────────────────────┐ │
│  │   Nginx     │                    │      Grafana            │ │
│  │  (Proxy)    │                    │   (Monitoring UI)       │ │
│  └─────────────┘                    └─────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
           │                                         │
┌─────────────────────────────────────────────────────────────────┐
│                     Frontend Network                            │
│  ┌─────────────┐                    ┌─────────────────────────┐ │
│  │  Web App    │                    │   Redis Session        │ │
│  │ (Frontend)  │                    │      Store             │ │
│  └─────────────┘                    └─────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
           │
┌─────────────────────────────────────────────────────────────────┐
│                     Backend Network                             │
│  ┌─────────────┐                                               │
│  │ API Gateway │                                               │
│  │  (Router)   │                                               │
│  └─────────────┘                                               │
└─────────────────────────────────────────────────────────────────┘
           │
┌─────────────────────────────────────────────────────────────────┐
│                    Services Network                             │
│  ┌─────────────┐  ┌─────────────┐  ┌──────────────────────────┐│
│  │User Service │  │Order Service│  │  Notification Service   ││
│  │   (API)     │  │    (API)    │  │        (API)             ││
│  └─────────────┘  └─────────────┘  └──────────────────────────┘│
└─────────────────────────────────────────────────────────────────┘
     │         │                │                    │
┌──────────┐ ┌─────────────────────────────────────────────────────┐
│ Database │ │              Messaging Network                      │
│ Network  │ │  ┌─────────────┐                                   │
│ ┌──────┐ │ │  │  RabbitMQ   │                                   │
│ │Redis │ │ │  │ (Message    │                                   │
│ │Cache │ │ │  │   Queue)    │                                   │
│ │      │ │ │  └─────────────┘                                   │
│ └──────┘ │ └─────────────────────────────────────────────────────┘
│ ┌──────┐ │              │
│ │Post  │ │ ┌─────────────────────────────────────────────────────┐
│ │greSQL│ │ │             External Network                        │
│ │  DBs │ │ │  ┌─────────────┐                                   │
│ └──────┘ │ │  │   MailHog   │                                   │
└──────────┘ │  │   (SMTP)    │                                   │
             │  └─────────────┘                                   │
             └─────────────────────────────────────────────────────┘
```

## Network Definitions

### 1. **Frontend Network** (`172.20.0.0/24`)

- **Purpose**: Public-facing services and user interfaces
- **Services**: Web Application, Nginx Proxy, Redis Session Store
- **Security**: Medium - handles user traffic
- **Characteristics**: Bridge network with ICC enabled

### 2. **Backend Network** (`172.21.0.0/24`)

- **Purpose**: Application logic and API gateway
- **Services**: API Gateway, Web Application (as client)
- **Security**: High - internal application communication
- **Characteristics**: Bridge network for API routing

### 3. **Services Network** (`172.22.0.0/24`)

- **Purpose**: Microservices inter-communication
- **Services**: User Service, Order Service, Notification Service, API Gateway, Redis Cache, Prometheus
- **Security**: High - business logic isolation
- **Characteristics**: Internal service mesh communication

### 4. **Database Network** (`172.23.0.0/24`)

- **Purpose**: Data persistence and cache layer
- **Services**: PostgreSQL Primary/Secondary, Redis Cache, Service clients
- **Security**: Very High - sensitive data access
- **Characteristics**: Restricted access, database-specific

### 5. **Messaging Network** (`172.24.0.0/24`)

- **Purpose**: Asynchronous communication and event streaming
- **Services**: RabbitMQ, Order Service, Notification Service
- **Security**: High - event-driven architecture
- **Characteristics**: Message queue isolation

### 6. **External Network** (`172.25.0.0/24`)

- **Purpose**: Third-party services and external APIs
- **Services**: MailHog (SMTP), Notification Service
- **Security**: Variable - external service simulation
- **Characteristics**: ICC disabled for security

### 7. **DMZ Network** (`172.26.0.0/24`)

- **Purpose**: Demilitarized zone for public access
- **Services**: Nginx Proxy, Grafana Dashboard
- **Security**: Medium - public-facing with restrictions
- **Characteristics**: Controlled public access

### 8. **Monitoring Network** (`172.27.0.0/24`)

- **Purpose**: Observability and monitoring services
- **Services**: Prometheus, Grafana
- **Security**: Medium - monitoring and metrics
- **Characteristics**: Cross-network access for metrics collection

## Service Architecture

### Frontend Tier

- **Nginx**: Reverse proxy and load balancer
- **Web Application**: User interface and frontend logic
- **Redis Session**: Session management and user state

### API Layer

- **API Gateway**: Central routing and service discovery
- **Request routing**: Intelligent traffic distribution
- **Authentication**: Centralized security enforcement

### Microservices Tier

- **User Service**: User management and authentication
- **Order Service**: Order processing and business logic
- **Notification Service**: Email and messaging system

### Data Tier

- **PostgreSQL Primary**: Main application database
- **PostgreSQL Secondary**: Orders and analytics database
- **Redis Cache**: Application-level caching

### Infrastructure Services

- **RabbitMQ**: Message queue and event streaming
- **MailHog**: SMTP server simulation
- **Prometheus**: Metrics collection and monitoring
- **Grafana**: Visualization and dashboards

## Network Security Features

### Isolation Strategies

- **Network Segmentation**: Services grouped by function and security requirements
- **Least Privilege**: Services only access required networks
- **DMZ Implementation**: Public services isolated from internal infrastructure

### Security Configurations

```yaml
# Example: High-security database network
database_network:
  driver: bridge
  driver_opts:
    com.docker.network.bridge.enable_icc: "true"
  labels:
    - "network.security=high"
    - "network.description=Database and cache services"
```

### Access Control Patterns

- **Frontend → Backend**: Web app accesses API gateway
- **Backend → Services**: API gateway routes to microservices
- **Services → Database**: Direct database access with specific credentials
- **Cross-network**: Monitoring services access multiple networks

## Network Aliases and Service Discovery

### Service Discovery Examples

```yaml
# Multiple aliases for flexible service discovery
networks:
  frontend_network:
    aliases:
      - webapp
      - frontend-service
  backend_network:
    aliases:
      - web-client
```

### Benefits of Aliases

- **Load Balancing**: Multiple names for the same service
- **Environment Flexibility**: Different names for different contexts
- **Migration Support**: Old and new names during transitions
- **Service Mesh**: Consistent naming across networks

## Lab Exercises

### Exercise 1: Network Inspection

```bash
# List all networks
docker network ls

# Inspect a specific network
docker network inspect 007-networks_frontend_network

# Check service connectivity
docker exec nginx ping web-app
docker exec web-app ping api-gateway
```

### Exercise 2: Service Communication Testing

```bash
# Test cross-network communication
docker exec api-gateway curl http://user-service:8001/health
docker exec user-service pg_isready -h postgres-primary -p 5432

# Test network isolation
docker exec nginx ping postgres-primary  # Should fail
docker exec web-app ping redis-cache     # Should fail
```

### Exercise 3: Network Security Validation

```bash
# Check network isolation
docker exec user-service nslookup postgres-secondary  # Should fail
docker exec order-service nslookup redis-session      # Should fail

# Verify correct access
docker exec user-service nslookup postgres-primary    # Should work
docker exec order-service nslookup postgres-secondary # Should work
```

### Exercise 4: Monitoring Network Traffic

```bash
# Monitor network activity
docker exec prometheus wget -qO- http://grafana:3000/api/health
docker exec grafana curl -s http://prometheus:9090/api/v1/targets

# Check cross-network metrics collection
docker logs prometheus | grep "scrape"
```

## Usage Instructions

### Starting the Application

```bash
# Start all services
docker-compose up -d

# Start specific tiers
docker-compose up -d nginx web-app api-gateway
docker-compose up -d postgres-primary postgres-secondary redis-cache
```

### Monitoring Network Health

```bash
# Check service status
docker-compose ps

# View network connectivity
docker-compose exec nginx wget -qO- http://web-app:3000/health
docker-compose exec api-gateway curl http://user-service:8001/api/status
```

### Accessing Services

- **Web Application**: <http://localhost> (via Nginx)
- **Grafana Dashboard**: <http://localhost:3000>
- **Prometheus Metrics**: <http://localhost:9090>
- **RabbitMQ Management**: <http://localhost:15672>
- **MailHog Web UI**: <http://localhost:8025>

## Network Configuration Details

### IPAM (IP Address Management)

Each network uses a dedicated subnet:

- **Frontend**: `172.20.0.0/24` (254 addresses)
- **Backend**: `172.21.0.0/24` (254 addresses)
- **Services**: `172.22.0.0/24` (254 addresses)
- **Database**: `172.23.0.0/24` (254 addresses)
- **Messaging**: `172.24.0.0/24` (254 addresses)
- **External**: `172.25.0.0/24` (254 addresses)
- **DMZ**: `172.26.0.0/24` (254 addresses)
- **Monitoring**: `172.27.0.0/24` (254 addresses)

### Bridge Network Options

```yaml
driver_opts:
  com.docker.network.bridge.name: "custom-bridge-name"
  com.docker.network.bridge.enable_icc: "true"
  com.docker.network.bridge.enable_ip_masquerade: "true"
```

### Network Labels

```yaml
labels:
  - "network.description=Purpose and usage description"
  - "network.environment=production"
  - "network.security=high|medium|low"
```

## Troubleshooting

### Common Network Issues

1. **Service Discovery Failures**: Check network aliases and DNS resolution
2. **Connection Timeouts**: Verify services are on the same network
3. **Port Conflicts**: Ensure unique port mappings
4. **Network Isolation**: Confirm intended network segmentation

### Debugging Commands

```bash
# Network connectivity
docker exec [container] ping [target]
docker exec [container] nslookup [service-name]
docker exec [container] netstat -rn

# Network inspection
docker network inspect [network-name]
docker network ls --filter driver=bridge
docker inspect [container] | grep NetworkMode
```

### Health Checks

```bash
# Service health verification
curl -f http://localhost/health || echo "Frontend down"
curl -f http://localhost:3000/api/health || echo "Grafana down"
curl -f http://localhost:9090/-/healthy || echo "Prometheus down"
```

## Best Practices

### Network Design

- **Principle of Least Privilege**: Only connect services to necessary networks
- **Defense in Depth**: Multiple layers of network security
- **Service Segmentation**: Group services by function and security requirements
- **Monitoring Integration**: Ensure observability across all networks

### Security Considerations

- **Network Isolation**: Prevent unauthorized cross-network communication
- **Service Discovery**: Use meaningful aliases for better organization
- **Access Control**: Implement proper authentication and authorization
- **Audit Logging**: Monitor and log network access patterns

### Performance Optimization

- **Network Locality**: Place frequently communicating services on the same network
- **Load Distribution**: Use multiple networks to distribute traffic
- **Resource Allocation**: Monitor network utilization and adjust as needed
- **Connection Pooling**: Implement efficient connection management

## Learning Outcomes

After completing this lab, you will understand:

- **Multi-network Architecture**: Design and implement complex network topologies
- **Network Segmentation**: Apply security principles through network isolation
- **Service Discovery**: Configure and use network aliases effectively
- **Cross-network Communication**: Manage service interactions across networks
- **Security Boundaries**: Implement DMZ and security zones
- **Monitoring Integration**: Set up observability across network segments
- **Troubleshooting Networks**: Diagnose and resolve network connectivity issues
- **Production Patterns**: Apply enterprise-grade networking practices

## Advanced Topics

### External Networks

```bash
# Create external network
docker network create --driver bridge production-shared

# Reference in compose file
networks:
  shared_network:
    external: true
    name: production-shared
```

### Network Plugins

- **Overlay Networks**: Multi-host networking
- **Macvlan Networks**: Direct host network access
- **Custom Drivers**: Third-party network solutions

### Container-to-Container Communication

- **Direct IP Access**: Using container IP addresses
- **Service Names**: DNS-based service discovery
- **Network Aliases**: Multiple names for the same service
- **Load Balancing**: Built-in round-robin DNS

## Navigation

[← Previous: 006-Watch](../006-Watch) | [Next: (End of Labs) →](../)
