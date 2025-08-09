#!/bin/zsh

# Adaptive Display Detection Script
# Automatically adapts workspace configuration to 1-3 displays
# Works regardless of current YABAI status

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'

echo "${BLUE}🔍 Adaptive Display Detection${NC}"
echo "=============================="

# Function to detect displays using system_profiler (always available)
detect_displays_system() {
    echo "${CYAN}📊 Using system_profiler for detection...${NC}"
    
    # Get display information from system
    local display_info=$(system_profiler SPDisplaysDataType 2>/dev/null)
    local display_count=0
    
    # Count connected displays
    if echo "$display_info" | grep -q "Resolution:"; then
        display_count=$(echo "$display_info" | grep -c "Resolution:")
    else
        # Fallback: assume at least 1 display (the main one)
        display_count=1
    fi
    
    echo "${GREEN}📺 Detected $display_count display(s)${NC}"
    return $display_count
}

# Function to detect displays using YABAI (if available)
detect_displays_yabai() {
    if command -v yabai &> /dev/null && yabai -m query --displays &> /dev/null; then
        echo "${CYAN}📊 Using YABAI for accurate detection...${NC}"
        local display_count=$(yabai -m query --displays | jq length 2>/dev/null || echo "0")
        
        if [ "$display_count" -gt 0 ]; then
            echo "${GREEN}📺 YABAI detected $display_count display(s)${NC}"
            
            # Show detailed display info
            echo "${YELLOW}Display Details:${NC}"
            yabai -m query --displays | jq -r '.[] | "  Display \(.index): \(.frame.width)x\(.frame.height)"' 2>/dev/null
            
            return $display_count
        fi
    fi
    
    return 0
}

# Function to generate adaptive configuration
generate_adaptive_config() {
    local display_count=$1
    
    echo ""
    echo "${BLUE}⚙️  Generating Adaptive Configuration${NC}"
    echo "====================================="
    
    case $display_count in
        1)
            echo "${YELLOW}📱 Single Display Configuration${NC}"
            cat > configs/adaptive_layout.yaml << EOF
# Single Display Layout Configuration
display_count: 1
layout_strategy: "unified"

displays:
  main:
    id: 1
    name: "Primary Display"
    purpose: "Unified Workspace"
    layout: "bsp"
    apps:
      - "All Applications"

workspace_profiles:
  work:
    main_apps: ["Visual Studio Code", "Terminal", "Safari", "ChatGPT"]
    layout: "bsp"
    focus_mode: true
    
  personal:
    main_apps: ["Safari", "WhatsApp", "Spotify", "Obsidian"]
    layout: "stack"
    focus_mode: false
    
  ai_research:
    main_apps: ["Jupyter Notebook", "Terminal", "ChatGPT", "LM Studio"]
    layout: "bsp"
    focus_mode: true

# YABAI Rules for Single Display
yabai_rules:
  - "yabai -m rule --add app=\"Visual Studio Code\" space=1"
  - "yabai -m rule --add app=\"Terminal\" space=2"
  - "yabai -m rule --add app=\"Safari\" space=3"
  - "yabai -m rule --add app=\"ChatGPT\" space=4"
EOF
            ;;
        2)
            echo "${YELLOW}🖥️  Dual Display Configuration${NC}"
            cat > configs/adaptive_layout.yaml << EOF
# Dual Display Layout Configuration
display_count: 2
layout_strategy: "dual_focus"

displays:
  left:
    id: 1
    name: "Secondary Display"
    purpose: "Reference & Communication"
    layout: "bsp"
    apps: ["Safari", "Chrome", "WhatsApp", "Slack", "Obsidian"]
    
  right:
    id: 2
    name: "Primary Display"
    purpose: "Main Work & AI Tools"
    layout: "bsp"
    apps: ["Visual Studio Code", "Terminal", "ChatGPT", "Grok", "LM Studio"]

workspace_profiles:
  work:
    left_apps: ["Safari", "Slack", "Teams"]
    right_apps: ["Visual Studio Code", "Terminal", "ChatGPT"]
    
  personal:
    left_apps: ["WhatsApp", "Spotify", "YouTube"]
    right_apps: ["Obsidian", "Safari", "Calendar"]
    
  ai_research:
    left_apps: ["Documentation", "Research Papers"]
    right_apps: ["Jupyter Notebook", "LM Studio", "Terminal"]

# YABAI Rules for Dual Display
yabai_rules:
  - "yabai -m rule --add app=\"Safari\" display=1"
  - "yabai -m rule --add app=\"WhatsApp\" display=1"
  - "yabai -m rule --add app=\"Slack\" display=1"
  - "yabai -m rule --add app=\"Visual Studio Code\" display=2"
  - "yabai -m rule --add app=\"Terminal\" display=2"
  - "yabai -m rule --add app=\"ChatGPT\" display=2"
EOF
            ;;
        3)
            echo "${YELLOW}🖥️🖥️🖥️ Triple Display Configuration${NC}"
            cat > configs/adaptive_layout.yaml << EOF
# Triple Display Layout Configuration (Original NEXUS Setup)
display_count: 3
layout_strategy: "distributed_excellence"

