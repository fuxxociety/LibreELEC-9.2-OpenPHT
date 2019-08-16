# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="fbneo-libretro"
PKG_VERSION="e0cdb6a"
PKG_ARCH="any"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/FBNeo"
PKG_URL="https://github.com/libretro/FBNeo/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="Port of FinalBurn Neo to Libretro."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto-parallel"

pre_make_target() {
  PKG_MAKE_OPTS_TARGET="-C src/burner/libretro CC=$CC CXX=$CXX GIT_VERSION=$PKG_VERSION EXTERNAL_ZLIB=1"

  if [ "$PROJECT" = "RPi" ]; then
    case $DEVICE in
      RPi)
        PKG_MAKE_OPTS_TARGET+=" platform=armv"
        ;;
      RPi2)
        PKG_MAKE_OPTS_TARGET+=" platform=rpi2"
        ;;
    esac
  fi

  if [ "$PROJECT" = "OdroidXU3" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=armv7-neon"
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp src/burner/libretro/fbneo_libretro.so $INSTALL/usr/lib/libretro/
}
