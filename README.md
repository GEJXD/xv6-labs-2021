## Sleep (easy)

> 实验里的`hints`很重要，跟着`hints`一步一步的实现就好。

从`user/echo.c`文件可以看到，`C`语言中获取命令行参数只需要在`main`
函数里面加上`int argc`, `char *argv[]`就行了。其中`argc`表示参数的
数量，argv是二维字符串数组，表示每个参数的内容。

例如在`cmd`输入`echo Hello World!`，`argc`就等于3，`argv`里的每一项
都对应上面。

从`kernel/sysproc.c`可以知道，`xv6`内核已经帮我们实现了`sleep`系统调
用，像`write`、`read`这样直接调用就可以了。

然后唯一需要注意的就是把读取的字符数值修改为`int`。

```C
// lab 1: Implement UNIX program sleep for xv6.

#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argv, char *argc[]) {
    if (argv <= 1) {
        fprintf(2, "Argument Error: Not found any arguments!\n");
        exit(0);README
    } else if (argv != 2) {
        fprintf(2, "Argument Error: Too many arguments! sleep command expect "
                   "only 1 argumens.\n");
        exit(0);
    }

    int time = atoi(argc[1]);
    sleep(time);
    exit(0);
}
```

## pingpong (easy)

内容大概就是要使用管道，实现父子进层之间的通信。互相接收一条消息，
然后打印`ping`或`pong`就行。

注意一下用不到的管道及时关闭，不然可能会堵塞读入口。写的有一点乱。

```C
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

        if (readMREADMEte that send pipe already closed by above
            close(ChildToParent[RD]);
            exit(1);
        }

        fprintf(1, "%d: received pong\n", getpid());
    }

    exit(0);
}

```

## primes (hard)

感觉是非常有意思的一个lab。

把埃氏筛的循环改为用管道来传给下一个进程，作为当前进程的读入。

有点像流水线的感觉，从前面一个进程拿到数据，加工后传给后一个进程，
以此递归至最后一个进程。并且感觉并不是并行的。

还是前面的问题，文件描述符有限，加上管道会堵塞读入，所以不用的管道
就要及时关闭。总体上和写`dfs`没太大区别。

```C
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

```

## find (moderate)

看懂`ls.c`就知道怎么写了。

简单说一下`ls.c`里的架构。首先用系统调用`open`打开传递的路径，
然后用`fstat`判断是文件还是目录，也就是`switch`里面的`T_FILE`和
`T_DIR`。如果是`T_DIR`就循环读出一个叫`dirent`的结构体，在
`kernel/fs.h`中查看定义，发现这么一个注释：

```C
// Directory is a file containing a sequence of dirent structures.
struct dirent {
  ushort inum;
  char name[DIRSIZ];
};
```

所以我们推测`dirent`就是用来描述一个文件的结构体。循环读入`dirent`
就等于读入一个个的文件。

然后继续判断文件的类型，是文件就判断一下并输出，是目录就继续递归查找。

```C
// lab01 - exercies 4
// simple version of the UNIX find program

#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fs.h"
#include "user/user.h"

void find(char *path, char *fileName) {
    int fd;
    struct stat
        st; // 存放文件的状态，包括类型、大小，还有其他的我也不太懂是啥。

    if ((fd = open(path, 0)) < 0) {
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }

    if (fstat(fd, &st) < 0) {
        fprintf(2, "find: cannot stat %s\n", path);
        return;
    }

    if (st.type != T_DIR) {
        fprintf(2, "find: the first argument must be dir.\n");
        return;
    }

    // strlen(path) + 1 表示path的长度 + '\0'
    // DIRSIZ 是文件的名字长度，不足14在后面补全空格, 见kernel/fs.h 54行

    // xv6 支持的文件缓存最大只有512B.
    char buf[512];
    if (strlen(path) + 1 + DIRSIZ + 1 > sizeof buf) {
        fprintf(2, "find: path too long\n");
        return;
    }

    strcpy(buf, path);
    char *p = buf + strlen(buf);

    // ls.c 里面写的一坨，查了半天才知道运算顺序。
    *p = '/';
    p++;
    // 这时候buf = buf + '/'； e.g. user -> user/

    struct dirent de;
    while (read(fd, &de, sizeof(de)) == sizeof(de)) {
        if (de.inum == 0)
            continue;
        // p指向buf末位的后一个位置，在字符串buf后面拼接了de.name
        memmove(p, de.name, DIRSIZ);
        p[DIRSIZ] = 0;

        if (stat(buf, &st) < 0) {
            fprintf(2, "find: cannot stat %s\n", buf);
            continue;
        }
        // 如果是dir，继续递归子目录。
        if (st.type == T_DIR) {
            if (strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
                continue;
            find(buf, fileName);
        } else if (st.type == T_FILE && strcmp(de.name, fileName) == 0) {
            fprintf(1, "%s\n", buf);
        }
    }

    return;
}

int main(int argv, char *argc[]) {
    if (argv != 3) {
        fprintf(2, "usage: find <direction> <fileName>\n");
        exit(1);
    }

    find(argc[1], argc[2]);
    exit(0);
}

```

## xargs (moderate)

> 卡死在字符串处理了，回去补指针的知识。

主要就是`fork`然后`exec`那一套，把`argc`里的参数都处理为一行一行
的字符串(把单行字符串变为多个以`\n`结尾的二维字符串)。

```C
#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/param.h"
#include "user/user.h"

int getline(char *buf) {
    int cnt = 0;
    while (read(0, buf, 1)) {
        if (++cnt >= 256) {
            fprintf(2, "xargs: line too long\n");
            exit(1);
        }
        if (*buf++ == '\n')
            break;
    }
    *(buf-1) = 0;
    return cnt;
}

int prase(char *buf, char **nargv, const int max) {
    int cnt = 0;
    while (*buf) {
        char *last = buf - 1;
        if (*last == 0 && *buf != ' ') {
            if (cnt >= max) {
                fprintf(2, "xargs: args too many\n");
                exit(1);
            }
            nargv[cnt++] = buf;
        }
        else if (*buf == ' ')
            *buf = 0;
        buf++;
    }
    nargv[cnt] = 0;
    return cnt;
}

int main(int argc, char const *argv[]) {
    if (argc == 1) {
        fprintf(2, "Usage: xargs COMMAND ...\n");
        exit(1);
    }
    char buf[257] = {0};
    while (getline(buf + 1)) {
        char *nargv[MAXARG + 1];
        memcpy(nargv, argv + 1, sizeof(char *) * (argc - 1));
        prase(buf + 1, nargv + argc - 1, MAXARG - argc + 1);
        int pid = fork();
        if (pid > 0) {
            int status;
            wait(&status);
        }
        else if (pid == 0) {
            char cmd[128];
            strcpy(cmd, argv[1]);
            exec(cmd, nargv);
        }
        else {
            fprintf(2, "fork error\n");
            exit(1);
        }
    }
    exit(0);
}
```