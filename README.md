# atari-dev

Standard containerized Atari 68k development environment for Ploos-AS projects.

## Purpose

`atari-dev` is the canonical build and tooling environment for Atari ST-family software projects. Individual repositories should consume this environment instead of maintaining their own compiler bootstrap.

M1 establishes a reproducible cross-toolchain based on Debian's `m68k-linux-gnu` binutils/GCC packages and a freestanding 68000 smoke artifact. The smoke artifact deliberately has no TOS dependency; TOS/GEM SDK integration is reserved for M2 so we do not pretend a Linux ABI cross-compiler is itself a complete Atari SDK.

## M1 usage

Build the container:

```sh
docker build -t atari-dev:m1 -f Containerfile .
```

Inspect toolchain metadata:

```sh
docker run --rm atari-dev:m1 tools/toolchain-info.sh
```

Build and validate the 68000 smoke artifact:

```sh
docker run --rm -v "$PWD:/work" atari-dev:m1 make check
```

The output `build/m68k-smoke.elf` is a freestanding Motorola 68000 ELF used to prove the compiler/linker baseline. M2 will add a TOS-native application contract suitable for execution by `atari-runtime`.

## Relationship to atari-runtime

Use `atari-dev` to build artifacts. Use [Ploos-AS/atari-runtime](https://github.com/Ploos-AS/atari-runtime) to execute and qualify Atari-native artifacts under emulation.

No proprietary Atari ROM/TOS images belong in this repository or its container image.

## Ploos-AS standards

- Software, ROM and firmware: MIT by default unless an inherited licence applies.
- Documentation and educational material: CC BY-SA 4.0 by default unless an inherited licence applies.
- Documentation source: Markdown, with `Ploos-AS/Documentation-Tools` used where applicable.

## Status

**M0 — Foundation — PASS**

**M1 — Toolchain baseline — PASS (static/repository qualification)**

The cross-toolchain, metadata probe, 68000 smoke build and GitHub Actions qualification are defined. A TOS-native SDK/application is intentionally M2 scope.
