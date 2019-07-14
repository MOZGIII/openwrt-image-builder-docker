FROM debian:stretch AS su-exec
RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential \
  && rm -rf /var/lib/apt/lists/*
WORKDIR /usr/src/app
COPY ./su-exec/* ./
RUN make su-exec

FROM debian:stretch

COPY ./scripts/install-image-builder-dependencies /usr/local/bin/

RUN apt-get update \
  && install-image-builder-dependencies \
  && rm -rf /var/lib/apt/lists/*

RUN groupadd builder --gid 1000 \
  && useradd builder \
  --home-dir /build \
  --shell /bin/bash \
  --no-create-home \
  --uid 1000 \
  --gid 1000

COPY ./scripts/* /usr/local/bin/
COPY --from=su-exec /usr/src/app/su-exec /usr/local/bin/

WORKDIR /build
VOLUME [ "/build" ]
