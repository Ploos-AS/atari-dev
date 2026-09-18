CC := m68k-atari-mintelf-gcc
BUILD := build
TARGET := $(BUILD)/HELLO.TOS

.PHONY: all check clean toolchain-info

all: $(TARGET)

$(BUILD):
	mkdir -p $@

$(TARGET): tests/hello-tos.c | $(BUILD)
	$(CC) -m68000 -Os -Wall -Wextra -o $@ $<

check: $(TARGET)
	test -s $(TARGET)
	file $(TARGET)
	@printf 'M2 atari-dev TOS artifact: PASS\n'

toolchain-info:
	atari-toolchain-info

clean:
	rm -rf $(BUILD)
