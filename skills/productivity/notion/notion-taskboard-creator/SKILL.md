---
name: notion-taskboard-creator
description: Create or recreate Notion taskboards and board views that match an existing project style. Use when the user asks to make a new taskboard, database, kanban board, phase board, milestone board, or Notion project board; clone the schema of an existing board; fix board column ordering; or create a board and then populate starter tasks.
---

# Notion Taskboard Creator

## Overview

Create a Notion taskboard that matches the requested workspace or project pattern, verify the schema and board view, and correct status ordering when the board uses a status-grouped Kanban view.

## Workflow

1. Resolve the requested parent page and nearby board pattern.
   - Use the Notion app to find the requested parent page or taskboard area.
   - If the user names an existing project, board, or page, fetch live Notion context before writing.
   - Prefer matching an existing local board style instead of inventing a new schema.

2. Fetch the source board or define the target schema.
   - If a similar board already exists, fetch its database and data source to confirm property names, select options, and visible views.
   - If there is no source board, define the smallest schema that fits the request.
   - For implementation boards, a good default schema is:
     - `Task` title
     - `Status`
     - `Milestone` or `Phase` when useful
     - `Priority`
     - `Type`
     - `Dependencies`
     - `Acceptance Criteria`

3. Create the database under the requested page.
   - Use `create_database` with the parent page ID.
   - Keep the title concise and human-readable.
   - Add a short description when it helps explain the phase, milestone, or board scope.

4. Set status order deliberately.
   - If cloning an existing board, preserve its status order exactly.
   - If creating a new implementation board without a source pattern, define status options in this order:
     - `Completed`
     - `In QA`
     - `In Progress`
     - `Not Started`
   - If a board already exists with the wrong order, correct it with `update_data_source`.
   - Do not assume a board view will sort status groups correctly if the option order is wrong.

5. Create the default board view.
   - Add a `Kanban by Status` board view grouped by `Status` when the board has a status property.
   - Show the most useful scanning properties, usually `Phase` or `Milestone`, `Type`, `Dependencies`, and `Task`.
   - Hide noisy properties from Kanban cards unless the user asks to show them; they can remain in the table/default view and task properties.
   - Keep the default table view unless the user explicitly wants it changed.

6. Verify the board, schema, and ordering.
   - Fetch the database after creation.
   - Confirm the board lives under the intended parent.
   - Confirm the data source schema matches the requested or source pattern.
   - Confirm status option order matches the source board or the chosen default.
   - Confirm the board view exists and groups by `Status`.

7. Populate starter tasks only when requested.
   - If the user also wants task cards, inspect 3-7 representative tasks from the source board before writing.
   - If `notion-taskboard-task-creator` is available, use that skill for card creation instead of re-deriving the full task-writing workflow.
   - Keep task creation separate from board creation in your reasoning so schema fixes do not get buried inside card-writing steps.

## Generic Board Pattern

Read [references/taskboard-pattern.md](references/taskboard-pattern.md) when creating a board without an existing source board to clone.

## Quality Bar

- The board lands under the requested parent page, not at workspace root.
- The schema uses exact fetched property names and select options when cloning an existing pattern.
- The status options are intentionally ordered and verified after creation.
- The Kanban view exists, groups by `Status`, and shows useful scanning properties.
- Verification happens after creation; do not assume the board is correct without fetching it back.
- If starter tasks are requested, use the board's actual schema and local writing style rather than generic task text.
