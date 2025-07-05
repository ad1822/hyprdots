#!/usr/bin/bash

if [ $(pgrep -c hyprpaper) -ne 0 ]; then
    hyprctl hyprpaper unload all
    killall hyprpaper
fi

TARGET="$HOME/Pictures/Wallpaper/Catppuccin"
WALLPAPER=$(find "$TARGET" -type f -regex '.*\.\(jpg\|jpeg\|png\|webp\)' | shuf -n 1)

CONFIG_PATH="$HOME/.config/hypr/hyprpaper.conf"
echo "preload = $WALLPAPER" > "$CONFIG_PATH"
echo "wallpaper = eDP-1, $WALLPAPER" >> "$CONFIG_PATH"
echo "splash = off" >> "$CONFIG_PATH"
echo "ipc = off" >> "$CONFIG_PATH"
