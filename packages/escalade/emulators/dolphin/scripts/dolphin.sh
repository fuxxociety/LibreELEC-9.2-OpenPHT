#!/bin/sh

. /etc/profile

KMS=0

emu_start

$PASUSPENDER dolphin-emu "$@"> /var/log/dolphin.log 2>&1

emu_stop
