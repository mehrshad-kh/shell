#!/bin/zsh

# Remove if not necessary.
# set -P
set -euo pipefail

zmodload zsh/zutil
zparseopts {n,-name}:=name_arg {u,-url}:=url_arg || exit 1

if [ $# -eq 0 ] || [ ${#name_arg[@]} -eq 0 ] || [ ${#url_arg[@]} -eq 0 ]
then
    echo "usage: init -n name -u url"
    exit 1
fi

if [ -f $PWD/.info ]; then
    echo "fatal: movies repository already exists in $PWD/" >&2
    exit 1
else
    echo "name=${name_arg[2]}" >> $PWD/.info
    echo "url=${url_arg[2]}" >> $PWD/.info
    echo "Initialized .info in $(pwd -P)/"
fi

exit 0
