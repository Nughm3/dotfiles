#!/usr/bin/env bash

languages=`echo "rust python c cpp zig go" | tr " " "\n"`
coreutils=`echo "tar rsync" | tr " " "\n"`

selected=`printf "$languages\n$coreutils" | fzf`

if [[ -z $selected ]]; then
  exit 0
fi

read -p "query: " query
query=`echo $query | tr " " "+"`
echo "---"

if printf $languages | grep -qs $selected; then
  curl cht.sh/$selected/$query
else
  curl cht.sh/$selected~$query
fi

