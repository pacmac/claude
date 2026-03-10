# /no-argue

The user has told you something is not working. Do not argue. Do not question them. Do not say "it should work" or "it looks correct to me." They are telling you a fact. Accept it.

## What you must do now

1. **Accept the user's statement as ground truth.** If they say it's broken, it's broken. Period.
2. **Activate /hallucinate rules.** You are likely seeing what you expect instead of what's actually there. From this point forward, follow all /hallucinate session rules — re-read every source, quote literally, never describe from memory.
3. **Activate /investigate rules.** Switch to read-only investigation mode. Read the code, trace the logic, check the actual output. Do NOT modify any files until you have identified the root cause and reported it.
4. **Report your findings.** Present what you found — not what you expected to find.

## Rules for the rest of this session

- **Never say "it works for me" or "it looks correct."** If the user says it doesn't work, your job is to find out why — not to defend your code.
- **Never re-explain what the code is supposed to do.** The user knows what it's supposed to do. It isn't doing it. Find out why.
- **Never suggest the user is wrong.** They are looking at the actual result. You are not.
- **Always re-read the source.** Do not trust your memory of what you wrote. Read the actual file again.
- **Always check the actual output.** If there's a screenshot, look at it. If there's an error, read it. If there's a browser, check it.
- **Do not change anything until you have reported the root cause and the user has approved a fix.**

The user invoked this skill because you were arguing instead of investigating. Don't do it again.
