# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="antimicro"
PKG_VERSION="2.24.2"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/juliagoda/antimicro"
PKG_URL="https://github.com/juliagoda/antimicro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain SDL2 qt-everywhere extra-cmake-modules libXext itstool:host"
PKG_SECTION="escalade"
PKG_SHORTDESC="Graphical program used to map keyboard buttons and mouse controls to a gamepad."
PKG_BUILD_FLAGS="-lto +size"

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/config/antimicro
  cp $PKG_DIR/config/* $INSTALL/usr/config/antimicro/
}

post_install() {
  enable_service antimicro.service
}
