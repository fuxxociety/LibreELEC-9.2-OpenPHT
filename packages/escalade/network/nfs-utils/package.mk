# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="nfs-utils"
PKG_VERSION="2.3.4"
PKG_SHA256="3b8b669e9b6b2f24d00ccab2fdf258d2605397d27c8f9fc760a73f34326f1e6c"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://sourceforge.net/projects/nfs"
PKG_URL="http://downloads.sf.net/sourceforge/nfs/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libtirpc libevent"
PKG_SECTION="escalade"
PKG_SHORTDESC="Support programs for Network File Systems"

PKG_CONFIGURE_OPTS_TARGET="--without-tcp-wrappers \
			   --disable-caps \
			   --disable-nfsv41 \
			   --disable-nfsdcld \
			   --disable-nfsdcld \
			   --disable-nfsdcltrack \
			   --disable-gss \
			   --enable-libmount-mount \
			   --with-systemd"

pre_configure_target() {
  cd $PKG_BUILD
  export CC_FOR_BUILD=$CC
  sed -i "s|sbindir = /sbin|sbindir = /usr/sbin|g" utils/*/Makefile.in
}

post_makeinstall_target() {
  mkdir -p $INSTALL/etc
  mkdir -p $INSTALL/usr/config
  ln -sf /storage/.config/nfs.conf $INSTALL/etc/
  ln -sf /storage/.config/nfsmount.conf $INSTALL/etc/
  ln -sf /storage/.config/exports $INSTALL/etc/
  ln -sf /storage/.config/idmapd.conf $INSTALL/etc/
  sed 's/# udp=n/udp=y/' nfs.conf > $INSTALL/usr/config/nfs.conf
  cp utils/mount/nfsmount.conf $INSTALL/usr/config/
  cp $PKG_DIR/config/* $INSTALL/usr/config/
  rm -rf $INSTALL/run
}

post_install() {
  enable_service nfs-server.service
}
