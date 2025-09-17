#!/bin/sh
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000

# XDG Paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# Random stuff that I like
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH="$HOME/.local/bin":$PATH
export PATH=$HOME/.local/share/go/bin:$PATH
export PATH="$PATH:./node_modules/.bin"
export PATH="$PATH:/opt/android-sdk/platform-tools/"
export PATH="$PATH:/opt/android-sdk/tools/bin/"
export PATH="$PATH:/opt/android-sdk/emulator/"
export QT_QPA_PLATFORMTHEME="gtk2"
export EDITOR="nvim"
export BROWSER="firefox-bin"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export ANDROID_HOME="/opt/android-sdk"
export GRIMBLAST_EDITOR="satty -f"

export GBDKDIR=/opt/gbdk/

# Proton Discord RPC fix
export WINEDLLPATH=$WINEDLLPATH:/opt/discord-rpc/bin64:/opt/discord-rpc/bin32

# For QT Themes
export QT_QPA_PLATFORMTHEME=qt5ct

# Cleaning $HOME folders
export HISTFILE="${XDG_STATE_HOME}"/bash/history
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NVM_DIR="$XDG_DATA_HOME"/nvm
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export PYTHONSTARTUP="/etc/python/pythonrc"
export W3M_DIR="$XDG_DATA_HOME"/w3m
export WINEPREFIX="$XDG_DATA_HOME"/wine
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export GPG_TTY=$(tty)
