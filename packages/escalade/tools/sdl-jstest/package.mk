# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="sdl-jstest"
PKG_VERSION="aafbdb1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://gitlab.com/sdl-jstest/sdl-jstest"
PKG_URL="https://gitlab.com/sdl-jstest/sdl-jstest.git"
PKG_DEPENDS_TARGET="toolchain SDL2"
PKG_SECTION="escalade"
PKG_SHORTDESC="Simple SDL joystick test application for the console."
GET_HANDLER_SUPPORT="git"
PKG_BUILD_FLAGS="-lto -gold"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SDL_JSTEST=off"
