#include "panic.h"

void panic(char* str)
{
    printf("KERNEL PANIC: ");
    printf(str);
    printf("\nHALTING SYSTEM.");
    asm volatile ( "cli" );
    asm volatile ( "hlt" );
}
