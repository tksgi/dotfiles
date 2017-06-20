cd ~
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\u \W\[\033[31m\]$(__git_ps1 [%s])\[\033[00m\]\$ '
alias vi='vim'
sh aarandom.sh
export PATH=$PATH:/Users/Tetsu/.nodebrew/current/bin
/usr/local/bin/zsh
