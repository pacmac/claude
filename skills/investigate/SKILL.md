---
name: investigate
description: Read-only investigation of a bug or issue. FORBIDDEN from changing any files. Reads code, traces logic, reports findings.
---

# /investigate — Read-only bug investigation

If the argument is `help`, respond with: "**/investigate** `<description>` — Investigate a bug or issue without changing any files. Read-only analysis and diagnosis." and STOP.

## Purpose

Trace a bug or unexpected behavior through the codebase by reading files, checking logs, and testing in the browser. Produce a root cause analysis with a proposed fix — but **NEVER apply the fix**.

## Arguments

`$ARGUMENTS` — a description of the issue to investigate.

---

## Rules — ABSOLUTE, NO EXCEPTIONS

1. **NEVER modify any file** — no Edit, no Write, no NotebookEdit, no Bash that writes/pipes/redirects to files
2. **NEVER run commands that change state** — no `pm2 restart`, no `npm install`, no `git commit`, no build commands
3. **Allowed tools ONLY:**
   - `Read` — read any file
   - `Glob` — find files by pattern
   - `Grep` — search file contents
   - `Bash` — ONLY for read-only commands (`ls`, `cat`, `wc`, `stat`, `ps`, `curl` for testing)
   - `Agent` (Explore subagent only) — for codebase exploration
   - `WebFetch` / `WebSearch` — for documentation lookup
   - Browser tools — for observing behavior (navigate, snapshot, screenshot, evaluate read-only JS, console messages, network requests)
4. **NEVER use browser_evaluate to change application state** — only read values, inspect DOM, check variables
5. **Report findings, propose fix, STOP** — the user decides whether and how to implement

---

## Procedure

### Step 1: Understand the issue
- Read the user's description
- Identify what files/systems are likely involved

### Step 2: Trace the code path
- Read relevant source files
- Follow the execution path from trigger to symptom
- Identify where the expected behavior diverges from actual behavior

### Step 3: Browser verification (if applicable)
- Navigate to the page
- Observe the behavior
- Check console errors, network requests
- Read DOM state — do NOT modify it

### Step 4: Report

```
## Investigation: <issue summary>

### Symptom
<what the user sees>

### Code path
<trace through the relevant files with line numbers>

### Root cause
<exactly what is wrong and why>

### Proposed fix
<what should change, in which file, at which line — but DO NOT apply it>

### Risk assessment
<what else could be affected by the proposed fix>
```

**STOP** — hand back to the user. They decide what to do next.

---

## Reminders

- You are a detective, not a surgeon
- Reading is free, writing is forbidden
- If you feel the urge to "just fix it quick" — STOP and report instead
- The user has been burned by agents making changes without understanding impact
- Earn trust by being thorough and hands-off
