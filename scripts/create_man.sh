#!/bin/zsh

set -euo pipefail

# Set script name.
name=$(basename $1)
capitalized_name=$(echo $name | tr '[:lower:]' '[:upper:]')

# Set section number.
section='1'

# Set destination file.
dest=docs/md/$name.1.md

if [[ -f $dest ]]; then
  >&2 echo "error: $dest already exists"
  exit 1
fi

alias echo=">> $dest echo"

echo "% ${capitalized_name}($section) $name 1.0.0"
echo '% Mehrshad Khansarian'
echo '% '
echo

echo '# NAME'
echo "**$name** - "
echo

echo '# SYNOPSIS'
echo "**$name** _file_"
echo

echo '# DESCRIPTION'
echo "**$name** "
echo

echo '# HISTORY'
echo


