FROM ubuntu:bionic

RUN apt-get update && apt-get upgrade && apt-get install -y libssl-dev

COPY hellorest /

CMD /hellorest
