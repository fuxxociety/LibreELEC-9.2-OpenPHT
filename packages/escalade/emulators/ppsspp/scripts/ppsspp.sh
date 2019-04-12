#!/bin/sh

. /etc/profile

emu_start

$PASUSPENDER PPSSPPSDL "$@" > /var/log/ppsspp.log 2>&1

emu_stop
