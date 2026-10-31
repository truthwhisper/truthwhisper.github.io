# syntax=docker/dockerfile:1
FROM --platform=linux/amd64 debian:trixie-backports

RUN apt-get update && \
    apt-get install -y locales \
        ca-certificates \
        tzdata \
        apt-transport-https \
        build-essential \
        curl \
        wget \
        git \
        xz-utils \
        openssl \
        openssh-server \
        openssh-client \
        && rm -rf /var/lib/apt/lists/* \
        && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

RUN mkdir -p /root/.ssh && \
    ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN --mount=type=ssh git clone git@github.com:truthwhisper/truthwhisper.github.io.git

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.utf-8
ENV PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
ENV HOME=/root

USER root
EXPOSE 5000

LABEL org.opencontainers.image.title="ASMGH-67"
LABEL org.opencontainers.image.source="https://github.com/truthwhisper/truthwhisper.github.io"
LABEL org.opencontainers.image.url="https://alpine.drthesmos.cv"
LABEL org.opencontainers.image.licenses="MIT"
