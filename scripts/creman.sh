#!/bin/zsh

set -euo pipefail

usage='usage: creman.sh [file] [dest_dir]'

if [[ $# -eq 1 && $1 =~ (-h|--help) ]]; then
  echo $usage
  exit 0
fi

if [[ $# -ne 2 ]]; then
  >&2 echo $usage
  exit 1
fi

# Set script name.
name=$(basename $1)
capitalized_name=$(echo $name | tr '[:lower:]' '[:upper:]')
dest=$2

# Set author.
author='Mehrshad Khansarian'

# Set section number.
section='1'

# Set destination file.
dest=$dest/$name.1.md

if [[ -f $dest ]]; then
  >&2 echo "error: $dest already exists"
  exit 1
fi

alias echo=">> $dest echo"

echo "% $capitalized_name($section) $name 1.0.0"
echo "% $author"
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


