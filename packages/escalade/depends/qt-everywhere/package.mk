# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="qt-everywhere"
PKG_VERSION="5.13.1"
PKG_SHA256="adf00266dc38352a166a9739f1a24a1e36f1be9c04bf72e16e142a256436974e"
PKG_LICENSE="GPL"
PKG_SITE="http://qt-project.org"
PKG_URL="https://download.qt.io/archive/qt/5.13/$PKG_VERSION/single/qt-everywhere-src-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="pcre2 zlib sqlite libinput systemd fontconfig freetype libpng libjpeg-turbo openssl libxkbcommon xcb-util xcb-util-image xcb-util-keysyms xcb-util-renderutil xcb-util-wm zstd"
PKG_LONGDESC="A cross-platform application and UI framework."
PKG_BUILDFLAGS="-lto"

PKG_CONFIGURE_OPTS_TARGET="-prefix /usr 
                           -hostprefix "${TOOLCHAIN}"
                           -docdir /usr/share/doc/qt
                           -archdatadir /usr/lib/qt
                           -device linux-libreelec-g++
                           -opensource -confirm-license -v
                           -release
                           -force-pkg-config
                           -ltcg
                           -eglfs
                           -system-libpng 
                           -system-freetype 
                           -system-xcb 
                           -system-libjpeg 
                           -system-zlib 
                           -system-pcre 
                           -openssl
                           -glib
                           -silent 
                           -journald 
                           -sqlite
                           -dbus
                           -fontconfig
                           -vulkan 
                           -opengl 
                           -nomake examples
                           -nomake tools 
                           -no-mimetype-database
                           -no-accessibility 
                           -no-rpath
                           -no-mtdev
                           -no-gif 
                           -no-libproxy
                           -no-cups
                           -no-iconv
                           -no-evdev
                           -no-tslib
                           -no-harfbuzz
                           -no-icu
                           -no-strip
                           -no-linuxfb 
                           -no-accessibility
                           -no-evdev
                           -no-sql-mysql
                           -no-strip
                           -no-tslib
                           -no-feature-linuxfb
                           -no-feature-openal
                           -no-feature-qml-debug
                           -no-feature-printer
                           -no-feature-vnc
                           -skip qt3d
                           -skip qtactiveqt
                           -skip qtandroidextras
                           -skip qtcharts
                           -skip qtconnectivity
                           -skip qtdatavis3d
                           -skip qtdoc
                           -skip qtlocation
                           -skip qtmacextras
                           -skip qtnetworkauth
                           -skip qtpurchasing
                           -skip qtquickcontrols
                           -skip qtremoteobjects
                           -skip qtscript
                           -skip qtscxml
                           -skip qtsensors
                           -skip qtserialport
                           -skip qtserialbus
                           -skip qtspeech
                           -skip qttranslations
                           -skip qtvirtualkeyboard
                           -skip qtwayland
                           -skip qtwebchannel
                           -skip qtwebengine
                           -skip qtwebsockets
                           -skip qtwebview
                           -skip qtwinextras
                           -skip qtx11extras"

configure_target() {
  QMAKE_CONF_DIR="qtbase/mkspecs/devices/linux-libreelec-g++"

  cd ..
  mkdir -p ${QMAKE_CONF_DIR}

  cat >"${QMAKE_CONF_DIR}/qmake.conf" <<EOF
MAKEFILE_GENERATOR      = UNIX
CONFIG                 += incremental
QMAKE_INCREMENTAL_STYLE = sublib
include(../../common/linux.conf)
include(../../common/gcc-base-unix.conf)
include(../../common/g++-unix.conf)
load(device_config)
QMAKE_CC         = ${CC}
QMAKE_CXX        = ${CXX}
QMAKE_LINK       = ${CXX}
QMAKE_LINK_SHLIB = ${CXX}
QMAKE_AR         = ${AR} cqs
QMAKE_OBJCOPY    = ${OBJCOPY}
QMAKE_NM         = ${NM} -P
QMAKE_STRIP      = ${STRIP}
QMAKE_CFLAGS     = ${CFLAGS}
QMAKE_CXXFLAGS   = ${CXXFLAGS}
QMAKE_LFLAGS     = ${LDFLAGS}
load(qt_config)
EOF

  cat >"${QMAKE_CONF_DIR}/qplatformdefs.h" <<EOF
#include "../../linux-g++/qplatformdefs.h"
EOF

  unset CC CXX LD RANLIB AR AS CPPFLAGS CFLAGS LDFLAGS CXXFLAGS
  ./configure ${PKG_CONFIGURE_OPTS_TARGET}
}

makeinstall_target() {
  make INSTALL_ROOT=${INSTALL} install
  make INSTALL_ROOT=${SYSROOT_PREFIX} install
  rm -rf ${INSTALL}/`echo $TOOLCHAIN | cut -d "/" -f 2`
  cp -a ${SYSROOT_PREFIX}/${TOOLCHAIN}/* ${TOOLCHAIN}/
  rm -rf ${SYSROOT_PREFIX}/`echo $TOOLCHAIN | cut -d "/" -f 2`
  rm -rf ${INSTALL}/usr/bin
  find ${INSTALL}/usr/lib -name "*.prl" -delete
}

post_makeinstall_target() {
  sed -i -e 's#${_qt5Core_install_prefix}/..##g' ${SYSROOT_PREFIX}/usr/lib/cmake/Qt5Core/Qt5CoreConfigExtrasMkspecDir.cmake
}
