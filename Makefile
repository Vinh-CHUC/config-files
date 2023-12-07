SHELL=zsh

# Dotfiles themselves
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
