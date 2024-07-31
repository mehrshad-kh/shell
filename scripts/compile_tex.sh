#!/bin/zsh

set -euo pipefail

usage="usage: compile_tex.sh"

if [[ $# -eq 1 && $1 =~ (-h|--help) ]]; then
  >&2 echo $usage
  exit 1
fi

src='main.tex'
tex='pdflatex'

$tex $src
# Replace trailing pattern of .* with .pdf.
open ${src/%.*/.pdf}

exit 0
