# /session-id

Name or rename the current Claude Code session for easy resuming later.

If the argument is `help`, respond with: "**/session-id <name>** — Assign a human-readable name to this session. Resume later with `cr <name>` from your terminal." and STOP.

## Procedure

- If `$ARGUMENTS` is empty: run `cr -w` and display the result.
- If `$ARGUMENTS` is a name: run `cr -s <name>` and display the result.

That's it. The `cr` script at `/usr/share/dis/bash/cr` handles all logic.
