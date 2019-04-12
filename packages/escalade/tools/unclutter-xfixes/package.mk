# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="unclutter-xfixes"
PKG_VERSION="facc3ad"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/Airblader/unclutter-xfixes"
PKG_URL="https://github.com/Airblader/unclutter-xfixes/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libX11 libev"
PKG_SHORTDESC="A program to hide the X11 cursor"

pre_configure_target() {
  export LDFLAGS="$LDFLAGS -lXext"
}

post_install() {
  enable_service unclutter.service
}

make_target() {
  make CC=$CC unclutter
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp unclutter $INSTALL/usr/bin/
}
