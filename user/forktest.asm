
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:
#include "kernel/stat.h"
#include "user/user.h"

#define N 1000

void print(const char *s) { write(1, s, strlen(s)); }
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0
   c:	00000097          	auipc	ra,0x0
  10:	152080e7          	jalr	338(ra) # 15e <strlen>
  14:	0005061b          	sext.w	a2,a0
  18:	85a6                	mv	a1,s1
  1a:	4505                	li	a0,1
  1c:	00000097          	auipc	ra,0x0
  20:	386080e7          	jalr	902(ra) # 3a2 <write>
  24:	60e2                	ld	ra,24(sp)
  26:	6442                	ld	s0,16(sp)
  28:	64a2                	ld	s1,8(sp)
  2a:	6105                	addi	sp,sp,32
  2c:	8082                	ret

000000000000002e <forktest>:

void forktest(void) {
  2e:	1101                	addi	sp,sp,-32
  30:	ec06                	sd	ra,24(sp)
  32:	e822                	sd	s0,16(sp)
  34:	e426                	sd	s1,8(sp)
  36:	e04a                	sd	s2,0(sp)
  38:	1000                	addi	s0,sp,32
    int n, pid;

    print("fork test\n");
  3a:	00000517          	auipc	a0,0x0
  3e:	3fe50513          	addi	a0,a0,1022 # 438 <sysinfo+0xe>
  42:	00000097          	auipc	ra,0x0
  46:	fbe080e7          	jalr	-66(ra) # 0 <print>

    for (n = 0; n < N; n++) {
  4a:	4481                	li	s1,0
  4c:	3e800913          	li	s2,1000
        pid = fork();
  50:	00000097          	auipc	ra,0x0
  54:	32a080e7          	jalr	810(ra) # 37a <fork>
        if (pid < 0)
  58:	06054163          	bltz	a0,ba <forktest+0x8c>
            break;
        if (pid == 0)
  5c:	c10d                	beqz	a0,7e <forktest+0x50>
    for (n = 0; n < N; n++) {
  5e:	2485                	addiw	s1,s1,1
  60:	ff2498e3          	bne	s1,s2,50 <forktest+0x22>
            exit(0);
    }

    if (n == N) {
        print("fork claimed to work N times!\n");
  64:	00000517          	auipc	a0,0x0
  68:	42450513          	addi	a0,a0,1060 # 488 <sysinfo+0x5e>
  6c:	00000097          	auipc	ra,0x0
  70:	f94080e7          	jalr	-108(ra) # 0 <print>
        exit(1);
  74:	4505                	li	a0,1
  76:	00000097          	auipc	ra,0x0
  7a:	30c080e7          	jalr	780(ra) # 382 <exit>
            exit(0);
  7e:	00000097          	auipc	ra,0x0
  82:	304080e7          	jalr	772(ra) # 382 <exit>
    }

    for (; n > 0; n--) {
        if (wait(0) < 0) {
            print("wait stopped early\n");
  86:	00000517          	auipc	a0,0x0
  8a:	3c250513          	addi	a0,a0,962 # 448 <sysinfo+0x1e>
  8e:	00000097          	auipc	ra,0x0
  92:	f72080e7          	jalr	-142(ra) # 0 <print>
            exit(1);
  96:	4505                	li	a0,1
  98:	00000097          	auipc	ra,0x0
  9c:	2ea080e7          	jalr	746(ra) # 382 <exit>
        }
    }

    if (wait(0) != -1) {
        print("wait got too many\n");
  a0:	00000517          	auipc	a0,0x0
  a4:	3c050513          	addi	a0,a0,960 # 460 <sysinfo+0x36>
  a8:	00000097          	auipc	ra,0x0
  ac:	f58080e7          	jalr	-168(ra) # 0 <print>
        exit(1);
  b0:	4505                	li	a0,1
  b2:	00000097          	auipc	ra,0x0
  b6:	2d0080e7          	jalr	720(ra) # 382 <exit>
    for (; n > 0; n--) {
  ba:	00905b63          	blez	s1,d0 <forktest+0xa2>
        if (wait(0) < 0) {
  be:	4501                	li	a0,0
  c0:	00000097          	auipc	ra,0x0
  c4:	2ca080e7          	jalr	714(ra) # 38a <wait>
  c8:	fa054fe3          	bltz	a0,86 <forktest+0x58>
    for (; n > 0; n--) {
  cc:	34fd                	addiw	s1,s1,-1
  ce:	f8e5                	bnez	s1,be <forktest+0x90>
    if (wait(0) != -1) {
  d0:	4501                	li	a0,0
  d2:	00000097          	auipc	ra,0x0
  d6:	2b8080e7          	jalr	696(ra) # 38a <wait>
  da:	57fd                	li	a5,-1
  dc:	fcf512e3          	bne	a0,a5,a0 <forktest+0x72>
    }

    print("fork test OK\n");
  e0:	00000517          	auipc	a0,0x0
  e4:	39850513          	addi	a0,a0,920 # 478 <sysinfo+0x4e>
  e8:	00000097          	auipc	ra,0x0
  ec:	f18080e7          	jalr	-232(ra) # 0 <print>
}
  f0:	60e2                	ld	ra,24(sp)
  f2:	6442                	ld	s0,16(sp)
  f4:	64a2                	ld	s1,8(sp)
  f6:	6902                	ld	s2,0(sp)
  f8:	6105                	addi	sp,sp,32
  fa:	8082                	ret

00000000000000fc <main>:

int main(void) {
  fc:	1141                	addi	sp,sp,-16
  fe:	e406                	sd	ra,8(sp)
 100:	e022                	sd	s0,0(sp)
 102:	0800                	addi	s0,sp,16
    forktest();
 104:	00000097          	auipc	ra,0x0
 108:	f2a080e7          	jalr	-214(ra) # 2e <forktest>
    exit(0);
 10c:	4501                	li	a0,0
 10e:	00000097          	auipc	ra,0x0
 112:	274080e7          	jalr	628(ra) # 382 <exit>

0000000000000116 <strcpy>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "user/user.h"

char *strcpy(char *s, const char *t) {
 116:	1141                	addi	sp,sp,-16
 118:	e422                	sd	s0,8(sp)
 11a:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 11c:	87aa                	mv	a5,a0
 11e:	0585                	addi	a1,a1,1
 120:	0785                	addi	a5,a5,1
 122:	fff5c703          	lbu	a4,-1(a1)
 126:	fee78fa3          	sb	a4,-1(a5)
 12a:	fb75                	bnez	a4,11e <strcpy+0x8>
        ;
    return os;
}
 12c:	6422                	ld	s0,8(sp)
 12e:	0141                	addi	sp,sp,16
 130:	8082                	ret

0000000000000132 <strcmp>:

int strcmp(const char *p, const char *q) {
 132:	1141                	addi	sp,sp,-16
 134:	e422                	sd	s0,8(sp)
 136:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 138:	00054783          	lbu	a5,0(a0)
 13c:	cb91                	beqz	a5,150 <strcmp+0x1e>
 13e:	0005c703          	lbu	a4,0(a1)
 142:	00f71763          	bne	a4,a5,150 <strcmp+0x1e>
        p++, q++;
 146:	0505                	addi	a0,a0,1
 148:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 14a:	00054783          	lbu	a5,0(a0)
 14e:	fbe5                	bnez	a5,13e <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 150:	0005c503          	lbu	a0,0(a1)
}
 154:	40a7853b          	subw	a0,a5,a0
 158:	6422                	ld	s0,8(sp)
 15a:	0141                	addi	sp,sp,16
 15c:	8082                	ret

000000000000015e <strlen>:

uint strlen(const char *s) {
 15e:	1141                	addi	sp,sp,-16
 160:	e422                	sd	s0,8(sp)
 162:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 164:	00054783          	lbu	a5,0(a0)
 168:	cf91                	beqz	a5,184 <strlen+0x26>
 16a:	0505                	addi	a0,a0,1
 16c:	87aa                	mv	a5,a0
 16e:	86be                	mv	a3,a5
 170:	0785                	addi	a5,a5,1
 172:	fff7c703          	lbu	a4,-1(a5)
 176:	ff65                	bnez	a4,16e <strlen+0x10>
 178:	40a6853b          	subw	a0,a3,a0
 17c:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 17e:	6422                	ld	s0,8(sp)
 180:	0141                	addi	sp,sp,16
 182:	8082                	ret
    for (n = 0; s[n]; n++)
 184:	4501                	li	a0,0
 186:	bfe5                	j	17e <strlen+0x20>

0000000000000188 <memset>:

void *memset(void *dst, int c, uint n) {
 188:	1141                	addi	sp,sp,-16
 18a:	e422                	sd	s0,8(sp)
 18c:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++) {
 18e:	ca19                	beqz	a2,1a4 <memset+0x1c>
 190:	87aa                	mv	a5,a0
 192:	1602                	slli	a2,a2,0x20
 194:	9201                	srli	a2,a2,0x20
 196:	00a60733          	add	a4,a2,a0
        cdst[i] = c;
 19a:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++) {
 19e:	0785                	addi	a5,a5,1
 1a0:	fee79de3          	bne	a5,a4,19a <memset+0x12>
    }
    return dst;
}
 1a4:	6422                	ld	s0,8(sp)
 1a6:	0141                	addi	sp,sp,16
 1a8:	8082                	ret

00000000000001aa <strchr>:

char *strchr(const char *s, char c) {
 1aa:	1141                	addi	sp,sp,-16
 1ac:	e422                	sd	s0,8(sp)
 1ae:	0800                	addi	s0,sp,16
    for (; *s; s++)
 1b0:	00054783          	lbu	a5,0(a0)
 1b4:	cb99                	beqz	a5,1ca <strchr+0x20>
        if (*s == c)
 1b6:	00f58763          	beq	a1,a5,1c4 <strchr+0x1a>
    for (; *s; s++)
 1ba:	0505                	addi	a0,a0,1
 1bc:	00054783          	lbu	a5,0(a0)
 1c0:	fbfd                	bnez	a5,1b6 <strchr+0xc>
            return (char *)s;
    return 0;
 1c2:	4501                	li	a0,0
}
 1c4:	6422                	ld	s0,8(sp)
 1c6:	0141                	addi	sp,sp,16
 1c8:	8082                	ret
    return 0;
 1ca:	4501                	li	a0,0
 1cc:	bfe5                	j	1c4 <strchr+0x1a>

00000000000001ce <gets>:

char *gets(char *buf, int max) {
 1ce:	711d                	addi	sp,sp,-96
 1d0:	ec86                	sd	ra,88(sp)
 1d2:	e8a2                	sd	s0,80(sp)
 1d4:	e4a6                	sd	s1,72(sp)
 1d6:	e0ca                	sd	s2,64(sp)
 1d8:	fc4e                	sd	s3,56(sp)
 1da:	f852                	sd	s4,48(sp)
 1dc:	f456                	sd	s5,40(sp)
 1de:	f05a                	sd	s6,32(sp)
 1e0:	ec5e                	sd	s7,24(sp)
 1e2:	1080                	addi	s0,sp,96
 1e4:	8baa                	mv	s7,a0
 1e6:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
 1e8:	892a                	mv	s2,a0
 1ea:	4481                	li	s1,0
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 1ec:	4aa9                	li	s5,10
 1ee:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;) {
 1f0:	89a6                	mv	s3,s1
 1f2:	2485                	addiw	s1,s1,1
 1f4:	0344d863          	bge	s1,s4,224 <gets+0x56>
        cc = read(0, &c, 1);
 1f8:	4605                	li	a2,1
 1fa:	faf40593          	addi	a1,s0,-81
 1fe:	4501                	li	a0,0
 200:	00000097          	auipc	ra,0x0
 204:	19a080e7          	jalr	410(ra) # 39a <read>
        if (cc < 1)
 208:	00a05e63          	blez	a0,224 <gets+0x56>
        buf[i++] = c;
 20c:	faf44783          	lbu	a5,-81(s0)
 210:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 214:	01578763          	beq	a5,s5,222 <gets+0x54>
 218:	0905                	addi	s2,s2,1
 21a:	fd679be3          	bne	a5,s6,1f0 <gets+0x22>
        buf[i++] = c;
 21e:	89a6                	mv	s3,s1
 220:	a011                	j	224 <gets+0x56>
 222:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 224:	99de                	add	s3,s3,s7
 226:	00098023          	sb	zero,0(s3)
    return buf;
}
 22a:	855e                	mv	a0,s7
 22c:	60e6                	ld	ra,88(sp)
 22e:	6446                	ld	s0,80(sp)
 230:	64a6                	ld	s1,72(sp)
 232:	6906                	ld	s2,64(sp)
 234:	79e2                	ld	s3,56(sp)
 236:	7a42                	ld	s4,48(sp)
 238:	7aa2                	ld	s5,40(sp)
 23a:	7b02                	ld	s6,32(sp)
 23c:	6be2                	ld	s7,24(sp)
 23e:	6125                	addi	sp,sp,96
 240:	8082                	ret

0000000000000242 <stat>:

int stat(const char *n, struct stat *st) {
 242:	1101                	addi	sp,sp,-32
 244:	ec06                	sd	ra,24(sp)
 246:	e822                	sd	s0,16(sp)
 248:	e04a                	sd	s2,0(sp)
 24a:	1000                	addi	s0,sp,32
 24c:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 24e:	4581                	li	a1,0
 250:	00000097          	auipc	ra,0x0
 254:	172080e7          	jalr	370(ra) # 3c2 <open>
    if (fd < 0)
 258:	02054663          	bltz	a0,284 <stat+0x42>
 25c:	e426                	sd	s1,8(sp)
 25e:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 260:	85ca                	mv	a1,s2
 262:	00000097          	auipc	ra,0x0
 266:	178080e7          	jalr	376(ra) # 3da <fstat>
 26a:	892a                	mv	s2,a0
    close(fd);
 26c:	8526                	mv	a0,s1
 26e:	00000097          	auipc	ra,0x0
 272:	13c080e7          	jalr	316(ra) # 3aa <close>
    return r;
 276:	64a2                	ld	s1,8(sp)
}
 278:	854a                	mv	a0,s2
 27a:	60e2                	ld	ra,24(sp)
 27c:	6442                	ld	s0,16(sp)
 27e:	6902                	ld	s2,0(sp)
 280:	6105                	addi	sp,sp,32
 282:	8082                	ret
        return -1;
 284:	597d                	li	s2,-1
 286:	bfcd                	j	278 <stat+0x36>

0000000000000288 <atoi>:

int atoi(const char *s) {
 288:	1141                	addi	sp,sp,-16
 28a:	e422                	sd	s0,8(sp)
 28c:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 28e:	00054683          	lbu	a3,0(a0)
 292:	fd06879b          	addiw	a5,a3,-48
 296:	0ff7f793          	zext.b	a5,a5
 29a:	4625                	li	a2,9
 29c:	02f66863          	bltu	a2,a5,2cc <atoi+0x44>
 2a0:	872a                	mv	a4,a0
    n = 0;
 2a2:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 2a4:	0705                	addi	a4,a4,1
 2a6:	0025179b          	slliw	a5,a0,0x2
 2aa:	9fa9                	addw	a5,a5,a0
 2ac:	0017979b          	slliw	a5,a5,0x1
 2b0:	9fb5                	addw	a5,a5,a3
 2b2:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 2b6:	00074683          	lbu	a3,0(a4)
 2ba:	fd06879b          	addiw	a5,a3,-48
 2be:	0ff7f793          	zext.b	a5,a5
 2c2:	fef671e3          	bgeu	a2,a5,2a4 <atoi+0x1c>
    return n;
}
 2c6:	6422                	ld	s0,8(sp)
 2c8:	0141                	addi	sp,sp,16
 2ca:	8082                	ret
    n = 0;
 2cc:	4501                	li	a0,0
 2ce:	bfe5                	j	2c6 <atoi+0x3e>

00000000000002d0 <memmove>:

void *memmove(void *vdst, const void *vsrc, int n) {
 2d0:	1141                	addi	sp,sp,-16
 2d2:	e422                	sd	s0,8(sp)
 2d4:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
 2d6:	02b57463          	bgeu	a0,a1,2fe <memmove+0x2e>
        while (n-- > 0)
 2da:	00c05f63          	blez	a2,2f8 <memmove+0x28>
 2de:	1602                	slli	a2,a2,0x20
 2e0:	9201                	srli	a2,a2,0x20
 2e2:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 2e6:	872a                	mv	a4,a0
            *dst++ = *src++;
 2e8:	0585                	addi	a1,a1,1
 2ea:	0705                	addi	a4,a4,1
 2ec:	fff5c683          	lbu	a3,-1(a1)
 2f0:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 2f4:	fef71ae3          	bne	a4,a5,2e8 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 2f8:	6422                	ld	s0,8(sp)
 2fa:	0141                	addi	sp,sp,16
 2fc:	8082                	ret
        dst += n;
 2fe:	00c50733          	add	a4,a0,a2
        src += n;
 302:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 304:	fec05ae3          	blez	a2,2f8 <memmove+0x28>
 308:	fff6079b          	addiw	a5,a2,-1
 30c:	1782                	slli	a5,a5,0x20
 30e:	9381                	srli	a5,a5,0x20
 310:	fff7c793          	not	a5,a5
 314:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 316:	15fd                	addi	a1,a1,-1
 318:	177d                	addi	a4,a4,-1
 31a:	0005c683          	lbu	a3,0(a1)
 31e:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 322:	fee79ae3          	bne	a5,a4,316 <memmove+0x46>
 326:	bfc9                	j	2f8 <memmove+0x28>

0000000000000328 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n) {
 328:	1141                	addi	sp,sp,-16
 32a:	e422                	sd	s0,8(sp)
 32c:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0) {
 32e:	ca05                	beqz	a2,35e <memcmp+0x36>
 330:	fff6069b          	addiw	a3,a2,-1
 334:	1682                	slli	a3,a3,0x20
 336:	9281                	srli	a3,a3,0x20
 338:	0685                	addi	a3,a3,1
 33a:	96aa                	add	a3,a3,a0
        if (*p1 != *p2) {
 33c:	00054783          	lbu	a5,0(a0)
 340:	0005c703          	lbu	a4,0(a1)
 344:	00e79863          	bne	a5,a4,354 <memcmp+0x2c>
            return *p1 - *p2;
        }
        p1++;
 348:	0505                	addi	a0,a0,1
        p2++;
 34a:	0585                	addi	a1,a1,1
    while (n-- > 0) {
 34c:	fed518e3          	bne	a0,a3,33c <memcmp+0x14>
    }
    return 0;
 350:	4501                	li	a0,0
 352:	a019                	j	358 <memcmp+0x30>
            return *p1 - *p2;
 354:	40e7853b          	subw	a0,a5,a4
}
 358:	6422                	ld	s0,8(sp)
 35a:	0141                	addi	sp,sp,16
 35c:	8082                	ret
    return 0;
 35e:	4501                	li	a0,0
 360:	bfe5                	j	358 <memcmp+0x30>

0000000000000362 <memcpy>:

void *memcpy(void *dst, const void *src, uint n) {
 362:	1141                	addi	sp,sp,-16
 364:	e406                	sd	ra,8(sp)
 366:	e022                	sd	s0,0(sp)
 368:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 36a:	00000097          	auipc	ra,0x0
 36e:	f66080e7          	jalr	-154(ra) # 2d0 <memmove>
}
 372:	60a2                	ld	ra,8(sp)
 374:	6402                	ld	s0,0(sp)
 376:	0141                	addi	sp,sp,16
 378:	8082                	ret

000000000000037a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 37a:	4885                	li	a7,1
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <exit>:
.global exit
exit:
 li a7, SYS_exit
 382:	4889                	li	a7,2
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <wait>:
.global wait
wait:
 li a7, SYS_wait
 38a:	488d                	li	a7,3
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 392:	4891                	li	a7,4
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <read>:
.global read
read:
 li a7, SYS_read
 39a:	4895                	li	a7,5
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <write>:
.global write
write:
 li a7, SYS_write
 3a2:	48c1                	li	a7,16
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <close>:
.global close
close:
 li a7, SYS_close
 3aa:	48d5                	li	a7,21
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3b2:	4899                	li	a7,6
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <exec>:
.global exec
exec:
 li a7, SYS_exec
 3ba:	489d                	li	a7,7
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <open>:
.global open
open:
 li a7, SYS_open
 3c2:	48bd                	li	a7,15
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3ca:	48c5                	li	a7,17
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3d2:	48c9                	li	a7,18
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3da:	48a1                	li	a7,8
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <link>:
.global link
link:
 li a7, SYS_link
 3e2:	48cd                	li	a7,19
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3ea:	48d1                	li	a7,20
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3f2:	48a5                	li	a7,9
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <dup>:
.global dup
dup:
 li a7, SYS_dup
 3fa:	48a9                	li	a7,10
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 402:	48ad                	li	a7,11
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 40a:	48b1                	li	a7,12
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 412:	48b5                	li	a7,13
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 41a:	48b9                	li	a7,14
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <trace>:
.global trace
trace:
 li a7, SYS_trace
 422:	48d9                	li	a7,22
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 42a:	48dd                	li	a7,23
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret
