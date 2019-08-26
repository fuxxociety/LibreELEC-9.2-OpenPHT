# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="dosbox-svn-libretro"
PKG_VERSION="f81ce27"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/dosbox-svn"
PKG_URL="https://github.com/libretro/dosbox-svn.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="Upstream port of DOSBox to libretro"
GET_HANDLER_SUPPORT="git"
PKG_GIT_CLONE_BRANCH="libretro"
PKG_TOOLCHAIN="make"

if [ "$ARCH" = "arm" ]; then
  PKG_BUILD_FLAGS="+lto-parallel"
else
  PKG_BUILD_FLAGS="-lto"
fi

make_target() {
  export SYSROOT_PREFIX
  make -C libretro GIT_VERSION=$PKG_VERSION WITH_DYNAREC=$ARCH WITH_FAKE_SDL=1
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/retroarch/cores
  cp libretro/dosbox_svn_libretro.so $INSTALL/usr/share/retroarch/cores/
}
