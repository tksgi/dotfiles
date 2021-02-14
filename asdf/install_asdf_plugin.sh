cd `dirname $0`
while read line
do
  echo "${line}"
  ary=(`echo $line`)
  if [ ${#ary[@]} -eq 2 ]; then
    asdf plugin-add "${ary[0]}"
    versions=(`echo ${ary[1]} | tr -s ',' ' '`)
    for version in versions
    do
      asdf install "${ary[0]}" "$version"
    done
    latest=`asdf latest ${ary[0]}`
    versionsStr=`echo ${ary[1]} | tr -s ',' ' ' | sed -e s/latest/"$latest"/`
    asdf global "${ary[0]}" "$versionsStr"
  else
    echo "the line '${line}' is invalid"
  fi
  echo ''
done < ./plugin_list.txt

# sh ./nodejs.sh
