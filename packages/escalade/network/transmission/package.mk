# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="transmission"
PKG_VERSION="7505891"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.transmissionbt.com/"
PKG_URL="https://github.com/transmission/transmission.git"
PKG_DEPENDS_TARGET="toolchain zlib openssl curl libevent"
PKG_SECTION="escalade"
PKG_SHORTDESC="transmission: a fast, easy and free BitTorrent client"
GET_HANDLER_SUPPORT="git"
PKG_GIT_CLONE_DEPTH="1"
PKG_GIT_SUBMODULE_DEPTH="1"

PGK_CMAKE_OPTS_TARGET="-DENABLE_CLI=On -DENABLE_LIGHTWEIGHT=On"

