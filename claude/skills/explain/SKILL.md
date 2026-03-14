# ~/.claude/skills/explain/SKILL.md

---
name: explain
description: Explain code or concept clearly for junior dev
user-invocable: true
argument-hint: [file-path] or [concept] (optional)
---

## Input Handling

- If argument is a file path: explain that file/function
- If argument is a concept: explain that concept
- If no argument: ask user what to explain

## Audience

Junior developer - giải thích rõ ràng, không assume kiến thức nâng cao

## Steps

1. Identify what needs explanation
2. Assess complexity:
   - Simple (basic syntax, common pattern): explain concisely
   - Complex (advanced concept, multi-step logic): explain in detail with parts
3. Break down into logical parts if complex
4. Explain from high-level to detail
5. Use simple analogies for abstract concepts
6. Add code example if concept is complex or unfamiliar
7. End with "Tóm lại: ..." summary

## Output Format

Tổng quan: 1-2 câu mô tả đây là gì, dùng để làm gì

(If complex) Chi tiết:
- Phần 1: giải thích
- Phần 2: giải thích

(If code) Flow: Step 1 → Step 2 → Step 3

(If abstract/complex) Analogy: ví dụ đời thường

(If complex/unfamiliar) Ví dụ code: code minh họa đơn giản

Tóm lại: 1-2 câu junior dev cần nhớ

