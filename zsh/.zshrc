
# 環境変数
export LC_CTYPE=ja_JP.UTF-8
export LANG=ja_JP.UTF-8



# 共通設定
source ~/dotfiles/zsh/mainconf.zsh

# alias
source ~/dotfiles/zsh/alias.zsh

sh ~/dotfiles/aarandom.sh

# 環境変数
if [ -f '~/path.sh`' ]
then
  source ~/path.sh
fi

source ~/dotfiles/zsh/zinit.sh
