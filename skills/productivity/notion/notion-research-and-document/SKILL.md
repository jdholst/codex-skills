---
name: notion-research-and-document
description: Research a web resource, product, paper, repository, competitor, or technical topic and publish the findings as a concise, source-linked Notion report. Use when the user asks to research, investigate, compare, evaluate, summarize, or document external sources into a Notion page, especially when they mention a Notion workspace, page, project, research notes area, or report destination.
---

# Notion Research and Document

## Overview

Research external sources and turn the findings into a concise Notion report with direct links, clear synthesis, and concrete recommended next actions. Use the user's requested Notion destination when provided; otherwise find or confirm the most appropriate parent page before writing.

## Workflow

1. Clarify only what is necessary.
   - If the user provides a URL, product name, repository, paper, person, company, or topic, proceed.
   - If the user names a Notion destination, use it as the target parent.
   - If no destination is given, search Notion for a likely project, research notes page, or workspace area. Ask a short question only if multiple plausible parent pages remain.
   - If they ask for "resources like X", do a shallow top-result scouting pass unless they explicitly ask for deep research.

2. Gather Notion context.
   - Search for the requested parent page and fetch it before creating content.
   - Check nearby or existing research pages when duplication is likely.
   - Use the fetched parent page ID or connector-provided target when creating the new report.
   - If the Notion connector exposes workspace-specific instructions or markdown rules, follow them; otherwise use conservative Notion-friendly markdown.

3. Research the topic.
   - Browse when current, precise, or source-attributed facts are needed.
   - Prefer primary sources: official websites, documentation, GitHub repositories, papers, product pages, filings, platform docs, and reputable original announcements.
   - Use secondary sources to triangulate market context, adoption, critique, or history when primary sources are incomplete.
   - For shallow scans, stay near top results and capture the basic description, source type, link, and why it matters.
   - For deeper reports, inspect enough source material to answer the user's real question, but keep the Notion page editable.

4. Decide whether to use subagents.
   - Use subagents only when they are available and authorized, and when the research is broad, comparative, or naturally separable across domains.
   - Good splits: competitor scan, technical architecture scan, repo/source-code scan, paper/research scan, market scan, policy/regulatory scan, and product-positioning scan.
   - Keep subagent prompts bounded and ask for name, URL, brief description, source type, useful facts, caveats, and relevance to the user's stated goal.
   - Do not let subagents write to Notion. The main agent owns the final synthesis and Notion write.

5. Create the Notion page.
   - Parent: the user-requested or verified Notion destination.
   - Title format: `<Research Type>: <Topic> - YYYY-MM-DD`, unless the user gives a specific title.
   - Use a short icon when helpful.
   - Include direct links for every resource, product, repository, paper, article, or documentation page used.
   - End with `## Recommended Actions Todo List` unless the user asks for a different ending.
   - Fetch the created page afterward to verify it saved under the correct parent and the markdown rendered acceptably.

## Page Shape

Adapt to the research task, but default to:

```markdown
## Scope

What was researched, why, and how deep the pass was.

## Executive Summary

Short synthesis of the most useful findings.

## Findings

Bulleted or sectioned findings with source links.

## Implications

What this suggests for the user's product, project, strategy, architecture, workflow, or decision.

## Open Questions

Questions that need follow-up, validation, or owner input.

## Sources

Direct links used.

## Recommended Actions Todo List

- [ ] Concrete next action.
- [ ] Concrete next action.
```

## Content Rules

- Keep reports useful but not bloated; Notion pages should be easy to edit after publishing.
- Separate observed facts from inference. Use phrases like "This suggests..." for interpretation.
- Prioritize the user's decision or project relevance over generic recap.
- Include a classification when useful: direct competitor, adjacent reference, infrastructure reference, operational reference, market signal, or long-term research signal.
- Include dates for time-sensitive facts and avoid implying old facts are current without verification.
- If a source is weak, promotional, stale, or incomplete, say so instead of overstating it.
- If Notion link formatting behaves oddly, update the page and fetch again before finishing.
- Finish by giving the user the Notion page link, the parent location, and a one- or two-sentence summary of what was captured.
