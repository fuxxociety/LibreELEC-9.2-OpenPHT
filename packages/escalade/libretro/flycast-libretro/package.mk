# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="flycast-libretro"
PKG_VERSION="198d578"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/flycast"
PKG_URL="https://github.com/libretro/flycast/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="Flycast is a multiplatform Sega Dreamcast emulator"
PKG_TOOLCHAIN="make"

configure_target() {
  PKG_MAKE_OPTS_TARGET="CC_AS=$CC GIT_VERSION=$PKG_VERSION"

  case $PROJECT in
    RPi)
      PKG_MAKE_OPTS_TARGET+=" WITH_DYNAREC=$TARGET_ARCH platform=rpi2"
      ;;
    OdroidXU3)
      PKG_MAKE_OPTS_TARGET+=" WITH_DYNAREC=$TARGET_ARCH platform=odroid BOARD=ODROID-XU4"
      ;;
    Generic)
      PKG_MAKE_OPTS_TARGET=" WITH_DYNAREC=$TARGET_ARCH HAVE_OIT=1"
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/retroarch/cores
  cp *.so $INSTALL/usr/share/retroarch/cores/flycast_libretro.so
}
