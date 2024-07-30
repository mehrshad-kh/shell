#!/bin/zsh

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

chronograph
