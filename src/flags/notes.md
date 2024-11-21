Notes on Flags and Jumps
====

First of all, I still don't understand why the jmp operation alone in `jumps.s` works as expected but not in arith-x86.s.

**jmp** is a unconditional jump. Either relative by `$ + 2` to jump 1 instruction, `$ + 4` to jump 2 instructions on a 32bit machine or by `.label_name`.

jCONDITION where CONDITION is a CPU flag. For example: js means jump if the SIGN FLAG is 1, jns means jump if the SIGN FLAG is 0. Most often `jnz` is used after **test** and **cmp**.

Unsigned numeric and negative numeric data type is represented by the same series of bits in memory. It depends on the SIGN FLAG and ZERO FLAG to correctly interpret such memory occupation. For example, on a 32bit machine:

- 0xFFFFFFFF means -1 when SIGN FLAG is 1
- 0xFFFFFFFF means 4294967295 when SIGN FLAG is 0
