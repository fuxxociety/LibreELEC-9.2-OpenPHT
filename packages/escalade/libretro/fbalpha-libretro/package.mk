# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="fbalpha-libretro"
PKG_VERSION="e8b51b7"
PKG_ARCH="any"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/FBAlphaFB"
PKG_URL="https://github.com/libretro/FBAlphaFB/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="Port of Final Burn Alpha to Libretro."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto"

pre_make_target() {
  PKG_MAKE_OPTS_TARGET="-C src/burner/libretro CC=$CC CXX=$CXX GIT_VERSION=$PKG_VERSION"

  if [ "$PROJECT" = "RPi" ]; then
    case $DEVICE in
      RPi)
        PKG_MAKE_OPTS_TARGET+=" platform=armv"
        ;;
      RPi2)
        PKG_MAKE_OPTS_TARGET+=" platform=rpi2"
        ;;
    esac
  else
    # NEON Support ?
    if target_has_feature neon; then
      PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=1"
    fi
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp src/burner/libretro/fbalpha_libretro.so $INSTALL/usr/lib/libretro/
}
