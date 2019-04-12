# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="SDL_net"
PKG_VERSION="1.2.8"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://www.libsdl.org/projects/SDL_net/"
PKG_URL="https://www.libsdl.org/projects/SDL_net/release/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain SDL"
PKG_SECTION="escalade"
PKG_SHORTDESC="SDL_net: network library" 
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared"
