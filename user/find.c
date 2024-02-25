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
