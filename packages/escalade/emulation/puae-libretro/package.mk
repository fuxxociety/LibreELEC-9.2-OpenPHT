PKG_NAME="puae-libretro"
PKG_VERSION="ed96bdd"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-uae"
PKG_URL="https://github.com/libretro/libretro-uae/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="libretro-uae-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="emulation"
PKG_SHORTDESC="PUAE LIBRETRO"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  strip_lto
  make CC=$CC AR=$AR LD=$LD GIT_VERSION=$PKG_VERSION
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp *.so $INSTALL/usr/lib/libretro/
 }
