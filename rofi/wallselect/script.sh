#!/bin/bash

WALL_DIR="$HOME/Pictures/Wallpaper"

SELECTED=$(find ~/Pictures/Wallpaper -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) |
  while read -r img; do echo -en "$img\0icon\x1f$img\n"; done |
  rofi -dmenu -show-icons -theme "$HOME/.config/rofi/wallselect/style.rasi")

# SELECTED=$(find ~/Pictures/Wallpaper \
#   \( -path ~/Pictures/Wallpaper/catppuccin -o -path ~/Pictures/Wallpaper/temp \) -prune -o \
#   -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) |
#   shuf |
#   while read -r img; do
#     echo -en "$img\0icon\x1f$img\n"
#   done |
#   rofi -dmenu -show-icons -theme "$HOME/.config/rofi/wallselect/style.rasi")

# echo $SELECTED

if [ $(pgrep -c hyprpaper) -ne 0 ] && [ -n "$SELECTED" ]; then
  hyprctl hyprpaper unload all
  killall hyprpaper
fi

CONFIG_PATH="$HOME/.config/hypr/hyprpaper.conf"
echo "preload = $SELECTED" >"$CONFIG_PATH"
echo "wallpaper = eDP-1, $SELECTED" >>"$CONFIG_PATH"
echo "splash = off" >>"$CONFIG_PATH"
echo "ipc = off" >>"$CONFIG_PATH"

hyprpaper &

