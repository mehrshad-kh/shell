#!/bin/zsh

set -euo pipefail

function echoerr
{
    >&2 echo "$1"
}

if [ $# -eq 0 ]
then
    echoerr "vilen: illegal use"
    echoerr "usage: vilen [file ...]"
    exit 1
fi

for link in "$@"
do
    resolved_link=$(curl -L --head -w '%{url_effective}' $link 2>/dev/null | tail -n1)
    video_len=$(ffmpeg -i $resolved_link 2>&1 | grep 'Duration' | cut -d ' ' -f 4 | sed s/,//)
    # ffprobe -i $file -show_entries format=duration -sexagesimal -v quiet -of csv="p=0"
    echo $video_len
done

exit 0
