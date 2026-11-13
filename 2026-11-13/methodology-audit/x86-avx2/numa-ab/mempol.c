#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/syscall.h>
/* Give the process an explicit memory policy (bind to every node it is allowed), then run the command.
   A task with a policy of its own is skipped by automatic NUMA balancing's scanner. --print shows the
   current policy and exits. */
int main(int argc, char **argv) {
    unsigned long mask[16]; int mode = -1;
    memset(mask, 0, sizeof mask);
    if (argc > 1 && !strcmp(argv[1], "--print")) {
        if (syscall(SYS_get_mempolicy, &mode, mask, 1024UL, 0, 0UL) != 0) { perror("get_mempolicy"); return 110; }
        printf("policy mode %d (0 default, 2 bind) nodes 0x%lx\n", mode, mask[0]); return 0;
    }
    if (syscall(SYS_get_mempolicy, &mode, mask, 1024UL, 0, 4UL) != 0) { perror("get_mempolicy(MEMS_ALLOWED)"); return 111; }
    if (syscall(SYS_set_mempolicy, 2, mask, 1024UL) != 0) { perror("set_mempolicy"); return 112; }
    if (argc < 2) return 0;
    execvp(argv[1], argv + 1); perror("execvp"); return 113;
}
