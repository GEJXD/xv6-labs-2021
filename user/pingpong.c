/* ====================================================
#
#   Author        : jxd
#   Email         : genesisjxd@gmail.com
#   File Name     : pingpong.c
#   Create Time   : 2024-08-11 23:12:01
#   Describe      : lab utils - Ping Pong (easy)
#
#   Last Modified : 2024-08-14 12:12:31
# ====================================================*/

#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char* argv[]) {
    int p[2];
    pipe(p);

    char msg[2] = "@";
    char buf[2];

    if (fork() != 0) {
        if (write(p[1], msg, 1) != 1) {
            fprintf(2, "cannot write a byte to child.\n");
            exit(1);
        }
        close(p[1]);

        if (read(p[0], buf, sizeof(buf)) != 1) {
            fprintf(2, "cannot read a byte from child.\n");
            exit(1);
        }
        close(p[0]);
        fprintf(1, "%d: received pong\n", getpid());
    } else {
        if (read(p[0], buf, sizeof(buf)) != 1) {
            fprintf(2, "cannot read a byte from parent.\n");
            exit(1);
        }
        close(p[0]);
        fprintf(1, "%d: received ping\n", getpid());

        if (write(p[1], msg, 1) != 1) {
            fprintf(2, "cannot write a byte to parent.\n");
            exit(1);
        }
        close(p[1]);
    }

    exit(0);
}
