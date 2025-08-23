#!/bin/bash

colors=(
  'green' 
  'yellow'
  'blue'
  'red'
)

session_id=$(tmux display-message -p '#{session_id}')
session_index=${session_id#$}
color_index=$((session_index % ${#colors[@]}))

echo "${colors[$color_index]}"

