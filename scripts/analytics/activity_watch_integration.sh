#!/bin/zsh

# Activity Watch Integration
# Collects and analyzes activity data for workspace optimization

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Configuration
AW_DATA_DIR="configs/activity_watch_data"
AW_LOG_FILE="configs/activity_watch.log"
AW_SERVER_URL="http://localhost:5600"

# Create data directory if it doesn't exist
mkdir -p "$AW_DATA_DIR"

# Function to log messages
log_message() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $message" >> "$AW_LOG_FILE"
    echo "${BLUE}[$timestamp]${NC} $message"
}

# Function to check if Activity Watch is running
check_activity_watch() {
    if curl -s "$AW_SERVER_URL" >/dev/null 2>&1; then
        echo "${GREEN}✅ Activity Watch server is running${NC}"
        return 0
    else
        echo "${YELLOW}⚠️  Activity Watch server not found${NC}"
        echo "${YELLOW}Install Activity Watch: brew install activitywatch${NC}"
        echo "${YELLOW}Start server: aw-qt${NC}"
        return 1
    fi
}

# Function to collect current activity data
collect_current_activity() {
    echo "${BLUE}📊 Collecting current activity data...${NC}"
    
    local current_date=$(date +%Y-%m-%d)
    local output_file="$AW_DATA_DIR/current_activity_$current_date.json"
    
    # Get current active window
    local active_window=$(yabai -m query --windows --window 2>/dev/null | jq -r '.app // "unknown"')
    
    # Get current display
    local current_display=$(yabai -m query --displays | jq -r '.[] | select(.["has-focus"]==true) | .index // "unknown"')
    
    # Get current space
    local current_space=$(yabai -m query --spaces | jq -r '.[] | select(.["visible"]==true) | .index // "unknown"')
    
    # Get system load
    local cpu_load=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')
    local memory_usage=$(top -l 1 | grep "PhysMem" | awk '{print $2}' | sed 's/M//')
    
    # Create JSON structure
    cat > "$output_file" << EOF
{
    "date": "$current_date",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "activity": {
        "active_window": "$active_window",
        "current_display": $current_display,
        "current_space": $current_space,
        "cpu_load": $cpu_load,
        "memory_usage": $memory_usage
    },
    "workspace_context": {
        "time_of_day": "$(date +%H:%M)",
        "day_of_week": "$(date +%u)",
        "session_duration": 0
    }
}
EOF
    
    log_message "Current activity data collected: $output_file"
    echo "${GREEN}✅ Current activity data saved to $output_file${NC}"
}

# Function to collect historical activity data
collect_historical_activity() {
    echo "${BLUE}📈 Collecting historical activity data...${NC}"
    
    local current_date=$(date +%Y-%m-%d)
    local output_file="$AW_DATA_DIR/historical_activity_$current_date.json"
    
    # Get window history from YABAI
    local window_history=$(yabai -m query --windows 2>/dev/null | jq -r '.[] | {app: .app, display: .display, space: .space, focused: .["focused"]}')
    
    # Get display usage over time
    local display_usage=$(yabai -m query --displays 2>/dev/null | jq -r '.[] | {index: .index, frame: .frame, spaces: .spaces}')
    
    # Create JSON structure
    cat > "$output_file" << EOF
{
    "date": "$current_date",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "historical_data": {
        "window_history": [$window_history],
        "display_usage": [$display_usage]
    },
    "analysis": {
        "most_used_apps": [],
        "display_preferences": [],
        "productivity_patterns": []
    }
}
EOF
    
    log_message "Historical activity data collected: $output_file"
    echo "${GREEN}✅ Historical activity data saved to $output_file${NC}"
}

# Function to analyze productivity patterns
analyze_productivity_patterns() {
    echo "${BLUE}🧠 Analyzing productivity patterns...${NC}"
    
    local current_date=$(date +%Y-%m-%d)
    local analysis_file="$AW_DATA_DIR/productivity_analysis_$current_date.json"
    
    # Get current time for analysis
    local current_hour=$(date +%H)
    local current_day=$(date +%u)
    
    # Determine productivity context
    local productivity_context="unknown"
    if [ "$current_day" -le 5 ] && [ "$current_hour" -ge 9 ] && [ "$current_hour" -le 17 ]; then
        productivity_context="work_hours"
    elif [ "$current_hour" -ge 18 ] || [ "$current_hour" -le 8 ]; then
        productivity_context="personal_hours"
    else
        productivity_context="transition_hours"
    fi
    
    # Get active applications
    local active_apps=$(yabai -m query --windows 2>/dev/null | jq -r '.[] | .app' | sort | uniq -c | sort -nr)
    
    # Create analysis JSON
    cat > "$analysis_file" << EOF
{
    "date": "$current_date",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "productivity_analysis": {
        "context": "$productivity_context",
        "time_of_day": "$(date +%H:%M)",
        "day_of_week": "$current_day",
        "active_applications": "$active_apps",
        "recommendations": []
    },
    "workspace_optimization": {
        "suggested_profile": "",
        "app_recommendations": [],
        "display_optimization": []
    }
}
EOF
    
    log_message "Productivity analysis generated: $analysis_file"
    echo "${GREEN}✅ Productivity analysis saved to $analysis_file${NC}"
}

