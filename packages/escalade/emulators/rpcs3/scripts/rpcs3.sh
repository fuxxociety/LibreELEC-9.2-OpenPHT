#!/bin/sh

. /etc/profile

KMS=0

emu_start

rpcs3 "$@" > /var/log/rpcs3.log 2>&1

emu_stop
