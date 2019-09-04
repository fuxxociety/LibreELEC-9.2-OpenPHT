# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="puae-libretro"
PKG_VERSION="7f3fdea"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-uae"
PKG_URL="https://github.com/libretro/libretro-uae/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="libretro-uae-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain capsimg"
PKG_SECTION="escalade"
PKG_SHORTDESC="PUAE LIBRETRO"

if [ "$ARCH" = "arm" ]; then
  PKG_BUILD_FLAGS="+lto-parallel"
else
  PKG_BUILD_FLAGS="-lto"
fi

make_target() {
  if [ "$ARCH" = "arm" ]; then
    CFLAGS+=" -DARM -marm"
  fi
  CFLAGS+=" -O3"
  make CC=$CC AR=$AR LD=$LD GIT_VERSION=$PKG_VERSION
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/retroarch/cores
  mkdir -p $INSTALL/usr/share/uae_data
  cp *.so $INSTALL/usr/share/retroarch/cores/
  for file in drive_click drive_snatch drive_spin drive_spinnd drive_startup
  do
    wget -q -O $INSTALL/usr/share/uae_data/${file}_LOUD.wav https://github.com/FrodeSolheim/fs-uae/raw/master/share/fs-uae/floppy_sounds/${file}.wav
  done
 }
