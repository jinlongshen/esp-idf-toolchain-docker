FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. System dependencies
RUN apt-get update && apt-get install -y \
    git wget flex bison gperf python3 python3-pip python3-venv \
    cmake ninja-build ccache libffi-dev libssl-dev dfu-util \
    libusb-1.0-0 vim-tiny bash-completion \
    && rm -rf /var/lib/apt/lists/*

# Use bash as shell so we can source scripts if needed
SHELL ["/bin/bash", "-c"]

# 2. Fix Git ownership for mounted volumes
RUN git config --system --add safe.directory '*'

# 3. Install ESP-IDF (v5.5.2)
ENV IDF_PATH=/opt/esp-idf
ENV IDF_TOOLS_PATH=/root/.espressif

RUN git clone https://github.com/espressif/esp-idf.git "$IDF_PATH" && \
    cd "$IDF_PATH" && \
    git checkout v5.5.2 && \
    git submodule update --init --recursive

# 4. Install ESP-IDF tools (toolchains, Python env, etc.)
#    IMPORTANT: Do NOT activate any venv before running install.sh
RUN /opt/esp-idf/install.sh esp32c3 debug-adapter

# 5. Fix GDB symlink
RUN GDB_PATH=$(find "$IDF_TOOLS_PATH" -name "riscv32-esp-elf-gdb" -type f | head -n 1) && \
    ln -s "$GDB_PATH" /usr/local/bin/riscv32-esp-elf-gdb

# 6. Auto-load ESP-IDF environment for interactive shells
RUN echo "export IDF_PATH=/opt/esp-idf" >> /etc/bash.bashrc && \
    echo ". /opt/esp-idf/export.sh" >> /etc/bash.bashrc

WORKDIR /project

