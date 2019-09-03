# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="dolphin-libretro"
PKG_VERSION="11a7ed4"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/dolphin"
PKG_URL="https://github.com/aliaspider/dolphin/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Dolphin Wii/Gamecube emulator - libretro port"
PKG_BUILD_FLAGS="+lto-parallel"

PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=1"

pre_configure_target() {
  export CFLAGS=`echo $CFLAGS | sed -e "s|-O.|-O3|g"`
  export CXXFLAGS=`echo $CFLAGS | sed -e "s|-O.|-O3|g"`
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/retroarch/cores
  mv *.so $INSTALL/usr/share/retroarch/cores/
  mkdir -p $INSTALL/usr/share/dolphin-emu
  cp -a ../Data/Sys $INSTALL/usr/share/dolphin-emu/
}
