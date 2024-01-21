#!/bin/sh

if [ -f /tmp/dwm_started ]; then
  exit
fi

touch /tmp/dwm_started

/usr/bin/xrandr --auto --output HDMI1 --mode 1920x1080 --right-of eDP1 &
/usr/bin/setxkbmap -layout 'us,ru' -option 'grp:alt_shift_toggle' &
# /usr/bin/gentoo-pipewire-launcher &
/usr/bin/pipewire &
/usr/bin/picom -b &
/usr/local/bin/dwmblocks &
/usr/bin/bgchd -bcknd feh -dir Images/wallpapers/ -intv 15m &
/usr/bin/bgctl next &
/bin/sh -c "/usr/bin/volumeicon &" &
/bin/sh -c '/usr/bin/sxhkd &' &
/bin/sh -c '/usr/bin/nm-applet &' &
/bin/sh -c '/usr/lib/polkit-kde-authentication-agent-1 &' &
/usr/bin/unclutter &
/usr/bin/numlockx on &
pgrep -x ssh-agent > /dev/null || ssh-agent -a $SSH_AUTH_SOCK
