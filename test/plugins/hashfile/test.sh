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


assert( )
{
	test "$@" || error "Assertion failed: $*"
}


readonly expectedOutput='NT_KEY: 41C00C584BD2D91C4017A2A12FA59F3F'
