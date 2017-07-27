################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2015 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="lz4"
PKG_VERSION="r131"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://www.lz4.org/"
PKG_URL="https://github.com/Cyan4973/lz4/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST=""
PKG_PRIORITY="optional"
PKG_SECTION="compress"
PKG_SHORTDESC="LZ4 compression library"
PKG_LONGDESC="LZ4 is a very fast lossless compression algorithm, providing compression speed at 400 MB/s per core, with near-linear scalability for multi-threaded applications. It also features an extremely fast decoder, with speed in multiple GB/s per core, typically reaching RAM speed limits on multi-core systems."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_host() {
  make all
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp -f programs/lz4 $TOOLCHAIN/bin
    cp -f programs/lz4c $TOOLCHAIN/bin
  mkdir -p $TOOLCHAIN/include
    cp -f lib/lz4.h $TOOLCHAIN/include
    cp -f lib/lz4hc.h $TOOLCHAIN/include
    cp -f lib/lz4frame.h $TOOLCHAIN/include
  mkdir -p $TOOLCHAIN/lib
    cp -f lib/liblz4.a $TOOLCHAIN/lib
}
