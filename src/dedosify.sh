#!/bin/zsh

# Modify text files created on Windows to match the Unix environment.

set -euo pipefail

usage="usage: dedosify.sh [file]"

if [[ $# -eq 1 && $1 =~ (-h|--help) ]]; then
  >&2 echo $usage
  exit 1
fi

# Only one parameter is needed.
if [[ $# -ne 1 ]]; then
  >&2 echo $usage
  exit 1
fi

# Assign the first parameter to a file.
file=$1
# Create a temp file.
tmp=$(mktemp)


# Check if $file is actually a file.
if [[ ! -f $file ]]; then
  >&2 echo "error: the provided argument is not a file"
  exit 1
fi

# Convert CRLF line terminators to LF.
tr -d '\r' < $file > $tmp

# Expand tabs to four spaces.
expand -t 4 $tmp > $file

# Remove the temp file.
rm $tmp

exit 0

