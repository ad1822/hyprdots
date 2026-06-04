#!/bin/bash

CONFIG_FILE="$HOME/.config/hypr/modules/decoration.lua"

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "Hyprland config file not found at $CONFIG_FILE"
  exit 1
fi

CURRENT_OPACITY=$(grep -E "^\s*active_opacity\s*=\s*" "$CONFIG_FILE" | awk -F'=' '{print $2}' | tr -d ' ')

echo $CURRENT_OPACITY

CURRENT_OPACITY_2=$(grep -E "^\s*inactive_opacity\s*=\s*" "$CONFIG_FILE" | awk -F'=' '{print $2}' | tr -d ' ')

if [[ "$CURRENT_OPACITY" == "0.90," ]]; then
  NEW_OPACITY="1"
  INACTIVE_OPACITY="1"
  notify-send -i "Transpenecy" "Non Transparent Mode" -t 1000
else
  NEW_OPACITY="0.90"
  INACTIVE_OPACITY="0.70"
  notify-send -i "Transpenecy" "Transparent Mode" -t 1000
fi

sed -i "s/^\s*active_opacity\s*=\s*[0-90.]*/    active_opacity = $NEW_OPACITY/" "$CONFIG_FILE"
sed -i "s/^\s*inactive_opacity\s*=\s*[0-70.]*/    inactive_opacity = $INACTIVE_OPACITY/" "$CONFIG_FILE"

echo "Toggled active_opacity to $NEW_OPACITY"

hyprctl reload
