#!/usr/bin/env bash

set -euo pipefail

close_agent() {
  local name=$1
  local details
  local workspace

  if ! details=$(herdr agent get "$name" 2>/dev/null); then
    return 0
  fi

  workspace=$(jq -er '.result.agent.workspace_id' <<<"$details")
  herdr workspace close "$workspace" >/dev/null
}

if [[ ${1:-} == '--close' ]]; then
  close_agent "${2:?missing agent name}"
  exit 0
fi

if ! agents=$(herdr agent list 2>/dev/null); then
  tmux display-message 'herdr server is not running'
  exit 0
fi

count=$(jq -r '.result.agents | length' <<<"$agents")

if ((count == 0)); then
  tmux display-message 'no herdr agents found'
  exit 0
fi

format_agents() {
  while IFS=$'\t' read -r session status title; do
    case "$status" in
      blocked)
        color=31
        icon='!'
        ;;
      done)
        color=34
        icon='✓'
        ;;
      working)
        color=33
        icon='…'
        ;;
      idle)
        color=90
        icon='·'
        ;;
      *)
        color=90
        icon='?'
        ;;
    esac

    label=$(
      printf '\033[1;%sm%s %-8s\033[0m  %-30s  %s' \
        "$color" \
        "$icon" \
        "$status" \
        "$session" \
    )

    printf '%s\t%s\n' "$session" "$label"
  done
}

fzf_status=0
selected=$(
  jq -r '
    def priority:
      if . == "blocked" then 0
      elif . == "done" then 1
      elif . == "working" then 2
      elif . == "idle" then 3
      else 4
      end;

    .result.agents
    | sort_by(.agent_status | priority)
    | .[]
    | [
        (.name // .agent // .workspace_id),
        .agent_status,
        (.terminal_title_stripped // .agent // "")
      ]
    | @tsv
  ' <<<"$agents" |
    format_agents |
    fzf \
      --delimiter=$'\t' \
      --with-nth=2 \
      --ansi \
      --tmux top,99% \
      --border=sharp \
      --gap \
      --info=hidden \
      --layout=reverse \
      --prompt='> ' \
      --header=$'\n\n[return] (⌐■_■)       [ctrl-x] (x_x) \n\n\n' \
      --bind 'ctrl-x:execute(bash "$HOME/.config/tmux/tmux-agent-launcher.sh" --close {1})+abort'
) || fzf_status=$?

case "$fzf_status" in
  0)
    ;;
  1 | 130)
    tmux refresh-client -S
    exit 0
    ;;
  *)
    tmux display-message "agent picker failed with status $fzf_status"
    exit 0
    ;;
esac

[[ -n "$selected" ]] || exit 0

session=${selected%%$'\t'*}

if ! tmux has-session -t "=$session" 2>/dev/null; then
  printf '\n  tmux session not found: %s\n' "$session"
  sleep 2
  exit 1
fi

if tmux display-message -p -t "=$session:3" >/dev/null 2>&1; then
  tmux select-window -t "=$session:3"
fi

tmux switch-client -t "=$session"
