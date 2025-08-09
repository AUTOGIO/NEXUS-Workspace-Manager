#!/bin/bash

# Dynamic Layout Manager Launcher for YABAI + N8N Workflows v2
# Launches the dynamic layout system with various options

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/configs/dynamic_layout_config.yaml"
LOG_FILE="$SCRIPT_DIR/logs/dynamic_layout.log"

# Create logs directory if it doesn't exist
mkdir -p "$SCRIPT_DIR/logs"

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  Dynamic Layout Manager v2.0${NC}"
    echo -e "${BLUE}  YABAI + N8N Workflows v2${NC}"
    echo -e "${BLUE}================================${NC}"
}

# Function to check dependencies
check_dependencies() {
    print_status "Checking dependencies..."
    
    # Check if Python is available
    if ! command -v python3 &> /dev/null; then
        print_error "Python 3 is not installed"
        exit 1
    fi
    
    # Check if YABAI is running
    if ! pgrep -x "yabai" > /dev/null; then
        print_warning "YABAI is not running. Starting YABAI..."
        brew services start yabai
        sleep 2
    fi
    
    # Check if required Python packages are installed
    python3 -c "import yaml, streamlit" 2>/dev/null || {
        print_warning "Installing required Python packages..."
        pip3 install pyyaml streamlit
    }
    
    print_status "Dependencies check completed"
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [OPTION]"
    echo ""
    echo "Options:"
    echo "  dashboard     Launch Streamlit dashboard"
    echo "  cli          Launch command-line interface"
    echo "  swap         Quick tool swap"
    echo "  profile      Switch profile"
    echo "  status       Show current status"
    echo "  install      Install dependencies"
    echo "  help         Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 dashboard                    # Launch dashboard"
    echo "  $0 cli                         # Launch CLI"
    echo "  $0 swap left code_editor       # Swap left display to code editor"
    echo "  $0 profile work                # Switch to work profile"
    echo "  $0 status                      # Show current status"
}

# Function to launch dashboard
launch_dashboard() {
    print_status "Launching Dynamic Layout Dashboard..."
    
    # Check if Streamlit is installed
    if ! command -v streamlit &> /dev/null; then
        print_warning "Streamlit not found. Installing..."
        pip3 install streamlit
    fi
    
    # Launch the dashboard
    cd "$SCRIPT_DIR"
    streamlit run layout_dashboard.py --server.port 8503 --server.headless true &
    
    # Wait a moment for the server to start
    sleep 3
    
    # Open in browser
    open "http://localhost:8503"
    
    print_status "Dashboard launched at http://localhost:8503"
    print_status "Press Ctrl+C to stop the dashboard"
    
    # Wait for user to stop
    wait
}

# Function to launch CLI
launch_cli() {
    print_status "Launching Dynamic Layout CLI..."
    cd "$SCRIPT_DIR"
    python3 dynamic_layout_manager.py
}

