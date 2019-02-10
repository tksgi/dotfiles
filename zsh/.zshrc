# 環境変数
export LC_CTYPE=ja_JP.UTF-8
case "$(TERM)" in
  Linux)
    #ttyの場合
    export LANG=C 
    ;;
  *)
    #その他のターミナルエミュレータの場合
    export LANG=ja_JP.UTF-8
    ;;
esac


case "$(uname)" in
  Darwin)
    #MacOSの場合
    ;;
  Linux)
    #Linuxの場合
    source ~/dotfiles/zsh/debian.zsh
    ;;
esac
# 共通設定
source ~/dotfiles/zsh/mainconf.zsh

# alias
source ~/dotfiles/zsh/zshalias.zsh

sh ~/dotfiles/aarandom.sh
