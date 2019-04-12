# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="freeimage"
PKG_VERSION="3180"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="http://freeimage.sourceforge.net/"
PKG_URL="http://downloads.sourceforge.net/freeimage/FreeImage$PKG_VERSION.zip"
PKG_SOURCE_DIR="FreeImage"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="FreeImage library"

pre_make_target() {
  export CFLAGS="$CFLAGS -DPNG_ARM_NEON_OPT=0"
}
