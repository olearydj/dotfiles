# history related settings
setopt sharehistory          # share history between sessions
setopt hist_ignore_all_dups  # remove older duplicate entries
setopt hist_find_no_dups     # suppress dupes in history search
setopt hist_ignore_space     # skip commands that start with space
setopt extended_history      # record timestamp of command
setopt hist_reduce_blanks    # remove superfluous blanks
setopt hist_verify           # secure history expansion

# other options
setopt auto_cd               # type directory name to cd
setopt correct               # auto-correct commands
setopt glob_dots             # makes globs match dotfiles

# remove duplicate entries from PATH
typeset -U PATH path

