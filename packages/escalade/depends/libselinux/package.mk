# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="libselinux"
PKG_VERSION="2.9"
PKG_SHA256="90c0c5c88fda876ca864551624010575ca7d7195469b7634a8ab726fe731f979"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/SELinuxProject/selinux"
PKG_URL="https://github.com/SELinuxProject/selinux/archive/libselinux-$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="selinux-libselinux-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain pcre"
PKG_SECTION="escalade"
PKG_SHORTDESC="Security Enhanced Linux (SELinux) userland libraries."
PKG_BUILD_FLAGS="-lto"

make_target() {
  make install DESTDIR=$SYSROOT_PREFIX
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib
  cp -a lib*/src/*.so* $INSTALL/usr/lib
}
