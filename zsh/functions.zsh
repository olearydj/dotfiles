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

