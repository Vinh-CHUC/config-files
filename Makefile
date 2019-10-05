build-notebook:
	docker build -t vinh/datascience:latest . 

setup-vim:
	if [[ -f ~/.vimrc || -h ~/.vimrc ]]; then \
		rm ~/.vimrc; 		  				  \
	fi;                       				  \
	if [[ -d ~/.vim || -h ~/.vim ]]; then     \
		rm -rf ~/.vim; 		  			 	  \
	fi;
	ln -s $(shell pwd)/vim ~/.vim
	ln -s $(shell pwd)/vimrc ~/.vimrc

setup-tmux:
	if [[ -f ~/.tmux.conf || -h ~/.tmux.conf ]]; then \
		rm ~/.tmux.conf; 		   					  \
	fi;                        						  \
	ln -s $(shell pwd)/tmux.conf ~/.tmux.conf

setup-git:
	if [[ -f ~/.gitconfig || -h ~/.gitconfig ]]; then \
		rm ~/.gitconfig; 		   					  \
	fi;                        						  \
	ln -s $(shell pwd)/gitconfig ~/.gitconfig

setup-zsh:
	./setupzsh.sh

setup-all: setup-vim setup-tmux setup-git setup-zsh
