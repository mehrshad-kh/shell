#!/bin/zsh

set -euo pipefail

zmodload zsh/zutil
zparseopts {s,-seek}:=seek_arg || exit 1

if [[ $# -eq 0 ]]; then
    if [ -h latest ]; then
        # -sn   disable subtitles
        # -ss pos   seek pos. Check format man page.
        ffplay $PWD/latest -fs -autoexit
    else
        echo "error: latest: no such file" >&2
        echo "Have you run \`movies link\'?" >&2
        exit 1
    fi
else
    if [[ $# -eq 2 ]]; then
        ffplay $PWD/latest -fs -autoexit -ss ${seek_arg[2]}
    fi
fi

exit 0
