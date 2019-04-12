# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="headless-agent"
PKG_VERSION="1.0"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/escalade"
PKG_DEPENDS_TARGET="toolchain dbus-python pygobject bluez"
PKG_SHORTDESC="Bluez simple-agent modified to automatically pair devices"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  mkdir -p $INSTALL/usr/lib/python2.7/site-packages
  cp $PKG_DIR/scripts/* $INSTALL/usr/bin/
  cp $(get_build_dir bluez)/test/bluezutils.py $INSTALL/usr/lib/python2.7/site-packages/
}

post_install() {
  enable_service headless-agent.service
}
