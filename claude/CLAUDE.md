## Ad-hoc Python

For any Python task outside of project-specific environments, use the venv python directly:

```bash
/casa/dev/default-python/.venv/bin/python
```

**Use for:** file parsing (Excel, PDF, Word), data analysis, web scraping, quick scripts.

**Do NOT use when:** working in a project with its own `pyproject.toml` or `.venv` - use that project's environment instead.

**Sandbox limitation:** Claude Code cannot run `uv` commands due to a sandbox conflict with `.git` marker files in the uv cache ([anthropics/claude-code#22620](https://github.com/anthropics/claude-code/issues/22620)). If a package is missing, ask the user to run `uv add <package> --project /casa/dev/default-python`.

For more information see `/casa/dev/default-python/README.md`.

## Package Management

Always use `uv` for Python package management. Never use `pip` or `uv pip`.

```bash
uv add <package>        # add dependency
uv add --dev <package>  # add dev dependency
uv run <command>        # run in project environment
uv sync                 # sync dependencies from lockfile
```
