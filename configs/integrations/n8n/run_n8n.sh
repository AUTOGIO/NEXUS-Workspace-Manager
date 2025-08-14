#!/bin/zsh
# Run N8N for NEXUS integration - Best Practices Implementation

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Configuration with best practices
N8N_PORT="${N8N_PORT:-5679}"  # Use available port
N8N_PASSWORD="${N8N_PASSWORD:-nexus123}"
N8N_DATA_DIR="${N8N_DATA_DIR:-$PROJECT_DIR/n8n_data}"
N8N_LOGS_DIR="${N8N_LOGS_DIR:-$PROJECT_DIR/logs/n8n}"

# Ensure directories exist
mkdir -p "$N8N_DATA_DIR" "$N8N_LOGS_DIR"

# Check if port is available
if lsof -i :$N8N_PORT &>/dev/null; then
    echo "⚠️  Port $N8N_PORT is occupied, finding next available..."
    for port in $(seq $((N8N_PORT + 1)) $((N8N_PORT + 20))); do
        if ! lsof -i :$port &>/dev/null; then
            N8N_PORT=$port
            echo "✅ Using port $N8N_PORT"
            break
        fi
    done
fi

# Save port to file for other scripts
echo "$N8N_PORT" > "$PROJECT_DIR/.n8n.port"

echo "🚀 Starting N8N for NEXUS Integration"
echo "====================================="
echo "🌐 Port: $N8N_PORT"
echo "📁 Data: $N8N_DATA_DIR"
echo "📝 Logs: $N8N_LOGS_DIR"

# Check if Docker is available
if command -v docker &>/dev/null && command -v docker-compose &>/dev/null; then
    echo "🐳 Using Docker Compose..."
    cd "$SCRIPT_DIR"
    
    # Create environment file
    cat > .env <<EOF
N8N_PORT=$N8N_PORT
N8N_PASSWORD=$N8N_PASSWORD
N8N_DATA_DIR=$N8N_DATA_DIR
N8N_LOGS_DIR=$N8N_LOGS_DIR
EOF
    
    # Start with Docker
    docker-compose up -d
    
    echo "✅ N8N started with Docker on port $N8N_PORT"
    
else
    echo "📦 Using npm installation..."
    
    # Check if n8n is installed
    if ! command -v n8n &>/dev/null; then
        echo "📥 Installing N8N..."
        npm install -g n8n
    fi
    
    # Start N8N with best practices
    echo "🚀 Starting N8N service..."
    N8N_PORT=$N8N_PORT \
    N8N_DATA_FOLDER="$N8N_DATA_DIR" \
    N8N_LOG_LEVEL=info \
    N8N_BASIC_AUTH_ACTIVE=true \
    N8N_BASIC_AUTH_USER=nexus \
    N8N_BASIC_AUTH_PASSWORD="$N8N_PASSWORD" \
    n8n start > "$N8N_LOGS_DIR/n8n.log" 2>&1 &
    
    N8N_PID=$!
    echo "$N8N_PID" > "$PROJECT_DIR/.n8n.pid"
    
    echo "✅ N8N started with npm on port $N8N_PORT (PID: $N8N_PID)"
fi

# Wait for N8N to be ready
echo "⏳ Waiting for N8N to be ready..."
for i in {1..30}; do
    if curl -s "http://localhost:$N8N_PORT" &>/dev/null; then
        echo "✅ N8N is ready and responding!"
        break
    fi
    echo "   Attempt $i/30..."
    sleep 2
done

# Display connection info
echo ""
echo "🎯 NEXUS N8N Integration Ready!"
echo "==============================="
echo "🌐 Dashboard: http://localhost:$N8N_PORT"
echo "🔑 Username: nexus"
echo "🔑 Password: $N8N_PASSWORD"
echo "📁 Data Directory: $N8N_DATA_DIR"
echo "📝 Logs: $N8N_LOGS_DIR"
echo ""
echo "🔗 Test webhook: ./scripts/events/emit_event.sh test"
