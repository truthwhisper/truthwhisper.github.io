# syntax=docker/dockerfile:1
FROM debian:stable
ARG LANG=C.en_US.UTF8
LABEL org.opencontainers.image.authors="lucathar@gmail.com" \
      org.opencontainers.image.title="OpenVPN Access Server" \
      org.opencontainers.image.source="https://github.com/truthwhisper/truthwhisper.github.io/vpn"
RUN apt-get update \
    && apt-get install -y ca-certificates curl systemctl \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
CMD ["/bin/sh"]
