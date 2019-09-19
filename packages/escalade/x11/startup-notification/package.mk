# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="startup-notification"
PKG_VERSION="0.12"
PKG_LICENSE="BSD"
PKG_SITE="http://www.freedesktop.org/software/startup-notification"
PKG_URL="http://www.freedesktop.org/software/startup-notification/releases/startup-notification-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain xcb-util"
PKG_SECTION="escalade"

PKG_CONFIGURE_OPTS_TARGET="lf_cv_sane_realloc=yes"
