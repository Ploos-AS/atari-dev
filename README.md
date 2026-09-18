# atari-dev

Standard containerized Atari 68k development environment for Ploos-AS projects.

## Purpose

`atari-dev` is the canonical build and tooling environment for Atari ST-family software projects. It exists so individual repositories do not need to maintain their own compiler/toolchain bootstrap logic.

Initial M0 scope targets Atari ST/STE development first, with room for TT/Falcon support where relevant later.

## M0 baseline

- reproducible container-based development environment
- m68k cross-development toolchain
- common build tools and scripting utilities
- Atari/TOS-oriented project templates and validation hooks
- CI-friendly, non-interactive baseline
- no proprietary Atari ROM/TOS images in the repository or container image

## Relationship to atari-runtime

Use `atari-dev` to build artifacts. Use [`Ploos-AS/atari-runtime`](https://github.com/Ploos-AS/atari-runtime) to execute and qualify those artifacts under Atari emulation.

## Ploos-AS standards

- Software, ROM and firmware: MIT by default unless an inherited licence applies.
- Documentation and educational material: CC BY-SA 4.0 by default unless an inherited licence applies.
- Documentation source: Markdown, with `Ploos-AS/Documentation-Tools` used for generated documentation where applicable.

## Status

**M0 — Foundation — IN PROGRESS**

M0 establishes repository structure, licensing, container baseline and the contract with `atari-runtime`.
