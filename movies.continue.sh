#!/bin/zsh

set -euo pipefail

last_episode_filename=$(readlink latest)

first_episode_link="$(cat .info | grep "^url" | cut -d "=" -f 2)"
new_episode_link="$(echo ${first_episode_link} | rev | cut -d "/" -f 2- | rev)/${last_episode_filename}"

curl -L -O -C - ${new_episode_link}
