FROM debian:13-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG BASE_URL=https://tho-otto.de/download/mint
ARG BINUTILS=binutils-2.45-mintelf-20250812-bin-linux64.tar.xz
ARG GCC=gcc-15.2.0-mintelf-20250810-bin-linux64.tar.xz
ARG MINTBIN=mintbin-0.4-mintelf-bin-linux64.tar.xz

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl file make xz-utils tar \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# FreeMiNT Linux m68k-atari-mintelf toolchain. The dated binutils/GCC
# archive names are the published Linux artifacts used by Atari ST tooling.
RUN set -eux; \
    for pkg in "$BINUTILS" "$GCC"; do \
      echo "Fetching $pkg"; \
      curl --fail --location --show-error --silent -o "$pkg" "$BASE_URL/$pkg"; \
      tar -C / -xJf "$pkg"; \
      rm -f "$pkg"; \
    done

# MiNTBin's published page confirms the Linux artifact name, but its
# historical direct archive route is not stable. Build this small
# supplementary tool set from the official FreeMiNT source instead.
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends git build-essential autoconf automake texinfo; \
    git clone https://github.com/freemint/mintbin.git /tmp/mintbin; \
    git -C /tmp/mintbin checkout 536a0419562ffe9352715fe8e6bbea842b593735; \
    mkdir -p /tmp/mintbin-build; \
    cd /tmp/mintbin-build; \
    /tmp/mintbin/configure --prefix=/usr/m68k-atari-mintelf; \
    make; \
    make install; \
    rm -rf /tmp/mintbin /var/lib/apt/lists/*

ENV PATH="/usr/m68k-atari-mintelf/bin:/usr/m68k-atari-mintelf/usr/bin:${PATH}"

WORKDIR /work
COPY tools/toolchain-info.sh /usr/local/bin/atari-toolchain-info
RUN chmod +x /usr/local/bin/atari-toolchain-info

LABEL org.opencontainers.image.source="https://github.com/Ploos-AS/atari-dev" \
      org.opencontainers.image.description="Ploos-AS standard Debian Atari 68k development environment"

CMD ["/bin/sh"]
