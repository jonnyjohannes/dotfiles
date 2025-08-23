#!/usr/bin/env bash
# Inspired by https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer

combo=$({
    tmux list-sessions -F '#{session_name}';
    find ~/src -mindepth 1 -maxdepth 1 -type l | cut -d'/' -f5-;
} | awk '!seen[$0]++ && NF')

selected=$(
    echo $combo | fzf --tmux top,99% --border sharp --prompt='(⌐■_■) '
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

