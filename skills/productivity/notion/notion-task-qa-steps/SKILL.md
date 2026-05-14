---
name: notion-task-qa-steps
description: Create or update a manual QA guide on a Notion task card after a code change, implementation plan, or acceptance criteria. Use when the user asks to add QA steps, manual testing steps, verification guidance, tester instructions, or acceptance-test notes to a Notion task, ticket, taskboard card, implementation card, or proof-of-concept task.
---

# Notion Task QA Steps

## Overview

Add practical, human-runnable QA guidance to an existing Notion task card. Keep the section concise, specific to the implemented change, and useful for someone manually verifying the work without needing the full development context.

## Workflow

1. Locate the task card.
   - Prefer a provided URL or exact title.
   - If only a title is provided, search Notion and fetch the matching task before updating.
   - Fetch the page content before editing so existing sections and child blocks are preserved.

2. Ground the QA steps in evidence.
   - Inspect the implementation diff, tests, plan, or task content when available.
   - Capture concrete commands already run or expected, such as `npm test`, `npm run lint`, `npm run build`, or focused test commands.
   - Identify the main user-visible flow and the highest-risk regression points.

3. Append or replace a `QA Guide` section near the bottom of the task.
   - If a QA section already exists, update it instead of duplicating it.
   - Use clear headings and checklists.
   - Include setup, automated checks, manual steps, expected results, and known caveats.

4. Verify the Notion update.
   - Re-fetch or otherwise confirm the task page contains the new QA section.
   - Report the task title and what was added.

## QA Section Shape

Use this structure unless the task clearly needs something smaller:

```markdown
## QA Guide

### Automated Checks
- [ ] Run `...`
- [ ] Confirm all tests pass.

### Manual QA
- [ ] Start the app with `...`.
- [ ] Open `...`.
- [ ] Exercise the primary flow.
- [ ] Confirm the expected result.

### Regression Checks
- [ ] Confirm the existing flow still works.
- [ ] Confirm no new console/runtime errors appear.

### Known Caveats
- Note anything the tester should not treat as a failure, or write `None known`.
```

## Writing Rules

- Write for a human tester, not the implementer.
- Prefer observable behavior over internal implementation details.
- Include exact routes, commands, buttons, and expected messages when known.
- Keep checklists short enough to run in one QA pass.
- Do not claim checks passed unless they were actually run or confirmed.
- Do not add product scope that was explicitly out of scope for the task.
