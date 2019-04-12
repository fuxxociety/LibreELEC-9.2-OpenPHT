# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="dosbox-svn-libretro"
PKG_VERSION="7187114"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/fr500/dosbox-svn"
PKG_URL="https://github.com/fr500/dosbox-svn.git"
PKG_DEPENDS_TARGET="toolchain SDL SDL_net"
PKG_SECTION="escalade"
PKG_SHORTDESC="Upstream port of DOSBox to libretro"
GET_HANDLER_SUPPORT="git"
PKG_GIT_CLONE_BRANCH="libretro"
PKG_BUILD_FLAGS="-gold -lto"
PKG_TOOLCHAIN="make"

make_target() {
  export SYSROOT_PREFIX
  cd libretro
  make GIT_VERSION=$PKG_VERSION WITH_DYNAREC=$ARCH
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp dosbox_svn_libretro.so $INSTALL/usr/lib/libretro/
}
