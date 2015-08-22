# Created by newuser for 5.0.8
export EXECUTOR=docker-machine
eval "$(docker-machine env default)"

autoload compinit
rm -f ~/.zcompdump; compinit
export PATH="$HOME/.bin:$PATH"
