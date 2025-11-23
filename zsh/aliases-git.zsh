# a subset of the aliases from git.plugin.zsh:
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git

# Helper functions for branch detection
function git_current_branch() {
  git branch --show-current 2> /dev/null || echo "main"
}

function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,master}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return 0
    fi
  done
  echo master
  return 1
}

# Core aliases for common workflows
alias g='git'

# Status
alias gs='git status'
alias gss='git status --short'

# Branch
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'

# Checkout
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcom='git checkout $(git_main_branch)'

# Add & Commit
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit --verbose'
alias gcm='git commit --message'
alias gca='git commit --verbose --all'
alias gca!='git commit --verbose --all --amend'

# Push & Pull
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gl='git pull'
alias gpr='git pull --rebase'

# Fetch
alias gf='git fetch'
alias gfa='git fetch --all --tags --prune'

# Diff
alias gd='git diff'
alias gds='git diff --staged'

# Log
alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'

# Stash
alias gst='git stash'
alias gstp='git stash pop'
alias gsta='git stash apply'

# Reset
alias grh='git reset'
alias grhh='git reset --hard'

