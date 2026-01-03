#!/usr/bin/env bash

TARGET_DIR="${WALLPAPER_DIR:-$HOME/Pictures/Wallpaper}"
CONFIG_PATH="$HOME/.config/hypr/hyprpaper.conf"

TEMP_FILE=$(mktemp)

yazi --chooser-file "$TEMP_FILE" "$TARGET_DIR"

WALLPAPER=$(cat "$TEMP_FILE")
rm "$TEMP_FILE"

if [[ -z "$WALLPAPER" || ! -f "$WALLPAPER" ]]; then
  echo "No wallpaper selected. Exiting."
  exit 0
fi

mkdir -p "$(dirname "$CONFIG_PATH")"
echo "splash = false" >"$CONFIG_PATH"
echo "wallpaper {" >>"$CONFIG_PATH"
echo "  monitor = eDP-1" >>"$CONFIG_PATH"
echo "  path = $WALLPAPER" >>"$CONFIG_PATH"
echo "  fit_mode = cover" >>"$CONFIG_PATH"
echo "}" >>"$CONFIG_PATH"

pkill hyprpaper
hyprctl dispatch exec "hyprpaper"

notify-send -a "hyprpaper" "Wallpaper Changed" -i "$WALLPAPER"
echo "Wallpaper set to: $WALLPAPER"
