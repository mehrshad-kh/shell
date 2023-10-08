#!/bin/zsh
# Quantum Find - list all the professors who have taught a course in quantum physics.

set -eu

faculty="https://phee.aut.ac.ir/content/3766/Faculty?&slct_pg_id=3146&sid=17&slc_lang=en"
homepages=($(curl -L -s "${faculty}" | grep -E "<span.+Homepage" | grep -oE "href=\"[^\"]+\"" | cut -d "=" -f 2 | sed s/\"//g | grep -E "^https:\/\/aut\.ac\.ir"))

for homepage in ${homepages[@]}; do
    count=$(curl -L -s "${homepage}" | sed -n '/Taught Courses/,$p' | grep -E "Quantum" | wc -l)
    if [[ ${count} -ne 0 ]]; then
        printf "%d %s\n" "${count}" "$(echo "${homepage}" | rev | cut -d "/" -f 1 | rev | sed s/%20/\ /g | sed s/-/\ /g | sed s/\?slc_lang//g)"
    fi
done

exit 0

