FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  curl \
  unzip

WORKDIR /src

RUN curl https://rclone.org/install.sh | bash

COPY run.sh run.sh

VOLUME [ "/root/.config/rclone", "/data" ]

CMD [ "./run.sh" ]
