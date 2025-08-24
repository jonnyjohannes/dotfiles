#!/usr/bin/env bash
set -euo pipefail

# 🧰 Usage:
#   sessionize tmux
#   sessionize links [-b BASE_DIR]
#   sessionize dirs  [-b BASE_DIR]
#
# Examples:
#   sessionize links -b ~/src
#   sessionize dirs
#
# Notes:
# - "tmux": shows existing tmux sessions
# - "links": shows top-level symlinks under BASE_DIR
# - "dirs": shows top-level directories under BASE_DIR

usage() {
  cat <<'EOF'
usage: sessionize MODE [options]

MODE:
  tmux    list existing tmux sessions
  links   list top-level symlinks under BASE_DIR
  dirs    list top-level directories under BASE_DIR

Options:
  -b BASE_DIR   base directory for links/dirs (default: ~/src)
  -p PROMPT     fzf prompt (default: (⌐■_■) )
  -h            show this help

Examples:
  sessionize tmux
  sessionize links -b ~/src
  sessionize dirs -p 'pick-a-project> '
EOF
}

mode="${1:-}"
if [[ -z "$mode" ]]; then
  usage; exit 1
fi
shift || true

base_dir="$HOME/src"
fzf_prompt="(⌐■_■) "

while getopts ":b:p:h" opt; do
  case "$opt" in
    b) base_dir="$OPTARG" ;;
    p) fzf_prompt="$OPTARG" ;;
    h) usage; exit 0 ;;
    \?) echo "Unknown option: -$OPTARG" >&2; usage; exit 1 ;;
    :)  echo "Option -$OPTARG requires an argument." >&2; usage; exit 1 ;;
  esac
done

# Ensure tmux/fzf/find exist where needed
need() { command -v "$1" >/dev/null 2>&1 || { echo "Missing dependency: $1" >&2; exit 1; }; }

need fzf
case "$mode" in
  tmux) need tmux ;;
  links|dirs) need find ;;
  *) echo "Invalid MODE: $mode" >&2; usage; exit 1 ;;
esac

# Build candidate list
candidates=()
case "$mode" in
  tmux)
    fzf_prompt=""
    while IFS= read -r line; do
      candidates+=("$line")
    done < <(tmux list-sessions -F '#{session_name}' 2>/dev/null || true)
    ;;
  links)
    fzf_prompt="(☼_☼) "
    while IFS= read -r line; do
      candidates+=("$line")
    done < <(find $base_dir -name '[!.]*' -mindepth 1 -maxdepth 1 -type l | cut -d'/' -f5- | awk 'NF')
    ;;
  dirs)
    while IFS= read -r line; do
      candidates+=("$line")
    done < <(find $base_dir -name '[!.]*' -mindepth 2 -maxdepth 2 -type d | cut -d'/' -f5- | awk 'NF')
    ;;
esac

# If no candidates, bail early (honesty is policy)
if [[ "${#candidates[@]}" -eq 0 ]]; then
  case "$mode" in
    tmux) echo "No tmux sessions found." ;;
    links) echo "No symlinks found under: $base_dir" ;;
    dirs) echo "No directories found under: $base_dir" ;;
  esac
  exit 0
fi

# fzf invocation — use tmux popup if inside tmux
fzf_cmd=(fzf --border=sharp --prompt="$fzf_prompt")
if [[ -n "${TMUX:-}" ]]; then
  fzf_cmd+=(--tmux top,99%)
fi

selected="$(
  printf '%s\n' "${candidates[@]}" | "${fzf_cmd[@]}" || true
)"

# User bailed
if [[ -z "${selected:-}" ]]; then
  exit 0
fi

# Act on selection
if [[ "$mode" == "tmux" ]]; then
  # Just jump to the existing session
  if [[ -n "${TMUX:-}" ]]; then
    tmux switch-client -t "$selected"
  else
    tmux attach -t "$selected"
  fi
  exit 0
fi

# For links/dirs: create/attach to a session named after the path
dir="$base_dir/$selected"
# Session names can’t have '/', '.' is meh; normalize
session="$(printf '%s' "$selected" | tr '/' '-' | tr '.' '_' )"

# Ensure directory exists (for symlinks it can point elsewhere; we still cd to the link itself)
if [[ ! -e "$dir" ]]; then
  echo "Selected path does not exist: $dir" >&2
  exit 1
fi


# Create session if missing
if ! tmux has-session -t "$session" 2>/dev/null; then
  tmux new-session -ds "$session" -c "$dir"
fi

# Switch or attach depending on whether we’re already in tmux
if [[ -n "${TMUX:-}" ]]; then
  tmux switch-client -t "$session"
else
  tmux attach -t "$session"
fi
