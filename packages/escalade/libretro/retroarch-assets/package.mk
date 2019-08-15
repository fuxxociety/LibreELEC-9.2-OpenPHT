# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="retroarch-assets"
PKG_VERSION="8d60910"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/retroarch-assets"
PKG_URL="https://github.com/libretro/retroarch-assets/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="RetroArch assets"
PKG_LONGDESC="RetroArch assets. Background and icon themes for the menu drivers."

configure_target() {
  cd $PKG_BUILD
}

makeinstall_target() {
  make install INSTALLDIR="$INSTALL/usr/share/retroarch/assets"
}
