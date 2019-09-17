# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="rpcs3"
PKG_VERSION="c900fb0"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://rpcs3.net"
PKG_URL="https://github.com/RPCS3/rpcs3.git"
PKG_DEPENDS_TARGET="toolchain ffmpeg libpng glew openal-soft-oem libevdev libSM mesa alsa-lib pulseaudio llvm qt-everywhere"
PKG_SECTION="escalade"
PKG_SHORTDESC="Playstation 3 emulator"
PKG_BUILD_FLAGS="-lto"

PKG_CMAKE_OPTS_TARGET="-DUSE_SYSTEM_FFMPEG=on \
		       -DUSE_SYSTEM_LIBPNG=on \
		       -DUSE_DISCORD_RPC=off \
		       -DUSE_NATIVE_INSTRUCTIONS=off \
		       -DBUILD_LLVM_SUBMODULE=off \
		       -DCMAKE_SKIP_RPATH=on"

pre_make_target() {
  sed -i "s:isystem :I:g" build.ninja
}

post_makeinstall_target() {
  cp $PKG_DIR/scripts/* $INSTALL/usr/bin/
  mkdir -p $INSTALL/usr/config/rpcs3
  cp -PR $PKG_DIR/config/* $INSTALL/usr/config/rpcs3/
}
