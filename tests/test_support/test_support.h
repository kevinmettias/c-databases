#ifndef TEST_SUPPORT_H
#define TEST_SUPPORT_H

#include <stdint.h>

static inline uint64_t TestSupport_Kib(uint64_t value)
{
    return value * 1024;
}

static inline uint64_t TestSupport_Mib(uint64_t value)
{
    return TestSupport_Kib(value) * 1024;
}

#endif
