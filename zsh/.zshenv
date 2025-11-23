# Bootstrap file for zsh configuration
# This file must be symlinked to ~/.zshenv for zsh to find it
#
# per https://youtu.be/rgdR27KMxpo, .zshenv is always sourced
# first, regardless of shell type: login, interactive, or script
# global order: zshenv, zprofile, zshrc, zlogin

# set global config root
if [[ -z "$XDG_CONFIG_HOME" ]]; then
	export XDG_CONFIG_HOME="${HOME}/.config"
fi

# specify location of zsh configuration
if [[ -d "${XDG_CONFIG_HOME}/zsh" ]]; then
	export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
fi

# Set state directory if not already set
# for files that maintain system state, e.g. user history
if [[ -z "$XDG_STATE_HOME" ]]; then
    export XDG_STATE_HOME="${HOME}/.local/state"
fi

# Ensure the zsh state directory exists
if [[ ! -d "$XDG_STATE_HOME/zsh" ]]; then
    mkdir -p "${XDG_STATE_HOME}/zsh"
fi

# Set directory for zsh session files
export ZSHDDIR="${XDG_STATE_HOME}/zsh/sessions"

# uv tools
export PATH="${HOME}/.local/bin:$PATH"
