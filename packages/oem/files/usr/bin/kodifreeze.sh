#!/bin/sh

# Script to suspend/resume audio and freeze/unfreeze the Kodi process

kodi_freeze() {
  kodi-send --action="RunScript(/usr/bin/audio-suspend.py)"
  usleep 500000
  if [ ! "$1" = "muteonly" ]; then
    systemctl stop kodi &
  fi
}

kodi_unfreeze() {
  if [ ! "$1" = "muteonly" ]; then
    kodi-send --action="RunScript(/usr/bin/audio-resume.py)"
  else
    systemctl start kodi
  fi
}

case $1 in
  freeze)
    if [ ! -f /tmp/.kodifreeze ]; then
      pidof kodi.bin > /dev/null && KODI=1
      if [ "$KODI" = "1" ]; then
        kodi_freeze $2
        touch /tmp/.kodifreeze
      else
        echo "Kodi isn't running, nothing to do."
      fi
    else
      echo "Kodi already frozen, nothing to do."
    fi
    ;;
  unfreeze)
    if [ -f /tmp/.kodifreeze ]; then
      kodi_unfreeze $2
      rm /tmp/.kodifreeze
    else
      echo "Kodi isn't frozen, nothing to do."
    fi
    ;;
  *)
    echo "Usage: $0 [freeze|unfreeze] [muteonly]"
    ;;
esac
