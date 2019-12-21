#!/bin/bash

# Docker Compose Multi-Network Demo Script
# This script demonstrates network connectivity and isolation

echo "🌐 Docker Compose Multi-Network Demo"
echo "====================================="
echo

# Check if Docker Compose is available
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null 2>&1; then
    echo "❌ Docker Compose is not installed"
    exit 1
fi

COMPOSE_CMD="docker compose"
if ! docker compose version &> /dev/null 2>&1; then
    COMPOSE_CMD="docker-compose"
fi

echo "📋 Using Docker Compose command: $COMPOSE_CMD"
echo

# Function to test network connectivity
test_connectivity() {
    local from_container=$1
    local to_service=$2
    local expected_result=$3
    
    echo -n "Testing $from_container → $to_service: "
    
    if docker exec "$from_container" ping -c 1 -W 2 "$to_service" >/dev/null 2>&1; then
        if [ "$expected_result" = "success" ]; then
            echo "✅ Connected (Expected)"
        else
            echo "❌ Connected (Unexpected)"
        fi
    else
        if [ "$expected_result" = "fail" ]; then
            echo "✅ Blocked (Expected)"
        else
            echo "❌ Blocked (Unexpected)"
        fi
    fi
}

# Function to show network information
show_network_info() {
    echo "📊 Network Information:"
    echo "======================"
    
    echo
    echo "🔍 Available Networks:"
    docker network ls --filter "name=007-networks" --format "table {{.Name}}\t{{.Driver}}\t{{.Scope}}"
    
    echo
    echo "🔍 Network Details:"
    for network in $(docker network ls --filter "name=007-networks" --format "{{.Name}}"); do
        echo "--- $network ---"
        docker network inspect "$network" --format '{{range .IPAM.Config}}Subnet: {{.Subnet}}{{end}}'
        echo "Connected containers:"
        docker network inspect "$network" --format '{{range $k, $v := .Containers}}  - {{$v.Name}} ({{$v.IPv4Address}}){{end}}'
        echo
    done
}

# Function to demonstrate service discovery
test_service_discovery() {
    echo "🔍 Service Discovery Test:"
    echo "=========================="
    
    echo
    echo "Testing DNS resolution from different services:"
    
    # Test from nginx (should resolve services in frontend and dmz networks)
    echo "From nginx container:"
    docker exec nginx nslookup web-app 2>/dev/null | grep -E "Name:|Address:" || echo "  ❌ web-app not found"
    docker exec nginx nslookup grafana 2>/dev/null | grep -E "Name:|Address:" || echo "  ❌ grafana not found"
    
    echo
    echo "From web-app container:"
    docker exec web-app nslookup api-gateway 2>/dev/null | grep -E "Name:|Address:" || echo "  ❌ api-gateway not found"
    docker exec web-app nslookup postgres-primary 2>/dev/null | grep -E "Name:|Address:" || echo "  ❌ postgres-primary not found (expected)"
    
    echo
}

# Function to test network isolation
test_network_isolation() {
    echo "🔒 Network Isolation Test:"
    echo "=========================="
    echo
    
    echo "Testing expected connections (should work):"
    test_connectivity "nginx" "web-app" "success"
    test_connectivity "web-app" "api-gateway" "success"
    test_connectivity "api-gateway" "user-service" "success"
    test_connectivity "user-service" "postgres-primary" "success"
    test_connectivity "order-service" "postgres-secondary" "success"
    test_connectivity "prometheus" "grafana" "success"
    
    echo
    echo "Testing network isolation (should be blocked):"
    test_connectivity "nginx" "postgres-primary" "fail"
    test_connectivity "web-app" "postgres-primary" "fail"
    test_connectivity "user-service" "postgres-secondary" "fail"
    test_connectivity "order-service" "postgres-primary" "fail"
    test_connectivity "grafana" "postgres-primary" "fail"
    
    echo
}

