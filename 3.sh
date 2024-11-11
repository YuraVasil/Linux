#!/bin/bash

path=""
text=""

while getopts ":p:s:" opt; do
case ${opt} in
	p )
	path=$OPTARG
	;;
	s )
	text=$OPTARG
	;;
	\? )
	echo "Incorrect key: -$OPTARG" >&2
	exit 1
	;;
	: )
	echo "Key -$OPTARG needs argument." >&2
	exit 1
	;;
esac
done

if [ -z "$path" ] || [ -z "$text" ]; then
	echo "Using: $0 -p <path> -s <text>"
	exit 1
fi

grep -r "$text" "$path"
