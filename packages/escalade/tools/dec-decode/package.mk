# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="dec-decode"
PKG_VERSION="f837a37"
PKG_ARCH="any"
PKG_LICENSE="Unlicense"
PKG_SITE="https://github.com/sammiq/dec-decode"
PKG_URL="https://github.com/sammiq/dec-decode/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain go:host"
PKG_SECTION="escalade"
PKG_LONGDESC="A .iso.dec decoder written in Go"
PKG_TOOLCHAIN="manual"

configure_target() {
  case $TARGET_ARCH in
    x86_64)
      export GOARCH=amd64
      ;;
    arm)
      export GOARCH=arm

      case $TARGET_CPU in
        arm1176jzf-s)
          export GOARM=6
          ;;
        *)
          export GOARM=7
          ;;
      esac
      ;;
    aarch64)
      export GOARCH=arm64
      ;;
  esac

  export GOOS=linux
  export CGO_ENABLED=1
  export CGO_NO_EMULATION=1
  export CGO_CFLAGS=$CFLAGS
  export LDFLAGS="-w -linkmode external -extldflags -Wl,--unresolved-symbols=ignore-in-shared-libs -extld $CC"
  export GOPATH=$PKG_BUILD/.gopath
  export GOLANG=$TOOLCHAIN/lib/golang/bin/go
  export GOROOT=$TOOLCHAIN/lib/golang
  export PATH=$PATH:$GOROOT/bin

  cd $PKG_BUILD
  mkdir -p $GOPATH
}

make_target() {
  $GOLANG build -v -a -o dec-decode .
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  mv dec-decode $INSTALL/usr/bin/
}
