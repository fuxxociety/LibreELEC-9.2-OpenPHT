# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="yajl-oem"
PKG_VERSION="2.1.0"
PKG_SHA256="3fb73364a5a30efe615046d07e6db9d09fd2b41c763c5f7d3bfb121cd5c5ac5a"
PKG_LICENSE="ISC"
PKG_SITE="http://lloyd.github.com/yajl/"
PKG_URL="https://github.com/lloyd/yajl/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A small event-driven (SAX-style) JSON parser."

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
