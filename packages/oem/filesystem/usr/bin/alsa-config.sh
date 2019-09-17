#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

# Get card and device number from PulseAudio's default sink
CARD=`pactl list sinks | grep "alsa.card =" | head -n 1 | cut -d \" -f 2`
DEVICE=`pactl list sinks | grep "alsa.device =" | head -n 1 | cut -d \" -f 2`

# Create dmix configuration
cat <<EOF > /storage/.config/asound.conf.dmix
defaults.pcm.!card $CARD
defaults.ctl.!card $CARD
defaults.pcm.!device $DEVICE
defaults.ctl.!device $DEVICE
EOF

# Create direct hardware configuration
cat <<EOF > /storage/.config/asound.conf.hw
pcm.!default {
  type hw
  card $CARD
  device $DEVICE
}
ctl.!default {
  type hw
  card $CARD
  device $DEVICE
}
EOF

test -f /storage/.config/asound.conf || ln -s /storage/.config/asound.conf.hw /storage/.config/asound.conf
