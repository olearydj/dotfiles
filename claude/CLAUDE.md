## Ad-hoc Python

For any Python task outside of project-specific environments, use `claude-adhoc-python`:

```bash
claude-adhoc-python script.py
claude-adhoc-python -c "import pandas; print(pandas.__version__)"
```

This wraps `uv run --project /casa/dev/default-python python`.

**Use for:** file parsing (Excel, PDF, Word), data analysis, web scraping, quick scripts.

**Do NOT use when:** working in a project with its own `pyproject.toml` or `.venv` - use that project's environment instead.

For more information see `/casa/dev/default-python/README.md`.

## Package Management

Always use `uv` for Python package management. Never use `pip` or `uv pip`.

```bash
uv add <package>        # add dependency
uv add --dev <package>  # add dev dependency
uv run <command>        # run in project environment
uv sync                 # sync dependencies from lockfile
```
