FROM debian:13-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential \
       ca-certificates \
       cmake \
       curl \
       file \
       git \
       make \
       ninja-build \
       pkg-config \
       python3 \
       python3-pip \
       unzip \
       xz-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work

LABEL org.opencontainers.image.source="https://github.com/Ploos-AS/atari-dev" \
      org.opencontainers.image.description="Ploos-AS standard Atari 68k development environment"

CMD ["/bin/bash"]
