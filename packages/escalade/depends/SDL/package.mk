# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="SDL"
PKG_VERSION="1.2.15"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://www.libsdl.org"
PKG_URL="https://www.libsdl.org/release/SDL-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib"
PKG_SECTION="escalade"
PKG_SHORTDESC="libsdl: A cross-platform Graphic API"
PKG_BUILD_FLAGS="+pic"
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET="--disable-video-directfb \
			   --disable-oss \
			   --disable-alsatest \
			   --disable-arts \
			   --disable-nas \
			   --disable-esd \
			   --disable-nas-shared \
			   --disable-diskaudio \
			   --disable-dummyaudio \
			   --disable-mintaudio \
			   --enable-static \
			   --disable-shared \
			   --disable-input-tslib \
			   --disable-rpath \
			   --without-x \
			   --with-gnu-ld"

post_makeinstall_target() {
  mkdir -p $TOOLCHAIN/bin
  sed -i -e "s:\(['=\" ]\)/usr:\\=$SYSROOT_PREFIX/usr:g" $SYSROOT_PREFIX/usr/bin/sdl-config
  rm -rf $INSTALL/usr/bin
}
