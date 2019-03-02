FROM ubuntu:cosmic

RUN \
  apt-get update && \
  apt-get install -y libphobos2-ldc-shared81 zlib1g-dev libssl-dev && \
  rm -rf /var/lib/apt/lists/*

COPY hellorest /

USER nobody

ENTRYPOINT ["/hellorest"]
