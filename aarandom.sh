#!/bin/zsh
files=(`\find ~/dotfiles/aa -type f`)
index=`expr $((RANDOM%${#files[*]})) + 1`
echo $index
file=${files[$index]}
echo $file
cat $file
# more ${files[$((RANDOM%${#files[*]}))]}
