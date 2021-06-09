name=hello_world

gnu_toolchain := riscv32-unknown-elf-
#gnu_toolchain := riscv32-unknown-linux-gnu-
program_name := $(name)_elf
#program_name := $(name)_linux



exe_file=$(program_name).out
static_exe_file=$(program_name)_static.out
obj_file=$(program_name).o
asm_file=$(program_name).s
pre_file=$(program_name).i
lib_file=$(program_name).a
dump_file=$(program_name).dump
static_dump_file=$(program_name)_static.dump
cpp_file=$(name).cpp

all:$(exe_file) $(obj_file) $(asm_file) $(pre_file) $(dump_file) $(static_dump_file) $(static_exe_file) $(lib_file)

$(exe_file):$(cpp_file)
	$(gnu_toolchain)g++ -Wall -o $@ $<

$(static_exe_file):$(cpp_file)
	$(gnu_toolchain)g++ -static -Wall -o $@ $<

$(obj_file):$(asm_file)
	$(gnu_toolchain)as -Wall -o $@ $<

$(asm_file):$(pre_file)
	$(gnu_toolchain)g++ -Wall -S -o $@ $<

$(pre_file):$(cpp_file)
	$(gnu_toolchain)cpp -Wall -o $@ $<

$(dump_file):$(exe_file)
	$(gnu_toolchain)objdump -S $< > $@

$(static_dump_file):$(static_exe_file)
	$(gnu_toolchain)objdump -S $< > $@

$(lib_file):$(obj_file)
	$(gnu_toolchain)ar rc -o $@ $<



.PHONY:clean
clean:
	rm -rf $(exe_file) $(obj_file) $(asm_file) $(pre_file) $(dump_file) $(static_dump_file) $(static_exe_file) $(lib_file)



