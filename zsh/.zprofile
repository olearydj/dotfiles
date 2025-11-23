# runs in all login shells, after .zshenv, before .zshrc
# for environment setup that should happen once per login

# setup homebrew paths
eval "$(/opt/homebrew/bin/brew shellenv)"

# env vars that rely on brew
export EDITOR="nvim"

