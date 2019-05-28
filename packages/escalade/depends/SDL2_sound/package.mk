# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="SDL2_sound"
PKG_VERSION="9262f9205898"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://www.icculus.org/SDL_sound/"
PKG_URL="http://hg.icculus.org/icculus/SDL_sound/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib SDL2"
PKG_SECTION="escalade"
PKG_SHORTDESC="A library to decode several popular sound file formats"

PKG_CMAKE_OPTS_TARGET="-DSDLSOUND_BUILD_STATIC=off"

pre_configure_target() {
  export CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include/SDL2"
  export LDFLAGS="$LDFLAGS -lSDL2 -lm"
}
