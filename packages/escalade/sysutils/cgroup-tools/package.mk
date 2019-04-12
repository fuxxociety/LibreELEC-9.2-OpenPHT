# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="cgroup-tools"
PKG_VERSION="0.41"
PKG_SHA256="e4e38bdc7ef70645ce33740ddcca051248d56b53283c0dc6d404e17706f6fb51"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="https://sourceforge.net/projects/libcg"
PKG_URL="https://downloads.sourceforge.net/libcg/libcgroup-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_SHORTDESC="Control Group Configuration"
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes \
                           --enable-static \
                           --enable-shared=no \
                           --disable-pam \
                           --enable-opaque-hierarchy=name=systemd"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp src/tools/cgexec $INSTALL/usr/bin
}

post_install() {
  if [ "$PROJECT" = "OdroidXU3" ]; then
    enable_service biglittle.service
    enable_service usbaffinity.service
  else
    rm $INSTALL/etc/profile.d/99-biglittle.conf
  fi
}
