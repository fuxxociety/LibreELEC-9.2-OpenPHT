# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="dosbox-sdl2"
PKG_VERSION="d4380b0"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/duganchen/dosbox"
PKG_URL="https://github.com/duganchen/dosbox/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib SDL2 SDL2_net SDL2_sound fluidsynth libpng munt zlib libpng"
PKG_SECTION="escalade"
PKG_SHORTDESC="DOSBox emulator SDL2 fork by duganchen"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--prefix=/usr \
			   --enable-core-inline \
                           --enable-dynrec \
			   --enable-unaligned_memory \
                           --with-sdl-prefix=$SYSROOT_PREFIX/usr"

case "$PROJECT" in
  Generic)
    PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET glu"
    PKG_CONFIGURE_OPTS_TARGET+=" --host=x86_64"
    ;;
  OdroidXU3|RPi)
    PKG_CONFIGURE_OPTS_TARGET+=" --host=armv7l"
    ;;
esac

pre_configure_target() {
  cd $PKG_BUILD
}

pre_make_target() {
  sed -i s/SVN/SDL2/g config.h
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/config/dosbox
  mkdir -p $INSTALL/usr/share/dosbox
  cp $PKG_DIR/scripts/* $INSTALL/usr/bin/
  cp $PKG_DIR/config/dosbox-SDL2.conf $INSTALL/usr/config/dosbox/
  wget -q https://github.com/duganchen/dosbox_shaders/archive/master.zip
  unzip -qj master.zip -d $INSTALL/usr/share/dosbox/shaders
  ln -s /usr/share/dosbox/shaders $INSTALL/usr/config/dosbox/shaders
}
