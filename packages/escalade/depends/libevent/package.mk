# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="libevent"
PKG_VERSION="2.1.8-stable"
PKG_SHA256="965cc5a8bb46ce4199a47e9b2c9e1cae3b137e8356ffdad6d94d3b9069b71dc2"
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
