#!/bin/zsh
files=(`\find ~/.aa -type f -and -not -name \*.sh`)
clear
cat ${files[$((RANDOM%${#files[*]}))]}
# more ${files[$((RANDOM%${#files[*]}))]}
