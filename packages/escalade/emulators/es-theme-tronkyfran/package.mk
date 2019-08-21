# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="es-theme-tronkyfran"
PKG_VERSION="cff0721"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/HerbFargus/es-theme-tronkyfran"
PKG_URL="https://github.com/HerbFargus/es-theme-tronkyfran/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="Tronkyfran theme for Emulationstation"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/etc/emulationstation/themes/es-theme-tronkyfran
  cp -r * $INSTALL/etc/emulationstation/themes/es-theme-tronkyfran
}
