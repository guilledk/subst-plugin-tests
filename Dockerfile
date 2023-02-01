FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y  \
        build-essential             \
        git                         \
        wget                        \
        cmake                       \
        curl                        \
        libboost-all-dev            \
        libcurl4-openssl-dev        \
        libgmp-dev                  \
        libssl-dev                  \
        libusb-1.0-0-dev            \
        llvm-11-dev                 \
        pkg-config

WORKDIR /root

RUN git clone https://github.com/guilledk/leap.git --branch subst_plugin

WORKDIR /root/leap

RUN git submodule update --init --recursive

RUN mkdir build

WORKDIR /root/leap/build

RUN cmake -DCMAKE_BUILD_TYPE=Release ..

RUN make package -j10

 RUN curl -L -O https://github.com/AntelopeIO/cdt/releases/download/v3.1.0/cdt_3.1.0_amd64.deb && \
     dpkg -i \
         cdt_3.1.0_amd64.deb \
         leap_3.2.0-ubuntu20.04_amd64.deb \
         leap-dev_3.2.0-ubuntu20.04_amd64.deb

WORKDIR /root

RUN wget https://telos-snapshots.s3.amazonaws.com/mainnet/telos-mainet-20211026-blk-180635436.tar.gz && \
    tar xvf telos-mainet-20211026-blk-180635436.tar.gz && \
    mv \
        snapshot-0ac4472c3af648291761dad85c9090333474a733dd1852008e2d1d41b212a0fc.bin \
        snapshot-mainnet-20211026-blk-180635436.bin


RUN wget https://telos-snapshots.s3.amazonaws.com/testnet/telos-testnet-20211020-blknum-136229794.tar.gz &&\
    tar xvf telos-testnet-20211020-blknum-136229794.tar.gz && \
    mv \
        snapshot-081eb3a22f5d3aeb348599b02f3afdd31adc36f278b0fbaba60441608015d58f.bin \
        snapshot-testnet-20211020-blknum-136229794.bin

RUN mkdir /root/target

WORKDIR /root/target

ENV PATH $PATH:/usr/opt/cdt/3.0.1/bin
