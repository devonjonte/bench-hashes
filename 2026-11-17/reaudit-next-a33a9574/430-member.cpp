// BLAKE3 #430, re-audit of 33acf40d (b3.h of next, a33a9574): is a b3_hasher kept
// "in an aligned member" aligned before C++17? Addresses only: nothing is hashed.
#include "b3.h"
#include <cstdint>
#include <cstdio>
#include <vector>
struct Wrapper { int id; b3_hasher h; };   // the member is aligned within Wrapper: alignof(Wrapper) is 64
int main() {
    int misaligned_new = 0, misaligned_vec = 0;
    const int n = 1000;
    for (int i = 0; i < n; i++) {
        Wrapper* w = new Wrapper;                                  // before C++17: operator new(size_t) alone
        if (reinterpret_cast<std::uintptr_t>(&w->h) % 64) misaligned_new++;
        (void) new char[1 + i % 48];                               // other allocations between, as a program has
    }
    for (int i = 0; i < n; i++) {
        std::vector<Wrapper> v(1 + i % 3);                         // std::allocator
        if (reinterpret_cast<std::uintptr_t>(&v[0].h) % 64) misaligned_vec++;
        (void) new char[1 + i % 48];
    }
    std::printf("__cplusplus=%ld sizeof(b3_hasher)=%zu alignof(Wrapper)=%zu: new Wrapper misaligned %d of %d; std::vector<Wrapper> misaligned %d of %d\n",
                (long)__cplusplus, sizeof(b3_hasher), alignof(Wrapper), misaligned_new, n, misaligned_vec, n);
}
