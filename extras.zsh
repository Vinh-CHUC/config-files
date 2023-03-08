export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/vinh/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/vinh/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/vinh/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/vinh/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="$HOME/bin:$PATH"
[ -f "$HOME/.cargo/env" ] && "$HOME/.cargo/env"
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
