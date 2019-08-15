# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="glsl-shaders"
PKG_VERSION="16a545b"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/glsl-shaders"
PKG_URL="https://github.com/libretro/glsl-shaders/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="Common GSLS shaders for RetroArch"
PKG_TOOLCHAIN="manual"

configure_target() {
  cd $PKG_BUILD
}

makeinstall_target() {
  make install INSTALLDIR="$INSTALL/usr/share/retroarch/shaders"
}
