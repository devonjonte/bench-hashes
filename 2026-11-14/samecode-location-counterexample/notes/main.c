#include <stdint.h>
#include <stdio.h>
extern const uint32_t note_limit;
int main(void) {
    printf("%u\n", note_limit);
    return 0;
}
