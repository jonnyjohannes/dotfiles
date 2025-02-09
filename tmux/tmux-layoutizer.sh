#!/usr/bin/env bash
# Inspired by ThePrimegean's tmux-sessionizer and tmux-windowizer

selected=$(find ~/src -mindepth 2 -maxdepth 2 -type d | cut -d'/' -f5- | fzf --tmux --border sharp --prompt=" ")

if [[ -z $selected ]]; then
    exit 0
fi

dir="$HOME/src/$selected"

session=$(echo $selected | cut -d'/' -f1 | tr . _)
window=$(echo $selected | cut -d'/' -f2 | tr . _)
target="$session:$window"

tmux_running=$(pgrep tmux)
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $session
    exit 0
fi

create_tmux_layout() {
    local window=$1
    local dir=$2

    tmux select-window -t $window
    tmux split-window -h -p 70 -c $dir
    tmux select-pane -L
    tmux split-window -v -p 30 -c $dir
    tmux select-pane -U
    tmux select-pane -R
}

if ! tmux has-session -t $session 2> /dev/null; then
    tmux new-session -ds $session -n $window
    create_tmux_layout $window $dir
fi

tmux switch-client -t $session

if ! tmux has-session -t $target 2> /dev/null; then
    tmux new-window -dn $window -c $dir
    create_tmux_layout $window $dir
fi

tmux select-window -t $target

