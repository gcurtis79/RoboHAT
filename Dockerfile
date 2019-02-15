FROM debian:buster-20190204

RUN apt-get update \
    &&  apt-get install -y --no-install-recommends apt-utils \
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

RUN hostname BuildENV

ADD .bashrc /root/.bashrc
ADD .profile /root/.profile

ADD firmware /build

WORKDIR /build

SHELL [ "/bin/bash", "--login"]