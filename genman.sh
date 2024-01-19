#!/bin/zsh

set -euo pipefail

if [[ $# -ne 2 ]]; then
    >&2 echo "usage: genman.sh file output_directory"
    exit 1
fi

if ! [[ $1 =~ \.md$ ]]; then
    >&2 echo "error: input file is not markdown"
    exit 1
fi

file_path=$1
out_dir=$2
base_name=$(basename $file_path)
out_file=$out_dir/${base_name%\.*}
pandoc --standalone --to man $file_path -o $out_file

exit 0
