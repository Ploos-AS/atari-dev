CC := m68k-atari-mintelf-gcc
BUILD := build
TOS_TARGET := $(BUILD)/HELLO.TOS
PRG_TARGET := $(BUILD)/HELLO.PRG

.PHONY: all check clean toolchain-info

all: $(TOS_TARGET) $(PRG_TARGET)

$(BUILD):
	mkdir -p $@

$(TOS_TARGET): tests/hello-tos.c | $(BUILD)
	$(CC) -m68000 -Os -Wall -Wextra -o $@ $<

$(PRG_TARGET): tests/hello-tos.c | $(BUILD)
	$(CC) -m68000 -Os -Wall -Wextra -o $@ $<

check: all
	test -s $(TOS_TARGET)
	test -s $(PRG_TARGET)
	file $(TOS_TARGET)
	file $(PRG_TARGET)
	@printf 'M2 atari-dev TOS + PRG artifacts: PASS\n'

toolchain-info:
	atari-toolchain-info

clean:
	rm -rf $(BUILD)
