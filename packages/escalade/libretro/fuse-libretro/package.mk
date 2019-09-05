# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="fuse-libretro"
PKG_VERSION="8184756"
PKG_URL="https://github.com/libretro/fuse-libretro/archive/$PKG_VERSION.tar.gz"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/fuse-libretro"
PKG_SECTION="escalade"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A port of the Fuse Unix Spectrum Emulator to libretro "

pre_build_target() {
  export GIT_VERSION=$PKG_VERSION
}

make_target() {
  case $PROJECT in
    RPi)
      make HAVE_NEON=1
      ;;
    OdroidXU3)
      make HAVE_NEON=1
      ;;
    Generic)
      make
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp fuse_libretro.so $INSTALL/usr/lib/libretro/
}
