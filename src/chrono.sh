#!/bin/zsh

set -euo pipefail

usage="usage: chrono.sh"

function chronograph()
{
  start=$(date +%s)
  while true;
  do
    time_elapsed=$(($(date +%s) - $start))
    printf "%s\r" $(date -u -r $time_elapsed +%H:%M:%S)
    sleep 0.5
  done
}

if [[ $# -eq 1 && $1 =~ (-h|--help) ]]; then
  >&2 echo $usage
  exit 1
fi

chronograph

exit 0
