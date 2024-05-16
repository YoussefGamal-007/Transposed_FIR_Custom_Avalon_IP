#include <stdio.h>
#include "sys/alt_stdio.h"
#include "system.h"
#include "alt_types.h"
#include "io.h"

#define MEMORY_BASE_ADDRESS2 0x3000

int main()
{
    int numberSamples = 256; // Number of samples to read

    for (alt_u32 i = 0; i < numberSamples; i++) {
        unsigned int data = IORD_32DIRECT(MEMORY_BASE_ADDRESS2 * 2, i * 2);
        printf("%x\n", data);
    }

    return 0;
}
