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

[ $# -eq 0 ] || error "Plugnin should not receive arguments!"
[ -n "${NTLM_AUTH_PLUGIN_USER:=}" ] || error "NTLM_AUTH_PLUGIN_USER not set!"


printf '%s' '44EBBA8D5312B8D611474411F56989AE'
