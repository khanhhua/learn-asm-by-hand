# https://makefiletutorial.com
# For a production ready Makefile https://makefiletutorial.com/#makefile-cookbook
BUILD_DIR := ./build

$(BUILD_DIR)/hello-x86.o:
	mkdir -p $(dir $@)
	nasm -o $(BUILD_DIR)/hello-x86.o -f elf32 hello-x86.s

hello-x86: $(BUILD_DIR)/hello-x86.o
	ld -o $(BUILD_DIR)/hello-x86 -g $(BUILD_DIR)/hello-x86.o

.PHONY: clean
clean:
	rm -r $(BUILD_DIR)

run: clean hello-x86
	./build/hello-x86
