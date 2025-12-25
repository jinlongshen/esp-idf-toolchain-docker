#!/usr/bin/env bash
set -e

BUILD_TYPE="${1:-Debug}"

case "$BUILD_TYPE" in
    Debug|Release)
        ;;
    "")
        BUILD_TYPE="Debug"
        ;;
    *)
        echo "ERROR: Invalid build type '$BUILD_TYPE'"
        echo "Allowed values: Debug, Release"
        exit 1
        ;;
esac

echo "==> Building FreeType (${BUILD_TYPE})"

rm -rf build
mkdir build

cat > build/CMakeCache.txt <<EOF
CMAKE_BUILD_TYPE:STRING=${BUILD_TYPE}
EOF

cmake -B build -S src \
  -DCMAKE_TOOLCHAIN_FILE=/opt/freetype-src/riscv32-toolchain.cmake \
  -DDISABLE_FORCE_DEBUG_POSTFIX=ON \
  -DBUILD_SHARED_LIBS=OFF \
  -DBUILD_TESTING=OFF \
  -DFT_DISABLE_ZLIB=ON \
  -DFT_DISABLE_BZIP2=ON \
  -DFT_DISABLE_PNG=ON \
  -DFT_DISABLE_HARFBUZZ=ON \
  -DFT_DISABLE_BROTLI=ON \
  -DFT_REQUIRE_ZLIB=OFF \
  -DFT_REQUIRE_BZIP2=OFF \
  -DFT_REQUIRE_PNG=OFF \
  -DFT_REQUIRE_HARFBUZZ=OFF \
  -DFT_REQUIRE_BROTLI=OFF \
  -DFT_ENABLE_ERROR_STRINGS=OFF \
  -DCMAKE_INSTALL_PREFIX=/opt/freetype

cmake --build build -j
cmake --build build --target install

echo "==> Installed to /opt/freetype"

