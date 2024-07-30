#!/bin/zsh

set -euo pipefail

if [[ $# -eq 0 ]]; then
    >&2 echo 'usage: trash.sh <file>...'
    exit 1
fi

mv "$@" ~/.Trash

exit 0
