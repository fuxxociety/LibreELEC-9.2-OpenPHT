# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="vulkan-loader"
PKG_VERSION="1.1.121"
PKG_SHA256="8966eb5a0f1503f5d8ab1b3602913285961786f7ee06bd1ff436dcce337505d3"
PKG_LICENSE="Apache 2.0"
PKG_SITE="https://github.com/KhronosGroup/Vulkan-Loader"
PKG_URL="https://github.com/KhronosGroup/Vulkan-Loader/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain cmake:host vulkan-headers"
PKG_LONGDESC="Vulkan Installable Client Driver (ICD) Loader"

PKG_CMAKE_OPTS_TARGET="-DBUILD_TESTS=Off \
                       -DBUILD_WSI_WAYLAND_SUPPORT=Off"
