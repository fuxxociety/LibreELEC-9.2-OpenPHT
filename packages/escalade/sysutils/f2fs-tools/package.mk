# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="f2fs-tools"
PKG_VERSION="1.12.0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://sourceforge.net/projects/f2fs-tools/"
PKG_URL="http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git/snapshot/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain util-linux libselinux"
PKG_DEPENDS_INIT="f2fs-tools"
PKG_SECTION="tools"
PKG_SHORTDESC="f2fs-tools: Utilities for use with the f2fs filesystem"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="cross_compiling=yes \
                           --prefix=/usr \
                           --bindir=/usr/bin \
                           --sbindir=/usr/sbin \
                           --host=$TARGET_HOST \
                           --build=$HOST_NAME \
                           --disable-shared"

configure_init() {
  : # reuse target
}

make_init() {
  : # reuse target
}

makeinstall_init() {
  mkdir -p $INSTALL/usr/sbin
  mkdir -p $INSTALL/usr/lib
  cp ../.install_pkg/usr/sbin/fsck.f2fs $INSTALL/usr/sbin
  cp ../.install_pkg/usr/sbin/mkfs.f2fs $INSTALL/usr/sbin
  cp -a $(get_build_dir libselinux)/.install_pkg/usr/lib/libselinux* $INSTALL/usr/lib
  cp $(get_build_dir glibc)/.install_pkg/usr/lib/libdl.so.2 $INSTALL/usr/lib
}
