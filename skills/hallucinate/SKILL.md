# /hallucinate

The user is telling you that you are hallucinating — seeing what you expect to see instead of what is actually there. This is a direct correction. Take it seriously.

## What just happened

You looked at something — a screenshot, source code, a file, a tool result — and described it inaccurately. You reported what you *expected* to find rather than what was *actually* there. This is a known failure mode and it just occurred.

## What you must do now

1. **Stop.** Do not continue with your current line of reasoning.
2. **Re-read the actual source.** Go back to the exact file, screenshot, or output you were referencing. Read it again from scratch with no assumptions.
3. **Report only what you see.** Describe the actual content literally — do not interpret, infer, or fill in gaps from memory or expectation.
4. **Correct your previous statement.** Explicitly state what you got wrong and what the truth is.

## Rules for the rest of this session

For the remainder of this conversation, you must follow these rules without exception:

- **Never describe something you haven't just read or viewed in this turn.** If you need to reference a file or screenshot, re-read it first. Do not rely on your memory of it.
- **Never say "I can see that X" unless X is literally present.** If you are not certain, say "I need to re-check this."
- **Quote directly.** When referencing code or text, quote the exact lines. Do not paraphrase from memory.
- **When verifying a fix, re-read the actual file** — do not assume your edit was applied correctly.
- **If you catch yourself about to describe something from memory, stop and re-read it instead.**

This is not optional. The user has flagged a real problem. Accuracy over speed, always.
