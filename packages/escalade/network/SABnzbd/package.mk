# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="SABnzbd"
PKG_VERSION="2.3.8"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://sabnzbd.org/"
PKG_URL="https://github.com/sabnzbd/sabnzbd/releases/download/$PKG_VERSION/SABnzbd-$PKG_VERSION-src.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 Cheetah sabyenc six par2cmdline unrar cryptography p7zip"
PKG_SECTION="escalade"
PKG_SHORTDESC="SABnzbd - The automated Usenet download tool"
PKG_TOOLCHAIN="manual"

make_target() {
  rm -fr linux osx six win
  python2 tools/make_mo.py
  python2 "$TOOLCHAIN/lib/$PKG_PYTHON_VERSION/compileall.py" -q .
  find . -name "*.py" -exec rm -rf "{}" ";"
}

makeinstall_target() {
  mkdir -p $INSTALL/opt/sabnzbd
  cp -PR * $INSTALL/opt/sabnzbd/
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/config/sabnzbd
  cp $PKG_DIR/config/* $INSTALL/usr/config/sabnzbd
}
