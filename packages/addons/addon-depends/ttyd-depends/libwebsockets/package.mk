# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libwebsockets"
PKG_VERSION="f89aa40"
PKG_SHA256="a0ec2fe11d90f999325fcf7203f69bd0217aec6df21a4a8b1dc741831ebff57f"
PKG_LICENSE="LGPL2+"
PKG_SITE="https://libwebsockets.org"
PKG_URL="https://github.com/warmcat/libwebsockets/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl json-c"
PKG_LONGDESC="Library for implementing network protocols with a tiny footprint."
PKG_BUILD_FLAGS="-lto"
