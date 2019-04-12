# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="citra-libretro"
PKG_VERSION="37192ff"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/citra"
PKG_URL="https://github.com/libretro/citra.git"
PKG_DEPENDS_TARGET="toolchain boost"
PKG_SECTION="escalade"
PKG_SHORTDESC="A Nintendo 3DS Emulator, running on libretro"

PKG_CMAKE_OPTS_TARGET="-DENABLE_SDL2=off -DENABLE_LIBRETRO=on -DENABLE_QT=off"
