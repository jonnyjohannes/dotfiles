#!/usr/bin/env bash

pane=${1:-}
[[ -n "$pane" ]] || exit 0

agent_present=$(tmux display-message -p -t "$pane" '#{@pi-agent}' 2>/dev/null) || exit 0
state=$(tmux display-message -p -t "$pane" '#{@pi-state}' 2>/dev/null) || exit 0

[[ "$agent_present" == 1 && "$state" == done ]] || exit 0

tmux set-option -p -t "$pane" @pi-state idle >/dev/null 2>&1 || true
