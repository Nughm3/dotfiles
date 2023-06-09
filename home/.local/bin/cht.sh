#!/usr/bin/env bash

languages=`echo "rust python c cpp zig go" | tr " " "\n"`
coreutils=`echo "dd head sed seq sort tac tail tar tee uniq wc" | tr " " "\n"`

selected=`printf "$languages\n$coreutils" | fzf`

if [[ -z $selected ]]; then
  exit 0
fi

read -p "query: " query
query=`echo $query | tr " " "+"`
echo "---"

if echo $languages | grep -q $selected; then
  curl https://cht.sh/$selected/$query
else
  curl https://cht.sh/$selected~$query
fi

