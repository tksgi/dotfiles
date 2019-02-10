#!/bin/zsh
files=(`\find ~/dotfiles/aa -type f`)
clear
cat ${files[$((RANDOM%${#files[*]}))]}
# more ${files[$((RANDOM%${#files[*]}))]}
