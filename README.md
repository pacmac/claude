# Claude Code Toolkit

A collection of custom skills and scripts for [Claude Code](https://claude.com/claude-code) — Anthropic's CLI for Claude. These extend Claude Code with opinionated workflows for safer, more disciplined AI-assisted development.

---

## Setup

### Scripts

Add the scripts to your system PATH so they can be called from anywhere:

```bash
# Symlink or add to PATH
ln -s /path/to/this/repo/cr /usr/local/bin/cr

# Or add the repo to your PATH
export PATH="/path/to/this/repo:$PATH"
```

### Skills

Skills are loaded by Claude Code from your project's `CLAUDE.md` or global settings. Point Claude Code at the `skills/` directory to make them available as slash commands.

---

## Skills

### `/codebox` — Clean Copy-Paste Output

Outputs text in a plain, unformatted code block — no syntax highlighting, no markdown, no explanations. Just the content, ready to copy and paste.

**Usage:**
```
/codebox <prompt>
```

**Example:**
```
/codebox list all environment variables used in this project
```

---

### `/investigate` — Read-Only Bug Investigation

A disciplined, hands-off investigation mode. Claude reads code, traces logic, checks the browser, and reports findings — but **never modifies any files**. Think of it as a detective, not a surgeon.

**Usage:**
```
/investigate <description of the issue>
```

**Output:** A structured report with symptom, code path, root cause, proposed fix, and risk assessment.

**Why this exists:** Prevents Claude from "just quickly fixing" something before fully understanding the problem. Forces thorough analysis before any code changes happen.

---

### `/no-guessing` — Two Strikes and You Plan

Activates a strict 2-attempt limit on fixing any problem. If both attempts fail, Claude must **stop**, switch to read-only investigation, and present a diagnostic report for your approval before trying again.

**Usage:**
```
/no-guessing
```

This activates the protocol for the remainder of the current task. It prevents guess-fix-guess spirals and forces Claude to understand the problem before burning more attempts.

**Rules:**
- Attempt 1: Best fix based on current understanding
- Attempt 2: Must explain what went wrong first, then try once more
- After 2 failures: Full stop. Read-only investigation. Diagnostic report. Wait for approval.

---

### `/session-id` — Name Your Sessions

Assign a human-readable name to the current Claude Code session so you can resume it later using the `cr` script.

**Usage:**
```
/session-id myfeature       # Name the current session "myfeature"
/session-id                  # Show the current session's name and UUID
```

---

### `/undo` — Revert Recent Changes

Undo Claude's most recent file changes using its memory of what it modified — no git commands involved. Useful when Claude makes changes you don't want but you haven't committed yet.

**Aliases:** `/revert`

**Usage:**
```
/undo                        # Undo the most recent batch of changes
/undo <specific change>      # Undo only a specific change
```

---

## Scripts

### `cr` — Session Naming and Resuming

A bash script for naming, listing, and resuming Claude Code sessions by human-readable names instead of UUIDs.

**Usage:**
```bash
cr                           # List all named sessions
cr <name>                    # Resume a session by name
cr <name> -f                 # Fork from a named session
cr -s <name>                 # Save/name the current session
cr -s <name> /path/to/proj   # Save with explicit project path
cr -w                        # Show current session UUID and name
```

**Requirements:** Python 3 (uses it internally for JSON handling)

Session names are stored in `~/.claude/session-names.json`.

---

## Philosophy

These tools enforce a few key principles:

- **Understand before changing** — read the code, trace the logic, identify the root cause before touching anything
- **Limit guessing** — two attempts max, then stop and think properly
- **Human stays in control** — investigate and report, don't silently fix
- **Keep it simple** — small, focused tools that do one thing well

---

## License

MIT
