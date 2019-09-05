# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

# libepoxy (actually) needs to be built shared, to avoid
# (EE) Failed to load /usr/lib/xorg/modules/libglamoregl.so:
# /usr/lib/xorg/modules/libglamoregl.so: undefined symbol: epoxy_eglCreateImageKHR
# in Xorg.log

PKG_NAME="libepoxy"
PKG_VERSION="8573dbc"
PKG_SHA256="532b76a029edb69a2c31e148859dc04c6596c6d059f504696f4e17d0630f1dcc"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/anholt/libepoxy"
PKG_URL="https://github.com/anholt/libepoxy/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Epoxy is a library for handling OpenGL function pointer management for you."
PKG_TOOLCHAIN="autotools"

if [ "$OPENGL" != "no" ]; then
  PKG_DEPENDS_TARGET+=" $OPENGL"
  PKG_CONFIGURE_OPTS_TARGET="--enable-x11"
fi

if [ "$OPENGLES" != "no" ]; then
  PKG_DEPENDS_TARGET+=" $OPENGLES"
fi

if [ "$DISPLAYSERVER" != "x11" ]; then
  PKG_CONFIGURE_OPTS_TARGET="--disable-glx"
fi
