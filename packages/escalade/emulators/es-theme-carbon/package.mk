# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="es-theme-carbon"
PKG_VERSION="3741345"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/RetroPie/es-theme-carbon"
PKG_URL="https://github.com/RetroPie/es-theme-carbon/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="Simple dark theme for Emulationstation"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/etc/emulationstation/themes/es-theme-carbon
  cp -r * $INSTALL/etc/emulationstation/themes/es-theme-carbon
}
