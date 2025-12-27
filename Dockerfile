FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git wget flex bison gperf python3 python3-pip python3-venv \
    cmake ninja-build ccache libffi-dev libssl-dev dfu-util \
    vim-tiny \
    && rm -rf /var/lib/apt/lists/*

# Ensure git works with mounted /project directory
RUN git config --system --add safe.directory /project

ENV IDF_PATH=/opt/esp-idf
RUN git clone --recursive https://github.com/espressif/esp-idf.git $IDF_PATH

RUN $IDF_PATH/install.sh esp32c3

RUN echo ". $IDF_PATH/export.sh" >> /etc/bash.bashrc

WORKDIR /project
