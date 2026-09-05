#!/bin/bash
# Host-side smoke test: verifies the build artifact's shape. Full
# interactive validation (shell startup, applet behavior) happens
# inside a NeoOS boot via neoos-kernel's regression harness -- this
# repo has no NeoOS to boot on its own.
set -e

BIN="${1:-build/busybox.nex}"

[ -f "$BIN" ] || { echo "FAILED: $BIN missing"; exit 1; }

# A plain ELF64 executable -- nexify's NOX magic stamp is a FAT-disk
# convenience (keeps host tools from misreading a mounted executable)
# that embedfs has no need for: kernel/elf.c accepts both magics, and
# an embedfs-embedded blob is never browsed by host tools anyway.
python3 - "$BIN" <<'EOF'
import sys
with open(sys.argv[1], "rb") as f:
    data = f.read(20)
assert data[1:4] == b"ELF", f"not an ELF file: {data[1:4]!r}"
assert data[4] == 2, "not ELF64"
e_type = int.from_bytes(data[16:18], "little")
assert e_type == 2, f"not an executable (e_type={e_type})"
print("smoke-test: OK -- ELF64 executable")
EOF
