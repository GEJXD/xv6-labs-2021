
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
        return matchhere(re + 1, text + 1);
    return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text) {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
    do { // a * matches zero or more instances
        if (matchhere(re, text))
            return 1;
    } while (*text != '\0' && (*text++ == c || c == '.'));
  16:	02e00a13          	li	s4,46
        if (matchhere(re, text))
  1a:	85a6                	mv	a1,s1
  1c:	854e                	mv	a0,s3
  1e:	00000097          	auipc	ra,0x0
  22:	030080e7          	jalr	48(ra) # 4e <matchhere>
  26:	e919                	bnez	a0,3c <matchstar+0x3c>
    } while (*text != '\0' && (*text++ == c || c == '.'));
  28:	0004c783          	lbu	a5,0(s1)
  2c:	cb89                	beqz	a5,3e <matchstar+0x3e>
  2e:	0485                	addi	s1,s1,1
  30:	2781                	sext.w	a5,a5
  32:	ff2784e3          	beq	a5,s2,1a <matchstar+0x1a>
  36:	ff4902e3          	beq	s2,s4,1a <matchstar+0x1a>
  3a:	a011                	j	3e <matchstar+0x3e>
            return 1;
  3c:	4505                	li	a0,1
    return 0;
}
  3e:	70a2                	ld	ra,40(sp)
  40:	7402                	ld	s0,32(sp)
  42:	64e2                	ld	s1,24(sp)
  44:	6942                	ld	s2,16(sp)
  46:	69a2                	ld	s3,8(sp)
  48:	6a02                	ld	s4,0(sp)
  4a:	6145                	addi	sp,sp,48
  4c:	8082                	ret

000000000000004e <matchhere>:
    if (re[0] == '\0')
  4e:	00054703          	lbu	a4,0(a0)
  52:	cb3d                	beqz	a4,c8 <matchhere+0x7a>
int matchhere(char *re, char *text) {
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  5c:	87aa                	mv	a5,a0
    if (re[1] == '*')
  5e:	00154683          	lbu	a3,1(a0)
  62:	02a00613          	li	a2,42
  66:	02c68563          	beq	a3,a2,90 <matchhere+0x42>
    if (re[0] == '$' && re[1] == '\0')
  6a:	02400613          	li	a2,36
  6e:	02c70a63          	beq	a4,a2,a2 <matchhere+0x54>
    if (*text != '\0' && (re[0] == '.' || re[0] == *text))
  72:	0005c683          	lbu	a3,0(a1)
    return 0;
  76:	4501                	li	a0,0
    if (*text != '\0' && (re[0] == '.' || re[0] == *text))
  78:	ca81                	beqz	a3,88 <matchhere+0x3a>
  7a:	02e00613          	li	a2,46
  7e:	02c70d63          	beq	a4,a2,b8 <matchhere+0x6a>
    return 0;
  82:	4501                	li	a0,0
    if (*text != '\0' && (re[0] == '.' || re[0] == *text))
  84:	02d70a63          	beq	a4,a3,b8 <matchhere+0x6a>
}
  88:	60a2                	ld	ra,8(sp)
  8a:	6402                	ld	s0,0(sp)
  8c:	0141                	addi	sp,sp,16
  8e:	8082                	ret
        return matchstar(re[0], re + 2, text);
  90:	862e                	mv	a2,a1
  92:	00250593          	addi	a1,a0,2
  96:	853a                	mv	a0,a4
  98:	00000097          	auipc	ra,0x0
  9c:	f68080e7          	jalr	-152(ra) # 0 <matchstar>
  a0:	b7e5                	j	88 <matchhere+0x3a>
    if (re[0] == '$' && re[1] == '\0')
  a2:	c691                	beqz	a3,ae <matchhere+0x60>
    if (*text != '\0' && (re[0] == '.' || re[0] == *text))
  a4:	0005c683          	lbu	a3,0(a1)
  a8:	fee9                	bnez	a3,82 <matchhere+0x34>
    return 0;
  aa:	4501                	li	a0,0
  ac:	bff1                	j	88 <matchhere+0x3a>
        return *text == '\0';
  ae:	0005c503          	lbu	a0,0(a1)
  b2:	00153513          	seqz	a0,a0
  b6:	bfc9                	j	88 <matchhere+0x3a>
        return matchhere(re + 1, text + 1);
  b8:	0585                	addi	a1,a1,1
  ba:	00178513          	addi	a0,a5,1
  be:	00000097          	auipc	ra,0x0
  c2:	f90080e7          	jalr	-112(ra) # 4e <matchhere>
  c6:	b7c9                	j	88 <matchhere+0x3a>
        return 1;
  c8:	4505                	li	a0,1
}
  ca:	8082                	ret

00000000000000cc <match>:
int match(char *re, char *text) {
  cc:	1101                	addi	sp,sp,-32
  ce:	ec06                	sd	ra,24(sp)
  d0:	e822                	sd	s0,16(sp)
  d2:	e426                	sd	s1,8(sp)
  d4:	e04a                	sd	s2,0(sp)
  d6:	1000                	addi	s0,sp,32
  d8:	892a                	mv	s2,a0
  da:	84ae                	mv	s1,a1
    if (re[0] == '^')
  dc:	00054703          	lbu	a4,0(a0)
  e0:	05e00793          	li	a5,94
  e4:	00f70e63          	beq	a4,a5,100 <match+0x34>
        if (matchhere(re, text))
  e8:	85a6                	mv	a1,s1
  ea:	854a                	mv	a0,s2
  ec:	00000097          	auipc	ra,0x0
  f0:	f62080e7          	jalr	-158(ra) # 4e <matchhere>
  f4:	ed01                	bnez	a0,10c <match+0x40>
    } while (*text++ != '\0');
  f6:	0485                	addi	s1,s1,1
  f8:	fff4c783          	lbu	a5,-1(s1)
  fc:	f7f5                	bnez	a5,e8 <match+0x1c>
  fe:	a801                	j	10e <match+0x42>
        return matchhere(re + 1, text);
 100:	0505                	addi	a0,a0,1
 102:	00000097          	auipc	ra,0x0
 106:	f4c080e7          	jalr	-180(ra) # 4e <matchhere>
 10a:	a011                	j	10e <match+0x42>
            return 1;
 10c:	4505                	li	a0,1
}
 10e:	60e2                	ld	ra,24(sp)
 110:	6442                	ld	s0,16(sp)
 112:	64a2                	ld	s1,8(sp)
 114:	6902                	ld	s2,0(sp)
 116:	6105                	addi	sp,sp,32
 118:	8082                	ret

