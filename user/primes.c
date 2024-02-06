// lab01 - exercise 3
// concurrent version of prime sieve using pipes

#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define WR 1
#define RD 0

__attribute__((noreturn)) void prime(int lpipe[2]) {
    int first;
    if (read(lpipe[RD], &first, sizeof(first)) == 0) {
        close(lpipe[RD]);
        exit(0);
    }

    fprintf(1, "prime %d\n", first);

    int rpipe[2];
    pipe(rpipe);

    int buf;
    while (read(lpipe[RD], &buf, sizeof(buf)) != 0) {
        if (buf % first != 0)
            write(rpipe[WR], &buf, sizeof(buf));
    }

    close(lpipe[RD]);
    close(rpipe[WR]);

    if (fork() == 0) {
        prime(rpipe);
        exit(0);
    } else {
        close(rpipe[RD]);
        wait(0);
    }

    exit(0);
}

int main() {
    int p[2];
    pipe(p);

    for (int i = 2; i <= 35; i++) {
        write(p[WR], &i, sizeof(int));
    }

    close(p[WR]);

    if (fork() == 0) {
        prime(p);
    } else {
        close(p[RD]);
        wait(0);
    }

    exit(0);
}