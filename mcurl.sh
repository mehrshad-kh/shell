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

resolved_link=$(curl -L --head -w '%{url_effective}' $url 2> /dev/null \
    | tail -n 1)

# -L, --location: Follow the request onto the last location.
# -O, --remote-name: Write output to a local file named like the remote file we get.
# -f, --fail: Fail silently.
alias curl='curl -L -O -C - -f  --retry-all-errors --retry-max-time 120'

curl $resolved_link

exit 0
