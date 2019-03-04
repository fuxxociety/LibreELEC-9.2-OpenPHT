# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="vulkan-headers"
PKG_VERSION="d59ee6ab0d0636a018874c23a46f4208b6cee9ca" # 1.1.98
PKG_SHA256="47df109786671d4a0c10ba4e4f84219775b7b0e287b27e97d7b2320732f405e4"
PKG_LICENSE="Apache 2.0"
PKG_SITE="https://github.com/KhronosGroup/Vulkan-Headers"
PKG_URL="https://github.com/KhronosGroup/Vulkan-Headers/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="Vulkan-Headers-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain cmake:host"
PKG_LONGDESC="Vulkan Header files and API registry"
