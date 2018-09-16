#!/usr/bin/env bash

set -e

usage() { echo "Usage: $0 outputfile-from-the-serverload.sh-script" 1>&2; exit 1; }

if [[ $# -eq 0 ]]; then
	echo "Input file is missing." && usage && exit 1
fi

if [[ ! -e $1 ]]; then
	echo "$1 does not exist" && usage && exit 1
fi

# This is also very hacky. It checks if the syntax of the input file is correct
echo "Checking input file syntax"
head $1 | grep -E "[0-9]*\.[0-9]* [0-9]*\.[0-9]* [0-9]*\.[0-9]* [0-9]*/[0-9]* [0-9]*.[0-9]{2}\:[0-9]{2}.procs_blocked [0-9]*.[0-9]*.[0-9]*.[0-9]*.[0-9]*.[0-9]*.[0-9]*.[0-9]*.[0-9]*.[0-9]* [0-9]* [0-9]* [a-z]*[0-9]" 1>/dev/null
echo "It checks out"

echo "Running R script"
docker run --rm -ti -u $(id -u $USER):$(id -g $USER) \
-v /tmp:/tmp \
-v $(pwd):/script r-base Rscript /script/systemLoad.R $1
echo "All done"

