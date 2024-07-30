#!/bin/zsh

set -euo pipefail

# If there are less than two positional arguments,
if [[ $# -lt 2 ]]; then
  # Print usage and exit on error.
  >&2 echo "usage: genman.sh file... output_directory"
  exit 1
fi

# Check if all-but-last arguments end in .md.
for (( i=1; i<$#; i++ )); do
  if ! [[ ${@[i]} =~ \.md$ ]]; then
    >&2 echo "error: input file is not markdown"
    exit 1
  fi
done

# Set output directory to one-to-last argument.
out_dir=${@: -1}
for (( i=1; i<$#; i++ )); do
  file_path=${@[i]}
  # Base name is the filename alone.
  base_name=$(basename $file_path)
  # The following parameter expansion removes .* from the end,
  # effectively removing .md from filenames.
  out_file=$out_dir/${base_name%\.*}
  pandoc --standalone --to man $file_path -o $out_file
done

exit 0
