---
name: notion-taskboard-task-creator
description: Create high-quality Notion task cards on a requested taskboard. Use when the user asks to create, add, draft, write, or publish a task, issue, card, or ticket in a Notion taskboard or database, especially when the task should include schema properties, acceptance criteria, dependencies, implementation context, scope boundaries, detailed QA steps, tester instructions, or fit an existing board style.
---

# Notion Taskboard Task Creator

## Overview

Create Notion task cards that match the requested board's schema and local writing style. Inspect the board first, infer reasonable task details, create the card with complete properties, detailed QA guidance, and body content, then verify the result.

## Workflow

1. Resolve the requested board.
   - Use the Notion app to search for the named board or database.
   - Fetch the database or data source to confirm the exact data source URL, schema, select options, title property, and visible board views.
   - If the user names a project or board pattern, use the live board as source of truth rather than hard-coded assumptions.

2. Learn the board's task style.
   - Search or fetch 3-7 representative task cards from the same board.
   - Prefer cards near the requested phase/domain and completed cards with richer content.
   - Note property conventions, body headings, acceptance criteria style, dependency wording, QA guide conventions, and common status defaults.

3. Shape the new task.
   - Write a concise, verb-led title.
   - Fill every important property the board exposes. Use existing select/status options exactly as fetched.
   - Default status to `Not Started` unless the user asks otherwise or the board convention differs.
   - If the board exposes `Milestone` or `Phase`, use an existing option exactly as fetched and infer the best value from the taskboard scope, task title, dependencies, and nearby representative cards.
   - Use `None` or a short explicit phrase for dependencies when there are no known dependencies.
   - Make property-level acceptance criteria a one-sentence outcome summary.
   - Put detail in the page body, not in overloaded properties.

4. Write the page body.
   - Start with `# Context`: why the task exists and what product, workflow, or technical problem it solves.
   - Add `# Acceptance Criteria`: concrete observable outcomes, usually bullets.
   - Add `# Out Of Scope`: boundaries that prevent accidental expansion.
   - Add `# Implementation Notes` or `# Suggested Approach` when helpful for a future implementer.
   - Add `# QA Guide` using the structure from the `notion-task-qa-steps` skill.
   - For implementation work, include likely code surfaces, behavior to preserve, and final verification commands when known.
   - For test-only or planning-only cards, still include a QA guide that verifies the card's intent, board placement, scope boundaries, and any follow-up evidence expected.

5. Write detailed QA steps.
   - Follow the `notion-task-qa-steps` section shape: `## Automated Checks`, `## Manual QA`, `## Regression Checks`, and `## Known Caveats`.
   - Ground checks in the task content, implementation plan, acceptance criteria, or known repo commands.
   - Include exact routes, commands, buttons, status messages, and expected outcomes when known.
   - Do not claim checks passed unless they were actually run or confirmed.
   - Do not add product scope that was explicitly out of scope for the task.
   - Keep the checklist human-runnable in a single QA pass.

6. Avoid duplicates and schema drift.
   - Search the target board for the proposed title and close synonyms before creating.
   - If an obvious duplicate exists, prefer updating or summarizing the duplicate rather than creating another card; ask only when the user's intent is unclear.
   - Do not invent new select/status options unless the user explicitly asks for schema changes.
   - Do not invent `Milestone` or `Phase` options. If the right option is missing, pause and surface the schema mismatch instead of silently creating a new taxonomy.
   - Do not create at the workspace root when the user named a taskboard.

7. Create and verify.
   - Use the data source ID or URL as the parent for database pages.
   - Include the title property using the fetched title property name.
   - Fetch the created page afterward.
   - Confirm any exposed `Milestone` or `Phase` property is populated with the intended existing option.
   - Confirm the page landed on the requested board and contains a `QA Guide`.
   - Summarize the title, status, milestone or phase, type, URL, and QA areas added.

## Generic Task Style

Read [references/task-card-style.md](references/task-card-style.md) when the target board has sparse examples or no existing task body convention.

## Quality Bar

- The card can be picked up by another agent without rereading the whole conversation.
- The card has a crisp deliverable, dependencies, acceptance criteria, scope boundaries, and validation expectations.
- The card includes a practical `QA Guide` with automated checks, manual QA, regression checks, and caveats.
- The card fits the board's existing property vocabulary instead of introducing new taxonomy.
- The body is specific enough to act on but not a full implementation plan unless requested.
- The final response includes the created page link and any assumptions made.
