#!/bin/zsh

# Given a student ID in clipboard, this script opens the file
# whose name contains the ID.

set -euo pipefail

# Set return code.
rc=0

# Get student ID from clipboard.
student_id=$(pbpaste)

# Create a temporary file to store matching filenames.
tmp=$(mktemp)

# Store all matching filenames to tmp.
find . -type f -name "*${student_id}*" -maxdepth 2 > tmp

# Count retrieved files.
file_count=$(wc -l tmp | awk '{print $1}')

case $file_count in
  0)
    # Inform the user if no matches were found.
    echo >&2 "error: no files matching *${student_id}*"
    rc=1
    ;;
  1)
    # Open the file if a single match was found.
    open "$(cat tmp)"
    ;;
  *)
    # Print all if there are multiple matches.
    cat tmp
    ;;
esac

rm tmp

exit $rc
