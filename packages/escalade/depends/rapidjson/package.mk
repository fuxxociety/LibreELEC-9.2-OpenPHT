# Made by github.com/escalade
#
PKG_NAME="rapidjson"
PKG_VERSION="f54b0e4"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://rapidjson.org"
PKG_URL="https://github.com/Tencent/rapidjson/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="depends"
PKG_SHORTDESC="rapidjson library"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_TARGET="-DRAPIDJSON_BUILD_DOC=OFF -DRAPIDJSON_BUILD_EXAMPLES=OFF -DRAPIDJSON_BUILD_TESTS=OFF"
