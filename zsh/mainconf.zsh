autoload colors
colors

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# 直前のコマンドの重複を削除
setopt hist_ignore_dups
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# 同時に起動したzshの間でヒストリを共有
setopt share_history

# 補完機能を有効にする
autoload -Uz compinit
compinit -u
# if [ -e ~/.cache/zsh-completions ]; then
#   fpath=(~/.cache/zsh-completions $fpath)
# else
#   git clone git://github.com/zsh-users/zsh-completions.git ~/.cache/zsh-completions
#   fpath=(~/.cache/zsh-completions $fpath)
# fi
#移動フォルダの履歴を記録(cd -[TAB])
setopt auto_pushd
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完候補を詰めて表示
setopt list_packed
# 補完候補一覧をカラー表示
zstyle ':completion:*' list-colors ''

# コマンドのスペルを訂正
setopt correct
# ビープ音を鳴らさない
setopt no_beep

# prompt
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' formats '[%F{green}%b%f]'    
zstyle ':vcs_info:*' actionformats '%F{green}%b%f(%F{red}%a%f)' 
precmd() { vcs_info }
PROMPT="Dir: %F{red}%~%f
%F{white}% %D %* %f $ "
RPROMPT='${vcs_info_msg_0_}'
RPROMPT2='${vcs_info_msg_0_}'

export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

#viライクな設定
# bindkey -v

#コマンド履歴検索(CTRL + P,N)
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#  色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

