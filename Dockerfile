FROM ubuntu:16.04
MAINTAINER DuyThinh <phandangduythinh@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list

RUN apt-get update -q

RUN apt-get install -qy --no-install-recommends \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
    make git

RUN apt-get install -qy --no-install-recommends \
    build-essential \
    chrpath \
    g++ \
    lib32gcc1 \
    vim \
    libc6-i386 \
    python \
    python2.7 \
    unzip \
    wget \
    "^libxcb.*" \
    gperf \
    qtchooser \
    flex \
    bison \
    python-magic \
    s3cmd


RUN apt-get install -qy --no-install-recommends \
    libglib2.0-dev \
    libopencv-dev \
    libx11-xcb-dev \
    libgl1-mesa-dev \
    libxcb1-dev \
    libx11-xcb-dev \
    libxcb-record0-dev \
    libxmu-dev \
    libappindicator-dev \
    libnotify-dev \
    libgstreamer-plugins-base0.10-dev \
    libx11-xcb-dev \
    libglu1-mesa-dev \
    libxrender-dev \
    libxi-dev \
    libssl-dev \
    libxcursor-dev \
    libxcomposite-dev \
    libxdamage-dev \
    libxrandr-dev \
    libfontconfig1-dev \
    libcap-dev \
    libbz2-dev \
    libgcrypt11-dev \
    libpci-dev \
    libnss3-dev \
    libxcursor-dev \
    libxcomposite-dev \
    libxdamage-dev \
    libxrandr-dev \
    libdrm-dev \
    libfontconfig1-dev \
    libxtst-dev \
    libasound2-dev \
    libcups2-dev \
    libpulse-dev \
    libudev-dev \
    libssl-dev \
    libicu-dev \
    libxslt-dev \
    zlib1g-dev

RUN apt-get install -qy --no-install-recommends \
    libc6-dbg gdb valgrind \
    xterm \
    gdbserver x11-utils \
    apt-utils

RUN apt-get install -qy --no-install-recommends \
	ca-certificates

# moving configuration
COPY opt-qt-5.4.0-lib.conf /etc/ld.so.conf.d/opt-qt-5.4.0-lib.conf

RUN useradd qt \
	&& mkdir /home/qt \
	&& chown qt:qt /home/qt

COPY qt540.tar.xz /tmp/

RUN tar -C /opt -xvJf /tmp/qt540.tar.xz

RUN rm -rf /tmp/qt540.tar.xz

RUN ldconfig

RUN apt-get autoclean -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/opt/Qt5.4.0/Tools/QtCreator/bin/:${PATH}"

# Fix bug for QtCreator not accept any keyboard
ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb

USER qt
WORKDIR /home/qt

ENTRYPOINT [ "qtcreator" ] 
