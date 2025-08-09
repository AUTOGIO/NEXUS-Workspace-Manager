#!/bin/zsh

# Screen Time Data Collector
# Integrates with macOS native Screen Time API for workspace analytics

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Configuration
DATA_DIR="configs/screen_time_data"
LOG_FILE="configs/screen_time.log"
SCREEN_TIME_DB="/Users/$(whoami)/Library/Application Support/Knowledge/knowledgeC.db"

# Create data directory if it doesn't exist
mkdir -p "$DATA_DIR"

# Function to log messages
log_message() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $message" >> "$LOG_FILE"
    echo "${BLUE}[$timestamp]${NC} $message"
}

# Function to check if Screen Time is enabled
check_screen_time_enabled() {
    if [ -f "$SCREEN_TIME_DB" ]; then
        echo "${GREEN}✅ Screen Time database found${NC}"
        return 0
    else
        echo "${YELLOW}⚠️  Screen Time database not found${NC}"
        echo "${YELLOW}Enable Screen Time in System Preferences > Screen Time${NC}"
        return 1
    fi
}

# Function to collect app usage data
collect_app_usage() {
    echo "${BLUE}📊 Collecting app usage data...${NC}"
    
    # Get current date
    local current_date=$(date +%Y-%m-%d)
    local output_file="$DATA_DIR/app_usage_$current_date.json"
    
    # Use system_profiler to get app information
    system_profiler SPApplicationsDataType | grep -A 5 "Applications:" > "$DATA_DIR/apps_list.txt"
    
    # Get running applications
    ps aux | grep -E "\.app" | grep -v grep > "$DATA_DIR/running_apps.txt"
    
    # Create JSON structure
    cat > "$output_file" << EOF
{
    "date": "$current_date",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "apps": {
        "running": [],
        "installed": []
    },
    "workspace_profiles": {
        "work": {
            "apps": ["Visual Studio Code", "Xcode", "Terminal", "Postman", "Slack", "Teams"],
            "usage_time": 0
        },
        "personal": {
            "apps": ["WhatsApp", "X", "Spotify", "Netflix", "Obsidian", "Calendar"],
            "usage_time": 0
        },
        "ai_research": {
            "apps": ["PyCharm", "Jupyter Notebook", "Ollama", "LM Studio", "MLX"],
            "usage_time": 0
        }
    }
}
EOF
    
    log_message "App usage data collected: $output_file"
    echo "${GREEN}✅ App usage data saved to $output_file${NC}"
}

# Function to collect display usage data
collect_display_usage() {
    echo "${BLUE}📺 Collecting display usage data...${NC}"
    
    local current_date=$(date +%Y-%m-%d)
    local output_file="$DATA_DIR/display_usage_$current_date.json"
    
    # Get display information from YABAI
    local displays=$(yabai -m query --displays 2>/dev/null)
    
    if [ $? -eq 0 ]; then
        cat > "$output_file" << EOF
{
    "date": "$current_date",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "displays": $displays,
    "active_windows": $(yabai -m query --windows 2>/dev/null || echo "[]")
}
EOF
        
        log_message "Display usage data collected: $output_file"
        echo "${GREEN}✅ Display usage data saved to $output_file${NC}"
    else
        echo "${RED}❌ Failed to collect display data${NC}"
    fi
}

# Function to collect workspace profile data
collect_workspace_data() {
    echo "${BLUE}🎯 Collecting workspace profile data...${NC}"
    
    local current_date=$(date +%Y-%m-%d)
    local output_file="$DATA_DIR/workspace_$current_date.json"
    
    # Get current profile if exists
    local current_profile="none"
    if [ -f "configs/current_profile.txt" ]; then
        current_profile=$(cat "configs/current_profile.txt")
    fi
    
    # Get time-based profile suggestion
    local suggested_profile=$(./scripts/auto_scheduler.sh manual 2>/dev/null | grep "Suggested Profile" | cut -d: -f2 | xargs)
    
    cat > "$output_file" << EOF
{
    "date": "$current_date",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "current_profile": "$current_profile",
    "suggested_profile": "$suggested_profile",
    "time_of_day": "$(date +%H:%M)",
    "day_of_week": "$(date +%u)",
    "session_duration": 0
}
EOF
    
    log_message "Workspace data collected: $output_file"
    echo "${GREEN}✅ Workspace data saved to $output_file${NC}"
}

