# pipe ripgrep output to delta pager for pretty printing
# per boost-your-git-dx, pg 90
function rg { command rg --json $@ | delta; }

# pulled from the macos plugin for omzsh:
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos

# Return the path of the frontmost Finder window
function pfd() {
  osascript 2>/dev/null <<EOF
    tell application "Finder"
      return POSIX path of (insertion location as alias)
    end tell
EOF
}

# cd to the current Finder directory
function cdf() {
  cd "$(pfd)"
}

# create a backup copy of a file
function bak() { cp "$1" "$1.bak"; }

# yank path to clipboard (uses zoxide to resolve)
function yp() {
  local dir
  if [ $# -eq 0 ]; then
    dir=$(pwd)
  else
    dir=$(zoxide query "$@") || return 1
  fi
  printf '%s' "$dir" | pbcopy
  echo "Copied: $dir"
}

# yank file path to clipboard (zoxide + fzf file picker)
function ypf() {
  local dir
  if [ $# -eq 0 ]; then
    dir=$(pwd)
  else
    dir=$(zoxide query "$@") || return 1
  fi
  local file=$(command ls "$dir" | fzf --height=~40% --prompt="file: ")
  [ -n "$file" ] || return 1
  local full="$dir/$file"
  printf '%s' "$full" | pbcopy
  echo "Copied: $full"
}

