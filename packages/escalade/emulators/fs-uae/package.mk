# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="fs-uae"
PKG_VERSION="3a9251b"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/FrodeSolheim/fs-uae"
PKG_URL="https://github.com/FrodeSolheim/fs-uae/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain SDL2 glew glu libmpeg2 libXi openal-soft-oem capsimg"
PKG_SECTION="escalade"
PKG_SHORTDESC="FS-UAE amiga emulator."
PKG_TOOLCHAIN="autotools"

pre_configure_target() {
  export ac_cv_func_realloc_0_nonnull=yes
  export SYSROOT_PREFIX
  cp $PKG_DIR/input/* $PKG_BUILD/share/fs-uae/input/
}

post_makeinstall_target() {
  # install scripts
  cp $PKG_DIR/scripts/* $INSTALL/usr/bin/

  # set up default config directory
  mkdir -p $INSTALL/usr/config/fs-uae/Plugins
  ln -sf /usr/lib/capsimg.so $INSTALL/usr/config/fs-uae/Plugins/capsimg.so
  cp -R $PKG_DIR/config $INSTALL/usr/config/fs-uae
  ln -s /storage/roms/bios $INSTALL/usr/config/fs-uae/Kickstarts

  rm -rf $INSTALL/usr/share/applications
  rm -rf $INSTALL/usr/share/icons
  rm -rf $INSTALL/usr/share/mime
}
