#!/bin/sh
set -eu

echo "atari-dev toolchain"
m68k-linux-gnu-gcc --version | head -n 1
m68k-linux-gnu-ld --version | head -n 1
echo "target: Motorola 68000"
