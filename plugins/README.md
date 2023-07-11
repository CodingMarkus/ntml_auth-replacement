# Plugins

## file.sh

Input arguments:
- (Absolute/Relative) Path to password file

Expects input file of the following format:

```
username1:password1
username2:password2
username3:password3
:
```

First colon separates username from password, so username must not contain a colon. 
Spaces are allowed at begining/end of username and passord. 
Line is terminated by newline, so passwords cannot contain a newline character.


## hashfile.sh

Input arguments:
- (Absolute/Relative) Path to hash password file

Expects input file of the following format:

```
username1:hash1
username2:hash2
username3:hash3
:
```

First colon separates username from password hash, so username must not contain a colon. 
Spaces are allowed at begining/end of username. Line is terminated by newline.
Password hash it he hexadecimal NT hash (MD4 of password with UTF16-LE encoding).
