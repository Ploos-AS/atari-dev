FROM debian:13-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG BASE_URL=https://tho-otto.de/download/mint
ARG BINUTILS=binutils-2.45-mintelf-20250812-bin-linux64.tar.xz
ARG GCC=gcc-15.2.0-mintelf-20250810-bin-linux64.tar.xz
ARG MINTBIN=mintbin-0.4-mintelf-bin-linux64.tar.xz
ARG MINTLIB_URL=https://atari.joska.no/snapshots/mintlib/mintlib-mintelf-latest.tar.bz2

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
    rm -rf /tmp/mintbin /tmp/mintbin-build /var/lib/apt/lists/*


# MiNTLib is the standard libc for FreeMiNT. Upstream publishes a dedicated
# mintelf snapshot; install it into the cross-toolchain prefix.
RUN set -eux; \
    curl --fail --location --show-error --silent -o /tmp/mintlib.tar.bz2 "$MINTLIB_URL"; \
    echo "MiNTLib archive layout:"; \
    tar -tjf /tmp/mintlib.tar.bz2 | head -n 80; \
    mkdir -p /tmp/mintlib-extract; \
    tar -C /tmp/mintlib-extract -xjf /tmp/mintlib.tar.bz2; \
    echo "MiNTLib extracted directories:"; \
    find /tmp/mintlib-extract -maxdepth 4 -type d | sort | head -n 100; \
    echo "stdio.h locations:"; \
    find /tmp/mintlib-extract -name stdio.h -print; \
    cp -a /tmp/mintlib-extract/. /; \
    echo "GCC sysroot: $(m68k-atari-mintelf-gcc -print-sysroot)"; \
    echo "GCC search dirs:"; m68k-atari-mintelf-gcc -print-search-dirs; \
    printf "" | m68k-atari-mintelf-gcc -m68000 -v -E -x c - >/tmp/gcc-preprocess.out 2>/tmp/gcc-preprocess.err || true; \
    cat /tmp/gcc-preprocess.err; \
    rm -rf /tmp/mintlib.tar.bz2 /tmp/mintlib-extract /tmp/gcc-preprocess.out /tmp/gcc-preprocess.err

ENV PATH="/usr/m68k-atari-mintelf/bin:/usr/m68k-atari-mintelf/usr/bin:${PATH}"

WORKDIR /work
COPY tools/toolchain-info.sh /usr/local/bin/atari-toolchain-info
RUN chmod +x /usr/local/bin/atari-toolchain-info

LABEL org.opencontainers.image.source="https://github.com/Ploos-AS/atari-dev" \
      org.opencontainers.image.description="Ploos-AS standard Debian Atari 68k development environment"

CMD ["/bin/sh"]
