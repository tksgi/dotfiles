if [ ! -e ~/.zplug ]
then
  git clone https://github.com/zplug/zplug ~/.zplug
fi
### ZPLUGIN
source ~/.zplug/init.zsh
module_path+=( "$HOME/.zplugin/bin/zmodules/Src" )
zmodload zdharma/zplugin

### Added by Zplugin's installer
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin installer's chunk

zplugin ice wait atinit"zpcompinit; zpcdreplay"
zplugin light zdharma/fast-syntax-highlighting

# git diff
zplugin ice as"program" pick"bin/git-dsf"
zplugin light zdharma/zsh-diff-so-fancy

zplugin ice wait blockf atpull'zplugin creinstall -q .'
zplugin light zsh-users/zsh-completions

zplugin ice wait atinit"zpcompinit; zpcdreplay"
zplugin light zdharma/fast-syntax-highlighting

zplugin ice as"completion"
zplugin snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zplugin ice as"completion"
zplugin snippet https://raw.githubusercontent.com/docker/compose/1.24.1/contrib/completion/zsh/_docker-compose
