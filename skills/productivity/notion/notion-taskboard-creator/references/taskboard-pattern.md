# Generic Notion Taskboard Pattern

Use this when the user wants a new taskboard but does not provide an existing board to clone.

## Default Schema

- `Task`: title property.
- `Status`: status or select property used for Kanban grouping.
- `Milestone`: optional select for project phases, releases, or milestones.
- `Phase`: optional select when the project uses phases separately from milestones.
- `Priority`: optional select such as `High`, `Medium`, `Low`.
- `Type`: optional select such as `Feature`, `Bug`, `Chore`, `Research`, `QA`.
- `Dependencies`: text or relation, depending on the workspace pattern.
- `Acceptance Criteria`: text summary for the expected outcome.

## Default Status Order

When no source board defines a different order, use:

1. `Completed`
2. `In QA`
3. `In Progress`
4. `Not Started`

This order makes completed work appear leftmost and new work rightmost. If the user's workspace convention differs, preserve the workspace convention instead.

## Default Views

- Keep the default table view.
- Add `Kanban by Status`, grouped by `Status`.
- Show scanning fields such as `Milestone`, `Phase`, `Type`, `Dependencies`, and `Task`.
- Hide noisy fields from cards unless they help daily scanning.

## Verification

After creation, fetch the database and confirm:

- Parent page is correct.
- Title and description are correct.
- Properties exist with the expected names.
- Status order matches the intended order.
- `Kanban by Status` exists and groups by `Status`.
