# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="dolphin"
PKG_VERSION="a974540"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/dolphin-emu/dolphin"
PKG_URL="https://github.com/dolphin-emu/dolphin/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain cmake:host openal-soft-oem libevdev ffmpeg zlib bluez pulseaudio alsa-lib libogg libvorbis libSM enet-oem"
PKG_SHORTDESC="Dolphin GameCube/Wii emulator"

PKG_CMAKE_OPTS_TARGET="-DENABLE_LTO=off -DUSE_SHARED_ENET=on -DENABLE_HEADLESS=on"

pre_make_target() {
  find . -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  #export VERBOSE=1
}

post_makeinstall_target() {
  cp $PKG_DIR/scripts/* $INSTALL/usr/bin/
  mkdir -p $INSTALL/usr/config/dolphin-emu
  cp -PR $PKG_DIR/config/* $INSTALL/usr/config/dolphin-emu/
}
