# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="nestopia-libretro"
PKG_VERSION="44800c5"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/nestopia"
PKG_URL="https://github.com/libretro/nestopia/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="nestopia-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="Libretro implementation of NEStopia. (Nintendo Entertainment System)"
PKG_TOOLCHAIN="make"

pre_configure_target() {
  cd $PKG_BUILD
}

make_target() {
  make -C libretro
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/retroarch/cores
  cp libretro/nestopia_libretro.so $INSTALL/usr/share/retroarch/cores/
}
