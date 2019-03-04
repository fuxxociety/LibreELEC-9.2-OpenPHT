# Made by github.com/escalade

PKG_NAME="exfat-nofuse"
PKG_VERSION="c0915bb"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/barrybingo/exfat-nofuse"
PKG_URL="https://github.com/barrybingo/exfat-nofuse/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="escalade"
PKG_SHORTDESC="Linux non-fuse read/write kernel driver for exFat"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  kernel_make KDIR=$(kernel_path) EXTRA_CFLAGS="-Wno-error=incompatible-pointer-types"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME
  cp *.ko $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME
}
