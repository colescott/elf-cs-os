#include "tty.h"

#include <stdbool.h>
#include <stdint.h>
#include "port.h"

void putChar(char c);
void putCharAt(unsigned char c, short color, int x, int y);
void setCursorState(bool state);
void setCursor(int x, int y);

uint8_t x = 0;
uint8_t y = 0;
uint16_t color;

void initTty()
{
    color = make_color(LIGHT_GRAY, BLACK);

    for(int i = 0; i < TTY_HEIGHT; i++)
        for(int j = 0; j < TTY_WIDTH; j++)
            putCharAt(' ', color, j, i);
}

void putChar(char c)
{
    putCharAt(c, color, x, y);
    if(++x >= TTY_WIDTH)
    {
        x = 0;
        if(++y >= TTY_HEIGHT)
        {
            y = 0;
        }
    }

    setCursor(x, y); //TODO: change cursor move to end of printf or user input
}

void putCharAt(unsigned char c, short color, int x, int y)
{
    volatile short *video = (volatile short*)0xB8000 + (y * 80 + x);
    *video = c | (color << 8);
}

void setCursorState(bool state)
{
    outb(0x3D4, state ? 0xE : 0xF);
}

void setCursor(int x, int y)
{
   unsigned short position=(y*80) + x;

   // cursor LOW port to vga INDEX register
   outb(0x3D4, 0x0F);
   outb(0x3D5, (unsigned char)(position&0xFF));
   // cursor HIGH port to vga INDEX register
   outb(0x3D4, 0x0E);
   outb(0x3D5, (unsigned char )((position>>8)&0xFF));
}

void printf(char* str, ...)
{
    //TODO: add real functionality to printf
    for(int i = 0; str[i] != '\0'; i++)
    {
        putChar(str[i]);
    }
}

uint8_t make_color(unsigned char foreground, unsigned char background)
{
    return (background << 4) | (foreground & 0x0F);
}
