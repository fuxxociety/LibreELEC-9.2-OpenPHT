#!/bin/sh

. /storage/.config/plex.conf

LD_LIBRARY_PATH=/usr/lib

curl -s -L https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=plex-media-server | grep -E '^pkgver|^_pkgsum' > /tmp/.plex_version || PLEX_BADURL=1
if [ -z "$PLEX_BADURL" ]; then
  . /tmp/.plex_version
  PLEX_VERSION=$pkgver-$_pkgsum
else
  PLEX_VERSION=NA
fi
rm -f /tmp/.plex_version

install_plex() {
  mkdir -p /tmp/runplex ; cd /tmp/runplex
  case `uname -m` in
    x86_64)
      wget -q https://downloads.plex.tv/plex-media-server-new/$1/redhat/plexmediaserver-$1.x86_64.rpm || exit 1
      rpm2cpio plexmediaserver-$1.x86_64.rpm | cpio -di 2>/dev/null
      ;;
    armv7l)
      wget -q https://downloads.plex.tv/plex-media-server-new/$1/debian/plexmediaserver_$1_armhf.deb || exit 1
      ar -x *.deb
      tar xf data.tar.*
      ;;
  esac
  mv usr/lib/plexmediaserver $PLEX_MEDIA_SERVER_HOME
  echo $PLEX_VERSION > $PLEX_MEDIA_SERVER_HOME/.plex_version
  cd ~ ; rm -rf /tmp/runplex
}

if [ ! -x $PLEX_MEDIA_SERVER_HOME ]; then
  echo "Plex directory does not exist, installing."
  install_plex $PLEX_VERSION
fi

if [ -f $PLEX_MEDIA_SERVER_HOME/.plex_version ]; then
  LOCAL_VERSION=`cat $PLEX_MEDIA_SERVER_HOME/.plex_version`
fi

if [ ! $PLEX_VERSION = $LOCAL_VERSION ] && [ ! $PLEX_VERSION = NA ]; then
  echo "New version found, updating."
  mv $PLEX_MEDIA_SERVER_HOME $PLEX_MEDIA_SERVER_HOME.bak
  install_plex $PLEX_VERSION
else
  echo "Plex up to date."
fi

