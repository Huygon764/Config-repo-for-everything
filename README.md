# Config-repo-for-everything

Personal dotfiles for **Cursor** and **Claude Code** — global rules and agent skills, synced across machines.

## Structure

```
.
├── install.sh              # Symlink or copy config into ~
├── cursor/
│   ├── rules/
│   │   └── core.mdc        # Cursor global rules (always apply)
│   └── skills/             # Cursor agent skills
│       ├── commit/
│       ├── debug/
│       ├── explain/
│       ├── refactor/
│       └── review-pr/
└── claude/
    ├── CLAUDE.md           # Claude Code global instructions
    └── skills/             # Claude Code skills (same workflows as cursor/skills)
        ├── commit/
        ├── debug/
        ├── explain/
        ├── refactor/
        └── review-pr/
```

| Path in repo | Installs to |
|--------------|-------------|
| `cursor/rules/core.mdc` | `~/.cursor/rules/core.mdc` |
| `cursor/skills/*` | `~/.cursor/skills/*` |
| `claude/CLAUDE.md` | `~/.claude/CLAUDE.md` |
| `claude/skills/*` | `~/.claude/skills/*` |

**Note:** Cursor skills live in `~/.cursor/skills/`, not `~/.cursor/skills-cursor/` (that directory is Cursor built-in).

## Quick start (new machine)

```bash
git clone https://github.com/Huygon764/Config-repo-for-everything.git
cd Config-repo-for-everything
chmod +x install.sh
./install.sh
```

Default install uses **symlinks**, so `git pull` in this repo updates config on disk automatically.

Copy instead of symlink:

```bash
./install.sh --copy
```

Existing files are backed up as `*.backup.<timestamp>` before overwrite.

## Update an existing machine

```bash
cd Config-repo-for-everything
git pull
# Symlink install: no re-run needed
# Copy install: re-run ./install.sh --copy
```

## For AI assistants

When helping with this repo:

- This is a **config/dotfiles** repo, not application source code.
- `cursor/` and `claude/` are kept in sync conceptually; skills share the same workflows.
- `claude/CLAUDE.md` and `cursor/rules/core.mdc` are separate sources (Claude vs Cursor), not copies of each other.
- Changes here should be installed with `./install.sh` on the target machine.
- Do **not** commit secrets (`.env`, API keys, credentials).

## Not included

- Cursor built-in skills (`~/.cursor/skills-cursor/`)
- Claude plugins, MCP config, or session data
- Project-specific `.cursor/rules` or `.cursor/skills` inside other repos
