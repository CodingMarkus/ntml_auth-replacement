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


# Verify correct hash result

result=$( ../../bin/ntlm_auth --plugin=./plugin.sh                 \
	--request-nt-key --username=User --challenge=D02E4386BCE91226  \
	--nt-response=82309ECD8D708B5EA08FAA3981CD83544233114A3D85D6DF )

assert "$result" = "$expectedOutput"



# Verify plugin can be set by environment variable

export NTLM_AUTH_PLUGIN=./plugin.sh

result=$( ../../bin/ntlm_auth                                      \
	--request-nt-key --username=User --challenge=D02E4386BCE91226  \
	--nt-response=82309ECD8D708B5EA08FAA3981CD83544233114A3D85D6DF )

assert "$result" = "$expectedOutput"



# Verify there is no output on stderr

stderrOut=$( ../../bin/ntlm_auth                                   \
	--request-nt-key --username=User --challenge=D02E4386BCE91226  \
	--nt-response=82309ECD8D708B5EA08FAA3981CD83544233114A3D85D6DF \
	>/dev/null 2>&1 )

assert -z "$stderrOut"



# Verify that we can pass arguments to plugins

unset NTLM_AUTH_PLUGIN

result=$( ../../bin/ntlm_auth --plugin=./plugin_with_args.sh       \
	--plugin-args='print 44EBBA8D5312B8D611474411F56989AE'         \
	--request-nt-key --username=User --challenge=D02E4386BCE91226  \
	--nt-response=82309ECD8D708B5EA08FAA3981CD83544233114A3D85D6DF )

assert "$result" = "$expectedOutput"


# Verify that we can pass arguments via environment

export NTLM_AUTH_PLUGIN=./plugin_with_args.sh
export NTLM_AUTH_PLUGIN_ARGS="print 44EBBA8D5312B8D611474411F56989AE"

result=$( ../../bin/ntlm_auth                                      \
	--request-nt-key --username=User --challenge=D02E4386BCE91226  \
	--nt-response=82309ECD8D708B5EA08FAA3981CD83544233114A3D85D6DF )

assert "$result" = "$expectedOutput"
