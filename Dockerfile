FROM ubuntu:cosmic

RUN \
  apt-get update && \
  apt-get install -y libphobos2-ldc-shared81 zlib1g libssl1.1 && \
  rm -rf /var/lib/apt/lists/*

COPY hellorest /

USER nobody

ENTRYPOINT ["/hellorest"]
