FROM debian:stretch-slim

# Version of arduino IDE
ARG VERSION="1.8.8"

# Home directory
ENV A_HOME="/root"

# Binary directory
ENV A_BIN_DIR="${A_HOME}/bin"

# Where Arduino IDE should be installed
ENV ARDUINO_DIR="${A_BIN_DIR}/arduino-ide"

# Arduino built-in examples
ENV ARDUINO_EXAMPLES="${ARDUINO_DIR}/examples"

# Arduino hardware
ENV ARDUINO_HARDWARE="${ARDUINO_DIR}/hardware"

# Arduino built-in libraries
ENV ARDUINO_LIBS="${ARDUINO_DIR}/libraries"

# Shell
SHELL ["/bin/bash","-c"]

# Working directory
WORKDIR ${A_HOME}

# Get updates and install dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install wget tar xz-utils git nano xvfb time curl -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/list/* && \
    rm -rf /root

COPY docker /root

# Get and install Arduino IDE
RUN curl http://downloads.arduino.cc/arduino-${VERSION}-linux64.tar.xz -o arduino.tar.xz
RUN tar -xf arduino.tar.xz && \
    mv arduino-${VERSION} ${ARDUINO_DIR} && \
    rm arduino.tar.xz && \
    ln -s ${ARDUINO_DIR}/arduino ${A_BIN_DIR}/arduino && \
    ln -s ${ARDUINO_DIR}/arduino-builder ${A_BIN_DIR}/arduino-builder && \
    echo "${AVERSION}" > ${A_ARDUINO_DIR}/version.txt && \
    mkdir ${A_HOME}/.arduino15 && \
    echo "boardsmanager.additional.urls=http://arduino.esp8266.com/versions/2.3.0/package_esp8266com_index.json,https://mcudude.github.io/MiniCore/package_MCUdude_MiniCore_index.json,https://downloads.arduino.cc/packages/package_avr_3.6.0_index.json,https://github.com/watterott/ATmega328PB-Testing/raw/master/package_m328pb_index.json" >> ${A_HOME}/.arduino15/preferences.txt && \
    ${A_BIN_DIR}/arduino --install-boards "m328pb:avr" && \
    ${A_BIN_DIR}/arduino --pref build.path=${A_HOME}/Arduino/firmware/build \
            --pref update.check=false \
            --board m328pb:avr:atmega328pbic:speed=8mhz \
            --save-prefs

WORKDIR /root/Arduino/firmware
