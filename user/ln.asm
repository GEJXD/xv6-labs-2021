
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[]) {
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
    if (argc != 3) {
   8:	478d                	li	a5,3
   a:	02f50163          	beq	a0,a5,2c <main+0x2c>
   e:	e426                	sd	s1,8(sp)
        fprintf(2, "Usage: ln old new\n");
  10:	00000597          	auipc	a1,0x0
  14:	7f058593          	addi	a1,a1,2032 # 800 <malloc+0x102>
  18:	4509                	li	a0,2
  1a:	00000097          	auipc	ra,0x0
  1e:	5fe080e7          	jalr	1534(ra) # 618 <fprintf>
        exit(1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	2aa080e7          	jalr	682(ra) # 2ce <exit>
  2c:	e426                	sd	s1,8(sp)
  2e:	84ae                	mv	s1,a1
    }
    if (link(argv[1], argv[2]) < 0)
  30:	698c                	ld	a1,16(a1)
  32:	6488                	ld	a0,8(s1)
  34:	00000097          	auipc	ra,0x0
  38:	2fa080e7          	jalr	762(ra) # 32e <link>
  3c:	00054763          	bltz	a0,4a <main+0x4a>
        fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
    exit(0);
  40:	4501                	li	a0,0
  42:	00000097          	auipc	ra,0x0
  46:	28c080e7          	jalr	652(ra) # 2ce <exit>
        fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  4a:	6894                	ld	a3,16(s1)
  4c:	6490                	ld	a2,8(s1)
  4e:	00000597          	auipc	a1,0x0
  52:	7ca58593          	addi	a1,a1,1994 # 818 <malloc+0x11a>
  56:	4509                	li	a0,2
  58:	00000097          	auipc	ra,0x0
  5c:	5c0080e7          	jalr	1472(ra) # 618 <fprintf>
  60:	b7c5                	j	40 <main+0x40>

0000000000000062 <strcpy>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "user/user.h"

char *strcpy(char *s, const char *t) {
  62:	1141                	addi	sp,sp,-16
  64:	e422                	sd	s0,8(sp)
  66:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
  68:	87aa                	mv	a5,a0
  6a:	0585                	addi	a1,a1,1
  6c:	0785                	addi	a5,a5,1
  6e:	fff5c703          	lbu	a4,-1(a1)
  72:	fee78fa3          	sb	a4,-1(a5)
  76:	fb75                	bnez	a4,6a <strcpy+0x8>
        ;
    return os;
}
  78:	6422                	ld	s0,8(sp)
  7a:	0141                	addi	sp,sp,16
  7c:	8082                	ret

000000000000007e <strcmp>:

int strcmp(const char *p, const char *q) {
  7e:	1141                	addi	sp,sp,-16
  80:	e422                	sd	s0,8(sp)
  82:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
  84:	00054783          	lbu	a5,0(a0)
  88:	cb91                	beqz	a5,9c <strcmp+0x1e>
  8a:	0005c703          	lbu	a4,0(a1)
  8e:	00f71763          	bne	a4,a5,9c <strcmp+0x1e>
        p++, q++;
  92:	0505                	addi	a0,a0,1
  94:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
  96:	00054783          	lbu	a5,0(a0)
  9a:	fbe5                	bnez	a5,8a <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
  9c:	0005c503          	lbu	a0,0(a1)
}
  a0:	40a7853b          	subw	a0,a5,a0
  a4:	6422                	ld	s0,8(sp)
  a6:	0141                	addi	sp,sp,16
  a8:	8082                	ret

00000000000000aa <strlen>:

uint strlen(const char *s) {
  aa:	1141                	addi	sp,sp,-16
  ac:	e422                	sd	s0,8(sp)
  ae:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
  b0:	00054783          	lbu	a5,0(a0)
  b4:	cf91                	beqz	a5,d0 <strlen+0x26>
  b6:	0505                	addi	a0,a0,1
  b8:	87aa                	mv	a5,a0
  ba:	86be                	mv	a3,a5
  bc:	0785                	addi	a5,a5,1
  be:	fff7c703          	lbu	a4,-1(a5)
  c2:	ff65                	bnez	a4,ba <strlen+0x10>
  c4:	40a6853b          	subw	a0,a3,a0
  c8:	2505                	addiw	a0,a0,1
        ;
    return n;
}
  ca:	6422                	ld	s0,8(sp)
  cc:	0141                	addi	sp,sp,16
  ce:	8082                	ret
    for (n = 0; s[n]; n++)
  d0:	4501                	li	a0,0
  d2:	bfe5                	j	ca <strlen+0x20>

00000000000000d4 <memset>:

void *memset(void *dst, int c, uint n) {
  d4:	1141                	addi	sp,sp,-16
  d6:	e422                	sd	s0,8(sp)
  d8:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++) {
  da:	ca19                	beqz	a2,f0 <memset+0x1c>
  dc:	87aa                	mv	a5,a0
  de:	1602                	slli	a2,a2,0x20
  e0:	9201                	srli	a2,a2,0x20
  e2:	00a60733          	add	a4,a2,a0
        cdst[i] = c;
  e6:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++) {
  ea:	0785                	addi	a5,a5,1
  ec:	fee79de3          	bne	a5,a4,e6 <memset+0x12>
    }
    return dst;
}
  f0:	6422                	ld	s0,8(sp)
  f2:	0141                	addi	sp,sp,16
  f4:	8082                	ret

00000000000000f6 <strchr>:

char *strchr(const char *s, char c) {
  f6:	1141                	addi	sp,sp,-16
  f8:	e422                	sd	s0,8(sp)
  fa:	0800                	addi	s0,sp,16
    for (; *s; s++)
  fc:	00054783          	lbu	a5,0(a0)
 100:	cb99                	beqz	a5,116 <strchr+0x20>
        if (*s == c)
 102:	00f58763          	beq	a1,a5,110 <strchr+0x1a>
    for (; *s; s++)
 106:	0505                	addi	a0,a0,1
 108:	00054783          	lbu	a5,0(a0)
 10c:	fbfd                	bnez	a5,102 <strchr+0xc>
            return (char *)s;
    return 0;
 10e:	4501                	li	a0,0
}
 110:	6422                	ld	s0,8(sp)
 112:	0141                	addi	sp,sp,16
 114:	8082                	ret
    return 0;
 116:	4501                	li	a0,0
 118:	bfe5                	j	110 <strchr+0x1a>

000000000000011a <gets>:

char *gets(char *buf, int max) {
 11a:	711d                	addi	sp,sp,-96
 11c:	ec86                	sd	ra,88(sp)
 11e:	e8a2                	sd	s0,80(sp)
 120:	e4a6                	sd	s1,72(sp)
 122:	e0ca                	sd	s2,64(sp)
 124:	fc4e                	sd	s3,56(sp)
 126:	f852                	sd	s4,48(sp)
 128:	f456                	sd	s5,40(sp)
 12a:	f05a                	sd	s6,32(sp)
 12c:	ec5e                	sd	s7,24(sp)
 12e:	1080                	addi	s0,sp,96
 130:	8baa                	mv	s7,a0
 132:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
 134:	892a                	mv	s2,a0
 136:	4481                	li	s1,0
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 138:	4aa9                	li	s5,10
 13a:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;) {
 13c:	89a6                	mv	s3,s1
 13e:	2485                	addiw	s1,s1,1
 140:	0344d863          	bge	s1,s4,170 <gets+0x56>
        cc = read(0, &c, 1);
 144:	4605                	li	a2,1
 146:	faf40593          	addi	a1,s0,-81
 14a:	4501                	li	a0,0
 14c:	00000097          	auipc	ra,0x0
 150:	19a080e7          	jalr	410(ra) # 2e6 <read>
        if (cc < 1)
 154:	00a05e63          	blez	a0,170 <gets+0x56>
        buf[i++] = c;
 158:	faf44783          	lbu	a5,-81(s0)
 15c:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 160:	01578763          	beq	a5,s5,16e <gets+0x54>
 164:	0905                	addi	s2,s2,1
 166:	fd679be3          	bne	a5,s6,13c <gets+0x22>
        buf[i++] = c;
 16a:	89a6                	mv	s3,s1
 16c:	a011                	j	170 <gets+0x56>
 16e:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 170:	99de                	add	s3,s3,s7
 172:	00098023          	sb	zero,0(s3)
    return buf;
}
 176:	855e                	mv	a0,s7
 178:	60e6                	ld	ra,88(sp)
 17a:	6446                	ld	s0,80(sp)
 17c:	64a6                	ld	s1,72(sp)
 17e:	6906                	ld	s2,64(sp)
 180:	79e2                	ld	s3,56(sp)
 182:	7a42                	ld	s4,48(sp)
 184:	7aa2                	ld	s5,40(sp)
 186:	7b02                	ld	s6,32(sp)
 188:	6be2                	ld	s7,24(sp)
 18a:	6125                	addi	sp,sp,96
 18c:	8082                	ret

000000000000018e <stat>:

int stat(const char *n, struct stat *st) {
 18e:	1101                	addi	sp,sp,-32
 190:	ec06                	sd	ra,24(sp)
 192:	e822                	sd	s0,16(sp)
 194:	e04a                	sd	s2,0(sp)
 196:	1000                	addi	s0,sp,32
 198:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 19a:	4581                	li	a1,0
 19c:	00000097          	auipc	ra,0x0
 1a0:	172080e7          	jalr	370(ra) # 30e <open>
    if (fd < 0)
 1a4:	02054663          	bltz	a0,1d0 <stat+0x42>
 1a8:	e426                	sd	s1,8(sp)
 1aa:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 1ac:	85ca                	mv	a1,s2
 1ae:	00000097          	auipc	ra,0x0
 1b2:	178080e7          	jalr	376(ra) # 326 <fstat>
 1b6:	892a                	mv	s2,a0
    close(fd);
 1b8:	8526                	mv	a0,s1
 1ba:	00000097          	auipc	ra,0x0
 1be:	13c080e7          	jalr	316(ra) # 2f6 <close>
    return r;
 1c2:	64a2                	ld	s1,8(sp)
}
 1c4:	854a                	mv	a0,s2
 1c6:	60e2                	ld	ra,24(sp)
 1c8:	6442                	ld	s0,16(sp)
 1ca:	6902                	ld	s2,0(sp)
 1cc:	6105                	addi	sp,sp,32
 1ce:	8082                	ret
        return -1;
 1d0:	597d                	li	s2,-1
 1d2:	bfcd                	j	1c4 <stat+0x36>

00000000000001d4 <atoi>:

int atoi(const char *s) {
 1d4:	1141                	addi	sp,sp,-16
 1d6:	e422                	sd	s0,8(sp)
 1d8:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 1da:	00054683          	lbu	a3,0(a0)
 1de:	fd06879b          	addiw	a5,a3,-48
 1e2:	0ff7f793          	zext.b	a5,a5
 1e6:	4625                	li	a2,9
 1e8:	02f66863          	bltu	a2,a5,218 <atoi+0x44>
 1ec:	872a                	mv	a4,a0
    n = 0;
 1ee:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 1f0:	0705                	addi	a4,a4,1
 1f2:	0025179b          	slliw	a5,a0,0x2
 1f6:	9fa9                	addw	a5,a5,a0
 1f8:	0017979b          	slliw	a5,a5,0x1
 1fc:	9fb5                	addw	a5,a5,a3
 1fe:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 202:	00074683          	lbu	a3,0(a4)
 206:	fd06879b          	addiw	a5,a3,-48
 20a:	0ff7f793          	zext.b	a5,a5
 20e:	fef671e3          	bgeu	a2,a5,1f0 <atoi+0x1c>
    return n;
}
 212:	6422                	ld	s0,8(sp)
 214:	0141                	addi	sp,sp,16
 216:	8082                	ret
    n = 0;
 218:	4501                	li	a0,0
 21a:	bfe5                	j	212 <atoi+0x3e>

000000000000021c <memmove>:

void *memmove(void *vdst, const void *vsrc, int n) {
 21c:	1141                	addi	sp,sp,-16
 21e:	e422                	sd	s0,8(sp)
 220:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
 222:	02b57463          	bgeu	a0,a1,24a <memmove+0x2e>
        while (n-- > 0)
 226:	00c05f63          	blez	a2,244 <memmove+0x28>
 22a:	1602                	slli	a2,a2,0x20
 22c:	9201                	srli	a2,a2,0x20
 22e:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 232:	872a                	mv	a4,a0
            *dst++ = *src++;
 234:	0585                	addi	a1,a1,1
 236:	0705                	addi	a4,a4,1
 238:	fff5c683          	lbu	a3,-1(a1)
 23c:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 240:	fef71ae3          	bne	a4,a5,234 <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 244:	6422                	ld	s0,8(sp)
 246:	0141                	addi	sp,sp,16
 248:	8082                	ret
        dst += n;
 24a:	00c50733          	add	a4,a0,a2
        src += n;
 24e:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 250:	fec05ae3          	blez	a2,244 <memmove+0x28>
 254:	fff6079b          	addiw	a5,a2,-1
 258:	1782                	slli	a5,a5,0x20
 25a:	9381                	srli	a5,a5,0x20
 25c:	fff7c793          	not	a5,a5
 260:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 262:	15fd                	addi	a1,a1,-1
 264:	177d                	addi	a4,a4,-1
 266:	0005c683          	lbu	a3,0(a1)
 26a:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 26e:	fee79ae3          	bne	a5,a4,262 <memmove+0x46>
 272:	bfc9                	j	244 <memmove+0x28>

0000000000000274 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n) {
 274:	1141                	addi	sp,sp,-16
 276:	e422                	sd	s0,8(sp)
 278:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0) {
 27a:	ca05                	beqz	a2,2aa <memcmp+0x36>
 27c:	fff6069b          	addiw	a3,a2,-1
 280:	1682                	slli	a3,a3,0x20
 282:	9281                	srli	a3,a3,0x20
 284:	0685                	addi	a3,a3,1
 286:	96aa                	add	a3,a3,a0
        if (*p1 != *p2) {
 288:	00054783          	lbu	a5,0(a0)
 28c:	0005c703          	lbu	a4,0(a1)
 290:	00e79863          	bne	a5,a4,2a0 <memcmp+0x2c>
            return *p1 - *p2;
        }
        p1++;
 294:	0505                	addi	a0,a0,1
        p2++;
 296:	0585                	addi	a1,a1,1
    while (n-- > 0) {
 298:	fed518e3          	bne	a0,a3,288 <memcmp+0x14>
    }
    return 0;
 29c:	4501                	li	a0,0
 29e:	a019                	j	2a4 <memcmp+0x30>
            return *p1 - *p2;
 2a0:	40e7853b          	subw	a0,a5,a4
}
 2a4:	6422                	ld	s0,8(sp)
 2a6:	0141                	addi	sp,sp,16
 2a8:	8082                	ret
    return 0;
 2aa:	4501                	li	a0,0
 2ac:	bfe5                	j	2a4 <memcmp+0x30>

00000000000002ae <memcpy>:

void *memcpy(void *dst, const void *src, uint n) {
 2ae:	1141                	addi	sp,sp,-16
 2b0:	e406                	sd	ra,8(sp)
 2b2:	e022                	sd	s0,0(sp)
 2b4:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 2b6:	00000097          	auipc	ra,0x0
 2ba:	f66080e7          	jalr	-154(ra) # 21c <memmove>
}
 2be:	60a2                	ld	ra,8(sp)
 2c0:	6402                	ld	s0,0(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret

00000000000002c6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2c6:	4885                	li	a7,1
 ecall
 2c8:	00000073          	ecall
 ret
 2cc:	8082                	ret

00000000000002ce <exit>:
.global exit
exit:
 li a7, SYS_exit
 2ce:	4889                	li	a7,2
 ecall
 2d0:	00000073          	ecall
 ret
 2d4:	8082                	ret

00000000000002d6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2d6:	488d                	li	a7,3
 ecall
 2d8:	00000073          	ecall
 ret
 2dc:	8082                	ret

00000000000002de <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2de:	4891                	li	a7,4
 ecall
 2e0:	00000073          	ecall
 ret
 2e4:	8082                	ret

00000000000002e6 <read>:
.global read
read:
 li a7, SYS_read
 2e6:	4895                	li	a7,5
 ecall
 2e8:	00000073          	ecall
 ret
 2ec:	8082                	ret

00000000000002ee <write>:
.global write
write:
 li a7, SYS_write
 2ee:	48c1                	li	a7,16
 ecall
 2f0:	00000073          	ecall
 ret
 2f4:	8082                	ret

00000000000002f6 <close>:
.global close
close:
 li a7, SYS_close
 2f6:	48d5                	li	a7,21
 ecall
 2f8:	00000073          	ecall
 ret
 2fc:	8082                	ret

00000000000002fe <kill>:
.global kill
kill:
 li a7, SYS_kill
 2fe:	4899                	li	a7,6
 ecall
 300:	00000073          	ecall
 ret
 304:	8082                	ret

0000000000000306 <exec>:
.global exec
exec:
 li a7, SYS_exec
 306:	489d                	li	a7,7
 ecall
 308:	00000073          	ecall
 ret
 30c:	8082                	ret

000000000000030e <open>:
.global open
open:
 li a7, SYS_open
 30e:	48bd                	li	a7,15
 ecall
 310:	00000073          	ecall
 ret
 314:	8082                	ret

0000000000000316 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 316:	48c5                	li	a7,17
 ecall
 318:	00000073          	ecall
 ret
 31c:	8082                	ret

000000000000031e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 31e:	48c9                	li	a7,18
 ecall
 320:	00000073          	ecall
 ret
 324:	8082                	ret

0000000000000326 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 326:	48a1                	li	a7,8
 ecall
 328:	00000073          	ecall
 ret
 32c:	8082                	ret

000000000000032e <link>:
.global link
link:
 li a7, SYS_link
 32e:	48cd                	li	a7,19
 ecall
 330:	00000073          	ecall
 ret
 334:	8082                	ret

0000000000000336 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 336:	48d1                	li	a7,20
 ecall
 338:	00000073          	ecall
 ret
 33c:	8082                	ret

000000000000033e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 33e:	48a5                	li	a7,9
 ecall
 340:	00000073          	ecall
 ret
 344:	8082                	ret

0000000000000346 <dup>:
.global dup
dup:
 li a7, SYS_dup
 346:	48a9                	li	a7,10
 ecall
 348:	00000073          	ecall
 ret
 34c:	8082                	ret

000000000000034e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 34e:	48ad                	li	a7,11
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 356:	48b1                	li	a7,12
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 35e:	48b5                	li	a7,13
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 366:	48b9                	li	a7,14
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <trace>:
.global trace
trace:
 li a7, SYS_trace
 36e:	48d9                	li	a7,22
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 376:	48dd                	li	a7,23
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <putc>:

#include <stdarg.h>

static char digits[] = "0123456789ABCDEF";

static void putc(int fd, char c) { write(fd, &c, 1); }
 37e:	1101                	addi	sp,sp,-32
 380:	ec06                	sd	ra,24(sp)
 382:	e822                	sd	s0,16(sp)
 384:	1000                	addi	s0,sp,32
 386:	feb407a3          	sb	a1,-17(s0)
 38a:	4605                	li	a2,1
 38c:	fef40593          	addi	a1,s0,-17
 390:	00000097          	auipc	ra,0x0
 394:	f5e080e7          	jalr	-162(ra) # 2ee <write>
 398:	60e2                	ld	ra,24(sp)
 39a:	6442                	ld	s0,16(sp)
 39c:	6105                	addi	sp,sp,32
 39e:	8082                	ret

00000000000003a0 <printint>:

static void printint(int fd, int xx, int base, int sgn) {
 3a0:	7139                	addi	sp,sp,-64
 3a2:	fc06                	sd	ra,56(sp)
 3a4:	f822                	sd	s0,48(sp)
 3a6:	f426                	sd	s1,40(sp)
 3a8:	0080                	addi	s0,sp,64
 3aa:	84aa                	mv	s1,a0
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if (sgn && xx < 0) {
 3ac:	c299                	beqz	a3,3b2 <printint+0x12>
 3ae:	0805cb63          	bltz	a1,444 <printint+0xa4>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
 3b2:	2581                	sext.w	a1,a1
    neg = 0;
 3b4:	4881                	li	a7,0
 3b6:	fc040693          	addi	a3,s0,-64
    }

    i = 0;
 3ba:	4701                	li	a4,0
    do {
        buf[i++] = digits[x % base];
 3bc:	2601                	sext.w	a2,a2
 3be:	00000517          	auipc	a0,0x0
 3c2:	4d250513          	addi	a0,a0,1234 # 890 <digits>
 3c6:	883a                	mv	a6,a4
 3c8:	2705                	addiw	a4,a4,1
 3ca:	02c5f7bb          	remuw	a5,a1,a2
 3ce:	1782                	slli	a5,a5,0x20
 3d0:	9381                	srli	a5,a5,0x20
 3d2:	97aa                	add	a5,a5,a0
 3d4:	0007c783          	lbu	a5,0(a5)
 3d8:	00f68023          	sb	a5,0(a3)
    } while ((x /= base) != 0);
 3dc:	0005879b          	sext.w	a5,a1
 3e0:	02c5d5bb          	divuw	a1,a1,a2
 3e4:	0685                	addi	a3,a3,1
 3e6:	fec7f0e3          	bgeu	a5,a2,3c6 <printint+0x26>
    if (neg)
 3ea:	00088c63          	beqz	a7,402 <printint+0x62>
        buf[i++] = '-';
 3ee:	fd070793          	addi	a5,a4,-48
 3f2:	00878733          	add	a4,a5,s0
 3f6:	02d00793          	li	a5,45
 3fa:	fef70823          	sb	a5,-16(a4)
 3fe:	0028071b          	addiw	a4,a6,2

    while (--i >= 0)
 402:	02e05c63          	blez	a4,43a <printint+0x9a>
 406:	f04a                	sd	s2,32(sp)
 408:	ec4e                	sd	s3,24(sp)
 40a:	fc040793          	addi	a5,s0,-64
 40e:	00e78933          	add	s2,a5,a4
 412:	fff78993          	addi	s3,a5,-1
 416:	99ba                	add	s3,s3,a4
 418:	377d                	addiw	a4,a4,-1
 41a:	1702                	slli	a4,a4,0x20
 41c:	9301                	srli	a4,a4,0x20
 41e:	40e989b3          	sub	s3,s3,a4
        putc(fd, buf[i]);
 422:	fff94583          	lbu	a1,-1(s2)
 426:	8526                	mv	a0,s1
 428:	00000097          	auipc	ra,0x0
 42c:	f56080e7          	jalr	-170(ra) # 37e <putc>
    while (--i >= 0)
 430:	197d                	addi	s2,s2,-1
 432:	ff3918e3          	bne	s2,s3,422 <printint+0x82>
 436:	7902                	ld	s2,32(sp)
 438:	69e2                	ld	s3,24(sp)
}
 43a:	70e2                	ld	ra,56(sp)
 43c:	7442                	ld	s0,48(sp)
 43e:	74a2                	ld	s1,40(sp)
 440:	6121                	addi	sp,sp,64
 442:	8082                	ret
        x = -xx;
 444:	40b005bb          	negw	a1,a1
        neg = 1;
 448:	4885                	li	a7,1
        x = -xx;
 44a:	b7b5                	j	3b6 <printint+0x16>

000000000000044c <vprintf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void vprintf(int fd, const char *fmt, va_list ap) {
 44c:	715d                	addi	sp,sp,-80
 44e:	e486                	sd	ra,72(sp)
 450:	e0a2                	sd	s0,64(sp)
 452:	f84a                	sd	s2,48(sp)
 454:	0880                	addi	s0,sp,80
    char *s;
    int c, i, state;

    state = 0;
    for (i = 0; fmt[i]; i++) {
 456:	0005c903          	lbu	s2,0(a1)
 45a:	1a090a63          	beqz	s2,60e <vprintf+0x1c2>
 45e:	fc26                	sd	s1,56(sp)
 460:	f44e                	sd	s3,40(sp)
 462:	f052                	sd	s4,32(sp)
 464:	ec56                	sd	s5,24(sp)
 466:	e85a                	sd	s6,16(sp)
 468:	e45e                	sd	s7,8(sp)
 46a:	8aaa                	mv	s5,a0
 46c:	8bb2                	mv	s7,a2
 46e:	00158493          	addi	s1,a1,1
    state = 0;
 472:	4981                	li	s3,0
            if (c == '%') {
                state = '%';
            } else {
                putc(fd, c);
            }
        } else if (state == '%') {
 474:	02500a13          	li	s4,37
 478:	4b55                	li	s6,21
 47a:	a839                	j	498 <vprintf+0x4c>
                putc(fd, c);
 47c:	85ca                	mv	a1,s2
 47e:	8556                	mv	a0,s5
 480:	00000097          	auipc	ra,0x0
 484:	efe080e7          	jalr	-258(ra) # 37e <putc>
 488:	a019                	j	48e <vprintf+0x42>
        } else if (state == '%') {
 48a:	01498d63          	beq	s3,s4,4a4 <vprintf+0x58>
    for (i = 0; fmt[i]; i++) {
 48e:	0485                	addi	s1,s1,1
 490:	fff4c903          	lbu	s2,-1(s1)
 494:	16090763          	beqz	s2,602 <vprintf+0x1b6>
        if (state == 0) {
 498:	fe0999e3          	bnez	s3,48a <vprintf+0x3e>
            if (c == '%') {
 49c:	ff4910e3          	bne	s2,s4,47c <vprintf+0x30>
                state = '%';
 4a0:	89d2                	mv	s3,s4
 4a2:	b7f5                	j	48e <vprintf+0x42>
            if (c == 'd') {
 4a4:	13490463          	beq	s2,s4,5cc <vprintf+0x180>
 4a8:	f9d9079b          	addiw	a5,s2,-99
 4ac:	0ff7f793          	zext.b	a5,a5
 4b0:	12fb6763          	bltu	s6,a5,5de <vprintf+0x192>
 4b4:	f9d9079b          	addiw	a5,s2,-99
 4b8:	0ff7f713          	zext.b	a4,a5
 4bc:	12eb6163          	bltu	s6,a4,5de <vprintf+0x192>
 4c0:	00271793          	slli	a5,a4,0x2
 4c4:	00000717          	auipc	a4,0x0
 4c8:	37470713          	addi	a4,a4,884 # 838 <malloc+0x13a>
 4cc:	97ba                	add	a5,a5,a4
 4ce:	439c                	lw	a5,0(a5)
 4d0:	97ba                	add	a5,a5,a4
 4d2:	8782                	jr	a5
                printint(fd, va_arg(ap, int), 10, 1);
 4d4:	008b8913          	addi	s2,s7,8
 4d8:	4685                	li	a3,1
 4da:	4629                	li	a2,10
 4dc:	000ba583          	lw	a1,0(s7)
 4e0:	8556                	mv	a0,s5
 4e2:	00000097          	auipc	ra,0x0
 4e6:	ebe080e7          	jalr	-322(ra) # 3a0 <printint>
 4ea:	8bca                	mv	s7,s2
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
                putc(fd, c);
            }
            state = 0;
 4ec:	4981                	li	s3,0
 4ee:	b745                	j	48e <vprintf+0x42>
                printint(fd, va_arg(ap, uint64), 10, 0);
 4f0:	008b8913          	addi	s2,s7,8
 4f4:	4681                	li	a3,0
 4f6:	4629                	li	a2,10
 4f8:	000ba583          	lw	a1,0(s7)
 4fc:	8556                	mv	a0,s5
 4fe:	00000097          	auipc	ra,0x0
 502:	ea2080e7          	jalr	-350(ra) # 3a0 <printint>
 506:	8bca                	mv	s7,s2
            state = 0;
 508:	4981                	li	s3,0
 50a:	b751                	j	48e <vprintf+0x42>
                printint(fd, va_arg(ap, int), 16, 0);
 50c:	008b8913          	addi	s2,s7,8
 510:	4681                	li	a3,0
 512:	4641                	li	a2,16
 514:	000ba583          	lw	a1,0(s7)
 518:	8556                	mv	a0,s5
 51a:	00000097          	auipc	ra,0x0
 51e:	e86080e7          	jalr	-378(ra) # 3a0 <printint>
 522:	8bca                	mv	s7,s2
            state = 0;
 524:	4981                	li	s3,0
 526:	b7a5                	j	48e <vprintf+0x42>
 528:	e062                	sd	s8,0(sp)
                printptr(fd, va_arg(ap, uint64));
 52a:	008b8c13          	addi	s8,s7,8
 52e:	000bb983          	ld	s3,0(s7)
    putc(fd, '0');
 532:	03000593          	li	a1,48
 536:	8556                	mv	a0,s5
 538:	00000097          	auipc	ra,0x0
 53c:	e46080e7          	jalr	-442(ra) # 37e <putc>
    putc(fd, 'x');
 540:	07800593          	li	a1,120
 544:	8556                	mv	a0,s5
 546:	00000097          	auipc	ra,0x0
 54a:	e38080e7          	jalr	-456(ra) # 37e <putc>
 54e:	4941                	li	s2,16
        putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 550:	00000b97          	auipc	s7,0x0
 554:	340b8b93          	addi	s7,s7,832 # 890 <digits>
 558:	03c9d793          	srli	a5,s3,0x3c
 55c:	97de                	add	a5,a5,s7
 55e:	0007c583          	lbu	a1,0(a5)
 562:	8556                	mv	a0,s5
 564:	00000097          	auipc	ra,0x0
 568:	e1a080e7          	jalr	-486(ra) # 37e <putc>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 56c:	0992                	slli	s3,s3,0x4
 56e:	397d                	addiw	s2,s2,-1
 570:	fe0914e3          	bnez	s2,558 <vprintf+0x10c>
                printptr(fd, va_arg(ap, uint64));
 574:	8be2                	mv	s7,s8
            state = 0;
 576:	4981                	li	s3,0
 578:	6c02                	ld	s8,0(sp)
 57a:	bf11                	j	48e <vprintf+0x42>
                s = va_arg(ap, char *);
 57c:	008b8993          	addi	s3,s7,8
 580:	000bb903          	ld	s2,0(s7)
                if (s == 0)
 584:	02090163          	beqz	s2,5a6 <vprintf+0x15a>
                while (*s != 0) {
 588:	00094583          	lbu	a1,0(s2)
 58c:	c9a5                	beqz	a1,5fc <vprintf+0x1b0>
                    putc(fd, *s);
 58e:	8556                	mv	a0,s5
 590:	00000097          	auipc	ra,0x0
 594:	dee080e7          	jalr	-530(ra) # 37e <putc>
                    s++;
 598:	0905                	addi	s2,s2,1
                while (*s != 0) {
 59a:	00094583          	lbu	a1,0(s2)
 59e:	f9e5                	bnez	a1,58e <vprintf+0x142>
                s = va_arg(ap, char *);
 5a0:	8bce                	mv	s7,s3
            state = 0;
 5a2:	4981                	li	s3,0
 5a4:	b5ed                	j	48e <vprintf+0x42>
                    s = "(null)";
 5a6:	00000917          	auipc	s2,0x0
 5aa:	28a90913          	addi	s2,s2,650 # 830 <malloc+0x132>
                while (*s != 0) {
 5ae:	02800593          	li	a1,40
 5b2:	bff1                	j	58e <vprintf+0x142>
                putc(fd, va_arg(ap, uint));
 5b4:	008b8913          	addi	s2,s7,8
 5b8:	000bc583          	lbu	a1,0(s7)
 5bc:	8556                	mv	a0,s5
 5be:	00000097          	auipc	ra,0x0
 5c2:	dc0080e7          	jalr	-576(ra) # 37e <putc>
 5c6:	8bca                	mv	s7,s2
            state = 0;
 5c8:	4981                	li	s3,0
 5ca:	b5d1                	j	48e <vprintf+0x42>
                putc(fd, c);
 5cc:	02500593          	li	a1,37
 5d0:	8556                	mv	a0,s5
 5d2:	00000097          	auipc	ra,0x0
 5d6:	dac080e7          	jalr	-596(ra) # 37e <putc>
            state = 0;
 5da:	4981                	li	s3,0
 5dc:	bd4d                	j	48e <vprintf+0x42>
                putc(fd, '%');
 5de:	02500593          	li	a1,37
 5e2:	8556                	mv	a0,s5
 5e4:	00000097          	auipc	ra,0x0
 5e8:	d9a080e7          	jalr	-614(ra) # 37e <putc>
                putc(fd, c);
 5ec:	85ca                	mv	a1,s2
 5ee:	8556                	mv	a0,s5
 5f0:	00000097          	auipc	ra,0x0
 5f4:	d8e080e7          	jalr	-626(ra) # 37e <putc>
            state = 0;
 5f8:	4981                	li	s3,0
 5fa:	bd51                	j	48e <vprintf+0x42>
                s = va_arg(ap, char *);
 5fc:	8bce                	mv	s7,s3
            state = 0;
 5fe:	4981                	li	s3,0
 600:	b579                	j	48e <vprintf+0x42>
 602:	74e2                	ld	s1,56(sp)
 604:	79a2                	ld	s3,40(sp)
 606:	7a02                	ld	s4,32(sp)
 608:	6ae2                	ld	s5,24(sp)
 60a:	6b42                	ld	s6,16(sp)
 60c:	6ba2                	ld	s7,8(sp)
        }
    }
}
 60e:	60a6                	ld	ra,72(sp)
 610:	6406                	ld	s0,64(sp)
 612:	7942                	ld	s2,48(sp)
 614:	6161                	addi	sp,sp,80
 616:	8082                	ret

0000000000000618 <fprintf>:

void fprintf(int fd, const char *fmt, ...) {
 618:	715d                	addi	sp,sp,-80
 61a:	ec06                	sd	ra,24(sp)
 61c:	e822                	sd	s0,16(sp)
 61e:	1000                	addi	s0,sp,32
 620:	e010                	sd	a2,0(s0)
 622:	e414                	sd	a3,8(s0)
 624:	e818                	sd	a4,16(s0)
 626:	ec1c                	sd	a5,24(s0)
 628:	03043023          	sd	a6,32(s0)
 62c:	03143423          	sd	a7,40(s0)
    va_list ap;

    va_start(ap, fmt);
 630:	fe843423          	sd	s0,-24(s0)
    vprintf(fd, fmt, ap);
 634:	8622                	mv	a2,s0
 636:	00000097          	auipc	ra,0x0
 63a:	e16080e7          	jalr	-490(ra) # 44c <vprintf>
}
 63e:	60e2                	ld	ra,24(sp)
 640:	6442                	ld	s0,16(sp)
 642:	6161                	addi	sp,sp,80
 644:	8082                	ret

0000000000000646 <printf>:

void printf(const char *fmt, ...) {
 646:	711d                	addi	sp,sp,-96
 648:	ec06                	sd	ra,24(sp)
 64a:	e822                	sd	s0,16(sp)
 64c:	1000                	addi	s0,sp,32
 64e:	e40c                	sd	a1,8(s0)
 650:	e810                	sd	a2,16(s0)
 652:	ec14                	sd	a3,24(s0)
 654:	f018                	sd	a4,32(s0)
 656:	f41c                	sd	a5,40(s0)
 658:	03043823          	sd	a6,48(s0)
 65c:	03143c23          	sd	a7,56(s0)
    va_list ap;

    va_start(ap, fmt);
 660:	00840613          	addi	a2,s0,8
 664:	fec43423          	sd	a2,-24(s0)
    vprintf(1, fmt, ap);
 668:	85aa                	mv	a1,a0
 66a:	4505                	li	a0,1
 66c:	00000097          	auipc	ra,0x0
 670:	de0080e7          	jalr	-544(ra) # 44c <vprintf>
}
 674:	60e2                	ld	ra,24(sp)
 676:	6442                	ld	s0,16(sp)
 678:	6125                	addi	sp,sp,96
 67a:	8082                	ret

000000000000067c <free>:
typedef union header Header;

static Header base;
static Header *freep;

void free(void *ap) {
 67c:	1141                	addi	sp,sp,-16
 67e:	e422                	sd	s0,8(sp)
 680:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 682:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 686:	00000797          	auipc	a5,0x0
 68a:	5e27b783          	ld	a5,1506(a5) # c68 <freep>
 68e:	a02d                	j	6b8 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr) {
        bp->s.size += p->s.ptr->s.size;
 690:	4618                	lw	a4,8(a2)
 692:	9f2d                	addw	a4,a4,a1
 694:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 698:	6398                	ld	a4,0(a5)
 69a:	6310                	ld	a2,0(a4)
 69c:	a83d                	j	6da <free+0x5e>
    } else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp) {
        p->s.size += bp->s.size;
 69e:	ff852703          	lw	a4,-8(a0)
 6a2:	9f31                	addw	a4,a4,a2
 6a4:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 6a6:	ff053683          	ld	a3,-16(a0)
 6aa:	a091                	j	6ee <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ac:	6398                	ld	a4,0(a5)
 6ae:	00e7e463          	bltu	a5,a4,6b6 <free+0x3a>
 6b2:	00e6ea63          	bltu	a3,a4,6c6 <free+0x4a>
void free(void *ap) {
 6b6:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b8:	fed7fae3          	bgeu	a5,a3,6ac <free+0x30>
 6bc:	6398                	ld	a4,0(a5)
 6be:	00e6e463          	bltu	a3,a4,6c6 <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c2:	fee7eae3          	bltu	a5,a4,6b6 <free+0x3a>
    if (bp + bp->s.size == p->s.ptr) {
 6c6:	ff852583          	lw	a1,-8(a0)
 6ca:	6390                	ld	a2,0(a5)
 6cc:	02059813          	slli	a6,a1,0x20
 6d0:	01c85713          	srli	a4,a6,0x1c
 6d4:	9736                	add	a4,a4,a3
 6d6:	fae60de3          	beq	a2,a4,690 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 6da:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp) {
 6de:	4790                	lw	a2,8(a5)
 6e0:	02061593          	slli	a1,a2,0x20
 6e4:	01c5d713          	srli	a4,a1,0x1c
 6e8:	973e                	add	a4,a4,a5
 6ea:	fae68ae3          	beq	a3,a4,69e <free+0x22>
        p->s.ptr = bp->s.ptr;
 6ee:	e394                	sd	a3,0(a5)
    } else
        p->s.ptr = bp;
    freep = p;
 6f0:	00000717          	auipc	a4,0x0
 6f4:	56f73c23          	sd	a5,1400(a4) # c68 <freep>
}
 6f8:	6422                	ld	s0,8(sp)
 6fa:	0141                	addi	sp,sp,16
 6fc:	8082                	ret

00000000000006fe <malloc>:
    hp->s.size = nu;
    free((void *)(hp + 1));
    return freep;
}

void *malloc(uint nbytes) {
 6fe:	7139                	addi	sp,sp,-64
 700:	fc06                	sd	ra,56(sp)
 702:	f822                	sd	s0,48(sp)
 704:	f426                	sd	s1,40(sp)
 706:	ec4e                	sd	s3,24(sp)
 708:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 70a:	02051493          	slli	s1,a0,0x20
 70e:	9081                	srli	s1,s1,0x20
 710:	04bd                	addi	s1,s1,15
 712:	8091                	srli	s1,s1,0x4
 714:	0014899b          	addiw	s3,s1,1
 718:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0) {
 71a:	00000517          	auipc	a0,0x0
 71e:	54e53503          	ld	a0,1358(a0) # c68 <freep>
 722:	c915                	beqz	a0,756 <malloc+0x58>
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 724:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits) {
 726:	4798                	lw	a4,8(a5)
 728:	08977e63          	bgeu	a4,s1,7c4 <malloc+0xc6>
 72c:	f04a                	sd	s2,32(sp)
 72e:	e852                	sd	s4,16(sp)
 730:	e456                	sd	s5,8(sp)
 732:	e05a                	sd	s6,0(sp)
    if (nu < 4096)
 734:	8a4e                	mv	s4,s3
 736:	0009871b          	sext.w	a4,s3
 73a:	6685                	lui	a3,0x1
 73c:	00d77363          	bgeu	a4,a3,742 <malloc+0x44>
 740:	6a05                	lui	s4,0x1
 742:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 746:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 74a:	00000917          	auipc	s2,0x0
 74e:	51e90913          	addi	s2,s2,1310 # c68 <freep>
    if (p == (char *)-1)
 752:	5afd                	li	s5,-1
 754:	a091                	j	798 <malloc+0x9a>
 756:	f04a                	sd	s2,32(sp)
 758:	e852                	sd	s4,16(sp)
 75a:	e456                	sd	s5,8(sp)
 75c:	e05a                	sd	s6,0(sp)
        base.s.ptr = freep = prevp = &base;
 75e:	00000797          	auipc	a5,0x0
 762:	51278793          	addi	a5,a5,1298 # c70 <base>
 766:	00000717          	auipc	a4,0x0
 76a:	50f73123          	sd	a5,1282(a4) # c68 <freep>
 76e:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 770:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits) {
 774:	b7c1                	j	734 <malloc+0x36>
                prevp->s.ptr = p->s.ptr;
 776:	6398                	ld	a4,0(a5)
 778:	e118                	sd	a4,0(a0)
 77a:	a08d                	j	7dc <malloc+0xde>
    hp->s.size = nu;
 77c:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 780:	0541                	addi	a0,a0,16
 782:	00000097          	auipc	ra,0x0
 786:	efa080e7          	jalr	-262(ra) # 67c <free>
    return freep;
 78a:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 78e:	c13d                	beqz	a0,7f4 <malloc+0xf6>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 790:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits) {
 792:	4798                	lw	a4,8(a5)
 794:	02977463          	bgeu	a4,s1,7bc <malloc+0xbe>
        if (p == freep)
 798:	00093703          	ld	a4,0(s2)
 79c:	853e                	mv	a0,a5
 79e:	fef719e3          	bne	a4,a5,790 <malloc+0x92>
    p = sbrk(nu * sizeof(Header));
 7a2:	8552                	mv	a0,s4
 7a4:	00000097          	auipc	ra,0x0
 7a8:	bb2080e7          	jalr	-1102(ra) # 356 <sbrk>
    if (p == (char *)-1)
 7ac:	fd5518e3          	bne	a0,s5,77c <malloc+0x7e>
                return 0;
 7b0:	4501                	li	a0,0
 7b2:	7902                	ld	s2,32(sp)
 7b4:	6a42                	ld	s4,16(sp)
 7b6:	6aa2                	ld	s5,8(sp)
 7b8:	6b02                	ld	s6,0(sp)
 7ba:	a03d                	j	7e8 <malloc+0xea>
 7bc:	7902                	ld	s2,32(sp)
 7be:	6a42                	ld	s4,16(sp)
 7c0:	6aa2                	ld	s5,8(sp)
 7c2:	6b02                	ld	s6,0(sp)
            if (p->s.size == nunits)
 7c4:	fae489e3          	beq	s1,a4,776 <malloc+0x78>
                p->s.size -= nunits;
 7c8:	4137073b          	subw	a4,a4,s3
 7cc:	c798                	sw	a4,8(a5)
                p += p->s.size;
 7ce:	02071693          	slli	a3,a4,0x20
 7d2:	01c6d713          	srli	a4,a3,0x1c
 7d6:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 7d8:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 7dc:	00000717          	auipc	a4,0x0
 7e0:	48a73623          	sd	a0,1164(a4) # c68 <freep>
            return (void *)(p + 1);
 7e4:	01078513          	addi	a0,a5,16
    }
}
 7e8:	70e2                	ld	ra,56(sp)
 7ea:	7442                	ld	s0,48(sp)
 7ec:	74a2                	ld	s1,40(sp)
 7ee:	69e2                	ld	s3,24(sp)
 7f0:	6121                	addi	sp,sp,64
 7f2:	8082                	ret
 7f4:	7902                	ld	s2,32(sp)
 7f6:	6a42                	ld	s4,16(sp)
 7f8:	6aa2                	ld	s5,8(sp)
 7fa:	6b02                	ld	s6,0(sp)
 7fc:	b7f5                	j	7e8 <malloc+0xea>
