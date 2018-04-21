FROM debian:stretch

COPY ./scripts/install-image-builder-dependencies /usr/local/bin/

RUN apt-get update \
  && install-image-builder-dependencies \
  && rm -rf /var/lib/apt/lists/*

COPY ./scripts/* /usr/local/bin/

WORKDIR /build
VOLUME [ "/build" ]
