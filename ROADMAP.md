# Roadmap

## M0 — Foundation — PASS

## M1 — Generic 68000 toolchain baseline — PASS

## M2 — TOS application toolchain — PASS

- FreeMiNT m68k-atari-mint GCC
- Linux-native container installation
- 68000 TOS qualification program
- reproducible container build contract
- artifact hand-off to atari-runtime
- third-party licences preserved

GitHub Actions run `35371308264` successfully built and uploaded `build/HELLO.TOS` on 2026-09-18.

## M3 — Consumer integration — PAUSED AFTER STABLE RUNTIME BASELINE

- stable `atari-runtime@v1` reusable qualification for ST/STE — PASS
- reusable consumer workflow
- ST/STE matrix
- standard artifact metadata
- assembler/vlink support
- debugger/tooling additions

## M4 — Extended targets

- TT/Falcon
- additional libraries
- cross-emulator qualification

### M3 stable checkpoint
- `MINIMAL.PRG` consumer qualification through `atari-runtime@v1` — PASS
- ST and STE guest execution — PASS
- GitHub Actions run `37121828700` — PASS
- assembler/vlink, debugger/tooling and later extended-target work remain deferred until development resumes
