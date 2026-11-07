# syntax=docker/dockerfile:1
FROM ghcr.io/truthwhisper/deb-67:latest
LABEL maintainer="lucathar@gmail.com"

RUN apt-get update \
    apt-get install -y ca-certificates \
    curl \
    systemctl \
    && bash -c 'bash <(curl -fsSL https://install.openvpn.com/as/DgiqdsQZFBogi0er) --yes' \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p \
       /openvpn \
       /ovpn/tmp \
       /ovpn/sock \
    && sed -i 's#~/tmp#/ovpn/tmp#g;s#~/sock#/ovpn/sock#g' /usr/local/openvpn_as/etc/as_templ.conf \
    && rm -rf /usr/local/openvpn_as/etc/sock/* \
    && rm -rf /usr/local/openvpn_as/etc/pid/* \
    && mv /usr/local/openvpn_as/etc /usr/local/openvpn_as/etc.docker.bak \
    && ln -s /openvpn/etc /usr/local/openvpn_as/etc

COPY docker-entrypoint.sh /

EXPOSE \
    943/tcp \
    1194/udp \
    443/tcp

VOLUME /openvpn

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/local/openvpn_as/scripts/openvpnas", "--nodaemon", "--pidfile=/ovpn/tmp/openvpn.pid"]
