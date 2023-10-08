#!/bin/sh

if [ -f /tmp/dwm_started ]; then
  exit
fi

touch /tmp/dwm_started

# /usr/bin/xrandr --auto --output HDMI1 --mode 1920x1080 --right-of eDP1 &#!/bin/bash
/usr/bin/setxkbmap -layout 'us,ru' -option 'grp:alt_shift_toggle' &
/usr/bin/gentoo-pipewire-launcher &
/usr/bin/picom -b &
/usr/local/bin/dwmblocks &
/usr/bin/volumeicon &
/usr/bin/bgchd -bcknd feh -dir Images/wallpapers/ -intv 15m &
/usr/bin/bgctl next &
/bin/sh -c '/usr/bin/sxhkd &' &
/usr/bin/unclutter &
