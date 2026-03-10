# /idi — Investigate, Document, Implement

A three-phase workflow that prevents jumping straight to code. You must complete each phase in order and get user approval before moving to the next.

## Phase 1: Investigate

- Read all relevant code, trace the logic, understand the current behavior
- Identify the root cause or the exact place where the new feature belongs
- Check for side effects, dependencies, and related code
- Do NOT modify any files during this phase

**Deliverable:** A short report covering:
- What you found
- Where the relevant code lives
- What the root cause is (for bugs) or where the change belongs (for features)
- Any risks or dependencies

**Wait for user approval before proceeding to Phase 2.**

## Phase 2: Document

- Write out the exact plan: what files will change, what the changes will be, and why
- List each change as a concrete step, not a vague description
- If the plan involves more than one logical change, break it into numbered steps
- Call out anything you're unsure about

**Deliverable:** A clear, specific implementation plan the user can review.

**Wait for user approval before proceeding to Phase 3.**

## Phase 3: Implement

- Execute the plan exactly as documented
- Make only the changes described in Phase 2 — nothing more
- If you discover something unexpected during implementation, stop and report it rather than improvising
- After implementation, verify the changes by re-reading the modified files

**Deliverable:** The completed changes, with a summary of what was done.

## Rules

- Never skip a phase. Never combine phases.
- Each phase ends with a deliverable and a pause for user input.
- If the user says "just do it" after Phase 1, you must still write the plan (Phase 2) before coding — but you may proceed through Phases 2 and 3 without pausing.
- If $ARGUMENTS is provided, treat it as the problem or feature description and begin Phase 1 immediately.
