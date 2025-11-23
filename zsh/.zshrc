# --- install and load zinit ---
# zinit and plugins all stored in ~/.local/share
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# --- load aliases ---
source "${ZDOTDIR}/aliases.zsh"
source "${ZDOTDIR}/aliases-git.zsh"
source "${ZDOTDIR}/aliases-eza.zsh"

# --- load functions ---
source "${ZDOTDIR}/functions.zsh"

# --- load options ---
source "${ZDOTDIR}/options.zsh"

# --- configure vi mode ---
source "${ZDOTDIR}/vi-mode.zsh"

# --- zsh history settings ---
# Override default history file location
# by default zsh sets this to $ZOTDIR/.zsh_history
export HISTFILE="${XDG_STATE_HOME}/zsh/history"

HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase

# --- uv settings ---
export UV_CACHE_DIR=/Volumes/Casa/.uv-cache

# --- shell integrations ---
eval "$(zoxide init --cmd cd zsh)"
eval "$(direnv hook zsh)"

# --- app settings ---
export BAT_THEME="Monokai Extended Bright"
export LESS="--chop-long-lines --HILITE-UNREAD --ignore-case --incsearch --jump-target=4 --LONG-PROMPT --no-init --quit-if-one-screen --RAW-CONTROL-CHARS --use-color --window=-4"
export RIPGREP_CONFIG_PATH="${HOME}/.config/ripgreprc"

# --- nvm settings ---
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# --- load and configure plugins using zinit ---
zinit light zsh-users/zsh-completions
autoload -U compinit && compinit

zinit light Aloxaf/fzf-tab

eval "$(fzf --zsh)"

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light MichaelAquilina/zsh-you-should-use

source "${ZDOTDIR}/fzf.zsh"

# --- configure plugins ---
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'         # case insensitive
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}          # colorize completions
zstyle ':completion:*' group-name ''                           # group matches by type
zstyle ':completion:*:*:*:*:directories' list-dirs-first true  # dirs before files
zstyle ':fzf-tab:*' fzf-command fzf                            # use fzf for tab completion

# --- Oh-My-Posh Prompt Setup ---
# original themes installed to ${brew --prefix oh-my-posh}/themes/
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/posh/posh.toml)"
fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

