#!/bin/bash

### This script ensures that the lab support files are generated successfully.
# Usage: ./check-lab-solution.sh

REPO_ROOT=$(git rev-parse --show-toplevel)
fails=()

MAKEFILES=$(grep -rl "skels:" $(find $REPO_ROOT -name Makefile))
for makefile in $MAKEFILES; do
    make -C $(dirname $makefile) skels 2>&1 >/dev/null
    if [ $? -ne 0 ]; then
        fails+=($makefile)
    fi
done

if [ ${#fails[@]} -ne 0 ]; then
    echo "The following Makefiles failed to generate the lab support files:"
    for fail in ${fails[@]}; do
        echo "  $fail"
    done
    exit 1
fi

echo "All lab support files generated successfully."
