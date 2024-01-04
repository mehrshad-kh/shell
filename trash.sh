#!/bin/zsh

set -euo pipefail

if [[ $# -ne 1 ]]; then
    >&2 echo 'usage: trash.sh file'
    exit 1
fi

mv $1 ~/.Trash
