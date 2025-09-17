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
	apt install bat build-essential direnv fd-find fzf eza fish git ripgrep sd
	# Python build deps
	apt install build-essential libssl-dev zlib1g-dev \
		libbz2-dev libreadline-dev libsqlite3-dev curl git \
		libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
	# CPP
	apt install clangd
	# go
	apt install golang-go
	# Haskell build dependencies
	apt install libgmp-dev
	# For opening appimages
	apt install libfuse2t64
	apt install alacritty just

install-linux-i3:
	apt install brightnessctl i3 blueman maim pavucontrol pasystray polybar rofi xclip

install-linux-sway:
	apt install mesa-utils sway upower waybar wl-clipboard wlr-randr wofi

install-linux-security:
	apt install pinentry-gtk2 scdaemon

## MNT Pocket Reform
setup-kanata-root-part:
	groupadd uinput
	usermod -aG uinput vinh
	usermod -aG input vinh
	cp keyboards/kanata/99-uinput.rules /etc/udev/rules.d/
	cp keyboards/kanata/uinput.conf /etc/modules-load.d/
	ln -sf ~/.cargo/bin/kanata /usr/bin/kanata


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

install-python-uv:
	curl -LsSf https://astral.sh/uv/install.sh | sh

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

##########
## Lean ##
##########
install-lean4:
	curl https://elan.lean-lang.org/elan-init.sh -sSf | sh -s -- --no-modify-path -y

##########
## Lua ###
##########
install-lua:
	apt install liblua5.4-dev lua5.4
	cd /tmp && wget https://luarocks.org/releases/luarocks-3.12.2.tar.gz \
		&& tar zxpf luarocks-3.12.2.tar.gz \
		&& cd luarocks-3.12.2 \
		&& ./configure && make && sudo make install

install-luals:
	brew install lua-language-server

# lua-language-server on arm64, download release from website

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

setup-fdfind:
	mkdir -p ~/.local/bin
	ln -s $(which fdfind) ~/.local/bin/fd
	ln -s $(shell pwd)/fdignore ~/.fdignore

setup-git:
	ln -sf $(shell pwd)/gitconfig ~/.gitconfig
	mkdir -p ~/.config
	rm -rf ~/.config/gitui
	ln -s $(shell pwd)/gitui ~/.config

setup-kanata:
	ln -sf $(shell pwd)/keyboards/kanata ~/.config/kanata

setup-ipython:
	ipython profile create
	ln -sf $(shell pwd)/ipython_config.py ~/.ipython/profile_default/ipython_config.py

setup-nvim:
	mkdir -p ~/.config
	rm -rf ~/.config/nvim
	ln -s $(shell pwd)/nvim_config ~/.config/nvim

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
