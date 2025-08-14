#!/bin/bash

# 🚀 NEXUS - Neural EXperience Unified System
# AI-Powered Workspace Intelligence for Apple Silicon
# 
# Author: Eduardo Giovannini
# Version: 0.1.0
# License: MIT

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
CONFIGS_DIR="$PROJECT_ROOT/configs"
PROFILES_DIR="$CONFIGS_DIR/profiles"
LOGS_DIR="$PROJECT_ROOT/logs"
DATA_DIR="$PROJECT_ROOT/data"
DASHBOARD_DIR="$PROJECT_ROOT/dashboard"

# Ensure required directories exist
mkdir -p "$LOGS_DIR" "$DATA_DIR"

# Logging function
log() {
    local level="$1"
    shift
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    case "$level" in
        "INFO") echo -e "${BLUE}[INFO]${NC} $timestamp: $message" ;;
        "SUCCESS") echo -e "${GREEN}[SUCCESS]${NC} $timestamp: $message" ;;
        "WARNING") echo -e "${YELLOW}[WARNING]${NC} $timestamp: $message" ;;
        "ERROR") echo -e "${RED}[ERROR]${NC} $timestamp: $message" ;;
        "DEBUG") echo -e "${PURPLE}[DEBUG]${NC} $timestamp: $message" ;;
    esac
    
    # Also log to file
    echo "[$level] $timestamp: $message" >> "$LOGS_DIR/nexus.log"
}

