# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="sabyenc"
PKG_VERSION="3.3.5"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="https://github.com/sabnzbd/sabyenc"
PKG_URL="https://github.com/sabnzbd/sabyenc/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host"
PKG_SECTION="escalade"
PKG_SHORTDESC="yEnc Module for Python modified for SABnzbd"
PKG_TOOLCHAIN="manual"

make_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
  export LDSHARED="$CC -shared"
  python setup.py build --cross-compile
}

makeinstall_target() {
  python setup.py install --root=$INSTALL --prefix=/usr
}

post_makeinstall_target() {
  find $INSTALL/usr/lib/python*/site-packages/  -name "*.py" -exec rm -rf {} ";"
  rm -rf $INSTALL/usr/bin
}
