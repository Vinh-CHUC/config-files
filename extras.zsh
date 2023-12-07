export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/vinh/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/vinh/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/vinh/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/vinh/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="$HOME/bin:$PATH"
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

## HomeBrew
export PATH="/usr/local/bin:$PATH"

## Poetry
export PATH="$HOME/.local/bin:$PATH"
fpath+=~/.zfunc
autoload -Uz compinit && compinit
