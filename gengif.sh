#!/bin/zsh
# Generate a GIF
# From: https://superuser.com/a/556031/1756780

zmodload zsh/zutil
zparseopts t:=duration || exit 1

if [[ $# -ne 4 ]]; then
    >&2 echo 'usage: gengif.sh -t [duration] [input] [output]'
    exit 1
fi

input_file=$3
output_file=$4

if [[ -f ${output_file} ]]; then
    >&2 echo "error: ${output_file} already exists"
    exit 1
fi

ffmpeg -t ${duration[2]} -i ${input_file} \
    -vf "fps=10,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
    -loop 0 ${output_file} 

exit 0
