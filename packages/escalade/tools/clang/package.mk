# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="clang"
PKG_VERSION="8.0.0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://llvm.org/"
PKG_URL="http://releases.llvm.org/$PKG_VERSION/cfe-$PKG_VERSION.src.tar.xz"
PKG_DEPENDS_HOST="toolchain llvm:host libxml2:host"
PKG_SECTION="escalade"
PKG_SHORTDESC="C language family frontend for LLVM"

PKG_CMAKE_OPTS_HOST="-DLLVM_DIR=$SYSROOT_PREFIX/usr/lib/cmake/llvm"
