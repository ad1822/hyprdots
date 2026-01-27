#!/bin/bash

set -euo pipefail

echo "==> Installing core packages..."

yay -S --noconfirm \
  pacseek \
  zoxide \
  fzf \
  unzip \
  starship \
  atuin \
  eza \
  acpi \
  playerctl

sudo pacman -S --noconfirm \
  dunst \
  libnotify \
  ttf-iosevka-nerd \
  wget \
  waybar \
  wl-clipboard \
  xdg-desktop-portal-hyprland \
  xdg-desktop-portal \
  brightnessctl \
  pavucontrol \
  tmux \
  slurp \
  grim \
  hyprlock \
  pamixer

if [ "$EUID" -eq 0 ]; then
  echo "❌ Do not run this script as root or with sudo."
  echo "Run it as your normal user. The script will ask for sudo when needed."
  exit 1
fi

# Text colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[97m"
RESET="\e[0m"

# Bold variants
BOLD="\e[1m"
BRED="\e[1;31m"
BGREEN="\e[1;32m"
BYELLOW="\e[1;33m"
BBLUE="\e[1;34m"

cecho() {
  local color=$1
  shift
  case "$color" in
  RED) echo -e "\e[31m$*\e[0m" ;;
  GREEN) echo -e "\e[32m$*\e[0m" ;;
  YELLOW) echo -e "\e[33m$*\e[0m" ;;
  BLUE) echo -e "\e[34m$*\e[0m" ;;
  MAGNETA) echo -e "\e[35m$*\e[0m" ;;
  CYAN) echo -e "\e[36m$*\e[0m" ;;
  *) echo "$@" ;; # Default no color
  esac
}

BACKUP_DIR="$HOME/.config_backup"
LOCAL_BIN="$HOME/.local/bin"
FONT_DIR="$HOME/.local/share/fonts"
DOTS_DIR="$HOME/hyprdots"

setup_hypr() {
  local BACKUP_DIR="$HOME/.config_backup"
  local EXISTING_CONFIG="$HOME/.config/hypr"
  local NEW_CONFIG_SOURCE="$HOME/hyprdots/hypr"

  read -p $'\e[34mDo you want to set Hyprland config (y/n): \e[0m' ans

  if [[ "$ans" != "y" ]]; then
    cecho RED "Skipped Hyprland setup."
    return
  fi

  cecho GREEN "Starting Hyprland config setup..."

  if ! command -v Hyprland &>/dev/null; then
    cecho YELLOW "Installing Hyprland and Wayland..."
    if ! sudo pacman -S --needed --noconfirm hyprland wayland; then
      cecho RED "Package installation failed. Aborting."
      return 1
    fi
  else
    cecho GREEN "Hyprland already installed."
  fi

  mkdir -p "$BACKUP_DIR"

  if [[ -d "$EXISTING_CONFIG" ]]; then
    local timestamp=$(date +%s)
    mv "$EXISTING_CONFIG" "$BACKUP_DIR/hypr_$timestamp"
    cecho RED "Existing Hyprland config backed up to $BACKUP_DIR/hypr_$timestamp"
  else
    cecho YELLOW "No existing Hyprland config to backup."
  fi

  if [[ -d "$NEW_CONFIG_SOURCE" ]]; then
    cp -r "$NEW_CONFIG_SOURCE" "$EXISTING_CONFIG"
    cecho GREEN "Hyprland config successfully moved to ~/.config/hypr"
  else
    cecho RED "New config directory not found at $NEW_CONFIG_SOURCE. Aborting."
    return 1
  fi

  cecho GREEN "Hyprland config setup complete."
}

