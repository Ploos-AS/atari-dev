FROM debian:13-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG BINUTILS_VERSION=2.45
ARG GCC_VERSION=15.2.0
ARG MINTBIN_VERSION=0.4
ARG MINTLIB_VERSION=0.60.1
ARG FDlibm_VERSION=20240425

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl file make xz-utils tar \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# Official prebuilt Linux cross-tools from the FreeMiNT/Thomas Otto distribution.
# They are host Linux binaries and install into /usr/m68k-atari-mint and
# /usr/lib/gcc/m68k-atari-mint. No Ubuntu/PPA dependency is used.
RUN set -eux; \
    for pkg in \
      "binutils-${BINUTILS_VERSION}-mint-bin-linux64.tar.xz" \
      "gcc-${GCC_VERSION}-mint-bin-linux64.tar.xz" \
      "mintbin-${MINTBIN_VERSION}-mint-bin-linux64.tar.xz" \
      "mintlib-${MINTLIB_VERSION}-mint.tar.xz" \
      "fdlibm-${FDlibm_VERSION}-mint.tar.xz"; do \
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
