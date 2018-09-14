#!/bin/zsh
files=(`\find ~/.aa -type f`)
clear
cat ${files[$((RANDOM%${#files[*]}))]}
# more ${files[$((RANDOM%${#files[*]}))]}
