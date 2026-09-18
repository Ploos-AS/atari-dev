#!/bin/sh
set -eu
echo "atari-dev canonical Atari toolchain"
m68k-atari-mintelf-gcc --version | head -n 1
m68k-atari-mintelf-gcc -dumpmachine
printf '68000 baseline: '
m68k-atari-mintelf-gcc -m68000 -dM -E - </dev/null | grep -q '__m68k__' && echo PASS
