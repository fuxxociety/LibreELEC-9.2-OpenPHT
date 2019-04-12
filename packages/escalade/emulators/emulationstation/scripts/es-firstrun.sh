#!/bin/sh

# Create an example rom in the first directory so that ES starts
touch `cat /usr/lib/tmpfiles.d/es_userdirs.conf | cut -d \  -f 2 | head -n 1`/example.zip

# Don't run this script again
touch /storage/.cache/.es-firstrun
