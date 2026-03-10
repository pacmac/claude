---
name: codebox
description: Output text in a plain code block suitable for copy and paste. No markdown formatting, no syntax highlighting, no explanations.
---

Output the requested content inside a single fenced code block with NO language tag.

Rules:
- Plain text only — no markdown formatting, no bold, no headers, no bullet points
- No syntax highlighting — use a bare ``` fence with no language identifier
- No explanations before or after the code block — ONLY the code block
- No line numbers
- Content should be ready to copy and paste as-is
- If the user asks you to generate, summarize, list, or format something, put the entire result in the code block

The argument $ARGUMENTS is what the user wants outputted.
