# inspired by the eza omzsh plugin:
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/eza

# Base eza command with default options:
# - list directories before files
# - show git status in listings
# - show icons
# - makefiles clickable

alias eza='eza \
  --group-directories-first \
  --git \
  --icons=auto \
  --hyperlink'

alias l='eza -la'                # default: long with hidden

alias ls='eza'                   # replace ls with eza
alias ll='eza -l'                # long list
alias la='eza -la'               # long lists, include hidden
alias lf='eza -lf'               # long list, only files
alias ldot='eza -ld .*'          # dotfiles only, dirs as entries
alias lD='eza -D'                # only directories, not hidden
alias lDD='eza -aD'              # only directories, with hidden
alias lS='eza -l --sort=size'    # long list, size sort
alias lT='eza -l --sort=newest'  # long list, time sort

