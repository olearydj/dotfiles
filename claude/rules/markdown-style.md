---
paths: "**/*.{md,qmd}"
---

# Markdown Style

## Quick Reference

| Format | Use For | Never Use For |
|--------|---------|---------------|
| `backticks` | Files, code, packages, enums, config keys | Company names, algorithms |
| Plain text | OpenAI, Anthropic, GPT-4o, Claude | - |
| *Italics* | Book titles, subtle emphasis | Structure, labels |

Avoid bold entirely. Instead use:

- Headings for section labels
- Backticks for code terms standing alone
- *Italics* or plain text with colons for list item labels
- For 3+ labeled items, prefer an actual bulleted list over inline labels
- *Italics* or plain text for standalone intro labels (e.g., "Why?" or *Why?*)

## Code Blocks

- Always specify a language tag
  - Use `python`, `yaml`, `json`, `bash`, `http` for actual code
  - Use `text` for ASCII diagrams, pseudo-schemas, formulas, prompts, log output
  - Never leave a code fence without a language tag

## Headings

- Never skip heading levels (h1 → h2 → h3 → h4)
- Strongly prefer only one h1 per document
- Use actual headings for section breaks, not standalone bold text

## Spacing

- Ensure there is a blank line before and after all lists, code fences, and tables
- Do not add blank lines between items within a numbered list
- Files should end with a single newline
- Do not remove '  ' (two spaces) at the end of lines where it is meant to serve as a line break instead of a paragraph break

## Formatting Details

### Backticks

Use for: filenames (`router.yaml`), code identifiers, packages (`Pydantic`), CLI commands, enum values, config keys (`temperature`).

### Plain Text

Use for: company names (OpenAI, Anthropic), algorithm names, model names (GPT-4o, Claude).

### Italics

Use sparingly, mostly for book titles and subtle emphasis (e.g., "focus on *why*, not *how*").

### Quotation Marks

Use for example terms being discussed: "Ship Date", "Customer ID".

### LaTeX

Use for non-trivial math expressions and symbols ($\tau$, $\alpha$). Use Unicode for informal notation and/or simple expressions, e.g., →, ≥, ∈.

Asterisks in formulas can be misinterpreted as italics. Prefer LaTeX or Unicode ×.

### Dashes

Use sparingly. Alternatively use semicolon or comma to combine elements of a statement or for parenthetical remarks. Do not use em dashes (—), en dashes (–), or double hyphens. Use plain hyphens everywhere: a single hyphen with spaces for parenthetical remarks (`context - termed a "vessel" - may define`), and a plain hyphen for ranges (pages 1-10) and compound words (well-known).

Exception: em dash in blockquote attribution is standard (`> — Author Name`).

When doing bulk replacement of en/em dashes, take care to preserve spacing. Replace ` – ` or ` — ` with ` - ` (space-hyphen-space) in a single operation. Do not strip trailing spaces.

