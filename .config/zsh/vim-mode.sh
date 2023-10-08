MODE_CURSOR_VIINS="#ffffff blinking bar"
MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ffffff"
MODE_CURSOR_VICMD="white block"
MODE_CURSOR_SEARCH="#ff00ff steady underline"
MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #ffffff"
KEYTIMEOUT=1
VIM_MODE_ESC_PREFIXED_WANTED='^?^Hbdfhul.g'


# # bindkey -e will be emacs mode
# bindkey -v
# export KEYTIMEOUT=1
#
# # Use vim keys in tab complete menu:
# bindkey -M menuselect '^h' vi-backward-char
# bindkey -M menuselect '^k' vi-up-line-or-history
# bindkey -M menuselect '^l' vi-forward-char
# bindkey -M menuselect '^j' vi-down-line-or-history
# bindkey -M menuselect '^[[Z' vi-up-line-or-history
# bindkey -v '^?' backward-delete-char
#
# # Fixing END, HOME, DEL and others
# bindkey -M viins "e[1~" beginning-of-line
# bindkey -M viins "e[4~" end-of-line
# bindkey -M viins "e[5~" beginning-of-history
# bindkey -M viins "e[6~" end-of-history
# bindkey -M viins "e[3~" delete-char
# bindkey -M viins "e[2~" quoted-insert
# bindkey -M viins "e[5C" forward-word
# bindkey -M viins "eOc" emacs-forward-word
# bindkey -M viins "e[5D" backward-word
# bindkey -M viins "eOd" emacs-backward-word
# bindkey -M viins "ee[C" forward-word
# bindkey -M viins "ee[D" backward-word
# bindkey -M viins "^H" backward-delete-word
# # for rxvt
# bindkey "e[8~" end-of-line
# bindkey "e[7~" beginning-of-line
# # for non RH/Debian xterm, can't hurt for RH/DEbian xterm
# bindkey "eOH" beginning-of-line
# bindkey "eOF" end-of-line
# # for freebsd console
# bindkey "e[H" beginning-of-line
# bindkey "e[F" end-of-line
# # completion in the middle of a line
# bindkey '^i' expand-or-complete-prefix
#
# # Change cursor shape for different vi modes.
# function zle-keymap-select () {
#     case $KEYMAP in
#         vicmd) echo -ne '\e[1 q';;      # block
#         viins|main) echo -ne '\e[5 q';; # beam
#     esac
# }
# zle -N zle-keymap-select
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
