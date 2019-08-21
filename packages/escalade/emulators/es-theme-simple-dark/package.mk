# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="es-theme-simple-dark"
PKG_VERSION="7171c72"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/RetroPie/es-theme-simple-dark"
PKG_URL="https://github.com/RetroPie/es-theme-simple-dark/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="Simple theme for Emulationstation"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/etc/emulationstation/themes/es-theme-simple-dark
  cp -r * $INSTALL/etc/emulationstation/themes/es-theme-simple-dark
}
