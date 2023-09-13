# 環境変数
export LC_CTYPE=ja_JP.UTF-8
export LANG=ja_JP.UTF-8

# asdf
# . $HOME/.asdf/asdf.sh
# fpath=(${ASDF_DIR}/completions $fpath)

# 共通設定
source $HOME/mainconf.zsh

# alias
source $HOME/alias.zsh

# 補完
source $HOME/zeno.zsh/zeno.zsh
export ZENO_GIT_CAT="bat --color=always"
export ZENO_GIT_TREE="exa --tree"
export ZENO_HOME=~/.config/zeno
export FZF_DEFAULT_OPTS='--reverse'

if [[ -n $ZENO_LOADED ]]; then
  bindkey ' '  zeno-auto-snippet

  bindkey '^m' zeno-auto-snippet-and-accept-line
  bindkey '^i' zeno-completion

  bindkey '^x '  zeno-insert-space
  bindkey '^x^m' accept-line
  bindkey '^x^z' zeno-toggle-auto-snippet

  bindkey '^r'   zeno-history-selection
  bindkey '^x^s' zeno-insert-snippet
  bindkey '^g' zeno-ghq-cd
fi


. "$HOME/.cargo/env"
eval "$(rtx activate zsh)"
