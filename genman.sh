#!/bin/zsh

set -euo pipefail

if [[ $# -ne 1 ]]; then
    >&2 echo "usage: genman.sh file"
    exit 1
fi

if ! [[ $1 =~ \.md$ ]]; then
    >&2 echo "error: input file is not markdown"
    exit 1
fi

pandoc --standalone --to man $1 -o ${1%\.*}

exit 0
