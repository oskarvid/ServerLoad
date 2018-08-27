#!/usr/bin/env bash
if [[ $# -eq 0 ]]; then
	echo "Input file is missing." && exit 1
fi

if [[ ! -e $1 ]]; then
	echo "$1 does not exist" && exit 1
fi

docker run --rm -ti -u $(id -u $USER):$(id -g $USER) -v $(pwd):/data r-base Rscript /data/systemLoad.R /data/$1

