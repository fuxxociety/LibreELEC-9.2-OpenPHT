# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="cryptography"
PKG_VERSION="2.6.1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="https://github.com/pyca/cryptography"
PKG_URL="https://github.com/pyca/cryptography/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host cffi"
PKG_SECTION="escalade"
PKG_SHORTDESC="Provides cryptographic recipes and primitives to Python developers"
PKG_TOOLCHAIN="manual"

make_target() {
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
  export LDSHARED="$CC -shared"
  python setup.py build --cross-compile
  python setup.py install --root=$INSTALL --prefix=/usr
}

post_makeinstall_target() {
  find $INSTALL/usr/lib/python*/site-packages/  -name "*.py" -exec rm -rf {} ";"
  rm -rf $INSTALL/usr/bin
}
