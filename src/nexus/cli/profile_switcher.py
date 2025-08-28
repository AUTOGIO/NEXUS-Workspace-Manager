#!/usr/bin/env python3
"""
NEXUS Profile Switcher CLI Module
Profile management and switching interface
"""

import argparse
import sys
import logging
import json
import subprocess
from pathlib import Path
from typing import Dict, Any, List, Optional

# Add project root to path
project_root = Path(__file__).parent.parent.parent.parent
sys.path.insert(0, str(project_root))

from nexus.utils.logger import setup_logging

logger = logging.getLogger(__name__)

class ProfileSwitcher:
    """Profile management and switching engine."""
    
    def __init__(self):
        self.setup_logging()
        self.load_config()
        self.profiles_dir = project_root / "configs" / "profiles"
        
    def setup_logging(self):
        """Setup logging configuration."""
        setup_logging()
        
    def load_config(self):
        """Load profile configuration."""
        try:
            config_path = project_root / "configs" / "nexus.yaml"
            if config_path.exists():
                # TODO: Load YAML config
                self.config = {
                    "profiles": {
                        "default": "personal",
                        "auto_switch": False,
                        "profiles_dir": "configs/profiles"
                    }
                }
            else:
                self.config = {
                    "profiles": {
                        "default": "personal",
                        "auto_switch": False,
                        "profiles_dir": "configs/profiles"
                    }
                }
        except Exception as e:
            logger.warning(f"Could not load config: {e}")
            self.config = {"profiles": {"default": "personal"}}
    
    def get_available_profiles(self) -> List[str]:
        """Get list of available profiles."""
        try:
            profiles = []
            
            # Check configs/profiles directory
            if self.profiles_dir.exists():
                for profile_file in self.profiles_dir.glob("*.sh"):
                    profile_name = profile_file.stem
                    if profile_name.startswith("ai_") or profile_name.endswith("_profile"):
                        profiles.append(profile_name)
            
            # Add hardcoded profiles if directory is empty
            if not profiles:
                profiles = [
                    "personal", "work", "focus", "gaming", "learning",
                    "ai_research", "ai_development", "ai_business",
                    "ai_content_creation", "ai_gaming", "ai_learning"
                ]
            
            return sorted(profiles)
            
        except Exception as e:
            logger.error(f"Error getting available profiles: {e}")
            return []
    
    def get_current_profile(self) -> Optional[str]:
        """Get current active profile."""
        try:
            # Check for current profile file
            current_profile_file = project_root / "configs" / "current_profile.txt"
            if current_profile_file.exists():
                with open(current_profile_file, 'r') as f:
                    return f.read().strip()
            
            # Check environment variable
            import os
            env_profile = os.environ.get('NEXUS_CURRENT_PROFILE')
            if env_profile:
                return env_profile
            
            # Return default
            return self.config["profiles"]["default"]
            
        except Exception as e:
            logger.error(f"Error getting current profile: {e}")
            return None
    
    def switch_profile(self, profile_name: str, force: bool = False) -> bool:
        """Switch to a specific profile."""
        try:
            print(f"🔄 Switching to profile: {profile_name}")
            
            # Validate profile exists
            available_profiles = self.get_available_profiles()
            if profile_name not in available_profiles:
                print(f"❌ Profile '{profile_name}' not found.")
                print(f"Available profiles: {', '.join(available_profiles)}")
                return False
            
            # Check if already on this profile
            current_profile = self.get_current_profile()
            if current_profile == profile_name and not force:
                print(f"✅ Already on profile: {profile_name}")
                return True
            
            # Execute profile script if it exists
            profile_script = self.profiles_dir / f"{profile_name}.sh"
            if profile_script.exists():
                print(f"📜 Executing profile script: {profile_script}")
                try:
                    result = subprocess.run(
                        [str(profile_script)],
                        capture_output=True,
                        text=True,
                        cwd=project_root
                    )
                    if result.returncode == 0:
                        print(f"✅ Profile script executed successfully")
                    else:
                        print(f"⚠️  Profile script had issues: {result.stderr}")
                except Exception as e:
                    logger.warning(f"Could not execute profile script: {e}")
            
            # Update current profile
            self.set_current_profile(profile_name)
            
            # Apply profile-specific settings
            self.apply_profile_settings(profile_name)
            
            print(f"✅ Successfully switched to profile: {profile_name}")
            return True
            
        except Exception as e:
            logger.error(f"Error switching profile: {e}")
            print(f"❌ Failed to switch profile: {e}")
            return False
    
    def set_current_profile(self, profile_name: str):
        """Set the current active profile."""
        try:
            # Update current profile file
            current_profile_file = project_root / "configs" / "current_profile.txt"
            current_profile_file.parent.mkdir(parents=True, exist_ok=True)
            
            with open(current_profile_file, 'w') as f:
                f.write(profile_name)
            
            # Update environment variable
            import os
            os.environ['NEXUS_CURRENT_PROFILE'] = profile_name
            
        except Exception as e:
            logger.error(f"Error setting current profile: {e}")
    
    def apply_profile_settings(self, profile_name: str):
        """Apply profile-specific settings."""
        try:
            print(f"⚙️  Applying profile settings...")
            
            # Profile-specific configurations
            profile_configs = {
                "work": {
                    "description": "Professional development and productivity",
                    "features": ["Focus mode", "Professional apps", "Dual-display optimization"]
                },
                "ai_research": {
                    "description": "AI research and development",
                    "features": ["AI tools", "Research apps", "Multi-window layout"]
                },
                "gaming": {
                    "description": "Gaming and entertainment",
                    "features": ["Gaming mode", "Performance optimization", "Full-screen apps"]
                },
                "focus": {
                    "description": "Deep focus and concentration",
                    "features": ["Do Not Disturb", "Minimal distractions", "Single-app focus"]
                }
            }
            
            config = profile_configs.get(profile_name, {})
            if config:
                print(f"  📋 {config.get('description', 'Custom profile')}")
                for feature in config.get('features', []):
                    print(f"  ✅ {feature}")
            
            # TODO: Implement actual profile application
            # This would include:
            # - YABAI layout changes
            # - System settings modifications
            # - App-specific configurations
            
        except Exception as e:
            logger.error(f"Error applying profile settings: {e}")
    
    def list_profiles(self, show_active: bool = False):
        """List available profiles."""
        try:
            profiles = self.get_available_profiles()
            current_profile = self.get_current_profile()
            
            print("📋 Available Profiles")
            print("=" * 30)
            
            for profile in profiles:
                if show_active and profile != current_profile:
                    continue
                    
                status = "🟢 ACTIVE" if profile == current_profile else "⚪"
                print(f"  {status} {profile}")
                
                if profile == current_profile:
                    print(f"      Current workspace profile")
            
            if not show_active:
                print(f"\nCurrent profile: {current_profile or 'None'}")
                print(f"Default profile: {self.config['profiles']['default']}")
                
        except Exception as e:
            logger.error(f"Error listing profiles: {e}")
            print(f"❌ Error listing profiles: {e}")
    
    def get_profile_info(self, profile_name: str) -> Dict[str, Any]:
        """Get detailed information about a profile."""
        try:
            profile_script = self.profiles_dir / f"{profile_name}.sh"
            
            info = {
                "name": profile_name,
                "exists": profile_script.exists(),
                "script_path": str(profile_script) if profile_script.exists() else None,
                "current": profile_name == self.get_current_profile()
            }
            
            if profile_script.exists():
                # Read profile script for description
                try:
                    with open(profile_script, 'r') as f:
                        content = f.read()
                        # Look for description in comments
                        lines = content.split('\n')
                        for line in lines:
                            if line.strip().startswith('#') and 'profile' in line.lower():
                                info["description"] = line.strip('# ').strip()
                                break
                except Exception:
                    pass
            
            return info
            
        except Exception as e:
            logger.error(f"Error getting profile info: {e}")
            return {"name": profile_name, "error": str(e)}