# Function to show service endpoints
show_service_endpoints() {
    echo "🌐 Service Endpoints:"
    echo "===================="
    echo
    echo "Web Services:"
    echo "  - Main Application: http://localhost"
    echo "  - Grafana Dashboard: http://localhost:3000"
    echo "  - Prometheus: http://localhost:9090"
    echo "  - RabbitMQ Management: http://localhost:15672"
    echo "  - MailHog Web UI: http://localhost:8025"
    echo
    echo "Database Access (for development):"
    echo "  - PostgreSQL Primary: localhost:5432"
    echo
}

# Function to demonstrate network aliases
test_network_aliases() {
    echo "🏷️  Network Aliases Test:"
    echo "========================="
    echo
    
    echo "Testing multiple aliases for the same service:"
    echo "nginx container aliases:"
    docker exec web-app nslookup web-proxy 2>/dev/null | grep -E "Address:" || echo "  ❌ web-proxy alias not found"
    docker exec web-app nslookup load-balancer 2>/dev/null | grep -E "Address:" || echo "  ❌ load-balancer alias not found"
    
    echo
    echo "api-gateway container aliases:"
    docker exec user-service nslookup gateway 2>/dev/null | grep -E "Address:" || echo "  ❌ gateway alias not found"
    docker exec user-service nslookup api-proxy 2>/dev/null | grep -E "Address:" || echo "  ❌ api-proxy alias not found"
    
    echo
}

# Main demo function
run_demo() {
    echo "🚀 Starting Multi-Network Demo..."
    echo
    
    echo "📝 Step 1: Starting services (this may take a few minutes)..."
    $COMPOSE_CMD up -d
    
    echo
    echo "⏳ Waiting for services to be ready..."
    sleep 10
    
    # Check if services are running
    echo "📋 Service Status:"
    $COMPOSE_CMD ps
    echo
    
    # Run tests
    show_network_info
    test_service_discovery
    test_network_isolation
    test_network_aliases
    show_service_endpoints
    
    echo
    echo "📚 Demo completed! Key learnings:"
    echo "================================="
    echo "✅ Services can communicate within the same network"
    echo "✅ Services are isolated between different networks"
    echo "✅ Some services span multiple networks for specific purposes"
    echo "✅ Network aliases provide flexible service discovery"
    echo "✅ Different network configurations serve different security needs"
    echo
    echo "💡 Try exploring the networks manually:"
    echo "   docker network ls"
    echo "   docker network inspect 007-networks_frontend_network"
    echo "   docker exec nginx ping web-app"
    echo "   docker exec web-app ping postgres-primary  # Should fail"
    echo
}

# Function to clean up
cleanup() {
    echo "🧹 Cleaning up..."
    $COMPOSE_CMD down -v
    echo "✅ Cleanup completed"
}

# Main script logic
case "${1:-demo}" in
    "demo"|"run")
        run_demo
        ;;
    "info"|"networks")
        show_network_info
        ;;
    "test"|"connectivity")
        test_network_isolation
        ;;
    "cleanup"|"clean"|"down")
        cleanup
        ;;
    "simple")
        echo "🌐 Running Simple Multi-Network Example..."
        $COMPOSE_CMD -f docker-compose-simple.yml up -d
        echo "✅ Simple example started"
        echo "   - Web: http://localhost"
        echo "   - Admin: http://localhost:8080"
        ;;
    "help"|*)
        echo "Docker Compose Multi-Network Demo"
        echo "================================="
        echo
        echo "Usage: $0 [command]"
        echo
        echo "Commands:"
        echo "  demo, run     - Run the complete demo (default)"
        echo "  info          - Show network information"
        echo "  test          - Test network connectivity"
        echo "  simple        - Run simple multi-network example"
        echo "  cleanup       - Stop services and cleanup"
        echo "  help          - Show this help message"
        echo
        echo "Examples:"
        echo "  $0              # Run complete demo"
        echo "  $0 simple       # Run simple example"
        echo "  $0 info         # Show network details"
        echo "  $0 cleanup      # Clean up everything"
        ;;
esac
