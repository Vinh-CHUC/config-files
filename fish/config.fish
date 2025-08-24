if status is-interactive
    # Commands to run in interactive sessions can go here

    # Basics
    fish_vi_key_bindings
    starship init fish | source

    direnv hook fish | source

    # Abbreviations
    abbr gsf 'git st --porcelain | fzf'
    abbr glf "git log --pretty=format:'%h %an %ad %s' --date=short | fzf"
    abbr ls 'eza -ls time'

    abbr psource 'source $(poetry env info --path)/bin/activate.fish'

    # Paths
    set -gx PYENV_ROOT $HOME/.pyenv
    set PATHS \
        /usr/local/bin \
        $HOME/bin \
        $HOME/.local/bin \
        $HOME/.local/bin/lua-language-server/bin \
        $HOME/.local/bin/obsidian \
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

    # LLMs
    set -x GEMINI_MODEL "gemini-2.5-flash"
    if test -f $HOME/.gemini_api_key; set -x GEMINI_API_KEY (string trim (cat $HOME/.gemini_api_key)); end;

    # Misc
    set -x FZF_DEFAULT_COMMAND 'fd --type file --hidden --no-ignore'
    set -x POETRY_VIRTUALENVS_IN_PROJECT 1

    # Homebrew linux
    set --global --export HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew";
    set --global --export HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar";
    set --global --export HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew";
    fish_add_path --global --move --path "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin";
    if test -n "$MANPATH[1]"; set --global --export MANPATH '' $MANPATH; end;
    if not contains "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH; set --global --export INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH; end;
    if test -n "$XDG_DATA_DIRS"; set --global --export XDG_DATA_DIRS "/home/linuxbrew/.linuxbrew/share" $XDG_DATA_DIRS; end;
end
