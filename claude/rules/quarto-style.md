---
paths: "**/*.qmd"
---

# Quarto Style

Additional rules for Quarto documents (`.qmd` files).

## Callouts

Use callout blocks for standalone remarks:

```markdown
::: {.callout-note}
Content here.
:::
```

| Callout | Use For |
|---------|---------|
| `callout-note` | Supplementary information, FYI, helpful context |
| `callout-tip` | Best practices, recommendations, "pro tips" |
| `callout-warning` | Potential pitfalls, things that could cause problems |
| `callout-important` | Critical information the reader must not skip |
| `callout-caution` | Proceed carefully, irreversible actions, data loss risks |

Do not use inline patterns like `[NOTE:...]` for standalone remarks.

## Cross-References

Use Quarto cross-references instead of prose like "see Section X".

Adding labels:

- Sections: `## Section Title {#sec-my-label}`
- Tables: `{#tbl-my-label}` in the caption line
- Figures: `{#fig-my-label}` in the figure options
- Equations: `$$ E = mc^2 $$ {#eq-label}`

Referencing: Use `@sec-label`, `@tbl-label`, `@fig-label`, `@eq-label`.

