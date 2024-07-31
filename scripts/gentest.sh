#!/bin/zsh

set -euo pipefail

usage="usage: gentest.sh"

if [[ $# -eq 1 && $1 =~ (-h|--help) ]]; then
  >&2 echo $usage
  exit 1
fi

inputs=(15 20 25 39 44 55 67 80 82 85 92)

for ((i = 1; i <= ${#inputs[@]}; i++)); do
  # Write each input to a file in in/.
  echo ${inputs[i]} > in/input${i}.txt
  # Create the corresponding output in out/
  # after being given to main executable.
  ./main < in/input${i}.txt > out/output${i}.txt
done

exit 0
