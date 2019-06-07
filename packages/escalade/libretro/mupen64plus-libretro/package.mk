# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="mupen64plus-libretro"
PKG_VERSION="be81697"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mupen64plus-libretro"
PKG_URL="https://github.com/libretro/mupen64plus-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain nasm:host"
PKG_SECTION="escalade"
PKG_SHORTDESC="mupen64plus + RSP-HLE + GLideN64 + libretro"
PKG_TOOLCHAIN="manual"

if [ "$ARCH" = "arm" ]; then
  PKG_BUILD_FLAGS="+lto-parallel"
else
  PKG_BUILD_FLAGS="-lto"
fi

configure_target() {
  cd $PKG_BUILD
}

make_target() {
  case $PROJECT in
    RPi)
      CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads \
                      -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"
      make platform=rpi2 FORCE_GLES=1 HAVE_NEON=1 WITH_DYNAREC=arm
      ;;
    Generic)
      make
      ;;
    OdroidXU3)
      make platform=odroid BOARD=ODROID-XU3 FORCE_GLES3=1 HAVE_NEON=1 WITH_DYNAREC=arm
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp mupen64plus_libretro.so $INSTALL/usr/lib/libretro/
}
