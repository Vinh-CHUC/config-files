#################
## OS Specific ##
#################

## OSX
install-osx-bins:
	brew install bat eza fd font-hack-nerd-font fzf gh gitui lua-language-server neovim python3 rg starship tmux wget zellij
	brew install fish

install-osx-security:
	brew install gnupg yubikey-personalization hopenpgp-tools ykman pinentry-mac

install-osx-cloud:
	brew tap hashicorp/tap
	brew install hashicorp/tap/terraform hashicorp/tap/terraform-ls
	brew install helm argocd awscli
	brew install --cask google-cloud-sdk

install-osx-cpp:
	brew install bazelisk clang-format cmake llvm

###########
## Linux ##
###########
install-linux-cargo-pkgs:
	cargo install -f --locked gitui kanata zellij

install-linux-starship:
	curl -sS https://starship.rs/install.sh | sh

install-linux-bins:
	# Neovim build dependencies
	apt install ninja-build gettext cmake make unzip curl build-essential
	apt install bat build-essential fd-find fzf eza fish git ripgrep
	ln -s $(which fdfind) ~/.local/bin/fd
	# Python build deps
	apt install build-essential libssl-dev zlib1g-dev \
		libbz2-dev libreadline-dev libsqlite3-dev curl git \
		libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
	apt install just
	# Haskell build dependencies
	apt install libgmp-dev
	# GUI - Wayland
	apt install foot mesa-utils sway upower xclip waybar wofi
	# GUI - I3
	apt install brightnessctl i3 blueman maim pavucontrol pasystray polybar rofi
	# Graphical Terminal Emulators
	apt install alacritty
	# Security related
	apt install fuse pinentry-tty scdaemon

## MNT Pocket Reform
setup-kanata:
	cp keyboards/kanata/99-uinput.rules /etc/udev/rules.d/
	cp keyboards/kanata/uinput.conf /etc/modules-load.d/

##########
## Misc ##
##########
# Path should be updated for Linux?
setup-fzf-completions:
	/usr/local/opt/fzf/install


############
## Python ##
############
install-python-poetry:
	curl -sSL https://install.python-poetry.org | python3 -

## Note these are already checked-in
setup-python-poetry-completions:
	poetry completions fish > ~/.config/fish/completions/poetry.fish

#############
## Haskell ##
#############
install-haskell-ghcup:
	curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | \
		BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
		BOOTSTRAP_HASKELL_INSTALL_STACK=1 \
		BOOTSTRAP_HASKELL_INSTALL_HLS=1 \
		sh

###########
## Idris ##
###########
install-osx-idris2:
	brew install chezscheme
	# Seems broken atm...
	bash -c "$$(curl -fsSL https://raw.githubusercontent.com/stefan-hoeck/idris2-pack/main/install.bash)"
	pack install-app idris2-lsp

##########
## Rust ##
##########
install-rustup:
	curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path -y
install-rust-analyzer:
	rustup component add rust-analyzer

##############
## Dotfiles ##
##############
setup-fish:
	rm -rf ~/.config/fish
	ln -s $(shell pwd)/fish ~/.config/fish
	mkdir -p ~/.config/fish/conf.d
	mkdir -p ~/.config/fish/completions
	mkdir -p ~/.config/fish/functions

setup-fisher:
	curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

setup-git:
	ln -sf $(shell pwd)/gitconfig ~/.gitconfig
	mkdir -p ~/.config
	rm -rf ~/.config/gitui
	ln -s $(shell pwd)/gitui ~/.config

setup-ipython:
	ipython profile create
	ln -sf $(shell pwd)/ipython_config.py ~/.ipython/profile_default/ipython_config.py

setup-nvim:
	mkdir -p ~/.config
	rm -rf ~/.config/nvim
	ln -s $(shell pwd)/nvim_config ~/.config/nvim
	mkdir -p ~/.local/share
	rm -rf ~/.local/share/nvim
	ln -s $(shell pwd)/nvim ~/.local/share/nvim

setup-starship:
	rm -rf ~/.config/starship.toml
	ln -s $(shell pwd)/starship.toml ~/.config/

setup-sway-waybar:
	mkdir -p ~/.config/sway
	mkdir -p ~/.config/waybar
	ln -sf $(shell pwd)/desktop/sway/config ~/.config/sway/config
	ln -sf $(shell pwd)/desktop/waybar/config ~/.config/waybar/config

setup-i3:
	mkdir -p ~/.config/i3
	ln -sf $(shell pwd)/desktop/i3/config ~/.config/i3/config
	rm -Rf ~/.config/polybar
	ln -sf $(shell pwd)/desktop/polybar ~/.config/polybar

setup-zellij:
	rm -rf ~/.config/zellij
	ln -s $(shell pwd)/zellij ~/.config/zellij

