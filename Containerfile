FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends software-properties-common ca-certificates curl file make git build-essential \
 && add-apt-repository ppa:vriviere/ppa \
 && apt-get update \
 && apt-get install -y --no-install-recommends cross-mint-essential libcmini-m68k-atari-mint \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /work

COPY tools/toolchain-info.sh /usr/local/bin/atari-toolchain-info
RUN chmod +x /usr/local/bin/atari-toolchain-info

LABEL org.opencontainers.image.source="https://github.com/Ploos-AS/atari-dev" \
      org.opencontainers.image.description="Ploos-AS standard Atari 68k development environment"

CMD ["/bin/sh"]
