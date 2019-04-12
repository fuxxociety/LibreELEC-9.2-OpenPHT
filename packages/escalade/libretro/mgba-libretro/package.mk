# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="mgba-libretro"
PKG_VERSION="8d0bf2a"
PKG_ARCH="any"
PKG_LICENSE="MPLv2.0"
PKG_SITE="https://github.com/libretro/mgba"
PKG_URL="https://github.com/libretro/mgba/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="mgba-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="mGBA Game Boy Advance Emulator"
PKG_TOOLCHAIN="make"

configure_target() {
  cd $PKG_BUILD
  export GIT_VERSION=$PKG_VERSION
}

make_target() {
  case $PROJECT in
    OdroidXU3|RPi)
      make platform=armv HAVE_NEON=1
      ;;
    Generic)
      make
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp mgba_libretro.so $INSTALL/usr/lib/libretro/
}
