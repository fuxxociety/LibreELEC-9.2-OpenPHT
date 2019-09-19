# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="i3"
PKG_VERSION="4.17.1"
PKG_SHA256="7a1984f2fc2680e34644388d08e64fa70aea8070af474c96717ad92d2499c5d9"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/i3/i3"
PKG_URL="https://github.com/i3/i3/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain startup-notification xcb-util-cursor xcb-util-keysyms xcb-util-wm xcb-xrm libxkbcommon cairo-oem pango-oem yajl-oem libev"
PKG_SECTION="escalade"
PKG_SHORTDESC="A tiling window manager"
PKG_TOOLCHAIN="autotools"

post_makeinstall_target() {
  if [ "${WINDOWMANAGER}" = "i3" ]; then
    mkdir -p $INSTALL/usr/lib/systemd/system
    cp $PKG_DIR/system.d.opt/windowmanager.service $INSTALL/usr/lib/systemd/system
  fi
  mkdir -p $INSTALL/usr/config/i3
  cp $PKG_DIR/config/* $INSTALL/usr/config/i3/
}

post_install() {
  if [ "${WINDOWMANAGER}" = "i3" ]; then
    enable_service windowmanager.service
  fi
}
