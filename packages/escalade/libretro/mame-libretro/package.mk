# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="mame-libretro"
PKG_VERSION="47c241e"
PKG_SHA256="7a690637384c64bec5f0db26452edd083bc22619aaffe7ec049eafe78e78444c"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame"
PKG_URL="https://github.com/libretro/mame/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="MAME - Multiple Arcade Machine Emulator"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-lto"

make_target() {
  PTR64="0"
  NOASM="0"

  if [ "$ARCH" == "arm" ]; then
    NOASM="1"
  elif [ "$ARCH" == "x86_64" ]; then
    PTR64="1"
  fi

  echo $MAKEFLAGS

  make REGENIE=1 VERBOSE=1 NOWERROR=1 PYTHON_EXECUTABLE=python2 CONFIG=libretro \
       LIBRETRO_OS="unix" ARCH="" PROJECT="" LIBRETRO_CPU="$ARCH" DISTRO="debian-stable" \
       CROSS_BUILD="1" OVERRIDE_CC="$CC" OVERRIDE_CXX="$CXX" OVERRIDE_LD="$LD" \
       PTR64="$PTR64" OPENMP=1 TARGET="mame" \
       SUBTARGET="arcade" PLATFORM="$ARCH" RETRO=1 OSD="retro" NOASM="$NOASM"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp *_libretro.so $INSTALL/usr/lib/libretro/mame-libretro.so
}
