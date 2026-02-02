# dotfiles

Personal configuration files for macOS. All configs live in `~/.config/` following XDG conventions.

## Setup (New Machine)

```bash
# Clone to ~/.config (backup existing if needed)
git clone https://github.com/olearydj/dotfiles.git ~/.config

# Symlink zsh bootstrap (required for zsh to find config)
ln -s ~/.config/zsh/.zshenv ~/.zshenv

# Install dependencies via Homebrew
brew install zsh neovim git delta bat eza fzf zoxide direnv ripgrep btop
brew install --cask ghostty karabiner-elements

# Install oh-my-posh
brew install jandedobbeleer/oh-my-posh/oh-my-posh

# Install zinit (zsh plugin manager) - happens automatically on first shell launch

# Restart shell
exec zsh
```

### Required Fonts

Install [MonaspiceXe Nerd Font](https://www.nerdfonts.com/font-downloads) for Ghostty and Neovim icons.

## Shell (zsh)

**Location:** `~/.config/zsh/`

**Bootstrap:** `~/.zshenv` must be symlinked to `~/.config/zsh/.zshenv` for zsh to find it.

```bash
ln -s ~/.config/zsh/.zshenv ~/.zshenv
```

**Structure:**
- `.zshenv` - Bootstrap (XDG setup, ZDOTDIR) + PATH (uv tools in `~/.local/bin`)
- `.zprofile` - Homebrew init, sets EDITOR=nvim
- `.zshrc` - Main config, sources everything else
- `options.zsh` - Shell options (history, auto_cd, PATH deduplication)
- `vi-mode.zsh` - Vi mode with cursor shape changes, edit-command-line, history prefix search
- `aliases.zsh` - General aliases (cat→bat, e→nvim)
- `aliases-git.zsh` - Git shortcuts (gs, gco, gp, gcom, gcm, etc.)
- `aliases-eza.zsh` - ls→eza replacements with icons/git
- `functions.zsh` - rg→delta piping, cdf (cd to Finder)
- `fzf.zsh` - Extensive fzf config with previews and custom theme

**Plugins (via zinit):**
- `zsh-completions` - Extended completions
- `fzf-tab` - Fuzzy tab completion (replaces default menu)
- `zsh-autosuggestions` - Fish-like history suggestions
- `fast-syntax-highlighting` - Command syntax colors
- `zsh-you-should-use` - Alias reminders

**Shell integrations:**
- `zoxide` - Smart cd (aliased as `cd`)
- `direnv` - Per-directory env vars
- `fzf` - Fuzzy finder (Ctrl+R history, Ctrl+T files, Opt+C dirs)
- `oh-my-posh` - Prompt theming
- `nvm` - Node version manager
- `conda` - Python via miniconda

## Terminal (Ghostty)

**Location:** `~/.config/ghostty/config`

- Theme: Arthur
- Font: MonaspiceXe Nerd Font Mono (size 20, ligatures disabled)
- Shell integration enabled (prompt jumping with Cmd+Up/Down)
- Block cursor, mouse hides while typing

## Prompt (Oh My Posh)

**Location:** `~/.config/posh/posh.toml`

Three-block layout:
1. **Left:** OS icon → Path (last 2 dirs) → Git branch
2. **Right:** user@host | execution time (>3s)
3. **New line:** `❯` prompt (red on error)

Transient prompt enabled with blank line before old prompts.

## Editor (Neovim)

**Location:** `~/.config/nvim/`

Based on kickstart.nvim with custom plugins in `lua/custom/`.

**Features:**
- Hybrid relative line numbers (current line shows absolute)
- Sticky scroll context (treesitter-context) - parent headers/functions pinned at top
- Outline sidebar (aerial.nvim) with Telescope integration
- Diagnostics: icons in margin only, `<leader>e` to inspect full message

**Custom Plugins:**
- `nvim-treesitter-context` - VS Code-style sticky scroll
- `aerial.nvim` - Symbol outline sidebar
- `markdown-preview.nvim` - Live preview in browser

**Markdown:**
- Soft wrap with `j`/`k` navigating display lines
- Linting disabled by default (manual with `<leader>ml`)
- Auto-fix with `<leader>mf`
- Format-on-save disabled (use `<leader>f` to format manually, or `:noa w` to save without any autocmds)
- Config: `.markdownlint.json` (dash-style lists, no line length limit)

**Key Bindings (custom):**

| Binding | Action |
|---------|--------|
| `<leader>e` | Show diagnostic in float |
| `<leader>o` | Toggle outline sidebar |
| `<leader>so` | Search outline symbols (Telescope) |
| `[c` | Jump to sticky context |
| `<leader>mp` | Markdown preview toggle |
| `<leader>ml` | Markdown lint (manual) |
| `<leader>mf` | Markdown auto-fix |

## Git

**Location:** `~/.config/git/`

- `config` - User info, delta pager (side-by-side, line numbers, hyperlinks), merge conflict style zdiff3
- `ignore` - Global gitignore (Python, macOS, Office, vim, node, credentials)

Uses delta for diffs with Monokai Extended theme.

## Other Tools

| Tool | Config Location | Notes |
|------|-----------------|-------|
| btop | `~/.config/btop/` | System monitor |
| ripgrep | `~/.config/ripgreprc` | Smart-case, hidden files, hyperlinks |
| bat | (uses defaults) | Aliased as `cat`, Monokai Extended Bright theme |
| Karabiner | `~/.config/karabiner/` | Caps Lock → Hyper/Escape |

## Scripts

**Location:** `~/.config/scripts/` (symlinked to `~/.local/bin/`)

- `md2pdf` - Markdown to PDF via pandoc + typst with GitHub-style alerts

## Key Bindings

| Binding | Action |
|---------|--------|
| `Escape` | Vi normal mode (zsh) |
| `v` (normal mode) | Open command in nvim |
| `Up/Down` | History search matching current prefix |
| `Ctrl+R` | Fuzzy history search (fzf) |
| `Ctrl+T` | Fuzzy file picker (fzf) |
| `Opt+C` | Fuzzy cd (fzf) |
| `Tab` | Fuzzy completion (fzf-tab) |
| `Cmd+Up/Down` | Jump between prompts (Ghostty) |
| `Caps Lock` | Hyper key (held) or Escape (tapped) |

## PATH Order

1. `~/.local/bin` - User tools (uv, scripts)
2. Conda, nvm, zinit
3. Homebrew
4. System paths
5. TeX, Quarto, Ghostty

