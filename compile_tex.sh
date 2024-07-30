#!/bin/zsh

set -euo pipefail

src='main.tex'
tex='pdflatex'

$tex $src
# Replace trailing pattern of .* with .pdf.
open ${src/%.*/.pdf}
