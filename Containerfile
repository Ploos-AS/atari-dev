FROM debian:13-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG BINUTILS=binutils-2.45-mintelf-20250812-bin-linux64.tar.xz
ARG GCC=gcc-15.2.0-mint-bin-linux64.tar.xz
ARG MINTBIN=mintbin-0.4-mint-bin-linux64.tar.xz
ARG MINTLIB=mintlib-0.60.1-mint.tar.xz
ARG FDLIBM=fdlibm-20240425-mint.tar.xz

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl file make xz-utils tar \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# Official FreeMiNT/Thomas Otto Linux cross-tool packages.
# These are Linux host binaries, not Ubuntu/PPA packages.
RUN set -eux; \
    for pkg in "$BINUTILS" "$GCC" "$MINTBIN" "$MINTLIB" "$FDLIBM"; do \
      curl -fsSLO "https://tho-otto.de/download/mint/$pkg"; \
      tar -C / -xJf "$pkg"; \
      rm -f "$pkg"; \
    done

ENV PATH="/usr/m68k-atari-mint/bin:/usr/m68k-atari-mint/usr/bin:${PATH}"

WORKDIR /work

COPY tools/toolchain-info.sh /usr/local/bin/atari-toolchain-info
RUN chmod +x /usr/local/bin/atari-toolchain-info

LABEL org.opencontainers.image.source="https://github.com/Ploos-AS/atari-dev" \
      org.opencontainers.image.description="Ploos-AS standard Debian Atari 68k development environment"

CMD ["/bin/sh"]
