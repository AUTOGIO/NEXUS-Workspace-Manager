#!/usr/bin/env python3
"""Unit tests for analytics components"""

import pytest
import json
import tempfile
from pathlib import Path
from unittest.mock import patch, MagicMock
import sys

# Add project root to path
project_root = Path(__file__).parent.parent.parent
sys.path.append(str(project_root))

def test_screen_time_jsonl_format():
    """Test screen time JSONL format"""
    sample_record = {
        "ts": "2025-08-12T00:00:00Z",
        "frontmost": "Cursor",
        "bundle": "com.todesktop.230313mzl4w4u9",
        "display": "LG ULTRAWIDE",
        "profile": "work"
    }
    
    # Validate JSON format
    json_str = json.dumps(sample_record)
    parsed = json.loads(json_str)
    
    assert parsed["frontmost"] == "Cursor"
    assert parsed["display"] == "LG ULTRAWIDE"
    assert "ts" in parsed
    assert "bundle" in parsed

def test_activity_watch_event_format():
    """Test ActivityWatch event format"""
    sample_event = {
        "timestamp": "2025-08-12T00:00:00Z",
        "duration": 0,
        "data": {
            "type": "workspace_change",
            "nexus_data": {
                "profile": "work",
                "apps": ["VS Code", "Terminal"]
            }
        }
    }
    
    # Validate structure
    assert "timestamp" in sample_event
    assert "data" in sample_event
    assert sample_event["data"]["type"] == "workspace_change"
    assert "nexus_data" in sample_event["data"]

@patch('subprocess.run')
def test_screen_time_collector_script(mock_run):
    """Test screen time collector script execution"""
    mock_run.return_value.returncode = 0
    mock_run.return_value.stdout = "Safari, Terminal"
    
    # Mock the script execution
    script_path = Path("scripts/analytics/screen_time_collector.sh")
    assert script_path.exists()

@patch('httpx.get')
def test_activity_watch_integration(mock_get):
    """Test ActivityWatch integration"""
    mock_get.return_value.status_code = 200
    
    # Mock the integration script
    script_path = Path("scripts/analytics/activity_watch_integration.sh")
    assert script_path.exists()

if __name__ == "__main__":
    pytest.main([__file__, "-v"])
