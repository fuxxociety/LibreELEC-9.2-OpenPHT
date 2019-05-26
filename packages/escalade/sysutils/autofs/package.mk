# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="autofs"
PKG_VERSION="5.1.5"
PKG_ARCH="any"
PKG_LICENSE="GPL2"
PKG_SITE="https://www.kernel.org/pub/linux/daemons/autofs/"
PKG_URL="https://mirrors.edge.kernel.org/pub/linux/daemons/autofs/v5/autofs-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain nfs-utils"
PKG_SECTION="escalade"
PKG_SHORTDESC="A kernel-based automounter for Linux"

PKG_CONFIGURE_OPTS_TARGET="--without-hesiod \
			   --enable-ignore-busy \
			   --with-libtirpc \
			   --sysconfdir=/storage/.config/autofs \
			   --with-mapdir=/storage/.config/autofs \
			   --with-confdir=/storage/.config/autofs/conf.d"

pre_configure_target() {
  cd $PKG_BUILD
}

post_makeinstall_target() {
  mkdir -p $INSTALL/etc
  mkdir -p $INSTALL/usr/config
  cp -a $PKG_DIR/config $INSTALL/usr/config/autofs
}

post_install() {
  enable_service autofs.service
}
