# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="repository.castagnait"
PKG_VERSION="1.0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodinerds.net"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_LONGDESC="CastagnaIT add-on repository"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="CastagnaIT Repository"
PKG_ADDON_TYPE="xbmc.addon.repository"

make_target() {
  sed -e "s|@PKG_VERSION@|$PKG_VERSION|g" \
      -e "s|@PKG_REV@|$PKG_REV|g" \
      -i addon.xml
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/kodi/addons/repository.castagnait/$PKG_ADDON_ID
  cp $PKG_BUILD/addon.xml $INSTALL/usr/share/kodi/addons/$PKG_ADDON_ID/
}

post_install() {
  ADDON_MANIFEST=$INSTALL/usr/share/kodi/system/addon-manifest.xml
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "$PKG_ADDON_ID" $ADDON_MANIFEST
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID
  cp -R $PKG_BUILD/* $ADDON_BUILD/$PKG_ADDON_ID
}
