# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="omxplayer"
PKG_VERSION="f06235c"
PKG_ARCH="arm"
PKG_LICENSE="MIT"
PKG_SITE="https://www.raspberrypi.org/documentation/raspbian/applications/omxplayer.md"
PKG_URL="https://github.com/popcornmix/omxplayer/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain boost"
PKG_SECTION="escalade"
PKG_SHORTDESC="Accelerated commandline player for RPi"

pre_configure_target() {
  export SYSROOT_PREFIX
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp omxplayer-dist/usr/bin/* $INSTALL/usr/bin/
}
