#!/bin/zsh

### Copy relevant files to ~/bin.

set -euo pipefail

# Set user bin directory.
user_bin="$HOME/bin"

# Get all files ending in .sh, 
# which are all scripts.
files=($(ls *.sh))
# Exclude do.sh from files.
excluded_file="do.sh"
# Replace files with the new version 
# missing the intended file.
files=(${files[@]/$excluded_file})

cp $files $user_bin

cp -R movies.dir $user_bin

# If `movies` symbolic link has not been created in user bin,
# create it.
if [[ ! -h $user_bin/movies ]]; then
  cd $user_bin
  ln -fs movies.dir/movies.sh movies
fi

exit 0
