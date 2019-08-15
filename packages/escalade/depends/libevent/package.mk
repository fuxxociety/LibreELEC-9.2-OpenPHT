# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="libevent"
PKG_VERSION="2.1.10-stable"
PKG_SHA256="e864af41a336bb11dab1a23f32993afe963c1f69618bd9292b89ecf6904845b0"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://libevent.org/"
PKG_URL="https://github.com/libevent/libevent/releases/download/release-$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl zlib"
PKG_SECTION="escalade"
PKG_SHORTDESC="libevent: A library for asynchronous event notification"

PKG_CONFIGURE_OPTS_TARGET="--enable-openssl --disable-debug-mode"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