# Function to generate analytics report
generate_analytics_report() {
    echo "${BLUE}📈 Generating analytics report...${NC}"
    
    local current_date=$(date +%Y-%m-%d)
    local report_file="$DATA_DIR/analytics_report_$current_date.md"
    
    # Count files in data directory
    local app_files=$(ls "$DATA_DIR"/app_usage_*.json 2>/dev/null | wc -l)
    local display_files=$(ls "$DATA_DIR"/display_usage_*.json 2>/dev/null | wc -l)
    local workspace_files=$(ls "$DATA_DIR"/workspace_*.json 2>/dev/null | wc -l)
    
    cat > "$report_file" << EOF
# Screen Time Analytics Report
**Date**: $current_date  
**Generated**: $(date)

## Data Collection Summary
- **App Usage Files**: $app_files
- **Display Usage Files**: $display_files  
- **Workspace Files**: $workspace_files

## Workspace Profile Analysis
- **Current Profile**: $(cat configs/current_profile.txt 2>/dev/null || echo "None")
- **Time of Day**: $(date +%H:%M)
- **Day of Week**: $(date +%A)

## Recent Activity
$(ls -la "$DATA_DIR"/*.json 2>/dev/null | tail -5 | awk '{print "- " $9 " (" $6 " " $7 " " $8 ")"}')

## Recommendations
1. **Profile Optimization**: Based on current time and usage patterns
2. **App Usage**: Monitor frequently used applications
3. **Display Utilization**: Track multi-display usage patterns
4. **Productivity Insights**: Identify peak productivity hours

---
*Generated by YABAI Workspace Manager Screen Time Collector*
EOF
    
    log_message "Analytics report generated: $report_file"
    echo "${GREEN}✅ Analytics report saved to $report_file${NC}"
}

# Function to start continuous monitoring
start_monitoring() {
    echo "${GREEN}🚀 Starting Screen Time monitoring...${NC}"
    log_message "Starting continuous monitoring"
    
    while true; do
        collect_app_usage
        collect_display_usage
        collect_workspace_data
        
        # Wait 5 minutes before next collection
        echo "${YELLOW}⏰ Next collection in 5 minutes...${NC}"
        sleep 300
    done
}

# Function to show help
show_help() {
    echo "${BLUE}📖 Screen Time Collector Help${NC}"
    echo "================================"
    echo ""
    echo "${GREEN}Usage:${NC}"
    echo "  $0 [command]"
    echo ""
    echo "${GREEN}Commands:${NC}"
    echo "  collect    - Collect current data"
    echo "  monitor    - Start continuous monitoring"
    echo "  report     - Generate analytics report"
    echo "  status     - Show collection status"
    echo "  help       - Show this help message"
    echo ""
    echo "${GREEN}Data Files:${NC}"
    echo "  • App Usage: $DATA_DIR/app_usage_*.json"
    echo "  • Display Usage: $DATA_DIR/display_usage_*.json"
    echo "  • Workspace Data: $DATA_DIR/workspace_*.json"
    echo "  • Analytics Reports: $DATA_DIR/analytics_report_*.md"
    echo ""
    echo "${YELLOW}Log File:${NC} $LOG_FILE"
}

# Function to show status
show_status() {
    echo "${BLUE}📊 Screen Time Collection Status${NC}"
    echo "=================================="
    
    # Check Screen Time availability
    check_screen_time_enabled
    
    # Show data directory contents
    echo ""
    echo "${YELLOW}Data Directory:${NC} $DATA_DIR"
    if [ -d "$DATA_DIR" ]; then
        local file_count=$(ls "$DATA_DIR"/*.json 2>/dev/null | wc -l)
        echo "${GREEN}Files collected:${NC} $file_count"
        
        if [ $file_count -gt 0 ]; then
            echo "${YELLOW}Recent files:${NC}"
            ls -la "$DATA_DIR"/*.json 2>/dev/null | tail -3
        fi
    else
        echo "${RED}Data directory not found${NC}"
    fi
    
    # Show log file status
    echo ""
    echo "${YELLOW}Log File:${NC} $LOG_FILE"
    if [ -f "$LOG_FILE" ]; then
        local log_lines=$(wc -l < "$LOG_FILE")
        echo "${GREEN}Log entries:${NC} $log_lines"
    else
        echo "${RED}Log file not found${NC}"
    fi
}

# Main script
case "${1:-help}" in
    "collect")
        echo "${GREEN}📊 Collecting Screen Time data...${NC}"
        collect_app_usage
        collect_display_usage
        collect_workspace_data
        generate_analytics_report
        ;;
    "monitor")
        start_monitoring
        ;;
    "report")
        generate_analytics_report
        ;;
    "status")
        show_status
        ;;
    "help"|*)
        show_help
        ;;
esac 