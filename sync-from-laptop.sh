#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<EOF
Usage: $(basename "$0")

Copy Cursor and Claude Code config from your home directory into this repo.

Use when you edited files under ~/.cursor or ~/.claude directly (copy install)
instead of in the repo. Skips paths that already symlink into this repo.

Targets:
  ~/.cursor/rules/core.mdc  ->  cursor/rules/core.mdc
  ~/.cursor/skills/*        ->  cursor/skills/*
  ~/.claude/CLAUDE.md       ->  claude/CLAUDE.md
  ~/.claude/skills/*        ->  claude/skills/*

After sync: git diff, then commit and push from the repo.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h | --help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

resolve_path() {
  local path="$1"
  if command -v realpath >/dev/null 2>&1; then
    realpath "$path"
  else
    python3 -c "import os, sys; print(os.path.realpath(sys.argv[1]))" "$path"
  fi
}

is_in_repo() {
  local resolved="$1"
  [[ "$resolved" == "$REPO_ROOT"* ]]
}

sync_file() {
  local src="$1"
  local dest="$2"

  if [[ ! -e "$src" && ! -L "$src" ]]; then
    echo "  skip: missing $src" >&2
    return 0
  fi

  local resolved
  resolved="$(resolve_path "$src")"

  if is_in_repo "$resolved"; then
    echo "  ok (already in repo): $src"
    return 0
  fi

  if [[ -f "$dest" ]] && cmp -s "$resolved" "$dest"; then
    echo "  ok (unchanged): $dest"
    return 0
  fi

  mkdir -p "$(dirname "$dest")"
  cp "$resolved" "$dest"
  echo "  synced: $dest"
}

sync_dir_skills() {
  local home_dir="$1"
  local repo_dir="$2"

  if [[ ! -d "$home_dir" ]]; then
    echo "  skip: missing directory $home_dir" >&2
    return 0
  fi

  local skill_path
  for skill_path in "$home_dir"/*/; do
    [[ -d "$skill_path" ]] || continue
    local name
    name="$(basename "$skill_path")"
    local src="${skill_path}SKILL.md"
    if [[ -e "$src" || -L "$src" ]]; then
      sync_file "$src" "${repo_dir}/${name}/SKILL.md"
    fi
  done
}

echo "Syncing into: $REPO_ROOT"
echo

echo "Cursor rules"
sync_file "$HOME/.cursor/rules/core.mdc" "$REPO_ROOT/cursor/rules/core.mdc"
echo

echo "Cursor skills"
sync_dir_skills "$HOME/.cursor/skills" "$REPO_ROOT/cursor/skills"
echo

echo "Claude Code"
sync_file "$HOME/.claude/CLAUDE.md" "$REPO_ROOT/claude/CLAUDE.md"
echo

echo "Claude skills"
sync_dir_skills "$HOME/.claude/skills" "$REPO_ROOT/claude/skills"
echo

echo "Done. Review with: git diff"
