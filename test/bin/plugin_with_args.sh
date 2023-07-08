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

[ $# -eq 0 ] && error "Plugnin requires arguments!"
[ $# -ne 2 ] && error "Wrong number of plugin arguments!"
[ "$1" = 'print' ] && printf '%s' "$2"
