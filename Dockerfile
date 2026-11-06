# syntax=docker.io/docker/dockerfile:1
FROM --platform=linux/amd64 ghcr.io/truthwhisper/deb-67:latest

CMD [ "/bin/bash" ]

LABEL maintainer="lucathar@gmail.com"
