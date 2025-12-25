#!/usr/bin/env bash
set -e

# Configure FreeType from the upstream directory
cmake -B build -S freetype \
  -G Ninja \
  -DCMAKE_TOOLCHAIN_FILE=$(pwd)/riscv32-toolchain.cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/opt/freetype

# Build
cmake --build build

# Install
cmake --install build

