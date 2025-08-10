#!/usr/bin/env bash
# Inspired by https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer

selected=$(
    find -L ~/src -name '[!.]*' -mindepth 2 -maxdepth 2 -type d |
    cut -d'/' -f5- |
    fzf --tmux 100% --border sharp --prompt=" "
)

if [[ -z $selected ]]; then
    exit 0
fi

dir="$HOME/src/$selected"

session=$(echo $selected | tr '/' '-' | tr . _)

if ! tmux has-session -t $session 2> /dev/null; then
    tmux new-session -ds $session -c $dir
fi

tmux switch-client -t $session

