############################
# Customize to your needs...
############################
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

prompt sorin

export PATH="$HOME/.bin:$PATH"
# recommended by brew doctor
export PATH="/usr/local/bin:$PATH"

export EXECUTOR=docker-machine
eval "$(docker-machine env dev)"

set -o vi
