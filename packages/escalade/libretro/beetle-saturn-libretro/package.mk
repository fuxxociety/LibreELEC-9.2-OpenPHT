# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="beetle-saturn-libretro"
PKG_VERSION="4006bf7"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-saturn-libretro"
PKG_URL="https://github.com/libretro/beetle-saturn-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="Standalone port of Mednafen Saturn to libretro."

case "$PROJECT" in
  "Generic")
    PKG_MAKE_OPTS_TARGET="HAVE_OPENGL=1"
    ;;
  "OdroidXU3")
    PKG_MAKE_OPTS_TARGET="HAVE_OPENGL=1 platform=unix-gles"
    ;;
esac

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/retroarch/cores
  cp *.so $INSTALL/usr/share/retroarch/cores/
}
