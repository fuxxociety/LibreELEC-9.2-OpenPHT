# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="connman-json-client"
PKG_VERSION="3c34b2e"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/eurogiciel-oss/connman-json-client"
PKG_URL="https://github.com/eurogiciel-oss/connman-json-client/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses json-c-oem"
PKG_SECTION="escalade"
PKG_LONGDESC="A ncurses UI for connman"
PKG_TOOLCHAIN="autotools"

pre_configure_target() {
  sed -i -e 's/-Werror//' ../Makefile.in
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp connman_ncurses $INSTALL/usr/bin
}
