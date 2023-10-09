#!/bin/zsh
# Quantum Find - list all the courses on quantum physics 
# at the Physics Department of Tehran Polytechnic, 
# along with the respective professor's name.

set -eu

if [[ $# -ne 0 ]]; then
    >&2 echo "usage: qfind.sh"
    exit 1
fi

faculty="https://phee.aut.ac.ir/content/3766/Faculty?&slct_pg_id=3146&sid=17&slc_lang=en"

# Retrieve homepage addresses of each respective professor.
homepages=($(curl -L -s "${faculty}" | \
    grep -E "<span.*Homepage" | \
    grep -oE "href=\"[^\"]+\"" | \
    cut -d "=" -f 2 | \
    sed -E "s/\"//g" | \
    grep -E "^https:\/\/aut\.ac\.ir"))

for homepage in ${homepages[@]}; do
    IFS=$'\n'
    # Retrieve a professor's taught courses from their homepage.
    courses=($(curl -L -s "${homepage}" | \
        sed -n -E '/Taught Courses/,$ p' | \
        grep -E "Quantum" | \
        sed -E -e "s/^[^>]*//" -e "s/>//"  -e "s/>//" -e "s/<.*//"))

    # Sort courses.
    # Requires `IFS=$'\n'`.
    sorted_courses=($(sort <<< ${courses[@]}))
    unset IFS

    if [[ ${#sorted_courses[@]} -ne 0 ]]; then
        # Retrieve professor name from homepage address.
        professor_name=$(echo "${homepage}" | \
            rev | \
            cut -d "/" -f 1 | \
            rev | \
            sed -E -e "s/(%20|-)/ /g" -e "s/\?slc_lang//")

        echo ${professor_name}
        for course in ${sorted_courses[@]}; do
            echo ${course}
        done
        echo 
    fi
done

exit 0

