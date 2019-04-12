# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="openal-soft-oem"
PKG_VERSION="1.19.1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.openal.org/"
PKG_URL="http://kcat.strangesoft.net/openal-releases/openal-soft-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain alsa-lib"
PKG_SECTION="escalade"
PKG_SHORTDESC="Open Audio Library"
PKG_TOOLCHAIN="cmake-make"

PKG_CMAKE_OPTS_TARGET="-DALSOFT_EXAMPLES=off \
		       -DALSOFT_TESTS=off \
		       -DALSOFT_UTILS=off \
		       -DALSOFT_BACKEND_OSS=off \
		       -DALSOFT_BACKEND_WAVE=off \
		       -DALSOFT_BACKEND_PULSEAUDIO=on"

pre_make_target() {
  $HOST_CC ../native-tools/bin2h.c -o native-tools/bin2h
  $HOST_CC ../native-tools/bsincgen.c -o native-tools/bsincgen -lm
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/config
  mkdir -p $INSTALL/etc/openal

  mv $INSTALL/usr/share/openal/alsoftrc.sample $INSTALL/usr/config/alsoft.conf
  ln -s /storage/.config/alsoft.conf $INSTALL/etc/openal/

  # Allow moving the audio stream as in when plugging a USB headset
  sed -i "s/^#allow-moves = false/allow-moves = true/" $INSTALL/usr/config/alsoft.conf
}
