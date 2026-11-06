# syntax=docker/dockerfile:1
FROM --platform=$BUILDPLATFORM debian:stable

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.utf8
ENV HOME=/root
ENV PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

USER root
CMD [ "/bin/bash" ]

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    coreutils \
    curl \
    gnupg2 \
    xz-utils \
    build-essential \
    wget \
    sudo \
    nano \
    apt-transport-https \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get full-upgrade -y

LABEL maintainer="lucathar@gmail.com"
LABEL org.opencontainers.image.url="https://github.com/truthwhisper/truthwhisper.github.io"
LABEL org.opencontainers.image.licenses="MIT License"
LABEL org.opencontainers.image.description="Debian Trixie Linux"
LABEL org.opencontainers.image.authors="Truth Whisper <lucathar@gmail.com>"
