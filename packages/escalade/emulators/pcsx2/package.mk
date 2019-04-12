# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="pcsx2"
PKG_VERSION="1.0"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://pcsx2.net"
PKG_SECTION="escalade"
PKG_SHORTDESC="Playstation 2 emulator"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  mkdir -p $INSTALL/usr/config
  cp -r $PKG_DIR/config $INSTALL/usr/config/PCSX2
  cp $PKG_DIR/scripts/* $INSTALL/usr/bin/
}