# Function to generate activity report
generate_activity_report() {
    echo "${BLUE}📋 Generating activity report...${NC}"
    
    local current_date=$(date +%Y-%m-%d)
    local report_file="$AW_DATA_DIR/activity_report_$current_date.md"
    
    # Count files in data directory
    local current_files=$(ls "$AW_DATA_DIR"/current_activity_*.json 2>/dev/null | wc -l)
    local historical_files=$(ls "$AW_DATA_DIR"/historical_activity_*.json 2>/dev/null | wc -l)
    local analysis_files=$(ls "$AW_DATA_DIR"/productivity_analysis_*.json 2>/dev/null | wc -l)
    
    cat > "$report_file" << EOF
# Activity Watch Integration Report
**Date**: $current_date  
**Generated**: $(date)

## Data Collection Summary
- **Current Activity Files**: $current_files
- **Historical Activity Files**: $historical_files  
- **Analysis Files**: $analysis_files

## Current Activity Status
- **Active Window**: $(yabai -m query --windows --window 2>/dev/null | jq -r '.app // "Unknown"')
- **Current Display**: $(yabai -m query --displays | jq -r '.[] | select(.has-focus==true) | .index // "Unknown"')
- **Current Space**: $(yabai -m query --spaces | jq -r '.[] | select(.visible==true) | .index // "Unknown"')

## Productivity Analysis
- **Time Context**: $(date +%H:%M)
- **Day Context**: $(date +%A)
- **Productivity Level**: $(if [ $(date +%H) -ge 9 ] && [ $(date +%H) -le 17 ]; then echo "High (Work Hours)"; else echo "Variable"; fi)

## Recent Activity Patterns
$(ls -la "$AW_DATA_DIR"/*.json 2>/dev/null | tail -5 | awk '{print "- " $9 " (" $6 " " $7 " " $8 ")"}')

## Recommendations
1. **Activity Optimization**: Based on current usage patterns
2. **Workspace Efficiency**: Monitor application switching patterns
3. **Productivity Insights**: Track peak performance hours
4. **Display Utilization**: Analyze multi-display usage

---
*Generated by YABAI Workspace Manager Activity Watch Integration*
EOF
    
    log_message "Activity report generated: $report_file"
    echo "${GREEN}✅ Activity report saved to $report_file${NC}"
}

# Function to start continuous activity monitoring
start_activity_monitoring() {
    echo "${GREEN}🚀 Starting Activity Watch monitoring...${NC}"
    log_message "Starting continuous activity monitoring"
    
    while true; do
        collect_current_activity
        analyze_productivity_patterns
        
        # Wait 2 minutes before next collection
        echo "${YELLOW}⏰ Next activity collection in 2 minutes...${NC}"
        sleep 120
    done
}

# Function to show help
show_help() {
    echo "${BLUE}📖 Activity Watch Integration Help${NC}"
    echo "====================================="
    echo ""
    echo "${GREEN}Usage:${NC}"
    echo "  $0 [command]"
    echo ""
    echo "${GREEN}Commands:${NC}"
    echo "  collect    - Collect current activity data"
    echo "  historical - Collect historical activity data"
    echo "  analyze    - Analyze productivity patterns"
    echo "  monitor    - Start continuous monitoring"
    echo "  report     - Generate activity report"
    echo "  status     - Show integration status"
    echo "  help       - Show this help message"
    echo ""
    echo "${GREEN}Data Files:${NC}"
    echo "  • Current Activity: $AW_DATA_DIR/current_activity_*.json"
    echo "  • Historical Activity: $AW_DATA_DIR/historical_activity_*.json"
    echo "  • Productivity Analysis: $AW_DATA_DIR/productivity_analysis_*.json"
    echo "  • Activity Reports: $AW_DATA_DIR/activity_report_*.md"
    echo ""
    echo "${YELLOW}Log File:${NC} $AW_LOG_FILE"
    echo "${YELLOW}Activity Watch Server:${NC} $AW_SERVER_URL"
}

# Function to show status
show_status() {
    echo "${BLUE}📊 Activity Watch Integration Status${NC}"
    echo "====================================="
    
    # Check Activity Watch availability
    check_activity_watch
    
    # Show data directory contents
    echo ""
    echo "${YELLOW}Data Directory:${NC} $AW_DATA_DIR"
    if [ -d "$AW_DATA_DIR" ]; then
        local file_count=$(ls "$AW_DATA_DIR"/*.json 2>/dev/null | wc -l)
        echo "${GREEN}Files collected:${NC} $file_count"
        
        if [ $file_count -gt 0 ]; then
            echo "${YELLOW}Recent files:${NC}"
            ls -la "$AW_DATA_DIR"/*.json 2>/dev/null | tail -3
        fi
    else
        echo "${RED}Data directory not found${NC}"
    fi
    
    # Show log file status
    echo ""
    echo "${YELLOW}Log File:${NC} $AW_LOG_FILE"
    if [ -f "$AW_LOG_FILE" ]; then
        local log_lines=$(wc -l < "$AW_LOG_FILE")
        echo "${GREEN}Log entries:${NC} $log_lines"
    else
        echo "${RED}Log file not found${NC}"
    fi
}

# Main script
case "${1:-help}" in
    "collect")
        echo "${GREEN}📊 Collecting activity data...${NC}"
        collect_current_activity
        ;;
    "historical")
        echo "${GREEN}📈 Collecting historical data...${NC}"
        collect_historical_activity
        ;;
    "analyze")
        echo "${GREEN}🧠 Analyzing productivity patterns...${NC}"
        analyze_productivity_patterns
        ;;
    "monitor")
        start_activity_monitoring
        ;;
    "report")
        generate_activity_report
        ;;
    "status")
        show_status
        ;;
    "help"|*)
        show_help
        ;;
esac 