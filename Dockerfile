ARG CONTAINER=ghcr.io/openwrt/sdk
ARG ARCH=mips_24kc
FROM $CONTAINER:$ARCH

LABEL "com.github.actions.name"="OpenWrt SDK"

ARG DEBIAN_FRONTEND=noninteractive

USER root

RUN \
	sed -i '$a\\ndeb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-15 main' /etc/apt/sources.list && \
	sed -i '$a\deb-src http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-15 main' /etc/apt/sources.list && \
	wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
	apt-get update && \
	apt-get install -y \
		build-essential \
		clang-15 \
		flex \
		bison \
		g++ \
		gawk \
		gcc-multilib \
		g++-multilib \
		gettext \
		git \
		libdw-dev \
		libelf-dev \
		libncurses5-dev \
		libssl-dev \
		python3-setuptools \
		rsync \
		swig \
		unzip \
		zlib1g-dev \
		file \
		wget \
		zstd && \
	apt-get clean

ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
