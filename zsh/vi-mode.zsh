# --- zsh vi mode settings ---

# enable vi mode
bindkey -v

# reduce ESC delay to 0.1 seconds (default is 0.4)
export KEYTIMEOUT=1

# open current command in nvim with 'v' in normal mode
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

# cursor shape: beam for insert, block for command mode
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'  # steady block
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'  # steady beam
  fi
}
zle -N zle-keymap-select

# start each new prompt in insert mode with beam cursor
function zle-line-init {
  echo -ne '\e[6 q'
}
zle -N zle-line-init

# up/down arrow searches history matching current input
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
