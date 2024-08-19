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

## Pocket Reform
install-linux-cargo-pkgs:
	cargo install -f --locked gitui kanata zellij

install-linux-starship:
	curl -sS https://starship.rs/install.sh | sh

install-linux-bins:
	# Neovim build dependencies
	apt install ninja-build gettext cmake unzip curl build-essential
	apt install bat build-essential fd-find eza fish git ripgrep upower xclip

##########
## Misc ##
##########
setup-fzf-completions:
	/usr/local/opt/fzf/install

setup-kanata:
	cp keyboards/kanata/99-uinput.rules /etc/udev/rules.d/
	cp keyboards/kanata/uinput.conf /etc/modules-load.d/

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

setup-tmux:
	ln -sf $(shell pwd)/tmux.conf ~/.tmux.conf

setup-zellij:
	mkdir -p ~/.config
	rm -rf ~/.config/zellij
	ln -s $(shell pwd)/zellij ~/.config/zellij

setup-sway-waybar:
	mkdir -p ~/.config/kanata
	ln -sf $(shell pwd)/keyboards/kanata/toggle.sh ~/.config/kanata/
	ln -sf $(shell pwd)/keyboards/kanata/pocket-reform.kbd ~/.config/kanata/
	ln -sf $(shell pwd)/desktop/sway/config ~/.config/sway/config
	ln -sf $(shell pwd)/desktop/waybar/config ~/.config/waybar/config

setup-zsh:
	./setupzsh.sh
	ln -sf $(shell pwd)/completion.zsh ~/.completion.zsh
	ln -sf $(shell pwd)/extras.zsh ~/.extras.zsh

setup-dotfiles: setup-nvim setup-tmux setup-tmux-tpm setup-git setup-ipython setup-zsh
