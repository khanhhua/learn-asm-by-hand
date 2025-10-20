SRCS := $(shell find ./src -iname *.s)
BUILD_DIR := build
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
PROGS := $(SRCS:%.s=$(BUILD_DIR)/%)

$(BUILD_DIR)/%.s.o: %.s
	mkdir -p $(dir $@)
	nasm -o $@ -f elf32 -g -F dwarf $?

$(BUILD_DIR)/%: $(BUILD_DIR)/%.s.o
	ld -o $@ $?

run:
	make $(BUILD_DIR)/src/$(MOD) && \
		$(BUILD_DIR)/src/$(MOD)

debug:
	make $(BUILD_DIR)/src/$(MOD) && \
		gdb $(BUILD_DIR)/src/$(MOD)

clean:
	rm -rf $(BUILD_DIR)

build-all: $(PROGS)

%: clean build/%
	$(BUILD_DIR)/$@

