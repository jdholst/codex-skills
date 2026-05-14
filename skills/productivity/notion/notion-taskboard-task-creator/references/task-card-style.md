# Generic Notion Task Card Style

Use this when a target board has sparse examples or no established body convention. If the board has rich examples, follow the live board style instead.

## Body Shape

```markdown
# Context

Why this task exists and what problem it solves.

# Acceptance Criteria

- Observable outcome.
- Observable outcome.

# Out Of Scope

- Work that should not be included.

# Suggested Approach

- Practical implementation guidance when helpful.

# QA Guide

## Automated Checks
- [ ] Run `...`.
- [ ] Confirm all tests pass.

## Manual QA
- [ ] Exercise the primary flow.
- [ ] Confirm the expected result.

## Regression Checks
- [ ] Confirm existing behavior still works.
- [ ] Confirm no new console/runtime errors appear.

## Known Caveats
- None known.
```

## Property Defaults

- Status: `Not Started` unless the board convention differs.
- Dependencies: `None` when no dependency is known.
- Priority: choose the lowest reasonable priority if the user does not specify.
- Type: use the closest existing option; do not create a new option silently.

## Writing Rules

- Prefer observable behavior over internal implementation detail.
- Keep acceptance criteria concrete enough for QA.
- Include scope boundaries to prevent accidental expansion.
- Do not claim tests or checks passed unless they were actually run.
