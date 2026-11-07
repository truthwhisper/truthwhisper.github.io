# syntax=docker/dockerfile:1
FROM debian:stable
LABEL maintainer="lucathar@gmail.com"
ARG HOME=/root
USER root
RUN apt-get update \
    && apt-get install -y ca-certificates \
    curl \
    systemctl \
    && rm -rf /var/lib/apt/lists/*
    
RUN /bin/bash <(curl -fsSL https://install.openvpn.com/as/DgiqdsQZFBogi0er) --yes

COPY docker-entrypoint.sh /

EXPOSE \
    943/tcp \
    1194/udp \
    443/tcp

VOLUME /openvpn

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/local/openvpn_as/scripts/openvpnas", "--nodaemon", "--pidfile=/ovpn/tmp/openvpn.pid"]
