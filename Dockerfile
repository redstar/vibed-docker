FROM ubuntu:bionic

RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y libphobos2-ldc-shared78 zlib1g-dev libssl-dev && \
  rm -rf /var/lib/apt/lists/*

COPY hellorest /

USER nobody

ENTRYPOINT ["/hellorest"]
