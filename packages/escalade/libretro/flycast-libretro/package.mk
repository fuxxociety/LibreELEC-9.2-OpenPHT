# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="flycast-libretro"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/flycast"
PKG_URL="https://github.com/libretro/flycast/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="Flycast is a multiplatform Sega Dreamcast emulator"
PKG_TOOLCHAIN="manual"

if [ "$PROJECT" = "Generic" ]; then
  PKG_VERSION="33c2ce0" # WinCE / MMU
else
  PKG_VERSION="6baf827"
fi

make_target() {
  case $PROJECT in
    RPi)
      make GIT_VERSION=$PKG_VERSION WITH_DYNAREC=$ARCH platform=rpi2
      ;;
    OdroidXU3)
      make GIT_VERSION=$PKG_VERSION WITH_DYNAREC=$ARCH platform=odroid BOARD=ODROID-XU4
      ;;
    Generic)
      make GIT_VERSION=$PKG_VERSION WITH_DYNAREC=$ARCH HAVE_OIT=1
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp *.so $INSTALL/usr/lib/libretro/flycast_libretro.so
}
