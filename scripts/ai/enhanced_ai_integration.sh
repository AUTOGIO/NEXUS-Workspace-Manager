#!/bin/zsh

# Enhanced AI Integration Script for YABAI Workspace
# Integrates with extensive model collection for intelligent workspace management

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'

# Configuration
MODEL_PATH="/Volumes/MICRO/models"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "${BLUE}🤖 Enhanced AI Integration for YABAI Workspace${NC}"
echo "=================================================="

# Function to check model availability
check_model_availability() {
    local model_name=$1
    local model_path=""
    
    # Check different possible paths
    for format in "MLX" "GGUF" "HF"; do
        for size in "small-1B" "medium-8B" "large-14B+"; do
            for purpose in "chat" "reasoning" "multimodal"; do
                potential_path="$MODEL_PATH/by-format/$format/$model_name"
                if [ -d "$potential_path" ] || [ -f "$potential_path" ]; then
                    echo "$potential_path"
                    return 0
                fi
            done
        done
    done
    
    # Check by-creator paths
    for creator in "lmstudio-community" "mlx-community" "standalone"; do
        potential_path="$MODEL_PATH/by-creator/$creator/$model_name"
        if [ -d "$potential_path" ] || [ -f "$potential_path" ]; then
            echo "$potential_path"
            return 0
        fi
    done
    
    return 1
}

# Function to get available memory
get_available_memory() {
    local total_memory=$(sysctl -n hw.memsize | awk '{print $0/1024/1024/1024}')
    local used_memory=$(vm_stat | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
    local available_memory=$(echo "$total_memory - ($used_memory * 4096 / 1024 / 1024 / 1024)" | bc -l)
    echo "$available_memory"
}

# Function to select optimal model for task
select_model_for_task() {
    local task_type=$1
    local available_memory=$(get_available_memory)
    
    case $task_type in
        "quick_response")
            if [ $(echo "$available_memory > 2" | bc -l) -eq 1 ]; then
                echo "TinyLlama-1.1B-Chat-v1.0-mlx"
            else
                echo "Llama-3.2-1B-Instruct-4bit"
            fi
            ;;
        "complex_reasoning")
            if [ $(echo "$available_memory > 8" | bc -l) -eq 1 ]; then
                echo "Phi-4-mini-reasoning-MLX-4bit"
            else
                echo "Phi-4-mini-reasoning-GGUF"
            fi
            ;;
        "coding")
            if [ $(echo "$available_memory > 6" | bc -l) -eq 1 ]; then
                echo "DeepSeek-R1-0528-Qwen3-8B-MLX-4bit"
            else
                echo "DeepSeek-R1-Distill-Llama-8B-Q4_K_M"
            fi
            ;;
        "visual_analysis")
            echo "Qwen2.5-VL-7B-Instruct-GGUF"
            ;;
        "conversation")
            if [ $(echo "$available_memory > 4" | bc -l) -eq 1 ]; then
                echo "Qwen3-4B-MLX-4bit"
            else
                echo "Meta-Llama-3-8B-Instruct-4bit"
            fi
            ;;
        "advanced_reasoning")
            if [ $(echo "$available_memory > 12" | bc -l) -eq 1 ]; then
                echo "Qwen3-14B-MLX-4bit"
            else
                echo "Phi-4-reasoning-plus-MLX-4bit"
            fi
            ;;
        *)
            echo "Meta-Llama-3.1-8B-Instruct-Q6_K"
            ;;
    esac
}

# Function to get profile-specific models
get_profile_models() {
    local profile=$1
    local available_memory=$(get_available_memory)
    
    case $profile in
        "work")
            if [ $(echo "$available_memory > 8" | bc -l) -eq 1 ]; then
                echo "primary: Meta-Llama-3.1-8B-Instruct-Q6_K"
                echo "coding: DeepSeek-R1-0528-Qwen3-8B-MLX-4bit"
                echo "reasoning: Phi-4-mini-reasoning-MLX-4bit"
            else
                echo "primary: TinyLlama-1.1B-Chat-v1.0-mlx"
                echo "coding: DeepSeek-R1-Distill-Llama-8B-Q4_K_M"
                echo "reasoning: Phi-4-mini-reasoning-GGUF"
            fi
            ;;
        "personal")
            if [ $(echo "$available_memory > 4" | bc -l) -eq 1 ]; then
                echo "primary: Qwen3-4B-MLX-4bit"
                echo "conversation: Meta-Llama-3-8B-Instruct-4bit"
                echo "creative: Mistral-Nemo-Instruct-2407-GGUF"
            else
                echo "primary: Llama-3.2-1B-Instruct-4bit"
                echo "conversation: TinyLlama-1.1B-Chat-v1.0-mlx"
                echo "creative: Mistral-Nemo-Instruct-2407-GGUF"
            fi
            ;;
        "ai_research")
            if [ $(echo "$available_memory > 12" | bc -l) -eq 1 ]; then
                echo "primary: Qwen3-14B-MLX-4bit"
                echo "reasoning: Phi-4-reasoning-plus-MLX-4bit"
                echo "coding: DeepSeek-R1-0528-Qwen3-8B-MLX-4bit"
                echo "vision: Qwen2.5-VL-7B-Instruct-GGUF"
            else
                echo "primary: Qwen3-8B-MLX-4bit"
                echo "reasoning: Phi-4-mini-reasoning-MLX-4bit"
                echo "coding: DeepSeek-R1-Distill-Llama-8B-Q4_K_M"
                echo "vision: Qwen2.5-VL-7B-Instruct-GGUF"
            fi
            ;;
    esac
}

