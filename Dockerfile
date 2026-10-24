FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive

LABEL maintainer="Truth W.perer <lucathar@gmail.com"

RUN apt update && apt upgrade -y && apt install -y ca-certificates tzdata apt-transport-https

CMD ["/bin/bash"]


