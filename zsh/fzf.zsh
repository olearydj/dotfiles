# =============================================================================
#                               FZF Configuration
# =============================================================================
# This configuration enhances fzf (command-line fuzzy finder) with:
# - Custom theme and visual styling
# - Integration with modern tools (fd, bat, eza)
# - Enhanced preview capabilities
# - Command-specific preview behaviors
#
# Prerequisites:
# - fzf: fuzzy finder (brew install fzf)
# - fd: modern alternative to 'find' (brew install fd)
# - bat: modern alternative to 'cat' (brew install bat)
# - eza: modern alternative to 'ls' (brew install eza)
#
# Note: This configuration assumes fzf shell integration is loaded via:
#   eval "$(fzf --zsh)"
#
# from: https://www.josean.com/posts/7-amazing-cli-tools
# see also, zen zsh config: https://youtu.be/ud7YxC33Z3w

# =============================================================================
#                               FZF User Guide
# =============================================================================
# FZF is a command-line fuzzy finder that enhances shell functionality.
# This configuration provides the following features:
#
# Key Bindings:
#   CTRL-T  - Paste selected files/folders into command line
#             - Shows preview with bat/eza
#             - Uses fd to find files (includes hidden, excludes .git)
#
#   CTRL-R  - Search command history
#             - Type to filter
#             - Up/down to navigate
#             - Enter to select
#
#   OPT-C   - CD into selected directory
#             - Shows tree preview with eza
#             - Only searches for directories
#
# Tab Completion:
#   Start typing a command and press TAB to trigger fuzzy completion:
#   cd <TAB>     - Navigate directories with preview
#   ssh <TAB>    - Select host with dig preview
#   kill <TAB>   - Select process
#   export <TAB> - See variable preview
#
# Search Syntax:
#   'word        - Exact match (quotes)
#   ^word        - Start with word
#   word$        - End with word
#   !word        - Not containing word
#   'one two     - Exact one AND contains two
#
# In fzf windows:
#   <Up>/CTRL-K  - Move up one line
#   <Down>/CTRL-J - Move down one line
#   <Enter>      - Select current item
#   CTRL-C/ESC   - Exit fzf
#   ?            - Toggle preview window
#   
# Finding files includes hidden files but excludes .git directories
# File previews show syntax highlighting via bat
# Directory previews show tree structure via eza

# -----------------------------------------------------------------------------
#                                Theme Settings
# -----------------------------------------------------------------------------
# Custom theme with dark background and carefully chosen colors
# Generated using: https://vitormv.github.io/fzf-themes/

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#d0d0d0,fg+:#d0d0d0,bg:#121212,bg+:#262626
  --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
  --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf
  --color=border:#666666,label:#87ff00,query:#d9d9d9
  --border="rounded" 
  --border-label-pos="3:center"
  --preview-window="border-rounded"
  --prompt="> "
  --marker=">" 
  --pointer="◆" 
  --separator="─" 
  --scrollbar="│"'

# -----------------------------------------------------------------------------
#                            Default Command Settings
# -----------------------------------------------------------------------------
# Configure fd as the default source for fzf
# - --hidden: Include hidden files (but still exclude .git)
# - --strip-cwd-prefix: Remove ./prefix from results
# - --exclude .git: Don't search in .git directories

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"

# Use the same command for CTRL-T (paste files/folders into command line)
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# For ALT-C (cd into selected directory), only search for directories
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# -----------------------------------------------------------------------------
#                             Preview Settings
# -----------------------------------------------------------------------------
# Define preview command based on item type:
# - For directories: show tree view using eza
# - For files: show syntax-highlighted content using bat

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

# Configure CTRL-T (file selection)
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview' \
  --border-label='CTRL-T: Select files/folders to paste...' \
  --bind '?:toggle-preview' \
  --height=50%"

# Configure ALT/OPT-C (directory jumping)
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200' \
  --border-label='OPT-C: Select directory to jump to...' \
  --bind '?:toggle-preview' \
  --height=50%"

# Configure CTRL-R (history search)
export FZF_CTRL_R_OPTS="--border-label='CTRL-R: Search command from history to paste...' \
  --height=50%"

# -----------------------------------------------------------------------------
#                           Completion Settings
# -----------------------------------------------------------------------------
# Override default path completion to use fd
# $1 is the base path to start searching from
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Override directory completion to use fd
# Similar to above but only for directories
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# -----------------------------------------------------------------------------
#                       Command-specific Previews
# -----------------------------------------------------------------------------
# Customize preview behavior based on the command being completed
# - cd: show directory tree
# - export/unset: show variable value
# - ssh: show dig output for the host
# - kill: show process information
# - others: use default fzf preview

_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)         fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export)     fzf --preview 'eval "echo \${$(echo {} | cut -d= -f1)}"' "$@" ;;
    unset)      fzf --preview 'eval "echo \${$(echo {})}"' "$@" ;;
    ssh)        fzf --preview 'dig +short {} 2>/dev/null || echo "No DNS record"' "$@" ;;
    kill)       fzf --preview 'ps -fp {}' "$@" ;;
    *)          fzf "$@" ;;
  esac
}

