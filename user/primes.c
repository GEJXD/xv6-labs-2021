/* ====================================================
#
#   Author        : jxd
#   Email         : genesisjxd@gmail.com
#   File Name     : primes.c
#   Create Time   : 2024-08-12 00:40:35
#   Describe      : Lab util - primes (hard)
#
#   Last Modified : 2024-08-14 19:50:40
# ====================================================*/

#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

void primes(int left[2], int base) {
    fprintf(1, "prime %d\n", base);

    int right[2];
    pipe(right);

    // 将剔除后的数写入缓冲区
    int cur, first = -1;
    while (read(left[0], &cur, sizeof(cur)) == sizeof(cur)) {
        if (cur % base == 0) continue;
        if (first == -1) first = cur;
        if (write(right[1], &cur, sizeof(cur)) != sizeof(cur)) {
            fprintf(2, "pid %d: cannot wirite %d bytes to right.\n", getpid(), sizeof(cur));
            exit(1);
        }
    }
    close(left[0]);

    if (first == -1) {
        exit(0);
    }

    if (fork() != 0) {
        close(right[1]);
        close(right[0]);
        // 第i个子进程等待第i+1个子进程结束
        wait((int*)0);
    } else {
        close(right[1]);
        primes(right, first);
    }

    return ;
}

int main(int argc, char* argv[]) {
    int p[2];
    pipe(p);

    // 主进程 所有数都写入管道
    for (int i = 2; i <= 35; i++) {
        if (write(p[1], &i, sizeof(int)) != sizeof(int)) {
            fprintf(2, "cannot write %d bytes.\n", sizeof(int));
        }
    }
    
    if (fork() != 0) {
        close(p[1]);
        close(p[0]);
        // 主进程等待第一个子进程结束
        wait((int*)0);
    } else {
        close(p[1]);
        primes(p, 2);
    }

    exit(0);
}
