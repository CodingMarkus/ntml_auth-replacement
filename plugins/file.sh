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


[ $# -eq 1 ] || error "File plugin requires one argument: Password file path!"
[ -n "${NTLM_AUTH_PLUGIN_USER:=}" ] || error "NTLM_AUTH_PLUGIN_USER not set!"

user=${NTLM_AUTH_PLUGIN_USER}


readHexBytes( )
{
	od -An -tx1 | tr -d ' \n' | tr '[:lower:]' '[:upper:]'
}


pipeHashMD4( )
{
	openssl dgst -md4 -binary
}


hash( )
{
	printf '%s' "$1" |  iconv -t UTF-16LE | pipeHashMD4 | readHexBytes
}


password=$( grep "^${user}:" "$1" | head -n1 | sed "s/^${user}:\(.*\)\$/\\1/" )
[ -n "$password" ] || error "User \"$user\" not found in password file \"$1\"!"

printf '%s\n' "$( hash "$password" )"