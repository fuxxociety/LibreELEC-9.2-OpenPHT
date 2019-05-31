# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="libretro-core-info"
PKG_VERSION="eef4add"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-core-info"
PKG_URL="https://github.com/libretro/libretro-core-info/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="Info files for libretro cores"
PKG_TOOLCHAIN="manual"

make_target() {
  sed -i s/bin\|/bin\|iso\|/ ../pcsx_rearmed*info
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp ../*.info $INSTALL/usr/lib/libretro/
}
