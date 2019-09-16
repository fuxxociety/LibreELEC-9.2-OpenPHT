# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="pcre2"
PKG_VERSION="10.33"
PKG_SHA256="35514dff0ccdf02b55bd2e9fa586a1b9d01f62332c3356e379eabb75f789d8aa"
PKG_LICENSE="BSD"
PKG_SITE="http://www.pcre.org/"
PKG_URL="https://ftp.pcre.org/pub/pcre/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="escalade"
PKG_LONGDESC="The PCRE library is a set of functions that implement regular expression pattern matching using the same syntax and semantics as Perl 5"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=ON \
                       -DPCRE2_BUILD_PCRE2_16=ON \
                       -DPCRE2_SUPPORT_JIT=ON \
                       -DPCRE2_SUPPORT_LIBREADLINE=OFF"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
