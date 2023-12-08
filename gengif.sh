#!/bin/zsh
# Generate a GIF
# From: https://superuser.com/a/556031/1756780

if [[ $# -ne 3 ]]; then
    >&2 echo 'usage: gengif.sh [seconds] [input] [output]'
    exit 1
fi

ffmpeg -t $1 -i $2 \
    -vf "fps=10,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
    -loop 0 $3 

exit 0
