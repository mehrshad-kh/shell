#!/bin/zsh

set -euo pipefail

if [[ $# -ne 1 ]]; then
    >&2 echo "error: usage: tman.sh [command]"
    exit 1
fi

tcl_version='8.6.13'

open "$HOME/Downloads/tcl$tcl_version/html/TclCmd/$1.htm"

exit 0
