#!/bin/zsh

# Auto Scheduler for YABAI Workspace
# Automatically switches workspace profiles based on time and context

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Configuration
CONFIG_FILE="configs/yabai_config.yaml"
LOG_FILE="configs/scheduler.log"
CURRENT_PROFILE_FILE="configs/current_profile.txt"

# Function to log messages
log_message() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $message" >> "$LOG_FILE"
    echo "${BLUE}[$timestamp]${NC} $message"
}

# Function to get current time info
get_time_info() {
    CURRENT_HOUR=$(date +%H)
    CURRENT_MINUTE=$(date +%M)
    CURRENT_DAY=$(date +%u)  # 1=Monday, 7=Sunday
    CURRENT_TIME="$CURRENT_HOUR:$CURRENT_MINUTE"
}

# Function to check if time is within range
is_time_in_range() {
    local start_time=$1
    local end_time=$2
    
    # Convert times to minutes for comparison
    local start_minutes=$(echo $start_time | awk -F: '{print $1*60 + $2}')
    local end_minutes=$(echo $end_time | awk -F: '{print $1*60 + $2}')
    local current_minutes=$(echo $CURRENT_TIME | awk -F: '{print $1*60 + $2}')
    
    if [ $start_minutes -le $end_minutes ]; then
        # Same day range
        [ $current_minutes -ge $start_minutes ] && [ $current_minutes -le $end_minutes ]
    else
        # Overnight range
        [ $current_minutes -ge $start_minutes ] || [ $current_minutes -le $end_minutes ]
    fi
}

# Function to check if day is in schedule
is_day_in_schedule() {
    local days=$1
    local current_day=$2
    
    for day in $days; do
        if [ "$day" = "$current_day" ]; then
            return 0
        fi
    done
    return 1
}

# Function to determine appropriate profile
determine_profile() {
    get_time_info
    
    log_message "Checking schedule for day $CURRENT_DAY at $CURRENT_TIME"
    
    # Work hours (Monday-Friday, 9:00-17:00)
    if is_day_in_schedule "1 2 3 4 5" $CURRENT_DAY && is_time_in_range "09:00" "17:00"; then
        echo "work"
        return
    fi
    
    # Research hours (Monday-Friday, 17:00-18:00)
    if is_day_in_schedule "1 2 3 4 5" $CURRENT_DAY && is_time_in_range "17:00" "18:00"; then
        echo "ai_research"
        return
    fi
    
    # Evening/Night hours (All days, 18:00-08:00)
    if is_time_in_range "18:00" "08:00"; then
        echo "personal"
        return
    fi
    
    # Default to personal during non-work hours
    echo "personal"
}

# Function to load profile
load_profile() {
    local profile=$1
    
    # Check if profile is already loaded
    if [ -f "$CURRENT_PROFILE_FILE" ]; then
        local current_profile=$(cat "$CURRENT_PROFILE_FILE")
        if [ "$current_profile" = "$profile" ]; then
            log_message "Profile $profile is already active"
            return
        fi
    fi
    
    log_message "Switching to $profile profile"
    
    case $profile in
        "work")
            if [ -f "workspace_profiles/work_profile.sh" ]; then
                source "workspace_profiles/work_profile.sh"
                echo "work" > "$CURRENT_PROFILE_FILE"
                log_message "Work profile loaded successfully"
            else
                log_message "ERROR: Work profile script not found"
            fi
            ;;
        "personal")
            if [ -f "workspace_profiles/personal_profile.sh" ]; then
                source "workspace_profiles/personal_profile.sh"
                echo "personal" > "$CURRENT_PROFILE_FILE"
                log_message "Personal profile loaded successfully"
            else
                log_message "ERROR: Personal profile script not found"
            fi
            ;;
        "ai_research")
            if [ -f "workspace_profiles/ai_research_profile.sh" ]; then
                source "workspace_profiles/ai_research_profile.sh"
                echo "ai_research" > "$CURRENT_PROFILE_FILE"
                log_message "AI Research profile loaded successfully"
            else
                log_message "ERROR: AI Research profile script not found"
            fi
            ;;
        *)
            log_message "ERROR: Unknown profile $profile"
            ;;
    esac
}

# Function to show current status
show_status() {
    echo "${BLUE}📅 Auto Scheduler Status${NC}"
    echo "========================"
    
    if [ -f "$CURRENT_PROFILE_FILE" ]; then
        local current_profile=$(cat "$CURRENT_PROFILE_FILE")
        echo "${GREEN}Current Profile:${NC} $current_profile"
    else
        echo "${YELLOW}Current Profile:${NC} None"
    fi
    
    get_time_info
    echo "${GREEN}Current Time:${NC} $CURRENT_TIME (Day $CURRENT_DAY)"
    
    local suggested_profile=$(determine_profile)
    echo "${GREEN}Suggested Profile:${NC} $suggested_profile"
    
    echo ""
    echo "${YELLOW}Schedule:${NC}"
    echo "  Work Hours: Mon-Fri 9:00-17:00 → Work Profile"
    echo "  Research Hours: Mon-Fri 17:00-18:00 → AI Research Profile"
    echo "  Evening Hours: Daily 18:00-8:00 → Personal Profile"
}

# Function to run scheduler
run_scheduler() {
    log_message "Starting auto scheduler"
    
    while true; do
        local suggested_profile=$(determine_profile)
        load_profile "$suggested_profile"
        
        # Wait 5 minutes before next check
        sleep 300
    done
}

# Function to show help
show_help() {
    echo "${BLUE}📖 Auto Scheduler Help${NC}"
    echo "======================="
    echo ""
    echo "${GREEN}Usage:${NC}"
    echo "  $0 [command]"
    echo ""
    echo "${GREEN}Commands:${NC}"
    echo "  status    - Show current scheduler status"
    echo "  start     - Start the auto scheduler"
    echo "  stop      - Stop the auto scheduler"
    echo "  manual    - Manually switch to suggested profile"
    echo "  help      - Show this help message"
    echo ""
    echo "${GREEN}Schedule:${NC}"
    echo "  • Work Hours: Monday-Friday 9:00-17:00"
    echo "  • Research Hours: Monday-Friday 17:00-18:00"
    echo "  • Evening Hours: Daily 18:00-8:00"
    echo ""
    echo "${YELLOW}Log File:${NC} $LOG_FILE"
    echo "${YELLOW}Config File:${NC} $CONFIG_FILE"
}

# Main script
case "${1:-help}" in
    "status")
        show_status
        ;;
    "start")
        echo "${GREEN}🚀 Starting auto scheduler...${NC}"
        echo "${YELLOW}Press Ctrl+C to stop${NC}"
        run_scheduler
        ;;
    "stop")
        echo "${YELLOW}🛑 Stopping auto scheduler...${NC}"
        pkill -f "auto_scheduler.sh"
        ;;
    "manual")
        local suggested_profile=$(determine_profile)
        echo "${GREEN}🔄 Manually switching to $suggested_profile profile...${NC}"
        load_profile "$suggested_profile"
        ;;
    "help"|*)
        show_help
        ;;
esac 