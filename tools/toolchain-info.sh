#!/bin/sh
set -eu
echo "atari-dev canonical Atari toolchain"
m68k-atari-mint-gcc --version | head -n 1
m68k-atari-mint-ld --version | head -n 1
echo "target: $(m68k-atari-mint-gcc -dumpmachine)"
