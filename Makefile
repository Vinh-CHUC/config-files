SHELL=zsh
#################
## Basic Tools ##
#################

## OSX
install-osx-bins:
	brew install bat eza fd font-hack-nerd-font fzf gh lua-language-server neovim python3 rg tmux wget
	brew install --cask google-cloud-sdk

install-osx-security:
	brew install gnupg yubikey-personalization hopenpgp-tools ykman pinentry-mac

install-osx-cloud:
	brew tap hashicorp/tap
	brew install hashicorp/tap/terraform hashicorp/tap/terraform-ls
	brew install helm argocd awscli

## Steam deck

## x-platforms
setup-fzf-completions:
	/usr/local/opt/fzf/install

############
## Python ##
############
install-python-poetry:
	curl -sSL https://install.python-poetry.org | python3 -

setup-python-poetry-completions:
	mkdir ~/.zfunc
	poetry completions zsh > ~/.zfunc/_poetry

#############
## Haskell ##
#############
install-haskell-ghcup:
	curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | \
		BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
		BOOTSTRAP_HASKELL_INSTALL_STACK=1 \
		BOOTSTRAP_HASKELL_INSTALL_HLS=1 \
		sh

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
setup-nvim:
	mkdir -p ~/.config
	rm -rf ~/.config/nvim
	ln -s $(shell pwd)/nvim_config ~/.config/nvim
	mkdir -p ~/.local/share
	rm -rf ~/.local/share/nvim
	ln -s $(shell pwd)/nvim ~/.local/share/nvim

setup-tmux:
	ln -sf $(shell pwd)/tmux.conf ~/.tmux.conf

setup-tmux-tpm:
	rm -rf ~/.tmux/plugins
	mkdir -p ~/.tmux/plugins
	ln -sf $(shell pwd)/tpm ~/.tmux/plugins/tpm

setup-zellij:
	mkdir -p ~/.config
	rm -rf ~/.config/zellij
	ln -s $(shell pwd)/zellij ~/.config/zellij

setup-git:
	ln -sf $(shell pwd)/gitconfig ~/.gitconfig

setup-ipython:
	ipython profile create
	ln -sf $(shell pwd)/ipython_config.py ~/.ipython/profile_default/ipython_config.py

setup-zsh:
	./setupzsh.sh
	ln -sf $(shell pwd)/completion.zsh ~/.completion.zsh
	ln -sf $(shell pwd)/extras.zsh ~/.extras.zsh

setup-dotfiles: setup-nvim setup-tmux setup-tmux-tpm setup-git setup-ipython setup-zsh
