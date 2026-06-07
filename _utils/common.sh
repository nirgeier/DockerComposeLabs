#!/bin/bash

##########################################
### Colors
##########################################

# Load the colors palette
source <(curl -s https://raw.githubusercontent.com/nirgeier/labs-assets/refs/heads/main/assets/scripts/colors.sh) 2>/dev/null || true

##########################################
### Global functions
##########################################

# Get the root folder
ROOT_FOLDER=$(git rev-parse --show-toplevel 2>/dev/null || pwd)

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Print a section header
section() {
    echo ""
    echo "────────────────────────────────────────────────────────"
    echo "  $1"
    echo "────────────────────────────────────────────────────────"
}

# Wait for a service to be healthy
wait_for_healthy() {
    local service="$1"
    local timeout="${2:-60}"
    echo ">>> Waiting for '${service}' to be healthy..."
    for i in $(seq 1 "$timeout"); do
        if docker compose ps "$service" 2>/dev/null | grep -q "healthy"; then
            echo ">>> ${service} is healthy!"
            return 0
        fi
        sleep 1
    done
    echo ">>> Timeout waiting for ${service}"
    return 1
}

# Wait for container logs to contain a pattern
wait_for_logs() {
    local service="$1"
    local pattern="$2"
    local timeout="${3:-30}"
    echo ">>> Waiting for logs pattern '${pattern}' in '${service}'..."
    for i in $(seq 1 "$timeout"); do
        if docker compose logs "$service" 2>/dev/null | grep -q "$pattern"; then
            echo ">>> Pattern found!"
            return 0
        fi
        sleep 1
    done
    echo ">>> Timeout waiting for pattern"
    return 1
}