# Function to analyze current workspace context
analyze_workspace_context() {
    echo "${CYAN}🔍 Analyzing current workspace context...${NC}"
    
    # Get current time and day
    local current_time=$(date +%H)
    local current_day=$(date +%u)
    local current_profile=""
    
    # Determine current profile based on time
    if [ "$current_day" -le 5 ] && [ "$current_time" -ge 9 ] && [ "$current_time" -le 17 ]; then
        current_profile="work"
    elif [ "$current_time" -ge 18 ] || [ "$current_time" -le 8 ]; then
        current_profile="personal"
    else
        current_profile="ai_research"
    fi
    
    # Get active applications
    local active_apps=$(osascript -e 'tell application "System Events" to get name of every process whose background only is false')
    
    # Analyze app patterns
    local development_apps=0
    local communication_apps=0
    local entertainment_apps=0
    
    for app in $active_apps; do
        case $app in
            *"Cursor"*|*"VS Code"*|*"Xcode"*|*"Terminal"*|*"iTerm"*)
                development_apps=$((development_apps + 1))
                ;;
            *"Slack"*|*"Teams"*|*"WhatsApp"*|*"Zoom"*)
                communication_apps=$((communication_apps + 1))
                ;;
            *"Spotify"*|*"Netflix"*|*"YouTube"*|*"Twitch"*)
                entertainment_apps=$((entertainment_apps + 1))
                ;;
        esac
    done
    
    echo "${GREEN}📊 Workspace Analysis:${NC}"
    echo "  - Current Time: $current_time:00"
    echo "  - Current Day: $current_day (1=Monday, 7=Sunday)"
    echo "  - Suggested Profile: $current_profile"
    echo "  - Active Apps: ${#active_apps[@]}"
    echo "  - Development Apps: $development_apps"
    echo "  - Communication Apps: $communication_apps"
    echo "  - Entertainment Apps: $entertainment_apps"
    
    # Suggest profile based on app usage
    if [ $development_apps -gt $communication_apps ] && [ $development_apps -gt $entertainment_apps ]; then
        echo "${YELLOW}💡 App pattern suggests: Work Profile${NC}"
        current_profile="work"
    elif [ $entertainment_apps -gt $development_apps ] && [ $entertainment_apps -gt $communication_apps ]; then
        echo "${YELLOW}💡 App pattern suggests: Personal Profile${NC}"
        current_profile="personal"
    fi
    
    echo "$current_profile"
}

# Function to suggest workspace optimizations
suggest_workspace_optimizations() {
    local profile=$1
    local available_memory=$(get_available_memory)
    
    echo "${PURPLE}🧠 AI-Powered Workspace Suggestions${NC}"
    echo "====================================="
    
    case $profile in
        "work")
            echo "${GREEN}💼 Work Profile Optimizations:${NC}"
            echo "  - Load coding assistant models for development"
            echo "  - Optimize display layout for development tools"
            echo "  - Enable code completion and documentation assistance"
            echo "  - Suggest relevant development tools based on current project"
            
            # Suggest specific models
            local coding_model=$(select_model_for_task "coding")
            local reasoning_model=$(select_model_for_task "complex_reasoning")
            
            echo "${CYAN}📋 Recommended Models:${NC}"
            echo "  - Coding: $coding_model"
            echo "  - Reasoning: $reasoning_model"
            ;;
        "personal")
            echo "${GREEN}🏠 Personal Profile Optimizations:${NC}"
            echo "  - Load conversation models for social interaction"
            echo "  - Optimize layout for entertainment and social media"
            echo "  - Enable creative writing and content generation"
            echo "  - Suggest entertainment and personal productivity tools"
            
            local conversation_model=$(select_model_for_task "conversation")
            echo "${CYAN}📋 Recommended Models:${NC}"
            echo "  - Conversation: $conversation_model"
            ;;
        "ai_research")
            echo "${GREEN}🤖 AI Research Profile Optimizations:${NC}"
            echo "  - Load large language models for research analysis"
            echo "  - Enable visual analysis for data interpretation"
            echo "  - Optimize for model development and experimentation"
            echo "  - Suggest AI/ML tools and frameworks"
            
            local advanced_model=$(select_model_for_task "advanced_reasoning")
            local vision_model=$(select_model_for_task "visual_analysis")
            
            echo "${CYAN}📋 Recommended Models:${NC}"
            echo "  - Advanced Reasoning: $advanced_model"
            echo "  - Visual Analysis: $vision_model"
            ;;
    esac
}

