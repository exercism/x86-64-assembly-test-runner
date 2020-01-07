#!/bin/sh

# $1 - The slug of the exercise (e.g. two-fer).
# $2 - A path to an input directory containing the submitted solution file(s) and the necessary test file(s) (with a trailing slash).
# $3 - A path to an output directory (with a trailing slash).

cwd=$(pwd)
test_file=$(echo "$1" | sed 's/-/_/')_test.c
cp debug.asm "$2"
cd "$2" || exit
sed -i 's#TEST_IGNORE();#// &#' "${test_file}"
make clean
stdbuf -oL make > "$3"results.out 2>&1
python3 "${cwd}"/process_results.py "$3"results.out
