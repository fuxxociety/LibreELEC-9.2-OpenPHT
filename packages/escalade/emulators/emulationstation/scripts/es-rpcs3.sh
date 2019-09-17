#!/bin/sh

systemctl stop emulationstation
rpcs3.sh
systemctl start emulationstation
