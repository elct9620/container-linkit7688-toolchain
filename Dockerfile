FROM ubuntu:14.04

ENV OPENWRT /usr/src/openwrt
ENV VERSION 15.05
ENV PATH $OPENWRT/staging_dir/toolchain-mipsel_24kec+dsp_gcc-4.8-linaro_uClibc-0.9.33.2/bin:$PATH

ENV CC mipsel-openwrt-linux-uclibc-gcc
ENV CXX mipsel-openwrt-linux-uclibc-g++
ENV LD mipsel-openwrt-linux-uclibc-gcc
ENV AR mipsel-openwrt-linux-uclibc-gcc-ar

RUN apt-get update
RUN apt-get -y install git g++ make libncurses5-dev subversion libssl-dev gawk libxml-parser-perl unzip wget python xz-utils
RUN cd /usr/src && git clone git://git.openwrt.org/15.05/openwrt.git

ADD lks7688.config $OPENWRT/.config

RUN cd $OPENWRT && \
    ./scripts/feeds update -a && \
    ./scripts/feeds install -a && \
    make defconfig && \
    make tools/install && \
    make toolchain/install