000000000000011a <grep>:
void grep(char *pattern, int fd) {
 11a:	715d                	addi	sp,sp,-80
 11c:	e486                	sd	ra,72(sp)
 11e:	e0a2                	sd	s0,64(sp)
 120:	fc26                	sd	s1,56(sp)
 122:	f84a                	sd	s2,48(sp)
 124:	f44e                	sd	s3,40(sp)
 126:	f052                	sd	s4,32(sp)
 128:	ec56                	sd	s5,24(sp)
 12a:	e85a                	sd	s6,16(sp)
 12c:	e45e                	sd	s7,8(sp)
 12e:	e062                	sd	s8,0(sp)
 130:	0880                	addi	s0,sp,80
 132:	89aa                	mv	s3,a0
 134:	8b2e                	mv	s6,a1
    m = 0;
 136:	4a01                	li	s4,0
    while ((n = read(fd, buf + m, sizeof(buf) - m - 1)) > 0) {
 138:	3ff00b93          	li	s7,1023
 13c:	00001a97          	auipc	s5,0x1
 140:	e64a8a93          	addi	s5,s5,-412 # fa0 <buf>
 144:	a0a1                	j	18c <grep+0x72>
            p = q + 1;
 146:	00148913          	addi	s2,s1,1
        while ((q = strchr(p, '\n')) != 0) {
 14a:	45a9                	li	a1,10
 14c:	854a                	mv	a0,s2
 14e:	00000097          	auipc	ra,0x0
 152:	1f0080e7          	jalr	496(ra) # 33e <strchr>
 156:	84aa                	mv	s1,a0
 158:	c905                	beqz	a0,188 <grep+0x6e>
            *q = 0;
 15a:	00048023          	sb	zero,0(s1)
            if (match(pattern, p)) {
 15e:	85ca                	mv	a1,s2
 160:	854e                	mv	a0,s3
 162:	00000097          	auipc	ra,0x0
 166:	f6a080e7          	jalr	-150(ra) # cc <match>
 16a:	dd71                	beqz	a0,146 <grep+0x2c>
                *q = '\n';
 16c:	47a9                	li	a5,10
 16e:	00f48023          	sb	a5,0(s1)
                write(1, p, q + 1 - p);
 172:	00148613          	addi	a2,s1,1
 176:	4126063b          	subw	a2,a2,s2
 17a:	85ca                	mv	a1,s2
 17c:	4505                	li	a0,1
 17e:	00000097          	auipc	ra,0x0
 182:	3b8080e7          	jalr	952(ra) # 536 <write>
 186:	b7c1                	j	146 <grep+0x2c>
        if (m > 0) {
 188:	03404763          	bgtz	s4,1b6 <grep+0x9c>
    while ((n = read(fd, buf + m, sizeof(buf) - m - 1)) > 0) {
 18c:	414b863b          	subw	a2,s7,s4
 190:	014a85b3          	add	a1,s5,s4
 194:	855a                	mv	a0,s6
 196:	00000097          	auipc	ra,0x0
 19a:	398080e7          	jalr	920(ra) # 52e <read>
 19e:	02a05b63          	blez	a0,1d4 <grep+0xba>
        m += n;
 1a2:	00aa0c3b          	addw	s8,s4,a0
 1a6:	000c0a1b          	sext.w	s4,s8
        buf[m] = '\0';
 1aa:	014a87b3          	add	a5,s5,s4
 1ae:	00078023          	sb	zero,0(a5)
        p = buf;
 1b2:	8956                	mv	s2,s5
        while ((q = strchr(p, '\n')) != 0) {
 1b4:	bf59                	j	14a <grep+0x30>
            m -= p - buf;
 1b6:	00001517          	auipc	a0,0x1
 1ba:	dea50513          	addi	a0,a0,-534 # fa0 <buf>
 1be:	40a90a33          	sub	s4,s2,a0
 1c2:	414c0a3b          	subw	s4,s8,s4
            memmove(buf, p, m);
 1c6:	8652                	mv	a2,s4
 1c8:	85ca                	mv	a1,s2
 1ca:	00000097          	auipc	ra,0x0
 1ce:	29a080e7          	jalr	666(ra) # 464 <memmove>
 1d2:	bf6d                	j	18c <grep+0x72>
}
 1d4:	60a6                	ld	ra,72(sp)
 1d6:	6406                	ld	s0,64(sp)
 1d8:	74e2                	ld	s1,56(sp)
 1da:	7942                	ld	s2,48(sp)
 1dc:	79a2                	ld	s3,40(sp)
 1de:	7a02                	ld	s4,32(sp)
 1e0:	6ae2                	ld	s5,24(sp)
 1e2:	6b42                	ld	s6,16(sp)
 1e4:	6ba2                	ld	s7,8(sp)
 1e6:	6c02                	ld	s8,0(sp)
 1e8:	6161                	addi	sp,sp,80
 1ea:	8082                	ret

00000000000001ec <main>:
int main(int argc, char *argv[]) {
 1ec:	7179                	addi	sp,sp,-48
 1ee:	f406                	sd	ra,40(sp)
 1f0:	f022                	sd	s0,32(sp)
 1f2:	ec26                	sd	s1,24(sp)
 1f4:	e84a                	sd	s2,16(sp)
 1f6:	e44e                	sd	s3,8(sp)
 1f8:	e052                	sd	s4,0(sp)
 1fa:	1800                	addi	s0,sp,48
    if (argc <= 1) {
 1fc:	4785                	li	a5,1
 1fe:	04a7de63          	bge	a5,a0,25a <main+0x6e>
    pattern = argv[1];
 202:	0085ba03          	ld	s4,8(a1)
    if (argc <= 2) {
 206:	4789                	li	a5,2
 208:	06a7d763          	bge	a5,a0,276 <main+0x8a>
 20c:	01058913          	addi	s2,a1,16
 210:	ffd5099b          	addiw	s3,a0,-3
 214:	02099793          	slli	a5,s3,0x20
 218:	01d7d993          	srli	s3,a5,0x1d
 21c:	05e1                	addi	a1,a1,24
 21e:	99ae                	add	s3,s3,a1
        if ((fd = open(argv[i], 0)) < 0) {
 220:	4581                	li	a1,0
 222:	00093503          	ld	a0,0(s2)
 226:	00000097          	auipc	ra,0x0
 22a:	330080e7          	jalr	816(ra) # 556 <open>
 22e:	84aa                	mv	s1,a0
 230:	04054e63          	bltz	a0,28c <main+0xa0>
        grep(pattern, fd);
 234:	85aa                	mv	a1,a0
 236:	8552                	mv	a0,s4
 238:	00000097          	auipc	ra,0x0
 23c:	ee2080e7          	jalr	-286(ra) # 11a <grep>
        close(fd);
 240:	8526                	mv	a0,s1
 242:	00000097          	auipc	ra,0x0
 246:	2fc080e7          	jalr	764(ra) # 53e <close>
    for (i = 2; i < argc; i++) {
 24a:	0921                	addi	s2,s2,8
 24c:	fd391ae3          	bne	s2,s3,220 <main+0x34>
    exit(0);
 250:	4501                	li	a0,0
 252:	00000097          	auipc	ra,0x0
 256:	2c4080e7          	jalr	708(ra) # 516 <exit>
        fprintf(2, "usage: grep pattern [file ...]\n");
 25a:	00000597          	auipc	a1,0x0
 25e:	7ee58593          	addi	a1,a1,2030 # a48 <malloc+0x102>
 262:	4509                	li	a0,2
 264:	00000097          	auipc	ra,0x0
 268:	5fc080e7          	jalr	1532(ra) # 860 <fprintf>
        exit(1);
 26c:	4505                	li	a0,1
 26e:	00000097          	auipc	ra,0x0
 272:	2a8080e7          	jalr	680(ra) # 516 <exit>
        grep(pattern, 0);
 276:	4581                	li	a1,0
 278:	8552                	mv	a0,s4
 27a:	00000097          	auipc	ra,0x0
 27e:	ea0080e7          	jalr	-352(ra) # 11a <grep>
        exit(0);
 282:	4501                	li	a0,0
 284:	00000097          	auipc	ra,0x0
 288:	292080e7          	jalr	658(ra) # 516 <exit>
            printf("grep: cannot open %s\n", argv[i]);
 28c:	00093583          	ld	a1,0(s2)
 290:	00000517          	auipc	a0,0x0
 294:	7d850513          	addi	a0,a0,2008 # a68 <malloc+0x122>
 298:	00000097          	auipc	ra,0x0
 29c:	5f6080e7          	jalr	1526(ra) # 88e <printf>
            exit(1);
 2a0:	4505                	li	a0,1
 2a2:	00000097          	auipc	ra,0x0
 2a6:	274080e7          	jalr	628(ra) # 516 <exit>

00000000000002aa <strcpy>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "user/user.h"

char *strcpy(char *s, const char *t) {
 2aa:	1141                	addi	sp,sp,-16
 2ac:	e422                	sd	s0,8(sp)
 2ae:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 2b0:	87aa                	mv	a5,a0
 2b2:	0585                	addi	a1,a1,1
 2b4:	0785                	addi	a5,a5,1
 2b6:	fff5c703          	lbu	a4,-1(a1)
 2ba:	fee78fa3          	sb	a4,-1(a5)
 2be:	fb75                	bnez	a4,2b2 <strcpy+0x8>
        ;
    return os;
}
 2c0:	6422                	ld	s0,8(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret

00000000000002c6 <strcmp>:

int strcmp(const char *p, const char *q) {
 2c6:	1141                	addi	sp,sp,-16
 2c8:	e422                	sd	s0,8(sp)
 2ca:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 2cc:	00054783          	lbu	a5,0(a0)
 2d0:	cb91                	beqz	a5,2e4 <strcmp+0x1e>
 2d2:	0005c703          	lbu	a4,0(a1)
 2d6:	00f71763          	bne	a4,a5,2e4 <strcmp+0x1e>
        p++, q++;
 2da:	0505                	addi	a0,a0,1
 2dc:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 2de:	00054783          	lbu	a5,0(a0)
 2e2:	fbe5                	bnez	a5,2d2 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 2e4:	0005c503          	lbu	a0,0(a1)
}
 2e8:	40a7853b          	subw	a0,a5,a0
 2ec:	6422                	ld	s0,8(sp)
 2ee:	0141                	addi	sp,sp,16
 2f0:	8082                	ret

00000000000002f2 <strlen>:

uint strlen(const char *s) {
 2f2:	1141                	addi	sp,sp,-16
 2f4:	e422                	sd	s0,8(sp)
 2f6:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 2f8:	00054783          	lbu	a5,0(a0)
 2fc:	cf91                	beqz	a5,318 <strlen+0x26>
 2fe:	0505                	addi	a0,a0,1
 300:	87aa                	mv	a5,a0
 302:	86be                	mv	a3,a5
 304:	0785                	addi	a5,a5,1
 306:	fff7c703          	lbu	a4,-1(a5)
 30a:	ff65                	bnez	a4,302 <strlen+0x10>
 30c:	40a6853b          	subw	a0,a3,a0
 310:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 312:	6422                	ld	s0,8(sp)
 314:	0141                	addi	sp,sp,16
 316:	8082                	ret
    for (n = 0; s[n]; n++)
 318:	4501                	li	a0,0
 31a:	bfe5                	j	312 <strlen+0x20>

000000000000031c <memset>:

void *memset(void *dst, int c, uint n) {
 31c:	1141                	addi	sp,sp,-16
 31e:	e422                	sd	s0,8(sp)
 320:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++) {
 322:	ca19                	beqz	a2,338 <memset+0x1c>
 324:	87aa                	mv	a5,a0
 326:	1602                	slli	a2,a2,0x20
 328:	9201                	srli	a2,a2,0x20
 32a:	00a60733          	add	a4,a2,a0
        cdst[i] = c;
 32e:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++) {
 332:	0785                	addi	a5,a5,1
 334:	fee79de3          	bne	a5,a4,32e <memset+0x12>
    }
    return dst;
}
 338:	6422                	ld	s0,8(sp)
 33a:	0141                	addi	sp,sp,16
 33c:	8082                	ret

000000000000033e <strchr>:

char *strchr(const char *s, char c) {
 33e:	1141                	addi	sp,sp,-16
 340:	e422                	sd	s0,8(sp)
 342:	0800                	addi	s0,sp,16
    for (; *s; s++)
 344:	00054783          	lbu	a5,0(a0)
 348:	cb99                	beqz	a5,35e <strchr+0x20>
        if (*s == c)
 34a:	00f58763          	beq	a1,a5,358 <strchr+0x1a>
    for (; *s; s++)
 34e:	0505                	addi	a0,a0,1
 350:	00054783          	lbu	a5,0(a0)
 354:	fbfd                	bnez	a5,34a <strchr+0xc>
            return (char *)s;
    return 0;
 356:	4501                	li	a0,0
}
 358:	6422                	ld	s0,8(sp)
 35a:	0141                	addi	sp,sp,16
 35c:	8082                	ret
    return 0;
 35e:	4501                	li	a0,0
 360:	bfe5                	j	358 <strchr+0x1a>

0000000000000362 <gets>:

char *gets(char *buf, int max) {
 362:	711d                	addi	sp,sp,-96
 364:	ec86                	sd	ra,88(sp)
 366:	e8a2                	sd	s0,80(sp)
 368:	e4a6                	sd	s1,72(sp)
 36a:	e0ca                	sd	s2,64(sp)
 36c:	fc4e                	sd	s3,56(sp)
 36e:	f852                	sd	s4,48(sp)
 370:	f456                	sd	s5,40(sp)
 372:	f05a                	sd	s6,32(sp)
 374:	ec5e                	sd	s7,24(sp)
 376:	1080                	addi	s0,sp,96
 378:	8baa                	mv	s7,a0
 37a:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
 37c:	892a                	mv	s2,a0
 37e:	4481                	li	s1,0
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 380:	4aa9                	li	s5,10
 382:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;) {
 384:	89a6                	mv	s3,s1
 386:	2485                	addiw	s1,s1,1
 388:	0344d863          	bge	s1,s4,3b8 <gets+0x56>
        cc = read(0, &c, 1);
 38c:	4605                	li	a2,1
 38e:	faf40593          	addi	a1,s0,-81
 392:	4501                	li	a0,0
 394:	00000097          	auipc	ra,0x0
 398:	19a080e7          	jalr	410(ra) # 52e <read>
        if (cc < 1)
 39c:	00a05e63          	blez	a0,3b8 <gets+0x56>
        buf[i++] = c;
 3a0:	faf44783          	lbu	a5,-81(s0)
 3a4:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 3a8:	01578763          	beq	a5,s5,3b6 <gets+0x54>
 3ac:	0905                	addi	s2,s2,1
 3ae:	fd679be3          	bne	a5,s6,384 <gets+0x22>
        buf[i++] = c;
 3b2:	89a6                	mv	s3,s1
 3b4:	a011                	j	3b8 <gets+0x56>
 3b6:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 3b8:	99de                	add	s3,s3,s7
 3ba:	00098023          	sb	zero,0(s3)
    return buf;
}
 3be:	855e                	mv	a0,s7
 3c0:	60e6                	ld	ra,88(sp)
 3c2:	6446                	ld	s0,80(sp)
 3c4:	64a6                	ld	s1,72(sp)
 3c6:	6906                	ld	s2,64(sp)
 3c8:	79e2                	ld	s3,56(sp)
 3ca:	7a42                	ld	s4,48(sp)
 3cc:	7aa2                	ld	s5,40(sp)
 3ce:	7b02                	ld	s6,32(sp)
 3d0:	6be2                	ld	s7,24(sp)
 3d2:	6125                	addi	sp,sp,96
 3d4:	8082                	ret

00000000000003d6 <stat>:

int stat(const char *n, struct stat *st) {
 3d6:	1101                	addi	sp,sp,-32
 3d8:	ec06                	sd	ra,24(sp)
 3da:	e822                	sd	s0,16(sp)
 3dc:	e04a                	sd	s2,0(sp)
 3de:	1000                	addi	s0,sp,32
 3e0:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 3e2:	4581                	li	a1,0
 3e4:	00000097          	auipc	ra,0x0
 3e8:	172080e7          	jalr	370(ra) # 556 <open>
    if (fd < 0)
 3ec:	02054663          	bltz	a0,418 <stat+0x42>
 3f0:	e426                	sd	s1,8(sp)
 3f2:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 3f4:	85ca                	mv	a1,s2
 3f6:	00000097          	auipc	ra,0x0
 3fa:	178080e7          	jalr	376(ra) # 56e <fstat>
 3fe:	892a                	mv	s2,a0
    close(fd);
 400:	8526                	mv	a0,s1
 402:	00000097          	auipc	ra,0x0
 406:	13c080e7          	jalr	316(ra) # 53e <close>
    return r;
 40a:	64a2                	ld	s1,8(sp)
}
 40c:	854a                	mv	a0,s2
 40e:	60e2                	ld	ra,24(sp)
 410:	6442                	ld	s0,16(sp)
 412:	6902                	ld	s2,0(sp)
 414:	6105                	addi	sp,sp,32
 416:	8082                	ret
        return -1;
 418:	597d                	li	s2,-1
 41a:	bfcd                	j	40c <stat+0x36>

000000000000041c <atoi>:

int atoi(const char *s) {
 41c:	1141                	addi	sp,sp,-16
 41e:	e422                	sd	s0,8(sp)
 420:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 422:	00054683          	lbu	a3,0(a0)
 426:	fd06879b          	addiw	a5,a3,-48
 42a:	0ff7f793          	zext.b	a5,a5
 42e:	4625                	li	a2,9
 430:	02f66863          	bltu	a2,a5,460 <atoi+0x44>
 434:	872a                	mv	a4,a0
    n = 0;
 436:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 438:	0705                	addi	a4,a4,1
 43a:	0025179b          	slliw	a5,a0,0x2
 43e:	9fa9                	addw	a5,a5,a0
 440:	0017979b          	slliw	a5,a5,0x1
 444:	9fb5                	addw	a5,a5,a3
 446:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 44a:	00074683          	lbu	a3,0(a4)
 44e:	fd06879b          	addiw	a5,a3,-48
 452:	0ff7f793          	zext.b	a5,a5
 456:	fef671e3          	bgeu	a2,a5,438 <atoi+0x1c>
    return n;
}
 45a:	6422                	ld	s0,8(sp)
 45c:	0141                	addi	sp,sp,16
 45e:	8082                	ret
    n = 0;
 460:	4501                	li	a0,0
 462:	bfe5                	j	45a <atoi+0x3e>

0000000000000464 <memmove>:

void *memmove(void *vdst, const void *vsrc, int n) {
 464:	1141                	addi	sp,sp,-16
 466:	e422                	sd	s0,8(sp)
 468:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
 46a:	02b57463          	bgeu	a0,a1,492 <memmove+0x2e>
        while (n-- > 0)
 46e:	00c05f63          	blez	a2,48c <memmove+0x28>
 472:	1602                	slli	a2,a2,0x20
 474:	9201                	srli	a2,a2,0x20
 476:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 47a:	872a                	mv	a4,a0
            *dst++ = *src++;
 47c:	0585                	addi	a1,a1,1
 47e:	0705                	addi	a4,a4,1
 480:	fff5c683          	lbu	a3,-1(a1)
 484:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 488:	fef71ae3          	bne	a4,a5,47c <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 48c:	6422                	ld	s0,8(sp)
 48e:	0141                	addi	sp,sp,16
 490:	8082                	ret
        dst += n;
 492:	00c50733          	add	a4,a0,a2
        src += n;
 496:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 498:	fec05ae3          	blez	a2,48c <memmove+0x28>
 49c:	fff6079b          	addiw	a5,a2,-1
 4a0:	1782                	slli	a5,a5,0x20
 4a2:	9381                	srli	a5,a5,0x20
 4a4:	fff7c793          	not	a5,a5
 4a8:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 4aa:	15fd                	addi	a1,a1,-1
 4ac:	177d                	addi	a4,a4,-1
 4ae:	0005c683          	lbu	a3,0(a1)
 4b2:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 4b6:	fee79ae3          	bne	a5,a4,4aa <memmove+0x46>
 4ba:	bfc9                	j	48c <memmove+0x28>

00000000000004bc <memcmp>:

int memcmp(const void *s1, const void *s2, uint n) {
 4bc:	1141                	addi	sp,sp,-16
 4be:	e422                	sd	s0,8(sp)
 4c0:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0) {
 4c2:	ca05                	beqz	a2,4f2 <memcmp+0x36>
 4c4:	fff6069b          	addiw	a3,a2,-1
 4c8:	1682                	slli	a3,a3,0x20
 4ca:	9281                	srli	a3,a3,0x20
 4cc:	0685                	addi	a3,a3,1
 4ce:	96aa                	add	a3,a3,a0
        if (*p1 != *p2) {
 4d0:	00054783          	lbu	a5,0(a0)
 4d4:	0005c703          	lbu	a4,0(a1)
 4d8:	00e79863          	bne	a5,a4,4e8 <memcmp+0x2c>
            return *p1 - *p2;
        }
        p1++;
 4dc:	0505                	addi	a0,a0,1
        p2++;
 4de:	0585                	addi	a1,a1,1
    while (n-- > 0) {
 4e0:	fed518e3          	bne	a0,a3,4d0 <memcmp+0x14>
    }
    return 0;
 4e4:	4501                	li	a0,0
 4e6:	a019                	j	4ec <memcmp+0x30>
            return *p1 - *p2;
 4e8:	40e7853b          	subw	a0,a5,a4
}
 4ec:	6422                	ld	s0,8(sp)
 4ee:	0141                	addi	sp,sp,16
 4f0:	8082                	ret
    return 0;
 4f2:	4501                	li	a0,0
 4f4:	bfe5                	j	4ec <memcmp+0x30>

00000000000004f6 <memcpy>:

void *memcpy(void *dst, const void *src, uint n) {
 4f6:	1141                	addi	sp,sp,-16
 4f8:	e406                	sd	ra,8(sp)
 4fa:	e022                	sd	s0,0(sp)
 4fc:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 4fe:	00000097          	auipc	ra,0x0
 502:	f66080e7          	jalr	-154(ra) # 464 <memmove>
}
 506:	60a2                	ld	ra,8(sp)
 508:	6402                	ld	s0,0(sp)
 50a:	0141                	addi	sp,sp,16
 50c:	8082                	ret

000000000000050e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 50e:	4885                	li	a7,1
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <exit>:
.global exit
exit:
 li a7, SYS_exit
 516:	4889                	li	a7,2
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <wait>:
.global wait
wait:
 li a7, SYS_wait
 51e:	488d                	li	a7,3
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 526:	4891                	li	a7,4
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <read>:
.global read
read:
 li a7, SYS_read
 52e:	4895                	li	a7,5
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <write>:
.global write
write:
 li a7, SYS_write
 536:	48c1                	li	a7,16
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <close>:
.global close
close:
 li a7, SYS_close
 53e:	48d5                	li	a7,21
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <kill>:
.global kill
kill:
 li a7, SYS_kill
 546:	4899                	li	a7,6
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <exec>:
.global exec
exec:
 li a7, SYS_exec
 54e:	489d                	li	a7,7
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <open>:
.global open
open:
 li a7, SYS_open
 556:	48bd                	li	a7,15
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 55e:	48c5                	li	a7,17
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 566:	48c9                	li	a7,18
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 56e:	48a1                	li	a7,8
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <link>:
.global link
link:
 li a7, SYS_link
 576:	48cd                	li	a7,19
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 57e:	48d1                	li	a7,20
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 586:	48a5                	li	a7,9
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <dup>:
.global dup
dup:
 li a7, SYS_dup
 58e:	48a9                	li	a7,10
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 596:	48ad                	li	a7,11
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 59e:	48b1                	li	a7,12
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5a6:	48b5                	li	a7,13
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5ae:	48b9                	li	a7,14
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <trace>:
.global trace
trace:
 li a7, SYS_trace
 5b6:	48d9                	li	a7,22
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 5be:	48dd                	li	a7,23
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <putc>:

#include <stdarg.h>

static char digits[] = "0123456789ABCDEF";

static void putc(int fd, char c) { write(fd, &c, 1); }
 5c6:	1101                	addi	sp,sp,-32
 5c8:	ec06                	sd	ra,24(sp)
 5ca:	e822                	sd	s0,16(sp)
 5cc:	1000                	addi	s0,sp,32
 5ce:	feb407a3          	sb	a1,-17(s0)
 5d2:	4605                	li	a2,1
 5d4:	fef40593          	addi	a1,s0,-17
 5d8:	00000097          	auipc	ra,0x0
 5dc:	f5e080e7          	jalr	-162(ra) # 536 <write>
 5e0:	60e2                	ld	ra,24(sp)
 5e2:	6442                	ld	s0,16(sp)
 5e4:	6105                	addi	sp,sp,32
 5e6:	8082                	ret

00000000000005e8 <printint>:

static void printint(int fd, int xx, int base, int sgn) {
 5e8:	7139                	addi	sp,sp,-64
 5ea:	fc06                	sd	ra,56(sp)
 5ec:	f822                	sd	s0,48(sp)
 5ee:	f426                	sd	s1,40(sp)
 5f0:	0080                	addi	s0,sp,64
 5f2:	84aa                	mv	s1,a0
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if (sgn && xx < 0) {
 5f4:	c299                	beqz	a3,5fa <printint+0x12>
 5f6:	0805cb63          	bltz	a1,68c <printint+0xa4>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
 5fa:	2581                	sext.w	a1,a1
    neg = 0;
 5fc:	4881                	li	a7,0
 5fe:	fc040693          	addi	a3,s0,-64
    }

    i = 0;
 602:	4701                	li	a4,0
    do {
        buf[i++] = digits[x % base];
 604:	2601                	sext.w	a2,a2
 606:	00000517          	auipc	a0,0x0
 60a:	4da50513          	addi	a0,a0,1242 # ae0 <digits>
 60e:	883a                	mv	a6,a4
 610:	2705                	addiw	a4,a4,1
 612:	02c5f7bb          	remuw	a5,a1,a2
 616:	1782                	slli	a5,a5,0x20
 618:	9381                	srli	a5,a5,0x20
 61a:	97aa                	add	a5,a5,a0
 61c:	0007c783          	lbu	a5,0(a5)
 620:	00f68023          	sb	a5,0(a3)
    } while ((x /= base) != 0);
 624:	0005879b          	sext.w	a5,a1
 628:	02c5d5bb          	divuw	a1,a1,a2
 62c:	0685                	addi	a3,a3,1
 62e:	fec7f0e3          	bgeu	a5,a2,60e <printint+0x26>
    if (neg)
 632:	00088c63          	beqz	a7,64a <printint+0x62>
        buf[i++] = '-';
 636:	fd070793          	addi	a5,a4,-48
 63a:	00878733          	add	a4,a5,s0
 63e:	02d00793          	li	a5,45
 642:	fef70823          	sb	a5,-16(a4)
 646:	0028071b          	addiw	a4,a6,2

    while (--i >= 0)
 64a:	02e05c63          	blez	a4,682 <printint+0x9a>
 64e:	f04a                	sd	s2,32(sp)
 650:	ec4e                	sd	s3,24(sp)
 652:	fc040793          	addi	a5,s0,-64
 656:	00e78933          	add	s2,a5,a4
 65a:	fff78993          	addi	s3,a5,-1
 65e:	99ba                	add	s3,s3,a4
 660:	377d                	addiw	a4,a4,-1
 662:	1702                	slli	a4,a4,0x20
 664:	9301                	srli	a4,a4,0x20
 666:	40e989b3          	sub	s3,s3,a4
        putc(fd, buf[i]);
 66a:	fff94583          	lbu	a1,-1(s2)
 66e:	8526                	mv	a0,s1
 670:	00000097          	auipc	ra,0x0
 674:	f56080e7          	jalr	-170(ra) # 5c6 <putc>
    while (--i >= 0)
 678:	197d                	addi	s2,s2,-1
 67a:	ff3918e3          	bne	s2,s3,66a <printint+0x82>
 67e:	7902                	ld	s2,32(sp)
 680:	69e2                	ld	s3,24(sp)
}
 682:	70e2                	ld	ra,56(sp)
 684:	7442                	ld	s0,48(sp)
 686:	74a2                	ld	s1,40(sp)
 688:	6121                	addi	sp,sp,64
 68a:	8082                	ret
        x = -xx;
 68c:	40b005bb          	negw	a1,a1
        neg = 1;
 690:	4885                	li	a7,1
        x = -xx;
 692:	b7b5                	j	5fe <printint+0x16>

0000000000000694 <vprintf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void vprintf(int fd, const char *fmt, va_list ap) {
 694:	715d                	addi	sp,sp,-80
 696:	e486                	sd	ra,72(sp)
 698:	e0a2                	sd	s0,64(sp)
 69a:	f84a                	sd	s2,48(sp)
 69c:	0880                	addi	s0,sp,80
    char *s;
    int c, i, state;

    state = 0;
    for (i = 0; fmt[i]; i++) {
 69e:	0005c903          	lbu	s2,0(a1)
 6a2:	1a090a63          	beqz	s2,856 <vprintf+0x1c2>
 6a6:	fc26                	sd	s1,56(sp)
 6a8:	f44e                	sd	s3,40(sp)
 6aa:	f052                	sd	s4,32(sp)
 6ac:	ec56                	sd	s5,24(sp)
 6ae:	e85a                	sd	s6,16(sp)
 6b0:	e45e                	sd	s7,8(sp)
 6b2:	8aaa                	mv	s5,a0
 6b4:	8bb2                	mv	s7,a2
 6b6:	00158493          	addi	s1,a1,1
    state = 0;
 6ba:	4981                	li	s3,0
            if (c == '%') {
                state = '%';
            } else {
                putc(fd, c);
            }
        } else if (state == '%') {
 6bc:	02500a13          	li	s4,37
 6c0:	4b55                	li	s6,21
 6c2:	a839                	j	6e0 <vprintf+0x4c>
                putc(fd, c);
 6c4:	85ca                	mv	a1,s2
 6c6:	8556                	mv	a0,s5
 6c8:	00000097          	auipc	ra,0x0
 6cc:	efe080e7          	jalr	-258(ra) # 5c6 <putc>
 6d0:	a019                	j	6d6 <vprintf+0x42>
        } else if (state == '%') {
 6d2:	01498d63          	beq	s3,s4,6ec <vprintf+0x58>
    for (i = 0; fmt[i]; i++) {
 6d6:	0485                	addi	s1,s1,1
 6d8:	fff4c903          	lbu	s2,-1(s1)
 6dc:	16090763          	beqz	s2,84a <vprintf+0x1b6>
        if (state == 0) {
 6e0:	fe0999e3          	bnez	s3,6d2 <vprintf+0x3e>
            if (c == '%') {
 6e4:	ff4910e3          	bne	s2,s4,6c4 <vprintf+0x30>
                state = '%';
 6e8:	89d2                	mv	s3,s4
 6ea:	b7f5                	j	6d6 <vprintf+0x42>
            if (c == 'd') {
 6ec:	13490463          	beq	s2,s4,814 <vprintf+0x180>
 6f0:	f9d9079b          	addiw	a5,s2,-99
 6f4:	0ff7f793          	zext.b	a5,a5
 6f8:	12fb6763          	bltu	s6,a5,826 <vprintf+0x192>
 6fc:	f9d9079b          	addiw	a5,s2,-99
 700:	0ff7f713          	zext.b	a4,a5
 704:	12eb6163          	bltu	s6,a4,826 <vprintf+0x192>
 708:	00271793          	slli	a5,a4,0x2
 70c:	00000717          	auipc	a4,0x0
 710:	37c70713          	addi	a4,a4,892 # a88 <malloc+0x142>
 714:	97ba                	add	a5,a5,a4
 716:	439c                	lw	a5,0(a5)
 718:	97ba                	add	a5,a5,a4
 71a:	8782                	jr	a5
                printint(fd, va_arg(ap, int), 10, 1);
 71c:	008b8913          	addi	s2,s7,8
 720:	4685                	li	a3,1
 722:	4629                	li	a2,10
 724:	000ba583          	lw	a1,0(s7)
 728:	8556                	mv	a0,s5
 72a:	00000097          	auipc	ra,0x0
 72e:	ebe080e7          	jalr	-322(ra) # 5e8 <printint>
 732:	8bca                	mv	s7,s2
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
                putc(fd, c);
            }
            state = 0;
 734:	4981                	li	s3,0
 736:	b745                	j	6d6 <vprintf+0x42>
                printint(fd, va_arg(ap, uint64), 10, 0);
 738:	008b8913          	addi	s2,s7,8
 73c:	4681                	li	a3,0
 73e:	4629                	li	a2,10
 740:	000ba583          	lw	a1,0(s7)
 744:	8556                	mv	a0,s5
 746:	00000097          	auipc	ra,0x0
 74a:	ea2080e7          	jalr	-350(ra) # 5e8 <printint>
 74e:	8bca                	mv	s7,s2
            state = 0;
 750:	4981                	li	s3,0
 752:	b751                	j	6d6 <vprintf+0x42>
                printint(fd, va_arg(ap, int), 16, 0);
 754:	008b8913          	addi	s2,s7,8
 758:	4681                	li	a3,0
 75a:	4641                	li	a2,16
 75c:	000ba583          	lw	a1,0(s7)
 760:	8556                	mv	a0,s5
 762:	00000097          	auipc	ra,0x0
 766:	e86080e7          	jalr	-378(ra) # 5e8 <printint>
 76a:	8bca                	mv	s7,s2
            state = 0;
 76c:	4981                	li	s3,0
 76e:	b7a5                	j	6d6 <vprintf+0x42>
 770:	e062                	sd	s8,0(sp)
                printptr(fd, va_arg(ap, uint64));
 772:	008b8c13          	addi	s8,s7,8
 776:	000bb983          	ld	s3,0(s7)
    putc(fd, '0');
 77a:	03000593          	li	a1,48
 77e:	8556                	mv	a0,s5
 780:	00000097          	auipc	ra,0x0
 784:	e46080e7          	jalr	-442(ra) # 5c6 <putc>
    putc(fd, 'x');
 788:	07800593          	li	a1,120
 78c:	8556                	mv	a0,s5
 78e:	00000097          	auipc	ra,0x0
 792:	e38080e7          	jalr	-456(ra) # 5c6 <putc>
 796:	4941                	li	s2,16
        putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 798:	00000b97          	auipc	s7,0x0
 79c:	348b8b93          	addi	s7,s7,840 # ae0 <digits>
 7a0:	03c9d793          	srli	a5,s3,0x3c
 7a4:	97de                	add	a5,a5,s7
 7a6:	0007c583          	lbu	a1,0(a5)
 7aa:	8556                	mv	a0,s5
 7ac:	00000097          	auipc	ra,0x0
 7b0:	e1a080e7          	jalr	-486(ra) # 5c6 <putc>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7b4:	0992                	slli	s3,s3,0x4
 7b6:	397d                	addiw	s2,s2,-1
 7b8:	fe0914e3          	bnez	s2,7a0 <vprintf+0x10c>
                printptr(fd, va_arg(ap, uint64));
 7bc:	8be2                	mv	s7,s8
            state = 0;
 7be:	4981                	li	s3,0
 7c0:	6c02                	ld	s8,0(sp)
 7c2:	bf11                	j	6d6 <vprintf+0x42>
                s = va_arg(ap, char *);
 7c4:	008b8993          	addi	s3,s7,8
 7c8:	000bb903          	ld	s2,0(s7)
                if (s == 0)
 7cc:	02090163          	beqz	s2,7ee <vprintf+0x15a>
                while (*s != 0) {
 7d0:	00094583          	lbu	a1,0(s2)
 7d4:	c9a5                	beqz	a1,844 <vprintf+0x1b0>
                    putc(fd, *s);
 7d6:	8556                	mv	a0,s5
 7d8:	00000097          	auipc	ra,0x0
 7dc:	dee080e7          	jalr	-530(ra) # 5c6 <putc>
                    s++;
 7e0:	0905                	addi	s2,s2,1
                while (*s != 0) {
 7e2:	00094583          	lbu	a1,0(s2)
 7e6:	f9e5                	bnez	a1,7d6 <vprintf+0x142>
                s = va_arg(ap, char *);
 7e8:	8bce                	mv	s7,s3
            state = 0;
 7ea:	4981                	li	s3,0
 7ec:	b5ed                	j	6d6 <vprintf+0x42>
                    s = "(null)";
 7ee:	00000917          	auipc	s2,0x0
 7f2:	29290913          	addi	s2,s2,658 # a80 <malloc+0x13a>
                while (*s != 0) {
 7f6:	02800593          	li	a1,40
 7fa:	bff1                	j	7d6 <vprintf+0x142>
                putc(fd, va_arg(ap, uint));
 7fc:	008b8913          	addi	s2,s7,8
 800:	000bc583          	lbu	a1,0(s7)
 804:	8556                	mv	a0,s5
 806:	00000097          	auipc	ra,0x0
 80a:	dc0080e7          	jalr	-576(ra) # 5c6 <putc>
 80e:	8bca                	mv	s7,s2
            state = 0;
 810:	4981                	li	s3,0
 812:	b5d1                	j	6d6 <vprintf+0x42>
                putc(fd, c);
 814:	02500593          	li	a1,37
 818:	8556                	mv	a0,s5
 81a:	00000097          	auipc	ra,0x0
 81e:	dac080e7          	jalr	-596(ra) # 5c6 <putc>
            state = 0;
 822:	4981                	li	s3,0
 824:	bd4d                	j	6d6 <vprintf+0x42>
                putc(fd, '%');
 826:	02500593          	li	a1,37
 82a:	8556                	mv	a0,s5
 82c:	00000097          	auipc	ra,0x0
 830:	d9a080e7          	jalr	-614(ra) # 5c6 <putc>
                putc(fd, c);
 834:	85ca                	mv	a1,s2
 836:	8556                	mv	a0,s5
 838:	00000097          	auipc	ra,0x0
 83c:	d8e080e7          	jalr	-626(ra) # 5c6 <putc>
            state = 0;
 840:	4981                	li	s3,0
 842:	bd51                	j	6d6 <vprintf+0x42>
                s = va_arg(ap, char *);
 844:	8bce                	mv	s7,s3
            state = 0;
 846:	4981                	li	s3,0
 848:	b579                	j	6d6 <vprintf+0x42>
 84a:	74e2                	ld	s1,56(sp)
 84c:	79a2                	ld	s3,40(sp)
 84e:	7a02                	ld	s4,32(sp)
 850:	6ae2                	ld	s5,24(sp)
 852:	6b42                	ld	s6,16(sp)
 854:	6ba2                	ld	s7,8(sp)
        }
    }
}
 856:	60a6                	ld	ra,72(sp)
 858:	6406                	ld	s0,64(sp)
 85a:	7942                	ld	s2,48(sp)
 85c:	6161                	addi	sp,sp,80
 85e:	8082                	ret

0000000000000860 <fprintf>:

void fprintf(int fd, const char *fmt, ...) {
 860:	715d                	addi	sp,sp,-80
 862:	ec06                	sd	ra,24(sp)
 864:	e822                	sd	s0,16(sp)
 866:	1000                	addi	s0,sp,32
 868:	e010                	sd	a2,0(s0)
 86a:	e414                	sd	a3,8(s0)
 86c:	e818                	sd	a4,16(s0)
 86e:	ec1c                	sd	a5,24(s0)
 870:	03043023          	sd	a6,32(s0)
 874:	03143423          	sd	a7,40(s0)
    va_list ap;

    va_start(ap, fmt);
 878:	fe843423          	sd	s0,-24(s0)
    vprintf(fd, fmt, ap);
 87c:	8622                	mv	a2,s0
 87e:	00000097          	auipc	ra,0x0
 882:	e16080e7          	jalr	-490(ra) # 694 <vprintf>
}
 886:	60e2                	ld	ra,24(sp)
 888:	6442                	ld	s0,16(sp)
 88a:	6161                	addi	sp,sp,80
 88c:	8082                	ret

000000000000088e <printf>:

void printf(const char *fmt, ...) {
 88e:	711d                	addi	sp,sp,-96
 890:	ec06                	sd	ra,24(sp)
 892:	e822                	sd	s0,16(sp)
 894:	1000                	addi	s0,sp,32
 896:	e40c                	sd	a1,8(s0)
 898:	e810                	sd	a2,16(s0)
 89a:	ec14                	sd	a3,24(s0)
 89c:	f018                	sd	a4,32(s0)
 89e:	f41c                	sd	a5,40(s0)
 8a0:	03043823          	sd	a6,48(s0)
 8a4:	03143c23          	sd	a7,56(s0)
    va_list ap;

    va_start(ap, fmt);
 8a8:	00840613          	addi	a2,s0,8
 8ac:	fec43423          	sd	a2,-24(s0)
    vprintf(1, fmt, ap);
 8b0:	85aa                	mv	a1,a0
 8b2:	4505                	li	a0,1
 8b4:	00000097          	auipc	ra,0x0
 8b8:	de0080e7          	jalr	-544(ra) # 694 <vprintf>
}
 8bc:	60e2                	ld	ra,24(sp)
 8be:	6442                	ld	s0,16(sp)
 8c0:	6125                	addi	sp,sp,96
 8c2:	8082                	ret

00000000000008c4 <free>:
typedef union header Header;

static Header base;
static Header *freep;

void free(void *ap) {
 8c4:	1141                	addi	sp,sp,-16
 8c6:	e422                	sd	s0,8(sp)
 8c8:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 8ca:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ce:	00000797          	auipc	a5,0x0
 8d2:	6ca7b783          	ld	a5,1738(a5) # f98 <freep>
 8d6:	a02d                	j	900 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr) {
        bp->s.size += p->s.ptr->s.size;
 8d8:	4618                	lw	a4,8(a2)
 8da:	9f2d                	addw	a4,a4,a1
 8dc:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 8e0:	6398                	ld	a4,0(a5)
 8e2:	6310                	ld	a2,0(a4)
 8e4:	a83d                	j	922 <free+0x5e>
    } else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp) {
        p->s.size += bp->s.size;
 8e6:	ff852703          	lw	a4,-8(a0)
 8ea:	9f31                	addw	a4,a4,a2
 8ec:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 8ee:	ff053683          	ld	a3,-16(a0)
 8f2:	a091                	j	936 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8f4:	6398                	ld	a4,0(a5)
 8f6:	00e7e463          	bltu	a5,a4,8fe <free+0x3a>
 8fa:	00e6ea63          	bltu	a3,a4,90e <free+0x4a>
void free(void *ap) {
 8fe:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 900:	fed7fae3          	bgeu	a5,a3,8f4 <free+0x30>
 904:	6398                	ld	a4,0(a5)
 906:	00e6e463          	bltu	a3,a4,90e <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 90a:	fee7eae3          	bltu	a5,a4,8fe <free+0x3a>
    if (bp + bp->s.size == p->s.ptr) {
 90e:	ff852583          	lw	a1,-8(a0)
 912:	6390                	ld	a2,0(a5)
 914:	02059813          	slli	a6,a1,0x20
 918:	01c85713          	srli	a4,a6,0x1c
 91c:	9736                	add	a4,a4,a3
 91e:	fae60de3          	beq	a2,a4,8d8 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 922:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp) {
 926:	4790                	lw	a2,8(a5)
 928:	02061593          	slli	a1,a2,0x20
 92c:	01c5d713          	srli	a4,a1,0x1c
 930:	973e                	add	a4,a4,a5
 932:	fae68ae3          	beq	a3,a4,8e6 <free+0x22>
        p->s.ptr = bp->s.ptr;
 936:	e394                	sd	a3,0(a5)
    } else
        p->s.ptr = bp;
    freep = p;
 938:	00000717          	auipc	a4,0x0
 93c:	66f73023          	sd	a5,1632(a4) # f98 <freep>
}
 940:	6422                	ld	s0,8(sp)
 942:	0141                	addi	sp,sp,16
 944:	8082                	ret

0000000000000946 <malloc>:
    hp->s.size = nu;
    free((void *)(hp + 1));
    return freep;
}

void *malloc(uint nbytes) {
 946:	7139                	addi	sp,sp,-64
 948:	fc06                	sd	ra,56(sp)
 94a:	f822                	sd	s0,48(sp)
 94c:	f426                	sd	s1,40(sp)
 94e:	ec4e                	sd	s3,24(sp)
 950:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 952:	02051493          	slli	s1,a0,0x20
 956:	9081                	srli	s1,s1,0x20
 958:	04bd                	addi	s1,s1,15
 95a:	8091                	srli	s1,s1,0x4
 95c:	0014899b          	addiw	s3,s1,1
 960:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0) {
 962:	00000517          	auipc	a0,0x0
 966:	63653503          	ld	a0,1590(a0) # f98 <freep>
 96a:	c915                	beqz	a0,99e <malloc+0x58>
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 96c:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits) {
 96e:	4798                	lw	a4,8(a5)
 970:	08977e63          	bgeu	a4,s1,a0c <malloc+0xc6>
 974:	f04a                	sd	s2,32(sp)
 976:	e852                	sd	s4,16(sp)
 978:	e456                	sd	s5,8(sp)
 97a:	e05a                	sd	s6,0(sp)
    if (nu < 4096)
 97c:	8a4e                	mv	s4,s3
 97e:	0009871b          	sext.w	a4,s3
 982:	6685                	lui	a3,0x1
 984:	00d77363          	bgeu	a4,a3,98a <malloc+0x44>
 988:	6a05                	lui	s4,0x1
 98a:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 98e:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 992:	00000917          	auipc	s2,0x0
 996:	60690913          	addi	s2,s2,1542 # f98 <freep>
    if (p == (char *)-1)
 99a:	5afd                	li	s5,-1
 99c:	a091                	j	9e0 <malloc+0x9a>
 99e:	f04a                	sd	s2,32(sp)
 9a0:	e852                	sd	s4,16(sp)
 9a2:	e456                	sd	s5,8(sp)
 9a4:	e05a                	sd	s6,0(sp)
        base.s.ptr = freep = prevp = &base;
 9a6:	00001797          	auipc	a5,0x1
 9aa:	9fa78793          	addi	a5,a5,-1542 # 13a0 <base>
 9ae:	00000717          	auipc	a4,0x0
 9b2:	5ef73523          	sd	a5,1514(a4) # f98 <freep>
 9b6:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 9b8:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits) {
 9bc:	b7c1                	j	97c <malloc+0x36>
                prevp->s.ptr = p->s.ptr;
 9be:	6398                	ld	a4,0(a5)
 9c0:	e118                	sd	a4,0(a0)
 9c2:	a08d                	j	a24 <malloc+0xde>
    hp->s.size = nu;
 9c4:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 9c8:	0541                	addi	a0,a0,16
 9ca:	00000097          	auipc	ra,0x0
 9ce:	efa080e7          	jalr	-262(ra) # 8c4 <free>
    return freep;
 9d2:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 9d6:	c13d                	beqz	a0,a3c <malloc+0xf6>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 9d8:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits) {
 9da:	4798                	lw	a4,8(a5)
 9dc:	02977463          	bgeu	a4,s1,a04 <malloc+0xbe>
        if (p == freep)
 9e0:	00093703          	ld	a4,0(s2)
 9e4:	853e                	mv	a0,a5
 9e6:	fef719e3          	bne	a4,a5,9d8 <malloc+0x92>
    p = sbrk(nu * sizeof(Header));
 9ea:	8552                	mv	a0,s4
 9ec:	00000097          	auipc	ra,0x0
 9f0:	bb2080e7          	jalr	-1102(ra) # 59e <sbrk>
    if (p == (char *)-1)
 9f4:	fd5518e3          	bne	a0,s5,9c4 <malloc+0x7e>
                return 0;
 9f8:	4501                	li	a0,0
 9fa:	7902                	ld	s2,32(sp)
 9fc:	6a42                	ld	s4,16(sp)
 9fe:	6aa2                	ld	s5,8(sp)
 a00:	6b02                	ld	s6,0(sp)
 a02:	a03d                	j	a30 <malloc+0xea>
 a04:	7902                	ld	s2,32(sp)
 a06:	6a42                	ld	s4,16(sp)
 a08:	6aa2                	ld	s5,8(sp)
 a0a:	6b02                	ld	s6,0(sp)
            if (p->s.size == nunits)
 a0c:	fae489e3          	beq	s1,a4,9be <malloc+0x78>
                p->s.size -= nunits;
 a10:	4137073b          	subw	a4,a4,s3
 a14:	c798                	sw	a4,8(a5)
                p += p->s.size;
 a16:	02071693          	slli	a3,a4,0x20
 a1a:	01c6d713          	srli	a4,a3,0x1c
 a1e:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 a20:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 a24:	00000717          	auipc	a4,0x0
 a28:	56a73a23          	sd	a0,1396(a4) # f98 <freep>
            return (void *)(p + 1);
 a2c:	01078513          	addi	a0,a5,16
    }
}
 a30:	70e2                	ld	ra,56(sp)
 a32:	7442                	ld	s0,48(sp)
 a34:	74a2                	ld	s1,40(sp)
 a36:	69e2                	ld	s3,24(sp)
 a38:	6121                	addi	sp,sp,64
 a3a:	8082                	ret
 a3c:	7902                	ld	s2,32(sp)
 a3e:	6a42                	ld	s4,16(sp)
 a40:	6aa2                	ld	s5,8(sp)
 a42:	6b02                	ld	s6,0(sp)
 a44:	b7f5                	j	a30 <malloc+0xea>
