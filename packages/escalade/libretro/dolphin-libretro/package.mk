# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="dolphin-libretro"
PKG_VERSION="1d973f4"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/dolphin"
PKG_URL="https://github.com/aliaspider/dolphin/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Dolphin Wii/Gamecube emulator - libretro port"

PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=1 \
		       -DCMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES=$SYSROOT_PREFIX/usr/include \
		       -DCMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES=$SYSROOT_PREFIX/usr/include"

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  mv *.so $INSTALL/usr/lib/libretro/
  mkdir -p $INSTALL/usr/config/retroarch/downloads/Dolphin
  cp -a ../Data/Sys $INSTALL/usr/config/retroarch/downloads/Dolphin/
}
