#!/bin/zsh

set -euo pipefail

usage="usage: dedosify [file]"

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
    >&2 echo $usage
    exit 1
fi

# Convert CRLF line terminators to LF.
tr -d '\r' < $file > $tmp

# Expand tabs to four spaces.
expand -t 4 $tmp > $file

# Remove the temp file.
rm $tmp

exit 0

