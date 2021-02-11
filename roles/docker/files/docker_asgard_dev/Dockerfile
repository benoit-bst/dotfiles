FROM ubuntu:20.04

# Now, go through and install the build dependencies
RUN apt-get update --assume-yes
RUN env DEBIAN_FRONTEND=noninteractive apt-get install --yes --quiet \
    autoconf \
    automake \
    ccache \
    clang \
    clang-tidy \
    coreutils \
    curl \
    vim \
    sudo \
    cmake \
    g++ \
    gcc \
    git \
    jq \
    lcov \
    libboost${boost_version}-all-dev \
    libcurl4-openssl-dev \
    libgeos++-dev \
    libgeos-dev \
    libluajit-5.1-dev \
    liblz4-dev \
    libprotobuf-dev \
    libspatialite-dev \
    libsqlite3-dev \
    libsqlite3-mod-spatialite \
    libtool \
    lld \
    locales \
    luajit \
    make \
    osmium-tool \
    parallel \
    pkg-config \
    protobuf-compiler \
    python-all-dev \
    python3-all-dev \
    python3-minimal \
    spatialite-bin \
    unzip \
    zlib1g-dev \
    python3-pip \
    libzmq3-dev \
    gucharmap \
  && rm -rf /var/lib/apt/lists/*

# add bbrisset user with sudo
RUN adduser --disabled-password --gecos '' bbrisset
RUN usermod -aG sudo bbrisset

RUN echo "bbrisset:root" | chpasswd
RUN echo "root:root" | chpasswd

# bash tunning
RUN rm -f /home/bbrisset/.bashrc 
COPY .bashrc /home/bbrisset/.bashrc

# git
COPY .gitconfig /home/bbrisset/.gitconfig

# bash_common
COPY .bash_common /home/bbrisset/.bash_common

# pre-commit
RUN pip3 install pre-commit
