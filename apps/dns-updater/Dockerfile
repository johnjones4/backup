FROM debian:buster

WORKDIR /usr/src

RUN apt-get update && apt-get install -y dnsutils curl zip

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

WORKDIR /usr/src/app

COPY . .

CMD ["./run.sh"]
