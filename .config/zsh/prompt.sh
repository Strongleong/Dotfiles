#!/bin/sh

## autoload vcs and colors
autoload -Uz vcs_info
autoload -U colors && colors

# enable only git
zstyle ':vcs_info:*' enable git

# setup a hook that runs before every ptompt.
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
#
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='!'
    fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats " %{$fg[blue]%}(%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[blue]%})"

# format our main prompt for hostname current folder, and permissions.
BASE_PROMPT="%B%{$fg[cyan]%}%c\$vcs_info_msg_0_ %{$fg[blue]%}> %{$reset_color%}"
PROMPT=$BASE_PROMPT
RPROMPT="%{$reset_color%}%(?.. %{$fg[red]%}%B ERR )%{$fg[blue]%}%*%{$reset_color%}"


function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/N}/(main|viins)/I}"
    PROMPT="%B%{$fg[cyan]%}[$RPS1] $BASE_PROMPT"
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
    RPROMPT="%{$reset_color%}%(?.. %{$fg[red]%}%B ERR )%{$fg[blue]%}%*%{$reset_color%}"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
