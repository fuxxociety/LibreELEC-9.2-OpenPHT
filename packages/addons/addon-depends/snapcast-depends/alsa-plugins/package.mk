# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="alsa-plugins"
PKG_VERSION="1.1.9"
PKG_SHA256="161772303da521abbbf1d91f63b470c4791392d5728f2192a42d71292078f907"
PKG_LICENSE="GPL"
PKG_SITE="http://www.alsa-project.org/"
PKG_URL="ftp://ftp.alsa-project.org/pub/plugins/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain alsa-lib"
PKG_LONGDESC="Alsa plugins."

if [ "$PULSEAUDIO_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pulseaudio"
  SUBDIR_PULSEAUDIO="pulse"
fi

PKG_CONFIGURE_OPTS_TARGET="--with-plugindir=/usr/lib/alsa"
PKG_MAKE_OPTS_TARGET="SUBDIRS=$SUBDIR_PULSEAUDIO"
PKG_MAKEINSTALL_OPTS_TARGET="SUBDIRS=$SUBDIR_PULSEAUDIO"
