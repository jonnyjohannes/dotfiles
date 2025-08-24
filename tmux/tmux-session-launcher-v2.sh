#!/usr/bin/env bash
# Inspired by https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer

base_dir=$HOME/src

colors=(42 43 44 41)
cadidates=()

# sessions, colour coded
index=0
for session in $(tmux list-sessions -F '#{session_name}' 2>/dev/null || true); do 
  color_index=$(($index % ${#colors[@]}))
  ((color_index++))
  color=${colors[$color_index]}
  label="$(printf '\033[1;30;%sm %s \033[0m' "$color" "$session")"
  candidates+=("$session"$'\t'"$label")
  ((index++))
done

# project dirs
for dir in $(find $base_dir -mindepth 2 -maxdepth 2 -type d | cut -d'/' -f5-); do
  label=$(printf '%s' $dir | tr '/' '-' | tr '.' '_' )
  candidates+=("$dir"$'\t'"$label")
done

selected=$(
  printf '%s\n' ${candidates[@]} |
  fzf \
    --ansi \
    --border=sharp \
    --tmux top,99% \
    --gap \
    --prompt="(⌐■_■) " \
    --delimiter='\t' \
    --with-nth=2
)

if [[ -z $selected ]]; then
  exit 0
fi

selected_dir="${selected%%$'\t'*}"
selected_label="${selected#*$'\t'}"

dir=$base_dir/$selected_dir
session=$(printf '%s' $selected_dir | tr '/' '-' | tr '.' '_' )

if ! tmux has-session -t=$session 2> /dev/null; then
    tmux new-session -ds $session -c $dir
fi

tmux switch-client -t $session

