# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="mame2010-libretro"
PKG_VERSION="c66718f"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2010-libretro"
PKG_URL="https://github.com/libretro/mame2010-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="Late 2010 version of MAME (0.139) for libretro and MAME 0.139 romsets"

pre_make_target() {
  export CFLAGS="$CFLAGS -fpermissive"
  export CXXFLAGS="$CXXFLAGS -fpermissive"
  export LD="$CXX"
}

make_target() {
  case $PROJECT in
    RPi)
      make platform=armv7-neon-hardfloat-cortex-a7
      ;;
    OdroidXU3)
      make platform=armv7-neon-hardfloat-cortex-a9
      ;;
    Generic)
      make
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/retroarch/cores
  cp mame2010_libretro.so $INSTALL/usr/share/retroarch/cores/
}
