---
name: refactor
description: Propose code refactoring with clear reasoning. Use when the user asks to refactor code or improve structure.
---

## Input Handling

- If argument is a file path: analyze that file and related files
- If argument is a folder path: analyze files in that folder
- If no argument: ask user which file/folder to refactor

## Steps

1. Read the target code
2. Read related files (imports, dependencies, usages)
3. Identify refactor opportunities:
   - Code duplication across files
   - Long functions (>30 lines)
   - Deep nesting (>3 levels)
   - Unclear naming
   - Mixed responsibilities (violate Single Responsibility)
   - Hard-coded values should be constants/config
   - Missing abstraction or over-abstraction
   - Inconsistent patterns between files
4. Rank by priority (Critical/Major/Minor)
5. Propose refactor with before/after
6. Wait for approval before implementing

## Priority Levels

- Critical: Causes bugs, security issues, or blocks development
- Major: Hurts readability, maintainability significantly
- Minor: Nice to have, code style improvements

## Output Format

Files analyzed: danh sách files đã đọc

---

[Priority: Critical/Major/Minor] Vấn đề 1: tên vấn đề

Files ảnh hưởng: danh sách files

Lý do cần refactor: impact nếu không fix

Before: code hiện tại (snippet)

After: code sau refactor (snippet)

---

[Priority: ...] Vấn đề 2: ...

---

Tổng kết: X critical, Y major, Z minor

Recommend: thứ tự refactor theo priority

Approve để thực hiện? (all / chọn số vấn đề / skip)
