# XDG Paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# zsh config dir
export ZDOTDIR=$HOME/.config/zsh

export PATH="$HOME/.local/bin":$PATH

exec dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY &

/usr/bin/xrandr --auto --output HDMI1 --mode 1920x1080 --right-of eDP1 &
/usr/bin/setxkbmap -layout "us,ru" -option "grp:alt_shift_toggle" &
/usr/bin/pipewire-media-session &
/usr/bin/numlockx on &
/usr/bin/feh -c feh --randomize --bg-fill /usr/share/backgrounds/* &
/usr/bin/picom -f --animations --experimental-backends -b --animation-for-open-window zoom &
/usr/local/bin/slstatus &
/usr/bin/volumeicon &
/usr/bin/unclutter &

/usr/local/bin/dwm
