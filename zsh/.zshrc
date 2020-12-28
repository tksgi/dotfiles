
# 環境変数
export LC_CTYPE=ja_JP.UTF-8
export LANG=ja_JP.UTF-8



# 共通設定
source ~/dotfiles/zsh/mainconf.zsh

# alias
source ~/dotfiles/zsh/alias.zsh

sh ~/dotfiles/aarandom.sh

eval "$(rbenv init -)"
eval "$(pyenv init -)"
eval "$(nodenv init -)"

# 環境変数
### .zshenvに書くべし ###

eval "$(anyenv init -)"
source ~/dotfiles/zsh/zinit.sh
