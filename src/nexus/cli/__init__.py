"""Command line interface modules."""

from .main import main
from .ai_optimize import AIWorkspaceOptimizer, main as ai_optimize_main
from .profile_switcher import ProfileSwitcher, main as profile_switcher_main
from .quick_menu import QuickMenu, main as quick_menu_main

__all__ = [
    "main",
    "AIWorkspaceOptimizer",
    "ai_optimize_main",
    "ProfileSwitcher", 
    "profile_switcher_main",
    "QuickMenu",
    "quick_menu_main"
]
