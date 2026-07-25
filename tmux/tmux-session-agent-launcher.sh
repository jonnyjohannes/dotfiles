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
seen_sessions=()
pi_records=()

normalize_session() {
  local value=$1
  value=${value//\//-}
  value=${value//./_}
  printf '%s' "$value"
}

close_session() {
  local session=$1
  tmux kill-session -t "=$session" >/dev/null 2>&1 || true
}

if [[ ${1:-} == '--close' ]]; then
  close_session "${2:?missing session}"
  exit 0
fi

snapshot_pi_info() {
  local pane_session
  local window
  local pane
  local agent_present
  local state

  pi_records=()
  while IFS=$'\t' read -r pane_session window pane agent_present state; do
    [[ "$agent_present" == 1 ]] || continue
    pi_records+=("$pane_session"$'\t'"${state:-idle}"$'\t'"$window"$'\t'"$pane")
  done < <(
    tmux list-panes -a \
      -F $'#{session_name}\t#{window_index}\t#{pane_id}\t#{@pi-agent}\t#{@pi-state}' \
      2>/dev/null || true
  )
}

pi_info() {
  local session=$1
  local record
  local pane_session
  local state
  local window
  local pane

  for record in "${pi_records[@]}"; do
    IFS=$'\t' read -r pane_session state window pane <<<"$record"
    [[ "$pane_session" == "$session" ]] || continue
    printf '%s\t%s\t%s' "$state" "$window" "$pane"
    return 0
  done

  return 1
}

status_color_and_icon() {
  case "$1" in
    working)
      printf '33;5\t■'
      ;;
    done)
      printf '34\t■'
      ;;
    idle)
      printf '90\t■'
      ;;
    *)
      printf '90\t?'
      ;;
  esac
}

session_seen() {
  local session=$1
  local seen

  for seen in "${seen_sessions[@]}"; do
    [[ "$seen" == "$session" ]] && return 0
  done

  return 1
}

add_candidate() {
  local target=$1
  local session=$2
  local label=$3
  local pi_record
  local pi_state
  local pi_window
  local pi_pane
  local status_parts
  local status_color
  local status_icon
  local status_label

  if session_seen "$session"; then
    return 0
  fi
  seen_sessions+=("$session")

  if pi_record=$(pi_info "$session"); then
    IFS=$'\t' read -r pi_state pi_window pi_pane <<<"$pi_record"
    status_parts=$(status_color_and_icon "$pi_state")
    IFS=$'\t' read -r status_color status_icon <<<"$status_parts"
    status_label=$(printf '\033[1;%sm%s\033[0m' \
      "$status_color" \
      "$status_icon")
    label+=" $status_label "
    candidates+=("$target"$'\t'"$label"$'\t'"$session"$'\t'"1"$'\t'"$pi_window"$'\t'"$pi_pane")
  else
    candidates+=("$target"$'\t'"$label"$'\t'"$session"$'\t'"0"$'\t'$'\t')
  fi
}

snapshot_pi_info

# sessions, colour coded
index=0
while IFS= read -r session; do
  [[ -n "$session" ]] || continue
  color_index=$(($index % ${#colors[@]}))
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
      --header $'\n\n[return] (⌐■_■)       [ctrl-x] (x_x) \n\n\n' \
      --expect=f1,f2,f3 \
      --bind 'ctrl-x:execute(tmux kill-session -t {1})+abort' \
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

IFS=$'\t' read -r target _ session pi_present pi_window pi_pane <<<"$selected"
[[ -n "${session:-}" ]] || exit 0

if tmux has-session -t "=$session" 2>/dev/null; then
  dir=$(tmux list-panes -t "=$session" -F '#{pane_current_path}' 2>/dev/null | head -n 1)
else
  dir=$base_dir/$target
  if [[ ! -d "$dir" ]]; then
    tmux display-message "project directory not found: $dir"
    exit 0
  fi
  tmux new-session -ds "$session" -c "$dir"
fi

case "$key" in
  f1 | f2 | f3)
    case "$key" in
      f1) window=1 ;;
      f2) window=2 ;;
      f3) window=3 ;;
    esac
    if ! tmux select-window -t "=$session:$window" 2>/dev/null; then
      tmux display-message "window $window not found in session: $session"
      tmux refresh-client -S
      exit 0
    fi
    ;;
esac

tmux switch-client -t "$session"
tmux refresh-client -S
