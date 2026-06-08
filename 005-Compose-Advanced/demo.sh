#!/bin/bash

# Set the COMPOSE_BAKE variable to true,
# This will  bake the Docker Compose file before starting the containers
COMPOSE_BAKE=true

# Get the root folder of the repository
export ROOT_FOLDER=$(git rev-parse --show-toplevel)

# Export all variables from .env
export $(grep -v '^#' $ROOT_FOLDER/resources/compose/.env | xargs)

## Remove any existing containers
docker-compose --env-file $ROOT_FOLDER/resources/compose/.env down --remove-orphans 

# Spin up the containers
docker-compose --env-file $ROOT_FOLDER/resources/compose/.env up -d --build --remove-orphans 

# Wait for the containers to be ready
while ! curl -s http://localhost:8090/health | grep -q 'healthy'; do
  echo "Waiting for the containers to be ready..."
  sleep 2
done


### Set some demo data for the demo
for i in {1..10}; do
  echo "Sending requests to server [$i]..."
  # Add ping counter 
  curl -s -o /dev/null http://localhost:8090/ping
  # Add error counter
  curl -s -o /dev/null http://localhost:8090/not-found
  sleep 0.25
done