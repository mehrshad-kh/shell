#!/bin/zsh

set -euo pipefail

dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com \
  | sed -E 's/"//g'

exit 0
