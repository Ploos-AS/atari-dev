FROM debian:13-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       binutils-m68k-linux-gnu \
       build-essential \
       ca-certificates \
       cmake \
       file \
       gcc-m68k-linux-gnu \
       git \
       make \
       ninja-build \
       pkg-config \
       python3 \
       xz-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work

COPY tools/toolchain-info.sh /usr/local/bin/atari-toolchain-info
RUN chmod +x /usr/local/bin/atari-toolchain-info

LABEL org.opencontainers.image.source="https://github.com/Ploos-AS/atari-dev" \
      org.opencontainers.image.description="Ploos-AS standard Atari 68k development environment"

CMD ["/bin/bash"]
