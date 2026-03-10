# /undo (alias: /revert)

Undo the most recent changes you made to files in this session.

If the argument is `help`, respond with: "**/undo** (alias: **/revert**) — Undo your most recent file changes using memory, without git commands." and STOP.

## Rules — ABSOLUTE, NO EXCEPTIONS

1. **NEVER use git commands** — no `git checkout`, `git restore`, `git reset`, `git show`, `git stash`, or any other git operation via Bash. These are blocked by permission and you will waste time retrying.

2. **Use your memory of what you changed** — you just made the changes, so you know exactly what the original content was. Read each modified file, identify YOUR changes, and use the Edit tool to restore the original content.

3. **Procedure:**
   - List the files you modified in the current task/attempt
   - For each file, read it and identify the lines you changed
   - Use Edit to restore the original content from memory
   - If you cannot remember the exact original content, tell the user honestly — do NOT guess
   - After restoring, rebuild CSS if any `.css` files were changed: `npx @tailwindcss/cli -i public/dui/css/input.css -o public/dui/css/main.css`
   - Reload the browser page to verify

4. **Do NOT touch files the user modified** — only revert YOUR changes. Check system reminders for user-modified files.

5. **Scope:** By default, undo the most recent batch of changes (since last commit or checkpoint). If the user specifies "undo X" where X is a specific change, only undo that.

6. **Verify:** After reverting, take a screenshot or confirm the state matches before your changes.
