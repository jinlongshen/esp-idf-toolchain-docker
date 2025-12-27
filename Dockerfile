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

# 3. Setup ESP-IDF tracking the MASTER branch (Prerelease)
ENV IDF_PATH=/opt/esp-idf
ENV IDF_TOOLS_PATH=/root/.espressif
RUN git clone --recursive --branch master https://github.com/espressif/esp-idf.git $IDF_PATH

# 4. Install tools AND the debug-adapter (Critical for Prerelease GDB)
RUN $IDF_PATH/install.sh esp32c3 debug-adapter

# 5. Enable Autocomplete and IDF environment for container terminal
RUN echo ". /etc/bash_completion" >> /etc/bash.bashrc && \
    echo ". $IDF_PATH/export.sh" >> /etc/bash.bashrc

WORKDIR /project
