#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/src -mindepth 2 -maxdepth 2 -type d | cut -d'/' -f5- | fzf --tmux --border sharp --prompt=" ")
fi

if [[ -z $selected ]]; then
    exit 0
fi

session_name="boards"
board_name=$(basename "$selected" | tr . _)
board_dir_path="$HOME/src/$selected"
target="$session_name:$board_name"

tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $session_name
    exit 0
fi

if ! tmux has-session -t $session_name 2> /dev/null; then
    tmux new-session -ds $session_name -n $board_name
fi

if ! tmux has-session -t $target 2> /dev/null; then
    tmux new-window -dn $board_name -c $board_dir_path

    tmux select-window -t $target
    tmux split-window -h -p 75 -c $board_dir_path
    tmux select-pane -L
    tmux split-window -v -p 30 -c $board_dir_path
    tmux select-window -t $target

    shift
    tmux send-keys -t $target " "
fi

tmux switch-client -t $session_name
tmux select-window -t $target

