// lab 1: Implement UNIX program sleep for xv6.

#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argv, char *argc[]) {
    if (argv <= 1) {
        fprintf(2, "Argument Error: Not found any arguments!\n");
        exit(0);
    } else if (argv != 2) {
        fprintf(2, "Argument Error: Too many arguments! sleep command expect "
                   "only 1 argumens.\n");
        exit(0);
    }

    int time = atoi(argc[1]);
    sleep(time);
    exit(0);
}