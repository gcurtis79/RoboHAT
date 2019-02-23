FROM debian:jessie-20190204

RUN apt-get update \
    &&  apt-get install -y --no-install-recommends \
        nano \
        arduino-mk \
        bash-completion \
        debhelper \
        devscripts equivs \
        dh-make \
        dpkg-dev \
        git \
        software-properties-common \
    &&  apt-get clean

RUN mkdir -p /build/src

WORKDIR /build

COPY hardware /build/
RUN cat hardware/atmega328pb/avr/boards.txt >> /usr/share/arduino/hardware/arduino/boards.txt
RUN cat hardware/atmega328pb/avr/programmers.txt >> /usr/share/arduino/hardware/arduino/programmers.txt
COPY hardware/atmega328pb/avr/variants/atmega328pb /usr/share/arduino/hardware/arduino/variants/
COPY hardware/tools/avr/avr/* /usr/share/arduino/hardware/tools/avr/avr/
COPY hardware/tools/avr/lib/* /lib/

ADD .bashrc /root/.bashrc
ADD .profile /root/.profile

ADD firmware /build

SHELL [ "/bin/bash", "--login"]