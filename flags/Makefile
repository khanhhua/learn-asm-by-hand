SRC := ./arith-x86.s
BUILD_DIR := ./build

$(BUILD_DIR)/arith-x86.o:
	mkdir -p $(dir $@)
	nasm -o $@ -f elf32 arith-x86.s

arith-x86: $(BUILD_DIR)/arith-x86.o
	ld -o $(BUILD_DIR)/$@ $?

clean:
	rm -R $(BUILD_DIR)

run: clean arith-x86
	$(BUILD_DIR)/arith-x86
	
