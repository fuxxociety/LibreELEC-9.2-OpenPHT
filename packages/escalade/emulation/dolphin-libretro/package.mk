# Made by github.com/escalade
#
PKG_NAME="dolphin-libretro"
PKG_VERSION="d61e5d3"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/dolphin"
PKG_URL="https://github.com/aliaspider/dolphin/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="dolphin-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain bluez lzo alsa-lib ffmpeg curl libpng zlib"
PKG_SECTION="libretro"
PKG_SHORTDESC="Dolphin Wii/Gamecube emulator - libretro port"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_USE_NINJA="no"

PKG_CMAKE_OPTS_TARGET="-DENABLE_LTO=0 -DLIBRETRO=1 -DTHREADS_PTHREAD_ARG=1"

pre_make_target() {
  find . -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  strip_lto
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  mv *.so $INSTALL/usr/lib/libretro/
}
