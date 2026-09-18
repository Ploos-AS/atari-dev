# atari-dev

Standard containerized Atari 68k development environment for Ploos-AS projects.

## M2 — TOS application toolchain

M2 uses the **FreeMiNT m68k-atari-mint GCC toolchain** as the canonical TOS application compiler. The Debian container consumes the official Linux cross-tool archives published by Thorsten Otto's FreeMiNT cross-tools distribution. The package set is pinned to dated archive names so CI is reproducible and does not depend on Ubuntu/PPA packaging. citeturn7search0turn10search0

The resulting toolchain provides the `m68k-atari-mint-gcc` target used for Atari ST/TOS software. FreeMiNT maintains the corresponding GCC and binutils projects. citeturn2search1turn2search4

### Qualification

```sh
docker build -t atari-dev:m2 -f Containerfile .
docker run --rm -v "$PWD:/work" atari-dev:m2 make clean check
```

The qualification artifact is:

```
build/HELLO.TOS
```

No TOS ROM is required to compile it and no proprietary Atari ROM material is included.

## Licensing

This repository's own software/infrastructure follows the Ploos-AS MIT standard. Third-party toolchain packages retain their own upstream licences and notices; they are not relicensed as MIT.

Documentation follows CC BY-SA 4.0 where applicable.

## Status

- M0 — Foundation — PASS
- M1 — 68000 toolchain baseline — PASS
- M2 — TOS application toolchain — **IMPLEMENTED; GitHub qualification pending**
