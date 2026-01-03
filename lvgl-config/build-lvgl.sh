#!/bin/bash
set -e

BUILD_DIR=/opt/lvgl-build

echo ">>> Cleaning old build directory"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

echo ">>> Configuring LVGL with CMake"
cd "$BUILD_DIR"

cmake \
  -DCMAKE_TOOLCHAIN_FILE=/opt/toolchain/riscv32-toolchain.cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/opt/lvgl \
  -DLV_CONF_PATH=/opt/lvgl-src/lv_conf.h \
  -G Ninja \
  /opt/lvgl-src

echo ">>> Injecting FreeType include paths into build.ninja"
sed -i 's@-isystem /opt/lvgl-src@-isystem /opt/lvgl-src -I/opt/freetype/include/freetype2@g' build.ninja

echo ">>> Building LVGL"
ninja

echo ">>> Installing LVGL"
ninja install

echo ">>> LVGL build complete"

