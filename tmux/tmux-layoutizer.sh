#!/usr/bin/env bash
# Inspired by ThePrimegean's tmux-sessionizer and tmux-windowizer

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find -L ~/src -mindepth 2 -maxdepth 2 -type d | cut -d'/' -f5- | fzf --tmux --border sharp --prompt=" ")
fi;


if [[ -z $selected ]]; then
    exit 0
fi

dir="$HOME/src/$selected"

session=$(echo $selected | tr '/' '-' | tr . _)

tmux_running=$(pgrep tmux)
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $session
    exit 0
fi

create_tmux_layout() {
    local dir=$1

    tmux select-window
    tmux split-window -h -p 80 -c $dir
    tmux select-pane -L
    tmux split-window -v -p 20 -c $dir
    tmux select-pane -U
    tmux select-pane -R
}

if ! tmux has-session -t $session 2> /dev/null; then
    tmux new-session -ds $session -c $dir
    tmux switch-client -t $session
    # create_tmux_layout $dir
fi

tmux switch-client -t $session

