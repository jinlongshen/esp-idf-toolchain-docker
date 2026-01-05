#!/bin/bash
set -e

BUILD_DIR=/opt/lvgl-build

echo ">>> Cleaning old build directory"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

echo ">>> Configuring LVGL with CMake"
cd "$BUILD_DIR"

# FORCE LV_ARCH to NONE and disable ARM-specific detections
cmake \
  -DCMAKE_TOOLCHAIN_FILE=/opt/toolchain/riscv32-toolchain.cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/opt/lvgl \
  -DLV_CONF_PATH=/opt/lvgl-src/lv_conf.h \
  -DLV_ARCH=NONE \
  -DLV_USE_DRAW_SW_ASM=OFF \
  -DLV_USE_ARM_HELIUM=OFF \
  -DLV_USE_ARM_NEON=OFF \
  -G Ninja \
  /opt/lvgl-src

echo ">>> Injecting FreeType include paths"
sed -i 's@-isystem /opt/lvgl-src@-isystem /opt/lvgl-src -I/opt/freetype/include/freetype2@g' build.ninja

ninja -v
ninja install
