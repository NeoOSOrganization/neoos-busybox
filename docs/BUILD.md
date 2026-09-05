# Building BusyBox for NeoOS

## Prerequisites

- x86_64-elf cross-compiler (from neoos-kernel toolchain)
- musl built from neoos-musl repository
- Standard build tools: make, gcc

## Build Steps

### 1. Ensure musl is built
```bash
cd ../neoos-musl
make
cd ../neoos-busybox
```

### 2. Configure BusyBox (optional)
```bash
cd upstream
make CROSS_COMPILE=x86_64-elf- menuconfig
cd ..
```

### 3. Build BusyBox
```bash
make MUSL_DIR=../neoos-musl/build-output
```

Expected output:
```
Building BusyBox...
OK BusyBox built at build/busybox.nex
-rwxr-xr-x  user group 1.5M build/busybox.nex
```

### 4. Verify build
```bash
make smoke-test
# Output: PASSED: BusyBox smoke tests
```

## Binary Output

- **Location:** `build/busybox.nex`
- **Size:** ~1.5MB (statically linked)
- **Format:** ELF 64-bit LSB executable, x86-64, statically linked
- **Symbols:** Linked against musl (no dynamic linker)

## Integration with NeoOS

### In kernel /ETC/INITTAB

```
::respawn:/BUSYBOX ash
```

### In OS builder

```bash
make ISO_CONTENTS="build/busybox.nex"
```

## Troubleshooting

### "musl not found at ../neoos-musl/build-output"
Ensure musl is built:
```bash
cd ../neoos-musl && make
```

### "x86_64-elf-gcc: command not found"
Add toolchain to PATH:
```bash
export PATH=../neoos-kernel/toolchain/x86_64-elf/bin:$PATH
```

### Build fails with ncurses error
BusyBox may try to use ncurses. Disable it:
```bash
cd upstream
make CROSS_COMPILE=x86_64-elf- menuconfig
# Disable: Networking Utilities → wget → SSL support
# Disable: Editors → vi → fancy vi
```

## Performance

- **Build time:** ~2-3 minutes
- **Binary size:** ~1.5MB (full featured)
- **Minimal size:** ~800KB (with menuconfig optimization)
