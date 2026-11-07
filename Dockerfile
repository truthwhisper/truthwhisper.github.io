# syntax=dockerfile:1
FROM scratch
ADD https://dl-cdn.alpinelinux.org/alpine/v3.24/releases/x86_64/alpine-minirootfs-3.24.4-x86_64.tar.gz /
CMD ["/bin/sh"]
LABEL maintainer="lucathar@gmail.com"
