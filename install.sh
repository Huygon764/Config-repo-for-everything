#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE="symlink"

usage() {
  cat <<EOF
Usage: $(basename "$0") [--copy]

Install Cursor and Claude Code config from this repo into your home directory.

  --copy     Copy files instead of creating symlinks (default: symlink)

Targets:
  cursor/rules/core.mdc  ->  ~/.cursor/rules/core.mdc
  cursor/skills/*        ->  ~/.cursor/skills/*
  claude/CLAUDE.md       ->  ~/.claude/CLAUDE.md
  claude/skills/*        ->  ~/.claude/skills/*
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --copy)
      MODE="copy"
      shift
      ;;
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

backup_if_exists() {
  local dest="$1"
  if [[ -e "$dest" || -L "$dest" ]]; then
    local backup="${dest}.backup.$(date +%Y%m%d%H%M%S)"
    mv "$dest" "$backup"
    echo "  backed up existing file to $backup"
  fi
}

install_file() {
  local src="$1"
  local dest="$2"

  if [[ ! -e "$src" ]]; then
    echo "  skip: missing source $src" >&2
    return 0
  fi

  mkdir -p "$(dirname "$dest")"

  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    echo "  ok (already linked): $dest"
    return 0
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    if [[ "$MODE" == "symlink" && -f "$dest" && ! -L "$dest" ]]; then
      if cmp -s "$src" "$dest"; then
        echo "  ok (identical): $dest"
        return 0
      fi
    fi
    backup_if_exists "$dest"
  fi

  if [[ "$MODE" == "copy" ]]; then
    cp "$src" "$dest"
    echo "  copied: $dest"
  else
    ln -s "$src" "$dest"
    echo "  linked: $dest -> $src"
  fi
}

install_dir_skills() {
  local src_dir="$1"
  local dest_dir="$2"

  if [[ ! -d "$src_dir" ]]; then
    echo "  skip: missing directory $src_dir" >&2
    return 0
  fi

  mkdir -p "$dest_dir"

  local skill_path
  for skill_path in "$src_dir"/*/; do
    [[ -d "$skill_path" ]] || continue
    local name
    name="$(basename "$skill_path")"
    install_file "${skill_path}SKILL.md" "${dest_dir}/${name}/SKILL.md"
  done
}

echo "Installing from: $REPO_ROOT"
echo "Mode: $MODE"
echo

echo "Cursor rules"
install_file "$REPO_ROOT/cursor/rules/core.mdc" "$HOME/.cursor/rules/core.mdc"
echo

echo "Cursor skills"
install_dir_skills "$REPO_ROOT/cursor/skills" "$HOME/.cursor/skills"
echo

echo "Claude Code"
install_file "$REPO_ROOT/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
echo

echo "Claude skills"
install_dir_skills "$REPO_ROOT/claude/skills" "$HOME/.claude/skills"
echo

echo "Done. Restart Cursor / Claude Code (or start a new session) to pick up changes."
