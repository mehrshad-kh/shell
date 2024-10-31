#!/bin/zsh

set -euo pipefail

tmp=$(mktemp)
find . -type f -name "*$(pbpaste)*" > tmp
if [[ $(wc -l tmp | awk '{print $1}') -eq 1 ]]; then
  open "$(cat tmp)"
else
  cat tmp
fi

rm tmp

exit 0
