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

PKG_NAME="mame2016-libretro"
PKG_VERSION="e06d731"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2016-libretro"
PKG_URL="https://github.com/libretro/mame2016-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="libretro"
PKG_SHORTDESC="MAME (0.174-ish) for libretro"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  strip_lto
  strip_gold
  PTR64="0"
  NOASM="0"

  if [ "$ARCH" == "arm" ]; then
    NOASM="1"
  elif [ "$ARCH" == "x86_64" ]; then
    PTR64="1"
  fi

  make REGENIE=1 VERBOSE=1 NOWERROR=1 PYTHON_EXECUTABLE=python2 CONFIG=libretro \
       LIBRETRO_OS="unix" ARCH="" PROJECT="" LIBRETRO_CPU="$ARCH" DISTRO="debian-stable" \
       CC="$CC" CXX="$CXX" LD="$LD" CROSS_BUILD="" PTR64="$PTR64" TARGET="mame" \
       SUBTARGET="arcade" PLATFORM="$ARCH" RETRO=1 OSD="retro" GIT_VERSION=$PKG_VERSION
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp *.so $INSTALL/usr/lib/libretro/
}
