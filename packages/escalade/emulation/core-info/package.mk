PKG_NAME="core-info"
PKG_VERSION="473d80b"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-core-info"
PKG_URL="https://github.com/libretro/libretro-core-info/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="libretro-core-info-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="emulation"
PKG_SHORTDESC="Info files for libretro cores"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

configure_target() {
  :
}

make_target() {
  :
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp ../*.info $INSTALL/usr/lib/libretro/
}

