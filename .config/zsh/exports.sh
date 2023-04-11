#!/bin/sh
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000

# XDG Paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export PATH="$HOME/.local/bin":$PATH
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH=$HOME/.local/share/go/bin:$PATH
export PATH="$PATH:./node_modules/.bin"
export TERM=alacritty
export TERMINAL="alacritty"
export QT_QPA_PLATFORMTHEME="gtk2"
export EDITOR="nvim"
export BROWSER="firefox-bin"

# Proton Discord RPC fix
export WINEDLLPATH=$WINEDLLPATH:/opt/discord-rpc/bin64:/opt/discord-rpc/bin32

# For QT Themes
export QT_QPA_PLATFORMTHEME=qt5ct
eval "$(zoxide init zsh)"
