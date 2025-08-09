#!/bin/zsh

# AI Integration Script for YABAI Workspace
# Integrates with external model collection for intelligent workspace management

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "${BLUE}🤖 AI Integration for YABAI Workspace${NC}"
echo "=========================================="

# Check for external model storage
MODEL_PATH="/Volumes/MICRO/models"
if [ -d "$MODEL_PATH" ]; then
    echo "${GREEN}✅ External model storage found at $MODEL_PATH${NC}"
    
    # List available models
    echo "${YELLOW}📁 Available Models:${NC}"
    find "$MODEL_PATH" -name "*.gguf" -o -name "*.mlx" | head -10 | while read model; do
        echo "  - $(basename "$model")"
    done
    
    # Check for Ollama
    if command -v ollama &> /dev/null; then
        echo "${GREEN}✅ Ollama detected${NC}"
        
        # List running models
        echo "${YELLOW}🔄 Running Models:${NC}"
        ollama list | grep -E "(running|active)" || echo "  No models currently running"
        
        # Suggest model loading based on workspace context
        echo ""
        echo "${BLUE}💡 AI Integration Suggestions:${NC}"
        echo "  - For Work Profile: Load coding assistant models"
        echo "  - For AI Research: Load large language models"
        echo "  - For Personal: Load conversation models"
        
    else
        echo "${YELLOW}⚠️  Ollama not found. Install with: brew install ollama${NC}"
    fi
    
    # Check for MLX
    if command -v mlx &> /dev/null; then
        echo "${GREEN}✅ MLX detected${NC}"
    else
        echo "${YELLOW}⚠️  MLX not found. Install with: pip install mlx${NC}"
    fi
    
else
    echo "${YELLOW}⚠️  External model storage not found at $MODEL_PATH${NC}"
    echo "  Expected path: /Volumes/MICRO/models"
fi

# AI-powered workspace optimization
echo ""
echo "${BLUE}🧠 AI Workspace Optimization${NC}"
echo "================================"

# Get current workspace context
CURRENT_TIME=$(date +%H)
CURRENT_DAY=$(date +%u)  # 1=Monday, 7=Sunday

# Suggest optimal workspace based on time and day
if [ "$CURRENT_DAY" -le 5 ] && [ "$CURRENT_TIME" -ge 9 ] && [ "$CURRENT_TIME" -le 17 ]; then
    echo "${GREEN}🕐 Work hours detected - suggesting Work Profile${NC}"
    SUGGESTED_PROFILE="work_profile.sh"
elif [ "$CURRENT_TIME" -ge 18 ] || [ "$CURRENT_TIME" -le 8 ]; then
    echo "${GREEN}🌙 Evening/Night hours - suggesting Personal Profile${NC}"
    SUGGESTED_PROFILE="personal_profile.sh"
else
    echo "${GREEN}🔬 Research hours - suggesting AI Research Profile${NC}"
    SUGGESTED_PROFILE="ai_research_profile.sh"
fi

# Load suggested profile if user confirms
echo ""
read -p "🤔 Load suggested profile ($SUGGESTED_PROFILE)? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -f "workspace_profiles/$SUGGESTED_PROFILE" ]; then
        echo "${GREEN}🚀 Loading suggested profile...${NC}"
        source "workspace_profiles/$SUGGESTED_PROFILE"
        echo "${GREEN}✅ Profile loaded successfully!${NC}"
    else
        echo "${YELLOW}⚠️  Suggested profile not found${NC}"
    fi
fi

# AI model recommendations based on current workspace
echo ""
echo "${BLUE}📋 AI Model Recommendations${NC}"
echo "=============================="

case $SUGGESTED_PROFILE in
    "work_profile.sh")
        echo "💼 For Work Profile:"
        echo "  - CodeLlama for coding assistance"
        echo "  - GPT-4 for documentation"
        echo "  - Claude for code review"
        ;;
    "personal_profile.sh")
        echo "🏠 For Personal Profile:"
        echo "  - Llama2 for casual conversation"
        echo "  - Mistral for creative writing"
        echo "  - Phi-2 for quick responses"
        ;;
    "ai_research_profile.sh")
        echo "🤖 For AI Research Profile:"
        echo "  - GPT-4 for research analysis"
        echo "  - Claude for detailed explanations"
        echo "  - Llama2 for model comparison"
        ;;
esac

echo ""
echo "${GREEN}✅ AI integration complete!${NC}" 