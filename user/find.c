/* ====================================================
#
#   Author        : jxd
#   Email         : genesisjxd@gmail.com
#   File Name     : find.c
#   Create Time   : 2024-08-14 21:55:40
#   Describe      : Lab utils - find (moderate)
#
#   Last Modified : 2024-08-17 16:15:51
# ====================================================*/

#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

void find(char* path, char* filename) {
    int fd;
    if ((fd = open(path, 0)) < 0) {
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }

    struct stat st;
    if (fstat(fd, &st) < 0) {
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }

    if (st.type != T_DIR) {
        fprintf(2, "find: %s should be a dir, but found a file.\n", path);
        exit(1);
    }

    char buf[512];
    
    // strlen(path) + 1 表示path的长度 + '\0'
    // DIRSIZ 是文件名最大长度, 见kernel/fs.h 54行
    // 最后还要在末位加上`/`，e.g. code/user -> code/user/
    if (strlen(path) + 1 + DIRSIZ + 1 > sizeof buf) {
        fprintf(2, "find: path too long.\n");
        exit(1);
    }

    strcpy(buf, path);
    char *p = buf + strlen(buf);
    *p ++ = '/';
    // 运算优先级: *p ---> p ++. 即p指向'/'的后一个位置

    struct dirent de;
    while (read(fd, &de, sizeof(de)) == sizeof(de)) {
        if (de.inum == 0) continue;
        // 将de.name复制到p后面,最大长度为DIRSIZ
        memmove(p, de.name, DIRSIZ);
        p[DIRSIZ] = 0;
        if (stat(buf, &st) < 0) {
            fprintf(2, "find: cannot stat %s\n", buf);
            continue;
        }
        switch (st.type) {
        case T_FILE:
            if (strcmp(de.name, filename) == 0) fprintf(1, "%s\n", buf);
            break;
        case T_DIR:
            if (strcmp(de.name, ".") == 0) continue;
            if (strcmp(de.name, "..") == 0) continue;
            find(buf, filename);
        }
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fprintf(2, "Usage: find [path] <filename>\n");
        exit(1);
    }

    if (argc == 2) {
        find(".", argv[1]);
    } else {
        find(argv[1], argv[2]);
    }

    exit(0);
}
