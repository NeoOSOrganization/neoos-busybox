# BusyBox for NeoOS

BusyBox port: interactive shell (ash), file utilities, and core utilities for NeoOS.

## Quick Start

Build (requires musl and kernel):

```bash
git clone https://github.com/NeoOSOrganization/neoos-musl ../neoos-musl
cd ../neoos-musl && make

git clone https://github.com/NeoOSOrganization/neoos-busybox
cd neoos-busybox
make MUSL_DIR=../neoos-musl/build-output
# Produces: build/busybox.nex
```

## Features

- Interactive ash shell
- 200+ coreutils replacements
- File utilities (cp, mv, rm, etc.)
- Static linked with musl libc

## Usage

In NeoOS `/ETC/INITTAB`:

```
::once:/BUSYBOX ash
```

Then boot NeoOS and you have a shell.

## Build Details

- Statically linked with musl + NeoOS syscall shim
- Single `.nex` binary
- Minimal BusyBox config (no X11, no C library features beyond musl)

## Smoke Test

```bash
make smoke-test
# Runs basic shell tests in NeoOS environment
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