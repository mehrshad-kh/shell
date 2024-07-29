#!/bin/zsh

### Copy relevant files to ~/bin.

set -euo pipefail

# Set user bin directory.
user_bin="$HOME/bin"

# Get all files ending in .sh, 
# which are all scripts.
files=($(ls *.sh))
# Exclude do.sh from files.
excluded_file="__copy__.sh"
# Replace files with the new version 
# missing the intended file.
files=(${files[@]/$excluded_file})

# Copy files to user bin.
rsync $files $user_bin

# Get scripts in movies.dir.
files=($(ls movies.dir/*.sh))
# Copy files to user bin, preserving their path.
rsync -R $files $user_bin

# If `movies` symbolic link has not been created in user bin,
# create it.
if [[ ! -h $user_bin/movies ]]; then
  ln -fs movies.dir/movies.sh $user_bin/movies
fi

exit 0
