#!/bin/bash
# BusyBox smoke test for NeoOS
# Runs after /busybox.nex is installed in the OS image

set -e

echo "=== BusyBox Smoke Test ==="

# Test: shell can start
/busybox sh -c "echo hello" > /tmp/test.txt 2>&1 || {
    echo "FAILED: shell startup"
    exit 1
}

# Test: output is correct
[ "$(cat /tmp/test.txt)" = "hello" ] || {
    echo "FAILED: echo command"
    cat /tmp/test.txt
    exit 1
}

# Test: basic utilities exist
/busybox ls / > /dev/null || {
    echo "FAILED: ls command"
    exit 1
}

echo "PASSED: BusyBox basic functionality"
exit 0
