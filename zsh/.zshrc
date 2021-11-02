
# 環境変数
export LC_CTYPE=ja_JP.UTF-8
export LANG=ja_JP.UTF-8

# 共通設定
source ~/dotfiles/zsh/mainconf.zsh

# alias
source ~/dotfiles/zsh/alias.zsh

zsh ~/dotfiles/aarandom.sh

# asdf
. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)

# manをnvimで開く
export MANPAGER="nvim -c 'set ft=man' -"

# 環境変数
### .zshenvに書くべし ###

# source ~/dotfiles/zsh/zinit.sh
