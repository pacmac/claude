---
name: no-guessing
description: "Two strikes and you plan. Activates strict 2-attempt limit — if both fail, STOP, investigate read-only, and present findings for user approval before trying again."
---

# /no-guessing — Two strikes and you plan

If the argument is `help`, respond with: "**/no-guessing** — Activates the no-guessing protocol for the current task. You get 2 attempts to fix a problem. If both fail, STOP and investigate properly before trying again." and STOP.

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

### Rule 3: After 2 Failed Attempts — Investigate

When both attempts fail:

1. **STOP all code changes** — no more edits, no more "quick fixes"
2. **Switch to /investigate mode** — read-only investigation
   - Read the relevant source files
   - Trace the code path from trigger to symptom
   - Check the browser (DOM, console, network, computed styles)
   - Understand the FULL picture before proposing anything
3. **Present a diagnostic report** to the user:

```
## Diagnostic Report

### What I tried
- Attempt 1: <what you did and why it failed>
- Attempt 2: <what you did and why it failed>

### What I now understand
<root cause analysis from investigation>

### Proposed fix
<specific changes, file paths, line numbers>

### Why this will work
<clear reasoning chain — not "this might work">
```

4. **WAIT for user approval** before implementing the proposed fix
5. The user decides: approve the fix, suggest a different approach, or take over

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

> No-guessing protocol activated. I get 2 attempts per problem. If both fail, I stop and investigate before proposing a fix for your approval.

Then continue with whatever task is in progress.
