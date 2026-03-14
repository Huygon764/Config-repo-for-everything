# ~/.claude/skills/review-pr/SKILL.md

---
name: review-pr
description: Review staged changes with detailed feedback
user-invocable: true
---

## Steps

1. Run `git diff --staged`
2. If no staged changes, inform user and stop
3. Identify file types to apply correct checklist

## General Checklist (all code)
- Logic errors or bugs
- Edge cases not handled
- Error handling missing or incorrect
- Code duplication
- Naming unclear or inconsistent
- Performance concerns (N+1, unnecessary loops, memory leaks)
- Security issues (injection, auth bypass, data exposure)

## Smart Contract Checklist (Solidity, Rust/ICP, Noir)
- Reentrancy vulnerability
- Integer overflow/underflow
- Access control missing or incorrect
- Unchecked external calls
- Front-running possibility
- Gas optimization issues
- State changes after external calls
- Missing events for important actions

## Output Format

For each issue:

[Severity: Critical/Major/Minor] File: path/to/file

Dòng: số dòng (nếu có)

Vấn đề: mô tả chi tiết vấn đề

Tại sao quan trọng: giải thích impact

Đề xuất fix: code suggestion hoặc hướng dẫn

---

## Summary

Kết thúc với bảng tổng kết (Critical: X, Major: Y, Minor: Z) và 1-2 câu đánh giá tổng quan.

If no issues: "Code looks good. Không tìm thấy vấn đề nào."

