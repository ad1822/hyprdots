#!/usr/bin/bash

if [ $(pgrep -c hyprpaper) -ne 0 ]; then
  hyprctl hyprpaper unload all
  killall hyprpaper
fi

TARGET="$HOME/Pictures/Wallpaper"
WALLPAPER=$(find "$TARGET" -type f -regex '.*\.\(jpg\|jpeg\|png\|webp\)' | shuf -n 1)
WALLPAPER_2=$(find "$TARGET" -type f -regex '.*\.\(jpg\|jpeg\|png\|webp\)' | shuf -n 1)
MON=$(hyprctl monitors -j | jq -r '.[0].name')
MON_1=$(hyprctl monitors -j | jq -r '.[1].name')

CONFIG_PATH="$HOME/.config/hypr/hyprpaper.conf"
echo "$CONFIG_PATH"
echo "$WALLPAPER"
echo "$TARGET"

echo "splash = false" >"$CONFIG_PATH"
echo "wallpaper {" >>"$CONFIG_PATH"
echo "  monitor = $MON" >>"$CONFIG_PATH"
echo "  path = $WALLPAPER" >>"$CONFIG_PATH"
echo "  fit_mode = cover" >>"$CONFIG_PATH"
echo "}" >>"$CONFIG_PATH"

echo "wallpaper {" >>"$CONFIG_PATH"
echo "  monitor = $MON_1" >>"$CONFIG_PATH"
echo "  path = $WALLPAPER" >>"$CONFIG_PATH"
echo "  fit_mode = cover" >>"$CONFIG_PATH"
echo "}" >>"$CONFIG_PATH"
