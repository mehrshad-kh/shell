#!/bin/zsh

# mcurl.sh
# Download files and videos using curl.
# This script merely makes use of sensible options of curl.

set -uo pipefail

usage="usage: mcurl <url>"

# If there is other than one
# positional parameter,
if [[ $# -ne 1 ]]; then
    # Yell at user.
    >&2 echo $usage
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

# For four more times,
for ((i = 0; i < 4; i++)); do
  # Initiate the download if it hasn't been
  # finished yet.
  if [[ $? -ne 0 ]]; then curl $resolved_url; fi
done

# If the download hasn't finished yet,
# say the following words.
if [[ $? -ne 0 ]]; then say 'download error'; fi

exit 0
