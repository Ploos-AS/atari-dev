# Roadmap

## M0 — Foundation — PASS
- repository baseline
- MIT software licence
- container skeleton
- dev/runtime separation

## M1 — Toolchain baseline — PASS
- generic Debian m68k GCC/binutils
- explicit 68000 smoke artifact
- GitHub Actions qualification

## M2 — TOS SDK and project integration — IMPLEMENTED / CI PENDING
- canonical `m68k-atari-mint` toolchain contract
- source-built and revision-pinned toolchain
- real TOS executable qualification artifact
- artifact exported from GitHub Actions
- runtime hand-off contract

M2 is PASS only after the GitHub runner has built the container and produced a valid `HELLO.TOS` artifact.

## M3 — Consumer integration
- reusable consumer workflow
- project template
- ST/STE application qualification matrix
- align with atari-runtime evidence format

## M4 — Extended targets
- evaluate TT/Falcon
- cross-emulator qualification
