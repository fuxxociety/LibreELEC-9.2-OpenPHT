# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="emulationstation"
PKG_VERSION="d62758c"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/RetroPie/EmulationStation"
PKG_URL="https://github.com/RetroPie/EmulationStation.git"
PKG_DEPENDS_TARGET="toolchain SDL2 freetype curl freeimage es-theme-tronkyfran vlc rapidjson libcec"
PKG_SECTION="escalade"
PKG_SHORTDESC="Emulationstation emulator frontend"
GET_HANDLER_SUPPORT="git"
PKG_GIT_SUBMODULE_DEPTH="1"

if [ "$MEDIACENTER" = "kodi" ]; then
  PKG_PATCH_DIRS="kodi"
fi

if [ "$PROJECT" = "RPi" ]; then
  PKG_DEPENDS_TARGET+=" omxplayer"
fi

pre_configure_target() {
  export CFLAGS=`echo $CFLAGS | sed -e "s|-O.|-O3|g"`
  export CXXFLAGS=`echo $CFLAGS | sed -e "s|-O.|-O3|g"`
}

makeinstall_target() {  
  mkdir -p $INSTALL/usr/bin
  mkdir -p $INSTALL/etc/emulationstation
  mkdir -p $INSTALL/usr/config

  cp $PKG_DIR/scripts/*.sh $INSTALL/usr/bin
  if [ "$MEDIACENTER" = "kodi" ]; then
    cp $PKG_DIR/scripts/kodi/*.sh $INSTALL/usr/bin
  fi
  cp $PKG_DIR/config/emulationstation.conf $INSTALL/usr/config/
  cp $PKG_DIR/config/es_input.cfg $INSTALL/etc/emulationstation/
  cp $PKG_DIR/config/$ARCH/* $INSTALL/etc/emulationstation/
  cp -r ../resources $INSTALL/etc/emulationstation/

  cp ../emulationstation $INSTALL/usr/bin
}

post_install() {
  if [ "$PROJECT" = "OdroidXU3" ]; then
    oem_bigcores emulationstation.service
  fi
  if [ ! "$PROJECT" = "Generic" ]; then
    sed -i -e '/gamecube/d' -e '/wii/d' -e '/ps2/d' $INSTALL/usr/lib/tmpfiles.d/es_userdirs.conf
  fi
  enable_service es-firstrun.service
}
