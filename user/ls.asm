
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

char *fmtname(char *path) {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	1800                	addi	s0,sp,48
   a:	84aa                	mv	s1,a0
    static char buf[DIRSIZ + 1];
    char *p;

    // Find first character after last slash.
    for (p = path + strlen(path); p >= path && *p != '/'; p--)
   c:	00000097          	auipc	ra,0x0
  10:	314080e7          	jalr	788(ra) # 320 <strlen>
  14:	02051793          	slli	a5,a0,0x20
  18:	9381                	srli	a5,a5,0x20
  1a:	97a6                	add	a5,a5,s1
  1c:	02f00693          	li	a3,47
  20:	0097e963          	bltu	a5,s1,32 <fmtname+0x32>
  24:	0007c703          	lbu	a4,0(a5)
  28:	00d70563          	beq	a4,a3,32 <fmtname+0x32>
  2c:	17fd                	addi	a5,a5,-1
  2e:	fe97fbe3          	bgeu	a5,s1,24 <fmtname+0x24>
        ;
    p++;
  32:	00178493          	addi	s1,a5,1

    // Return blank-padded name.
    if (strlen(p) >= DIRSIZ)
  36:	8526                	mv	a0,s1
  38:	00000097          	auipc	ra,0x0
  3c:	2e8080e7          	jalr	744(ra) # 320 <strlen>
  40:	2501                	sext.w	a0,a0
  42:	47b5                	li	a5,13
  44:	00a7f863          	bgeu	a5,a0,54 <fmtname+0x54>
        return p;
    memmove(buf, p, strlen(p));
    memset(buf + strlen(p), ' ', DIRSIZ - strlen(p));
    return buf;
}
  48:	8526                	mv	a0,s1
  4a:	70a2                	ld	ra,40(sp)
  4c:	7402                	ld	s0,32(sp)
  4e:	64e2                	ld	s1,24(sp)
  50:	6145                	addi	sp,sp,48
  52:	8082                	ret
  54:	e84a                	sd	s2,16(sp)
  56:	e44e                	sd	s3,8(sp)
    memmove(buf, p, strlen(p));
  58:	8526                	mv	a0,s1
  5a:	00000097          	auipc	ra,0x0
  5e:	2c6080e7          	jalr	710(ra) # 320 <strlen>
  62:	00001997          	auipc	s3,0x1
  66:	f4e98993          	addi	s3,s3,-178 # fb0 <buf.0>
  6a:	0005061b          	sext.w	a2,a0
  6e:	85a6                	mv	a1,s1
  70:	854e                	mv	a0,s3
  72:	00000097          	auipc	ra,0x0
  76:	420080e7          	jalr	1056(ra) # 492 <memmove>
    memset(buf + strlen(p), ' ', DIRSIZ - strlen(p));
  7a:	8526                	mv	a0,s1
  7c:	00000097          	auipc	ra,0x0
  80:	2a4080e7          	jalr	676(ra) # 320 <strlen>
  84:	0005091b          	sext.w	s2,a0
  88:	8526                	mv	a0,s1
  8a:	00000097          	auipc	ra,0x0
  8e:	296080e7          	jalr	662(ra) # 320 <strlen>
  92:	1902                	slli	s2,s2,0x20
  94:	02095913          	srli	s2,s2,0x20
  98:	4639                	li	a2,14
  9a:	9e09                	subw	a2,a2,a0
  9c:	02000593          	li	a1,32
  a0:	01298533          	add	a0,s3,s2
  a4:	00000097          	auipc	ra,0x0
  a8:	2a6080e7          	jalr	678(ra) # 34a <memset>
    return buf;
  ac:	84ce                	mv	s1,s3
  ae:	6942                	ld	s2,16(sp)
  b0:	69a2                	ld	s3,8(sp)
  b2:	bf59                	j	48 <fmtname+0x48>

00000000000000b4 <ls>:

