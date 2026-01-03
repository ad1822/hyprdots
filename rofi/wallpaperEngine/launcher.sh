#!/bin/sh

WALLPAPER_DIR="$HOME/.local/share/Steam/steamapps/workshop/content/431960"

# Exit if directory doesn't exist
[ -d "$WALLPAPER_DIR" ] || exit 1

# Pick wallpaper ID
WP_ID=$(ls "$WALLPAPER_DIR" | rofi -dmenu -p "Wallpaper Engine")

[ -z "$WP_ID" ] && exit 0

# Kill existing wallpaperengine
pkill linux-wallpaperengine 2>/dev/null

# Launch wallpaper (same mode as your GUI)
linux-wallpaperengine \
  --screen-root eDP-1 \
  --scaling fill \
  --fps 60 \
  --volume 0.4 \
  --silent \
  --fullscreen-pause \
  --no-audio-processing \
  "$WALLPAPER_DIR/$WP_ID"
