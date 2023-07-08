# ntml_auth Replacement

## Description

A shell script that works as a drop-in replacement for `ntml_auth` when used for MSCHAP v2 authentication, so no full Samba installation is required in many situations; at least if the correct plugin exists. The task of plugin is to fetch the plain-text user password or the pre-calculated MD4 user password hash (also known as NTHASH or sambaNTHash or just NTML password).


## Usage

The script behaves like the original `ntml_auth` when called with the argument `--request-nt-key`. The following arguments are supported and expected to be present:

* `--username`
* `--challenge`
* `--nt-response`

Documentation of the original tool: [ntml_auth](https://www.samba.org/samba/docs/current/man-html/ntlm_auth.1.html)

It also allows the argument `--allow-mschapv2` but simply ignores it as the script always operates in MSCHAP v2 mode

The following two new parameters were added:

* `--plugin`: Which plugin to use (relative or absolute path to plugin).
* `--plugin-args`: Which arguments to pass to the plugin (separated by space; quoting is possible).

Note that the last two arguments can also be set via the environment variables `NTLM_AUTH_PLUGIN` and `NTLM_AUTH_PLUGIN_ARGS` instead; arguments override environment variables if both are set.


## Requirements

The only requirement aside from a [POSIX shell environment](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/toc.html) is [OpenSSL](https://www.openssl.org/) to perform the cryptographic operations.

Note that plugins may have requirements of their own but those are only relevant if that plugin is in use.
