#include "multiboot.h"]

#include "tty.h"

void kernel_early(unsigned long magic, unsigned long addr)
{

}

void kernel_main(void)
{
    initTty();
    printf("Hello, kernel world!");
    while(1) {}
}
