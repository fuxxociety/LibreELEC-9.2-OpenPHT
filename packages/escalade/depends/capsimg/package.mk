# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="capsimg"
PKG_VERSION="067db4c"
PKG_SHA256="0576a49a23c70b0022d423d8ae4691c8d7004ceed1527b971f2eba0fc799c0af"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/FrodeSolheim/capsimg"
PKG_URL="https://github.com/FrodeSolheim/capsimg/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_LONGDESC="SPS Decoder Library 5.1"
PKG_TOOLCHAIN="autotools"

pre_configure_target() {
  cd $PKG_BUILD
  ./bootstrap
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib
  cp capsimg.so $INSTALL/usr/lib/
}
