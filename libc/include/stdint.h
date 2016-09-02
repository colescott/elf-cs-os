#ifndef _STDINT_H
#define _STDINT_H

typedef signed char int8_t;
typedef signed short int16_t;
typedef signed int int32_t;
typedef signed long int int64_t;

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long int uint64_t;

#define INT8_MAX   0x7f
#define INT8_MIN   (-INT8_MAX - 1)
#define UINT8_MAX   (INT8_MAX * 2 + 1)
#define INT16_MAX   0x7fff
#define INT16_MIN   (-INT16_MAX - 1)
#define UINT16_MAX   (__CONCAT(INT16_MAX, U) * 2U + 1U)
#define INT32_MAX   0x7fffffffL
#define INT32_MIN   (-INT32_MAX - 1L)
#define UINT32_MAX   (__CONCAT(INT32_MAX, U) * 2UL + 1UL)
#define INT64_MAX   0x7fffffffffffffffLL
#define INT64_MIN   (-INT64_MAX - 1LL)
#define UINT64_MAX   (__CONCAT(INT64_MAX, U) * 2ULL + 1ULL)

#endif
