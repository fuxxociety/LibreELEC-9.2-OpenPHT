# Made by github.com/escalade
PKG_NAME="dosbox-svn-libretro"
PKG_VERSION="f495b5c"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/fr500/dosbox-svn"
PKG_DEPENDS_TARGET="toolchain SDL SDL_net"
PKG_SECTION="emulation"
PKG_SHORTDESC="Upstream port of DOSBox to libretro"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_build_target() {
  git clone --recursive -b libretro $PKG_SITE $PKG_BUILD/$PKG_NAME-git
  cd $PKG_BUILD/$PKG_NAME-git
  git reset --hard $PKG_VERSION
  rm -rf .git
  cd -
  mv $PKG_BUILD/$PKG_NAME-git/* $PKG_BUILD/
  rm -rf $PKG_BUILD/$PKG_NAME-git
  for a in $PKG_DIR/patches/*.patch
  do
    patch -p1 -d $PKG_BUILD < $a
  done
}

make_target() {
  cd libretro
  strip_gold
  strip_lto
  export SYSROOT_PREFIX
  make GIT_VERSION=$PKG_VERSION WITH_DYNAREC=x86_64
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp dosbox_svn_libretro.so $INSTALL/usr/lib/libretro/
}
