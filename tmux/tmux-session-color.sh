#!/usr/bin/env bash

colors=(
  'green' 
  'yellow'
  'blue'
  'red'
)

active_session=$(tmux display-message -p '#S')
index=0
for session in $(tmux list-sessions -F '#S' 2>/dev/null); do
        if [[ "$session" == "$active_session" ]]; then
                break 
        fi
        ((index++))
done
color_index=$(($index % ${#colors[@]}))

echo "${colors[$color_index]}"

