#!/bin/sh

. /etc/profile

KMS=0

emu_start

dolphin-emu-nogui "$@"> /var/log/dolphin.log 2>&1

emu_stop
