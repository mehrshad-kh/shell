#!/bin/zsh

# mcurl.sh
# Download files and videos using curl.
# This script merely makes use of sensible options of curl.

set -euo pipefail

if [[ $# -ne 1 ]]; then
    >&2 echo "usage: mcurl [URL]"
    exit 1
fi

url=$1

# Resolve the link to get final filename.
resolved_url=$(curl -L --head -w '%{url_effective}' $url 2> /dev/null \
    | tail -n 1)

# -L, --location: Follow the request onto the last location.
# -O, --remote-name: Write output to a local file named like the remote file we get.
# -f, --fail: Fail silently.
# Use caffeinate -i to prevent system sleep. macOS only.
alias curl='caffeinate -i curl -L -O -C - -f  --retry-all-errors --retry-max-time 120'

curl $resolved_url

exit 0
