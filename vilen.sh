#!/bin/zsh

# Script does not work in case of  `set -o pipefail``
set -eu

if [[ $# -eq 0 ]]; then
    >&2 echo "vilen: illegal use"
    >&2 echo "usage: vilen [file ...]"
    exit 1
fi

for file in "$@"; do
    if [[ ${file} == "http*" ]]; then
        resolved_link=$(curl -L --head -w '%{url_effective}' ${file} 2>/dev/null | tail -n 1)
        video_len=$(ffmpeg -i ${resolved_link} 2>&1 | grep "Duration" | cut -d " " -f 4 | sed s/,//)
        # ffprobe -i $file -show_entries format=duration -sexagesimal -v quiet -of csv="p=0"
    else
        video_len=$(ffmpeg -i ${file} 2>&1 | grep "Duration" | cut -d " " -f 4 | sed s/,//)
    fi

    echo ${video_len}
done

exit 0
