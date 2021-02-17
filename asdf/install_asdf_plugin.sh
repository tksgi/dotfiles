#!/bin/zsh
cd `dirname $0`
while read line
do
  echo "${line}"
  if [ ${line[1]} = '#' ]; then
    continue
  fi
  ary=(`echo $line`)
  if [ ${#ary[@]} -eq 2 ]; then
    echo ${ary[1]}
    asdf plugin-add "${ary[1]}"
    versions=(`echo ${ary[2]} | tr -s ',' ' '`)
    for version in ${versions[@]}
    do
      echo "install version: ${version}"
      asdf install "${ary[1]}" "$version"
    done
    latest=`asdf latest ${ary[1]}`
    versionsStr=`echo ${ary[1]} | tr -s ',' ' ' | sed -e s/latest/"$latest"/`
    asdf global "${ary[0]}" "$versionsStr"
  else
    echo "the line '${line}' is invalid"
  fi
  echo ''
done < ./plugin_list.txt

# sh ./nodejs.sh
