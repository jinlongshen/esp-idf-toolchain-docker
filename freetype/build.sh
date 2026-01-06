#!/usr/bin/env bash
set -e

cmake -B build -S freetype \
  -G Ninja \
  -DCMAKE_TOOLCHAIN_FILE=/opt/esp-idf/tools/cmake/toolchain-esp32c3.cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/opt/freetype

cmake --build build
cmake --install build