# Function to perform quick swap
quick_swap() {
    if [ $# -lt 2 ]; then
        print_error "Usage: $0 swap <display> <tool>"
        echo "Available displays: left, center, right"
        echo "Available tools: code_editor, terminal, ai_chat, ai_development, productivity, communication, web_browser, n8n_dashboard, n8n_monitoring, entertainment"
        exit 1
    fi
    
    display="$1"
    tool="$2"
    
    print_status "Swapping $tool to $display display..."
    cd "$SCRIPT_DIR"
    python3 dynamic_layout_manager.py swap "$display" "$tool"
}

# Function to switch profile
switch_profile() {
    if [ $# -lt 1 ]; then
        print_error "Usage: $0 profile <profile_name>"
        echo "Available profiles: work, personal, ai_research"
        exit 1
    fi
    
    profile="$1"
    
    print_status "Switching to $profile profile..."
    cd "$SCRIPT_DIR"
    python3 dynamic_layout_manager.py profile "$profile"
}

# Function to show status
show_status() {
    print_status "Showing current layout status..."
    cd "$SCRIPT_DIR"
    python3 dynamic_layout_manager.py status
}

# Function to install dependencies
install_dependencies() {
    print_status "Installing dependencies..."
    
    # Install Python packages
    pip3 install pyyaml streamlit pandas
    
    # Create necessary directories
    mkdir -p "$SCRIPT_DIR/logs"
    mkdir -p "$SCRIPT_DIR/configs"
    
    # Check if YABAI is installed
    if ! command -v yabai &> /dev/null; then
        print_warning "YABAI not found. Installing via Homebrew..."
        brew install yabai
    fi
    
    # Check if jq is installed (for JSON parsing)
    if ! command -v jq &> /dev/null; then
        print_warning "jq not found. Installing via Homebrew..."
        brew install jq
    fi
    
    print_status "Dependencies installed successfully"
}

# Function to setup BetterTouchTool shortcuts
setup_shortcuts() {
    print_status "Setting up BetterTouchTool shortcuts..."
    
    # Check if BetterTouchTool is installed
    if [ ! -d "/Applications/BetterTouchTool.app" ]; then
        print_warning "BetterTouchTool not found. Please install it manually."
        return
    fi
    
    # Create shortcuts configuration
    cat > "$SCRIPT_DIR/configs/btt_shortcuts.json" << 'EOF'
{
  "shortcuts": [
    {
      "name": "Swap Left Display",
      "key": "cmd+shift+1",
      "action": "run_script",
      "script": "python3 /Users/eduardof.giovannini/Desktop/YABAI/dynamic_layout_manager.py swap left web_browser"
    },
    {
      "name": "Swap Center Display", 
      "key": "cmd+shift+2",
      "action": "run_script",
      "script": "python3 /Users/eduardof.giovannini/Desktop/YABAI/dynamic_layout_manager.py swap center code_editor"
    },
    {
      "name": "Swap Right Display",
      "key": "cmd+shift+3", 
      "action": "run_script",
      "script": "python3 /Users/eduardof.giovannini/Desktop/YABAI/dynamic_layout_manager.py swap right productivity"
    },
    {
      "name": "Switch to Work Profile",
      "key": "cmd+shift+w",
      "action": "run_script", 
      "script": "python3 /Users/eduardof.giovannini/Desktop/YABAI/dynamic_layout_manager.py profile work"
    },
    {
      "name": "Switch to Personal Profile",
      "key": "cmd+shift+p",
      "action": "run_script",
      "script": "python3 /Users/eduardof.giovannini/Desktop/YABAI/dynamic_layout_manager.py profile personal"
    },
    {
      "name": "Switch to AI Research Profile",
      "key": "cmd+shift+a",
      "action": "run_script",
      "script": "python3 /Users/eduardof.giovannini/Desktop/YABAI/dynamic_layout_manager.py profile ai_research"
    }
  ]
}
EOF
    
    print_status "BetterTouchTool shortcuts configuration created at configs/btt_shortcuts.json"
    print_warning "Please import this configuration into BetterTouchTool manually"
}

# Function to start background monitoring
start_monitoring() {
    print_status "Starting background monitoring..."
    
    # Create monitoring script
    cat > "$SCRIPT_DIR/monitor_layout.py" << 'EOF'
#!/usr/bin/env python3
"""
Background monitoring for dynamic layout system
"""

import time
import subprocess
from pathlib import Path
from dynamic_layout_manager import DynamicLayoutManager

def monitor_layout():
    manager = DynamicLayoutManager()
    
    while True:
        try:
            # Check current time and switch profiles if needed
            current_hour = time.localtime().tm_hour
            current_day = time.localtime().tm_wday + 1  # Monday = 1
            
            # Work hours (Monday-Friday, 9 AM - 5 PM)
            if current_day <= 5 and 9 <= current_hour < 17:
                if manager.current_profile != "work":
                    print(f"🕘 Switching to work profile at {current_hour}:00")
                    manager.swap_by_profile("work")
            
            # Evening hours (6 PM - 8 AM)
            elif current_hour >= 18 or current_hour < 8:
                if manager.current_profile != "personal":
                    print(f"🌙 Switching to personal profile at {current_hour}:00")
                    manager.swap_by_profile("personal")
            
            # Research hours (5 PM - 6 PM, Monday-Friday)
            elif current_day <= 5 and current_hour == 17:
                if manager.current_profile != "ai_research":
                    print(f"🔬 Switching to AI research profile at {current_hour}:00")
                    manager.swap_by_profile("ai_research")
            
            time.sleep(300)  # Check every 5 minutes
            
        except KeyboardInterrupt:
            print("🛑 Monitoring stopped")
            break
        except Exception as e:
            print(f"❌ Monitoring error: {e}")
            time.sleep(60)

if __name__ == "__main__":
    monitor_layout()
EOF
    
    # Start monitoring in background
    cd "$SCRIPT_DIR"
    python3 monitor_layout.py &
    MONITOR_PID=$!
    
    echo $MONITOR_PID > "$SCRIPT_DIR/logs/monitor.pid"
    print_status "Background monitoring started (PID: $MONITOR_PID)"
}

# Function to stop monitoring
stop_monitoring() {
    if [ -f "$SCRIPT_DIR/logs/monitor.pid" ]; then
        MONITOR_PID=$(cat "$SCRIPT_DIR/logs/monitor.pid")
        if kill -0 $MONITOR_PID 2>/dev/null; then
            kill $MONITOR_PID
            rm "$SCRIPT_DIR/logs/monitor.pid"
            print_status "Background monitoring stopped"
        else
            print_warning "Monitoring process not found"
        fi
    else
        print_warning "No monitoring process found"
    fi
}

# Main script logic
main() {
    print_header
    
    # Check if we're in the right directory
    if [ ! -f "$SCRIPT_DIR/dynamic_layout_manager.py" ]; then
        print_error "Dynamic layout manager not found. Please run this script from the YABAI directory."
        exit 1
    fi
    
    # Parse command line arguments
    case "${1:-help}" in
        dashboard)
            check_dependencies
            launch_dashboard
            ;;
        cli)
            check_dependencies
            launch_cli
            ;;
        swap)
            check_dependencies
            quick_swap "$2" "$3"
            ;;
        profile)
            check_dependencies
            switch_profile "$2"
            ;;
        status)
            check_dependencies
            show_status
            ;;
        install)
            install_dependencies
            ;;
        shortcuts)
            setup_shortcuts
            ;;
        monitor)
            check_dependencies
            start_monitoring
            ;;
        stop-monitor)
            stop_monitoring
            ;;
        help|--help|-h)
            show_usage
            ;;
        *)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
}

# Run main function
main "$@" 