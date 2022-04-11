FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  lastpass-cli \
  curl

VOLUME [ "/config", "/data" ]

ENV LPASS_HOME=/config
ENV LPASS_DISABLE_PINENTRY=1

WORKDIR /src/app

COPY run.sh run.sh

CMD [ "./run.sh" ]
