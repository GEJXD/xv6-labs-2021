// lab01 - exercise2
// @brief use UNIX system call to "ping-pong" one byte between two progress over
// pair of pipes

#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define WR 1 // 写入端
#define RD 0 // 读取端

#define true 1
#define false 0

int readMessage(int *p, char *buf, int nbytes) {
    if (read(p[RD], buf, nbytes) != nbytes) {
        fprintf(2, "ReadError: the number of read bytes is not equal.");
        return false;
    } else {
        close(p[RD]);
        return true;
    }
}

int sendMessage(int *p, char *buf, int nbytes) {
    if (write(p[WR], buf, nbytes) != nbytes) {
        fprintf(2, "WriteError: the number of writen bytes is not equal.");
        return false;
    } else {
        close(p[WR]);
        return true;
    }
}

void closePipes(int *p1, int *p2) {
    close(p1[WR]);
    close(p1[RD]);
    close(p2[WR]);
    close(p2[RD]);
}

int main() {
    char buf = '#';

    int parentToChild[2];
    pipe(parentToChild);

    int ChildToParent[2];
    pipe(ChildToParent);

    int pid = fork();
    if (pid < 0) {
        fprintf(2, "fork() error!");
        closePipes(parentToChild, ChildToParent);
        exit(1);
    } else if (pid == 0) { // child
        close(parentToChild[WR]);
        close(ChildToParent[RD]);

        // receive massage from parent
        if (readMessage(parentToChild, &buf, sizeof(char)) == false) {
            close(parentToChild[RD]);
            close(ChildToParent[WR]);
            exit(1);
        }
        fprintf(1, "%d: received ping\n", getpid());

        // send massage to parent
        if (sendMessage(ChildToParent, &buf, sizeof(char)) == false) {
            // note that read pipe already be closed by above.
            close(ChildToParent[WR]);
            exit(1);
        }

        exit(0);
    } else { // parent
        close(parentToChild[RD]);
        close(ChildToParent[WR]);

        if (sendMessage(parentToChild, &buf, sizeof(char)) == false) {
            close(parentToChild[WR]);
            close(ChildToParent[RD]);
            exit(1);
        }

        if (readMessage(ChildToParent, &buf, sizeof(char)) == false) {
            // note that send pipe already closed by above
            close(ChildToParent[RD]);
            exit(1);
        }

        fprintf(1, "%d: received pong\n", getpid());
    }

    exit(0);
}