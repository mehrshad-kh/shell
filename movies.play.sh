#!/bin/zsh

set -euo pipefail

if [ -h latest ]; then
    # -sn   disable subtitles
    # -ss pos   seek pos. Check format man page.
    ffplay $PWD/latest -fs -autoexit
else
    echo "error: latest: no such file" >&2
    echo "Have you run \`movies link\'?" >&2
    exit 1
fi

exit 0
