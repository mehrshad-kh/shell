#!/bin/zsh
# Quantum Find - list all the courses on quantum physics 
# at the Physics Department of Tehran Polytechnic, 
# along with the respective professor's name.

set -eu

faculty="https://phee.aut.ac.ir/content/3766/Faculty?&slct_pg_id=3146&sid=17&slc_lang=en"
homepages=($(curl -L -s "${faculty}" | grep -E "<span.+Homepage" | grep -oE "href=\"[^\"]+\"" | cut -d "=" -f 2 | sed "s/\"//g" | grep -E "^https:\/\/aut\.ac\.ir"))

for homepage in "${homepages[@]}"; do
    courses=("$(curl -L -s "${homepage}" | sed -n '/Taught Courses/,$p' | grep -E "Quantum" | sed "s/^[^>]*//" | sed "s/>//" | sed "s/>//" | sed "s/<.*//")")

    courses=($courses)
    # courses=("$(echo "${courses[@]}" | sort)")

    if [[ "${#courses[@]}" -ne 0 ]]; then
        professor_name="$(echo "${homepage}" | rev | cut -d "/" -f 1 | rev | sed "s/%20/ /g" | sed "s/-/ /g" | sed "s/?slc_lang//g")"
        echo "${professor_name}"
        for course in "${courses[@]}"; do
            echo "${course}"
        done
        echo 
    fi
done

exit 0

