# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="vulkan-loader"
PKG_VERSION="5fa0e749ff437840d53da27ac60043830bccfa47" # 1.1.98
PKG_SHA256="d7d9d7ff35841ad082b060fffc43ddfff838a1c08872574fda910b43ade036d9"
PKG_LICENSE="Apache 2.0"
PKG_SITE="https://github.com/KhronosGroup/Vulkan-Loader"
PKG_URL="https://github.com/KhronosGroup/Vulkan-Loader/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="Vulkan-Loader-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain cmake:host vulkan-headers"
PKG_LONGDESC="Vulkan Installable Client Driver (ICD) Loader."

PKG_CMAKE_OPTS_TARGET="-DBUILD_TESTS=Off \
                       -DBUILD_WSI_WAYLAND_SUPPORT=Off"

