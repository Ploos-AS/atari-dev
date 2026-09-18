# atari-dev

Standard containerized Atari 68k development environment for Ploos-AS projects.

## Purpose

`atari-dev` is the canonical build and tooling environment for Atari ST-family software projects.

M2 adopts the **m68k-atari-mint** ABI/toolchain family as the canonical Atari application target. This is the established GCC target used to produce TOS executables such as `.PRG`, `.TOS` and `.TTP`. The toolchain is built from source by the container build; Atari TOS ROM images are neither required for compilation nor distributed here.

## Milestones

- **M0 — Foundation — PASS**
- **M1 — generic 68000 cross-toolchain baseline — PASS**
- **M2 — TOS application toolchain contract — IMPLEMENTED / CI qualification pending**

## M2 contract

Canonical compiler prefix:

```
m68k-atari-mint-
```

The M2 qualification program is a console TOS application and must produce `build/HELLO.TOS`. Consumer Atari projects should build inside this environment rather than install private cross-toolchains.

The container pins the cross-toolchain source repository to an explicit revision through `MINT_TOOLCHAIN_REF`. Updating that revision is an intentional infrastructure change.

## Relationship to atari-runtime

`atari-dev` builds the TOS artifact. [Ploos-AS/atari-runtime](https://github.com/Ploos-AS/atari-runtime) executes the same artifact with Hatari.

Compilation and CI do not require proprietary Atari material. Runtime qualification can use a user-supplied legal TOS image; later we can additionally qualify against a redistributable open TOS implementation where appropriate.

## Ploos-AS standards

- Software, ROM and firmware: MIT by default unless inherited licensing applies.
- Documentation and educational material: CC BY-SA 4.0 by default.
- Markdown is canonical documentation source.
- Proprietary TOS/ROM images must not be committed or embedded in the container.
