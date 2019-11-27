SHELL=zsh

build-notebook:
	docker build -t vinh/datascience:latest . 

setup-vim:
	ln -sf $(shell pwd)/vim ~/.vim
	ln -sf $(shell pwd)/vimrc ~/.vimrc

setup-tmux:
	ln -sf $(shell pwd)/tmux.conf ~/.tmux.conf

setup-git:
	ln -sf $(shell pwd)/gitconfig ~/.gitconfig

setup-zsh:
	./setupzsh.sh

setup-all: setup-vim setup-tmux setup-git setup-zsh
