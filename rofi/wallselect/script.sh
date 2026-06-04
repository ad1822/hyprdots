j!/bin/bash

WALL_DIR="$HOME/Pictures/Wallpaper"

# SELECTED=$(find ~/Pictures/Wallpaper -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) |
#   while read -r img; do echo -en "$img\0icon\x1f$img\n"; done |
#   rofi -dmenu -show-icons -theme "$HOME/.config/rofi/wallselect/style.rasi")

ls -1t --time=birth ~/Pictures/Wallpaper/*.{jpg,jpeg,png} 2>/dev/null

SELECTED=$(find ~/Pictures/Wallpaper \
  -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec stat --format='%W %n' {} + |
  sort -rn |
  cut -d' ' -f2- |
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
MON=$(hyprctl monitors -j | jq -r '.[0].name')
MON_1=$(hyprctl monitors -j | jq -r '.[1].name')

echo "splash = false" >"$CONFIG_PATH"
echo "wallpaper {" >>"$CONFIG_PATH"
echo "  monitor = $MON" >>"$CONFIG_PATH"
echo "  path = $SELECTED" >>"$CONFIG_PATH"
echo "  fit_mode = cover" >>"$CONFIG_PATH"
echo "}" >>"$CONFIG_PATH"

echo "wallpaper {" >>"$CONFIG_PATH"
echo "  monitor = $MON_1" >>"$CONFIG_PATH"
echo "  path = $SELECTED" >>"$CONFIG_PATH"
echo "  fit_mode = cover" >>"$CONFIG_PATH"
echo "}" >>"$CONFIG_PATH"

hyprpaper &
