#include "multiboot.h"

#include "tty.h"

#include <stdbool.h>
#include <stdlib.h>

void kernel_early(multiboot_info_t* mbd, unsigned int magic)
{
    initTty();
    if(magic != MULTIBOOT_BOOTLOADER_MAGIC)
    {
        panic("BAD MAGIC NUMBER!!!11!");
        return;
    }

    if(mbd->flags & 0b1)
    {
        char* buffer;
        printf(itoa(mbd->mem_upper, buffer, 10));
        printf("kB upper\n");
        printf(itoa(mbd->mem_lower, buffer, 10));
        printf("kB lower\n");
        printf(itoa((mbd->mem_lower + mbd->mem_upper) / 1024, buffer, 10));
        printf("mB total RAM\n");
        if(mbd->flags & 0b100000)
        {
            printf("got memory map.\nAddress: 0x");
            const memory_map_t * mmap = mbd->mmap_addr;
            printf(itoa( mmap, buffer, 16 ));
            printf("\nmmap[0] size: ");
            printf(itoa( mmap->size, buffer, 16 ));
            printf("\nmmap length: ");
            printf(itoa( mbd->mmap_length, buffer, 16 ));
            printf("\n");
        }
    }
}

void kernel_main(void)
{
    printf("Hello, kernel world!");
    while(true) {}
}
