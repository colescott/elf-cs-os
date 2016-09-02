NAME = elf-cs-os

AR = i686-elf-ar
AS = i686-elf-as
CC = i686-elf-gcc
CPPC= i686-elf-g++

WARNINGS := -Wall -Wextra -pedantic -Wshadow -Wpointer-arith -Wcast-align \
            -Wwrite-strings -Wmissing-prototypes -Wmissing-declarations \
            -Wredundant-decls -Wnested-externs -Winline -Wno-long-long \
            -Wuninitialized -Wconversion -Wstrict-prototypes
CFLAGS := -std=gnu99 -ffreestanding -O2 $(WARNINGS)
CPPFLAGS := -ffreestanding -O2 $(WARNINGS) -fno-exceptions -fno-rtti

SRCFILES=$(shell find . -type f -name '*.c') $(shell find . -type f -name '*.s') $(shell find . -type f -name '*.cpp')
OBJS =$(patsubst %.c,%.o,$(shell find . -type f -name '*.c')) $(patsubst %.s,%.o,$(shell find . -type f -name '*.s')) $(patsubst %.cpp,%.o,$(shell find . -type f -name '*.cpp'))

LINKERLD = kernel/boot/linker.ld
LINKERFLAGS = -ffreestanding -O2 -nostdlib -lgcc

HEADERFILES = $(addprefix -I, $(shell find kernel/include -type d -print)) $(addprefix -I, $(shell find libc/include -type d -print))

all: $(NAME).kernel

elf-cs-os.kernel: $(OBJS)
	$(CC) -T $(LINKERLD) -o $@ $(OBJS) $(LINKERFLAGS) $(CFLAGS)

%.o: %.cpp
	$(CPPC) -c $< -o $@ $(CPPFLAGS) $(HEADERFILES)

%.o: %.c
	$(CC) -c $< -o $@ $(CFLAGS) $(HEADERFILES)

%.o: %.s
	$(CC) -c $< -o $@ $(CFLAGS) $(CPPFLAGS) $(HEADERFILES)

install: install-headers install-kernel

install-kernel: $(NAME).kernel
	cp $(NAME).kernel iso/boot

iso: install-kernel
	grub-mkrescue -o $(NAME).iso iso

run: iso
	qemu-system-i386 -cdrom $(NAME).iso -m 1G

clean:
	rm -Rf $(NAME).kernel $(OBJS) $(NAME).iso iso/boot/$(NAME).kernel
todo:
	grep -r TODO .
