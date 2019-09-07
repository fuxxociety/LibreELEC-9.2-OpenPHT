# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="parallel-n64-libretro"
PKG_VERSION="017d864"
PKG_SHA256=""
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/parallel-n64"
PKG_URL="https://github.com/libretro/parallel-n64/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="parallel-n64-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="mupen64plus for libretro with multiple graphic plugins and vulkan support"
PKG_BUILD_FLAGS=""

configure_target() {
  export GIT_VERSION=$PKG_VERSION
}

make_target() {
  case $PROJECT in
    RPi)
      make HAVE_PARALLEL=0 platform=rpi2
      ;;
    OdroidXU3)
      make HAVE_PARALLEL=0 platform=odroid BOARD=ODROID-XU4
      ;;
    Generic)
      make WITH_DYNAREC=$TARGET_ARCH HAVE_PARALLEL=1
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/retroarch/cores
  cp *.so $INSTALL/usr/share/retroarch/cores/
}
