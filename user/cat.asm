
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:
#include "kernel/stat.h"
#include "user/user.h"

char buf[512];

void cat(int fd) {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	89aa                	mv	s3,a0
    int n;

    while ((n = read(fd, buf, sizeof(buf))) > 0) {
  10:	00001917          	auipc	s2,0x1
  14:	d7890913          	addi	s2,s2,-648 # d88 <buf>
  18:	20000613          	li	a2,512
  1c:	85ca                	mv	a1,s2
  1e:	854e                	mv	a0,s3
  20:	00000097          	auipc	ra,0x0
  24:	386080e7          	jalr	902(ra) # 3a6 <read>
  28:	84aa                	mv	s1,a0
  2a:	02a05963          	blez	a0,5c <cat+0x5c>
        if (write(1, buf, n) != n) {
  2e:	8626                	mv	a2,s1
  30:	85ca                	mv	a1,s2
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	37a080e7          	jalr	890(ra) # 3ae <write>
  3c:	fc950ee3          	beq	a0,s1,18 <cat+0x18>
            fprintf(2, "cat: write error\n");
  40:	00001597          	auipc	a1,0x1
  44:	88058593          	addi	a1,a1,-1920 # 8c0 <malloc+0x102>
  48:	4509                	li	a0,2
  4a:	00000097          	auipc	ra,0x0
  4e:	68e080e7          	jalr	1678(ra) # 6d8 <fprintf>
            exit(1);
  52:	4505                	li	a0,1
  54:	00000097          	auipc	ra,0x0
  58:	33a080e7          	jalr	826(ra) # 38e <exit>
        }
    }
    if (n < 0) {
  5c:	00054963          	bltz	a0,6e <cat+0x6e>
        fprintf(2, "cat: read error\n");
        exit(1);
    }
}
  60:	70a2                	ld	ra,40(sp)
  62:	7402                	ld	s0,32(sp)
  64:	64e2                	ld	s1,24(sp)
  66:	6942                	ld	s2,16(sp)
  68:	69a2                	ld	s3,8(sp)
  6a:	6145                	addi	sp,sp,48
  6c:	8082                	ret
        fprintf(2, "cat: read error\n");
  6e:	00001597          	auipc	a1,0x1
  72:	86a58593          	addi	a1,a1,-1942 # 8d8 <malloc+0x11a>
  76:	4509                	li	a0,2
  78:	00000097          	auipc	ra,0x0
  7c:	660080e7          	jalr	1632(ra) # 6d8 <fprintf>
        exit(1);
  80:	4505                	li	a0,1
  82:	00000097          	auipc	ra,0x0
  86:	30c080e7          	jalr	780(ra) # 38e <exit>

000000000000008a <main>:

