# Made by github.com/escalade

PKG_NAME="transmission"
PKG_VERSION="2.93"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.transmissionbt.com/"
PKG_URL="https://github.com/transmission/transmission/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib openssl curl libevent"
PKG_SECTION="service/downloadmanager"
PKG_SHORTDESC="transmission: a fast, easy and free BitTorrent client"
PKG_LONGDESC="transmission is a fast, easy and free BitTorrent client"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Transmission"
PKG_ADDON_TYPE="xbmc.service"

PKG_AUTORECONF="no"
PKG_USE_NINJA="no"

PGK_CMAKE_OPTS_TARGET="-DENABLE_CLI=On -DENABLE_LIGHTWEIGHT=On"

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp $PKG_BUILD/.$TARGET_NAME/daemon/transmission-daemon $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp $PKG_BUILD/.$TARGET_NAME/daemon/transmission-remote $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp $PKG_BUILD/.$TARGET_NAME/utils/transmission-create $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp $PKG_BUILD/.$TARGET_NAME/utils/transmission-edit $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp $PKG_BUILD/.$TARGET_NAME/utils/transmission-show $ADDON_BUILD/$PKG_ADDON_ID/bin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/web
  cp -R $PKG_BUILD/web/* $ADDON_BUILD/$PKG_ADDON_ID/web
  find $ADDON_BUILD/$PKG_ADDON_ID/web -name "Makefile*" -exec rm -rf {} ";"
  rm -rf $ADDON_BUILD/$PKG_ADDON_ID/web/LICENSE
}