# Function to check model collection status
check_model_collection() {
    echo "${BLUE}📁 Model Collection Analysis${NC}"
    echo "============================="
    
    if [ -d "$MODEL_PATH" ]; then
        echo "${GREEN}✅ Model collection found at $MODEL_PATH${NC}"
        
        # Count models by format
        local mlx_count=$(find "$MODEL_PATH" -name "*.mlx" -o -name "*.safetensors" | wc -l)
        local gguf_count=$(find "$MODEL_PATH" -name "*.gguf" | wc -l)
        local total_models=$((mlx_count + gguf_count))
        
        echo "${CYAN}📊 Model Statistics:${NC}"
        echo "  - Total Models: $total_models"
        echo "  - MLX Models: $mlx_count"
        echo "  - GGUF Models: $gguf_count"
        
        # Check for specific model categories
        echo "${CYAN}🎯 Model Categories:${NC}"
        
        # Check reasoning models
        if find "$MODEL_PATH" -name "*Phi-4*" -o -name "*reasoning*" | grep -q .; then
            echo "  ✅ Reasoning Models: Available"
        else
            echo "  ❌ Reasoning Models: Not found"
        fi
        
        # Check vision models
        if find "$MODEL_PATH" -name "*VL*" -o -name "*vision*" | grep -q .; then
            echo "  ✅ Vision Models: Available"
        else
            echo "  ❌ Vision Models: Not found"
        fi
        
        # Check coding models
        if find "$MODEL_PATH" -name "*DeepSeek*" -o -name "*Granite*" | grep -q .; then
            echo "  ✅ Coding Models: Available"
        else
            echo "  ❌ Coding Models: Not found"
        fi
        
    else
        echo "${RED}❌ Model collection not found at $MODEL_PATH${NC}"
        return 1
    fi
}

# Function to integrate with Ollama
integrate_with_ollama() {
    echo "${BLUE}🦙 Ollama Integration${NC}"
    echo "====================="
    
    if command -v ollama &> /dev/null; then
        echo "${GREEN}✅ Ollama detected${NC}"
        
        # List running models
        local running_models=$(ollama list | grep "running" | wc -l)
        echo "  - Running Models: $running_models"
        
        # Suggest model loading based on current context
        local current_profile=$(analyze_workspace_context)
        local suggested_model=$(select_model_for_task "conversation")
        
        echo "${YELLOW}💡 Suggested Ollama Model: $suggested_model${NC}"
        
        # Offer to load model
        read -p "🤔 Load suggested model in Ollama? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "${GREEN}🚀 Loading model in Ollama...${NC}"
            ollama pull "$suggested_model" &
            echo "${GREEN}✅ Model loading started in background${NC}"
        fi
        
    else
        echo "${YELLOW}⚠️  Ollama not found. Install with: brew install ollama${NC}"
    fi
}

# Function to integrate with MLX
integrate_with_mlx() {
    echo "${BLUE}🍎 MLX Integration${NC}"
    echo "=================="
    
    if python3 -c "import mlx" 2>/dev/null; then
        echo "${GREEN}✅ MLX detected${NC}"
        
        # Check for MLX models
        local mlx_models=$(find "$MODEL_PATH" -name "*.safetensors" | grep -i mlx | wc -l)
        echo "  - Available MLX Models: $mlx_models"
        
        # Suggest MLX model for current context
        local current_profile=$(analyze_workspace_context)
        local suggested_mlx_model=$(select_model_for_task "complex_reasoning")
        
        if [[ $suggested_mlx_model == *"MLX"* ]]; then
            echo "${YELLOW}💡 Suggested MLX Model: $suggested_mlx_model${NC}"
        fi
        
    else
        echo "${YELLOW}⚠️  MLX not found. Install with: pip install mlx${NC}"
    fi
}

# Main execution
main() {
    echo "${BLUE}🤖 Enhanced AI Integration for YABAI Workspace${NC}"
    echo "=================================================="
    
    # Check model collection
    if ! check_model_collection; then
        echo "${RED}❌ Cannot proceed without model collection${NC}"
        exit 1
    fi
    
    # Analyze current workspace context
    local current_profile=$(analyze_workspace_context)
    
    # Get available memory
    local available_memory=$(get_available_memory)
    echo "${CYAN}💾 Available Memory: ${available_memory}GB${NC}"
    
    # Suggest workspace optimizations
    suggest_workspace_optimizations "$current_profile"
    
    # Integrate with Ollama
    integrate_with_ollama
    
    # Integrate with MLX
    integrate_with_mlx
    
    # Offer to load suggested profile
    echo ""
    read -p "🤔 Load suggested profile ($current_profile)? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        local profile_script="$PROJECT_DIR/configs/profiles/${current_profile}_profile.sh"
        if [ -f "$profile_script" ]; then
            echo "${GREEN}🚀 Loading $current_profile profile...${NC}"
            source "$profile_script"
            echo "${GREEN}✅ Profile loaded successfully!${NC}"
        else
            echo "${YELLOW}⚠️  Profile script not found: $profile_script${NC}"
        fi
    fi
    
    echo ""
    echo "${GREEN}✅ Enhanced AI integration complete!${NC}"
    echo "${CYAN}💡 Your workspace is now optimized with AI-powered suggestions${NC}"
}

# Run main function
main "$@"
