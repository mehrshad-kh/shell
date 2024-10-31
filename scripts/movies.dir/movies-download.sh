#!/bin/zsh

set -uo pipefail

usage="usage: movies download [next | current]"

# If there is less than one positional parameter,
if [[ $# -ne 1 ]]; then
  # Exit.
  >&2 echo $usage
  exit 1
fi

# If next is given,
if [[ $1 == 'next' ]]; then
  # Set next_flag to 1.
  next_flag=1
  current_flag=0
# If current is given,
elif [[ $1 == 'current' ]]; then
  # Set current_flag to 1.
  current_flag=1
  next_flag=0
# Otherwise,
else
  # Print usage and exit.
  >&2 echo $usage
  exit 1
fi

latest=".movies/latest"
info=".movies/info"

new_episode_filename=""
new_episode_link=""

function download_current
{
  # Read last episode filename from latest.
  last_episode_filename="$(readlink ${latest})"

  # Remove the initial '../'.
  last_episode_filename="$(echo ${last_episode_filename} | sed -E "s/^\.\.\///")"

  # Get first episode link from info.
  first_episode_link="$(cat ${info} \
    | grep "^url =" \
    | cut -d "=" -f 2 \
    | xargs)"
  # Determine new episode link by injecting
  # last episode filename into first episode link.
  new_episode_link="$(echo ${first_episode_link} \
    | rev \
    | cut -d "/" -f 2- \
    | rev)/${last_episode_filename}"

  # Set new episode filename for later download.
  new_episode_filename="${last_episode_filename}"
}

function download_next
{
  # If latest does not exist,
  # the first episode is to be downloaded.
  if ! [[ -h ${latest} ]]; then
    # Set is_first to true.
    is_first=1
    # Get new episode link from info.
    new_episode_link="$(cat ${info} \
      | grep -E "^url" \
      | cut -d "=" -f 2 \
      | xargs)"

    # Determine new episode filename from 
    # its corresponding link.
    new_episode_filename="$(echo ${new_episode_link} \
      | rev \
      | cut -d "/" -f 1 \
      | rev)"
  else
    # Set is_first to false.
    is_first=0
    # In case latest exists,
    # Read last episode filename from latest.
    last_episode_filename="$(readlink ${latest})"

    # Determine last episode number from 
    # its corresponding filename.
    last_episode_number=$(echo ${last_episode_filename} \
      | grep -oE "E\d{2}" \
      | cut -c 2-3)

    # Determine new episode number by adding 1 to
    # last episode number.
    new_episode_number=$((${last_episode_number} + 1))
    # Format the new episode number to two digits.
    new_formatted_episode_number="$(printf "%02d" ${new_episode_number})"

    # Get first episode link from info.
    first_episode_link="$(cat ${info} \
      | grep -E "^url =" \
      | cut -d "=" -f 2 \
      | xargs)"
    # Determine first episode filename from
    # its corresponding link.
    first_episode_filename="$(echo ${first_episode_link} \
      | rev \
      | cut -d "/" -f 1 \
      | rev)"

    # Determine new episode filename by injecting the
    # new formatted episode number into 
    # first episode filename.
    new_episode_filename="$(echo ${first_episode_filename} \
      | sed -E "s/E[0-9]{2}/E${new_formatted_episode_number}/")"
    # Determine first episode link by injecting
    # new episode filename into
    # first episode link.
    new_episode_link="$(echo ${first_episode_link} \
      | rev \
      | cut -d "/" -f 2- \
      | rev)/${new_episode_filename}"
  fi

  # If new episode filename already exists,
  # say it cannot be downloaded.
  if [[ -f "${new_episode_filename}" ]]; then
  >&2 echo "error: next episode already exists"
    exit 1
  fi
}

if [[ ${next_flag} == 1 ]]; then
  download_next
  verb="begins"
elif [[ ${#current_flag} == 1 ]]; then
  download_current
  verb="continues"
fi

# Create an empty file to link to.
touch ${new_episode_filename}
movies link --next

# Resolve the link to get final filename.
resolved_url=$(curl -L --head -w '%{url_effective}' \
  "${new_episode_link}" 2> /dev/null | tail -n 1)

# Download the episode.
echo "Download ${verb} for: ${new_episode_filename}"
caffeinate -i curl -C - -L -O -f \
  --retry-all-errors \
  --retry-max-time 30 \
  "${resolved_url}"

# If curl finishes with error,
if [[ $? -ne 0 ]]; then
  # Link to the previous episode.
  # Exit 1.
  movies link --prev
  exit 1
fi

if [[ is_first -eq 1 ]]; then movies link; fi

exit 0
