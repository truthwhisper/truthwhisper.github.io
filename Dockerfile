# syntax=docker.io/docker/dockerfile:1
ARG DEBIAN_VERSION=13.7
FROM debian:trixie AS builder

ARG DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    LANGUAGE=C.UTF-8
    
ENV HOME=/root
ENV PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

USER root
EXPOSE 8000
CMD [ "/bin/bash" ]

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    libffi-dev \
    libldap2-dev \
    libmariadb-dev-compat \
    libpq-dev \
    libsasl2-dev \
    libssl-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libxmlsec1-openssl \
    libxslt1-dev \
    nodejs \
    npm \
    coreutils \
    curl \
    nginx \
    gnupg2 \
    xz-utils \
    build-essential \
    wget \
    sudo \
    nano \
    apt-transport-https \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN npm install --global vite@latest

COPY ./entrypoint.sh /srv/scripts/entrypoint.sh
RUN chmod +x /src/scripts/*


LABEL maintainer="lucathar@gmail.com"
LABEL org.opencontainers.image.url="https://github.com/truthwhisper/truthwhisper.github.io"
LABEL org.opencontainers.image.licenses="MIT License"
LABEL org.opencontainers.image.description="Debian Trixie Linux"
LABEL org.opencontainers.image.authors="Truth Whisper <lucathar@gmail.com>"
