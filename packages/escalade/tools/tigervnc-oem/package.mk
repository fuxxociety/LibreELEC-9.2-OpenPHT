# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="tigervnc-oem"
PKG_VERSION="1.7.0"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="http://www.tigervnc.org"
PKG_URL="https://github.com/TigerVNC/tigervnc/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain cmake:host libX11 libXdamage libXext libXtst zlib libjpeg-turbo"
PKG_SECTION="escalade"
PKG_SHORTDESC="TigerVNC server"

PKG_CMAKE_OPTS_TARGET="-DBUILD_VIEWER=off -Wno-dev"

post_makeinstall_target() {
  rm $INSTALL/usr/bin/vncserver
  rm $INSTALL/usr/bin/vncconfig
  mkdir -p $INSTALL/usr/config
  cp $PKG_DIR/files/vncpasswd $INSTALL/usr/config/
  mkdir -p $INSTALL/usr/lib/systemd/system
  cp $PKG_DIR/system.d/tigervnc-oem.service $INSTALL/usr/lib/systemd/system
}
