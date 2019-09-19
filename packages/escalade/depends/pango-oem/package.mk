# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="pango-oem"
PKG_VERSION="1.44.6"
PKG_SHA256="3e1e41ba838737e200611ff001e3b304c2ca4cdbba63d200a20db0b0ddc0f86c"
PKG_LICENSE="GPL"
PKG_SITE="http://www.pango.org/"
PKG_URL="https://ftp.gnome.org/pub/gnome/sources/pango/${PKG_VERSION:0:4}/pango-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain cairo-oem freetype fontconfig fribidi glib harfbuzz-oem libX11 libXft"
PKG_LONGDESC="The Pango library for layout and rendering of internationalized text."
PKG_TOOLCHAIN="meson"

PKG_MESON_OPTS_TARGET="-Dintrospection=false"

#pre_configure_target() {
#  export PKG_CONFIG_PATH="$(get_build_dir cairo)/.$TARGET_NAME/src":"$(get_build_dir libXft)/.$TARGET_NAME/src"
#}
