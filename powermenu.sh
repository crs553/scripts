#!/bin/sh

chosen=$(echo -e "  Lock\n⏻  Power Off\n  Reboot\n󰤄  Suspend\n  Logout" | \
    wofi --dmenu --insensitive --width 250 --height 300 --style ~/.config/wofi/src/mocha/style.css --prompt "Power")

case "$chosen" in
    "  Lock") swaylock ;;
    "⏻  Power Off") systemctl poweroff ;;
    "  Reboot") systemctl reboot ;;
    "󰤄  Suspend") systemctl suspend ;;
    "  Logout") hyprctl dispatch exit ;;
esac

