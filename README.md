# atari-dev

Standard containerized Atari 68k development environment for Ploos-AS projects.

## M2 — TOS application toolchain

M2 uses the FreeMiNT **m68k-atari-mintelf** GCC toolchain as the canonical Atari application compiler. The container remains Debian 13 and installs the upstream Linux cross-tool archives directly; it has no Ubuntu/PPA dependency.

The ELF toolchain refers to the object-file/toolchain format. It still produces Atari executable output suitable for the runtime qualification path. Binutils and GCC are pinned to the dated upstream Linux artifacts.

### Qualification

```sh
docker build -t atari-dev:m2 -f Containerfile .
docker run --rm -v "$PWD:/work" atari-dev:m2 make clean check
```

The qualification artifact is `build/HELLO.TOS`. No TOS ROM is required to compile it and no proprietary Atari ROM material is included.

GitHub Actions qualification run `35371308264` passed on 2026-09-18 and built/uploaded `HELLO.TOS`.

## Licensing

This repository's own software/infrastructure follows the Ploos-AS MIT standard. Third-party toolchain packages retain their upstream licences and notices and are not relicensed as MIT.

Documentation follows CC BY-SA 4.0 where applicable.

## Status

- M0 — Foundation — PASS
- M1 — 68000 toolchain baseline — PASS
- M2 — TOS application toolchain — **PASS**
