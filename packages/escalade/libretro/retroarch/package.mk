# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="retroarch"
PKG_VERSION="84281d3"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/RetroArch"
PKG_URL="https://github.com/libretro/RetroArch/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib freetype zlib retroarch-assets retroarch-overlays libretro-core-info retroarch-joypad-autoconfig glsl-shaders ffmpeg libass openal-soft-oem libxkbcommon"
PKG_SECTION="escalade"
PKG_SHORTDESC="Reference frontend for the libretro API."

get_graphicdrivers

if [ "$OPENGLES_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" $OPENGLES"
else
  PKG_DEPENDS_TARGET+=" $OPENGL"
fi

if [ "$PULSEAUDIO_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" pulseaudio"
else
  RETROARCH_OPTS+=" --disable-pulse"
fi

if [ ! -z "$VULKAN_DRIVERS" ]; then
  RETROARCH_OPTS+=" --enable-vulkan"
  PKG_DEPENDS_TARGET+=" vulkan-loader slang-shaders"
fi

case "$PROJECT" in
  Generic)
    RETROARCH_OPTS+=" --enable-kms"
    PKG_DEPENDS_TARGET+=" nvidia-cg-toolkit"
    ;;
  RPi)
    RETROARCH_OPTS+=" --enable-opengles --disable-kms --disable-x11 --disable-opengl1 --disable-opengl_core --enable-neon"
    CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"
    ;;
  OdroidXU3)
   RETROARCH_OPTS+=" --enable-opengles --enable-kms --disable-x11 --disable-opengl1 --disable-opengl_core --enable-opengles3 --enable-neon"
   ;;
esac

PKG_CONFIGURE_OPTS_TARGET="--disable-vg \
                           --disable-sdl \
                           --disable-sdl2 \
                           --disable-qt \
                           $RETROARCH_OPTS \
                           --enable-zlib \
                           --disable-builtinflac \
                           --disable-xinerama \
                           --enable-freetype"

pre_configure_target() {
  cd $PKG_BUILD
  echo $PKG_VERSION > .gitversion
  export PKG_CONF_PATH=$TOOLCHAIN/bin/pkg-config
  export CFLAGS=`echo $CFLAGS | sed -e "s|-O.|-O3|g"`
  export CXXFLAGS=`echo $CFLAGS | sed -e "s|-O.|-O3|g"`
}

