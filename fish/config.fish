if status is-interactive
    # Commands to run in interactive sessions can go here

    # Basics
    fish_vi_key_bindings
    starship init fish | source

    # Abbreviations
    abbr gsf 'git st --porcelain | fzf'
    abbr glf "git log --pretty=format:'%h %an %ad %s' --date=short | fzf"
    abbr ls 'eza -ls time'
    abbr standalone 'xrandr --output HDMI-1-0 --off && ~/.config/polybar/launch.sh --shapes'
    abbr workdesktop '~/.screenlayout/work.sh && cd ~/.config/polybar && ./launch.sh --shapes'
    abbr homedesktop '~/.screenlayout/home.sh && cd ~/.config/polybar && ./launch.sh --shapes'

    abbr psource 'source $(poetry env info --path)/bin/activate.fish'

    # Paths
    set -Ux PYENV_ROOT $HOME/.pyenv
    set PATHS \
        /usr/local/bin \
        $HOME/bin \
        $HOME/.local/bin \
        $HOME/.cargo/bin \
        $HOME/.ghcup/bin \
        $HOME/.cabal/bin \
        $HOME/.pack/bin \
        $PYENV_ROOT/bin \
        /usr/local/go/bin \
        $HOME/go/bin
    for p in $PATHS
        test -d $p; and fish_add_path $p
    end

    pyenv init --path | source

    # Misc
    set -x FZF_DEFAULT_COMMAND 'fd --type file --hidden --no-ignore'
    set -x POETRY_VIRTUALENVS_IN_PROJECT 0

    # Homebrew linux
    set --global --export HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew";
    set --global --export HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar";
    set --global --export HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew";
    fish_add_path --global --move --path "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin";
    if test -n "$MANPATH[1]"; set --global --export MANPATH '' $MANPATH; end;
    if not contains "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH; set --global --export INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH; end;
    if test -n "$XDG_DATA_DIRS"; set --global --export XDG_DATA_DIRS "/home/linuxbrew/.linuxbrew/share" $XDG_DATA_DIRS; end;
end
