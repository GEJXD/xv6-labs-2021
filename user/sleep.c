// lab 1: Implement UNIX program sleep for xv6.

#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argv, char *argc[]) {
    if (argv <= 1) {
        fprintf(2, "sleep time not found.\n");
        exit(0);
    }

    int i;
    for (i = 1; i < argv; i++) {
        int sleepTime = atoi(argc[i]);
        sleep(sleepTime);
    }
    exit(0);
}