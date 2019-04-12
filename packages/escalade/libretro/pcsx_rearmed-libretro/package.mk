# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="pcsx_rearmed-libretro"
PKG_VERSION="da17206"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/pcsx_rearmed"
PKG_URL="https://github.com/libretro/pcsx_rearmed/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="pcsx_rearmed-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="ARM optimized PCSX fork"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="-gold"

configure_target() {
  cd $PKG_BUILD
}

make_target() {
  case $PROJECT in
    RPi)
      make -f Makefile.libretro platform=rpi2 GIT_VERSION=$PKG_VERSION
      ;;
    OdroidXU3)
      make -f Makefile.libretro platform=armv7-neon GIT_VERSION=$PKG_VERSION
      ;;
    *)
      make -f Makefile.libretro GIT_VERSION=$PKG_VERSION
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp pcsx_rearmed_libretro.so $INSTALL/usr/lib/libretro/
}
