FROM debian:13-slim AS toolchain

ARG DEBIAN_FRONTEND=noninteractive
ARG MINT_TOOLCHAIN_REPO=https://github.com/pd95/m68k-atari-mint-cross-tools.git
ARG MINT_TOOLCHAIN_REF=master

RUN apt-get update && apt-get install -y --no-install-recommends \
    autoconf automake bison build-essential ca-certificates curl flex gawk git \
    libgmp-dev libmpc-dev libmpfr-dev libtool lzip make patch pkg-config \
    python3 texinfo wget xz-utils && rm -rf /var/lib/apt/lists/*

RUN git clone "$MINT_TOOLCHAIN_REPO" /src/mint \
 && cd /src/mint \
 && git checkout "$MINT_TOOLCHAIN_REF" \
 && sed -i -E 's/CC="gcc -arch \$\(ARCH\)"/CC="gcc"/g; s/CXX="g\+\+ -arch \$\(ARCH\)"/CXX="g++"/g' Makefile.* \
 && (make PREFIX=/opt/cross-mint all || { find /src/mint/compile -name config.log -print -exec tail -n 120 {} \\; ; exit 1; })

FROM debian:13-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates file make \
 && rm -rf /var/lib/apt/lists/*
COPY --from=toolchain /opt/cross-mint /opt/cross-mint
ENV PATH="/opt/cross-mint/bin:${PATH}"
WORKDIR /work
COPY tools/toolchain-info.sh /usr/local/bin/atari-toolchain-info
RUN chmod +x /usr/local/bin/atari-toolchain-info
LABEL org.opencontainers.image.source="https://github.com/Ploos-AS/atari-dev"
CMD ["/bin/sh"]
