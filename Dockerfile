FROM ubuntu:xenial

RUN apt-get update && apt-get upgrade && apt-get install -y libssl-dev

COPY hellorest /

CMD /hellorest
