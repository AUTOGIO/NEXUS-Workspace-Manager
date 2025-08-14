#!/bin/zsh
# Production-Ready Screen Time Collector for NEXUS
# Best Practices: Idempotent, Observable, Safe

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
DATA_DIR="$PROJECT_DIR/data/current"
LOG_FILE="$PROJECT_DIR/logs/analytics/screen_time.log"
PID_FILE="$PROJECT_DIR/.screen_time_collector.pid"

# Configuration
COLLECTION_INTERVAL="${COLLECTION_INTERVAL:-60}"  # seconds
MAX_LOG_SIZE="${MAX_LOG_SIZE:-10485760}"  # 10MB
LOG_ROTATION_COUNT="${LOG_ROTATION_COUNT:-5}"

# Ensure directories exist
mkdir -p "$DATA_DIR" "$(dirname "$LOG_FILE")"

# Logging function with best practices
log_message() {
    local level="$1"
    local message="$2"
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    echo "[$timestamp] [$level] $message" | tee -a "$LOG_FILE"
}

# Check if already running
check_running() {
    if [ -f "$PID_FILE" ]; then
        local pid=$(cat "$PID_FILE")
        if kill -0 "$pid" 2>/dev/null; then
            log_message "WARN" "Screen time collector already running (PID: $pid)"
        return 0
    else
            log_message "INFO" "Removing stale PID file"
            rm -f "$PID_FILE"
        fi
    fi
    return 1
}

# Rotate logs if needed
rotate_logs() {
    if [ -f "$LOG_FILE" ] && [ $(stat -f%z "$LOG_FILE" 2>/dev/null || echo 0) -gt $MAX_LOG_SIZE ]; then
        log_message "INFO" "Rotating log file (size exceeded $MAX_LOG_SIZE bytes)"
        
        for i in $(seq $((LOG_ROTATION_COUNT - 1)) -1 1); do
            if [ -f "${LOG_FILE}.$i" ]; then
                mv "${LOG_FILE}.$i" "${LOG_FILE}.$((i + 1))"
            fi
        done
        
        if [ -f "$LOG_FILE" ]; then
            mv "$LOG_FILE" "${LOG_FILE}.1"
        fi
        
        touch "$LOG_FILE"
    fi
}

# Get frontmost app info safely
get_frontmost_app() {
    osascript 2>/dev/null <<EOF || echo "Unknown,com.unknown"
tell application "System Events"
    set frontApp to name of first application process whose frontmost is true
    set frontAppBundle to bundle identifier of first application process whose frontmost is true
    return frontApp & "," & frontAppBundle
end tell
EOF
}

# Get current display safely
get_current_display() {
    osascript 2>/dev/null <<EOF || echo "Unknown"
tell application "System Events"
    try
        set frontApp to name of first application process whose frontmost is true
        set frontWindow to window 1 of process frontApp
        set windowPosition to position of frontWindow
        set screenBounds to bounds of window of desktop
        if item 1 of windowPosition < (item 1 of screenBounds / 2) then
            return "HZ30GAMER"
        else if item 1 of windowPosition < item 1 of screenBounds then
            return "LG ULTRAWIDE"
        else
            return "iMac"
        end if
    on error
        return "Unknown"
    end try
end tell
EOF
}

# Collect screen time data with error handling
collect_screen_time() {
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    local app_info=$(get_frontmost_app)
    local frontmost_app=$(echo "$app_info" | cut -d',' -f1)
    local bundle_id=$(echo "$app_info" | cut -d',' -f2)
    local display=$(get_current_display)
    local profile=$(basename "$(pwd)" 2>/dev/null || echo "unknown")
    
    # Validate data
    if [ "$frontmost_app" = "Unknown" ] || [ "$bundle_id" = "com.unknown" ]; then
        log_message "WARN" "Could not determine frontmost app"
        return 1
    fi
    
    # Create JSONL record
    local record=$(cat <<EOF
{"ts":"$timestamp","frontmost":"$frontmost_app","bundle":"$bundle_id","display":"$display","profile":"$profile","collector":"screen_time_collector"}
EOF
)
    
    # Write to data file atomically
    local temp_file="$DATA_DIR/screen_time.tmp"
    echo "$record" > "$temp_file"
    mv "$temp_file" "$DATA_DIR/screen_time.jsonl"
    
    # Append to log
    log_message "INFO" "Collected: $frontmost_app on $display (profile: $profile)"
    
    echo "$record"
}

# Signal handler for graceful shutdown
cleanup() {
    log_message "INFO" "Shutting down screen time collector"
    rm -f "$PID_FILE"
    exit 0
}

# Main execution
main() {
    # Set up signal handlers
    trap cleanup SIGTERM SIGINT
    
    # Check if already running
    if check_running; then
        exit 0
    fi
    
    # Write PID file
    echo $$ > "$PID_FILE"
    
    log_message "INFO" "Starting screen time collector (PID: $$)"
    log_message "INFO" "Data directory: $DATA_DIR"
    log_message "INFO" "Collection interval: ${COLLECTION_INTERVAL}s"
    
    # Main collection loop
    while true; do
        # Rotate logs if needed
        rotate_logs
        
        # Collect data
        if collect_screen_time; then
            # Success - continue
            :
        else
            log_message "ERROR" "Failed to collect screen time data"
        fi
        
        # Wait for next collection
        sleep "$COLLECTION_INTERVAL"
    done
}

# Command line interface
case "${1:-}" in
    "monitor")
        main
        ;;
    "collect")
        collect_screen_time
        ;;
    "status")
        if check_running; then
            echo "✅ Running (PID: $(cat "$PID_FILE"))"
        else
            echo "❌ Not running"
        fi
        ;;
    "stop")
        if [ -f "$PID_FILE" ]; then
            local pid=$(cat "$PID_FILE")
            if kill -0 "$pid" 2>/dev/null; then
                kill "$pid"
                echo "✅ Stopped screen time collector (PID: $pid)"
            else
                echo "⚠️  Process not running"
            fi
            rm -f "$PID_FILE"
        else
            echo "⚠️  PID file not found"
        fi
        ;;
    *)
        echo "Usage: $0 {monitor|collect|status|stop}"
        echo ""
        echo "Commands:"
        echo "  monitor  - Start continuous monitoring"
        echo "  collect  - Collect single data point"
        echo "  status   - Check if collector is running"
        echo "  stop     - Stop running collector"
        exit 1
        ;;
esac 