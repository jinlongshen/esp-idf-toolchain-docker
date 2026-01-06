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

# 3. Install ESP-IDF (v6.1-dev)
ENV IDF_PATH=/opt/esp-idf
ENV IDF_TOOLS_PATH=/root/.espressif

RUN git clone https://github.com/espressif/esp-idf.git "$IDF_PATH" && \
    cd "$IDF_PATH" && \
    git checkout v6.1-dev && \
    git submodule update --init --recursive

# 4. Create ESP-IDF Python virtualenv
RUN python3 -m venv /opt/esp-idf/.venv

# 5. Install Python deps inside the venv
RUN source /opt/esp-idf/.venv/bin/activate && \
    pip install --upgrade pip setuptools wheel && \
    pip install -r /opt/esp-idf/tools/requirements/requirements.core.txt

# 6. Install toolchains (includes 2025 riscv32-esp-elf)
RUN source /opt/esp-idf/.venv/bin/activate && \
    /opt/esp-idf/install.sh esp32c3 debug-adapter

# 7. Fix GDB symlink
RUN GDB_PATH=$(find "$IDF_TOOLS_PATH" -name "riscv32-esp-elf-gdb" -type f | head -n 1) && \
    ln -s "$GDB_PATH" /usr/local/bin/riscv32-esp-elf-gdb

# 8. Auto-load ESP-IDF environment for interactive shells
RUN echo "export IDF_PATH=/opt/esp-idf" >> /etc/bash.bashrc && \
    echo "source /opt/esp-idf/.venv/bin/activate" >> /etc/bash.bashrc && \
    echo ". /opt/esp-idf/export.sh" >> /etc/bash.bashrc

WORKDIR /project

