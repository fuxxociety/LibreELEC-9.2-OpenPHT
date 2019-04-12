# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="desmume-libretro"
PKG_VERSION="b2da53a"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/desmume"
PKG_URL="https://github.com/libretro/desmume/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="desmume-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain libpcap"
PKG_SECTION="escalade"
PKG_SHORTDESC="libretro wrapper for desmume NDS emulator."
PKG_TOOLCHAIN="make"

make_target() {
  cd $PKG_BUILD
  if [ "$ARCH" = "arm" ]; then
    make -C desmume/src/frontend/libretro platform=unix-armv GIT_VERSION=$PKG_VERSION
  else
    make -C desmume/src/frontend/libretro GIT_VERSION=$PKG_VERSION
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp desmume/src/frontend/libretro/desmume_libretro.so $INSTALL/usr/lib/libretro/
}