setup_waybar() {
  local BACKUP_DIR="$HOME/.config_backup"
  local EXISTING_CONFIG="$HOME/.config/waybar"
  local NEW_CONFIG_SOURCE="$HOME/hyprdots/waybar"

  read -p $'\e[34mDo you want to set waybar config (y/n): \e[0m' ans

  if [[ "$ans" != "y" ]]; then
    cecho RED "Skipped Waybar setup."
    return
  fi

  cecho GREEN "Starting Waybar config setup..."

  if ! command -v waybar &>/dev/null; then
    cecho YELLOW "Installing Waybar..."
    if ! sudo pacman -S --needed --noconfirm waybar; then
      cecho RED "Package installation failed. Aborting."
      return 1
    fi
  else
    cecho GREEN "Waybar already installed."
  fi

  mkdir -p "$BACKUP_DIR"

  if [[ -d "$EXISTING_CONFIG" ]]; then
    local timestamp=$(date +%s)
    mv "$EXISTING_CONFIG" "$BACKUP_DIR/waybar_$timestamp"
    cecho RED "Existing Waybar config backed up to $BACKUP_DIR/waybar_$timestamp"
  else
    cecho YELLOW "No existing Waybar config to backup."
  fi

  if [[ -d "$NEW_CONFIG_SOURCE" ]]; then
    cp -r "$NEW_CONFIG_SOURCE" "$EXISTING_CONFIG"
    cecho GREEN "Waybar config successfully moved to ~/.config/waybar"
    chmod +x $EXISTING_CONFIG/scripts/*
    touch ~/.config/waybar/scripts/.env
    echo "GITHUB_USERNAME=" >>~/.config/waybar/scripts/.env
    echo "GITHUB_PAT=" >>~/.config/waybar/scripts/.env

    cecho CYAN "For Setting up Github Weekly Waybar Module, Consider this : https://github.com/ad1822/weekly-github-waybar-module"
  else
    cecho RED "New config directory not found at $NEW_CONFIG_SOURCE. Aborting."
    return 1
  fi

  cecho GREEN "Waybar config setup complete."
}

setup_dunst() {
  local BACKUP_DIR="$HOME/.config_backup"
  local EXISTING_CONFIG="$HOME/.config/dunst"
  local NEW_CONFIG_SOURCE="$HOME/hyprdots/dunst"
  local LOCAL_BIN="$HOME/.local/bin"
  local DOTFILES_BIN="$HOME/hyprdots/bin"

  read -p $'\e[34mDo you want to set dunst config (y/n): \e[0m' ans
  if [[ "$ans" != "y" ]]; then
    cecho RED "Skipped Dunst setup."
    return
  fi

  cecho GREEN "Starting Dunst config setup..."

  # Install Dunst and dependencies
  cecho YELLOW "Installing Dunst and libnotify..."
  if ! sudo pacman -S --needed --noconfirm dunst libnotify; then
    cecho RED "Package installation failed. Aborting."
    return 1
  fi

  # Create local bin directory if needed
  mkdir -p "$LOCAL_BIN"

  # Copy bin scripts if source exists
  if [[ -d "$DOTFILES_BIN" ]]; then
    cp -u "$DOTFILES_BIN"/* "$LOCAL_BIN"/ 2>/dev/null
    chmod +x "$LOCAL_BIN"/* 2>/dev/null
    cecho GREEN "Copied and set executable permissions for scripts in ~/.local/bin"
  else
    cecho YELLOW "No scripts found at $DOTFILES_BIN"
  fi

  # Create backup directory
  mkdir -p "$BACKUP_DIR"

  # Backup existing config
  if [[ -d "$EXISTING_CONFIG" ]]; then
    local timestamp
    timestamp=$(date +%s)
    mv "$EXISTING_CONFIG" "$BACKUP_DIR/dunst_$timestamp"
    cecho RED "Existing Dunst config backed up to $BACKUP_DIR/dunst_$timestamp"
  else
    cecho YELLOW "No existing Dunst config to backup."
  fi

  # Copy new config
  if [[ -d "$NEW_CONFIG_SOURCE" ]]; then
    cp -r "$NEW_CONFIG_SOURCE" "$EXISTING_CONFIG"
    cecho GREEN "Dunst config set at ~/.config/dunst"
  else
    cecho RED "New config not found at $NEW_CONFIG_SOURCE. Aborting."
    return 1
  fi

  cecho GREEN "Dunst setup complete."
}

setup_yazi() {
  local BACKUP_DIR="$HOME/.config_backup"
  local EXISTING_CONFIG="$HOME/.config/yazi"
  local NEW_CONFIG_SOURCE="$HOME/hyprdots/yazi"

  read -p $'\e[34mDo you want to set Yazi config (y/n): \e[0m' ans

  if [[ "$ans" != "y" ]]; then
    cecho RED "Skipped Yazi setup."
    return
  fi

  cecho GREEN "Starting Yazi config setup..."

  if ! command -v yazi &>/dev/null; then
    cecho YELLOW "Installing Yazi..."
    if ! sudo pacman -S --needed --noconfirm yazi; then
      cecho RED "Package installation failed. Aborting."
      return 1
    fi
  else
    cecho GREEN "Yazi already installed."
  fi

  mkdir -p "$BACKUP_DIR"

  if [[ -d "$EXISTING_CONFIG" ]]; then
    local timestamp=$(date +%s)
    mv "$EXISTING_CONFIG" "$BACKUP_DIR/yazi_$timestamp"
    cecho RED "Existing Yazi config backed up to $BACKUP_DIR/yazi_$timestamp"
  else
    cecho YELLOW "No existing Yazi config to backup."
  fi

  if [[ -d "$NEW_CONFIG_SOURCE" ]]; then
    cp -r "$NEW_CONFIG_SOURCE" "$EXISTING_CONFIG"
    cecho GREEN "Yazi config successfully moved to ~/.config/yazi"
  else
    cecho RED "New config directory not found at $NEW_CONFIG_SOURCE. Aborting."
    return 1
  fi

  cecho GREEN "Installing Yazi Plugins"
  ya pkg install

  cecho GREEN "Yazi config setup complete."
}

setup_rofi() {
  local BACKUP_DIR="$HOME/.config_backup"
  local EXISTING_CONFIG="$HOME/.config/rofi"
  local NEW_CONFIG_SOURCE="$HOME/hyprdots/rofi"

  read -p $'\e[34mDo you want to set Rofi config (y/n): \e[0m' ans
  if [[ "$ans" != "y" ]]; then
    cecho RED "Skipped Rofi setup."
    return
  fi

  cecho GREEN "Starting Rofi config setup..."

  # Check and install Rofi
  if ! command -v rofi &>/dev/null; then
    cecho YELLOW "Rofi not found. Installing..."
    if ! sudo pacman -S --needed --noconfirm rofi; then
      cecho RED "Failed to install Rofi. Aborting."
      return 1
    fi
  else
    cecho GREEN "Rofi is already installed."
  fi

  # Ensure backup dir exists
  mkdir -p "$BACKUP_DIR"

  # Backup existing config if present
  if [[ -d "$EXISTING_CONFIG" ]]; then
    local timestamp=$(date +%s)
    mv "$EXISTING_CONFIG" "$BACKUP_DIR/rofi_$timestamp"
    cecho RED "Existing Rofi config backed up to $BACKUP_DIR/rofi_$timestamp"
  else
    cecho YELLOW "No existing Rofi config found to backup."
  fi

  # Copy new config
  if [[ -d "$NEW_CONFIG_SOURCE" ]]; then
    cp -r "$NEW_CONFIG_SOURCE" "$EXISTING_CONFIG"
    cecho GREEN "Rofi config successfully copied to ~/.config/rofi"
    chmod +x ~/.config/rofi/*
  else
    cecho RED "New config not found at $NEW_CONFIG_SOURCE. Aborting."
    return 1
  fi

  cecho GREEN "Rofi config setup complete."
}

setup_yay() {
  read -p $'\e[34mDo you want to install yay AUR helper (y/n): \e[0m' ans
  if [[ "$ans" != "y" ]]; then
    cecho RED "Skipped yay installation."
    return
  fi

  if command -v yay &>/dev/null; then
    cecho GREEN "✔ yay is already installed."
    return
  fi

  cecho GREEN "Installing yay AUR helper..."

  sudo pacman -S --needed --noconfirm git base-devel || {
    cecho RED "Failed to install required packages. Aborting."
    return 1
  }

  local YAY_DIR
  YAY_DIR=$(mktemp -d)

  git clone https://aur.archlinux.org/yay.git "$YAY_DIR" || {
    cecho RED "Failed to clone yay repository."
    return 1
  }

  cd "$YAY_DIR" || return 1
  makepkg -si --noconfirm || {
    cecho RED "yay build failed."
    return 1
  }

  cd - >/dev/null
  rm -rf "$YAY_DIR"

  cecho GREEN "yay installation complete."
}

setup_fish() {
  local BACKUP_DIR="$HOME/.config_backup"
  local EXISTING_CONFIG="$HOME/.config/fish"
  local NEW_CONFIG_SOURCE="$HOME/hyprdots/fish"

  read -p $'\e[34mDo you want to set up Fish shell config (y/n): \e[0m' ans

  if [[ "$ans" != "y" ]]; then
    echo -e "\e[31mSkipped Fish shell setup.\e[0m"
    return
  fi

  echo -e "\e[32mStarting Fish shell config setup...\e[0m"

  # Install Fish if not installed
  if ! command -v fish &>/dev/null; then
    echo -e "\e[33mInstalling Fish shell...\e[0m"
    if ! sudo pacman -S --needed --noconfirm fish; then
      echo -e "\e[31mFish installation failed. Aborting.\e[0m"
      return 1
    fi
  else
    echo -e "\e[32mFish shell already installed.\e[0m"
  fi

  setup_wakafetch() {
  read -p $'\e[34mDo you want to install wakafetch-sqlite (y/n): \e[0m' ans
  if [[ "$ans" != "y" ]]; then
    cecho RED "Skipped wakafetch-sqlite setup."
    return
  fi

  cecho GREEN "Installing wakafetch-sqlite..."

  if wget -q "https://raw.githubusercontent.com/ad1822/wakafetch-sqlite/dev/wakafetch-sqlite" -O /tmp/wakafetch-sqlite; then
    sudo mv /tmp/wakafetch-sqlite /usr/bin/wakafetch-sqlite
    sudo chmod +x /usr/bin/wakafetch-sqlite
    cecho GREEN "wakafetch-sqlite installation complete"
  else
    cecho RED "wakafetch-sqlite installation failed. Aborting"
    return 1
  fi
}

  # Backup existing config
  mkdir -p "$BACKUP_DIR"
  if [[ -d "$EXISTING_CONFIG" ]]; then
    local timestamp
    timestamp=$(date +%s)
    mv "$EXISTING_CONFIG" "$BACKUP_DIR/fish_$timestamp"
    echo -e "\e[31mExisting Fish config backed up to $BACKUP_DIR/fish_$timestamp\e[0m"
  else
    echo -e "\e[33mNo existing Fish config to backup.\e[0m"
  fi

  # Copy new config
  if [[ -d "$NEW_CONFIG_SOURCE" ]]; then
    cp -r "$NEW_CONFIG_SOURCE" "$EXISTING_CONFIG"
    echo -e "\e[32mFish config successfully moved to ~/.config/fish\e[0m"
  else
    echo -e "\e[31mNew config directory not found at $NEW_CONFIG_SOURCE. Aborting.\e[0m"
    return 1
  fi

  # Set Fish as default shell
  if [[ "$SHELL" != "/usr/bin/fish" ]]; then
    echo -e "\e[32mSetting Fish as default shell...\e[0m"
    chsh -s /usr/bin/fish
  fi

  echo -e "\e[32mFish shell setup complete. Fish is now your default shell.\e[0m"
}

setup_other_things() {
  read -p $'\e[34mDo you want to backup and replace other configs (cava, kitty, fastfetch, starship etc.)? (y/n): \e[0m' ans
  if [[ "$ans" != "y" ]]; then
    cecho RED "Skipped other configs setup."
    return
  fi

  CONFIGS="cava kitty fastfetch pacseek hypridle starship"
  BACKUP_DIR="$HOME/.config_backup"

  cecho GREEN "==> Backing up and replacing config files..."
  mkdir -p "$BACKUP_DIR" || {
    cecho RED "Failed to create backup directory: $BACKUP_DIR"
    return 1
  }

  for dir in $CONFIGS; do
    SRC="$HOME/.config/$dir"
    if [ -d "$SRC" ]; then
      cecho YELLOW "=> Backing up $dir to $BACKUP_DIR"
      cp -r "$SRC" "$BACKUP_DIR/" && cecho GREEN "✓ $dir backed up."
      rm -rf "$SRC" && cecho GREEN "✓ $dir removed from ~/.config."
    else
      cecho BLUE "=> Skipped $dir: Not found in ~/.config"
    fi
  done

  cecho GREEN "All selected configs processed. Backup saved at: $BACKUP_DIR"
}

cecho CYAN "==> Creating wallpaper directory..."
mkdir -p "$HOME/Pictures/Wallpaper"

setup_yay
setup_hypr
setup_waybar
setup_dunst
setup_yazi
setup_rofi
setup_fish
setup_other_things
