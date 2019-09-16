# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="pkgrip"
PKG_VERSION="a3ff06d"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/qwikrazor87/pkgrip"
PKG_URL="https://github.com/qwikrazor87/pkgrip/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="Fast linux alternative for decrypting PS3/PSP pkgs"
PKG_TOOLCHAIN="make"

make_target() {
  make -C src CC=$CC libkirk/libkirk.a
  make -C src CC=$CC
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp src/pkgrip $INSTALL/usr/bin/
}
