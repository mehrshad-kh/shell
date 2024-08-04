#!/bin/zsh

set -euo pipefail

user_bin=$HOME/bin

# Get all scripts as an array.
files=($(ls *.sh))

# Set the excluded file.
excluded_file='__link__.sh'

# Remove the excluded file from the array.
files=(${files[@]/$excluded_file})

for file in ${files[@]}; do
  # `readlink -f` returns absolute path of file.
  ln -fs $(readlink -f $file) $user_bin/$(basename $file)
done

ln -fs $(readlink -f $(readlink movies)) $user_bin/movies

exit 0