make_target() {
  make V=1 HAVE_LAKKA=1 $MAKEFLAGS
  make -C gfx/video_filters compiler=$CC extra_flags="$CFLAGS" $MAKEFLAGS
  make -C libretro-common/audio/dsp_filters compiler=$CC extra_flags="$CFLAGS" $MAKEFLAGS
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  mkdir -p $INSTALL/etc
    cp $PKG_BUILD/retroarch $INSTALL/usr/bin
    cp $PKG_BUILD/retroarch.cfg $INSTALL/etc
  mkdir -p $INSTALL/usr/share/retroarch/video_filters
    cp $PKG_BUILD/gfx/video_filters/*.so $INSTALL/usr/share/retroarch/video_filters
    cp $PKG_BUILD/gfx/video_filters/*.filt $INSTALL/usr/share/retroarch/video_filters
  mkdir -p $INSTALL/usr/share/retroarch/audio_filters
    cp $PKG_BUILD/libretro-common/audio/dsp_filters/*.so $INSTALL/usr/share/retroarch/audio_filters
    cp $PKG_BUILD/libretro-common/audio/dsp_filters/*.dsp $INSTALL/usr/share/retroarch/audio_filters
    cp $PKG_DIR/scripts/* $INSTALL/usr/bin
  
  # General configuration
  sed -i -e "s/# libretro_directory =/libretro_directory = \"\/tmp\/cores\"/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# libretro_info_path =/libretro_info_path = \"\/tmp\/cores\"/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# rgui_browser_directory =/rgui_browser_directory =\/storage\/roms/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# savefile_directory =/savefile_directory =\/storage\/.config\/retroarch\/savefiles/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# savestate_directory =/savestate_directory =\/storage\/.config\/retroarch\/savestates/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# system_directory =/system_directory =\/storage\/roms\/bios/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# recording_output_directory =/recording_output_directory =\/storage\/recordings/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# recording_config_directory =/recording_config_directory =\/storage\/recordings/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# screenshot_directory =/screenshot_directory =\/storage\/screenshots/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_shader_dir =/video_shader_dir =\/tmp\/shaders/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# rgui_show_start_screen = true/rgui_show_start_screen = false/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# assets_directory =/assets_directory =\/tmp\/assets/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# overlay_directory =/overlay_directory =\/tmp\/overlays/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# input_overlay_enable = true/input_overlay_enable = false/" $INSTALL/etc/retroarch.cfg
  if [ ! "$PROJECT" = "RPi" ]; then
    sed -i -e "s/# menu_driver = \"rgui\"/menu_driver = \"ozone\"/" $INSTALL/etc/retroarch.cfg
  fi
  echo "wifi_driver = \"connmanctl\"" >> $INSTALL/etc/retroarch.cfg
  echo "menu_rgui_shadows = \"true\"" >> $INSTALL/etc/retroarch.cfg

  # Quick menu
  echo "quick_menu_show_undo_save_load_state = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "quick_menu_show_save_core_overrides = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "quick_menu_show_save_game_overrides = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "quick_menu_show_cheats = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "quick_menu_show_overlays = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "quick_menu_show_rewind = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "quick_menu_show_latency = \"false\"" >> $INSTALL/etc/retroarch.cfg

  # Menu
  sed -i -e "s/# menu_show_core_updater = true/# menu_show_core_updater = false/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# menu_show_online_updater = true/# menu_show_online_updater = false/" $INSTALL/etc/retroarch.cfg
  echo "menu_show_reboot = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "menu_show_shutdown = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "menu_show_quit_retroarch = \"true\"" >> $INSTALL/etc/retroarch.cfg

  # Video
  sed -i -e "s/# video_windowed_fullscreen = true/video_windowed_fullscreen = false/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_smooth = true/video_smooth = false/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_aspect_ratio_auto = false/video_aspect_ratio_auto = true/" $INSTALL/etc/retroarch.cfg
  if [ ! "$PROJECT" = "RPi" ]; then
    sed -i -e "s/# video_font_path =/video_font_path =\/usr\/share\/retroarch\/assets\/ozone\/regular.ttf/" $INSTALL/etc/retroarch.cfg
  fi
  sed -i -e "s/# video_font_size = 48/video_font_size = 32/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_filter_dir =/video_filter_dir =\/usr\/share\/retroarch\/video_filters/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_gpu_screenshot = true/video_gpu_screenshot = false/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_fullscreen = false/video_fullscreen = true/" $INSTALL/etc/retroarch.cfg

  # Audio
  sed -i -e "s/# audio_driver =/audio_driver = \"pulse\"/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# audio_filter_dir =/audio_filter_dir =\/usr\/share\/retroarch\/audio_filters/" $INSTALL/etc/retroarch.cfg

  # Saving
  echo "savestate_thumbnail_enable = \"false\"" >> $INSTALL/etc/retroarch.cfg
  
  # Input
  sed -i -e "s/# input_driver = sdl/input_driver = udev/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# input_max_users = 16/input_max_users = 5/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# input_autodetect_enable = true/input_autodetect_enable = true/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# joypad_autoconfig_dir =/joypad_autoconfig_dir = \/tmp\/joypads/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# input_menu_toggle_gamepad_combo = 0/input_menu_toggle_gamepad_combo = 2/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# all_users_control_menu = false/all_users_control_menu = true/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_aspect_ratio_auto = false/video_aspect_ratio_auto = true/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# enable_device_vibration = false/enable_device_vibration = true/" $INSTALL/etc/retroarch.cfg

  # Menu
  sed -i -e "s/# menu_mouse_enable = false/menu_mouse_enable = false/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# menu_core_enable = true/menu_core_enable = false/" $INSTALL/etc/retroarch.cfg
  echo "menu_show_advanced_settings = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "menu_wallpaper_opacity = \"1.0\"" >> $INSTALL/etc/retroarch.cfg
  echo "content_show_images = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "content_show_music = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "content_show_video = \"false\"" >> $INSTALL/etc/retroarch.cfg

  # Updater
  if [ "$ARCH" == "arm" ]; then
    sed -i -e "s/# core_updater_buildbot_url = \"http:\/\/buildbot.libretro.com\"/core_updater_buildbot_url = \"http:\/\/buildbot.libretro.com\/nightly\/linux\/armhf\/latest\/\"/" $INSTALL/etc/retroarch.cfg
  fi
  
  # Playlists
  echo "playlist_names = \"$RA_PLAYLIST_NAMES\"" >> $INSTALL/etc/retroarch.cfg
  echo "playlist_cores = \"$RA_PLAYLIST_CORES\"" >> $INSTALL/etc/retroarch.cfg
  echo "playlist_entry_rename = \"false\"" >> $INSTALL/etc/retroarch.cfg
  echo "playlist_entry_remove = \"false\"" >> $INSTALL/etc/retroarch.cfg
}

post_install() {
  if [ "$PROJECT" = "OdroidXU3" ]; then
    oem_bigcores retroarch.service
  fi
  enable_service tmp-cores.mount
  enable_service tmp-joypads.mount
  enable_service tmp-assets.mount
  enable_service tmp-shaders.mount
  enable_service tmp-overlays.mount
}
