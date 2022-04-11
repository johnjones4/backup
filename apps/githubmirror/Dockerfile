FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  curl \
  gpg

RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null

RUN apt-get update && apt-get install -y \
  git \
  gh

ENV ORG_FILE="/config/orgs"
ENV DATA_DIR="/data"

WORKDIR /src/app

COPY mirror.sh mirror.sh
COPY run.sh run.sh

VOLUME [ "/root/.ssh", "/data", "/config" ]

CMD [ "./run.sh" ]
