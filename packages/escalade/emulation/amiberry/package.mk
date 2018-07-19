#########################################################################
#                                                                       #
# Extended build by Escalade (https://github.com/escalade/LibreELEC.tv) #
#                                                                       #
#########################################################################

PKG_NAME="amiberry"
PKG_VERSION="ea3908c"
PKG_ARCH="arm"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/midwan/amiberry"
PKG_URL="https://github.com/midwan/amiberry/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib freetype zlib SDL2 SDL2_ttf SDL2_image libpng flac mpg123 gperftools"
PKG_SECTION="emulation"
PKG_SHORTDESC="Amiga emulator optimized for Raspberry Pi"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  export SYSROOT_PREFIX
  case $PROJECT in
    RPi)
      make PLATFORM=rpi-sdl2-dispmanx CC=$CC CXX=$CXX STRIP=$STRIP
      ;;
    RPi2)
      make PLATFORM=rpi2-sdl2-dispmanx CC=$CC CXX=$CXX STRIP=$STRIP
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp amiberry-* $INSTALL/usr/bin/amiberry
  cp $PKG_DIR/scripts/* $INSTALL/usr/bin
  mkdir -p $INSTALL/usr/config
  cp -R $PKG_DIR/config $INSTALL/usr/config/amiberry
  cp -R data $INSTALL/usr/config/amiberry/
  ln -s /storage/roms/bios $INSTALL/usr/config/amiberry/kickstarts
 }
