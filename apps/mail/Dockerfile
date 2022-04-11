FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  make \
  gcc \
  wget \
  libsecret-1-dev \
  pkg-config \
  pass \
  openssl \
  offlineimap \
  curl

WORKDIR /src

RUN wget https://golang.org/dl/go1.15.15.linux-$(dpkg --print-architecture).tar.gz
RUN tar zxvf go1.15.15.linux-$(dpkg --print-architecture).tar.gz

RUN wget https://github.com/ProtonMail/proton-bridge/archive/refs/tags/v1.8.10.tar.gz
RUN tar zxvf v1.8.10.tar.gz

WORKDIR /src/proton-bridge-1.8.10
RUN PATH=/src/go/bin:$PATH make install-dev-dependencies
RUN PATH=/src/go/bin:$PATH make build-nogui

WORKDIR /src/app

COPY run.sh run.sh

VOLUME [ "/config", "/data", "/root/.config", "/root/.gnupg", "/root/.password-store" ]

CMD [ "./run.sh" ]
