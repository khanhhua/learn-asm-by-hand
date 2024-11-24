Notes on Flags and Jumps
====

First of all, I still don't understand why the jmp operation alone in `jumps.s` works as expected but not in arith-x86.s.

**jmp** is a unconditional jump. Either relative by `$ + 2` to jump 1 instruction, `$ + 4` to jump 2 instructions on a 32bit machine or by `.label_name`.

jCONDITION where CONDITION is a CPU flag. For example: js means jump if the SIGN FLAG is 1, jns means jump if the SIGN FLAG is 0. Most often `jnz` is used after **test** and **cmp**.

Unsigned numeric and negative numeric data type is represented by the same series of bits in memory. It depends on the SIGN FLAG and ZERO FLAG to correctly interpret such memory occupation. For example, on a 32bit machine:

- 0xFFFFFFFF means -1 when SIGN FLAG is 1
- 0xFFFFFFFF means 4294967295 when SIGN FLAG is 0

## Function calls

Integral returned values can be allotted `EAX` register.
Complex structure can inhibit the stack.

Assuming stack is used to hold returned value, function calls follow this convention:

1. Push 0x0000000 onto stack
1. Push last param first
1. Push 1st param last
1. Invoke `call function_name` instruction
1. Pop top of stack to somewhere predefined

## Function definition

### Prologue

1. push value of outer stack base on top of stack
1. update `ebp` with the address of top of stack

```asm
push ebp
mov  ebp, esp
```

Proceed with function logical definitions

### Epilogue

1. reset top of stack back to `ebp`
1. pop the previous value `ebp` back to `ebp` register
1. invoke `ret N` where N is the parameter count

## How does it work?

It is critical to visualize the memory layout of the application physically on RAM concerning the code segment and the data segment. Stack belongs to the data segment with high memory address as the starting point, say 0xbFFFFFFF. Code segment contains actual executable instructions after object file is linked. Functions and labels directly refer to specific addresses within the code segment. Under the hood, a register named `eip` maintains the address of the instruction to be executed next, aka program counter, which automatically increments after each execution.

Invoking `call function_name` is evaluated as:

```asm
push eip
jmp function_name
```



```
              Code _start :              function_name:
Stack |---]---]---]---]---]---]---]---]---]---]---]---]---]---]
  &destination^           |   ^destination                    |
                 push eip⤶                            pop eip⤶ 
        jmp function_name
```

## `EBP` vs `ESP` registers

Word size of the underlying architecture determines how many bytes are pushed onto stack after each `push` operation. For IA32, it is 4 bytes.

`EBP` is a special register that holds an integer as the offset to top of the current stack, and should not be dereferenced. `ESP` is the register that holds the address of the top of stack. The follow equation must always hold:

```
address of top of outer stack frame = esp - old ebp
```

Local variables can be allocated on the stack by pushing stack OR using `sub N` operation in case of byte units (char, char array). The former mode guarantees that `esp` decrements by 4bytes on IA32 machines.

```
       ⤹ ⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯ v
esp -> 0xbFFFF530    0x01 0x00 0x00 0x00
       0xbFFFFF2C    0x00 0x00 0x00 0x00

```

With gdb utility, we can inspect for what byte value resides at `0xbFFFF530`

```bash
x /b $esp
0xbFFFF530:   0x01
```

Hence it is necessary to indicate the size of operand during the operations: `mov`, `add`, `and`, `or` because the machine must offset the size in order to determine the number of bytes to put at the precise address.

From `ESP`'s point of view, reading the address at `0bFFFFF530` must take into account how many bytes is concerned. Reading one byte at the given address is quite straight forward. Reading two bytes at an address follows little endian-encoding. Little Endian means "Little End" first, or least significant byte first. For example:

```
esp -> 0xbFFFF530:     0x00000fff

x /2b $esp
0xbFFFF530:            0xff   0x0f
```

which means

```
x /1b ($esp+1)
0xbFFFF531:             0x0f
```

Therefore one must be extra careful when reading the output of gdb `x` command.

