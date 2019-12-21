#!/bin/bash

# Docker Compose Watch Demo Script
# This script demonstrates Docker Compose Watch functionality

echo "🐳 Docker Compose Watch Demo"
echo "============================="
echo

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null 2>&1; then
    echo "❌ Docker Compose is not installed or not available"
    echo "Please install Docker Compose v2.22+ to use the watch feature"
    exit 1
fi

# Check Docker Compose version for watch support
echo "📋 Checking Docker Compose version..."
if docker compose version &> /dev/null 2>&1; then
    COMPOSE_CMD="docker compose"
    VERSION=$(docker compose version --short 2>/dev/null || echo "unknown")
    echo "✅ Using Docker Compose v$VERSION"
else
    COMPOSE_CMD="docker-compose"
    VERSION=$(docker-compose version --short 2>/dev/null || echo "unknown")
    echo "⚠️  Using Docker Compose v$VERSION (watch feature requires v2.22+)"
fi

echo

# Create sample project structure
echo "📁 Creating sample project structure..."
mkdir -p frontend/src frontend/public
mkdir -p backend/src backend/app backend/config
mkdir -p nginx/conf.d
mkdir -p db
mkdir -p redis

# Create sample files
echo "📝 Creating sample files..."

# Frontend files
cat > frontend/Dockerfile << 'EOF'
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
EOF

cat > frontend/package.json << 'EOF'
{
  "name": "frontend-demo",
  "version": "1.0.0",
  "scripts": {
    "start": "echo 'Frontend server running on port 3000' && sleep infinity"
  },
  "dependencies": {
    "react": "^18.0.0"
  }
}
EOF

cat > frontend/src/App.js << 'EOF'
// Sample React component
function App() {
  return (
    <div>
      <h1>Docker Compose Watch Demo</h1>
      <p>Edit this file to see hot reload in action!</p>
    </div>
  );
}

export default App;
EOF

# Backend files
cat > backend/Dockerfile << 'EOF'
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8000
CMD ["npm", "start"]
EOF

cat > backend/package.json << 'EOF'
{
  "name": "backend-demo",
  "version": "1.0.0",
  "scripts": {
    "start": "echo 'Backend server running on port 8000' && sleep infinity"
  },
  "dependencies": {
    "express": "^4.18.0"
  }
}
EOF

cat > backend/src/server.js << 'EOF'
// Sample Express server
const express = require('express');
const app = express();
const port = 8000;

app.get('/', (req, res) => {
  res.json({ 
    message: 'Hello from Docker Compose Watch Demo!',
    timestamp: new Date().toISOString()
  });
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
EOF

# Configuration files
cat > backend/config/app.config.js << 'EOF'
module.exports = {
  port: 8000,
  database: {
    host: 'db',
    port: 5432,
    database: 'devdb'
  },
  redis: {
    host: 'redis',
    port: 6379
  }
};
EOF

cat > nginx/nginx.conf << 'EOF'
events {
    worker_connections 1024;
}

http {
    upstream frontend {
        server frontend:3000;
    }
    
    upstream backend {
        server backend:8000;
    }
    
    server {
        listen 80;
        
        location / {
            proxy_pass http://frontend;
        }
        
        location /api {
            proxy_pass http://backend;
        }
    }
}
EOF

cat > db/init.sql << 'EOF'
-- Sample database initialization
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (name, email) VALUES 
('Demo User', 'demo@example.com'),
('Test User', 'test@example.com');
EOF

cat > redis/redis.conf << 'EOF'
# Redis configuration for development
port 6379
bind 0.0.0.0
save 900 1
save 300 10
save 60 10000
EOF

echo "✅ Sample project structure created!"
echo

# Show directory structure
echo "📂 Project structure:"
find . -type f -name "*.js" -o -name "*.json" -o -name "*.conf" -o -name "*.sql" -o -name "Dockerfile" | sort

echo
echo "🚀 Demo Instructions:"
echo "===================="
echo
echo "1. Start services with watch mode:"
echo "   $COMPOSE_CMD up --watch"
echo
echo "2. In another terminal, try editing these files to see watch in action:"
echo "   • frontend/src/App.js - triggers sync action"
echo "   • backend/src/server.js - triggers sync action"
echo "   • frontend/package.json - triggers rebuild action"
echo "   • backend/config/app.config.js - triggers restart action"
echo
echo "3. Watch the logs to see when files are detected and actions are triggered"
echo
echo "4. Stop the demo:"
echo "   $COMPOSE_CMD down"
echo
echo "📚 For more information, see the README.md file"
echo
echo "Happy coding! 🎉"
