# Made by github.com/escalade
#
PKG_NAME="emulationstation-retropie"
PKG_VERSION="de021ca"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/RetroPie/EmulationStation"
PKG_SOURCE_DIR="EmulationStation-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain SDL2 freetype curl cmake:host freeimage emulationstation-theme-carbon vlc"
PKG_SECTION="emulation"
PKG_SHORTDESC="Emulationstation emulator frontend"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_build_target() {
  git clone --recursive $PKG_SITE $PKG_BUILD/$PKG_NAME-git
  cd $PKG_BUILD/$PKG_NAME-git
  git reset --hard $PKG_VERSION
  cd -
  mv $PKG_BUILD/$PKG_NAME-git/* $PKG_BUILD/
  rm -rf $PKG_BUILD/$PKG_NAME-git
  for a in $PKG_DIR/patches/*.patch
  do
    patch -p1 -d $PKG_BUILD < $a
  done
}

pre_configure_target() {
  strip_gold
}

post_makeinstall_target() {  
    mkdir -p $INSTALL/etc/emulationstation
    mkdir -p $INSTALL/usr/config/emulationstation
    mkdir -p $INSTALL/usr/lib/tmpfiles.d
    ln -s /storage/.config/emulationstation/es_systems.cfg $INSTALL/etc/emulationstation/
    cp $PKG_DIR/scripts/* $INSTALL/usr/bin
    cp $PKG_DIR/files/emulationstation.conf $INSTALL/usr/config/emulationstation/
    cp $PKG_DIR/files/es_input.cfg $INSTALL/usr/config/emulationstation/
    cp $PKG_DIR/files/es_settings.cfg $INSTALL/usr/config/emulationstation/
    cp -a ../resources $INSTALL/usr/config/emulationstation/
    if [[ "$PROJECT" =~ "RPi" ]]; then
      cp $PKG_DIR/files/es_systems-rpi.cfg $INSTALL/usr/config/emulationstation/es_systems.cfg
      cp $PKG_DIR/files/emulationstation-userdirs-rpi.conf $INSTALL/usr/lib/tmpfiles.d/emulationstation-userdirs.conf
    else
      cp $PKG_DIR/files/es_systems-generic.cfg $INSTALL/usr/config/emulationstation/es_systems.cfg
      cp $PKG_DIR/files/emulationstation-userdirs-generic.conf $INSTALL/usr/lib/tmpfiles.d/emulationstation-userdirs.conf
    fi
}
