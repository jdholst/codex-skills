#!/usr/bin/env python3
"""Generate GitHub Markdown badges for Notion task links.

Input format, one task per line:
  Task title|https://www.notion.so/...
"""

from __future__ import annotations

import argparse
import sys
from dataclasses import dataclass
from urllib.parse import quote


@dataclass(frozen=True)
class TaskLink:
    title: str
    url: str


def parse_task_line(line: str) -> TaskLink:
    if "|" not in line:
        raise ValueError(f"Expected 'title|url' input, got: {line!r}")

    title, url = (part.strip() for part in line.split("|", 1))
    if not title:
        raise ValueError("Task title cannot be empty.")
    if not url:
        raise ValueError(f"URL cannot be empty for task: {title!r}")

    return TaskLink(title=title, url=url)


def make_badge(task: TaskLink, label: str, color: str, style: str) -> str:
    encoded_label = quote(label, safe="")
    encoded_message = quote(task.title, safe="")
    alt_text = task.title.replace("[", "(").replace("]", ")")
    badge_url = (
        "https://img.shields.io/static/v1"
        f"?label={encoded_label}"
        f"&message={encoded_message}"
        f"&color={quote(color, safe='')}"
        f"&style={quote(style, safe='')}"
        "&logo=notion"
        "&logoColor=white"
    )
    return f"- [![{alt_text}]({badge_url})]({task.url})"


def read_tasks(stdin: str) -> list[TaskLink]:
    tasks: list[TaskLink] = []
    for line_number, raw_line in enumerate(stdin.splitlines(), start=1):
        line = raw_line.strip()
        if not line or line.startswith("#"):
            continue
        try:
            tasks.append(parse_task_line(line))
        except ValueError as error:
            raise SystemExit(f"Line {line_number}: {error}") from error
    return tasks


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Generate Markdown Notion task badges from title|url lines."
    )
    parser.add_argument("--label", default="Notion Task")
    parser.add_argument("--color", default="000000")
    parser.add_argument("--style", default="for-the-badge")
    parser.add_argument("--heading", default="Notion Tasks")
    args = parser.parse_args()

    tasks = read_tasks(sys.stdin.read())
    if not tasks:
        raise SystemExit("No task links provided on stdin.")

    print(f"## {args.heading}")
    print()
    for task in tasks:
        print(make_badge(task, label=args.label, color=args.color, style=args.style))

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
