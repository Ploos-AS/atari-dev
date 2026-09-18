CC ?= m68k-linux-gnu-gcc
READELF ?= m68k-linux-gnu-readelf
CFLAGS := -m68000 -Os -ffreestanding -fno-builtin -nostdlib
LDFLAGS := -nostdlib -Wl,-e,_start
BUILD := build
TARGET := $(BUILD)/m68k-smoke.elf

.PHONY: all check clean toolchain-info

all: $(TARGET)

$(BUILD):
	mkdir -p $@

$(TARGET): tests/m68k-smoke.c | $(BUILD)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<

check: $(TARGET)
	$(READELF) -h $(TARGET) | grep -q 'Machine:.*MC68000'
	file $(TARGET)
	@echo "M1 atari-dev smoke qualification: PASS"

toolchain-info:
	tools/toolchain-info.sh

clean:
	rm -rf $(BUILD)
