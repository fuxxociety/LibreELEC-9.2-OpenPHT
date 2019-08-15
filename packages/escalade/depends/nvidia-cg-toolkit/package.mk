# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="nvidia-cg-toolkit"
PKG_VERSION="3.1"
PKG_SHA256="e8ff01e6cc38d1b3fd56a083f5860737dbd2f319a39037528fb1a74a89ae9878"
PKG_ARCH="x86_64"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://developer.nvidia.com/cg-toolkit"
PKG_URL="https://developer.download.nvidia.com/cg/Cg_${PKG_VERSION}/Cg-${PKG_VERSION}_April2012_x86_64.tgz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="NVIDIA Cg libraries"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  # Install libraries and binaries to image
  mkdir -p $INSTALL/usr/bin
  mkdir -p $INSTALL/usr/lib
  cp usr/lib64/* $INSTALL/usr/lib
  cp usr/bin/* $INSTALL/usr/bin

  # Install libraries and headers to toolchain
  cp usr/lib64/* $SYSROOT_PREFIX/usr/lib
  cp -R usr/include/* $SYSROOT_PREFIX/usr/include
}
