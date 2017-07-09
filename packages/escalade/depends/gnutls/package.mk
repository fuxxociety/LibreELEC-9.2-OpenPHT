# Made by github.com/escalade
PKG_NAME="gnutls"
PKG_VERSION="3.5.13"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://www.gnutls.org"
PKG_URL="https://www.gnupg.org/ftp/gcrypt/gnutls/v3.5/gnutls-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain nettle"
PKG_SECTION="escalade/depends"
PKG_SHORTDESC="GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--with-included-libtasn1 \
			   --with-included-unistring \
			   --without-p11-kit \
			   --with-libgcrypt \
			   --disable-doc"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
