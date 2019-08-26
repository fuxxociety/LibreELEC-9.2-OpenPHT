# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="vlc"
PKG_VERSION="3.0.8"
PKG_SHA256="e0149ef4a20a19b9ecd87309c2d27787ee3f47dfd47c6639644bc1f6fd95bdf6"
PKG_LICENSE="GPL"
PKG_SITE="http://www.videolan.org"
PKG_URL="http://get.videolan.org/vlc/$PKG_VERSION/vlc-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain ffmpeg libmpeg2 zlib flac"
PKG_SECTION="escalade"
PKG_LONGDESC="VideoLAN multimedia player and streamer"
PKG_BUILD_FLAGS="+pic"

if [ "$PROJECT" = "RPi" ]; then
  PKG_PATCH_DIRS="MMAL"
fi

PKG_CONFIGURE_OPTS_TARGET="--enable-silent-rules \
                             --disable-dependency-tracking \
                             --disable-static \
                             --disable-dbus \
                             --disable-nls \
                             --disable-rpath \
                             --disable-sout \
                             --disable-lua \
                             --disable-vlm \
                             --disable-taglib \
                             --disable-live555 \
                             --disable-dc1394 \
                             --disable-dvdread \
                             --disable-dvdnav \
                             --disable-opencv \
                             --disable-decklink \
                             --disable-sftp \
                             --disable-v4l2 \
                             --disable-vcd \
                             --disable-libcddb \
                             --disable-dvbpsi \
                             --disable-screen \
                             --disable-ogg \
                             --disable-shout\
                             --disable-mod \
                             --disable-mpc \
                             --disable-gme \
                             --disable-wma-fixed \
                             --disable-shine \
                             --disable-omxil \
                             --disable-mad \
                             --disable-merge-ffmpeg \
                             --enable-avcodec \
                             --enable-avformat \
                             --enable-swscale \
                             --enable-postproc \
                             --disable-faad \
                             --enable-flac \
                             --disable-aa \
                             --disable-twolame \
                             --disable-realrtsp \
                             --disable-libtar \
                             --disable-a52 \
                             --disable-dca \
                             --enable-libmpeg2 \
                             --disable-vorbis \
                             --disable-tremor \
                             --disable-speex \
                             --disable-theora \
                             --disable-schroedinger \
                             --disable-png \
                             --disable-x264 \
                             --disable-x26410b \
                             --disable-fluidsynth \
                             --disable-zvbi \
                             --disable-telx \
                             --disable-libass \
                             --disable-kate \
                             --disable-tiger \
                             --disable-xcb \
                             --disable-xvideo \
                             --disable-sdl-image \
                             --disable-freetype \
                             --disable-fribidi \
                             --disable-fontconfig \
                             --disable-libxml2 \
                             --disable-svg \
                             --disable-directx \
                             --disable-caca \
                             --disable-oss \
                             --enable-pulse \
                             --enable-alsa \
                             --disable-jack \
                             --disable-upnp \
                             --disable-skins2 \
                             --disable-kai \
                             --disable-qt \
                             --disable-macosx \
                             --disable-macosx-qtkit \
                             --disable-ncurses \
                             --disable-goom \
                             --disable-projectm \
                             --disable-udev \
                             --disable-mtp \
                             --disable-lirc \
                             --disable-libgcrypt \
                             --disable-update-check \
                             --disable-gnutls \
                             --disable-kva \
                             --disable-bluray \
                             --disable-samplerate \
                             --disable-sid \
                             --disable-crystalhd \
                             --disable-dxva2 \
                             --disable-soxr \
                             --disable-aom \
                             --disable-dav1d \
                             --disable-vdpau \
                             --disable-mpg123 \
                             --disable-vlc"

pre_configure_target() {
  if [ "$PROJECT" = "RPi" ]; then
    PKG_CONFIGURE_OPTS_TARGET+=" --enable-mmal"
  fi

  if target_has_feature neon; then
    PKG_CONFIGURE_OPTS_TARGET+=" --enable-neon"
  fi
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/share
}
