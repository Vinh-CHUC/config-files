SHELL=zsh

setup-vim:
	ln -sf $(shell pwd)/vim ~/.vim
	ln -sf $(shell pwd)/vimrc ~/.vimrc

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

setup-all: setup-vim setup-tmux setup-git setup-ipython setup-zsh
