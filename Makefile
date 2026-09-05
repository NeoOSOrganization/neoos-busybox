# BusyBox port for NeoOS
# Stub implementation (full build in Phase 3)

MUSL_DIR ?= ../neoos-musl/build-output
BUILD_DIR ?= build

.PHONY: all clean smoke-test

all:
	@echo "BusyBox build: placeholder (implementation in Phase 3)"
	@echo "When complete, will:"
	@echo "  1. Configure BusyBox for NeoOS"
	@echo "  2. Link against musl from $(MUSL_DIR)"
	@echo "  3. Produce static binary at $(BUILD_DIR)/busybox.nex"

clean:
	rm -rf $(BUILD_DIR)

smoke-test:
	@echo "BusyBox smoke test: placeholder (runs in Phase 3)"
	@echo "Will verify: shell startup, basic commands (echo, ls, etc.)"
