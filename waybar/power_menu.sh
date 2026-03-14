#!/bin/bash
choice=$(printf "  Wyłącz\n  Uruchom ponownie\n  Uśpij\n  Zablokuj" | wofi --dmenu --prompt "Zasilanie")

case "$choice" in
    "  Wyłącz")           systemctl poweroff ;;
    "  Uruchom ponownie") systemctl reboot ;;
    "  Uśpij")            systemctl suspend ;;
    "  Zablokuj")         hyprlock ;;
esac
