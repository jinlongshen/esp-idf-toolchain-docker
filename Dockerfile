FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Install system dependencies + completion support
RUN apt-get update && apt-get install -y \
    git wget flex bison gperf python3 python3-pip python3-venv \
    cmake ninja-build ccache libffi-dev libssl-dev dfu-util \
    libusb-1.0-0 vim-tiny bash-completion \
    && rm -rf /var/lib/apt/lists/*

# 2. Fix Git ownership for mounted volumes
RUN git config --system --add safe.directory '*'

# 3. Setup ESP-IDF tracking the MASTER branch
ENV IDF_PATH=/opt/esp-idf
ENV IDF_TOOLS_PATH=/root/.espressif
RUN git clone --recursive --branch master https://github.com/espressif/esp-idf.git $IDF_PATH

# 4. Install tools AND the debug-adapter (Bakes in the 2025 toolchain)
RUN $IDF_PATH/install.sh esp32c3 debug-adapter

# 5. Permanent Fix: Symlink the GDB binary
# We use 'find' to bypass the buggy export.sh detection during Docker build
RUN GDB_PATH=$(find $IDF_TOOLS_PATH -name "riscv32-esp-elf-gdb" -type f | grep "bin/riscv32-esp-elf-gdb" | head -n 1) && \
    if [ -z "$GDB_PATH" ]; then \
        echo "❌ GDB not found in $IDF_TOOLS_PATH" && exit 1; \
    fi && \
    ln -s "$GDB_PATH" /usr/local/bin/riscv32-esp-elf-gdb && \
    echo "✅ Linked GDB from $GDB_PATH to /usr/local/bin/riscv32-esp-elf-gdb"

# 6. Enable IDF environment for interactive terminal sessions (Dev Containers)
RUN echo "export IDF_PATH=/opt/esp-idf" >> /etc/bash.bashrc && \
    echo "export IDF_PATH_FORCE=1" >> /etc/bash.bashrc && \
    echo ". $IDF_PATH/export.sh" >> /etc/bash.bashrc

WORKDIR /project
