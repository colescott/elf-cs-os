#ifndef _TTY_H
#define _TTY_H

#define TTY_WIDTH  80
#define TTY_HEIGHT 25

#define BLACK         0x0
#define BLUE          0x1
#define GREEN         0x2
#define CYAN          0x3
#define RED           0x4
#define MAGENTA       0x5
#define BROWN         0x6
#define LIGHT_GRAY    0x7
#define LIGHT_GREY    0x7
#define DARK_GRAY     0x8
#define DARK_GREY     0x8
#define LIGHT_BLUE    0x9
#define LIGHT_GREEN   0xA
#define LIGHT_CYAN    0xB
#define LIGHT_RED     0xC
#define LIGHT_MAGENTA 0xD
#define YELLOW        0xE
#define WHITE         0xF

#include <stdint.h>

void initTty();
void printf(char* str, ...);
uint8_t make_color(unsigned char foreground, unsigned char background);

#endif
