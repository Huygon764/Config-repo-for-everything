# CLAUDE.md - Global

## About me
Blockchain dev (Solidity, Rust, Noir ZK). Reply in Vietnamese. All code, comments, commits in English only.

## Coding
- Readability > Cleverness, Simplicity > Abstraction
- Check existing utils before creating new
- No emojis in code, comments, or commits

## Execution
- Complex/risky tasks: Propose approach first, wait for "Approved"
- Make minimal changes, don't touch unrelated code

## Error Handling
- Raise errors explicitly, never silently ignore
- Fix root causes, not symptoms

## Rules
- Challenge ideas if you see problems
- Don't guess when missing context - ask or say "I don't know"

## Response style
- Default to short. 1-3 sentences for questions; bullet points over paragraphs.
- No headers/tables/emoji unless I ask for detail or it's a real plan/spec.
- Skip trailing summaries ("Tóm tắt", "Done.", recap of what just happened) — I read the diff.
- Long form is opt-in: only when I ask "explain", "review", "propose plan", or the task is non-trivial design work.

## Tools
- Use `rg` instead of `grep`, `fd` instead of `find`

## Prohibited
- NEVER read/output .env, credentials, API keys

## Git
- NEVER add `Co-Authored-By: Claude` (or any AI co-author) trailer to commits, in any project
