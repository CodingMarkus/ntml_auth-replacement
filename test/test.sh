#!/bin/sh

set -eu

error( )
{
	( printf "ERROR: %s" "$1" \
		| tr '\n' ' '         \
		| sed 's/^ *//'       \
		| sed 's/ *$//' ) >&2
	printf '\n' >&2
	exit 1
}


for testDir in bin plugins/*
do
	case $testDir in *'*'*) continue; esac
	(
		cd "$testDir"
		"./test.sh" || error "Test \"$testDir\" failed!"
		printf '%s: OK\n' "$testDir"
	)
done