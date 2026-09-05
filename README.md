# BusyBox for NeoOS

BusyBox port: interactive shell (ash), file utilities, and core utilities for NeoOS.

## Quick Start

Build (requires musl):

```bash
git clone https://github.com/NeoOSOrganization/neoos-musl ../neoos-musl
cd ../neoos-musl && make KERNEL_SHIM_DIR=../neoos-kernel/third_party/shim

git clone https://github.com/NeoOSOrganization/neoos-busybox
cd neoos-busybox
git submodule update --init upstream
make MUSL_DIR=../neoos-musl/build-output
# Produces: build/busybox.nex + build/busybox.test.json
```

`config/apply.sh` configures the upstream submodule (allnoconfig + the
`config/neoos.fragment` overlay); the submodule itself stays a pristine
checkout, matching neoos-kernel's `third_party/shim` pattern.

## Using it with neoos-kernel

`build/busybox.test.json` is a manifest declaring exactly where
busybox's inittab entries (bbspike/nshtest/bbsh) go and which markers
they require — pass this repo's `build/` as one of neoos-kernel's
`EMBED_DIRS`:

```sh
cd ../neoos-kernel
make EMBED_DIRS=../neoos-busybox/build test
```

## Features

- Interactive ash shell
- 200+ coreutils replacements
- File utilities (cp, mv, rm, etc.)
- Static linked with musl libc

## Build Details

- Statically linked with musl + NeoOS syscall shim
- Single `.nex` binary
- Minimal BusyBox config (no X11, no C library features beyond musl)

## Smoke Test

```bash
make smoke-test
# Host-side: verifies build/busybox.nex is a valid ELF64 executable.
# Full interactive validation (shell startup, applet behavior) happens
# inside a NeoOS boot via neoos-kernel's regression harness -- this
# repo has no NeoOS to boot on its own.
```

## Documentation

- Port-specific notes: See `PORTING-NOTES.md`
- General porting guide: https://github.com/NeoOSOrganization/neoos-docs/blob/main/docs/porting.md
 - **[3D ASCII Viewer](https://github.com/NeoOSOrganization/neoos-3d-ascii-viewer)** — Another NeoOS port example

## License

BusyBox is GPL v2. NeoOS patches (if any) follow the same license.

## In This Organization

This is a **port template**. Each port is its own repository.

- **[neoos-kernel](https://github.com/NeoOSOrganization/neoos-kernel)** — Kernel (see syscalls, features)
- **[neoos-musl](https://github.com/NeoOSOrganization/neoos-musl)** — libc (ports link against this)
- **[neoos-os-builder](https://github.com/NeoOSOrganization/neoos-os-builder)** — Assembles final images with selected ports
- **[neoos-docs](https://github.com/NeoOSOrganization/neoos-docs)** — Porting guide and best practices
 - **[3D ASCII Viewer](https://github.com/NeoOSOrganization/neoos-3d-ascii-viewer)** — Another NeoOS port example