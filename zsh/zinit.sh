if [ ! -e $HOME/.zinit/bin ]
then
  mkdir ~/.zinit
  git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi
### zinit
source ~/.zinit/bin/zinit.zsh
# module_path+=( "$HOME/.zinit/bin/zmodules/Src" )
# zmodload zdharma/zinit

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# zinit ice wait atinit"zpcompinit; zpcdreplay"
# zinit light zdharma/fast-syntax-highlighting

# git diff
zinit ice as"program" pick"bin/git-dsf"
zinit light zdharma/zsh-diff-so-fancy

# fzf
# zinit lucid as=program pick="$ZPFX/bin/(fzf|fzf-tmux)" \
#   atclone="cp shell/completion.zsh _fzf_completion; \
#   cp bin/(fzf|fzf-tmux) $ZPFX/bin" \
#   make="PREFIX=$ZPFX install" for \
#   junegunn/fzf
zinit pack for fzf
# zinit ice lucid wait"0" depth"1" blockf
# zinit light "chitoku-k/fzf-zsh-completions"
# zinit light yuki-ycino/fzf-preview.zsh
# # FZF_PREVIEW_DISABLE_DEFAULT_BIND=1
# FZF_PREVIEW_ENABLE_TMUX=1
# bindkey '^i' fzf-or-normal-completion
# bindkey '^fc' fzf-cd
# bindkey '^f^g' fzf-ghq
# bindkey '^f^v' fzf-grep-vscode

zinit ice as"program" make
zinit light x-motemen/ghq

zinit ice as"program" atclone"cargo install exa" atpull"%atclone"
zinit light ogham/exa

zinit ice as"program" atclone"cargo install --locked bat" atpull"%atclone"
zinit light sharkdp/bat
# 
# zinit ice as"program"
# zinit light dandavison/delta

zinit ice as"program" atclone"sh autogen.sh; ./configure" atpull"%atclone" make 
zinit light tmux/tmux
# ./configure && make && sudo make install

zinit ice wait blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

zinit ice wait atinit"zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

zinit ice as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zinit ice as"completion"
zinit snippet https://raw.githubusercontent.com/docker/compose/1.24.1/contrib/completion/zsh/_docker-compose
