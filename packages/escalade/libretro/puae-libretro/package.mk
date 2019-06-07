# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="puae-libretro"
PKG_VERSION="8796e81"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-uae"
PKG_URL="https://github.com/libretro/libretro-uae/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="libretro-uae-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain capsimg"
PKG_SECTION="escalade"
PKG_SHORTDESC="PUAE LIBRETRO"

if [ "$ARCH" = "arm" ]; then
  PKG_BUILD_FLAGS="+lto-parallel"
  PKG_PATCH_DIRS="joystick2"
else
  PKG_BUILD_FLAGS="-lto"
fi

make_target() {
  if [ "$ARCH" = "arm" ]; then
    CFLAGS="$CFLAGS -DARM -marm"
  fi
  make CC=$CC AR=$AR LD=$LD GIT_VERSION=$PKG_VERSION
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp *.so $INSTALL/usr/lib/libretro/
 }
