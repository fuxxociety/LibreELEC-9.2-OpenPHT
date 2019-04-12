#!/bin/sh

. /etc/profile

if ! docker images | grep arch-pcsx2 > /dev/null; then 
  docker pull escalade1/arch-pcsx2
fi

emu_start

if [ "$SDL_AUDIODRIVER" = "alsa" -o "$ALSA" = "1"]; then
  sed -i "s/^HostApi=pulseaudio/HostApi=alsa/" /storage/.config/PCSX2/inis/spu2-x.ini
else
  sed -i "s/^HostApi=alsa/HostApi=pulseaudio/" /storage/.config/PCSX2/inis/spu2-x.ini
fi

DOCKER_ARGS=" \
  --rm \
  --name arch-pcsx2 \
  --privileged \
  -i \
  -e DISPLAY=:0.0 \
  -e SDL_AUDIODRIVER=$SDL_AUDIODRIVER \
  -e PULSE_RUNTIME_PATH=$PULSE_RUNTIME_PATH \
  -v /dev/shm:/dev/shm \
  -v /var/media:/media \
  -v /var/run/localtime:/etc/localtime
  -v /run:/run \
  -v /storage:/storage \
  -v /storage/.config/asound.conf:/etc/asound.conf \
  -v /storage/.config/PCSX2:/root/.config/PCSX2 \
  -v /storage/roms/bios:/root/.config/PCSX2/bios \
  -v /tmp/.X11-unix:/tmp/.X11-unix"

$PASUSPENDER docker run $DOCKER_ARGS escalade1/arch-pcsx2 /usr/bin/PCSX2 "$@" > /var/log/pcsx2.log 2>&1

emu_stop
