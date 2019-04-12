# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="amiberry"
PKG_VERSION="99d1b64"
PKG_ARCH="arm"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/midwan/amiberry"
PKG_URL="https://github.com/midwan/amiberry.git"
PKG_DEPENDS_TARGET="toolchain alsa-lib freetype zlib SDL2 SDL2_ttf SDL2_image libpng flac mpg123 capsimg"
PKG_SECTION="escalade"
PKG_SHORTDESC="Amiga emulator optimized for Raspberry Pi"
GET_HANDLER_SUPPORT="git"
PKG_TOOLCHAIN="make"

configure_target() {
  cd $PKG_BUILD
  export SYSROOT_PREFIX
  case "$PROJECT" in
    OdroidXU3)
      PKG_MAKE_OPTS_TARGET+=" PLATFORM=xu4"
      ;;
    *)
      make
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  mkdir -p $INSTALL/usr/config/amiberry
  for dir in savestates screenshots kickstarts conf data whdboot; do
    cp -R $dir $INSTALL/usr/config/amiberry
  done
  ln -s /usr/lib/capsimg.so $INSTALL/usr/config/amiberry/
  cp amiberry* $INSTALL/usr/bin/amiberry
}
