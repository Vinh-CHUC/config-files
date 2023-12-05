export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'

export PATH="$HOME/bin:$PATH"
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

## HomeBrew
export PATH="/usr/local/bin:$PATH"

## Poetry
export PATH="$HOME/.local/bin:$PATH"
fpath+=~/.zfunc
autoload -Uz compinit && compinit
