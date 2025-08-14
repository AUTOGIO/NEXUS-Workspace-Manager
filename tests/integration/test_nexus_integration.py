#!/usr/bin/env python3
"""Integration tests for NEXUS system"""

import pytest
import tempfile
import shutil
import subprocess
import time
import requests
from pathlib import Path
import sys

# Add project root to path
project_root = Path(__file__).parent.parent.parent
sys.path.append(str(project_root))


class TestNEXUSIntegration:
    """Integration tests for NEXUS components"""
    
    @pytest.fixture(scope="class")
    def temp_project_dir(self):
        """Create temporary project directory for testing"""
        temp_dir = tempfile.mkdtemp()
        yield Path(temp_dir)
        shutil.rmtree(temp_dir)
    
    def test_yabai_integration(self):
        """Test YABAI integration"""
        try:
            result = subprocess.run(
                ["yabai", "-m", "query", "--displays"],
                capture_output=True,
                text=True,
                timeout=10
            )
            assert result.returncode == 0
            # YABAI returns JSON, so check for valid JSON structure
            import json
            displays_data = json.loads(result.stdout)
            assert isinstance(displays_data, list), "Should return list of displays"
            print(f"✅ YABAI integration working - {len(displays_data)} displays found")
        except subprocess.TimeoutExpired:
            pytest.skip("YABAI not responding")
        except FileNotFoundError:
            pytest.skip("YABAI not installed")
        except json.JSONDecodeError:
            pytest.fail("YABAI returned invalid JSON")
    
    def test_streamlit_availability(self):
        """Test Streamlit availability"""
        try:
            result = subprocess.run(
                ["python3", "-c", "import streamlit; print(streamlit.__version__)"],
                capture_output=True,
                text=True,
                timeout=10
            )
            assert result.returncode == 0
            assert "1." in result.stdout  # Version check
        except subprocess.TimeoutExpired:
            pytest.skip("Streamlit import timeout")
    
    def test_mlx_availability(self):
        """Test MLX availability"""
        try:
            result = subprocess.run(
                ["python3", "-c", "import mlx; print('MLX available')"],
                capture_output=True,
                text=True,
                timeout=10
            )
            if result.returncode == 0:
                print("✅ MLX is available")
            else:
                print("⚠️  MLX not available - will be installed during setup")
        except subprocess.TimeoutExpired:
            pytest.skip("MLX import timeout")
    
    def test_n8n_webhook_endpoint(self):
        """Test N8N webhook endpoint (if running)"""
        try:
            response = requests.get("http://localhost:5678", timeout=5)
            if response.status_code == 200:
                print("✅ N8N is running")
            else:
                print("⚠️  N8N responded with status:", response.status_code)
        except requests.exceptions.RequestException:
            print("⚠️  N8N not running - will be started during setup")
    
    def test_project_structure(self):
        """Test project structure integrity"""
        required_dirs = [
            "src/nexus",
            "scripts/ai",
            "scripts/analytics",
            "configs/profiles",
            "dashboard",
            "tests"
        ]
        
        for dir_path in required_dirs:
            assert Path(dir_path).exists(), f"Required directory missing: {dir_path}"
        
        required_files = [
            "launcher.sh",
            "README.md",
            "pyproject.toml",
            "src/nexus/__init__.py"
        ]
        
        for file_path in required_files:
            assert Path(file_path).exists(), f"Required file missing: {file_path}"
    
    def test_script_executability(self):
        """Test script executability"""
        scripts = [
            "launcher.sh",
            "scripts/ai/enhanced_ai_integration.sh",
            "scripts/analytics/screen_time_collector.sh"
        ]
        
        for script in scripts:
            if Path(script).exists():
                # Check if script is executable
                assert Path(script).stat().st_mode & 0o111, f"Script not executable: {script}"


if __name__ == "__main__":
    pytest.main([__file__, "-v"])
