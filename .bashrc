cd ~
# source /usr/local/etc/bash_completion.d/git-prompt.sh
# source /usr/local/etc/bash_completion.d/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
# export PS1='\u \W\[\033[31m\]$(__git_ps1 [%s])\[\033[00m\]\$ '
alias vi='vim'
# sh ~/dotfiles/aarandom.sh
# export PATH=$PATH:/Users/Tetsu/.nodebrew/current/bin
# /usr/local/bin/zsh
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
source "$HOME/.cargo/env"
. "$HOME/.cargo/env"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
