################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="reicast-libretro"
PKG_VERSION="2abb342"
PKG_ARCH="x86_64 arm"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/reicast-emulator"
PKG_URL="https://github.com/libretro/reicast-emulator/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="reicast-emulator-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="libretro"
PKG_SHORTDESC="Reicast is a multiplatform Sega Dreamcast emulator"
PKG_LONGDESC="Reicast is a multiplatform Sega Dreamcast emulator"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  strip_lto
  mkdir -p out
  case $PROJECT in
    RPi)
      make GIT_VERSION=$PKG_VERSION WITH_DYNAREC=$ARCH FORCE_GLES=1 platform=rpi
      mv *.so out
      ;;
    RPi2)
      make GIT_VERSION=$PKG_VERSION WITH_DYNAREC=$ARCH FORCE_GLES=1 platform=rpi2
      mv *.so out
      ;;
    Generic)
      make AS=${AS} CC_AS=${AS} HAVE_OIT=1 GIT_VERSION=$PKG_VERSION WITH_DYNAREC=$ARCH
      mv *.so out
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp out/*.so $INSTALL/usr/lib/libretro/
}
