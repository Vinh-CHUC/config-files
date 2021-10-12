SHELL=zsh

setup-vim:
	ln -sf $(shell pwd)/vim ~/.vim
	ln -sf $(shell pwd)/vimrc ~/.vimrc

setup-nvim:
	mkdir -p ~/.config/nvim
	ln -sf $(shell pwd)/init.vim ~/.config/nvim/init.vim
	mkdir -p ~/.local/share
	ln -sf $(shell pwd)/nvim ~/.local/share/nvim

setup-tmux:
	ln -sf $(shell pwd)/tmux.conf ~/.tmux.conf
setup-tmux-tpm:
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

setup-bin:
	ln -sf $(shell pwd)/bin ~/bin

setup-all: setup-vim setup-nvim setup-tmux setup-tmux-tpm setup-git setup-zsh setup-bin
