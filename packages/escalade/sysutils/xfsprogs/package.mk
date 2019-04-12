# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="xfsprogs"
PKG_VERSION="4.20.0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.xfs.org"
PKG_URL="https://git.kernel.org/cgit/fs/xfs/xfsprogs-dev.git/snapshot/xfsprogs-dev-$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="xfsprogs-dev-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain util-linux readline"
PKG_DEPENDS_INIT="xfsprogs"
PKG_SECTION="escalade"
PKG_SHORTDESC="xfsprogs: Utilities for use with the xfs filesystem"
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET="AC_HAVE_COPY_FILE_RANGE=no --prefix=/usr \
			   --exec-prefix=/ \
			   --enable-shared=no \
			   --with-gnu-ld \
			   --enable-readline=no"

pre_configure_target() {
  sed -i 's/^HAVE_COPY_FILE_RANGE.*/HAVE_COPY_FILE_RANGE\ =\ no/' include/builddefs.in
  export LDFLAGS="$LDFLAGS -lncurses"
  make configure
}

configure_init() {
  : # reuse target
}

make_init() {
  : # reuse target
}

makeinstall_init() {
  mkdir -p $INSTALL/usr/sbin
  cp ../.install_pkg/usr/sbin/xfs_repair $INSTALL/usr/sbin
  cp ../.install_pkg/usr/sbin/fsck.xfs $INSTALL/usr/sbin
  cp ../.install_pkg/usr/sbin/mkfs.xfs $INSTALL/usr/sbin
}
