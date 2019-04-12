# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="SDL_sound"
PKG_VERSION="719dade41745"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://www.icculus.org/SDL_sound/"
PKG_URL="http://hg.icculus.org/icculus/SDL_sound/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib SDL"
PKG_SECTION="escalade"
PKG_SHORTDESC="SDL_sound library"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--prefix=/usr \
			   --disable-speex \
			   ac_cv_path_SDL2_CONFIG=$SYSROOT_PREFIX/usr/bin/sdl2-config"

post_unpack() {
  touch $PKG_BUILD/README
}
