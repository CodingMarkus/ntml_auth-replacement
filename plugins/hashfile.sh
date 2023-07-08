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


password=$( grep "^${user}:" "$1" | head -n1 | sed "s/^${user}:\(.*\)\$/\\1/" )
[ -n "$password" ] || error "User \"$user\" not found in password file \"$1\"!"

printf '%s\n' "$password" | tr '[:lower:]' '[:upper:]'