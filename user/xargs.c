/* ====================================================
#
#   Author        : jxd
#   Email         : genesisjxd@gmail.com
#   File Name     : xargs.c
#   Create Time   : 2024-08-17 19:57:35
#   Describe      : Lab Utils - xargs (moderate)
#
#   Last Modified : 2024-08-20 12:38:03
# ====================================================*/

#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/param.h"

int getline(char* buf, const int max) {
    int cnt = 0;
    while (read(0, buf, sizeof(char)) > 0) {
        if (++cnt > max) {
            fprintf(2, "xargs: input lines are too long.\n");
            exit(1);
        }
        if (*buf++ == '\n') break;
    }
    *(buf - 1) = 0;
    return cnt;
}

int parse(char** args, char* buf, const int max) {
    int cnt = 0;
    while (*buf) {
        if (cnt >= max) {
            fprintf(2, "xargs: args are too many.\n");
            exit(1);
        }
        while (*buf && *buf == ' ') buf ++;
        if (*buf == 0) break;
        args[cnt ++] = buf;
        while (*buf && *buf != ' ') buf ++;
        if (*buf) *buf++ = '\0';
    }
    return cnt;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fprintf(2, "Usage: xargs <command> [arguments]\n");
        exit(1);
    }

    char* args[MAXARG] = {0};
    for (int i = 1; i < argc; i++) {
        args[i - 1] = argv[i];
    }

    char buf[512] = {0};
    while (getline(buf, sizeof buf)) {
        parse(args + argc - 1, buf, MAXARG - argc + 1);
        int pid = fork();
        if (pid > 0) {
            wait((int*)0);
        } else if (pid == 0) {
            char cmd[128];
            strcpy(cmd, args[0]);
            exec(cmd, args);
        } else {
            fprintf(2, "xargs: fork error.\n");
            exit(1);
        }
    }

    exit(0);
}
