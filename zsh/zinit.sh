if [ ! -e $HOME/.zinit/bin ]
then
  mkdir ~/.zinit
  git clone git@github.com:/zdharma/zinit.git ~/.zinit/bin
fi
### zinit
source ~/.zinit/bin/zinit.zsh
# module_path+=( "$HOME/.zinit/bin/zmodules/Src" )
# zmodload zdharma/zinit

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# git diff
zinit ice as"program" pick"bin/git-dsf"
zinit light zdharma/zsh-diff-so-fancy

zinit ice wait blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

zinit ice wait atinit"zpcompinit; zpcdreplay"
zinit light zsh-users/zsh-syntax-highlighting

zinit ice as"completion"
zinit snippet git@github.com:/docker/cli/blob/master/contrib/completion/zsh/_docker

zinit ice as"completion"
zinit snippet https://raw.githubusercontent.com/docker/compose/1.24.1/contrib/completion/zsh/_docker-compose