int main(int argc, char *argv[]) {
  8a:	7179                	addi	sp,sp,-48
  8c:	f406                	sd	ra,40(sp)
  8e:	f022                	sd	s0,32(sp)
  90:	1800                	addi	s0,sp,48
    int fd, i;

    if (argc <= 1) {
  92:	4785                	li	a5,1
  94:	04a7da63          	bge	a5,a0,e8 <main+0x5e>
  98:	ec26                	sd	s1,24(sp)
  9a:	e84a                	sd	s2,16(sp)
  9c:	e44e                	sd	s3,8(sp)
  9e:	00858913          	addi	s2,a1,8
  a2:	ffe5099b          	addiw	s3,a0,-2
  a6:	02099793          	slli	a5,s3,0x20
  aa:	01d7d993          	srli	s3,a5,0x1d
  ae:	05c1                	addi	a1,a1,16
  b0:	99ae                	add	s3,s3,a1
        cat(0);
        exit(0);
    }

    for (i = 1; i < argc; i++) {
        if ((fd = open(argv[i], 0)) < 0) {
  b2:	4581                	li	a1,0
  b4:	00093503          	ld	a0,0(s2)
  b8:	00000097          	auipc	ra,0x0
  bc:	316080e7          	jalr	790(ra) # 3ce <open>
  c0:	84aa                	mv	s1,a0
  c2:	04054063          	bltz	a0,102 <main+0x78>
            fprintf(2, "cat: cannot open %s\n", argv[i]);
            exit(1);
        }
        cat(fd);
  c6:	00000097          	auipc	ra,0x0
  ca:	f3a080e7          	jalr	-198(ra) # 0 <cat>
        close(fd);
  ce:	8526                	mv	a0,s1
  d0:	00000097          	auipc	ra,0x0
  d4:	2e6080e7          	jalr	742(ra) # 3b6 <close>
    for (i = 1; i < argc; i++) {
  d8:	0921                	addi	s2,s2,8
  da:	fd391ce3          	bne	s2,s3,b2 <main+0x28>
    }
    exit(0);
  de:	4501                	li	a0,0
  e0:	00000097          	auipc	ra,0x0
  e4:	2ae080e7          	jalr	686(ra) # 38e <exit>
  e8:	ec26                	sd	s1,24(sp)
  ea:	e84a                	sd	s2,16(sp)
  ec:	e44e                	sd	s3,8(sp)
        cat(0);
  ee:	4501                	li	a0,0
  f0:	00000097          	auipc	ra,0x0
  f4:	f10080e7          	jalr	-240(ra) # 0 <cat>
        exit(0);
  f8:	4501                	li	a0,0
  fa:	00000097          	auipc	ra,0x0
  fe:	294080e7          	jalr	660(ra) # 38e <exit>
            fprintf(2, "cat: cannot open %s\n", argv[i]);
 102:	00093603          	ld	a2,0(s2)
 106:	00000597          	auipc	a1,0x0
 10a:	7ea58593          	addi	a1,a1,2026 # 8f0 <malloc+0x132>
 10e:	4509                	li	a0,2
 110:	00000097          	auipc	ra,0x0
 114:	5c8080e7          	jalr	1480(ra) # 6d8 <fprintf>
            exit(1);
 118:	4505                	li	a0,1
 11a:	00000097          	auipc	ra,0x0
 11e:	274080e7          	jalr	628(ra) # 38e <exit>

0000000000000122 <strcpy>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "user/user.h"

char *strcpy(char *s, const char *t) {
 122:	1141                	addi	sp,sp,-16
 124:	e422                	sd	s0,8(sp)
 126:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 128:	87aa                	mv	a5,a0
 12a:	0585                	addi	a1,a1,1
 12c:	0785                	addi	a5,a5,1
 12e:	fff5c703          	lbu	a4,-1(a1)
 132:	fee78fa3          	sb	a4,-1(a5)
 136:	fb75                	bnez	a4,12a <strcpy+0x8>
        ;
    return os;
}
 138:	6422                	ld	s0,8(sp)
 13a:	0141                	addi	sp,sp,16
 13c:	8082                	ret

000000000000013e <strcmp>:

int strcmp(const char *p, const char *q) {
 13e:	1141                	addi	sp,sp,-16
 140:	e422                	sd	s0,8(sp)
 142:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 144:	00054783          	lbu	a5,0(a0)
 148:	cb91                	beqz	a5,15c <strcmp+0x1e>
 14a:	0005c703          	lbu	a4,0(a1)
 14e:	00f71763          	bne	a4,a5,15c <strcmp+0x1e>
        p++, q++;
 152:	0505                	addi	a0,a0,1
 154:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 156:	00054783          	lbu	a5,0(a0)
 15a:	fbe5                	bnez	a5,14a <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 15c:	0005c503          	lbu	a0,0(a1)
}
 160:	40a7853b          	subw	a0,a5,a0
 164:	6422                	ld	s0,8(sp)
 166:	0141                	addi	sp,sp,16
 168:	8082                	ret

000000000000016a <strlen>:

uint strlen(const char *s) {
 16a:	1141                	addi	sp,sp,-16
 16c:	e422                	sd	s0,8(sp)
 16e:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 170:	00054783          	lbu	a5,0(a0)
 174:	cf91                	beqz	a5,190 <strlen+0x26>
 176:	0505                	addi	a0,a0,1
 178:	87aa                	mv	a5,a0
 17a:	86be                	mv	a3,a5
 17c:	0785                	addi	a5,a5,1
 17e:	fff7c703          	lbu	a4,-1(a5)
 182:	ff65                	bnez	a4,17a <strlen+0x10>
 184:	40a6853b          	subw	a0,a3,a0
 188:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 18a:	6422                	ld	s0,8(sp)
 18c:	0141                	addi	sp,sp,16
 18e:	8082                	ret
    for (n = 0; s[n]; n++)
 190:	4501                	li	a0,0
 192:	bfe5                	j	18a <strlen+0x20>

0000000000000194 <memset>:

void *memset(void *dst, int c, uint n) {
 194:	1141                	addi	sp,sp,-16
 196:	e422                	sd	s0,8(sp)
 198:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++) {
 19a:	ca19                	beqz	a2,1b0 <memset+0x1c>
 19c:	87aa                	mv	a5,a0
 19e:	1602                	slli	a2,a2,0x20
 1a0:	9201                	srli	a2,a2,0x20
 1a2:	00a60733          	add	a4,a2,a0
        cdst[i] = c;
 1a6:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++) {
 1aa:	0785                	addi	a5,a5,1
 1ac:	fee79de3          	bne	a5,a4,1a6 <memset+0x12>
    }
    return dst;
}
 1b0:	6422                	ld	s0,8(sp)
 1b2:	0141                	addi	sp,sp,16
 1b4:	8082                	ret

00000000000001b6 <strchr>:

char *strchr(const char *s, char c) {
 1b6:	1141                	addi	sp,sp,-16
 1b8:	e422                	sd	s0,8(sp)
 1ba:	0800                	addi	s0,sp,16
    for (; *s; s++)
 1bc:	00054783          	lbu	a5,0(a0)
 1c0:	cb99                	beqz	a5,1d6 <strchr+0x20>
        if (*s == c)
 1c2:	00f58763          	beq	a1,a5,1d0 <strchr+0x1a>
    for (; *s; s++)
 1c6:	0505                	addi	a0,a0,1
 1c8:	00054783          	lbu	a5,0(a0)
 1cc:	fbfd                	bnez	a5,1c2 <strchr+0xc>
            return (char *)s;
    return 0;
 1ce:	4501                	li	a0,0
}
 1d0:	6422                	ld	s0,8(sp)
 1d2:	0141                	addi	sp,sp,16
 1d4:	8082                	ret
    return 0;
 1d6:	4501                	li	a0,0
 1d8:	bfe5                	j	1d0 <strchr+0x1a>

00000000000001da <gets>:

char *gets(char *buf, int max) {
 1da:	711d                	addi	sp,sp,-96
 1dc:	ec86                	sd	ra,88(sp)
 1de:	e8a2                	sd	s0,80(sp)
 1e0:	e4a6                	sd	s1,72(sp)
 1e2:	e0ca                	sd	s2,64(sp)
 1e4:	fc4e                	sd	s3,56(sp)
 1e6:	f852                	sd	s4,48(sp)
 1e8:	f456                	sd	s5,40(sp)
 1ea:	f05a                	sd	s6,32(sp)
 1ec:	ec5e                	sd	s7,24(sp)
 1ee:	1080                	addi	s0,sp,96
 1f0:	8baa                	mv	s7,a0
 1f2:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
 1f4:	892a                	mv	s2,a0
 1f6:	4481                	li	s1,0
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 1f8:	4aa9                	li	s5,10
 1fa:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;) {
 1fc:	89a6                	mv	s3,s1
 1fe:	2485                	addiw	s1,s1,1
 200:	0344d863          	bge	s1,s4,230 <gets+0x56>
        cc = read(0, &c, 1);
 204:	4605                	li	a2,1
 206:	faf40593          	addi	a1,s0,-81
 20a:	4501                	li	a0,0
 20c:	00000097          	auipc	ra,0x0
 210:	19a080e7          	jalr	410(ra) # 3a6 <read>
        if (cc < 1)
 214:	00a05e63          	blez	a0,230 <gets+0x56>
        buf[i++] = c;
 218:	faf44783          	lbu	a5,-81(s0)
 21c:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 220:	01578763          	beq	a5,s5,22e <gets+0x54>
 224:	0905                	addi	s2,s2,1
 226:	fd679be3          	bne	a5,s6,1fc <gets+0x22>
        buf[i++] = c;
 22a:	89a6                	mv	s3,s1
 22c:	a011                	j	230 <gets+0x56>
 22e:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 230:	99de                	add	s3,s3,s7
 232:	00098023          	sb	zero,0(s3)
    return buf;
}
 236:	855e                	mv	a0,s7
 238:	60e6                	ld	ra,88(sp)
 23a:	6446                	ld	s0,80(sp)
 23c:	64a6                	ld	s1,72(sp)
 23e:	6906                	ld	s2,64(sp)
 240:	79e2                	ld	s3,56(sp)
 242:	7a42                	ld	s4,48(sp)
 244:	7aa2                	ld	s5,40(sp)
 246:	7b02                	ld	s6,32(sp)
 248:	6be2                	ld	s7,24(sp)
 24a:	6125                	addi	sp,sp,96
 24c:	8082                	ret

000000000000024e <stat>:

int stat(const char *n, struct stat *st) {
 24e:	1101                	addi	sp,sp,-32
 250:	ec06                	sd	ra,24(sp)
 252:	e822                	sd	s0,16(sp)
 254:	e04a                	sd	s2,0(sp)
 256:	1000                	addi	s0,sp,32
 258:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 25a:	4581                	li	a1,0
 25c:	00000097          	auipc	ra,0x0
 260:	172080e7          	jalr	370(ra) # 3ce <open>
    if (fd < 0)
 264:	02054663          	bltz	a0,290 <stat+0x42>
 268:	e426                	sd	s1,8(sp)
 26a:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 26c:	85ca                	mv	a1,s2
 26e:	00000097          	auipc	ra,0x0
 272:	178080e7          	jalr	376(ra) # 3e6 <fstat>
 276:	892a                	mv	s2,a0
    close(fd);
 278:	8526                	mv	a0,s1
 27a:	00000097          	auipc	ra,0x0
 27e:	13c080e7          	jalr	316(ra) # 3b6 <close>
    return r;
 282:	64a2                	ld	s1,8(sp)
}
 284:	854a                	mv	a0,s2
 286:	60e2                	ld	ra,24(sp)
 288:	6442                	ld	s0,16(sp)
 28a:	6902                	ld	s2,0(sp)
 28c:	6105                	addi	sp,sp,32
 28e:	8082                	ret
        return -1;
 290:	597d                	li	s2,-1
 292:	bfcd                	j	284 <stat+0x36>

0000000000000294 <atoi>:

int atoi(const char *s) {
 294:	1141                	addi	sp,sp,-16
 296:	e422                	sd	s0,8(sp)
 298:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 29a:	00054683          	lbu	a3,0(a0)
 29e:	fd06879b          	addiw	a5,a3,-48
 2a2:	0ff7f793          	zext.b	a5,a5
 2a6:	4625                	li	a2,9
 2a8:	02f66863          	bltu	a2,a5,2d8 <atoi+0x44>
 2ac:	872a                	mv	a4,a0
    n = 0;
 2ae:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 2b0:	0705                	addi	a4,a4,1
 2b2:	0025179b          	slliw	a5,a0,0x2
 2b6:	9fa9                	addw	a5,a5,a0
 2b8:	0017979b          	slliw	a5,a5,0x1
 2bc:	9fb5                	addw	a5,a5,a3
 2be:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 2c2:	00074683          	lbu	a3,0(a4)
 2c6:	fd06879b          	addiw	a5,a3,-48
 2ca:	0ff7f793          	zext.b	a5,a5
 2ce:	fef671e3          	bgeu	a2,a5,2b0 <atoi+0x1c>
    return n;
}
 2d2:	6422                	ld	s0,8(sp)
 2d4:	0141                	addi	sp,sp,16
 2d6:	8082                	ret
    n = 0;
 2d8:	4501                	li	a0,0
 2da:	bfe5                	j	2d2 <atoi+0x3e>

00000000000002dc <memmove>:

void *memmove(void *vdst, const void *vsrc, int n) {
 2dc:	1141                	addi	sp,sp,-16
 2de:	e422                	sd	s0,8(sp)
 2e0:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
 2e2:	02b57463          	bgeu	a0,a1,30a <memmove+0x2e>
        while (n-- > 0)
 2e6:	00c05f63          	blez	a2,304 <memmove+0x28>
 2ea:	1602                	slli	a2,a2,0x20
 2ec:	9201                	srli	a2,a2,0x20
 2ee:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 2f2:	872a                	mv	a4,a0
            *dst++ = *src++;
 2f4:	0585                	addi	a1,a1,1
 2f6:	0705                	addi	a4,a4,1
 2f8:	fff5c683          	lbu	a3,-1(a1)
 2fc:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 300:	fef71ae3          	bne	a4,a5,2f4 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 304:	6422                	ld	s0,8(sp)
 306:	0141                	addi	sp,sp,16
 308:	8082                	ret
        dst += n;
 30a:	00c50733          	add	a4,a0,a2
        src += n;
 30e:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 310:	fec05ae3          	blez	a2,304 <memmove+0x28>
 314:	fff6079b          	addiw	a5,a2,-1
 318:	1782                	slli	a5,a5,0x20
 31a:	9381                	srli	a5,a5,0x20
 31c:	fff7c793          	not	a5,a5
 320:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 322:	15fd                	addi	a1,a1,-1
 324:	177d                	addi	a4,a4,-1
 326:	0005c683          	lbu	a3,0(a1)
 32a:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 32e:	fee79ae3          	bne	a5,a4,322 <memmove+0x46>
 332:	bfc9                	j	304 <memmove+0x28>

0000000000000334 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n) {
 334:	1141                	addi	sp,sp,-16
 336:	e422                	sd	s0,8(sp)
 338:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0) {
 33a:	ca05                	beqz	a2,36a <memcmp+0x36>
 33c:	fff6069b          	addiw	a3,a2,-1
 340:	1682                	slli	a3,a3,0x20
 342:	9281                	srli	a3,a3,0x20
 344:	0685                	addi	a3,a3,1
 346:	96aa                	add	a3,a3,a0
        if (*p1 != *p2) {
 348:	00054783          	lbu	a5,0(a0)
 34c:	0005c703          	lbu	a4,0(a1)
 350:	00e79863          	bne	a5,a4,360 <memcmp+0x2c>
            return *p1 - *p2;
        }
        p1++;
 354:	0505                	addi	a0,a0,1
        p2++;
 356:	0585                	addi	a1,a1,1
    while (n-- > 0) {
 358:	fed518e3          	bne	a0,a3,348 <memcmp+0x14>
    }
    return 0;
 35c:	4501                	li	a0,0
 35e:	a019                	j	364 <memcmp+0x30>
            return *p1 - *p2;
 360:	40e7853b          	subw	a0,a5,a4
}
 364:	6422                	ld	s0,8(sp)
 366:	0141                	addi	sp,sp,16
 368:	8082                	ret
    return 0;
 36a:	4501                	li	a0,0
 36c:	bfe5                	j	364 <memcmp+0x30>

000000000000036e <memcpy>:

void *memcpy(void *dst, const void *src, uint n) {
 36e:	1141                	addi	sp,sp,-16
 370:	e406                	sd	ra,8(sp)
 372:	e022                	sd	s0,0(sp)
 374:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 376:	00000097          	auipc	ra,0x0
 37a:	f66080e7          	jalr	-154(ra) # 2dc <memmove>
}
 37e:	60a2                	ld	ra,8(sp)
 380:	6402                	ld	s0,0(sp)
 382:	0141                	addi	sp,sp,16
 384:	8082                	ret

0000000000000386 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 386:	4885                	li	a7,1
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <exit>:
.global exit
exit:
 li a7, SYS_exit
 38e:	4889                	li	a7,2
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <wait>:
.global wait
wait:
 li a7, SYS_wait
 396:	488d                	li	a7,3
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 39e:	4891                	li	a7,4
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <read>:
.global read
read:
 li a7, SYS_read
 3a6:	4895                	li	a7,5
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <write>:
.global write
write:
 li a7, SYS_write
 3ae:	48c1                	li	a7,16
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <close>:
.global close
close:
 li a7, SYS_close
 3b6:	48d5                	li	a7,21
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <kill>:
.global kill
kill:
 li a7, SYS_kill
 3be:	4899                	li	a7,6
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3c6:	489d                	li	a7,7
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <open>:
.global open
open:
 li a7, SYS_open
 3ce:	48bd                	li	a7,15
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3d6:	48c5                	li	a7,17
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3de:	48c9                	li	a7,18
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3e6:	48a1                	li	a7,8
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <link>:
.global link
link:
 li a7, SYS_link
 3ee:	48cd                	li	a7,19
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3f6:	48d1                	li	a7,20
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3fe:	48a5                	li	a7,9
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <dup>:
.global dup
dup:
 li a7, SYS_dup
 406:	48a9                	li	a7,10
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 40e:	48ad                	li	a7,11
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 416:	48b1                	li	a7,12
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 41e:	48b5                	li	a7,13
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 426:	48b9                	li	a7,14
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <trace>:
.global trace
trace:
 li a7, SYS_trace
 42e:	48d9                	li	a7,22
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 436:	48dd                	li	a7,23
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <putc>:

#include <stdarg.h>

static char digits[] = "0123456789ABCDEF";

static void putc(int fd, char c) { write(fd, &c, 1); }
 43e:	1101                	addi	sp,sp,-32
 440:	ec06                	sd	ra,24(sp)
 442:	e822                	sd	s0,16(sp)
 444:	1000                	addi	s0,sp,32
 446:	feb407a3          	sb	a1,-17(s0)
 44a:	4605                	li	a2,1
 44c:	fef40593          	addi	a1,s0,-17
 450:	00000097          	auipc	ra,0x0
 454:	f5e080e7          	jalr	-162(ra) # 3ae <write>
 458:	60e2                	ld	ra,24(sp)
 45a:	6442                	ld	s0,16(sp)
 45c:	6105                	addi	sp,sp,32
 45e:	8082                	ret

0000000000000460 <printint>:

static void printint(int fd, int xx, int base, int sgn) {
 460:	7139                	addi	sp,sp,-64
 462:	fc06                	sd	ra,56(sp)
 464:	f822                	sd	s0,48(sp)
 466:	f426                	sd	s1,40(sp)
 468:	0080                	addi	s0,sp,64
 46a:	84aa                	mv	s1,a0
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if (sgn && xx < 0) {
 46c:	c299                	beqz	a3,472 <printint+0x12>
 46e:	0805cb63          	bltz	a1,504 <printint+0xa4>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
 472:	2581                	sext.w	a1,a1
    neg = 0;
 474:	4881                	li	a7,0
 476:	fc040693          	addi	a3,s0,-64
    }

    i = 0;
 47a:	4701                	li	a4,0
    do {
        buf[i++] = digits[x % base];
 47c:	2601                	sext.w	a2,a2
 47e:	00000517          	auipc	a0,0x0
 482:	4ea50513          	addi	a0,a0,1258 # 968 <digits>
 486:	883a                	mv	a6,a4
 488:	2705                	addiw	a4,a4,1
 48a:	02c5f7bb          	remuw	a5,a1,a2
 48e:	1782                	slli	a5,a5,0x20
 490:	9381                	srli	a5,a5,0x20
 492:	97aa                	add	a5,a5,a0
 494:	0007c783          	lbu	a5,0(a5)
 498:	00f68023          	sb	a5,0(a3)
    } while ((x /= base) != 0);
 49c:	0005879b          	sext.w	a5,a1
 4a0:	02c5d5bb          	divuw	a1,a1,a2
 4a4:	0685                	addi	a3,a3,1
 4a6:	fec7f0e3          	bgeu	a5,a2,486 <printint+0x26>
    if (neg)
 4aa:	00088c63          	beqz	a7,4c2 <printint+0x62>
        buf[i++] = '-';
 4ae:	fd070793          	addi	a5,a4,-48
 4b2:	00878733          	add	a4,a5,s0
 4b6:	02d00793          	li	a5,45
 4ba:	fef70823          	sb	a5,-16(a4)
 4be:	0028071b          	addiw	a4,a6,2

    while (--i >= 0)
 4c2:	02e05c63          	blez	a4,4fa <printint+0x9a>
 4c6:	f04a                	sd	s2,32(sp)
 4c8:	ec4e                	sd	s3,24(sp)
 4ca:	fc040793          	addi	a5,s0,-64
 4ce:	00e78933          	add	s2,a5,a4
 4d2:	fff78993          	addi	s3,a5,-1
 4d6:	99ba                	add	s3,s3,a4
 4d8:	377d                	addiw	a4,a4,-1
 4da:	1702                	slli	a4,a4,0x20
 4dc:	9301                	srli	a4,a4,0x20
 4de:	40e989b3          	sub	s3,s3,a4
        putc(fd, buf[i]);
 4e2:	fff94583          	lbu	a1,-1(s2)
 4e6:	8526                	mv	a0,s1
 4e8:	00000097          	auipc	ra,0x0
 4ec:	f56080e7          	jalr	-170(ra) # 43e <putc>
    while (--i >= 0)
 4f0:	197d                	addi	s2,s2,-1
 4f2:	ff3918e3          	bne	s2,s3,4e2 <printint+0x82>
 4f6:	7902                	ld	s2,32(sp)
 4f8:	69e2                	ld	s3,24(sp)
}
 4fa:	70e2                	ld	ra,56(sp)
 4fc:	7442                	ld	s0,48(sp)
 4fe:	74a2                	ld	s1,40(sp)
 500:	6121                	addi	sp,sp,64
 502:	8082                	ret
        x = -xx;
 504:	40b005bb          	negw	a1,a1
        neg = 1;
 508:	4885                	li	a7,1
        x = -xx;
 50a:	b7b5                	j	476 <printint+0x16>

000000000000050c <vprintf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void vprintf(int fd, const char *fmt, va_list ap) {
 50c:	715d                	addi	sp,sp,-80
 50e:	e486                	sd	ra,72(sp)
 510:	e0a2                	sd	s0,64(sp)
 512:	f84a                	sd	s2,48(sp)
 514:	0880                	addi	s0,sp,80
    char *s;
    int c, i, state;

    state = 0;
    for (i = 0; fmt[i]; i++) {
 516:	0005c903          	lbu	s2,0(a1)
 51a:	1a090a63          	beqz	s2,6ce <vprintf+0x1c2>
 51e:	fc26                	sd	s1,56(sp)
 520:	f44e                	sd	s3,40(sp)
 522:	f052                	sd	s4,32(sp)
 524:	ec56                	sd	s5,24(sp)
 526:	e85a                	sd	s6,16(sp)
 528:	e45e                	sd	s7,8(sp)
 52a:	8aaa                	mv	s5,a0
 52c:	8bb2                	mv	s7,a2
 52e:	00158493          	addi	s1,a1,1
    state = 0;
 532:	4981                	li	s3,0
            if (c == '%') {
                state = '%';
            } else {
                putc(fd, c);
            }
        } else if (state == '%') {
 534:	02500a13          	li	s4,37
 538:	4b55                	li	s6,21
 53a:	a839                	j	558 <vprintf+0x4c>
                putc(fd, c);
 53c:	85ca                	mv	a1,s2
 53e:	8556                	mv	a0,s5
 540:	00000097          	auipc	ra,0x0
 544:	efe080e7          	jalr	-258(ra) # 43e <putc>
 548:	a019                	j	54e <vprintf+0x42>
        } else if (state == '%') {
 54a:	01498d63          	beq	s3,s4,564 <vprintf+0x58>
    for (i = 0; fmt[i]; i++) {
 54e:	0485                	addi	s1,s1,1
 550:	fff4c903          	lbu	s2,-1(s1)
 554:	16090763          	beqz	s2,6c2 <vprintf+0x1b6>
        if (state == 0) {
 558:	fe0999e3          	bnez	s3,54a <vprintf+0x3e>
            if (c == '%') {
 55c:	ff4910e3          	bne	s2,s4,53c <vprintf+0x30>
                state = '%';
 560:	89d2                	mv	s3,s4
 562:	b7f5                	j	54e <vprintf+0x42>
            if (c == 'd') {
 564:	13490463          	beq	s2,s4,68c <vprintf+0x180>
 568:	f9d9079b          	addiw	a5,s2,-99
 56c:	0ff7f793          	zext.b	a5,a5
 570:	12fb6763          	bltu	s6,a5,69e <vprintf+0x192>
 574:	f9d9079b          	addiw	a5,s2,-99
 578:	0ff7f713          	zext.b	a4,a5
 57c:	12eb6163          	bltu	s6,a4,69e <vprintf+0x192>
 580:	00271793          	slli	a5,a4,0x2
 584:	00000717          	auipc	a4,0x0
 588:	38c70713          	addi	a4,a4,908 # 910 <malloc+0x152>
 58c:	97ba                	add	a5,a5,a4
 58e:	439c                	lw	a5,0(a5)
 590:	97ba                	add	a5,a5,a4
 592:	8782                	jr	a5
                printint(fd, va_arg(ap, int), 10, 1);
 594:	008b8913          	addi	s2,s7,8
 598:	4685                	li	a3,1
 59a:	4629                	li	a2,10
 59c:	000ba583          	lw	a1,0(s7)
 5a0:	8556                	mv	a0,s5
 5a2:	00000097          	auipc	ra,0x0
 5a6:	ebe080e7          	jalr	-322(ra) # 460 <printint>
 5aa:	8bca                	mv	s7,s2
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
                putc(fd, c);
            }
            state = 0;
 5ac:	4981                	li	s3,0
 5ae:	b745                	j	54e <vprintf+0x42>
                printint(fd, va_arg(ap, uint64), 10, 0);
 5b0:	008b8913          	addi	s2,s7,8
 5b4:	4681                	li	a3,0
 5b6:	4629                	li	a2,10
 5b8:	000ba583          	lw	a1,0(s7)
 5bc:	8556                	mv	a0,s5
 5be:	00000097          	auipc	ra,0x0
 5c2:	ea2080e7          	jalr	-350(ra) # 460 <printint>
 5c6:	8bca                	mv	s7,s2
            state = 0;
 5c8:	4981                	li	s3,0
 5ca:	b751                	j	54e <vprintf+0x42>
                printint(fd, va_arg(ap, int), 16, 0);
 5cc:	008b8913          	addi	s2,s7,8
 5d0:	4681                	li	a3,0
 5d2:	4641                	li	a2,16
 5d4:	000ba583          	lw	a1,0(s7)
 5d8:	8556                	mv	a0,s5
 5da:	00000097          	auipc	ra,0x0
 5de:	e86080e7          	jalr	-378(ra) # 460 <printint>
 5e2:	8bca                	mv	s7,s2
            state = 0;
 5e4:	4981                	li	s3,0
 5e6:	b7a5                	j	54e <vprintf+0x42>
 5e8:	e062                	sd	s8,0(sp)
                printptr(fd, va_arg(ap, uint64));
 5ea:	008b8c13          	addi	s8,s7,8
 5ee:	000bb983          	ld	s3,0(s7)
    putc(fd, '0');
 5f2:	03000593          	li	a1,48
 5f6:	8556                	mv	a0,s5
 5f8:	00000097          	auipc	ra,0x0
 5fc:	e46080e7          	jalr	-442(ra) # 43e <putc>
    putc(fd, 'x');
 600:	07800593          	li	a1,120
 604:	8556                	mv	a0,s5
 606:	00000097          	auipc	ra,0x0
 60a:	e38080e7          	jalr	-456(ra) # 43e <putc>
 60e:	4941                	li	s2,16
        putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 610:	00000b97          	auipc	s7,0x0
 614:	358b8b93          	addi	s7,s7,856 # 968 <digits>
 618:	03c9d793          	srli	a5,s3,0x3c
 61c:	97de                	add	a5,a5,s7
 61e:	0007c583          	lbu	a1,0(a5)
 622:	8556                	mv	a0,s5
 624:	00000097          	auipc	ra,0x0
 628:	e1a080e7          	jalr	-486(ra) # 43e <putc>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 62c:	0992                	slli	s3,s3,0x4
 62e:	397d                	addiw	s2,s2,-1
 630:	fe0914e3          	bnez	s2,618 <vprintf+0x10c>
                printptr(fd, va_arg(ap, uint64));
 634:	8be2                	mv	s7,s8
            state = 0;
 636:	4981                	li	s3,0
 638:	6c02                	ld	s8,0(sp)
 63a:	bf11                	j	54e <vprintf+0x42>
                s = va_arg(ap, char *);
 63c:	008b8993          	addi	s3,s7,8
 640:	000bb903          	ld	s2,0(s7)
                if (s == 0)
 644:	02090163          	beqz	s2,666 <vprintf+0x15a>
                while (*s != 0) {
 648:	00094583          	lbu	a1,0(s2)
 64c:	c9a5                	beqz	a1,6bc <vprintf+0x1b0>
                    putc(fd, *s);
 64e:	8556                	mv	a0,s5
 650:	00000097          	auipc	ra,0x0
 654:	dee080e7          	jalr	-530(ra) # 43e <putc>
                    s++;
 658:	0905                	addi	s2,s2,1
                while (*s != 0) {
 65a:	00094583          	lbu	a1,0(s2)
 65e:	f9e5                	bnez	a1,64e <vprintf+0x142>
                s = va_arg(ap, char *);
 660:	8bce                	mv	s7,s3
            state = 0;
 662:	4981                	li	s3,0
 664:	b5ed                	j	54e <vprintf+0x42>
                    s = "(null)";
 666:	00000917          	auipc	s2,0x0
 66a:	2a290913          	addi	s2,s2,674 # 908 <malloc+0x14a>
                while (*s != 0) {
 66e:	02800593          	li	a1,40
 672:	bff1                	j	64e <vprintf+0x142>
                putc(fd, va_arg(ap, uint));
 674:	008b8913          	addi	s2,s7,8
 678:	000bc583          	lbu	a1,0(s7)
 67c:	8556                	mv	a0,s5
 67e:	00000097          	auipc	ra,0x0
 682:	dc0080e7          	jalr	-576(ra) # 43e <putc>
 686:	8bca                	mv	s7,s2
            state = 0;
 688:	4981                	li	s3,0
 68a:	b5d1                	j	54e <vprintf+0x42>
                putc(fd, c);
 68c:	02500593          	li	a1,37
 690:	8556                	mv	a0,s5
 692:	00000097          	auipc	ra,0x0
 696:	dac080e7          	jalr	-596(ra) # 43e <putc>
            state = 0;
 69a:	4981                	li	s3,0
 69c:	bd4d                	j	54e <vprintf+0x42>
                putc(fd, '%');
 69e:	02500593          	li	a1,37
 6a2:	8556                	mv	a0,s5
 6a4:	00000097          	auipc	ra,0x0
 6a8:	d9a080e7          	jalr	-614(ra) # 43e <putc>
                putc(fd, c);
 6ac:	85ca                	mv	a1,s2
 6ae:	8556                	mv	a0,s5
 6b0:	00000097          	auipc	ra,0x0
 6b4:	d8e080e7          	jalr	-626(ra) # 43e <putc>
            state = 0;
 6b8:	4981                	li	s3,0
 6ba:	bd51                	j	54e <vprintf+0x42>
                s = va_arg(ap, char *);
 6bc:	8bce                	mv	s7,s3
            state = 0;
 6be:	4981                	li	s3,0
 6c0:	b579                	j	54e <vprintf+0x42>
 6c2:	74e2                	ld	s1,56(sp)
 6c4:	79a2                	ld	s3,40(sp)
 6c6:	7a02                	ld	s4,32(sp)
 6c8:	6ae2                	ld	s5,24(sp)
 6ca:	6b42                	ld	s6,16(sp)
 6cc:	6ba2                	ld	s7,8(sp)
        }
    }
}
 6ce:	60a6                	ld	ra,72(sp)
 6d0:	6406                	ld	s0,64(sp)
 6d2:	7942                	ld	s2,48(sp)
 6d4:	6161                	addi	sp,sp,80
 6d6:	8082                	ret

00000000000006d8 <fprintf>:

void fprintf(int fd, const char *fmt, ...) {
 6d8:	715d                	addi	sp,sp,-80
 6da:	ec06                	sd	ra,24(sp)
 6dc:	e822                	sd	s0,16(sp)
 6de:	1000                	addi	s0,sp,32
 6e0:	e010                	sd	a2,0(s0)
 6e2:	e414                	sd	a3,8(s0)
 6e4:	e818                	sd	a4,16(s0)
 6e6:	ec1c                	sd	a5,24(s0)
 6e8:	03043023          	sd	a6,32(s0)
 6ec:	03143423          	sd	a7,40(s0)
    va_list ap;

    va_start(ap, fmt);
 6f0:	fe843423          	sd	s0,-24(s0)
    vprintf(fd, fmt, ap);
 6f4:	8622                	mv	a2,s0
 6f6:	00000097          	auipc	ra,0x0
 6fa:	e16080e7          	jalr	-490(ra) # 50c <vprintf>
}
 6fe:	60e2                	ld	ra,24(sp)
 700:	6442                	ld	s0,16(sp)
 702:	6161                	addi	sp,sp,80
 704:	8082                	ret

0000000000000706 <printf>:

void printf(const char *fmt, ...) {
 706:	711d                	addi	sp,sp,-96
 708:	ec06                	sd	ra,24(sp)
 70a:	e822                	sd	s0,16(sp)
 70c:	1000                	addi	s0,sp,32
 70e:	e40c                	sd	a1,8(s0)
 710:	e810                	sd	a2,16(s0)
 712:	ec14                	sd	a3,24(s0)
 714:	f018                	sd	a4,32(s0)
 716:	f41c                	sd	a5,40(s0)
 718:	03043823          	sd	a6,48(s0)
 71c:	03143c23          	sd	a7,56(s0)
    va_list ap;

    va_start(ap, fmt);
 720:	00840613          	addi	a2,s0,8
 724:	fec43423          	sd	a2,-24(s0)
    vprintf(1, fmt, ap);
 728:	85aa                	mv	a1,a0
 72a:	4505                	li	a0,1
 72c:	00000097          	auipc	ra,0x0
 730:	de0080e7          	jalr	-544(ra) # 50c <vprintf>
}
 734:	60e2                	ld	ra,24(sp)
 736:	6442                	ld	s0,16(sp)
 738:	6125                	addi	sp,sp,96
 73a:	8082                	ret

000000000000073c <free>:
typedef union header Header;

static Header base;
static Header *freep;

void free(void *ap) {
 73c:	1141                	addi	sp,sp,-16
 73e:	e422                	sd	s0,8(sp)
 740:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 742:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 746:	00000797          	auipc	a5,0x0
 74a:	63a7b783          	ld	a5,1594(a5) # d80 <freep>
 74e:	a02d                	j	778 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr) {
        bp->s.size += p->s.ptr->s.size;
 750:	4618                	lw	a4,8(a2)
 752:	9f2d                	addw	a4,a4,a1
 754:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 758:	6398                	ld	a4,0(a5)
 75a:	6310                	ld	a2,0(a4)
 75c:	a83d                	j	79a <free+0x5e>
    } else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp) {
        p->s.size += bp->s.size;
 75e:	ff852703          	lw	a4,-8(a0)
 762:	9f31                	addw	a4,a4,a2
 764:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 766:	ff053683          	ld	a3,-16(a0)
 76a:	a091                	j	7ae <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 76c:	6398                	ld	a4,0(a5)
 76e:	00e7e463          	bltu	a5,a4,776 <free+0x3a>
 772:	00e6ea63          	bltu	a3,a4,786 <free+0x4a>
void free(void *ap) {
 776:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 778:	fed7fae3          	bgeu	a5,a3,76c <free+0x30>
 77c:	6398                	ld	a4,0(a5)
 77e:	00e6e463          	bltu	a3,a4,786 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 782:	fee7eae3          	bltu	a5,a4,776 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr) {
 786:	ff852583          	lw	a1,-8(a0)
 78a:	6390                	ld	a2,0(a5)
 78c:	02059813          	slli	a6,a1,0x20
 790:	01c85713          	srli	a4,a6,0x1c
 794:	9736                	add	a4,a4,a3
 796:	fae60de3          	beq	a2,a4,750 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 79a:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp) {
 79e:	4790                	lw	a2,8(a5)
 7a0:	02061593          	slli	a1,a2,0x20
 7a4:	01c5d713          	srli	a4,a1,0x1c
 7a8:	973e                	add	a4,a4,a5
 7aa:	fae68ae3          	beq	a3,a4,75e <free+0x22>
        p->s.ptr = bp->s.ptr;
 7ae:	e394                	sd	a3,0(a5)
    } else
        p->s.ptr = bp;
    freep = p;
 7b0:	00000717          	auipc	a4,0x0
 7b4:	5cf73823          	sd	a5,1488(a4) # d80 <freep>
}
 7b8:	6422                	ld	s0,8(sp)
 7ba:	0141                	addi	sp,sp,16
 7bc:	8082                	ret

00000000000007be <malloc>:
    hp->s.size = nu;
    free((void *)(hp + 1));
    return freep;
}

void *malloc(uint nbytes) {
 7be:	7139                	addi	sp,sp,-64
 7c0:	fc06                	sd	ra,56(sp)
 7c2:	f822                	sd	s0,48(sp)
 7c4:	f426                	sd	s1,40(sp)
 7c6:	ec4e                	sd	s3,24(sp)
 7c8:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 7ca:	02051493          	slli	s1,a0,0x20
 7ce:	9081                	srli	s1,s1,0x20
 7d0:	04bd                	addi	s1,s1,15
 7d2:	8091                	srli	s1,s1,0x4
 7d4:	0014899b          	addiw	s3,s1,1
 7d8:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0) {
 7da:	00000517          	auipc	a0,0x0
 7de:	5a653503          	ld	a0,1446(a0) # d80 <freep>
 7e2:	c915                	beqz	a0,816 <malloc+0x58>
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 7e4:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits) {
 7e6:	4798                	lw	a4,8(a5)
 7e8:	08977e63          	bgeu	a4,s1,884 <malloc+0xc6>
 7ec:	f04a                	sd	s2,32(sp)
 7ee:	e852                	sd	s4,16(sp)
 7f0:	e456                	sd	s5,8(sp)
 7f2:	e05a                	sd	s6,0(sp)
    if (nu < 4096)
 7f4:	8a4e                	mv	s4,s3
 7f6:	0009871b          	sext.w	a4,s3
 7fa:	6685                	lui	a3,0x1
 7fc:	00d77363          	bgeu	a4,a3,802 <malloc+0x44>
 800:	6a05                	lui	s4,0x1
 802:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 806:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 80a:	00000917          	auipc	s2,0x0
 80e:	57690913          	addi	s2,s2,1398 # d80 <freep>
    if (p == (char *)-1)
 812:	5afd                	li	s5,-1
 814:	a091                	j	858 <malloc+0x9a>
 816:	f04a                	sd	s2,32(sp)
 818:	e852                	sd	s4,16(sp)
 81a:	e456                	sd	s5,8(sp)
 81c:	e05a                	sd	s6,0(sp)
        base.s.ptr = freep = prevp = &base;
 81e:	00000797          	auipc	a5,0x0
 822:	76a78793          	addi	a5,a5,1898 # f88 <base>
 826:	00000717          	auipc	a4,0x0
 82a:	54f73d23          	sd	a5,1370(a4) # d80 <freep>
 82e:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 830:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits) {
 834:	b7c1                	j	7f4 <malloc+0x36>
                prevp->s.ptr = p->s.ptr;
 836:	6398                	ld	a4,0(a5)
 838:	e118                	sd	a4,0(a0)
 83a:	a08d                	j	89c <malloc+0xde>
    hp->s.size = nu;
 83c:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 840:	0541                	addi	a0,a0,16
 842:	00000097          	auipc	ra,0x0
 846:	efa080e7          	jalr	-262(ra) # 73c <free>
    return freep;
 84a:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 84e:	c13d                	beqz	a0,8b4 <malloc+0xf6>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 850:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits) {
 852:	4798                	lw	a4,8(a5)
 854:	02977463          	bgeu	a4,s1,87c <malloc+0xbe>
        if (p == freep)
 858:	00093703          	ld	a4,0(s2)
 85c:	853e                	mv	a0,a5
 85e:	fef719e3          	bne	a4,a5,850 <malloc+0x92>
    p = sbrk(nu * sizeof(Header));
 862:	8552                	mv	a0,s4
 864:	00000097          	auipc	ra,0x0
 868:	bb2080e7          	jalr	-1102(ra) # 416 <sbrk>
    if (p == (char *)-1)
 86c:	fd5518e3          	bne	a0,s5,83c <malloc+0x7e>
                return 0;
 870:	4501                	li	a0,0
 872:	7902                	ld	s2,32(sp)
 874:	6a42                	ld	s4,16(sp)
 876:	6aa2                	ld	s5,8(sp)
 878:	6b02                	ld	s6,0(sp)
 87a:	a03d                	j	8a8 <malloc+0xea>
 87c:	7902                	ld	s2,32(sp)
 87e:	6a42                	ld	s4,16(sp)
 880:	6aa2                	ld	s5,8(sp)
 882:	6b02                	ld	s6,0(sp)
            if (p->s.size == nunits)
 884:	fae489e3          	beq	s1,a4,836 <malloc+0x78>
                p->s.size -= nunits;
 888:	4137073b          	subw	a4,a4,s3
 88c:	c798                	sw	a4,8(a5)
                p += p->s.size;
 88e:	02071693          	slli	a3,a4,0x20
 892:	01c6d713          	srli	a4,a3,0x1c
 896:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 898:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 89c:	00000717          	auipc	a4,0x0
 8a0:	4ea73223          	sd	a0,1252(a4) # d80 <freep>
            return (void *)(p + 1);
 8a4:	01078513          	addi	a0,a5,16
    }
}
 8a8:	70e2                	ld	ra,56(sp)
 8aa:	7442                	ld	s0,48(sp)
 8ac:	74a2                	ld	s1,40(sp)
 8ae:	69e2                	ld	s3,24(sp)
 8b0:	6121                	addi	sp,sp,64
 8b2:	8082                	ret
 8b4:	7902                	ld	s2,32(sp)
 8b6:	6a42                	ld	s4,16(sp)
 8b8:	6aa2                	ld	s5,8(sp)
 8ba:	6b02                	ld	s6,0(sp)
 8bc:	b7f5                	j	8a8 <malloc+0xea>
