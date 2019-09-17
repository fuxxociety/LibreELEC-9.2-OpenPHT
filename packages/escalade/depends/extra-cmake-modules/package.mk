# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="extra-cmake-modules"
PKG_VERSION="5.62.0"
PKG_SHA256=""
PKG_LICENSE="LGPL"
PKG_SITE="https://community.kde.org/Frameworks"
PKG_URL="https://download.kde.org/stable/frameworks/5.62/extra-cmake-modules-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain cmake:host"
PKG_SECTION="escalade"
PKG_LONGDESC="Extra modules and scripts for CMake."

PKG_CMAKE_OPTS_TARGET="-DBUILD_TESTING=OFF"

pre_configure_target() {
  sed -e 's|/usr/bin/env python|/usr/bin/env python2|' -i ../find-modules/*.py
}
