if [ ! -e zinit ]
then
  mkdir ~/.zinit
  git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi
### zinit
source ~/.zplug/init.zsh
module_path+=( "$HOME/.zinit/bin/zmodules/Src" )
zmodload zdharma/zinit

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice wait atinit"zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

# git diff
zinit ice as"program" pick"bin/git-dsf"
zinit light zdharma/zsh-diff-so-fancy

zinit ice wait blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

zinit ice wait atinit"zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

zinit ice as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zinit ice as"completion"
zinit snippet https://raw.githubusercontent.com/docker/compose/1.24.1/contrib/completion/zsh/_docker-compose
