#!/bin/bash

/usr/bin/eww daemon &
$HOME/.config/eww/scripts/open-bars-on-all-screens &
/usr/bin/swww-daemon &
/usr/bin/artix-pipewire-loader &
/usr/lib/hyprpolkitagent &
/usr/bin/hypridle &
/usr/bin/dunst &
/usr/bin/nm-applet &
/usr/bin/dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &
/usr/lib/xdg-desktop-portal-hyprland &
/usr/lib/xdg-desktop-portal &
/usr/bin/pcmanfm --daemon-mode &
/usr/bin/walker --gapplication-service &
/usr/bin/blueman-applet &
/usr/bin/hyprpm update -n &
