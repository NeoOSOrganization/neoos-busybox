# BusyBox port for NeoOS.
#
# Config lives in config/ (mirrors neoos-kernel's third_party/shim
# pattern): upstream/ stays a pristine submodule, config/apply.sh does
# allnoconfig + a fragment rather than checking in a whole .config, so
# a version bump takes upstream's default for options the fragment
# does not name.
MUSL_DIR ?= ../neoos-musl/build-output
BUSYBOX_DIR ?= upstream
BUILD_DIR ?= build

.PHONY: all clean smoke-test

all: $(BUILD_DIR)/busybox.nex

$(BUILD_DIR)/busybox.nex: config/apply.sh config/neoos.fragment config/neoos.unbuildable config/setconfig.py user.ld
	@[ -f "$(MUSL_DIR)/lib/libc.a" ] || { echo "error: musl not found at $(MUSL_DIR); build neoos-musl first" >&2; exit 1; }
	MUSL_DIR=$(abspath $(MUSL_DIR)) BUSYBOX_DIR=$(abspath $(BUSYBOX_DIR)) config/apply.sh
	$(MAKE) -C $(BUSYBOX_DIR) -j$(shell nproc)
	@mkdir -p $(BUILD_DIR)
	cp $(BUSYBOX_DIR)/busybox $(BUILD_DIR)/busybox.nex
	cp config/busybox.test.json $(BUILD_DIR)/busybox.test.json

clean:
	rm -rf $(BUILD_DIR)
	$(MAKE) -C $(BUSYBOX_DIR) clean 2>/dev/null || true
	rm -f $(BUSYBOX_DIR)/.config $(BUSYBOX_DIR)/.neoos-symbols

smoke-test: $(BUILD_DIR)/busybox.nex
	./smoke-test.sh
