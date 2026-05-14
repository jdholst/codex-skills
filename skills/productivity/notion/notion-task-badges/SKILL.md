---
name: notion-task-badges
description: Generate attractive GitHub Markdown badges for Notion task links. Use when the user asks for Notion task badges, PR description badges, linked badge buttons, Shields.io badges, a badge list for Notion tasks, or wants taskboard/task URLs converted into copy-ready Markdown links.
---

# Notion Task Badges

## Overview

Create GitHub-friendly Markdown badges that link to Notion task pages. Prefer Shields.io static badges with the Notion logo because they render cleanly in GitHub PR descriptions.

## Workflow

1. Gather task titles and URLs.
   - If the user provides explicit title/URL pairs, use them directly.
   - If the user names a Notion taskboard, use the Notion app to fetch/search the taskboard and collect task titles plus page URLs.
   - Preserve exact task titles unless the user asks for shorter badge labels.

2. Generate copy-ready Markdown.
   - Use `scripts/generate_badges.py` for multiple tasks or any title with punctuation, spaces, slashes, ampersands, or long text.
   - Default to a list under `## Notion Tasks` for PR descriptions.
   - Use one badge per line when there are many tasks.
   - Keep the badge link target as the Notion page URL.

3. Choose badge text.
   - Default label: `Notion Task`.
   - Default message: exact task title.
   - For very long titles, keep exact text unless the user asks for compact labels.
   - If making a single badge, a short message like `Task` or the task's noun phrase is acceptable.

4. Return the result.
   - Wrap the full output in a fenced `md` code block so the user can paste it into a PR.
   - If taskboard retrieval may be incomplete, say so briefly outside the code block.
   - Do not create or edit Notion pages unless the user asks; this skill is for badge generation.

## Badge Format

Use this Shields static badge pattern:

```md
[![TASK_TITLE](https://img.shields.io/static/v1?label=Notion%20Task&message=URL_ENCODED_TASK_TITLE&color=000000&style=for-the-badge&logo=notion&logoColor=white)](NOTION_TASK_URL)
```

Use black (`000000`) for Notion-native styling. Keep `style=for-the-badge`, `logo=notion`, and `logoColor=white`.

## Script

Use [scripts/generate_badges.py](scripts/generate_badges.py) with newline-delimited `title|url` pairs:

```bash
python3 skills/productivity/notion/notion-task-badges/scripts/generate_badges.py <<'EOF'
Define runtime adapter interface|https://www.notion.so/...
Mount runtime through adapter and iframe host|https://www.notion.so/...
EOF
```

The script prints a `## Notion Tasks` section with Markdown badge list items.
