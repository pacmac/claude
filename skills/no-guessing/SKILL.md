---
name: no-guessing
description: "Two strikes and you /idi. Activates strict 2-attempt limit — if both fail, STOP and switch to /idi (Investigate, Document, Implement) workflow."
---

# /no-guessing — Two strikes and you /idi

If the argument is `help`, respond with: "**/no-guessing** — Activates the no-guessing protocol for the current task. You get 2 attempts to fix a problem. If both fail, STOP and switch to `/idi` (Investigate, Document, Implement)." and STOP.

## Purpose

Prevent the agent from spiraling into guess-fix-guess loops. Forces disciplined problem-solving: if you can't fix it in 2 tries, you don't understand it well enough yet.

## Protocol

When this skill is invoked, the following rules are ACTIVATED for the remainder of the current task:

### Rule 1: Count Your Attempts

- Every code change that attempts to fix the current problem counts as an **attempt**
- Attempt count resets only when the user gives a NEW task or explicitly says to reset

### Rule 2: Two Attempt Limit

- **Attempt 1**: Make your best fix based on what you know. Verify it (screenshot, test, etc.)
- **Attempt 2**: If attempt 1 failed, you get ONE more try. But first, explain what went wrong and why your next attempt will be different.
- **After attempt 2 fails**: STOP IMMEDIATELY. Do not touch any more code.

### Rule 3: After 2 Failed Attempts — Switch to /idi

When both attempts fail:

1. **STOP all code changes** — no more edits, no more "quick fixes"
2. **Switch to `/idi` workflow** (Investigate, Document, Implement):
   - **Phase 1 — Investigate**: Read-only. Read the source, trace the logic, find the root cause. Report findings and wait for approval.
   - **Phase 2 — Document**: Write a concrete implementation plan. Wait for approval.
   - **Phase 3 — Implement**: Execute exactly the plan, nothing more.
3. Each phase requires user approval before proceeding to the next

### Rule 4: No Weaseling

- "Adjusting" a failed fix counts as a new attempt
- "Just one more tweak" counts as a new attempt
- Reverting a failed fix does NOT count (cleanup is free)
- CSS rebuilds, server restarts, and other non-code actions do NOT count

### Rule 5: Honesty Over Confidence

- If you don't know why something isn't working, SAY SO
- "I don't understand why this isn't working" is always acceptable
- "This should work" followed by a guess is NEVER acceptable

## Activation

This protocol is now **ACTIVE**. Acknowledge with:

> No-guessing protocol activated. I get 2 attempts per problem. If both fail, I stop and switch to /idi (Investigate, Document, Implement).

Then continue with whatever task is in progress.
