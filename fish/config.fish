if status is-interactive
    # Commands to run in interactive sessions can go here

    # Basics
    fish_vi_key_bindings
    starship init fish | source

    # Abbreviations
    abbr gsf 'git st --porcelain | fzf'
    abbr glf "git log --pretty=format:'%h %an %ad %s' --date=short | fzf"
    abbr ll 'eza -l'

    # Paths
    set PATHS \
        /usr/local/bin \
        $HOME/bin \
        $HOME/.local/bin \
        $HOME/.cargo/bin \
        $HOME/.ghcup/bin \
        $HOME/.cabal/bin \
        $HOME/.pack/bin \
        $HOME/go/bin
    for p in $PATHS
        test -d $p; and fish_add_path $p
    end

    # Misc
    set -x FZF_DEFAULT_COMMAND 'fd --type file --hidden --no-ignore'
    set -x POETRY_VIRTUALENVS_IN_PROJECT 0
end
