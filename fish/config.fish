if status is-interactive
    # Commands to run in interactive sessions can go here

    function notify-waiting
        if test -z "$ZELLIJ_PANE_ID"
            echo "Not in Zellij"
            return 1
        end

        zellij pipe --name "zellij-attention::waiting::$ZELLIJ_PANE_ID"
    end

    function notify-completed
        if test -z "$ZELLIJ_PANE_ID"
            echo "Not in Zellij"
            return 1
        end

        zellij pipe --name "zellij-attention::completed::$ZELLIJ_PANE_ID"
    end

    # Basics
    fish_vi_key_bindings
    starship init fish | source

    direnv hook fish | source

    # Abbreviations
    abbr gsf 'git st --porcelain | fzf'
    abbr glf "git log --pretty=format:'%h %an %ad %s' --date=short | fzf"
    abbr ls 'eza -ls time'

    abbr standalone 'xrandr --output DP-1 --off --output HDMI-1-0 --off --output eDP-1 --primary --mode 1920x1080 --pos 0x0 && ~/.config/polybar/launch.sh --shapes'
    abbr workdesktop '~/.screenlayout/work.sh && cd ~/.config/polybar && ./launch.sh --shapes'
    abbr homedesktop '~/.screenlayout/home.sh && cd ~/.config/polybar && ./launch.sh --shapes'

    abbr psource 'source $(poetry env info --path)/bin/activate.fish'

    # Paths
    set PATHS \
        /usr/local/bin \
        $HOME/bin \
        $HOME/.local/bin \
        $HOME/.local/bin/lua-language-server/bin \
        $HOME/.local/bin/obsidian \
        $HOME/.cargo/bin \
        $HOME/.elan/bin \
        $HOME/.ghcup/bin \
        $HOME/.cabal/bin \
        $HOME/.pack/bin \
        /usr/local/go/bin \
        $HOME/go/bin
    for p in $PATHS
        test -d $p; and fish_add_path $p
    end

    # LLMs
    set -x GEMINI_MODEL "gemini-3-flash-preview"
    if test -f $HOME/.gemini_api_key; set -x GEMINI_API_KEY (string trim (cat $HOME/.gemini_api_key)); end;
    if test -f $HOME/.openclaw_gateway_token; set -x OPENCLAW_GATEWAY_TOKEN (string trim (cat $HOME/.openclaw_gateway_token)); end;

    # C++
    set -x CC gcc-14
    set -x CCX g++-14

    # Misc
    set -x FZF_DEFAULT_COMMAND 'fd --type file --hidden --no-ignore'
    set -x POETRY_VIRTUALENVS_IN_PROJECT 1
    zoxide init fish | source

    # Homebrew linux
    set --global --export HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew";
    set --global --export HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar";
    set --global --export HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew";
    fish_add_path --global --move --path "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin";
    if test -n "$MANPATH[1]"; set --global --export MANPATH '' $MANPATH; end;
    if not contains "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH; set --global --export INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH; end;
    if test -n "$XDG_DATA_DIRS"; set --global --export XDG_DATA_DIRS "/home/linuxbrew/.linuxbrew/share" $XDG_DATA_DIRS; end;

    # Mise
    source $HOME/.config/mise/mise.fish
end
