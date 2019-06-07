# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="yabasanshiro-libretro"
PKG_VERSION="f702466"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/yabause"
PKG_URL="https://github.com/libretro/yabause/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="Yet Another Buggy And Uncomplete Saturn Emulator"
PKG_TOOLCHAIN="make"

make_target() {
  cd $PKG_BUILD/yabause/src/libretro
  make CC=$HOST_CC generate-files
  case $PROJECT in
    OdroidXU3)
      make GIT_VERSION=$PKG_VERSION platform=odroid BOARD=ODROID-XU4
      ;;
  esac
}

makeinstall_target() {
  echo $INSTALL $INSTALL
  mkdir -p $INSTALL/usr/lib/libretro
  cp yabasanshiro_libretro.so $INSTALL/usr/lib/libretro/
}
