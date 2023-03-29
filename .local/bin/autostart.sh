# /usr/bin/xrandr --auto --output HDMI1 --mode 1920x1080 --right-of eDP1 &
/usr/bin/setxkbmap -layout "us,ru" -option "grp:alt_shift_toggle" &
/usr/bin/gentoo-pipewire-launcher &
/usr/bin/picom -f --animations --experimental-backends -b --animation-for-open-window zoom &
/usr/local/bin/slstatus &
/usr/bin/volumeicon &
/usr/bin/bgchd -bcknd feh -dir Images/wallpapers/current -intv 3m
/usr/bin/bgctl next &
/usr/bin/sxhkd &
/usr/bin/unclutter &

