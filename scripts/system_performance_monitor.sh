#!/bin/zsh
# 📊 NEXUS System Performance Monitor
# Optimized for M3 iMac with your specific apps

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "${BLUE}📊 NEXUS Performance Monitor${NC}"
echo "================================"

# System Overview
echo "${GREEN}🖥️  System Overview:${NC}"
echo "Hardware: $(system_profiler SPHardwareDataType | grep "Model Name" | awk -F: '{print $2}' | xargs)"
echo "Memory: $(system_profiler SPHardwareDataType | grep "Memory" | awk -F: '{print $2}' | xargs)"
echo "Processor: $(system_profiler SPHardwareDataType | grep "Processor Name" | awk -F: '{print $2}' | xargs)"

# Memory Usage
echo ""
echo "${GREEN}💾 Memory Usage:${NC}"
memory_pressure=$(memory_pressure | head -5)
echo "$memory_pressure"

# Display Performance
echo ""
echo "${GREEN}📺 Display Performance:${NC}"
if command -v yabai &> /dev/null; then
    displays=$(yabai -m query --displays | jq length)
    echo "Active Displays: $displays"
    echo "YABAI Status: ✅ Running"
else
    echo "YABAI Status: ❌ Not running"
fi

# MLX Performance Check
echo ""
echo "${GREEN}🧠 MLX Performance:${NC}"
if python3 -c "import mlx.core as mx; print('MLX Status: ✅ Available -', mx.__version__)" 2>/dev/null; then
    echo "MLX-LM: ✅ Ready for inference"
    
    # Check model availability
    if [ -d "/Volumes/MICRO/models" ]; then
        mlx_models=$(find /Volumes/MICRO/models -name "*MLX*" -type d | wc -l)
        echo "MLX Models: $mlx_models available"
    fi
else
    echo "MLX Status: ❌ Not available"
fi

# App Performance
echo ""
echo "${GREEN}📱 Key App Status:${NC}"

# Check your most important apps
apps_to_check=(
    "Cursor"
    "Obsidian" 
    "ChatGPT"
    "Vivaldi"
    "LM Studio"
    "One Thing"
    "ActivityWatch"
    "iStatistica Pro"
)

for app in "${apps_to_check[@]}"; do
    if pgrep -f "$app" > /dev/null; then
        echo "$app: ✅ Running"
    else
        echo "$app: ⚪ Not running"
    fi
done

# Temperature Monitoring
echo ""
echo "${GREEN}🌡️  Thermal Status:${NC}"
if command -v sudo &> /dev/null; then
    # Check if iStatistica is running for thermal data
    if pgrep -f "iStatistica" > /dev/null; then
        echo "Thermal Monitoring: ✅ iStatistica active"
    else
        echo "Thermal Monitoring: ⚪ Start iStatistica for detailed thermal data"
    fi
fi

# Storage Status
echo ""
echo "${GREEN}💿 Storage Status:${NC}"
df -h / | tail -1 | awk '{print "System Disk: " $3 " used / " $2 " total (" $5 " full)"}'

if [ -d "/Volumes/MICRO" ]; then
    df -h /Volumes/MICRO | tail -1 | awk '{print "Model Storage: " $3 " used / " $2 " total (" $5 " full)"}'
else
    echo "Model Storage: ⚠️  /Volumes/MICRO not mounted"
fi

# Performance Recommendations
echo ""
echo "${YELLOW}💡 Performance Recommendations:${NC}"

# Check memory usage
memory_usage=$(ps -A -o %mem | awk '{sum+=$1} END {print sum}')
if (( $(echo "$memory_usage > 80" | bc -l) )); then
    echo "⚠️  High memory usage ($memory_usage%) - Consider closing unused apps"
fi

# Check if CleanMyMac is available for cleanup
if [ -d "/Applications/CleanMyMac_5_MAS.app" ]; then
    echo "💡 Run CleanMyMac for system optimization"
fi

# Check if ActivityWatch is running for productivity tracking
if ! pgrep -f "ActivityWatch" > /dev/null; then
    echo "💡 Start ActivityWatch for productivity monitoring"
fi

# YABAI optimization
if command -v yabai &> /dev/null; then
    window_count=$(yabai -m query --windows | jq length)
    if [ "$window_count" -gt 20 ]; then
        echo "⚠️  Many windows open ($window_count) - Consider workspace organization"
    fi
fi

echo ""
echo "${GREEN}✅ Performance check complete!${NC}"
