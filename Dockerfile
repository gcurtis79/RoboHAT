FROM debian:stretch-slim

# Version of arduino IDE
ARG VERSION="1.8.5"

# Version of Arduino IDE to download
ENV ARDUINO_VERSION=$VERSION

# Where Arduino IDE should be installed
ENV ARDUINO_DIR="/opt/arduino"

# Arduino built-in examples
ENV ARDUINO_EXAMPLES="${ARDUINO_DIR}/examples"

# Arduino hardware
ENV ARDUINO_HARDWARE="${ARDUINO_DIR}/hardware"

# Arduino built-in libraries
ENV ARDUINO_LIBS="${ARDUINO_DIR}/libraries"

# Arduino tools
ENV ARDUINO_TOOLS="${ARDUINO_HARDWARE}/tools"

# Arduino tools-builder
ENV ARDUINO_TOOLS_BUILDER="${ARDUINO_DIR}/tools-builder"

# Arduino boards FQBN prefix
ENV A_FQBN="arduino:avr"

# Binary directory
ENV A_BIN_DIR="/usr/local/bin"

# Tools directory
ENV A_TOOLS_DIR="/opt/tools"

# Home directory
ENV A_HOME="/root"

# Shell
SHELL ["/bin/bash","-c"]

# Working directory
WORKDIR ${A_HOME}

# Get updates and install dependencies
RUN apt-get update && apt-get install wget tar xz-utils git nano xvfb -y && apt-get clean && rm -rf /var/lib/apt/list/*

# Get and install Arduino IDE
RUN wget -q https://downloads.arduino.cc/arduino-${ARDUINO_VERSION}-linux64.tar.xz -O arduino.tar.xz && \
    tar -xf arduino.tar.xz && \
    rm arduino.tar.xz && \
    mv arduino-${ARDUINO_VERSION} ${ARDUINO_DIR} && \
    ln -s ${ARDUINO_DIR}/arduino ${A_BIN_DIR}/arduino && \
    ln -s ${ARDUINO_DIR}/arduino-builder ${A_BIN_DIR}/arduino-builder && \
    echo "${ARDUINO_VERSION}" > ${A_ARDUINO_DIR}/version.txt

# Install additional commands & directories
RUN mkdir ${A_HOME}/Arduino && \
    mkdir ${A_HOME}/Arduino/libraries && \
    mkdir ${A_HOME}/Arduino/hardware && \
    mkdir ${A_HOME}/Arduino/tools
    mkdir ${A_HOME}/Arduino/build

COPY hardware/* ${A_HOME}/Arduino/hardware
COPY libraries/* ${A_HOME}/Arduino/libraries

RUN arduino --pref build.path=${A_HOME}/Arduino/build \
            --pref update.check=false
            --board arduino:avr:pro:cpu=8MHzatmega328
            --save-prefs
