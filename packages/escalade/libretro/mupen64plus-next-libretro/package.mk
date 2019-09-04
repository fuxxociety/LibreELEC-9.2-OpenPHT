# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="mupen64plus-next-libretro"
PKG_VERSION="16baae7"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mupen64plus-libretro-nx"
PKG_URL="https://github.com/libretro/mupen64plus-libretro-nx/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain nasm:host"
PKG_SECTION="escalade"
PKG_SHORTDESC="mupen64plus + RSP-HLE + GLideN64 + libretro"
PKG_TOOLCHAIN="manual"

if [ "$ARCH" = "arm" ]; then
  PKG_BUILD_FLAGS="+lto-parallel"
else
  PKG_BUILD_FLAGS="-lto"
fi

configure_target() {
  cd $PKG_BUILD
}

make_target() {
  case $PROJECT in
    RPi)
      make platform=rpi2
      ;;
    Generic)
      make
      ;;
    OdroidXU3)
      make platform=odroid BOARD=ODROID-XU4
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/retroarch/cores
  cp *.so $INSTALL/usr/share/retroarch/cores/
}
