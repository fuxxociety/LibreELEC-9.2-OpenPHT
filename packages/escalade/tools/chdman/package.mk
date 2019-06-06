# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="chdman"
PKG_VERSION="ad45c9c"
PKG_SHA256="00f5f5e4abdb705cbf9341b6c24e21061c288569f554979a0cff36f3e5c70315"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://www.mamedev.org"
PKG_URL="https://github.com/mamedev/mame/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain SDL2 zlib flac"
PKG_SECTION="escalade"
PKG_SHORTDESC="MAME Compressed Hunks of Data (CHD) manager"
PKG_TOOLCHAIN="make"

make_target() {
  case $ARCH in
    arm)
      NOASM=1
      PTR64=0
      ;;
    x86_64)
      PTR64=1
      NOASM=0
      ;;
  esac

  MAKE_OPTS="NOWERROR=1 \
	     OPENMP=1 \
	     TOOLS=1 \
	     USE_SYSTEM_LIB_ZLIB=1 \
	     USE_SYSTEM_LIB_FLAC=1 \
	     USE_SYSTEM_LIB_EXPAT=1 \
	     OPTIMIZE=2 \
	     PTR64=$PTR64 \
	     NOASM=$NOASM \
	     PLATFORM=$ARCH \
	     TARGET=mame \
	     SUBTARGET=arcade \
	     OSD=sdl \
	     CC=$CC \
	     CXX=$CXX \
	     LD=$LD \
	     AR=$AR"

  unset ARCH
  unset DISTRO
  unset PROJECT

  make CC=$HOST_CC CXX=$HOST_CXX LD=$HOST_LD AR=$AR CFLAGS= CXXFLAGS= LDFLAGS= $MAKEFLAGS 3rdparty/genie/bin/linux/genie
  make $MAKE_OPTS $MAKEFLAGS build/projects/sdl/mamearcade/gmake-linux/Makefile
  make $MAKE_OPTS $MAKEFLAGS NEW_GIT_VERSION=$PKG_VERSION build/generated/version.cpp

  for makefile in 7z ocore_sdl utils utf8proc chdman
  do
    make -C build/projects/sdl/mamearcade/gmake-linux $MAKE_OPTS $MAKEFLAGS config=release -f $makefile.make
  done
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp chdman $INSTALL/usr/bin
}
