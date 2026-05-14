---
name: notion-research-documentation
description: Research across Notion and synthesize into structured documentation. Use when gathering information from multiple Notion sources to produce briefs, summaries, comparisons, comprehensive reports, research docs, or source-cited documentation.
---

# Research & Documentation

Pull relevant Notion pages, synthesize findings, and publish clear briefs or reports with citations and links to sources.

## Quick Start

1. Find sources with `Notion:notion-search` using targeted queries; confirm scope with the user when results are ambiguous.
2. Fetch pages via `Notion:notion-fetch`; note key sections and capture citations using `reference/citations.md`.
3. Choose output format using `reference/format-selection-guide.md`.
4. Draft in Notion with `Notion:notion-create-pages` using the matching template.
5. Link sources and add a references/citations section; update as new info arrives with `Notion:notion-update-page`.

## Workflow

### 0. If Notion tools are unavailable

Pause and ask the user to connect the Notion app:

1. Enable the bundled Notion app for this plugin or session.
2. Complete the Notion auth flow if Codex prompts for it.
3. Restart Codex or the current session if the tools still do not appear.

After the app is connected, finish your answer and tell the user to retry so they can continue with source gathering.

### 1. Gather sources

- Search first with targeted queries; refine queries, and ask the user to confirm if multiple results appear.
- Fetch relevant pages, skim for facts, metrics, claims, constraints, and dates.
- Track each source URL or ID for later citation; prefer direct quotes for critical facts.

### 2. Select the format

- Quick readout: quick brief.
- Single-topic dive: research summary.
- Option tradeoffs: comparison.
- Deep dive or executive-ready output: comprehensive report.
- See `reference/format-selection-guide.md` for when to pick each.

### 3. Synthesize

- Outline before writing; group findings by themes or questions.
- Note evidence with source IDs; flag gaps or contradictions.
- Keep the user's goal in view, such as decision, summary, plan, or recommendation.

### 4. Create the doc

- Pick the matching template in `reference/` and adapt it.
- Create the page with `Notion:notion-create-pages`; include title, summary, key findings, supporting evidence, and recommendations or next steps when relevant.
- Add citations inline and a references section; link back to source pages.

### 5. Finalize and hand off

- Add highlights, risks, and open questions.
- If the user needs follow-ups, create tasks or a checklist in the page; link any task database entries if applicable.
- Share a short changelog or status using `Notion:notion-update-page` when updating.

## References and Examples

- `reference/`: search tactics, format selection, templates, and citation rules.
- `examples/`: end-to-end walkthroughs for competitor analysis, technical investigation, market research, and trip planning.
