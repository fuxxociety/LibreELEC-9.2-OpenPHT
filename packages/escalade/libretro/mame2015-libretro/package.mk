# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="mame2015-libretro"
PKG_VERSION="80a2e82"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2015-libretro"
PKG_URL="https://github.com/libretro/mame2015-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="libretro"
PKG_SHORTDESC="Late 2014/early 2015 version of MAME (0.160-ish) for libretro and MAME 0.160 romsets"

pre_make_target() {
  export REALCC=$CC
  export CC=$CXX
  export LD=$CXX
  export GIT_VERSION=$PKG_VERSION
}

make_target() {
  case $PROJECT in
    OdroidXU3|RPi)
      make platform=armv7-neon-hardfloat-cortex-a7
      ;;
    Generic)
      make
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp mame2015_libretro.so $INSTALL/usr/lib/libretro/
}