# Error handling
error_exit() {
    log "ERROR" "$1"
    exit 1
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check system requirements
check_requirements() {
    log "INFO" "Checking system requirements..."
    
    # Check Python
    if ! command_exists python3; then
        error_exit "Python 3.11+ is required but not installed"
    fi
    
    # Check Python version
    local python_version=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
    if [[ ! "$python_version" =~ ^(3\.1[1-9]|3\.[2-9][0-9])$ ]]; then
        error_exit "Python 3.11+ is required, found $python_version"
    fi
    
    # Check YABAI
    if ! command_exists yabai; then
        log "WARNING" "YABAI not found. Install with: brew install yabai"
    fi
    
    # Check SKHD
    if ! command_exists skhd; then
        log "WARNING" "SKHD not found. Install with: brew install skhd"
    fi
    
    log "SUCCESS" "System requirements check completed"
}

# Check YABAI status
check_yabai_status() {
    log "INFO" "Checking YABAI status..."
    
    if ! command_exists yabai; then
        log "WARNING" "YABAI is not installed"
        return 1
    fi
    
    if pgrep -x "yabai" >/dev/null; then
        log "SUCCESS" "YABAI is running"
        return 0
    else
        log "WARNING" "YABAI is not running"
        return 1
    fi
}

# Start YABAI service
start_yabai() {
    log "INFO" "Starting YABAI service..."
    
    if command_exists yabai; then
        yabai --start-service || log "WARNING" "Failed to start YABAI service"
        sleep 2
        
        if check_yabai_status; then
            log "SUCCESS" "YABAI service started successfully"
        else
            log "WARNING" "YABAI service may not be running properly"
        fi
    else
        log "ERROR" "YABAI is not installed"
    fi
}

# Load workspace profile
load_profile() {
    local profile_name="$1"
    local profile_file="$PROFILES_DIR/${profile_name}.sh"
    
    if [[ ! -f "$profile_file" ]]; then
        error_exit "Profile '$profile_name' not found: $profile_file"
    fi
    
    log "INFO" "Loading workspace profile: $profile_name"
    
    # Make profile executable
    chmod +x "$profile_file"
    
    # Source and execute profile
    if source "$profile_file"; then
        log "SUCCESS" "Profile '$profile_name' loaded successfully"
    else
        error_exit "Failed to load profile '$profile_name'"
    fi
}

# Launch dashboard
launch_dashboard() {
    log "INFO" "Launching NEXUS dashboard..."
    
    if [[ ! -d "$DASHBOARD_DIR" ]]; then
        error_exit "Dashboard directory not found: $DASHBOARD_DIR"
    fi
    
    cd "$DASHBOARD_DIR"
    
    # Check if Streamlit is available
    if command_exists streamlit; then
        log "INFO" "Starting Streamlit dashboard..."
        streamlit run interactive_guide.py --server.port 8501 --server.headless true &
        log "SUCCESS" "Dashboard started at http://localhost:8501"
    else
        log "WARNING" "Streamlit not found, trying Python module..."
        python3 -m streamlit run interactive_guide.py --server.port 8501 --server.headless true &
        log "SUCCESS" "Dashboard started at http://localhost:8501"
    fi
}

# Check system status
check_system_status() {
    log "INFO" "Checking NEXUS system status..."
    
    echo -e "\n${CYAN}=== NEXUS System Status ===${NC}\n"
    
    # Check YABAI
    echo -e "${BLUE}YABAI Status:${NC}"
    if check_yabai_status; then
        echo -e "  ${GREEN}✓ Running${NC}"
        yabai -m query --spaces | jq '.[] | {id: .index, label: .label, windows: .windows | length}' 2>/dev/null || echo "  No spaces found"
    else
        echo -e "  ${RED}✗ Not running${NC}"
    fi
    
    # Check SKHD
    echo -e "\n${BLUE}SKHD Status:${NC}"
    if pgrep -x "skhd" >/dev/null; then
        echo -e "  ${GREEN}✓ Running${NC}"
    else
        echo -e "  ${RED}✗ Not running${NC}"
    fi
    
    # Check Python environment
    echo -e "\n${BLUE}Python Environment:${NC}"
    if [[ -d "$PROJECT_ROOT/.venv" ]]; then
        echo -e "  ${GREEN}✓ Virtual environment found${NC}"
        echo -e "  Python: $(python3 --version)"
    else
        echo -e "  ${YELLOW}⚠ No virtual environment found${NC}"
    fi
    
    # Check available profiles
    echo -e "\n${BLUE}Available Profiles:${NC}"
    if [[ -d "$PROFILES_DIR" ]]; then
        for profile in "$PROFILES_DIR"/*.sh; do
            if [[ -f "$profile" ]]; then
                local name=$(basename "$profile" .sh)
                echo -e "  • $name"
            fi
        done
    else
        echo -e "  ${RED}✗ Profiles directory not found${NC}"
    fi
    
    # Check disk space
    echo -e "\n${BLUE}Disk Space:${NC}"
    df -h "$PROJECT_ROOT" | tail -1 | awk '{print "  " $4 " available on " $1}'
    
    echo -e "\n${CYAN}=== End Status ===${NC}\n"
}

# Show main menu
show_menu() {
    echo -e "\n${CYAN}🚀 NEXUS - Neural EXperience Unified System${NC}"
    echo -e "${BLUE}AI-Powered Workspace Intelligence for Apple Silicon${NC}\n"
    
    echo -e "${YELLOW}Available Commands:${NC}"
    echo -e "  ${GREEN}1)${NC}  Load Work Profile"
    echo -e "  ${GREEN}2)${NC}  Load Personal Profile"
    echo -e "  ${GREEN}3)${NC}  Load AI Research Profile"
    echo -e "  ${GREEN}4)${NC}  Load Focus Profile"
    echo -e "  ${GREEN}5)${NC}  Load Gaming Profile"
    echo -e "  ${GREEN}6)${NC}  Load Learning Profile"
    echo -e "  ${GREEN}7)${NC}  Load AI Business Profile"
    echo -e "  ${GREEN}8)${NC}  Load AI Content Creation Profile"
    echo -e "  ${GREEN}9)${NC}  Load AI Development Profile"
    echo -e "  ${GREEN}10)${NC} Load AI Gaming Profile"
    echo -e "  ${GREEN}11)${NC} Load AI Learning Profile"
    echo -e "  ${GREEN}12)${NC} System Status Check"
    echo -e "  ${GREEN}13)${NC} Launch Dashboard"
    echo -e "  ${GREEN}14)${NC} Start YABAI Service"
    echo -e "  ${GREEN}15)${NC} Check Requirements"
    echo -e "  ${GREEN}16)${NC} Exit"
    
    echo -e "\n${YELLOW}Usage Examples:${NC}"
    echo -e "  ${CYAN}./launcher.sh work_profile${NC}     # Load specific profile"
    echo -e "  ${CYAN}./launcher.sh dashboard${NC}        # Launch dashboard"
    echo -e "  ${CYAN}./launcher.sh status${NC}           # Check system status"
    echo -e "  ${CYAN}./launcher.sh${NC}                  # Show this menu"
}

# Main function
main() {
    local command="${1:-}"
    
    # Change to project root
    cd "$PROJECT_ROOT"
    
    # Check requirements first
    check_requirements
    
    case "$command" in
        "work_profile"|"1")
            load_profile "work_profile"
            ;;
        "personal_profile"|"2")
            load_profile "personal_profile"
            ;;
        "ai_research_profile"|"3")
            load_profile "ai_research_profile"
            ;;
        "focus_profile"|"4")
            load_profile "focus_profile"
            ;;
        "gaming_profile"|"5")
            load_profile "gaming_profile"
            ;;
        "learning_profile"|"6")
            load_profile "learning_profile"
            ;;
        "ai_business_profile"|"7")
            load_profile "ai_business_profile"
            ;;
        "ai_content_creation_profile"|"8")
            load_profile "ai_content_creation_profile"
            ;;
        "ai_development_profile"|"9")
            load_profile "ai_development_profile"
            ;;
        "ai_gaming_profile"|"10")
            load_profile "ai_gaming_profile"
            ;;
        "ai_learning_profile"|"11")
            load_profile "ai_learning_profile"
            ;;
        "status"|"12")
            check_system_status
            ;;
        "dashboard"|"13")
            launch_dashboard
            ;;
        "start_yabai"|"14")
            start_yabai
            ;;
        "check_requirements"|"15")
            check_requirements
            ;;
        "exit"|"16"|"quit")
            log "INFO" "Exiting NEXUS launcher"
            exit 0
            ;;
        "")
            show_menu
            ;;
        *)
            log "ERROR" "Unknown command: $command"
            echo -e "\n${RED}Unknown command: $command${NC}"
            show_menu
            exit 1
            ;;
    esac
}

# Handle script interruption
trap 'log "WARNING" "Script interrupted"; exit 1' INT TERM

# Run main function with all arguments
main "$@" 