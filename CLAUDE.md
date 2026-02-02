## Config Structure

This is the central dotfiles directory. Most configs live here with symlinks from expected locations.

### Key Symlinks

| Expected Location | Actual Location |
|-------------------|-----------------|
| `~/.claude` | `~/.config/claude` |
| `~/.local/bin/*` | `~/.config/scripts/*` (individual symlinks) |
| `~/.zshrc` | Sources `$ZDOTDIR/.zshrc` via `.zshenv` |

### Zsh

`ZDOTDIR` is set to `~/.config/zsh` in `~/.zshenv`. Structure:

- `.zshenv` - always sourced first (all shell types); sets XDG dirs, PATH, `UV_CACHE_DIR`
- `.zshrc` - interactive shells only; plugins, aliases, functions, shell integrations
- `aliases.zsh` - shell aliases
- `functions.zsh` - shell functions

Environment variables needed by scripts/non-interactive shells go in `.zshenv`, not `.zshrc`.

### uv (Python)

Cache is on `/Volumes/Casa` for hardlink performance with projects on that volume:

```bash
# in .zshenv (not .zshrc, so all shells get it)
export UV_CACHE_DIR=/Volumes/Casa/.uv-cache
```

**Sandbox conflict:** The uv cache contains `.git` marker files (to prevent git indexing). Claude Code's sandbox blocks `.git` access, causing `uv` commands to fail with "Operation not permitted". This is tracked in [anthropics/claude-code#22620](https://github.com/anthropics/claude-code/issues/22620).

**Workaround:** Claude Code cannot run `uv` commands directly. For the ad-hoc Python environment:
- User must run `uv add <package> --project /casa/dev/claude-code` manually
- Claude Code uses the venv python directly: `/casa/dev/claude-code/.venv/bin/python`

### Sandbox Limitations

The sandbox blocks more than expected:

- **`.git` access** - blocked everywhere, breaks `git clone`, `uv`, and similar tools
- **Symlinks outside CWD** - user must create manually
- **Heredocs** - write to file first, then execute
- **`additionalDirectories`** - requires full paths, no tilde expansion
- **`excludedCommands`** - doesn't bypass sandbox on first attempt (bug)

When blocked, ask the user to run the command.

### Scripts

Standalone scripts go in `~/.config/scripts/`. To make available in PATH:

```bash
ln -sf ~/.config/scripts/script-name ~/.local/bin/script-name
```

Use scripts (not shell functions) for commands that need to work in non-interactive shells.

### Application Configs

- `claude/` - Claude Code settings, CLAUDE.md
- `ghostty/` - Ghostty terminal
- `nvim/` - Neovim
- `tmux/` - tmux
- `zsh/` - Zsh shell