displays:
  left:
    id: 1
    name: "HZ30GAMER 30\" or Secondary"
    purpose: "Browsers & Web Tools"
    layout: "bsp"
    apps: ["Safari", "Vivaldi", "Chrome", "Firefox"]
    
  center:
    id: 2
    name: "LG ULTRAWIDE 34\" or Primary"
    purpose: "AI & Development Tools"
    layout: "bsp"
    apps: ["ChatGPT", "Grok", "VS Code", "Xcode", "Terminal"]
    
  right:
    id: 3
    name: "iMac 24\" or Third Display"
    purpose: "Productivity & Communication"
    layout: "stack"
    apps: ["Obsidian", "WhatsApp", "X", "Slack", "Teams"]

workspace_profiles:
  work:
    left_apps: ["Safari", "Chrome", "Documentation"]
    center_apps: ["Visual Studio Code", "Terminal", "ChatGPT"]
    right_apps: ["Slack", "Teams", "Notion"]
    
  personal:
    left_apps: ["YouTube", "Netflix", "Entertainment"]
    center_apps: ["Obsidian", "Creative Apps"]
    right_apps: ["WhatsApp", "X", "Social Media"]
    
  ai_research:
    left_apps: ["Research Papers", "Documentation"]
    center_apps: ["Jupyter Notebook", "LM Studio", "MLX"]
    right_apps: ["ChatGPT", "Claude", "AI Tools"]

# YABAI Rules for Triple Display
yabai_rules:
  - "yabai -m rule --add app=\"Safari\" display=1"
  - "yabai -m rule --add app=\"Vivaldi\" display=1"
  - "yabai -m rule --add app=\"Visual Studio Code\" display=2"
  - "yabai -m rule --add app=\"ChatGPT\" display=2"
  - "yabai -m rule --add app=\"Terminal\" display=2"
  - "yabai -m rule --add app=\"Obsidian\" display=3"
  - "yabai -m rule --add app=\"WhatsApp\" display=3"
  - "yabai -m rule --add app=\"X\" display=3"
EOF
            ;;
        *)
            echo "${RED}❌ Unsupported display count: $display_count${NC}"
            echo "${YELLOW}💡 NEXUS supports 1-3 displays. Defaulting to single display mode.${NC}"
            generate_adaptive_config 1
            return
            ;;
    esac
    
    echo "${GREEN}✅ Adaptive configuration generated${NC}"
}

# Function to update dynamic layout manager
update_dynamic_layout() {
    local display_count=$1
    
    echo ""
    echo "${BLUE}🔄 Updating Dynamic Layout Manager${NC}"
    echo "=================================="
    
    # Create adaptive display configuration for Python scripts
    cat > configs/current_display_config.json << EOF
{
    "display_count": $display_count,
    "detection_time": "$(date -Iseconds)",
    "adaptive_mode": true,
    "layout_strategy": $([ $display_count -eq 1 ] && echo '"unified"' || [ $display_count -eq 2 ] && echo '"dual_focus"' || echo '"distributed_excellence"')
}
EOF
    
    echo "${GREEN}✅ Dynamic layout configuration updated${NC}"
}

# Function to suggest optimal AI models based on display count
suggest_ai_models() {
    local display_count=$1
    
    echo ""
    echo "${BLUE}🤖 AI Model Suggestions${NC}"
    echo "======================="
    
    case $display_count in
        1)
            echo "${YELLOW}📱 Single Display - Efficiency Focus:${NC}"
            echo "  - Quick Response: TinyLlama-1.1B (minimal memory)"
            echo "  - Balanced: Qwen3-4B-MLX-4bit (good performance)"
            echo "  - Coding: DeepSeek-R1-Distill-Llama-8B-Q4_K_M"
            ;;
        2)
            echo "${YELLOW}🖥️  Dual Display - Productivity Focus:${NC}"
            echo "  - Primary: Meta-Llama-3.1-8B-Instruct-Q6_K"
            echo "  - Coding: DeepSeek-R1-0528-Qwen3-8B-MLX-4bit"
            echo "  - Reasoning: Phi-4-mini-reasoning-MLX-4bit"
            ;;
        3)
            echo "${YELLOW}🖥️🖥️🖥️ Triple Display - Full Power:${NC}"
            echo "  - Advanced: Qwen3-14B-MLX-4bit"
            echo "  - Reasoning: Phi-4-reasoning-plus-MLX-4bit" 
            echo "  - Vision: Qwen2.5-VL-7B-Instruct-GGUF"
            echo "  - Coding: DeepSeek-R1-0528-Qwen3-8B-MLX-4bit"
            ;;
    esac
}

# Main execution
main() {
    local display_count=0
    
    # Try YABAI detection first
    detect_displays_yabai
    display_count=$?
    
    # Fallback to system detection if YABAI fails
    if [ $display_count -eq 0 ]; then
        detect_displays_system
        display_count=$?
    fi
    
    # Ensure we have at least 1 display
    if [ $display_count -eq 0 ]; then
        display_count=1
        echo "${YELLOW}⚠️  Defaulting to single display configuration${NC}"
    fi
    
    # Generate configurations
    generate_adaptive_config $display_count
    update_dynamic_layout $display_count
    suggest_ai_models $display_count
    
    # Save current configuration
    echo "$display_count" > configs/current_display_count.txt
    
    echo ""
    echo "${GREEN}🎯 Adaptive Detection Complete${NC}"
    echo "=============================="
    echo "${CYAN}Current Setup: $display_count display(s)${NC}"
    echo "${CYAN}Configuration: configs/adaptive_layout.yaml${NC}"
    echo "${CYAN}Status: configs/current_display_config.json${NC}"
    echo ""
    echo "${YELLOW}💡 NEXUS will now adapt to your $display_count display setup!${NC}"
}

# Run main function
main "$@"
