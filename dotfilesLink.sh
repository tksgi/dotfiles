#!/bin/sh
cd ~
mkdir ~/.config
ln -sf ~/dotfiles/.bashrc ~/.bashrc
# ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.gitignore_global ~/.gitignore_global
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/vim/.vimrc ~/.vimrc
ln -sf ~/dotfiles/nvim ~/.config/nvim
mkdir -p ~/.vim/after
ln -sf ~/dotfiles/vim/after ~/.vim/after
cp ~/dotfiles/zsh/.zshrc ~/
ln -sf ~/dotfiles/alacritty ~/.config/alacritty
