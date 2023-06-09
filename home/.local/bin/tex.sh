#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "usage: tex.sh [FILE] [-o|--open]"
    exit 2
fi

FILE=$1
BASE=${FILE%.*}

pdflatex $FILE 2>/dev/null 1>&2

if [ $? -ne 0 ]; then
  echo "Compilation error (exit $?)"
  exit 1
fi

rm -f "$BASE.log" "$BASE.aux" "$BASE.out"

if [ "$2" = "-o" ] || [ "$2" = "--open" ]; then
    xdg-open "$BASE.pdf"
fi

