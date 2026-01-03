#!/bin/bash

WALL_DIR="$HOME/Pictures/Wallpaper"

# SELECTED=$(find ~/Pictures/Wallpaper -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) |
#   while read -r img; do echo -en "$img\0icon\x1f$img\n"; done |
#   rofi -dmenu -show-icons -theme "$HOME/.config/rofi/wallselect/style.rasi")

SELECTED=$(find ~/Pictures/Wallpaper \
  -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) |
  shuf |
  while read -r img; do
    echo -en "$img\0icon\x1f$img\n"
  done |
  rofi -dmenu -show-icons -theme "$HOME/.config/rofi/wallselect/style.rasi")

# echo $SELECTED

if [ $(pgrep -c hyprpaper) -ne 0 ] && [ -n "$SELECTED" ]; then
  hyprctl hyprpaper unload all
  killall hyprpaper
fi

CONFIG_PATH="$HOME/.config/hypr/hyprpaper.conf"

echo "splash = false" >"$CONFIG_PATH"
echo "wallpaper {" >>"$CONFIG_PATH"
echo "  monitor = eDP-1" >>"$CONFIG_PATH"
echo "  path = $SELECTED" >>"$CONFIG_PATH"
echo "  fit_mode = cover" >>"$CONFIG_PATH"
echo "}" >>"$CONFIG_PATH"

hyprpaper &
