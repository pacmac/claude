# Claude Code Toolkit

A collection of custom skills for [Claude Code](https://claude.com/claude-code) — Anthropic's CLI for Claude. These extend Claude Code with opinionated workflows for safer, more disciplined AI-assisted development.

---

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/pacmac/claude/master/install.sh | bash
```

This installs all skills to `~/.claude/skills/` and the `cr` script to `~/.local/bin/`.

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

### `/no-argue` — Accept It and Investigate

When you tell Claude something isn't working and it pushes back with "it should work" or "it looks correct to me" — use this. It forces Claude to accept your statement as fact, activate `/hallucinate` rules (re-read everything, no describing from memory), and switch to `/investigate` mode (read-only, find the root cause, report before fixing).

**Usage:**
```
/no-argue
```

**Why this exists:** Claude has a habit of defending its own code instead of looking at what actually went wrong. This skill short-circuits the argument and redirects it to productive investigation.

---

### `/hallucinate` — Stop Seeing What Isn't There

Tells Claude to stop hallucinating — describing what it *expects* to see instead of what's *actually* there. When Claude misreads a screenshot, quotes code that doesn't exist, or describes a file from memory instead of reading it, use this to snap it back to reality.

**Usage:**
```
/hallucinate
```

Once activated, Claude must re-read every source it references, quote code literally instead of paraphrasing, and never describe something it hasn't just viewed in the current turn. Stays in effect for the rest of the session.

**Why this exists:** Claude frequently "sees" what it expects — reporting that code looks correct when it doesn't, describing UI elements that aren't there, or confirming a fix worked without actually checking. This skill forces it to stop and look again.

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

Assign a human-readable name to the current Claude Code session so you can resume it later. This skill includes the `cr` script, which handles all the session-naming logic and also lets you list and resume named sessions from the terminal.

**Inside Claude Code:**
```
/session-id myfeature       # Name the current session "myfeature"
/session-id                  # Show the current session's name and UUID
```

**From the terminal (via `cr`):**
```bash
cr                           # List all named sessions
cr <name>                    # Resume a session by name
cr <name> -f                 # Fork from a named session
cr -s <name>                 # Save/name the current session
cr -s <name> /path/to/proj   # Save with explicit project path
cr -w                        # Show current session UUID and name
```

Session names are stored in `~/.claude/session-names.json`. Requires Python 3.

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

## Philosophy

These tools enforce a few key principles:

- **Understand before changing** — read the code, trace the logic, identify the root cause before touching anything
- **Limit guessing** — two attempts max, then stop and think properly
- **Human stays in control** — investigate and report, don't silently fix
- **Keep it simple** — small, focused tools that do one thing well

---

## License

MIT
