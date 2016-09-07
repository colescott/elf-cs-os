# Declare constants used for creating a multiboot header.
.set ALIGN,    1<<0             # align loaded modules on page boundaries
.set MEMINFO,  1<<1             # ask grub to provide memory map
.set FLAGS,    ALIGN | MEMINFO  # Multiboot 'flag' field
.set MAGIC,    0x1BADB002       # 'magic number' lets bootloader find the header
.set CHECKSUM, -(MAGIC + FLAGS) # checksum of above, to prove we are multiboot

# Declare Multiboot Standard header
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

# Set stack pointer to new address with 16Kib of stack size
.section .bootstrap_stack, "aw", @nobits
stack_bottom:
.skip 16384
stack_top:

# start section of kernel
.section .text
.global _start
.type _start, @function
_start:
	# set stack pointer to top of stack
	movl $stack_top, %esp

    push %eax # pass multiboot magic number to kernel_early
    push %ebx # pass multiboot info to kernel_early

	# Run early kernel stuff
	call kernel_early

	# Call global constructors
	# call _init

	# Call main kernel
	call kernel_main

	# Hang on kernel crash
	cli
	hlt
.Lhang:
	jmp .Lhang

# c function gdt_flush();
#.global _gdt_flush     # Allows the C code to link to this
#.extern gp            # Says that 'gp' is in another file
#.type _gdt_flush, @function
#_gdt_flush:
#    lgdt gp        # Load the GDT with our '_gp' which is a special pointer
#    mov %ax, 0x10      # 0x10 is the offset in the GDT to our data segment
#    mov %ds, %ax
#    mov %es, %ax
#    mov %fs, %ax
#    mov %gs, %ax
#    mov %ss, %ax
#    ljmp $0x08, $flush2   # 0x08 is the offset to our code segment: Far jump!
#flush2:
#    ret               # Returns back to the C code!

# c function idt_load();'
#.global _idt_load
#.extern idtp
#.type _idt_load, @function
#_idt_load:
#    lidt idtp
#    ret

# Set the size of the _start symbol to the current location '.' minus its start.
.size _start, . - _start
