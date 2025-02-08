#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/src ~/src/j2 ~/src/wayfair -mindepth 1 -maxdepth 1 -type d | fzf --tmux)
fi

if [[ -z $selected ]]; then
    exit 0
fi

session_name="boards"
selected_name=$(basename "$selected" | tr . _)
target="$session_name:$selected_name"
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $session_name -c $selected
    exit 0
fi

if ! tmux has-session -t $session_name 2> /dev/null; then
    tmux new-session -ds $session_name -n $selected_name -c $selected
fi

if ! tmux has-session -t $target 2> /dev/null; then
    tmux neww -dn $selected_name

    shift
    tmux send-keys -t $target "cd $selected"
fi

tmux switch-client -t $session_name
tmux select-window -t $target

