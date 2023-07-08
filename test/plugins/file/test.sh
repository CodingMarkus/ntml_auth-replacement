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


export NTLM_AUTH_PLUGIN=../../../plugins/file.sh
export NTLM_AUTH_PLUGIN_ARGS=passwords.txt

result=$( ../../../bin/ntlm_auth                                   \
	--request-nt-key --username=User --challenge=D02E4386BCE91226  \
	--nt-response=82309ECD8D708B5EA08FAA3981CD83544233114A3D85D6DF )

assert "$result" = "$expectedOutput"
