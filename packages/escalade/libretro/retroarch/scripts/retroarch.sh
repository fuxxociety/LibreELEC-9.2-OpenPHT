#!/bin/sh

. /etc/profile

emu_start

if [ "$M3U" = "1" ]; then
  if file --mime-type "$2" | grep -q zip$; then
    mkdir -p /tmp/.retroarch
    unzip -j -q -d /tmp/.retroarch "$2"
    for file in /tmp/.retroarch/*; do echo $file >> /tmp/.retroarch/rom.m3u; done
  else
    echo "M3U=1 is set but filename is not a .zip file"
    M3U=0
  fi
fi

CONFIG=/storage/.config/retroarch/retroarch.cfg

if [ "$SDL_AUDIODRIVER" = "alsa" ]; then
   sed -i 's/^audio_driver = "pulse"/audio_driver = "alsathread"/' $CONFIG
elif [ "$SDL_AUDIODRIVER" = "pulseaudio" ]; then
   sed -i 's/^audio_driver = "alsa.*/audio_driver = "pulse"/' $CONFIG
fi


if [ "$M3U" = "1" ]; then
  $PASUSPENDER /usr/bin/retroarch -v -L $1 /tmp/.retroarch/rom.m3u > /var/log/retroarch.log 2>&1
  rm -rf /tmp/.retroarch
else
  $PASUSPENDER /usr/bin/retroarch -v -L $1 "$2" > /var/log/retroarch.log 2>&1
  rm -rf /tmp/.retroarch
fi

emu_stop
