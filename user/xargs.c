// lab01 - exercise 05
// simple version of the UNIX xargs program

#include "kernel/types.h"
#include "kernel/param.h"
#include "kernel/stat.h"
#include "user/user.h"

int readLine(char *buf) {
    char ch;
    char *p = buf;
    int n, totBytes = 0;

    while ((n = read(0, &ch, sizeof(ch))) != 0) {
        if (n < 0) {
            fprintf(2, "xargs: read error.\n");
            exit(1);
        }
        if (ch != '\n' || ch == ' ') {
            *p = ch;
            p++;
            totBytes += n;
        } else {
            *p = '\0';
            break;
        }
    }
    return totBytes;
}

int main(int argc, char *argv[]) {
    char *args[MAXARG];
    for (int i = 1; i < argc; i++) {
        args[i - 1] = argv[i];
    }

    char buf[512];
    while (readLine(buf) != 0) {
        char **argsIdx = args + argc - 1;
        char *p = (char *)malloc(sizeof(buf));
        strcpy(p, buf);

        *argsIdx = p;
        argsIdx++;
        *argsIdx = (char *)0;

        int pid = fork();
        if (pid == 0) {
            exec(args[0], args);
            fprintf(2, "exec: nod found %s\n.", args[0]);
            exit(1);
        } else {
            wait(0);
        }
    }

    exit(0);
}