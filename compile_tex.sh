#!/bin/zsh

set -euo pipefail

pdflatex main.tex
open main.pdf
