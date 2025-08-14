#!/usr/bin/env python3
"""
🚀 NEXUS Enhanced Automation Bridge
AI-Powered Workspace Intelligence for Apple Silicon

Author: Eduardo Giovannini
Version: 1.0.0
License: MIT

Enhanced automation bridge with AI-powered features for NEXUS
"""

import os
import sys
import json
import yaml
import argparse
import subprocess
from pathlib import Path
from typing import Dict, List, Optional, Any, Tuple
from dataclasses import dataclass, asdict
from datetime import datetime, time
import psutil
import platform
import logging

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

@dataclass
class WorkspaceContext:
    """Current workspace context information."""
    active_apps: List[str]
    current_profile: str
    display_config: Dict[str, Any]
    time_of_day: str
    system_load: float
    memory_usage: float
    user_activity: str

@dataclass
class AIRecommendation:
    """AI-powered workspace recommendation."""
    profile: str
    confidence: float
    reasoning: str
    optimizations: List[str]
    estimated_improvement: float

class NEXUSEnhancedBridge:
    """Enhanced automation bridge for NEXUS with AI-powered features."""
    
    def __init__(self):
        self.project_root = Path(__file__).parent.parent.parent
        self.configs_dir = self.project_root / "configs"
        self.profiles_dir = self.configs_dir / "profiles"
        self.models_dir = self.configs_dir / "models"
        
        # Load configuration
        self.config = self._load_config()
        self.profiles = self._load_profiles()
        
        # Initialize AI components
        self.ai_enabled = self.config.get('ai_enabled', True)
        
    def _load_config(self) -> Dict[str, Any]:
        """Load NEXUS configuration."""
        config_file = self.configs_dir / "models" / "model_config.yaml"
        if config_file.exists():
            try:
                with open(config_file, 'r') as f:
                    return yaml.safe_load(f)
            except Exception as e:
                logger.warning(f"Error loading config: {e}")
        return {}
    
    def _load_profiles(self) -> List[str]:
        """Load available workspace profiles."""
        profiles = []
        if self.profiles_dir.exists():
            for profile_file in self.profiles_dir.glob("*.sh"):
                profiles.append(profile_file.stem)
        return sorted(profiles)
    
    def get_workspace_context(self) -> WorkspaceContext:
        """Get current workspace context."""
        try:
            # Get active applications
            active_apps = self._get_active_apps()
            
            # Get current profile (if any)
            current_profile = self._get_current_profile()
            
            # Get display configuration
            display_config = self._get_display_config()
            
            # Get time of day
            time_of_day = self._get_time_of_day()
            
            # Get system metrics
            system_load = psutil.cpu_percent(interval=1)
            memory_usage = psutil.virtual_memory().percent
            
            # Determine user activity
            user_activity = self._determine_user_activity(active_apps)
            
            return WorkspaceContext(
                active_apps=active_apps,
                current_profile=current_profile,
                display_config=display_config,
                time_of_day=time_of_day,
                system_load=system_load,
                memory_usage=memory_usage,
                user_activity=user_activity
            )
        except Exception as e:
            logger.error(f"Error getting workspace context: {e}")
            return WorkspaceContext([], "", {}, "unknown", 0.0, 0.0, "unknown")
    
    def _get_active_apps(self) -> List[str]:
        """Get list of currently active applications."""
        try:
            # Use osascript to get frontmost applications
            cmd = 'osascript -e "tell application \\"System Events\\" to get name of every process whose background only is false"'
            result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
            if result.returncode == 0:
                apps = [app.strip() for app in result.stdout.split(',')]
                return [app for app in apps if app and len(app) > 0]
        except Exception as e:
            logger.warning(f"Error getting active apps: {e}")
        return []
    
    def _get_current_profile(self) -> str:
        """Get current workspace profile."""
        # This would need to be implemented based on how profiles are tracked
        # For now, return empty string
        return ""
    
    def _get_display_config(self) -> Dict[str, Any]:
        """Get current display configuration."""
        try:
            # Get YABAI display information
            cmd = "yabai -m query --displays"
            result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
            if result.returncode == 0:
                displays = json.loads(result.stdout)
                return {"displays": displays, "count": len(displays)}
        except Exception as e:
            logger.warning(f"Error getting display config: {e}")
        return {"displays": [], "count": 0}
    
    def _get_time_of_day(self) -> str:
        """Get time of day category."""
        current_hour = datetime.now().hour
        if 6 <= current_hour < 12:
            return "morning"
        elif 12 <= current_hour < 17:
            return "afternoon"
        elif 17 <= current_hour < 22:
            return "evening"
        else:
            return "night"
    
    def _determine_user_activity(self, active_apps: List[str]) -> str:
        """Determine user activity based on active applications."""
        if not active_apps:
            return "idle"
        
        # Define activity patterns
        development_apps = {"Cursor", "VS Code", "Xcode", "Terminal", "iTerm"}
        creative_apps = {"Final Cut Pro", "Logic Pro", "Photoshop", "Illustrator", "Figma"}
        productivity_apps = {"Slack", "Teams", "Zoom", "Chrome", "Safari"}
        entertainment_apps = {"Steam", "Discord", "Spotify", "Netflix", "YouTube"}
        
        app_set = set(active_apps)
        
        if app_set.intersection(development_apps):
            return "development"
        elif app_set.intersection(creative_apps):
            return "creative"
        elif app_set.intersection(productivity_apps):
            return "productivity"
        elif app_set.intersection(entertainment_apps):
            return "entertainment"
        else:
            return "general"
    
    def get_ai_recommendation(self, context: WorkspaceContext) -> AIRecommendation:
        """Get AI-powered workspace recommendation."""
        try:
            # Simple rule-based recommendation system
            # In a real implementation, this would use AI models
            
            recommendation = self._rule_based_recommendation(context)
            
            return AIRecommendation(
                profile=recommendation["profile"],
                confidence=recommendation["confidence"],
                reasoning=recommendation["reasoning"],
                optimizations=recommendation["optimizations"],
                estimated_improvement=recommendation["improvement"]
            )
        except Exception as e:
            logger.error(f"Error getting AI recommendation: {e}")
            return AIRecommendation("work_profile", 0.5, "Fallback recommendation", [], 0.0)
    
    def _rule_based_recommendation(self, context: WorkspaceContext) -> Dict[str, Any]:
        """Simple rule-based recommendation system."""
        recommendations = []
        
        # Time-based recommendations
        if context.time_of_day == "morning":
            recommendations.append(("work_profile", 0.8, "Morning work hours", ["Launch productivity apps", "Set work layout"], 0.3))
        
        # Activity-based recommendations
        if context.user_activity == "development":
            recommendations.append(("ai_development_profile", 0.9, "Development activity detected", ["Optimize for coding", "Launch dev tools"], 0.4))
        elif context.user_activity == "creative":
            recommendations.append(("content_creation_profile", 0.9, "Creative activity detected", ["Optimize for creativity", "Launch creative tools"], 0.4))
        elif context.user_activity == "entertainment":
            recommendations.append(("gaming_profile", 0.8, "Entertainment activity detected", ["Optimize for gaming", "Hide work distractions"], 0.3))
        
        # System load recommendations
        if context.system_load > 80:
            recommendations.append(("focus_profile", 0.7, "High system load", ["Reduce distractions", "Focus on current task"], 0.2))
        
        # Memory usage recommendations
        if context.memory_usage > 85:
            recommendations.append(("focus_profile", 0.6, "High memory usage", ["Close unnecessary apps", "Optimize memory"], 0.2))
        
        # Default recommendation
        if not recommendations:
            recommendations.append(("work_profile", 0.5, "Default recommendation", ["General optimization"], 0.1))
        
        # Return best recommendation
        best_rec = max(recommendations, key=lambda x: x[1])
        return {
            "profile": best_rec[0],
            "confidence": best_rec[1],
            "reasoning": best_rec[2],
            "optimizations": best_rec[3],
            "improvement": best_rec[4]
        }
    
    def optimize_layout(self) -> bool:
        """Optimize current workspace layout using AI."""
        try:
            logger.info("Starting AI-powered layout optimization...")
            
            # Get current context
            context = self.get_workspace_context()
            
            # Get AI recommendation
            recommendation = self.get_ai_recommendation(context)
            
            logger.info(f"AI Recommendation: {recommendation.profile} (confidence: {recommendation.confidence})")
            logger.info(f"Reasoning: {recommendation.reasoning}")
            
            # Apply optimizations
            self._apply_layout_optimizations(recommendation.optimizations)
            
            # Load recommended profile if confidence is high
            if recommendation.confidence > 0.7:
                self._load_profile(recommendation.profile)
                logger.info(f"Loaded profile: {recommendation.profile}")
            
            return True
            
        except Exception as e:
            logger.error(f"Error optimizing layout: {e}")
            return False
    
    def _apply_layout_optimizations(self, optimizations: List[str]):
        """Apply layout optimizations."""
        for optimization in optimizations:
            logger.info(f"Applying optimization: {optimization}")
            
            if "Launch productivity apps" in optimization:
                self._launch_productivity_apps()
            elif "Optimize for coding" in optimization:
                self._optimize_for_coding()
            elif "Optimize for creativity" in optimization:
                self._optimize_for_creativity()
            elif "Reduce distractions" in optimization:
                self._reduce_distractions()
    
    def _launch_productivity_apps(self):
        """Launch productivity applications."""
        apps = ["Cursor", "Chrome", "Slack"]
        for app in apps:
            try:
                subprocess.run(["open", "-a", app], check=True)
                logger.info(f"Launched {app}")
            except Exception as e:
                logger.warning(f"Failed to launch {app}: {e}")
    
    def _optimize_for_coding(self):
        """Optimize workspace for coding."""
        try:
            # Set YABAI layout to BSP for coding
            subprocess.run(["yabai", "-m", "space", "--layout", "bsp"], check=True)
            logger.info("Set layout to BSP for coding")
        except Exception as e:
            logger.warning(f"Failed to set layout: {e}")
    
    def _optimize_for_creativity(self):
        """Optimize workspace for creative work."""
        try:
            # Set YABAI layout to float for creative work
            subprocess.run(["yabai", "-m", "space", "--layout", "float"], check=True)
            logger.info("Set layout to float for creative work")
        except Exception as e:
            logger.warning(f"Failed to set layout: {e}")
    
    def _reduce_distractions(self):
        """Reduce workspace distractions."""
        try:
            # Hide non-essential apps
            distracting_apps = ["Chrome", "Safari", "Slack"]
            for app in distracting_apps:
                subprocess.run(["osascript", "-e", f'tell application "{app}" to hide'], check=True)
            logger.info("Hidden distracting applications")
        except Exception as e:
            logger.warning(f"Failed to hide apps: {e}")
    
    def _load_profile(self, profile_name: str) -> bool:
        """Load a workspace profile."""
        try:
            profile_script = self.profiles_dir / f"{profile_name}.sh"
            if profile_script.exists():
                subprocess.run(["bash", str(profile_script)], check=True)
                return True
            else:
                logger.warning(f"Profile script not found: {profile_script}")
                return False
        except Exception as e:
            logger.error(f"Error loading profile {profile_name}: {e}")
            return False
    
    def analyze_workspace(self) -> Dict[str, Any]:
        """Analyze current workspace and provide insights."""
        try:
            context = self.get_workspace_context()
            recommendation = self.get_ai_recommendation(context)
            
            analysis = {
                "timestamp": datetime.now().isoformat(),
                "context": asdict(context),
                "recommendation": asdict(recommendation),
                "system_health": {
                    "cpu_load": context.system_load,
                    "memory_usage": context.memory_usage,
                    "active_apps_count": len(context.active_apps),
                    "display_count": context.display_config.get("count", 0)
                },
                "optimization_suggestions": recommendation.optimizations
            }
            
            return analysis
            
        except Exception as e:
            logger.error(f"Error analyzing workspace: {e}")
            return {"error": str(e)}
    
    def create_snapshot(self) -> bool:
        """Create a snapshot of current workspace state."""
        try:
            snapshot_dir = self.project_root / "data" / "snapshots"
            snapshot_dir.mkdir(parents=True, exist_ok=True)
            
            # Get current state
            context = self.get_workspace_context()
            yabai_state = self._get_yabai_state()
            
            snapshot = {
                "timestamp": datetime.now().isoformat(),
                "context": asdict(context),
                "yabai_state": yabai_state,
                "system_info": {
                    "platform": platform.system(),
                    "python_version": platform.python_version(),
                    "cpu_count": psutil.cpu_count()
                }
            }
            
            # Save snapshot
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            snapshot_file = snapshot_dir / f"workspace_snapshot_{timestamp}.json"
            
            with open(snapshot_file, 'w') as f:
                json.dump(snapshot, f, indent=2)
            
            logger.info(f"Workspace snapshot created: {snapshot_file}")
            return True
            
        except Exception as e:
            logger.error(f"Error creating snapshot: {e}")
            return False
    
    def _get_yabai_state(self) -> Dict[str, Any]:
        """Get current YABAI state."""
        try:
            state = {}
            
            # Get spaces
            result = subprocess.run(["yabai", "-m", "query", "--spaces"], 
                                  capture_output=True, text=True, check=True)
            state["spaces"] = json.loads(result.stdout)
            
            # Get windows
            result = subprocess.run(["yabai", "-m", "query", "--windows"], 
                                  capture_output=True, text=True, check=True)
            state["windows"] = json.loads(result.stdout)
            
            # Get displays
            result = subprocess.run(["yabai", "-m", "query", "--displays"], 
                                  capture_output=True, text=True, check=True)
            state["displays"] = json.loads(result.stdout)
            
            return state
            
        except Exception as e:
            logger.warning(f"Error getting YABAI state: {e}")
            return {}
    
    def context_aware_profile(self) -> str:
        """Get context-aware profile recommendation."""
        try:
            context = self.get_workspace_context()
            recommendation = self.get_ai_recommendation(context)
            
            logger.info(f"Context-aware profile: {recommendation.profile}")
            logger.info(f"Reasoning: {recommendation.reasoning}")
            
            return recommendation.profile
            
        except Exception as e:
            logger.error(f"Error getting context-aware profile: {e}")
            return "work_profile"
    
    def auto_schedule(self) -> bool:
        """Automatically schedule workspace changes."""
        try:
            current_time = datetime.now()
            current_hour = current_time.hour
            current_weekday = current_time.weekday()
            
            # Define schedule rules
            schedule_rules = {
                "morning_work": {"time": (6, 9), "weekdays": range(5), "profile": "work_profile"},
                "lunch_break": {"time": (12, 13), "weekdays": range(5), "profile": "personal_profile"},
                "afternoon_work": {"time": (13, 17), "weekdays": range(5), "profile": "work_profile"},
                "evening_relax": {"time": (18, 22), "weekdays": range(7), "profile": "gaming_profile"},
                "night_focus": {"time": (22, 6), "weekdays": range(7), "profile": "focus_profile"}
            }
            
            # Find matching rule
            for rule_name, rule in schedule_rules.items():
                start_hour, end_hour = rule["time"]
                weekdays = rule["weekdays"]
                
                if (start_hour <= current_hour < end_hour and 
                    current_weekday in weekdays):
                    
                    logger.info(f"Auto-schedule: {rule_name} -> {rule['profile']}")
                    self._load_profile(rule['profile'])
                    return True
            
            logger.info("No auto-schedule rule matched")
            return False
            
        except Exception as e:
            logger.error(f"Error in auto-schedule: {e}")
            return False

