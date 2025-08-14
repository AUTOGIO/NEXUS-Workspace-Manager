#!/bin/zsh
# Install MLX for Apple Silicon

set -euo pipefail

echo "🤖 Installing MLX for Apple Silicon..."
echo "====================================="

# Check if MLX is already installed
if python3 -c "import mlx" 2>/dev/null; then
    echo "✅ MLX already installed: $(python3 -c 'import mlx; print(mlx.__version__)')"
    exit 0
fi

# Check Python version
python_version=$(python3 --version | cut -d' ' -f2 | cut -d'.' -f1,2)
if [[ $(echo "$python_version >= 3.8" | bc -l) -eq 0 ]]; then
    echo "❌ Python 3.8+ required, found: $python_version"
    exit 1
fi

# Install MLX
echo "📦 Installing MLX..."
pip3 install mlx

# Install MLX-LM
echo "📦 Installing MLX-LM..."
pip3 install mlx-lm

# Verify installation
if python3 -c "import mlx" 2>/dev/null; then
    echo "✅ MLX installed successfully: $(python3 -c 'import mlx; print(mlx.__version__)')"
else
    echo "❌ MLX installation failed"
    exit 1
fi

# Test with small model
echo "🧪 Testing MLX installation..."
python3 scripts/ai/smoke_mlx.py

echo "✅ MLX installation complete!"
