#!/usr/bin/env bash

set -euo pipefail

session=${1:?usage: tmux-agent-herdr.sh SESSION DIR [COMMAND...]}
dir=${2:?usage: tmux-agent-herdr.sh SESSION DIR [COMMAND...]}
shift 2

if (($#)); then
  agent_command=("$@")
else
  agent_command=(pi)
fi

# Keep Herdr's rendered terminal stream on tmux's primary screen so tmux
# retains it in its own history for normal copy mode.
if [[ -n ${TMUX_PANE:-} ]]; then
  tmux set-window-option -t "$TMUX_PANE" alternate-screen off
fi

if ! herdr status server >/dev/null 2>&1; then
  printf 'herdr server is not running\n' >&2
  exit 1
fi

# The Herdr agent name doubles as its tmux session routing key.
if herdr agent get "$session" >/dev/null 2>&1; then
  herdr agent attach "$session"
  exit
fi

created=$(
  herdr workspace create \
    --cwd "$dir" \
    --label "$session" \
    --no-focus
)

workspace=$(jq -er '.result.workspace.workspace_id' <<<"$created")
root_pane=$(jq -er '.result.root_pane.pane_id' <<<"$created")

cleanup_workspace() {
  herdr workspace close "$workspace" >/dev/null 2>&1 || true
}

if ! herdr agent start "$session" \
  --workspace "$workspace" \
  --cwd "$dir" \
  --no-focus \
  -- "${agent_command[@]}"
then
  cleanup_workspace
  exit 1
fi

# workspace create starts with a shell pane; the named agent replaces it.
if ! herdr pane close "$root_pane" >/dev/null; then
  cleanup_workspace
  exit 1
fi

herdr agent attach "$session"
