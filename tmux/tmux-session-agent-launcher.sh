#!/usr/bin/env bash
# Inspired by https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer

colors=(
  42
  44
  45
  43
  46
  41
)
base_dir=$HOME/src
candidates=()

normalize_session() {
  local value=$1
  value=${value//\//-}
  value=${value//./_}
  printf '%s' "$value"
}

close_agent() {
  local name=$1
  local details
  local workspace

  if ! details=$(herdr agent get "$name" 2>/dev/null); then
    return 0
  fi

  if ! workspace=$(jq -er '.result.agent.workspace_id' <<<"$details" 2>/dev/null); then
    return 0
  fi

  herdr workspace close "$workspace" >/dev/null 2>&1 || true
}

close_session() {
  local session=$1
  local agent_present=${2:-0}

  if [[ "$agent_present" == 1 ]]; then
    close_agent "$session"
  fi

  tmux kill-session -t "=$session" >/dev/null 2>&1 || true
}

if [[ ${1:-} == '--close' ]]; then
  close_session "${2:?missing session}" "${3:-0}"
  exit 0
fi

agents_json=
agent_rows=
if agents_json=$(herdr agent list 2>/dev/null); then
  agent_rows=$(jq -r '
    .result.agents[]?
    | [(.name // .agent // .workspace_id // ""),
       (.agent_status // "unknown")]
    | map(gsub("[\\t\\r\\n]"; " "))
    | @tsv
  ' <<<"$agents_json" 2>/dev/null || true)
fi

agent_info() {
  local session=$1
  local agent_name
  local agent_state
  while IFS=$'\t' read -r agent_name agent_state; do
    [[ "$agent_name" == "$session" ]] || continue
    printf '%s' "$agent_state"
    return 0
  done <<<"$agent_rows"

  return 1
}

status_color_and_icon() {
  case "$1" in
    blocked)
      printf '31\t!'
      ;;
    done)
      printf '34\t✓'
      ;;
    working)
      printf '33\t…'
      ;;
    idle)
      printf '90\t·'
      ;;
    *)
      printf '90\t?'
      ;;
  esac
}

add_candidate() {
  local target=$1
  local session=$2
  local label=$3
  local agent_record
  local agent_state
  local status_parts
  local status_color
  local status_icon
  local status_label

  if agent_record=$(agent_info "$session") && [[ -n "$agent_record" ]]; then
    agent_state=$agent_record
    status_parts=$(status_color_and_icon "$agent_state")
    IFS=$'\t' read -r status_color status_icon <<<"$status_parts"
    status_label=$(printf '\033[1;%sm%s %-8s\033[0m' \
      "$status_color" \
      "$status_icon" \
      "$agent_state")
    label+="  $status_label"
    candidates+=("$target"$'\t'"$label"$'\t'"$session"$'\t'1)
  else
    candidates+=("$target"$'\t'"$label"$'\t'"$session"$'\t'0)
  fi
}

# sessions, colour coded
index=0
while IFS= read -r session; do
  [[ -n "$session" ]] || continue
  color_index=$(($index % ${#colors[@]}))
  ((color_index++))
  color=${colors[$color_index]}

  label=$(printf '\033[1;30;%sm %s \033[0m' "$color" "$session")
  add_candidate "$session" "$session" "$label"

  ((index++))
done < <(tmux list-sessions -F '#{session_name}' 2>/dev/null || true)

# project dirs
while IFS= read -r -d '' dir; do
  relative=${dir#"$base_dir"/}
  session=$(normalize_session "$relative")
  label=$session
  add_candidate "$relative" "$session" "$label"
done < <(find -L "$base_dir" -mindepth 2 -maxdepth 2 -type d -print0 2>/dev/null || true)

# Alacritty maps Ctrl-Enter to the Insert key sequence so fzf can
# distinguish it from ordinary Enter.
fzf_status=0
selected_output=$(
  printf '%s\n' "${candidates[@]}" |
    fzf \
      --delimiter='\t' \
      --with-nth=2 \
      --ansi \
      --tmux top,99% \
      --border=sharp \
      --gap \
      --info=hidden \
      --layout=reverse \
      --header $'\n\n[return] (⌐■_■)       [ctrl-enter] <|°_°|>       [ctrl-x] (x_x) \n\n\n' \
      --expect=insert \
      --bind 'ctrl-x:execute(bash "$HOME/.config/tmux/tmux-session-agent-launcher.sh" --close {3} {4})+abort'
) || fzf_status=$?

case "$fzf_status" in
  0)
    ;;
  1 | 130)
    tmux refresh-client -S
    exit 0
    ;;
  *)
    tmux display-message "session picker failed with status $fzf_status"
    exit 0
    ;;
esac

[[ -n "$selected_output" ]] || exit 0

key=
selected=$selected_output
if [[ "$selected_output" == *$'\n'* ]]; then
  key=${selected_output%%$'\n'*}
  selected=${selected_output#*$'\n'}
fi

IFS=$'\t' read -r target _ session agent_present <<<"$selected"
[[ -n "${session:-}" ]] || exit 0

dir=$base_dir/$target
if ! tmux has-session -t "=$session" 2>/dev/null; then
  if [[ ! -d "$dir" ]]; then
    tmux display-message "tmux session not found: $session"
    exit 0
  fi
  tmux new-session -ds "$session" -c "$dir"
fi

if [[ "$key" == insert && "$agent_present" == 1 ]]; then
  # tmux window focus does not always produce Herdr's focus event. Mark the
  # agent seen explicitly so Herdr transitions done (idle + unseen) to idle.
  herdr agent focus "$session" >/dev/null 2>&1 || true

  if tmux list-windows -t "=$session" -F '#{window_index}' 2>/dev/null | grep -qx '3'; then
    tmux select-window -t "=$session:3"
  fi
fi

tmux switch-client -t "$session"
tmux refresh-client -S
