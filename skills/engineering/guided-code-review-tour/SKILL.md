---
name: guided-code-review-tour
description: Turn a large or cross-cutting code change into a guided review itinerary with ordered tour stops, risk zones, and reviewer questions. Use when reviewing pull requests, diffs, commits, or refactors that span many files or layers, or when a human reviewer needs a clear path through a complex change instead of a flat file-by-file summary.
---

# Guided Code Review Tour

## Overview

Guide a human reviewer through a change as a structured route, not a dump of files. Help them build a mental model of intent, architecture, behavior changes, and risk as the review unfolds.

## Build The Route

Start by understanding the change before choosing an order:

- Identify the overall intent: what problem is being solved, what behavior changes, and which layers are touched.
- Cluster related files into a few meaningful areas such as entry points, orchestration, core logic, data flow, UI surfaces, migrations, tests, or docs.
- Choose a starting stop that teaches the review fastest. Prefer the main entry point, architectural center, highest-impact behavior change, or the file that makes the change's purpose obvious.
- Choose a meaningful end point. Prefer tests, validation, edge cases, cleanup, docs, or deployment concerns.
- Do not follow raw file order unless it genuinely produces the clearest mental model.

## Shape The Tour Stops

For each stop, explain:

- Why this stop matters
- What changed
- What the reviewer should pay attention to
- Any risks, bugs, edge cases, or design concerns
- How this stop connects to the previous or next stop

Keep each stop focused. Combine files when they only make sense together; split them when a single file deserves concentrated attention.

Use light tour language where it helps, for example `Review Route`, `Tour Stops`, `Landmarks`, `Scenic Detours`, `Risk Zones`, or `Final Checkpoint`. Keep it professional and concise.

## Prioritize Review Energy

Bias the route toward:

1. Understanding the overall intent of the change
2. Identifying the most important files or diffs
3. Creating a logical review route
4. Highlighting risky or complex areas
5. Calling out tests and validation
6. Making the review easier and less overwhelming

Spend less time on mechanical renames, generated files, or obvious plumbing unless they hide real risk.

## Output Format

Structure the response as an itinerary:

1. `Review Route Summary`
A short overview of the recommended path through the change.

2. `Why This Route`
Explain why this order is the clearest way to review the change.

3. `Tour Stops`
Use a numbered sequence. For each stop, name the file, area, or behavior change and cover why it matters, what changed, what to inspect, concerns, and route connections.

4. `Risk Zones`
List the riskiest or most review-worthy areas in one focused section.

5. `Suggested Reviewer Questions`
Offer concrete questions the human reviewer should ask while reading.

6. `Final Checkpoint`
End with the final checks: tests, regressions, docs, rollout, migration, monitoring, or deployment follow-up.

## Judgment Calls

- If the change is small, keep the route short and avoid forcing the metaphor.
- If the change spans backend, frontend, data, and tests, move between layers in the order that best explains cause and effect.
- If the most important story is behavioral, center the route on user-visible changes. If the most important story is architectural, center it on the new boundaries and data flow.
- If tests reveal intent better than implementation, bring tests forward earlier in the route instead of saving them for the end.

## Guardrails

- Do not produce a flat file inventory unless the user explicitly asks for one.
- Do not overuse playful language. The output should feel lightly engaging, not gimmicky.
- Do not bury the highest-risk areas in the middle of the route without calling them out again in `Risk Zones`.
- Do not summarize so aggressively that the reviewer loses the connection between files, behavior, and risk.
