# yabai rule definitions for Daily Routine
# Add these lines to your ~/.yabairc and reload yabai (brew services restart yabai)

# Display assignments (update display IDs as needed)
yabai -m rule --add app="Vivaldi"   display=1 space=1
yabai -m rule --add app="Safari"    display=1 space=1
yabai -m rule --add app="ChatGPT"   display=2 space=1
# Grok may use a browser or an app; update accordingly
yabai -m rule --add app="Grok"      display=2 space=1
yabai -m rule --add app="Obsidian"  display=3 space=1
yabai -m rule --add app="WhatsApp"  display=3 space=1
yabai -m rule --add app="X"         display=3 space=1
