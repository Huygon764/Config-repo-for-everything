# ~/.claude/skills/commit/SKILL.md

---
name: commit
description: Generate conventional commit message from staged changes
user-invocable: true
---

## Steps

1. Run `git diff --staged`
2. If no staged changes, inform user and stop
3. Analyze what changed (files, logic, purpose)
4. Generate commit message:
   - Format: `<type>: <description>`
   - Types: feat, fix, docs, style, refactor, test, chore
   - Description: max 72 chars, imperative mood (add, fix, update - not added, fixed)
   - Language: English only
5. Show the proposed message and ask: "Commit với message này không?"
6. If approved, run `git commit -m "<message>"`

