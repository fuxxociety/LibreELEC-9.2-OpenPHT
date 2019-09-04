# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="btrfs-progs-oem"
PKG_VERSION="v5.2.1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kdave/btrfs-progs"
PKG_URL="https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/btrfs-progs-$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="btrfs-progs-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain e2fsprogs util-linux zlib lzo zstd"
PKG_DEPENDS_INIT="btrfs-progs-oem zlib:init lzo:init"
PKG_SECTION="escalade"
PKG_SHORTDESC="f2fs-tools: Utilities for use with the f2fs filesystem"

PKG_CONFIGURE_OPTS_TARGET="--prefix=/usr \
                           --disable-option-checking \
			   --disable-python \
                           --disable-documentation"

pre_configure_target() {
  cd ..
  rm -rf $TARGET_NAME
}

configure_init() {
  : # reuse target
}

make_init() {
  : # reuse target
}

makeinstall_init() {
  mkdir -p $INSTALL/usr/sbin
  cp ../.install_pkg/usr/bin/btrfs $INSTALL/usr/sbin
  cp ../.install_pkg/usr/bin/fsck.btrfs $INSTALL/usr/sbin
  cp ../.install_pkg/usr/bin/mkfs.btrfs $INSTALL/usr/sbin
}
