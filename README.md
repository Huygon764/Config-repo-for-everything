# Config-repo-for-everything

Personal dotfiles for **Cursor** and **Claude Code** — global rules and agent skills, synced across machines.

## Structure

```
.
├── install.sh              # Symlink or copy config into ~
├── sync-from-laptop.sh     # Copy ~/.cursor and ~/.claude back into repo
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

## Workflow

Repo lives on disk (e.g. `~/boh/Config-repo-for-everything`). Config in `~/.cursor` and `~/.claude` points at files **inside that folder** via symlinks.

**First time (new machine):**

```bash
git clone https://github.com/Huygon764/Config-repo-for-everything.git ~/boh/Config-repo-for-everything
cd ~/boh/Config-repo-for-everything
chmod +x install.sh
./install.sh
```

**Get updates (any machine already set up):**

```bash
cd ~/boh/Config-repo-for-everything   # path where you cloned
git pull
```

No second `./install.sh` needed — symlinks already point into the repo, so pulled files are what Cursor/Claude read.

**Edit config:** change files in the repo (or edit via symlinks in `~`), then commit and push from the repo:

```bash
cd ~/boh/Config-repo-for-everything
git add -A && git commit -m "your message" && git push
```

On another machine: `git pull` only.

Copy install (`./install.sh --copy`) does not auto-update — re-run `./install.sh --copy` after each pull.

If you edited config under `~/.cursor` or `~/.claude` directly (not via symlink), pull changes into the repo before commit:

```bash
./sync-from-laptop.sh
git diff
git add -A && git commit -m "your message" && git push
```

Symlink install: edits in `~` are already repo files — skip sync.

## For AI assistants

When helping with this repo:

- This is a **config/dotfiles** repo, not application source code.
- `cursor/` and `claude/` are kept in sync conceptually; skills share the same workflows.
- `claude/CLAUDE.md` and `cursor/rules/core.mdc` are separate sources (Claude vs Cursor), not copies of each other.
- Run `./install.sh` on the target machine to symlink config into `~`
- Do **not** commit secrets (`.env`, API keys, credentials).

## Not included

- Cursor built-in skills (`~/.cursor/skills-cursor/`)
- Claude plugins, MCP config, or session data
- Project-specific `.cursor/rules` or `.cursor/skills` inside other repos
