# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="slang-shaders"
PKG_VERSION="c8c3957"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/slang-shaders"
PKG_URL="https://github.com/libretro/slang-shaders/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_LONGDESC="Common slang shaders for RetroArch"
PKG_TOOLCHAIN="manual"

make_target() {
  cd ..
  make install INSTALLDIR="$INSTALL/usr/share/retroarch/shaders"
}
