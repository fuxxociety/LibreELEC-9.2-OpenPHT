# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="fluidsynth"
PKG_VERSION="2.0.5"
PKG_SHA256="69b244512883491e7e66b4d0151c61a0d6d867d4d2828c732563be0f78abcc51"
PKG_LICENSE="GPL"
PKG_SITE="http://fluidsynth.org/"
PKG_URL="https://github.com/FluidSynth/fluidsynth/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain glib libsndfile"
PKG_LONGDESC="FluidSynth renders midi music files as raw audio data, for playing or conversion."
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=1 \
                       -Denable-readline=0 \
                       -DLIB_SUFFIX="

if [ "$PULSEAUDIO_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" pulseaudio"
fi
