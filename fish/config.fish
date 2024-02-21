if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings
    starship init fish | source

    # Abbreviations
    abbr gsf 'git st --porcelain | fzf'
    abbr glf "git log --pretty=format:'%h %an %ad %s' --date=short | fzf"
    abbr ll 'eza -l'
end
