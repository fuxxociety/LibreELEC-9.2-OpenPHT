# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="chdman"
PKG_VERSION="0210"
PKG_SHA256="4d0b23f3c9f9b2f6283ed78d5afc9a6391d2ee6ce5f0f4bcc2a357ec14aa06c4"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://www.mamedev.org"
PKG_URL="https://github.com/mamedev/mame/archive/mame$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain SDL2 zlib flac"
PKG_SECTION="escalade"
PKG_SHORTDESC="MAME Compressed Hunks of Data (CHD) manager"
PKG_TOOLCHAIN="make"

PTR64="0"
NOASM="0"

if [ "$ARCH" == "arm" ]; then
  NOASM="1"
elif [ "$ARCH" == "x86_64" ]; then
  PTR64="1"
fi

PKG_MAKE_OPTS_TARGET="REGENIE=1 \
		      VERBOSE=0 \
		      NOWERROR=1 \
		      OPENMP=1 \
		      PTR64=$PTR64 \
		      NOASM=$NOASM \
		      PYTHON_EXECUTABLE=python2 \
		      PLATFORM=$ARCH \
		      MAINTARGET=mame \
		      SUBTARGET=arcade \
		      OSD=sdl \
		      USE_SYSTEM_LIB_EXPAT=1 \
		      USE_SYSTEM_LIB_ZLIB=1 \
		      USE_SYSTEM_LIB_FLAC=1"

make_target() {
  unset ARCH
  unset DISTRO

  for makeopts in $PKG_MAKE_OPTS_TARGET
  do
    export $makeopts
  done

  make CC=$HOST_CC CXX=$HOST_CXX LD=$HOST_LD AR=$AR $MAKEFLAGS verbose=1 -C 3rdparty/genie/build/gmake.linux -f genie.make

3rdparty/genie/bin/linux/genie --with-system-expat=$USE_SYSTEM_LIB_EXPAT --with-system-zlib=$USE_SYSTEM_LIB_ZLIB --with-system-flac=$USE_SYSTEM_LIB_FLAC --distro=generic --CC=$CC --CXX=$CXX --LD=$LD --with-tools --NOWERROR=$NOWERROR --target=$MAINTARGET --subtarget=$SUBTARGET --build-dir='build' --OPENMP=$OPENMP --PYTHON_EXECUTABLE=$PYTHON_EXECUTABLE --NOASM=$NOASM --osd=$OSD --targetos='linux' --PLATFORM=$PLATFORM --gcc=linux-gcc --gcc_version=$(gcc --version | head -n 1 | awk '{print $3}') gmake
  
  make $PKG_MAKE_OPTS_TARGET CC=$CC CXX=$CXX LD=$LD AR=$AR NEW_GIT_VERSION=$PKG_VERSION $MAKEFLAGS verbose=1 build/generated/version.cpp

  for makefile in 7z ocore_$OSD utils utf8proc chdman
  do
    make -C build/projects/sdl/mamearcade/gmake-linux config=release verbose=1 -f $makefile.make $MAKEFLAGS
  done
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp chdman $INSTALL/usr/bin
}
