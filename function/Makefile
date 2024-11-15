BUILD_DIR := ./build

$(BUILD_DIR)/function-x86.o:
	mkdir -p $(dir $@)
	nasm -o $@ -f elf32 function-x86.s

function-x86: $(BUILD_DIR)/function-x86.o
	ld -o $(BUILD_DIR)/function-x86 $?

clean:
	rm -R $(BUILD_DIR)

run: clean function-x86
	./build/function-x86

