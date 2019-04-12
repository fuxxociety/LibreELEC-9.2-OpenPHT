# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="joyutils"
PKG_VERSION="b6703eb"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/datrh/joyutils"
PKG_URL="https://github.com/datrh/joyutils//archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="jscal, jstest, and jsattach utilities for the Linux joystick driver"
PKG_TOOLCHAIN="manual"

make_target() {
  $CC -lm -o jscal jscal.c $CFLAGS
  $CC -lm -o jstest jstest.c $CFLAGS
  $CC -lm -o jsattach jsattach.c $CFLAGS
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp jscal $INSTALL/usr/bin/
  cp jstest $INSTALL/usr/bin/
  cp jsattach $INSTALL/usr/bin/
}