def main():
    """Main function for the enhanced bridge."""
    parser = argparse.ArgumentParser(description="NEXUS Enhanced Automation Bridge")
    parser.add_argument("--optimize-layout", action="store_true", 
                       help="Optimize current workspace layout using AI")
    parser.add_argument("--analyze-workspace", action="store_true", 
                       help="Analyze current workspace and provide insights")
    parser.add_argument("--create-snapshot", action="store_true", 
                       help="Create a snapshot of current workspace state")
    parser.add_argument("--context-aware-profile", action="store_true", 
                       help="Get context-aware profile recommendation")
    parser.add_argument("--auto-schedule", action="store_true", 
                       help="Automatically schedule workspace changes")
    parser.add_argument("--smart-profile-selection", action="store_true", 
                       help="AI-powered profile selection")
    parser.add_argument("--context-analysis", action="store_true", 
                       help="AI analyzes current context and provides suggestions")
    parser.add_argument("--move-window-display", action="store_true", 
                       help="Move focused window to next display")
    parser.add_argument("--toggle-performance-mode", action="store_true", 
                       help="Toggle AI performance mode")
    parser.add_argument("--quick-inference", action="store_true", 
                       help="Quick AI inference with current context")
    parser.add_argument("--cycle-profiles", action="store_true", 
                       help="Cycle through workspace profiles")
    
    args = parser.parse_args()
    
    # Initialize bridge
    bridge = NEXUSEnhancedBridge()
    
    try:
        if args.optimize_layout:
            success = bridge.optimize_layout()
            print(f"Layout optimization: {'Success' if success else 'Failed'}")
            
        elif args.analyze_workspace:
            analysis = bridge.analyze_workspace()
            print(json.dumps(analysis, indent=2))
            
        elif args.create_snapshot:
            success = bridge.create_snapshot()
            print(f"Snapshot creation: {'Success' if success else 'Failed'}")
            
        elif args.context_aware_profile:
            profile = bridge.context_aware_profile()
            print(f"Recommended profile: {profile}")
            
        elif args.auto_schedule:
            success = bridge.auto_schedule()
            print(f"Auto-schedule: {'Success' if success else 'Failed'}")
            
        elif args.smart_profile_selection:
            profile = bridge.context_aware_profile()
            print(f"Smart profile selection: {profile}")
            
        elif args.context_analysis:
            analysis = bridge.analyze_workspace()
            print(json.dumps(analysis, indent=2))
            
        elif args.move_window_display:
            print("Window display movement feature coming soon...")
            
        elif args.toggle_performance_mode:
            print("Performance mode toggle feature coming soon...")
            
        elif args.quick_inference:
            print("Quick inference feature coming soon...")
            
        elif args.cycle_profiles:
            print("Profile cycling feature coming soon...")
            
        else:
            # Default: show help
            parser.print_help()
            
    except Exception as e:
        logger.error(f"Error in main: {e}")
        print(f"Error: {e}")
        return 1
    
    return 0

if __name__ == "__main__":
    sys.exit(main())
