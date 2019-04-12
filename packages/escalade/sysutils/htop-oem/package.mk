# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="htop-oem"
PKG_VERSION="5666bfd"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/avafinger/htop-2.1.1_enhanced-version"
PKG_URL="https://github.com/avafinger/htop-2.1.1_enhanced-version.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="Enhanced version of htop 2.1.0 to monitor the health of big.LITTLE arm core"
PKG_TOOLCHAIN="autotools"
GET_HANDLER_SUPPORT="git"

pre_patch() {
  mv $PKG_BUILD/htop/htop-2.1.1/* $PKG_BUILD/
  cd $PKG_BUILD
  rm -rf htop
}

PKG_CONFIGURE_OPTS_TARGET="--enable-cgroup \
			   --disable-vserver \
			   --disable-unicode \
			   --enable-proc \
			   --disable-hwloc \
			   --with-gnu-ld"

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/config
  cp -R $PKG_DIR/config/* $INSTALL/usr/config
}
