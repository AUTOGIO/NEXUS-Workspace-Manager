#!/bin/zsh

# Daily Routine startup script for macOS
# Opens user-specified applications and gives them a chance to launch before
# yabai applies window rules. Update the paths and application names as needed.

open -na "/Applications/Vivaldi.app"
open -na "/Applications/Safari.app"
open -na "/Applications/ChatGPT.app"
open -na "/Applications/Grok.app"        # update if your Grok app has a different name
open -na "/Applications/Obsidian.app"
open -na "/Applications/WhatsApp.app"
open -na "/Applications/X.app"           # update path if your Twitter client is named differently

# Wait a bit to allow apps to finish launching before yabai moves them
sleep 2
