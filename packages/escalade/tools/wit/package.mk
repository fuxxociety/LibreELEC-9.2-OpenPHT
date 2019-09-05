# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="wit"
PKG_VERSION="18aa486"
PKG_SHA256="482537957071087f2733f07602f00ebed6bef8bde037ef9fc4c29ac8f1aab0f0"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/OldRepoPreservation/wiimms-iso-tools"
PKG_URL="https://github.com/OldRepoPreservation/wiimms-iso-tools/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_LONGDESC="Wiimms ISO Tools"
PKG_TOOLCHAIN="make"

make_target() {
  make INSTALL_PATH=$INSTALL/usr tools
}
