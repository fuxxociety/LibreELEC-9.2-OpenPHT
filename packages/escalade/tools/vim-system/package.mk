# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="vim-system"
PKG_VERSION="8.1.1054"
PKG_ARCH="any"
PKG_LICENSE="VIM"
PKG_SITE="http://www.vim.org/"
PKG_URL="https://github.com/vim/vim/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_SECTION="tools"
PKG_SHORTDESC="vim: VI IMproved"

PKG_CONFIGURE_OPTS_TARGET="vim_cv_toupper_broken=no \
                           vim_cv_terminfo=yes \
                           vim_cv_tty_group=world \
                           vim_cv_tty_mode=0620 \
                           vim_cv_getcwd_broken=no \
                           vim_cv_stat_ignores_slash=yes \
                           vim_cv_memmove_handles_overlap=yes \
                           vim_cv_tgetent=zero \
                           ac_cv_sizeof_int=4 \
                           ac_cv_small_wchar_t=no \
			   --enable-selinux=no \
                           --enable-gui=no \
                           --with-compiledby=LibreELEC \
                           --with-features=normal \
                           --with-tlib=ncurses \
                           --without-x"

pre_configure_target() {
  cd $PKG_BUILD
}

post_makeinstall_target() {
  mkdir $INSTALL/bin
  ln -sf /usr/bin/vim $INSTALL/usr/bin/vi
  rm -rf $INSTALL/usr/share/vim/vim*/doc
  rm -rf $INSTALL/usr/share/vim/vim*/lang
  rm -rf $INSTALL/usr/share/vim/vim*/spell
  rm -rf $INSTALL/usr/share/vim/vim*/tutor
}
