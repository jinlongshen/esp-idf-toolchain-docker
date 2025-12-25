set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR riscv32)

# Absolute paths to the compiler inside the base image
set(CMAKE_C_COMPILER   /root/.espressif/tools/riscv32-esp-elf/esp-15.2.0_20251204/riscv32-esp-elf/bin/riscv32-esp-elf-gcc)
set(CMAKE_CXX_COMPILER /root/.espressif/tools/riscv32-esp-elf/esp-15.2.0_20251204/riscv32-esp-elf/bin/riscv32-esp-elf-g++)

set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})

set(CMAKE_C_FLAGS   "-Os -ffunction-sections -fdata-sections")
set(CMAKE_CXX_FLAGS "-Os -ffunction-sections -fdata-sections")

set(CMAKE_EXE_LINKER_FLAGS "-Wl,--gc-sections")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

