# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="oem"
PKG_VERSION="1.0"
PKG_LICENSE="various"
PKG_SITE="http://www.libreelec.tv"
PKG_DEPENDS_TARGET="toolchain xfsprogs btrfs-progs-oem f2fs-tools vim-system retroarch fuse-libretro snes9x-libretro snes9x2010-libretro flycast-libretro mupen64plus-next-libretro quicknes-libretro mgba-libretro fbneo-libretro dosbox-svn-libretro scummvm-libretro vice-libretro puae-libretro desmume-libretro ppsspp-libretro genesis-plus-gx-libretro joyutils sdl-jstest emulationstation dosbox-sdl2 scraper rsync unrar p7zip transmission SABnzbd htop-oem cgroup-tools tcpdump file mediainfo alsa-plugins strace screen headless-agent plymouth-lite ttyd-oem nfs-utils autofs chdman dec-decode wit pkgrip pyudev"
PKG_SECTION="oem"
PKG_LONGDESC="OEM: Metapackage for various OEM packages"
PKG_TOOLCHAIN="manual"

case "$PROJECT" in
  OdroidXU3)
    PKG_DEPENDS_TARGET+=" pcsx_rearmed-libretro mame2016-libretro yabasanshiro-libretro docker-oem mame2003-plus-libretro"
    ;;
  RPi)
    PKG_DEPENDS_TARGET+=" pcsx_rearmed-libretro omxplayer mame2003-plus-libretro"
    ;;
  Generic)
    PKG_DEPENDS_TARGET+=" dolphin-libretro beetle-psx-libretro fs-uae mame2016-libretro pcsx2 unclutter-xfixes docker-oem citra-libretro beetle-saturn-libretro parallel-n64-libretro tigervnc-oem rpcs3 antimicro"
    ;;
esac

if [ "$MEDIACENTER" = "kodi" ]; then
  IMAGE_ADDONS="inputstream.adaptive repository.castagnait"
  PKG_DEPENDS_TARGET+=" $IMAGE_ADDONS"
fi

make_target() {
  :
}

makeinstall_target() {
  mkdir -p $INSTALL
  mkdir -p $INSTALL/usr/bin
  mkdir -p $INSTALL/usr/config

  # Copy oem files to image
  if [ -d "$PKG_DIR/filesystem" ]; then
    cp -PR $PKG_DIR/filesystem/* $INSTALL
  fi

  # Needed by the RPi
  if [ "$PROJECT" = "RPi" ]; then
    sed -i "s/module-udev-detect/module-udev-detect tsched=0/" $INSTALL/usr/config/pulse-daemon.conf.d/system.pa
  fi

  # Install UTF-8 locale (needed by SABnzbd)
  if [ ! "$PROJECT" = "Generic" ]; then
    mkdir -p $INSTALL/usr/share/i18n/charmaps
    cp -P $(get_build_dir glibc)/.$TARGET_NAME/locale/localedef $INSTALL/usr/bin/
    cp -PR $(get_build_dir glibc)/localedata/charmaps/UTF-8 $INSTALL/usr/share/i18n/charmaps
    gzip $INSTALL/usr/share/i18n/charmaps/UTF-8
  fi
}

post_install() {
  # Activate oem systemd services
  for service in $PKG_DIR/filesystem/usr/lib/systemd/system/*.service; do
    if [ -f "$service" ]; then
      enable_service $(basename $service)
    fi
  done
  if [ "$MEDIACENTER" = "kodi" ]; then
    # Install custom file structure
    cp -PR $PKG_DIR/kodi/filesystem/* $INSTALL
    # Don't start Kodi automatically
    rm -f $INSTALL/usr/lib/systemd/system/kodi.target.wants/kodi.service
    rm -f $INSTALL/usr/lib/systemd/system/kodi.service.wants/kodi-autostart.service
    sed -i '/Install/,+1 d' $INSTALL/usr/lib/systemd/system/kodi.target || true
    # Add custom addons to the image addon manifest
    if [ -n "$IMAGE_ADDONS" ]; then
      KODI_ADDON_MANIFEST="$BUILD/image/system/usr/share/kodi/system/addon-manifest.xml"
      for ADDON_ID in $IMAGE_ADDONS; do
        xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "$ADDON_ID" $KODI_ADDON_MANIFEST
      done
    fi
  else
    # These services will start the shutdown scripts normally asocciated with Kodi
    enable_service oem-halt.service
    enable_service oem-poweroff.service
    enable_service oem-reboot.service
  fi
  # We use our own autostart service
  enable_service oem-autostart.service
  # Set the default frontend
  sed -i -e "s/@DEFAULT@/DEFAULT=\"${FRONTEND}\"/" $INSTALL/usr/bin/frontend.sh
}
