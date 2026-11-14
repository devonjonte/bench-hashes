#include <stddef.h>
#include <stdint.h>
struct FileLimit {
    const char *path;
    size_t path_len;
    uint32_t max_bytes;
    uint32_t flags;
};
extern const struct FileLimit file_limit;
