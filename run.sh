#!/bin/sh

# $1 - The slug of the exercise (e.g. two-fer).
# $2 - A path to an input directory containing the submitted solution file(s) and the necessary test file(s) (with a trailing slash).
# $3 - A path to an output directory (with a trailing slash).

file=$(echo "$1" | sed 's/-/_/')
cd "$2" || exit
sed -i 's#TEST_IGNORE();#// &#' "${file}"_test.c
make clean
make
