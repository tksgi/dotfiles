#!/bin/sh
files+=(`\find ~/dotfiles/aa -type f`)
file_count=`\find ~/dotfiles/aa -type f | wc -l`
index=`expr $((RANDOM%$file_count)) + 1`
file=${files[$index]}
cat $file
# more ${files[$((RANDOM%${#files[*]}))]}
