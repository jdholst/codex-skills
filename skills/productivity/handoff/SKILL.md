---
name: handoff
description: Compact the current conversation into a handoff document for another agent to pick up. Use when the user asks to hand off work, continue in a later session, summarize current state for another agent, or prepare context for the next Codex session.
---

Write a handoff document summarising the current conversation so a fresh agent can continue the work. Save it to a path produced by `mktemp -t handoff-XXXXXX.md` (read the file before you write to it).

## Inputs

- `focus`: optional freeform description of what the next session will be used for.
- If the user provides a focus, tailor the handoff around that next-session goal.
- Codex does not receive slash-command arguments in a special variable, so infer the focus from the user's request or the surrounding conversation.

Suggest the skills to be used, if any, by the next session.

Do not duplicate content already captured in other artifacts (PRDs, plans, ADRs, issues, commits, diffs). Reference them by path or URL instead.