def main():
    """Main entry point for profile switcher CLI."""
    parser = argparse.ArgumentParser(
        description="NEXUS Profile Switcher",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  nexus-profile-switcher --list                    # List all profiles
  nexus-profile-switcher --list --active          # Show only active profile
  nexus-profile-switcher --switch work            # Switch to work profile
  nexus-profile-switcher --switch ai_research     # Switch to AI research profile
  nexus-profile-switcher --info gaming            # Get info about gaming profile
        """
    )
    
    parser.add_argument('--list', '-l', action='store_true', help='List available profiles')
    parser.add_argument('--active', '-a', action='store_true', help='Show only active profile')
    parser.add_argument('--switch', '-s', help='Switch to specified profile')
    parser.add_argument('--info', '-i', help='Get information about specified profile')
    parser.add_argument('--force', '-f', action='store_true', help='Force profile switch')
    parser.add_argument('--verbose', '-v', action='store_true', help='Verbose output')
    
    args = parser.parse_args()
    
    # Setup logging
    setup_logging()
    
    try:
        switcher = ProfileSwitcher()
        
        if args.list:
            switcher.list_profiles(args.active)
        elif args.switch:
            success = switcher.switch_profile(args.switch, args.force)
            sys.exit(0 if success else 1)
        elif args.info:
            info = switcher.get_profile_info(args.info)
            print(f"📋 Profile Information: {info['name']}")
            print("=" * 40)
            for key, value in info.items():
                if key != 'name':
                    print(f"{key}: {value}")
        else:
            # Default: show current profile
            current = switcher.get_current_profile()
            print(f"🟢 Current Profile: {current}")
            print(f"📋 Available profiles: {', '.join(switcher.get_available_profiles())}")
            
    except KeyboardInterrupt:
        print("\nOperation cancelled by user.")
        sys.exit(1)
    except Exception as e:
        logger.error(f"Error in profile switcher CLI: {e}")
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()