void ls(char *path) {
  b4:	d9010113          	addi	sp,sp,-624
  b8:	26113423          	sd	ra,616(sp)
  bc:	26813023          	sd	s0,608(sp)
  c0:	25213823          	sd	s2,592(sp)
  c4:	1c80                	addi	s0,sp,624
  c6:	892a                	mv	s2,a0
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;

    if ((fd = open(path, 0)) < 0) {
  c8:	4581                	li	a1,0
  ca:	00000097          	auipc	ra,0x0
  ce:	4ba080e7          	jalr	1210(ra) # 584 <open>
  d2:	06054963          	bltz	a0,144 <ls+0x90>
  d6:	24913c23          	sd	s1,600(sp)
  da:	84aa                	mv	s1,a0
        fprintf(2, "ls: cannot open %s\n", path);
        return;
    }

    if (fstat(fd, &st) < 0) {
  dc:	d9840593          	addi	a1,s0,-616
  e0:	00000097          	auipc	ra,0x0
  e4:	4bc080e7          	jalr	1212(ra) # 59c <fstat>
  e8:	06054963          	bltz	a0,15a <ls+0xa6>
        fprintf(2, "ls: cannot stat %s\n", path);
        close(fd);
        return;
    }

    switch (st.type) {
  ec:	da041783          	lh	a5,-608(s0)
  f0:	4705                	li	a4,1
  f2:	08e78663          	beq	a5,a4,17e <ls+0xca>
  f6:	4709                	li	a4,2
  f8:	02e79663          	bne	a5,a4,124 <ls+0x70>
    case T_FILE:
        printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
  fc:	854a                	mv	a0,s2
  fe:	00000097          	auipc	ra,0x0
 102:	f02080e7          	jalr	-254(ra) # 0 <fmtname>
 106:	85aa                	mv	a1,a0
 108:	da843703          	ld	a4,-600(s0)
 10c:	d9c42683          	lw	a3,-612(s0)
 110:	da041603          	lh	a2,-608(s0)
 114:	00001517          	auipc	a0,0x1
 118:	99450513          	addi	a0,a0,-1644 # aa8 <malloc+0x134>
 11c:	00000097          	auipc	ra,0x0
 120:	7a0080e7          	jalr	1952(ra) # 8bc <printf>
            }
            printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
        }
        break;
    }
    close(fd);
 124:	8526                	mv	a0,s1
 126:	00000097          	auipc	ra,0x0
 12a:	446080e7          	jalr	1094(ra) # 56c <close>
 12e:	25813483          	ld	s1,600(sp)
}
 132:	26813083          	ld	ra,616(sp)
 136:	26013403          	ld	s0,608(sp)
 13a:	25013903          	ld	s2,592(sp)
 13e:	27010113          	addi	sp,sp,624
 142:	8082                	ret
        fprintf(2, "ls: cannot open %s\n", path);
 144:	864a                	mv	a2,s2
 146:	00001597          	auipc	a1,0x1
 14a:	93258593          	addi	a1,a1,-1742 # a78 <malloc+0x104>
 14e:	4509                	li	a0,2
 150:	00000097          	auipc	ra,0x0
 154:	73e080e7          	jalr	1854(ra) # 88e <fprintf>
        return;
 158:	bfe9                	j	132 <ls+0x7e>
        fprintf(2, "ls: cannot stat %s\n", path);
 15a:	864a                	mv	a2,s2
 15c:	00001597          	auipc	a1,0x1
 160:	93458593          	addi	a1,a1,-1740 # a90 <malloc+0x11c>
 164:	4509                	li	a0,2
 166:	00000097          	auipc	ra,0x0
 16a:	728080e7          	jalr	1832(ra) # 88e <fprintf>
        close(fd);
 16e:	8526                	mv	a0,s1
 170:	00000097          	auipc	ra,0x0
 174:	3fc080e7          	jalr	1020(ra) # 56c <close>
        return;
 178:	25813483          	ld	s1,600(sp)
 17c:	bf5d                	j	132 <ls+0x7e>
        if (strlen(path) + 1 + DIRSIZ + 1 > sizeof buf) {
 17e:	854a                	mv	a0,s2
 180:	00000097          	auipc	ra,0x0
 184:	1a0080e7          	jalr	416(ra) # 320 <strlen>
 188:	2541                	addiw	a0,a0,16
 18a:	20000793          	li	a5,512
 18e:	00a7fb63          	bgeu	a5,a0,1a4 <ls+0xf0>
            printf("ls: path too long\n");
 192:	00001517          	auipc	a0,0x1
 196:	92650513          	addi	a0,a0,-1754 # ab8 <malloc+0x144>
 19a:	00000097          	auipc	ra,0x0
 19e:	722080e7          	jalr	1826(ra) # 8bc <printf>
            break;
 1a2:	b749                	j	124 <ls+0x70>
 1a4:	25313423          	sd	s3,584(sp)
 1a8:	25413023          	sd	s4,576(sp)
 1ac:	23513c23          	sd	s5,568(sp)
        strcpy(buf, path);
 1b0:	85ca                	mv	a1,s2
 1b2:	dc040513          	addi	a0,s0,-576
 1b6:	00000097          	auipc	ra,0x0
 1ba:	122080e7          	jalr	290(ra) # 2d8 <strcpy>
        p = buf + strlen(buf);
 1be:	dc040513          	addi	a0,s0,-576
 1c2:	00000097          	auipc	ra,0x0
 1c6:	15e080e7          	jalr	350(ra) # 320 <strlen>
 1ca:	1502                	slli	a0,a0,0x20
 1cc:	9101                	srli	a0,a0,0x20
 1ce:	dc040793          	addi	a5,s0,-576
 1d2:	00a78933          	add	s2,a5,a0
        *p++ = '/';
 1d6:	00190993          	addi	s3,s2,1
 1da:	02f00793          	li	a5,47
 1de:	00f90023          	sb	a5,0(s2)
            printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 1e2:	00001a17          	auipc	s4,0x1
 1e6:	8eea0a13          	addi	s4,s4,-1810 # ad0 <malloc+0x15c>
                printf("ls: cannot stat %s\n", buf);
 1ea:	00001a97          	auipc	s5,0x1
 1ee:	8a6a8a93          	addi	s5,s5,-1882 # a90 <malloc+0x11c>
        while (read(fd, &de, sizeof(de)) == sizeof(de)) {
 1f2:	a801                	j	202 <ls+0x14e>
                printf("ls: cannot stat %s\n", buf);
 1f4:	dc040593          	addi	a1,s0,-576
 1f8:	8556                	mv	a0,s5
 1fa:	00000097          	auipc	ra,0x0
 1fe:	6c2080e7          	jalr	1730(ra) # 8bc <printf>
        while (read(fd, &de, sizeof(de)) == sizeof(de)) {
 202:	4641                	li	a2,16
 204:	db040593          	addi	a1,s0,-592
 208:	8526                	mv	a0,s1
 20a:	00000097          	auipc	ra,0x0
 20e:	352080e7          	jalr	850(ra) # 55c <read>
 212:	47c1                	li	a5,16
 214:	04f51c63          	bne	a0,a5,26c <ls+0x1b8>
            if (de.inum == 0)
 218:	db045783          	lhu	a5,-592(s0)
 21c:	d3fd                	beqz	a5,202 <ls+0x14e>
            memmove(p, de.name, DIRSIZ);
 21e:	4639                	li	a2,14
 220:	db240593          	addi	a1,s0,-590
 224:	854e                	mv	a0,s3
 226:	00000097          	auipc	ra,0x0
 22a:	26c080e7          	jalr	620(ra) # 492 <memmove>
            p[DIRSIZ] = 0;
 22e:	000907a3          	sb	zero,15(s2)
            if (stat(buf, &st) < 0) {
 232:	d9840593          	addi	a1,s0,-616
 236:	dc040513          	addi	a0,s0,-576
 23a:	00000097          	auipc	ra,0x0
 23e:	1ca080e7          	jalr	458(ra) # 404 <stat>
 242:	fa0549e3          	bltz	a0,1f4 <ls+0x140>
            printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 246:	dc040513          	addi	a0,s0,-576
 24a:	00000097          	auipc	ra,0x0
 24e:	db6080e7          	jalr	-586(ra) # 0 <fmtname>
 252:	85aa                	mv	a1,a0
 254:	da843703          	ld	a4,-600(s0)
 258:	d9c42683          	lw	a3,-612(s0)
 25c:	da041603          	lh	a2,-608(s0)
 260:	8552                	mv	a0,s4
 262:	00000097          	auipc	ra,0x0
 266:	65a080e7          	jalr	1626(ra) # 8bc <printf>
 26a:	bf61                	j	202 <ls+0x14e>
 26c:	24813983          	ld	s3,584(sp)
 270:	24013a03          	ld	s4,576(sp)
 274:	23813a83          	ld	s5,568(sp)
 278:	b575                	j	124 <ls+0x70>

000000000000027a <main>:

int main(int argc, char *argv[]) {
 27a:	1101                	addi	sp,sp,-32
 27c:	ec06                	sd	ra,24(sp)
 27e:	e822                	sd	s0,16(sp)
 280:	1000                	addi	s0,sp,32
    int i;

    if (argc < 2) {
 282:	4785                	li	a5,1
 284:	02a7db63          	bge	a5,a0,2ba <main+0x40>
 288:	e426                	sd	s1,8(sp)
 28a:	e04a                	sd	s2,0(sp)
 28c:	00858493          	addi	s1,a1,8
 290:	ffe5091b          	addiw	s2,a0,-2
 294:	02091793          	slli	a5,s2,0x20
 298:	01d7d913          	srli	s2,a5,0x1d
 29c:	05c1                	addi	a1,a1,16
 29e:	992e                	add	s2,s2,a1
        ls(".");
        exit(0);
    }
    for (i = 1; i < argc; i++)
        ls(argv[i]);
 2a0:	6088                	ld	a0,0(s1)
 2a2:	00000097          	auipc	ra,0x0
 2a6:	e12080e7          	jalr	-494(ra) # b4 <ls>
    for (i = 1; i < argc; i++)
 2aa:	04a1                	addi	s1,s1,8
 2ac:	ff249ae3          	bne	s1,s2,2a0 <main+0x26>
    exit(0);
 2b0:	4501                	li	a0,0
 2b2:	00000097          	auipc	ra,0x0
 2b6:	292080e7          	jalr	658(ra) # 544 <exit>
 2ba:	e426                	sd	s1,8(sp)
 2bc:	e04a                	sd	s2,0(sp)
        ls(".");
 2be:	00001517          	auipc	a0,0x1
 2c2:	82250513          	addi	a0,a0,-2014 # ae0 <malloc+0x16c>
 2c6:	00000097          	auipc	ra,0x0
 2ca:	dee080e7          	jalr	-530(ra) # b4 <ls>
        exit(0);
 2ce:	4501                	li	a0,0
 2d0:	00000097          	auipc	ra,0x0
 2d4:	274080e7          	jalr	628(ra) # 544 <exit>

00000000000002d8 <strcpy>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "user/user.h"

char *strcpy(char *s, const char *t) {
 2d8:	1141                	addi	sp,sp,-16
 2da:	e422                	sd	s0,8(sp)
 2dc:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 2de:	87aa                	mv	a5,a0
 2e0:	0585                	addi	a1,a1,1
 2e2:	0785                	addi	a5,a5,1
 2e4:	fff5c703          	lbu	a4,-1(a1)
 2e8:	fee78fa3          	sb	a4,-1(a5)
 2ec:	fb75                	bnez	a4,2e0 <strcpy+0x8>
        ;
    return os;
}
 2ee:	6422                	ld	s0,8(sp)
 2f0:	0141                	addi	sp,sp,16
 2f2:	8082                	ret

00000000000002f4 <strcmp>:

int strcmp(const char *p, const char *q) {
 2f4:	1141                	addi	sp,sp,-16
 2f6:	e422                	sd	s0,8(sp)
 2f8:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 2fa:	00054783          	lbu	a5,0(a0)
 2fe:	cb91                	beqz	a5,312 <strcmp+0x1e>
 300:	0005c703          	lbu	a4,0(a1)
 304:	00f71763          	bne	a4,a5,312 <strcmp+0x1e>
        p++, q++;
 308:	0505                	addi	a0,a0,1
 30a:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 30c:	00054783          	lbu	a5,0(a0)
 310:	fbe5                	bnez	a5,300 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 312:	0005c503          	lbu	a0,0(a1)
}
 316:	40a7853b          	subw	a0,a5,a0
 31a:	6422                	ld	s0,8(sp)
 31c:	0141                	addi	sp,sp,16
 31e:	8082                	ret

0000000000000320 <strlen>:

uint strlen(const char *s) {
 320:	1141                	addi	sp,sp,-16
 322:	e422                	sd	s0,8(sp)
 324:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 326:	00054783          	lbu	a5,0(a0)
 32a:	cf91                	beqz	a5,346 <strlen+0x26>
 32c:	0505                	addi	a0,a0,1
 32e:	87aa                	mv	a5,a0
 330:	86be                	mv	a3,a5
 332:	0785                	addi	a5,a5,1
 334:	fff7c703          	lbu	a4,-1(a5)
 338:	ff65                	bnez	a4,330 <strlen+0x10>
 33a:	40a6853b          	subw	a0,a3,a0
 33e:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 340:	6422                	ld	s0,8(sp)
 342:	0141                	addi	sp,sp,16
 344:	8082                	ret
    for (n = 0; s[n]; n++)
 346:	4501                	li	a0,0
 348:	bfe5                	j	340 <strlen+0x20>

000000000000034a <memset>:

void *memset(void *dst, int c, uint n) {
 34a:	1141                	addi	sp,sp,-16
 34c:	e422                	sd	s0,8(sp)
 34e:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++) {
 350:	ca19                	beqz	a2,366 <memset+0x1c>
 352:	87aa                	mv	a5,a0
 354:	1602                	slli	a2,a2,0x20
 356:	9201                	srli	a2,a2,0x20
 358:	00a60733          	add	a4,a2,a0
        cdst[i] = c;
 35c:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++) {
 360:	0785                	addi	a5,a5,1
 362:	fee79de3          	bne	a5,a4,35c <memset+0x12>
    }
    return dst;
}
 366:	6422                	ld	s0,8(sp)
 368:	0141                	addi	sp,sp,16
 36a:	8082                	ret

000000000000036c <strchr>:

char *strchr(const char *s, char c) {
 36c:	1141                	addi	sp,sp,-16
 36e:	e422                	sd	s0,8(sp)
 370:	0800                	addi	s0,sp,16
    for (; *s; s++)
 372:	00054783          	lbu	a5,0(a0)
 376:	cb99                	beqz	a5,38c <strchr+0x20>
        if (*s == c)
 378:	00f58763          	beq	a1,a5,386 <strchr+0x1a>
    for (; *s; s++)
 37c:	0505                	addi	a0,a0,1
 37e:	00054783          	lbu	a5,0(a0)
 382:	fbfd                	bnez	a5,378 <strchr+0xc>
            return (char *)s;
    return 0;
 384:	4501                	li	a0,0
}
 386:	6422                	ld	s0,8(sp)
 388:	0141                	addi	sp,sp,16
 38a:	8082                	ret
    return 0;
 38c:	4501                	li	a0,0
 38e:	bfe5                	j	386 <strchr+0x1a>

0000000000000390 <gets>:

char *gets(char *buf, int max) {
 390:	711d                	addi	sp,sp,-96
 392:	ec86                	sd	ra,88(sp)
 394:	e8a2                	sd	s0,80(sp)
 396:	e4a6                	sd	s1,72(sp)
 398:	e0ca                	sd	s2,64(sp)
 39a:	fc4e                	sd	s3,56(sp)
 39c:	f852                	sd	s4,48(sp)
 39e:	f456                	sd	s5,40(sp)
 3a0:	f05a                	sd	s6,32(sp)
 3a2:	ec5e                	sd	s7,24(sp)
 3a4:	1080                	addi	s0,sp,96
 3a6:	8baa                	mv	s7,a0
 3a8:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
 3aa:	892a                	mv	s2,a0
 3ac:	4481                	li	s1,0
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 3ae:	4aa9                	li	s5,10
 3b0:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;) {
 3b2:	89a6                	mv	s3,s1
 3b4:	2485                	addiw	s1,s1,1
 3b6:	0344d863          	bge	s1,s4,3e6 <gets+0x56>
        cc = read(0, &c, 1);
 3ba:	4605                	li	a2,1
 3bc:	faf40593          	addi	a1,s0,-81
 3c0:	4501                	li	a0,0
 3c2:	00000097          	auipc	ra,0x0
 3c6:	19a080e7          	jalr	410(ra) # 55c <read>
        if (cc < 1)
 3ca:	00a05e63          	blez	a0,3e6 <gets+0x56>
        buf[i++] = c;
 3ce:	faf44783          	lbu	a5,-81(s0)
 3d2:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 3d6:	01578763          	beq	a5,s5,3e4 <gets+0x54>
 3da:	0905                	addi	s2,s2,1
 3dc:	fd679be3          	bne	a5,s6,3b2 <gets+0x22>
        buf[i++] = c;
 3e0:	89a6                	mv	s3,s1
 3e2:	a011                	j	3e6 <gets+0x56>
 3e4:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 3e6:	99de                	add	s3,s3,s7
 3e8:	00098023          	sb	zero,0(s3)
    return buf;
}
 3ec:	855e                	mv	a0,s7
 3ee:	60e6                	ld	ra,88(sp)
 3f0:	6446                	ld	s0,80(sp)
 3f2:	64a6                	ld	s1,72(sp)
 3f4:	6906                	ld	s2,64(sp)
 3f6:	79e2                	ld	s3,56(sp)
 3f8:	7a42                	ld	s4,48(sp)
 3fa:	7aa2                	ld	s5,40(sp)
 3fc:	7b02                	ld	s6,32(sp)
 3fe:	6be2                	ld	s7,24(sp)
 400:	6125                	addi	sp,sp,96
 402:	8082                	ret

0000000000000404 <stat>:

int stat(const char *n, struct stat *st) {
 404:	1101                	addi	sp,sp,-32
 406:	ec06                	sd	ra,24(sp)
 408:	e822                	sd	s0,16(sp)
 40a:	e04a                	sd	s2,0(sp)
 40c:	1000                	addi	s0,sp,32
 40e:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 410:	4581                	li	a1,0
 412:	00000097          	auipc	ra,0x0
 416:	172080e7          	jalr	370(ra) # 584 <open>
    if (fd < 0)
 41a:	02054663          	bltz	a0,446 <stat+0x42>
 41e:	e426                	sd	s1,8(sp)
 420:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 422:	85ca                	mv	a1,s2
 424:	00000097          	auipc	ra,0x0
 428:	178080e7          	jalr	376(ra) # 59c <fstat>
 42c:	892a                	mv	s2,a0
    close(fd);
 42e:	8526                	mv	a0,s1
 430:	00000097          	auipc	ra,0x0
 434:	13c080e7          	jalr	316(ra) # 56c <close>
    return r;
 438:	64a2                	ld	s1,8(sp)
}
 43a:	854a                	mv	a0,s2
 43c:	60e2                	ld	ra,24(sp)
 43e:	6442                	ld	s0,16(sp)
 440:	6902                	ld	s2,0(sp)
 442:	6105                	addi	sp,sp,32
 444:	8082                	ret
        return -1;
 446:	597d                	li	s2,-1
 448:	bfcd                	j	43a <stat+0x36>

000000000000044a <atoi>:

int atoi(const char *s) {
 44a:	1141                	addi	sp,sp,-16
 44c:	e422                	sd	s0,8(sp)
 44e:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 450:	00054683          	lbu	a3,0(a0)
 454:	fd06879b          	addiw	a5,a3,-48
 458:	0ff7f793          	zext.b	a5,a5
 45c:	4625                	li	a2,9
 45e:	02f66863          	bltu	a2,a5,48e <atoi+0x44>
 462:	872a                	mv	a4,a0
    n = 0;
 464:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 466:	0705                	addi	a4,a4,1
 468:	0025179b          	slliw	a5,a0,0x2
 46c:	9fa9                	addw	a5,a5,a0
 46e:	0017979b          	slliw	a5,a5,0x1
 472:	9fb5                	addw	a5,a5,a3
 474:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 478:	00074683          	lbu	a3,0(a4)
 47c:	fd06879b          	addiw	a5,a3,-48
 480:	0ff7f793          	zext.b	a5,a5
 484:	fef671e3          	bgeu	a2,a5,466 <atoi+0x1c>
    return n;
}
 488:	6422                	ld	s0,8(sp)
 48a:	0141                	addi	sp,sp,16
 48c:	8082                	ret
    n = 0;
 48e:	4501                	li	a0,0
 490:	bfe5                	j	488 <atoi+0x3e>

0000000000000492 <memmove>:

void *memmove(void *vdst, const void *vsrc, int n) {
 492:	1141                	addi	sp,sp,-16
 494:	e422                	sd	s0,8(sp)
 496:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
 498:	02b57463          	bgeu	a0,a1,4c0 <memmove+0x2e>
        while (n-- > 0)
 49c:	00c05f63          	blez	a2,4ba <memmove+0x28>
 4a0:	1602                	slli	a2,a2,0x20
 4a2:	9201                	srli	a2,a2,0x20
 4a4:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 4a8:	872a                	mv	a4,a0
            *dst++ = *src++;
 4aa:	0585                	addi	a1,a1,1
 4ac:	0705                	addi	a4,a4,1
 4ae:	fff5c683          	lbu	a3,-1(a1)
 4b2:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 4b6:	fef71ae3          	bne	a4,a5,4aa <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 4ba:	6422                	ld	s0,8(sp)
 4bc:	0141                	addi	sp,sp,16
 4be:	8082                	ret
        dst += n;
 4c0:	00c50733          	add	a4,a0,a2
        src += n;
 4c4:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 4c6:	fec05ae3          	blez	a2,4ba <memmove+0x28>
 4ca:	fff6079b          	addiw	a5,a2,-1
 4ce:	1782                	slli	a5,a5,0x20
 4d0:	9381                	srli	a5,a5,0x20
 4d2:	fff7c793          	not	a5,a5
 4d6:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 4d8:	15fd                	addi	a1,a1,-1
 4da:	177d                	addi	a4,a4,-1
 4dc:	0005c683          	lbu	a3,0(a1)
 4e0:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 4e4:	fee79ae3          	bne	a5,a4,4d8 <memmove+0x46>
 4e8:	bfc9                	j	4ba <memmove+0x28>

00000000000004ea <memcmp>:

int memcmp(const void *s1, const void *s2, uint n) {
 4ea:	1141                	addi	sp,sp,-16
 4ec:	e422                	sd	s0,8(sp)
 4ee:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0) {
 4f0:	ca05                	beqz	a2,520 <memcmp+0x36>
 4f2:	fff6069b          	addiw	a3,a2,-1
 4f6:	1682                	slli	a3,a3,0x20
 4f8:	9281                	srli	a3,a3,0x20
 4fa:	0685                	addi	a3,a3,1
 4fc:	96aa                	add	a3,a3,a0
        if (*p1 != *p2) {
 4fe:	00054783          	lbu	a5,0(a0)
 502:	0005c703          	lbu	a4,0(a1)
 506:	00e79863          	bne	a5,a4,516 <memcmp+0x2c>
            return *p1 - *p2;
        }
        p1++;
 50a:	0505                	addi	a0,a0,1
        p2++;
 50c:	0585                	addi	a1,a1,1
    while (n-- > 0) {
 50e:	fed518e3          	bne	a0,a3,4fe <memcmp+0x14>
    }
    return 0;
 512:	4501                	li	a0,0
 514:	a019                	j	51a <memcmp+0x30>
            return *p1 - *p2;
 516:	40e7853b          	subw	a0,a5,a4
}
 51a:	6422                	ld	s0,8(sp)
 51c:	0141                	addi	sp,sp,16
 51e:	8082                	ret
    return 0;
 520:	4501                	li	a0,0
 522:	bfe5                	j	51a <memcmp+0x30>

0000000000000524 <memcpy>:

void *memcpy(void *dst, const void *src, uint n) {
 524:	1141                	addi	sp,sp,-16
 526:	e406                	sd	ra,8(sp)
 528:	e022                	sd	s0,0(sp)
 52a:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 52c:	00000097          	auipc	ra,0x0
 530:	f66080e7          	jalr	-154(ra) # 492 <memmove>
}
 534:	60a2                	ld	ra,8(sp)
 536:	6402                	ld	s0,0(sp)
 538:	0141                	addi	sp,sp,16
 53a:	8082                	ret

000000000000053c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 53c:	4885                	li	a7,1
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <exit>:
.global exit
exit:
 li a7, SYS_exit
 544:	4889                	li	a7,2
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <wait>:
.global wait
wait:
 li a7, SYS_wait
 54c:	488d                	li	a7,3
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 554:	4891                	li	a7,4
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <read>:
.global read
read:
 li a7, SYS_read
 55c:	4895                	li	a7,5
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <write>:
.global write
write:
 li a7, SYS_write
 564:	48c1                	li	a7,16
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <close>:
.global close
close:
 li a7, SYS_close
 56c:	48d5                	li	a7,21
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <kill>:
.global kill
kill:
 li a7, SYS_kill
 574:	4899                	li	a7,6
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <exec>:
.global exec
exec:
 li a7, SYS_exec
 57c:	489d                	li	a7,7
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <open>:
.global open
open:
 li a7, SYS_open
 584:	48bd                	li	a7,15
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 58c:	48c5                	li	a7,17
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 594:	48c9                	li	a7,18
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 59c:	48a1                	li	a7,8
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <link>:
.global link
link:
 li a7, SYS_link
 5a4:	48cd                	li	a7,19
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5ac:	48d1                	li	a7,20
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5b4:	48a5                	li	a7,9
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <dup>:
.global dup
dup:
 li a7, SYS_dup
 5bc:	48a9                	li	a7,10
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5c4:	48ad                	li	a7,11
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5cc:	48b1                	li	a7,12
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5d4:	48b5                	li	a7,13
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5dc:	48b9                	li	a7,14
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <trace>:
.global trace
trace:
 li a7, SYS_trace
 5e4:	48d9                	li	a7,22
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 5ec:	48dd                	li	a7,23
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <putc>:

#include <stdarg.h>

static char digits[] = "0123456789ABCDEF";

static void putc(int fd, char c) { write(fd, &c, 1); }
 5f4:	1101                	addi	sp,sp,-32
 5f6:	ec06                	sd	ra,24(sp)
 5f8:	e822                	sd	s0,16(sp)
 5fa:	1000                	addi	s0,sp,32
 5fc:	feb407a3          	sb	a1,-17(s0)
 600:	4605                	li	a2,1
 602:	fef40593          	addi	a1,s0,-17
 606:	00000097          	auipc	ra,0x0
 60a:	f5e080e7          	jalr	-162(ra) # 564 <write>
 60e:	60e2                	ld	ra,24(sp)
 610:	6442                	ld	s0,16(sp)
 612:	6105                	addi	sp,sp,32
 614:	8082                	ret

0000000000000616 <printint>:

static void printint(int fd, int xx, int base, int sgn) {
 616:	7139                	addi	sp,sp,-64
 618:	fc06                	sd	ra,56(sp)
 61a:	f822                	sd	s0,48(sp)
 61c:	f426                	sd	s1,40(sp)
 61e:	0080                	addi	s0,sp,64
 620:	84aa                	mv	s1,a0
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if (sgn && xx < 0) {
 622:	c299                	beqz	a3,628 <printint+0x12>
 624:	0805cb63          	bltz	a1,6ba <printint+0xa4>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
 628:	2581                	sext.w	a1,a1
    neg = 0;
 62a:	4881                	li	a7,0
 62c:	fc040693          	addi	a3,s0,-64
    }

    i = 0;
 630:	4701                	li	a4,0
    do {
        buf[i++] = digits[x % base];
 632:	2601                	sext.w	a2,a2
 634:	00000517          	auipc	a0,0x0
 638:	51450513          	addi	a0,a0,1300 # b48 <digits>
 63c:	883a                	mv	a6,a4
 63e:	2705                	addiw	a4,a4,1
 640:	02c5f7bb          	remuw	a5,a1,a2
 644:	1782                	slli	a5,a5,0x20
 646:	9381                	srli	a5,a5,0x20
 648:	97aa                	add	a5,a5,a0
 64a:	0007c783          	lbu	a5,0(a5)
 64e:	00f68023          	sb	a5,0(a3)
    } while ((x /= base) != 0);
 652:	0005879b          	sext.w	a5,a1
 656:	02c5d5bb          	divuw	a1,a1,a2
 65a:	0685                	addi	a3,a3,1
 65c:	fec7f0e3          	bgeu	a5,a2,63c <printint+0x26>
    if (neg)
 660:	00088c63          	beqz	a7,678 <printint+0x62>
        buf[i++] = '-';
 664:	fd070793          	addi	a5,a4,-48
 668:	00878733          	add	a4,a5,s0
 66c:	02d00793          	li	a5,45
 670:	fef70823          	sb	a5,-16(a4)
 674:	0028071b          	addiw	a4,a6,2

    while (--i >= 0)
 678:	02e05c63          	blez	a4,6b0 <printint+0x9a>
 67c:	f04a                	sd	s2,32(sp)
 67e:	ec4e                	sd	s3,24(sp)
 680:	fc040793          	addi	a5,s0,-64
 684:	00e78933          	add	s2,a5,a4
 688:	fff78993          	addi	s3,a5,-1
 68c:	99ba                	add	s3,s3,a4
 68e:	377d                	addiw	a4,a4,-1
 690:	1702                	slli	a4,a4,0x20
 692:	9301                	srli	a4,a4,0x20
 694:	40e989b3          	sub	s3,s3,a4
        putc(fd, buf[i]);
 698:	fff94583          	lbu	a1,-1(s2)
 69c:	8526                	mv	a0,s1
 69e:	00000097          	auipc	ra,0x0
 6a2:	f56080e7          	jalr	-170(ra) # 5f4 <putc>
    while (--i >= 0)
 6a6:	197d                	addi	s2,s2,-1
 6a8:	ff3918e3          	bne	s2,s3,698 <printint+0x82>
 6ac:	7902                	ld	s2,32(sp)
 6ae:	69e2                	ld	s3,24(sp)
}
 6b0:	70e2                	ld	ra,56(sp)
 6b2:	7442                	ld	s0,48(sp)
 6b4:	74a2                	ld	s1,40(sp)
 6b6:	6121                	addi	sp,sp,64
 6b8:	8082                	ret
        x = -xx;
 6ba:	40b005bb          	negw	a1,a1
        neg = 1;
 6be:	4885                	li	a7,1
        x = -xx;
 6c0:	b7b5                	j	62c <printint+0x16>

00000000000006c2 <vprintf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void vprintf(int fd, const char *fmt, va_list ap) {
 6c2:	715d                	addi	sp,sp,-80
 6c4:	e486                	sd	ra,72(sp)
 6c6:	e0a2                	sd	s0,64(sp)
 6c8:	f84a                	sd	s2,48(sp)
 6ca:	0880                	addi	s0,sp,80
    char *s;
    int c, i, state;

    state = 0;
    for (i = 0; fmt[i]; i++) {
 6cc:	0005c903          	lbu	s2,0(a1)
 6d0:	1a090a63          	beqz	s2,884 <vprintf+0x1c2>
 6d4:	fc26                	sd	s1,56(sp)
 6d6:	f44e                	sd	s3,40(sp)
 6d8:	f052                	sd	s4,32(sp)
 6da:	ec56                	sd	s5,24(sp)
 6dc:	e85a                	sd	s6,16(sp)
 6de:	e45e                	sd	s7,8(sp)
 6e0:	8aaa                	mv	s5,a0
 6e2:	8bb2                	mv	s7,a2
 6e4:	00158493          	addi	s1,a1,1
    state = 0;
 6e8:	4981                	li	s3,0
            if (c == '%') {
                state = '%';
            } else {
                putc(fd, c);
            }
        } else if (state == '%') {
 6ea:	02500a13          	li	s4,37
 6ee:	4b55                	li	s6,21
 6f0:	a839                	j	70e <vprintf+0x4c>
                putc(fd, c);
 6f2:	85ca                	mv	a1,s2
 6f4:	8556                	mv	a0,s5
 6f6:	00000097          	auipc	ra,0x0
 6fa:	efe080e7          	jalr	-258(ra) # 5f4 <putc>
 6fe:	a019                	j	704 <vprintf+0x42>
        } else if (state == '%') {
 700:	01498d63          	beq	s3,s4,71a <vprintf+0x58>
    for (i = 0; fmt[i]; i++) {
 704:	0485                	addi	s1,s1,1
 706:	fff4c903          	lbu	s2,-1(s1)
 70a:	16090763          	beqz	s2,878 <vprintf+0x1b6>
        if (state == 0) {
 70e:	fe0999e3          	bnez	s3,700 <vprintf+0x3e>
            if (c == '%') {
 712:	ff4910e3          	bne	s2,s4,6f2 <vprintf+0x30>
                state = '%';
 716:	89d2                	mv	s3,s4
 718:	b7f5                	j	704 <vprintf+0x42>
            if (c == 'd') {
 71a:	13490463          	beq	s2,s4,842 <vprintf+0x180>
 71e:	f9d9079b          	addiw	a5,s2,-99
 722:	0ff7f793          	zext.b	a5,a5
 726:	12fb6763          	bltu	s6,a5,854 <vprintf+0x192>
 72a:	f9d9079b          	addiw	a5,s2,-99
 72e:	0ff7f713          	zext.b	a4,a5
 732:	12eb6163          	bltu	s6,a4,854 <vprintf+0x192>
 736:	00271793          	slli	a5,a4,0x2
 73a:	00000717          	auipc	a4,0x0
 73e:	3b670713          	addi	a4,a4,950 # af0 <malloc+0x17c>
 742:	97ba                	add	a5,a5,a4
 744:	439c                	lw	a5,0(a5)
 746:	97ba                	add	a5,a5,a4
 748:	8782                	jr	a5
                printint(fd, va_arg(ap, int), 10, 1);
 74a:	008b8913          	addi	s2,s7,8
 74e:	4685                	li	a3,1
 750:	4629                	li	a2,10
 752:	000ba583          	lw	a1,0(s7)
 756:	8556                	mv	a0,s5
 758:	00000097          	auipc	ra,0x0
 75c:	ebe080e7          	jalr	-322(ra) # 616 <printint>
 760:	8bca                	mv	s7,s2
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
                putc(fd, c);
            }
            state = 0;
 762:	4981                	li	s3,0
 764:	b745                	j	704 <vprintf+0x42>
                printint(fd, va_arg(ap, uint64), 10, 0);
 766:	008b8913          	addi	s2,s7,8
 76a:	4681                	li	a3,0
 76c:	4629                	li	a2,10
 76e:	000ba583          	lw	a1,0(s7)
 772:	8556                	mv	a0,s5
 774:	00000097          	auipc	ra,0x0
 778:	ea2080e7          	jalr	-350(ra) # 616 <printint>
 77c:	8bca                	mv	s7,s2
            state = 0;
 77e:	4981                	li	s3,0
 780:	b751                	j	704 <vprintf+0x42>
                printint(fd, va_arg(ap, int), 16, 0);
 782:	008b8913          	addi	s2,s7,8
 786:	4681                	li	a3,0
 788:	4641                	li	a2,16
 78a:	000ba583          	lw	a1,0(s7)
 78e:	8556                	mv	a0,s5
 790:	00000097          	auipc	ra,0x0
 794:	e86080e7          	jalr	-378(ra) # 616 <printint>
 798:	8bca                	mv	s7,s2
            state = 0;
 79a:	4981                	li	s3,0
 79c:	b7a5                	j	704 <vprintf+0x42>
 79e:	e062                	sd	s8,0(sp)
                printptr(fd, va_arg(ap, uint64));
 7a0:	008b8c13          	addi	s8,s7,8
 7a4:	000bb983          	ld	s3,0(s7)
    putc(fd, '0');
 7a8:	03000593          	li	a1,48
 7ac:	8556                	mv	a0,s5
 7ae:	00000097          	auipc	ra,0x0
 7b2:	e46080e7          	jalr	-442(ra) # 5f4 <putc>
    putc(fd, 'x');
 7b6:	07800593          	li	a1,120
 7ba:	8556                	mv	a0,s5
 7bc:	00000097          	auipc	ra,0x0
 7c0:	e38080e7          	jalr	-456(ra) # 5f4 <putc>
 7c4:	4941                	li	s2,16
        putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7c6:	00000b97          	auipc	s7,0x0
 7ca:	382b8b93          	addi	s7,s7,898 # b48 <digits>
 7ce:	03c9d793          	srli	a5,s3,0x3c
 7d2:	97de                	add	a5,a5,s7
 7d4:	0007c583          	lbu	a1,0(a5)
 7d8:	8556                	mv	a0,s5
 7da:	00000097          	auipc	ra,0x0
 7de:	e1a080e7          	jalr	-486(ra) # 5f4 <putc>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7e2:	0992                	slli	s3,s3,0x4
 7e4:	397d                	addiw	s2,s2,-1
 7e6:	fe0914e3          	bnez	s2,7ce <vprintf+0x10c>
                printptr(fd, va_arg(ap, uint64));
 7ea:	8be2                	mv	s7,s8
            state = 0;
 7ec:	4981                	li	s3,0
 7ee:	6c02                	ld	s8,0(sp)
 7f0:	bf11                	j	704 <vprintf+0x42>
                s = va_arg(ap, char *);
 7f2:	008b8993          	addi	s3,s7,8
 7f6:	000bb903          	ld	s2,0(s7)
                if (s == 0)
 7fa:	02090163          	beqz	s2,81c <vprintf+0x15a>
                while (*s != 0) {
 7fe:	00094583          	lbu	a1,0(s2)
 802:	c9a5                	beqz	a1,872 <vprintf+0x1b0>
                    putc(fd, *s);
 804:	8556                	mv	a0,s5
 806:	00000097          	auipc	ra,0x0
 80a:	dee080e7          	jalr	-530(ra) # 5f4 <putc>
                    s++;
 80e:	0905                	addi	s2,s2,1
                while (*s != 0) {
 810:	00094583          	lbu	a1,0(s2)
 814:	f9e5                	bnez	a1,804 <vprintf+0x142>
                s = va_arg(ap, char *);
 816:	8bce                	mv	s7,s3
            state = 0;
 818:	4981                	li	s3,0
 81a:	b5ed                	j	704 <vprintf+0x42>
                    s = "(null)";
 81c:	00000917          	auipc	s2,0x0
 820:	2cc90913          	addi	s2,s2,716 # ae8 <malloc+0x174>
                while (*s != 0) {
 824:	02800593          	li	a1,40
 828:	bff1                	j	804 <vprintf+0x142>
                putc(fd, va_arg(ap, uint));
 82a:	008b8913          	addi	s2,s7,8
 82e:	000bc583          	lbu	a1,0(s7)
 832:	8556                	mv	a0,s5
 834:	00000097          	auipc	ra,0x0
 838:	dc0080e7          	jalr	-576(ra) # 5f4 <putc>
 83c:	8bca                	mv	s7,s2
            state = 0;
 83e:	4981                	li	s3,0
 840:	b5d1                	j	704 <vprintf+0x42>
                putc(fd, c);
 842:	02500593          	li	a1,37
 846:	8556                	mv	a0,s5
 848:	00000097          	auipc	ra,0x0
 84c:	dac080e7          	jalr	-596(ra) # 5f4 <putc>
            state = 0;
 850:	4981                	li	s3,0
 852:	bd4d                	j	704 <vprintf+0x42>
                putc(fd, '%');
 854:	02500593          	li	a1,37
 858:	8556                	mv	a0,s5
 85a:	00000097          	auipc	ra,0x0
 85e:	d9a080e7          	jalr	-614(ra) # 5f4 <putc>
                putc(fd, c);
 862:	85ca                	mv	a1,s2
 864:	8556                	mv	a0,s5
 866:	00000097          	auipc	ra,0x0
 86a:	d8e080e7          	jalr	-626(ra) # 5f4 <putc>
            state = 0;
 86e:	4981                	li	s3,0
 870:	bd51                	j	704 <vprintf+0x42>
                s = va_arg(ap, char *);
 872:	8bce                	mv	s7,s3
            state = 0;
 874:	4981                	li	s3,0
 876:	b579                	j	704 <vprintf+0x42>
 878:	74e2                	ld	s1,56(sp)
 87a:	79a2                	ld	s3,40(sp)
 87c:	7a02                	ld	s4,32(sp)
 87e:	6ae2                	ld	s5,24(sp)
 880:	6b42                	ld	s6,16(sp)
 882:	6ba2                	ld	s7,8(sp)
        }
    }
}
 884:	60a6                	ld	ra,72(sp)
 886:	6406                	ld	s0,64(sp)
 888:	7942                	ld	s2,48(sp)
 88a:	6161                	addi	sp,sp,80
 88c:	8082                	ret

000000000000088e <fprintf>:

void fprintf(int fd, const char *fmt, ...) {
 88e:	715d                	addi	sp,sp,-80
 890:	ec06                	sd	ra,24(sp)
 892:	e822                	sd	s0,16(sp)
 894:	1000                	addi	s0,sp,32
 896:	e010                	sd	a2,0(s0)
 898:	e414                	sd	a3,8(s0)
 89a:	e818                	sd	a4,16(s0)
 89c:	ec1c                	sd	a5,24(s0)
 89e:	03043023          	sd	a6,32(s0)
 8a2:	03143423          	sd	a7,40(s0)
    va_list ap;

    va_start(ap, fmt);
 8a6:	fe843423          	sd	s0,-24(s0)
    vprintf(fd, fmt, ap);
 8aa:	8622                	mv	a2,s0
 8ac:	00000097          	auipc	ra,0x0
 8b0:	e16080e7          	jalr	-490(ra) # 6c2 <vprintf>
}
 8b4:	60e2                	ld	ra,24(sp)
 8b6:	6442                	ld	s0,16(sp)
 8b8:	6161                	addi	sp,sp,80
 8ba:	8082                	ret

00000000000008bc <printf>:

void printf(const char *fmt, ...) {
 8bc:	711d                	addi	sp,sp,-96
 8be:	ec06                	sd	ra,24(sp)
 8c0:	e822                	sd	s0,16(sp)
 8c2:	1000                	addi	s0,sp,32
 8c4:	e40c                	sd	a1,8(s0)
 8c6:	e810                	sd	a2,16(s0)
 8c8:	ec14                	sd	a3,24(s0)
 8ca:	f018                	sd	a4,32(s0)
 8cc:	f41c                	sd	a5,40(s0)
 8ce:	03043823          	sd	a6,48(s0)
 8d2:	03143c23          	sd	a7,56(s0)
    va_list ap;

    va_start(ap, fmt);
 8d6:	00840613          	addi	a2,s0,8
 8da:	fec43423          	sd	a2,-24(s0)
    vprintf(1, fmt, ap);
 8de:	85aa                	mv	a1,a0
 8e0:	4505                	li	a0,1
 8e2:	00000097          	auipc	ra,0x0
 8e6:	de0080e7          	jalr	-544(ra) # 6c2 <vprintf>
}
 8ea:	60e2                	ld	ra,24(sp)
 8ec:	6442                	ld	s0,16(sp)
 8ee:	6125                	addi	sp,sp,96
 8f0:	8082                	ret

00000000000008f2 <free>:
typedef union header Header;

static Header base;
static Header *freep;

void free(void *ap) {
 8f2:	1141                	addi	sp,sp,-16
 8f4:	e422                	sd	s0,8(sp)
 8f6:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 8f8:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8fc:	00000797          	auipc	a5,0x0
 900:	6ac7b783          	ld	a5,1708(a5) # fa8 <freep>
 904:	a02d                	j	92e <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr) {
        bp->s.size += p->s.ptr->s.size;
 906:	4618                	lw	a4,8(a2)
 908:	9f2d                	addw	a4,a4,a1
 90a:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 90e:	6398                	ld	a4,0(a5)
 910:	6310                	ld	a2,0(a4)
 912:	a83d                	j	950 <free+0x5e>
    } else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp) {
        p->s.size += bp->s.size;
 914:	ff852703          	lw	a4,-8(a0)
 918:	9f31                	addw	a4,a4,a2
 91a:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 91c:	ff053683          	ld	a3,-16(a0)
 920:	a091                	j	964 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 922:	6398                	ld	a4,0(a5)
 924:	00e7e463          	bltu	a5,a4,92c <free+0x3a>
 928:	00e6ea63          	bltu	a3,a4,93c <free+0x4a>
void free(void *ap) {
 92c:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 92e:	fed7fae3          	bgeu	a5,a3,922 <free+0x30>
 932:	6398                	ld	a4,0(a5)
 934:	00e6e463          	bltu	a3,a4,93c <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 938:	fee7eae3          	bltu	a5,a4,92c <free+0x3a>
    if (bp + bp->s.size == p->s.ptr) {
 93c:	ff852583          	lw	a1,-8(a0)
 940:	6390                	ld	a2,0(a5)
 942:	02059813          	slli	a6,a1,0x20
 946:	01c85713          	srli	a4,a6,0x1c
 94a:	9736                	add	a4,a4,a3
 94c:	fae60de3          	beq	a2,a4,906 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 950:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp) {
 954:	4790                	lw	a2,8(a5)
 956:	02061593          	slli	a1,a2,0x20
 95a:	01c5d713          	srli	a4,a1,0x1c
 95e:	973e                	add	a4,a4,a5
 960:	fae68ae3          	beq	a3,a4,914 <free+0x22>
        p->s.ptr = bp->s.ptr;
 964:	e394                	sd	a3,0(a5)
    } else
        p->s.ptr = bp;
    freep = p;
 966:	00000717          	auipc	a4,0x0
 96a:	64f73123          	sd	a5,1602(a4) # fa8 <freep>
}
 96e:	6422                	ld	s0,8(sp)
 970:	0141                	addi	sp,sp,16
 972:	8082                	ret

0000000000000974 <malloc>:
    hp->s.size = nu;
    free((void *)(hp + 1));
    return freep;
}

void *malloc(uint nbytes) {
 974:	7139                	addi	sp,sp,-64
 976:	fc06                	sd	ra,56(sp)
 978:	f822                	sd	s0,48(sp)
 97a:	f426                	sd	s1,40(sp)
 97c:	ec4e                	sd	s3,24(sp)
 97e:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 980:	02051493          	slli	s1,a0,0x20
 984:	9081                	srli	s1,s1,0x20
 986:	04bd                	addi	s1,s1,15
 988:	8091                	srli	s1,s1,0x4
 98a:	0014899b          	addiw	s3,s1,1
 98e:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0) {
 990:	00000517          	auipc	a0,0x0
 994:	61853503          	ld	a0,1560(a0) # fa8 <freep>
 998:	c915                	beqz	a0,9cc <malloc+0x58>
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 99a:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits) {
 99c:	4798                	lw	a4,8(a5)
 99e:	08977e63          	bgeu	a4,s1,a3a <malloc+0xc6>
 9a2:	f04a                	sd	s2,32(sp)
 9a4:	e852                	sd	s4,16(sp)
 9a6:	e456                	sd	s5,8(sp)
 9a8:	e05a                	sd	s6,0(sp)
    if (nu < 4096)
 9aa:	8a4e                	mv	s4,s3
 9ac:	0009871b          	sext.w	a4,s3
 9b0:	6685                	lui	a3,0x1
 9b2:	00d77363          	bgeu	a4,a3,9b8 <malloc+0x44>
 9b6:	6a05                	lui	s4,0x1
 9b8:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 9bc:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 9c0:	00000917          	auipc	s2,0x0
 9c4:	5e890913          	addi	s2,s2,1512 # fa8 <freep>
    if (p == (char *)-1)
 9c8:	5afd                	li	s5,-1
 9ca:	a091                	j	a0e <malloc+0x9a>
 9cc:	f04a                	sd	s2,32(sp)
 9ce:	e852                	sd	s4,16(sp)
 9d0:	e456                	sd	s5,8(sp)
 9d2:	e05a                	sd	s6,0(sp)
        base.s.ptr = freep = prevp = &base;
 9d4:	00000797          	auipc	a5,0x0
 9d8:	5ec78793          	addi	a5,a5,1516 # fc0 <base>
 9dc:	00000717          	auipc	a4,0x0
 9e0:	5cf73623          	sd	a5,1484(a4) # fa8 <freep>
 9e4:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 9e6:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits) {
 9ea:	b7c1                	j	9aa <malloc+0x36>
                prevp->s.ptr = p->s.ptr;
 9ec:	6398                	ld	a4,0(a5)
 9ee:	e118                	sd	a4,0(a0)
 9f0:	a08d                	j	a52 <malloc+0xde>
    hp->s.size = nu;
 9f2:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 9f6:	0541                	addi	a0,a0,16
 9f8:	00000097          	auipc	ra,0x0
 9fc:	efa080e7          	jalr	-262(ra) # 8f2 <free>
    return freep;
 a00:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 a04:	c13d                	beqz	a0,a6a <malloc+0xf6>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 a06:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits) {
 a08:	4798                	lw	a4,8(a5)
 a0a:	02977463          	bgeu	a4,s1,a32 <malloc+0xbe>
        if (p == freep)
 a0e:	00093703          	ld	a4,0(s2)
 a12:	853e                	mv	a0,a5
 a14:	fef719e3          	bne	a4,a5,a06 <malloc+0x92>
    p = sbrk(nu * sizeof(Header));
 a18:	8552                	mv	a0,s4
 a1a:	00000097          	auipc	ra,0x0
 a1e:	bb2080e7          	jalr	-1102(ra) # 5cc <sbrk>
    if (p == (char *)-1)
 a22:	fd5518e3          	bne	a0,s5,9f2 <malloc+0x7e>
                return 0;
 a26:	4501                	li	a0,0
 a28:	7902                	ld	s2,32(sp)
 a2a:	6a42                	ld	s4,16(sp)
 a2c:	6aa2                	ld	s5,8(sp)
 a2e:	6b02                	ld	s6,0(sp)
 a30:	a03d                	j	a5e <malloc+0xea>
 a32:	7902                	ld	s2,32(sp)
 a34:	6a42                	ld	s4,16(sp)
 a36:	6aa2                	ld	s5,8(sp)
 a38:	6b02                	ld	s6,0(sp)
            if (p->s.size == nunits)
 a3a:	fae489e3          	beq	s1,a4,9ec <malloc+0x78>
                p->s.size -= nunits;
 a3e:	4137073b          	subw	a4,a4,s3
 a42:	c798                	sw	a4,8(a5)
                p += p->s.size;
 a44:	02071693          	slli	a3,a4,0x20
 a48:	01c6d713          	srli	a4,a3,0x1c
 a4c:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 a4e:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 a52:	00000717          	auipc	a4,0x0
 a56:	54a73b23          	sd	a0,1366(a4) # fa8 <freep>
            return (void *)(p + 1);
 a5a:	01078513          	addi	a0,a5,16
    }
}
 a5e:	70e2                	ld	ra,56(sp)
 a60:	7442                	ld	s0,48(sp)
 a62:	74a2                	ld	s1,40(sp)
 a64:	69e2                	ld	s3,24(sp)
 a66:	6121                	addi	sp,sp,64
 a68:	8082                	ret
 a6a:	7902                	ld	s2,32(sp)
 a6c:	6a42                	ld	s4,16(sp)
 a6e:	6aa2                	ld	s5,8(sp)
 a70:	6b02                	ld	s6,0(sp)
 a72:	b7f5                	j	a5e <malloc+0xea>
