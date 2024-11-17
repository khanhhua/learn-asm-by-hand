SRCS := $(wildcard *.s)
BUILD_DIR := ./build
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
PROGS := $(SRCS:%.s=$(BUILD_DIR)/%)

$(BUILD_DIR)/%.s.o: %.s
	mkdir -p $(dir $@)
	nasm -o $@ -f elf32 -g -F dwarf $?

$(BUILD_DIR)/%: $(BUILD_DIR)/%.s.o
	ld -o $@ $?

clean:
	rm -rf $(BUILD_DIR)

build-all: $(PROGS)

print: clean build/print
	$(BUILD_DIR)/print

