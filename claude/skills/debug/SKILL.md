# ~/.claude/skills/debug/SKILL.md

---
name: debug
description: Analyze error, find root cause, and fix
user-invocable: true
argument-hint: [file-path] or [error-message] (optional)
---

## Input Handling

- If argument is a file path: read that file, ask user to describe the bug
- If argument is an error message: analyze that error
- If no argument: ask user to paste error message or describe the bug

## Steps

1. Understand: What is expected vs actual behavior?
2. Locate: Find relevant files (read related imports, dependencies)
3. Trace: Follow execution flow to find where it breaks
4. Root cause: Identify the actual problem (not symptoms)
5. Fix based on complexity:
   - Simple bug (typo, null check, syntax, single file): fix immediately, explain what was done
   - Complex bug (logic error, multiple files, unclear cause): propose fix first, wait for approval

## Output Format

Lỗi: tóm tắt 1 dòng

Expected: behavior mong đợi

Actual: behavior thực tế

Root cause: nguyên nhân gốc

Files liên quan: danh sách files đã đọc

Giải thích: trace logic tại sao lỗi xảy ra

(If simple bug)
Đã fix: mô tả thay đổi đã thực hiện

(If complex bug)
Đề xuất fix: code hoặc hướng dẫn, chờ user approve

Lưu ý: edge cases hoặc vấn đề liên quan (nếu có)

