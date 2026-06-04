#!/usr/bin/env bash

set -euo pipefail

# ── Config ──────────────────────────────────────────────────────────
ROFI_DIR="$HOME/.config/rofi/powermenu"
THEME="style"

UPTIME="$(uptime -p |
  sed 's/up //; s/hours\?/hr/g; s/minutes\?/min/g')"

# ── Options ─────────────────────────────────────────────────────────
declare -A ACTIONS=(
  ["Shutdown"]="hyprshutdown -t 'Shutting Down...' --post-cmd 'shutdown -P 0'"
  ["Reboot"]="reboot"
  ["Logout"]="hyprshutdown -t 'Loging Out... ' --post-cmd 'logout -P 0'"
)

LOCK_CMD=""

[[ -n "$LOCK_CMD" ]] && ACTIONS["Lock"]="$LOCK_CMD"

# ── Rofi Helpers ────────────────────────────────────────────────────
rofi_menu() {
  rofi -dmenu \
    -p " $USER" \
    -mesg "󰥔 Uptime: $UPTIME" \
    -theme "${ROFI_DIR}/${THEME}.rasi"
}

confirm_menu() {
  rofi -dmenu \
    -p "Confirmation" \
    -mesg "Are you sure?" \
    -theme "${ROFI_DIR}/confirmation.rasi"
}

confirm() {
  local answer

  answer=$(
    printf "Yes\nNo" | confirm_menu
  )

  [[ "$answer" == "Yes" ]]
}

# ── Main Menu ───────────────────────────────────────────────────────
chosen=$(
  printf '%s\n' "${!ACTIONS[@]}" |
    sort |
    rofi_menu
)

[[ -z "${chosen:-}" ]] && exit 0

# ── Execute ─────────────────────────────────────────────────────────
if confirm; then
  eval "${ACTIONS[$chosen]}"
fi
