#!/bin/sh

. /etc/profile

emu_start

dosbox "$@" > /var/log/dosbox.log 2>&1

emu_stop
