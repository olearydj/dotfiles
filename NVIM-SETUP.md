# Neovim Cheatsheet

My customizations on top of kickstart.nvim for Python, Shell, and Markdown.

## Quick Start

```bash
nvim file.py          # Open a file
:Lazy sync            # Update plugins
:Mason                # Manage LSP servers/tools
:checkhealth          # Diagnose issues
```

## Key Bindings

Leader key: `Space`

### Navigation & Search

| Keys               | Action                      |
| ------------------ | --------------------------- |
| `<leader>sf`       | Search files                |
| `<leader>sg`       | Live grep (search content)  |
| `<leader>sh`       | Search help                 |
| `<leader>sk`       | Search keymaps              |
| `<leader><leader>` | Find open buffers           |
| `<leader>/`        | Fuzzy search current buffer |
| `\`                | Toggle file tree (neo-tree) |

### LSP (cursor on code)

| Keys        | Action                    |
| ----------- | ------------------------- |
| `grd`       | Go to definition          |
| `grr`       | Find references           |
| `gri`       | Go to implementation      |
| `grn`       | Rename symbol             |
| `gra`       | Code actions (fixes)      |
| `K`         | Hover docs (`q` to close) |
| `<leader>q` | Open diagnostics list     |

### Editing

| Keys         | Action                    |
| ------------ | ------------------------- |
| `<leader>f`  | Format buffer             |
| `<leader>mp` | Toggle markdown preview   |
| `saiw"`      | Surround word with quotes |
| `sd"`        | Delete surrounding quotes |
| `sr"'`       | Replace `"` with `'`      |

### Git (gitsigns)

| Keys         | Action         |
| ------------ | -------------- |
| `]c` / `[c`  | Next/prev hunk |
| `<leader>hp` | Preview hunk   |
| `<leader>hs` | Stage hunk     |

### Windows

| Keys           | Action              |
| -------------- | ------------------- |
| `Ctrl-h/j/k/l` | Move between splits |
| `:q`           | Close window        |
| `Ctrl-w v`     | Vertical split      |
| `Ctrl-w s`     | Horizontal split    |

## Language Support

| Language | LSP          | Linter       | Formatter |
| -------- | ------------ | ------------ | --------- |
| Python   | basedpyright | ruff         | ruff      |
| Shell    | bashls       | shellcheck   | shfmt     |
| Markdown | -            | markdownlint | prettier  |
| TOML     | taplo        | -            | taplo     |
| JSON     | jsonls       | -            | prettier  |
| YAML     | yamlls       | -            | prettier  |

**Spellcheck:** typos_lsp (code), harper_ls (grammar only)

## Config Structure

```
~/.config/nvim/
├── init.lua                 # Main config
├── after/lsp/
│   └── harper_ls.lua        # Harper settings
├── lua/
│   ├── custom/plugins/      # Custom plugins
│   └── kickstart/plugins/   # Optional plugins
└── .markdownlint.json       # Markdownlint rules
```

## Common Tasks

**Add word to dictionary:** cursor on word → `gra` → "Add to dictionary"

**Install new LSP:** add to `servers` in `init.lua` → `:Lazy sync`

**Check active LSPs:** `:LspInfo`

**Check formatters:** `:ConformInfo`
