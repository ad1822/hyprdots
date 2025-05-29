<h1 align="center">Hyprdots - Aesthetic Dotfiles for Hyprland</h1>

<p align="center">
  <a href="https://hyprland.org/"><img src="https://img.shields.io/badge/Hyprland-abd6fd?style=for-the-badge" alt="Hyprland - A dynamic tiling Wayland compositor based on wlroots that doesn't sacrifice on its looks" /></a>
  <a href="https://github.com/Alexays/Waybar"><img src="https://img.shields.io/badge/Waybar-cdd6f4?style=for-the-badge" alt="Waybar - Highly customizable Wayland bar for Sway and Wlroots based compositors" /></a>
  <a href="https://github.com/hyprwm/hyprlock"><img src="https://img.shields.io/badge/Hyprlock-89dceb?style=for-the-badge" alt="Hyprlock - Hyprland's GPU-accelerated screen locking utility" /></a>
  <a href="https://www.gnu.org/software/bash/manual/zsh.html"><img src="https://img.shields.io/badge/zsh-f2cdcd?style=for-the-badge" alt="Z Shell" /></a>
  <a href="https://github.com/kovidgoyal/kitty"><img src="https://img.shields.io/badge/Kitty-cba6f7?style=for-the-badge" alt="Kitty - Cross-platform, fast, feature-rich, GPU based terminal" /></a>
  <a href="https://github.com/lbonn/rofi"><img src="https://img.shields.io/badge/Rofi-fab387?style=for-the-badge" alt="Rofi - A window switcher, application launcher and dmenu replacement" /></a>
  <a href="https://github.com/sentriz/cliphist"><img src="https://img.shields.io/badge/Cliphist-cdd6f4?style=for-the-badge" alt="Cliphist - Wayland clipboard manager" /></a>
  <a href="https://github.com/pwmt/zathura"><img src="https://img.shields.io/badge/Zathura-94e2d5?style=for-the-badge" alt="Zathura is a highly customizable and functional document viewer" /></a>
  <a href="https://github.com/sddm/sddm"><img src="https://img.shields.io/badge/Sddm-a6e3a1?style=for-the-badge" alt="Simple Desktop Display Manager" /></a>
  <a href="https://github.com/dunst-project/dunst"><img src="https://img.shields.io/badge/Dunst-fab387?style=for-the-badge" alt="Dunst - Lightweight and customizable notification daemon" /></a>
  <a href="https://github.com/tmux/tmux/"><img src="https://img.shields.io/badge/Tmux-a6e3a1?style=for-the-badge" alt="Terminal Multiplexer" /></a>
</p>

<p align="center">
  <a href="https://github.com/ad1822/hyprdots/stars">
    <img src="https://img.shields.io/github/stars/ad1822/hyprdots?style=for-the-badge" alt="Stars">
  </a>
  <a href="https://github.com/ad1822/hyprdots/forks">
    <img src="https://img.shields.io/github/forks/ad1822/hyprdots?style=for-the-badge" alt="Stars">
  </a>
  <!-- <a href="https://github.com/ad1822/hyprdots/network/members">
    <img src="https://img.shields.io/github/forks/your-username/hyprdots?style=for-the-badge" alt="Forks">
  </a> -->
  <a href="https://github.com/your-username/hyprdots/commits/main">
    <img src="https://img.shields.io/github/last-commit/ad1822/hyprdots?style=for-the-badge" alt="Last Commit">
  </a>
</p>

<!-- ##### Home: -->

![home](Assets/main.png)

<!-- ##### K9s and Cava: -->

![powermenu](Assets/k9s_cava.png)

<!-- ##### Yazi and Btop: -->

![btop](Assets/btop.png)

<!-- ##### Powermenu: -->

![powermenu](Assets/powermenu.png)

<!-- ##### GoLang Showcase : -->

![powermenu](Assets/go_2.png)

<!-- ##### Launcher: -->

![launcher](Assets/launcher.png)

## Wallpaper

[Wallpaper](https://drive.google.com/drive/folders/1Eog40yvrTshjDLVIETVncBKcDsvPLMIX?usp=sharing)

---

## 🚀 Quick Installation Guide

### 📦 Programs Included

- **Window Manager**: Hyprland (Tiling)
- **Status Bar**: Waybar
- **Notification Manager**: Dunst
- **Browser**: Zen
- **Color Picker**: hyprpicker
- **Wallpaper Utility**: hyprpaper
- **Screenshot Utility**: grim + slurp
- **App Launcher**: Rofi
- **Terminal Emulator**: kitty
- **Shell**: Zsh
- **Media Controls**: playerctl
- **Power Management**: acpi
- **Brightness Control**: brightnessctl
- **Audio Management**: pamixer, PulseAudio
- **Network Management**: NetworkManager (nmcli), iwd (iNet Wireless Daemon)

> ℹ️ **For more detailed guidance**, check out [this](./Resources.md)

---

## 🛠️ Installation Steps

1. **Clone the repository** to your home directory like `~` or `/home/username` :

   ```sh
   git clone https://github.com/ad1822/hyprdots ~/hyprdots
   ```

2. **Navigate to the cloned directory**:

   ```sh
   cd ~/hyprdots
   ```

3. **Run the setup script**:

   ```sh
   sudo bash ./setup.sh
   ```

4. **GTK Theme Setup**:

- [Catppuccin Gtk theme](https://github.com/catppuccin/gtk/releases)

- I use [`ngw-look`](https://github.com/nwg-piotr/nwg-look) to configure GTK themes and styles.

---

## ⚠️ Important Notice (Read Before Running Setup)

> ### **Warning:**
>
> This setup script will **move your existing config files** (e.g., for Waybar, Kitty, Hyprland, etc.) to a backup folder at `~/.config_backup`. Then, it will copy the new configs from this repo into your `~/.config` directory.
>
> ### What this means:
>
> - Your current setup will be **replaced**.
> - If you have customizations you care about, **back them up manually** or review the script before running.
> - Fonts and themes will be installed system-wide in your `~/.local/share/fonts` directory.

---
