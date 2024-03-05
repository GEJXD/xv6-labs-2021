
user/_mkdir:     file format elf64-littleriscv


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
    int i;

    if (argc < 2) {
   8:	4785                	li	a5,1
   a:	02a7d963          	bge	a5,a0,3c <main+0x3c>
   e:	e426                	sd	s1,8(sp)
  10:	e04a                	sd	s2,0(sp)
  12:	00858493          	addi	s1,a1,8
  16:	ffe5091b          	addiw	s2,a0,-2
  1a:	02091793          	slli	a5,s2,0x20
  1e:	01d7d913          	srli	s2,a5,0x1d
  22:	05c1                	addi	a1,a1,16
  24:	992e                	add	s2,s2,a1
        fprintf(2, "Usage: mkdir files...\n");
        exit(1);
    }

    for (i = 1; i < argc; i++) {
        if (mkdir(argv[i]) < 0) {
  26:	6088                	ld	a0,0(s1)
  28:	00000097          	auipc	ra,0x0
  2c:	326080e7          	jalr	806(ra) # 34e <mkdir>
  30:	02054663          	bltz	a0,5c <main+0x5c>
    for (i = 1; i < argc; i++) {
  34:	04a1                	addi	s1,s1,8
  36:	ff2498e3          	bne	s1,s2,26 <main+0x26>
  3a:	a81d                	j	70 <main+0x70>
  3c:	e426                	sd	s1,8(sp)
  3e:	e04a                	sd	s2,0(sp)
        fprintf(2, "Usage: mkdir files...\n");
  40:	00000597          	auipc	a1,0x0
  44:	7d858593          	addi	a1,a1,2008 # 818 <malloc+0x102>
  48:	4509                	li	a0,2
  4a:	00000097          	auipc	ra,0x0
  4e:	5e6080e7          	jalr	1510(ra) # 630 <fprintf>
        exit(1);
  52:	4505                	li	a0,1
  54:	00000097          	auipc	ra,0x0
  58:	292080e7          	jalr	658(ra) # 2e6 <exit>
            fprintf(2, "mkdir: %s failed to create\n", argv[i]);
  5c:	6090                	ld	a2,0(s1)
  5e:	00000597          	auipc	a1,0x0
  62:	7d258593          	addi	a1,a1,2002 # 830 <malloc+0x11a>
  66:	4509                	li	a0,2
  68:	00000097          	auipc	ra,0x0
  6c:	5c8080e7          	jalr	1480(ra) # 630 <fprintf>
            break;
        }
    }

    exit(0);
  70:	4501                	li	a0,0
  72:	00000097          	auipc	ra,0x0
  76:	274080e7          	jalr	628(ra) # 2e6 <exit>

000000000000007a <strcpy>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "user/user.h"

char *strcpy(char *s, const char *t) {
  7a:	1141                	addi	sp,sp,-16
  7c:	e422                	sd	s0,8(sp)
  7e:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
  80:	87aa                	mv	a5,a0
  82:	0585                	addi	a1,a1,1
  84:	0785                	addi	a5,a5,1
  86:	fff5c703          	lbu	a4,-1(a1)
  8a:	fee78fa3          	sb	a4,-1(a5)
  8e:	fb75                	bnez	a4,82 <strcpy+0x8>
        ;
    return os;
}
  90:	6422                	ld	s0,8(sp)
  92:	0141                	addi	sp,sp,16
  94:	8082                	ret

0000000000000096 <strcmp>:

int strcmp(const char *p, const char *q) {
  96:	1141                	addi	sp,sp,-16
  98:	e422                	sd	s0,8(sp)
  9a:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
  9c:	00054783          	lbu	a5,0(a0)
  a0:	cb91                	beqz	a5,b4 <strcmp+0x1e>
  a2:	0005c703          	lbu	a4,0(a1)
  a6:	00f71763          	bne	a4,a5,b4 <strcmp+0x1e>
        p++, q++;
  aa:	0505                	addi	a0,a0,1
  ac:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
  ae:	00054783          	lbu	a5,0(a0)
  b2:	fbe5                	bnez	a5,a2 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
  b4:	0005c503          	lbu	a0,0(a1)
}
  b8:	40a7853b          	subw	a0,a5,a0
  bc:	6422                	ld	s0,8(sp)
  be:	0141                	addi	sp,sp,16
  c0:	8082                	ret

00000000000000c2 <strlen>:

uint strlen(const char *s) {
  c2:	1141                	addi	sp,sp,-16
  c4:	e422                	sd	s0,8(sp)
  c6:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
  c8:	00054783          	lbu	a5,0(a0)
  cc:	cf91                	beqz	a5,e8 <strlen+0x26>
  ce:	0505                	addi	a0,a0,1
  d0:	87aa                	mv	a5,a0
  d2:	86be                	mv	a3,a5
  d4:	0785                	addi	a5,a5,1
  d6:	fff7c703          	lbu	a4,-1(a5)
  da:	ff65                	bnez	a4,d2 <strlen+0x10>
  dc:	40a6853b          	subw	a0,a3,a0
  e0:	2505                	addiw	a0,a0,1
        ;
    return n;
}
  e2:	6422                	ld	s0,8(sp)
  e4:	0141                	addi	sp,sp,16
  e6:	8082                	ret
    for (n = 0; s[n]; n++)
  e8:	4501                	li	a0,0
  ea:	bfe5                	j	e2 <strlen+0x20>

00000000000000ec <memset>:

void *memset(void *dst, int c, uint n) {
  ec:	1141                	addi	sp,sp,-16
  ee:	e422                	sd	s0,8(sp)
  f0:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++) {
  f2:	ca19                	beqz	a2,108 <memset+0x1c>
  f4:	87aa                	mv	a5,a0
  f6:	1602                	slli	a2,a2,0x20
  f8:	9201                	srli	a2,a2,0x20
  fa:	00a60733          	add	a4,a2,a0
        cdst[i] = c;
  fe:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++) {
 102:	0785                	addi	a5,a5,1
 104:	fee79de3          	bne	a5,a4,fe <memset+0x12>
    }
    return dst;
}
 108:	6422                	ld	s0,8(sp)
 10a:	0141                	addi	sp,sp,16
 10c:	8082                	ret

000000000000010e <strchr>:

char *strchr(const char *s, char c) {
 10e:	1141                	addi	sp,sp,-16
 110:	e422                	sd	s0,8(sp)
 112:	0800                	addi	s0,sp,16
    for (; *s; s++)
 114:	00054783          	lbu	a5,0(a0)
 118:	cb99                	beqz	a5,12e <strchr+0x20>
        if (*s == c)
 11a:	00f58763          	beq	a1,a5,128 <strchr+0x1a>
    for (; *s; s++)
 11e:	0505                	addi	a0,a0,1
 120:	00054783          	lbu	a5,0(a0)
 124:	fbfd                	bnez	a5,11a <strchr+0xc>
            return (char *)s;
    return 0;
 126:	4501                	li	a0,0
}
 128:	6422                	ld	s0,8(sp)
 12a:	0141                	addi	sp,sp,16
 12c:	8082                	ret
    return 0;
 12e:	4501                	li	a0,0
 130:	bfe5                	j	128 <strchr+0x1a>

0000000000000132 <gets>:

char *gets(char *buf, int max) {
 132:	711d                	addi	sp,sp,-96
 134:	ec86                	sd	ra,88(sp)
 136:	e8a2                	sd	s0,80(sp)
 138:	e4a6                	sd	s1,72(sp)
 13a:	e0ca                	sd	s2,64(sp)
 13c:	fc4e                	sd	s3,56(sp)
 13e:	f852                	sd	s4,48(sp)
 140:	f456                	sd	s5,40(sp)
 142:	f05a                	sd	s6,32(sp)
 144:	ec5e                	sd	s7,24(sp)
 146:	1080                	addi	s0,sp,96
 148:	8baa                	mv	s7,a0
 14a:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
 14c:	892a                	mv	s2,a0
 14e:	4481                	li	s1,0
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 150:	4aa9                	li	s5,10
 152:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;) {
 154:	89a6                	mv	s3,s1
 156:	2485                	addiw	s1,s1,1
 158:	0344d863          	bge	s1,s4,188 <gets+0x56>
        cc = read(0, &c, 1);
 15c:	4605                	li	a2,1
 15e:	faf40593          	addi	a1,s0,-81
 162:	4501                	li	a0,0
 164:	00000097          	auipc	ra,0x0
 168:	19a080e7          	jalr	410(ra) # 2fe <read>
        if (cc < 1)
 16c:	00a05e63          	blez	a0,188 <gets+0x56>
        buf[i++] = c;
 170:	faf44783          	lbu	a5,-81(s0)
 174:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 178:	01578763          	beq	a5,s5,186 <gets+0x54>
 17c:	0905                	addi	s2,s2,1
 17e:	fd679be3          	bne	a5,s6,154 <gets+0x22>
        buf[i++] = c;
 182:	89a6                	mv	s3,s1
 184:	a011                	j	188 <gets+0x56>
 186:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 188:	99de                	add	s3,s3,s7
 18a:	00098023          	sb	zero,0(s3)
    return buf;
}
 18e:	855e                	mv	a0,s7
 190:	60e6                	ld	ra,88(sp)
 192:	6446                	ld	s0,80(sp)
 194:	64a6                	ld	s1,72(sp)
 196:	6906                	ld	s2,64(sp)
 198:	79e2                	ld	s3,56(sp)
 19a:	7a42                	ld	s4,48(sp)
 19c:	7aa2                	ld	s5,40(sp)
 19e:	7b02                	ld	s6,32(sp)
 1a0:	6be2                	ld	s7,24(sp)
 1a2:	6125                	addi	sp,sp,96
 1a4:	8082                	ret

00000000000001a6 <stat>:

int stat(const char *n, struct stat *st) {
 1a6:	1101                	addi	sp,sp,-32
 1a8:	ec06                	sd	ra,24(sp)
 1aa:	e822                	sd	s0,16(sp)
 1ac:	e04a                	sd	s2,0(sp)
 1ae:	1000                	addi	s0,sp,32
 1b0:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 1b2:	4581                	li	a1,0
 1b4:	00000097          	auipc	ra,0x0
 1b8:	172080e7          	jalr	370(ra) # 326 <open>
    if (fd < 0)
 1bc:	02054663          	bltz	a0,1e8 <stat+0x42>
 1c0:	e426                	sd	s1,8(sp)
 1c2:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 1c4:	85ca                	mv	a1,s2
 1c6:	00000097          	auipc	ra,0x0
 1ca:	178080e7          	jalr	376(ra) # 33e <fstat>
 1ce:	892a                	mv	s2,a0
    close(fd);
 1d0:	8526                	mv	a0,s1
 1d2:	00000097          	auipc	ra,0x0
 1d6:	13c080e7          	jalr	316(ra) # 30e <close>
    return r;
 1da:	64a2                	ld	s1,8(sp)
}
 1dc:	854a                	mv	a0,s2
 1de:	60e2                	ld	ra,24(sp)
 1e0:	6442                	ld	s0,16(sp)
 1e2:	6902                	ld	s2,0(sp)
 1e4:	6105                	addi	sp,sp,32
 1e6:	8082                	ret
        return -1;
 1e8:	597d                	li	s2,-1
 1ea:	bfcd                	j	1dc <stat+0x36>

00000000000001ec <atoi>:

int atoi(const char *s) {
 1ec:	1141                	addi	sp,sp,-16
 1ee:	e422                	sd	s0,8(sp)
 1f0:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 1f2:	00054683          	lbu	a3,0(a0)
 1f6:	fd06879b          	addiw	a5,a3,-48
 1fa:	0ff7f793          	zext.b	a5,a5
 1fe:	4625                	li	a2,9
 200:	02f66863          	bltu	a2,a5,230 <atoi+0x44>
 204:	872a                	mv	a4,a0
    n = 0;
 206:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 208:	0705                	addi	a4,a4,1
 20a:	0025179b          	slliw	a5,a0,0x2
 20e:	9fa9                	addw	a5,a5,a0
 210:	0017979b          	slliw	a5,a5,0x1
 214:	9fb5                	addw	a5,a5,a3
 216:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 21a:	00074683          	lbu	a3,0(a4)
 21e:	fd06879b          	addiw	a5,a3,-48
 222:	0ff7f793          	zext.b	a5,a5
 226:	fef671e3          	bgeu	a2,a5,208 <atoi+0x1c>
    return n;
}
 22a:	6422                	ld	s0,8(sp)
 22c:	0141                	addi	sp,sp,16
 22e:	8082                	ret
    n = 0;
 230:	4501                	li	a0,0
 232:	bfe5                	j	22a <atoi+0x3e>

0000000000000234 <memmove>:

void *memmove(void *vdst, const void *vsrc, int n) {
 234:	1141                	addi	sp,sp,-16
 236:	e422                	sd	s0,8(sp)
 238:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
 23a:	02b57463          	bgeu	a0,a1,262 <memmove+0x2e>
        while (n-- > 0)
 23e:	00c05f63          	blez	a2,25c <memmove+0x28>
 242:	1602                	slli	a2,a2,0x20
 244:	9201                	srli	a2,a2,0x20
 246:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 24a:	872a                	mv	a4,a0
            *dst++ = *src++;
 24c:	0585                	addi	a1,a1,1
 24e:	0705                	addi	a4,a4,1
 250:	fff5c683          	lbu	a3,-1(a1)
 254:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 258:	fef71ae3          	bne	a4,a5,24c <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 25c:	6422                	ld	s0,8(sp)
 25e:	0141                	addi	sp,sp,16
 260:	8082                	ret
        dst += n;
 262:	00c50733          	add	a4,a0,a2
        src += n;
 266:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 268:	fec05ae3          	blez	a2,25c <memmove+0x28>
 26c:	fff6079b          	addiw	a5,a2,-1
 270:	1782                	slli	a5,a5,0x20
 272:	9381                	srli	a5,a5,0x20
 274:	fff7c793          	not	a5,a5
 278:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 27a:	15fd                	addi	a1,a1,-1
 27c:	177d                	addi	a4,a4,-1
 27e:	0005c683          	lbu	a3,0(a1)
 282:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 286:	fee79ae3          	bne	a5,a4,27a <memmove+0x46>
 28a:	bfc9                	j	25c <memmove+0x28>

000000000000028c <memcmp>:

int memcmp(const void *s1, const void *s2, uint n) {
 28c:	1141                	addi	sp,sp,-16
 28e:	e422                	sd	s0,8(sp)
 290:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0) {
 292:	ca05                	beqz	a2,2c2 <memcmp+0x36>
 294:	fff6069b          	addiw	a3,a2,-1
 298:	1682                	slli	a3,a3,0x20
 29a:	9281                	srli	a3,a3,0x20
 29c:	0685                	addi	a3,a3,1
 29e:	96aa                	add	a3,a3,a0
        if (*p1 != *p2) {
 2a0:	00054783          	lbu	a5,0(a0)
 2a4:	0005c703          	lbu	a4,0(a1)
 2a8:	00e79863          	bne	a5,a4,2b8 <memcmp+0x2c>
            return *p1 - *p2;
        }
        p1++;
 2ac:	0505                	addi	a0,a0,1
        p2++;
 2ae:	0585                	addi	a1,a1,1
    while (n-- > 0) {
 2b0:	fed518e3          	bne	a0,a3,2a0 <memcmp+0x14>
    }
    return 0;
 2b4:	4501                	li	a0,0
 2b6:	a019                	j	2bc <memcmp+0x30>
            return *p1 - *p2;
 2b8:	40e7853b          	subw	a0,a5,a4
}
 2bc:	6422                	ld	s0,8(sp)
 2be:	0141                	addi	sp,sp,16
 2c0:	8082                	ret
    return 0;
 2c2:	4501                	li	a0,0
 2c4:	bfe5                	j	2bc <memcmp+0x30>

00000000000002c6 <memcpy>:

void *memcpy(void *dst, const void *src, uint n) {
 2c6:	1141                	addi	sp,sp,-16
 2c8:	e406                	sd	ra,8(sp)
 2ca:	e022                	sd	s0,0(sp)
 2cc:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 2ce:	00000097          	auipc	ra,0x0
 2d2:	f66080e7          	jalr	-154(ra) # 234 <memmove>
}
 2d6:	60a2                	ld	ra,8(sp)
 2d8:	6402                	ld	s0,0(sp)
 2da:	0141                	addi	sp,sp,16
 2dc:	8082                	ret

00000000000002de <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2de:	4885                	li	a7,1
 ecall
 2e0:	00000073          	ecall
 ret
 2e4:	8082                	ret

00000000000002e6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2e6:	4889                	li	a7,2
 ecall
 2e8:	00000073          	ecall
 ret
 2ec:	8082                	ret

00000000000002ee <wait>:
.global wait
wait:
 li a7, SYS_wait
 2ee:	488d                	li	a7,3
 ecall
 2f0:	00000073          	ecall
 ret
 2f4:	8082                	ret

00000000000002f6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2f6:	4891                	li	a7,4
 ecall
 2f8:	00000073          	ecall
 ret
 2fc:	8082                	ret

00000000000002fe <read>:
.global read
read:
 li a7, SYS_read
 2fe:	4895                	li	a7,5
 ecall
 300:	00000073          	ecall
 ret
 304:	8082                	ret

0000000000000306 <write>:
.global write
write:
 li a7, SYS_write
 306:	48c1                	li	a7,16
 ecall
 308:	00000073          	ecall
 ret
 30c:	8082                	ret

000000000000030e <close>:
.global close
close:
 li a7, SYS_close
 30e:	48d5                	li	a7,21
 ecall
 310:	00000073          	ecall
 ret
 314:	8082                	ret

0000000000000316 <kill>:
.global kill
kill:
 li a7, SYS_kill
 316:	4899                	li	a7,6
 ecall
 318:	00000073          	ecall
 ret
 31c:	8082                	ret

000000000000031e <exec>:
.global exec
exec:
 li a7, SYS_exec
 31e:	489d                	li	a7,7
 ecall
 320:	00000073          	ecall
 ret
 324:	8082                	ret

0000000000000326 <open>:
.global open
open:
 li a7, SYS_open
 326:	48bd                	li	a7,15
 ecall
 328:	00000073          	ecall
 ret
 32c:	8082                	ret

000000000000032e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 32e:	48c5                	li	a7,17
 ecall
 330:	00000073          	ecall
 ret
 334:	8082                	ret

0000000000000336 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 336:	48c9                	li	a7,18
 ecall
 338:	00000073          	ecall
 ret
 33c:	8082                	ret

000000000000033e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 33e:	48a1                	li	a7,8
 ecall
 340:	00000073          	ecall
 ret
 344:	8082                	ret

0000000000000346 <link>:
.global link
link:
 li a7, SYS_link
 346:	48cd                	li	a7,19
 ecall
 348:	00000073          	ecall
 ret
 34c:	8082                	ret

000000000000034e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 34e:	48d1                	li	a7,20
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 356:	48a5                	li	a7,9
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <dup>:
.global dup
dup:
 li a7, SYS_dup
 35e:	48a9                	li	a7,10
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 366:	48ad                	li	a7,11
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 36e:	48b1                	li	a7,12
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 376:	48b5                	li	a7,13
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 37e:	48b9                	li	a7,14
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <trace>:
.global trace
trace:
 li a7, SYS_trace
 386:	48d9                	li	a7,22
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 38e:	48dd                	li	a7,23
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <putc>:

#include <stdarg.h>

static char digits[] = "0123456789ABCDEF";

static void putc(int fd, char c) { write(fd, &c, 1); }
 396:	1101                	addi	sp,sp,-32
 398:	ec06                	sd	ra,24(sp)
 39a:	e822                	sd	s0,16(sp)
 39c:	1000                	addi	s0,sp,32
 39e:	feb407a3          	sb	a1,-17(s0)
 3a2:	4605                	li	a2,1
 3a4:	fef40593          	addi	a1,s0,-17
 3a8:	00000097          	auipc	ra,0x0
 3ac:	f5e080e7          	jalr	-162(ra) # 306 <write>
 3b0:	60e2                	ld	ra,24(sp)
 3b2:	6442                	ld	s0,16(sp)
 3b4:	6105                	addi	sp,sp,32
 3b6:	8082                	ret

00000000000003b8 <printint>:

static void printint(int fd, int xx, int base, int sgn) {
 3b8:	7139                	addi	sp,sp,-64
 3ba:	fc06                	sd	ra,56(sp)
 3bc:	f822                	sd	s0,48(sp)
 3be:	f426                	sd	s1,40(sp)
 3c0:	0080                	addi	s0,sp,64
 3c2:	84aa                	mv	s1,a0
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if (sgn && xx < 0) {
 3c4:	c299                	beqz	a3,3ca <printint+0x12>
 3c6:	0805cb63          	bltz	a1,45c <printint+0xa4>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
 3ca:	2581                	sext.w	a1,a1
    neg = 0;
 3cc:	4881                	li	a7,0
 3ce:	fc040693          	addi	a3,s0,-64
    }

    i = 0;
 3d2:	4701                	li	a4,0
    do {
        buf[i++] = digits[x % base];
 3d4:	2601                	sext.w	a2,a2
 3d6:	00000517          	auipc	a0,0x0
 3da:	4da50513          	addi	a0,a0,1242 # 8b0 <digits>
 3de:	883a                	mv	a6,a4
 3e0:	2705                	addiw	a4,a4,1
 3e2:	02c5f7bb          	remuw	a5,a1,a2
 3e6:	1782                	slli	a5,a5,0x20
 3e8:	9381                	srli	a5,a5,0x20
 3ea:	97aa                	add	a5,a5,a0
 3ec:	0007c783          	lbu	a5,0(a5)
 3f0:	00f68023          	sb	a5,0(a3)
    } while ((x /= base) != 0);
 3f4:	0005879b          	sext.w	a5,a1
 3f8:	02c5d5bb          	divuw	a1,a1,a2
 3fc:	0685                	addi	a3,a3,1
 3fe:	fec7f0e3          	bgeu	a5,a2,3de <printint+0x26>
    if (neg)
 402:	00088c63          	beqz	a7,41a <printint+0x62>
        buf[i++] = '-';
 406:	fd070793          	addi	a5,a4,-48
 40a:	00878733          	add	a4,a5,s0
 40e:	02d00793          	li	a5,45
 412:	fef70823          	sb	a5,-16(a4)
 416:	0028071b          	addiw	a4,a6,2

    while (--i >= 0)
 41a:	02e05c63          	blez	a4,452 <printint+0x9a>
 41e:	f04a                	sd	s2,32(sp)
 420:	ec4e                	sd	s3,24(sp)
 422:	fc040793          	addi	a5,s0,-64
 426:	00e78933          	add	s2,a5,a4
 42a:	fff78993          	addi	s3,a5,-1
 42e:	99ba                	add	s3,s3,a4
 430:	377d                	addiw	a4,a4,-1
 432:	1702                	slli	a4,a4,0x20
 434:	9301                	srli	a4,a4,0x20
 436:	40e989b3          	sub	s3,s3,a4
        putc(fd, buf[i]);
 43a:	fff94583          	lbu	a1,-1(s2)
 43e:	8526                	mv	a0,s1
 440:	00000097          	auipc	ra,0x0
 444:	f56080e7          	jalr	-170(ra) # 396 <putc>
    while (--i >= 0)
 448:	197d                	addi	s2,s2,-1
 44a:	ff3918e3          	bne	s2,s3,43a <printint+0x82>
 44e:	7902                	ld	s2,32(sp)
 450:	69e2                	ld	s3,24(sp)
}
 452:	70e2                	ld	ra,56(sp)
 454:	7442                	ld	s0,48(sp)
 456:	74a2                	ld	s1,40(sp)
 458:	6121                	addi	sp,sp,64
 45a:	8082                	ret
        x = -xx;
 45c:	40b005bb          	negw	a1,a1
        neg = 1;
 460:	4885                	li	a7,1
        x = -xx;
 462:	b7b5                	j	3ce <printint+0x16>

0000000000000464 <vprintf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void vprintf(int fd, const char *fmt, va_list ap) {
 464:	715d                	addi	sp,sp,-80
 466:	e486                	sd	ra,72(sp)
 468:	e0a2                	sd	s0,64(sp)
 46a:	f84a                	sd	s2,48(sp)
 46c:	0880                	addi	s0,sp,80
    char *s;
    int c, i, state;

    state = 0;
    for (i = 0; fmt[i]; i++) {
 46e:	0005c903          	lbu	s2,0(a1)
 472:	1a090a63          	beqz	s2,626 <vprintf+0x1c2>
 476:	fc26                	sd	s1,56(sp)
 478:	f44e                	sd	s3,40(sp)
 47a:	f052                	sd	s4,32(sp)
 47c:	ec56                	sd	s5,24(sp)
 47e:	e85a                	sd	s6,16(sp)
 480:	e45e                	sd	s7,8(sp)
 482:	8aaa                	mv	s5,a0
 484:	8bb2                	mv	s7,a2
 486:	00158493          	addi	s1,a1,1
    state = 0;
 48a:	4981                	li	s3,0
            if (c == '%') {
                state = '%';
            } else {
                putc(fd, c);
            }
        } else if (state == '%') {
 48c:	02500a13          	li	s4,37
 490:	4b55                	li	s6,21
 492:	a839                	j	4b0 <vprintf+0x4c>
                putc(fd, c);
 494:	85ca                	mv	a1,s2
 496:	8556                	mv	a0,s5
 498:	00000097          	auipc	ra,0x0
 49c:	efe080e7          	jalr	-258(ra) # 396 <putc>
 4a0:	a019                	j	4a6 <vprintf+0x42>
        } else if (state == '%') {
 4a2:	01498d63          	beq	s3,s4,4bc <vprintf+0x58>
    for (i = 0; fmt[i]; i++) {
 4a6:	0485                	addi	s1,s1,1
 4a8:	fff4c903          	lbu	s2,-1(s1)
 4ac:	16090763          	beqz	s2,61a <vprintf+0x1b6>
        if (state == 0) {
 4b0:	fe0999e3          	bnez	s3,4a2 <vprintf+0x3e>
            if (c == '%') {
 4b4:	ff4910e3          	bne	s2,s4,494 <vprintf+0x30>
                state = '%';
 4b8:	89d2                	mv	s3,s4
 4ba:	b7f5                	j	4a6 <vprintf+0x42>
            if (c == 'd') {
 4bc:	13490463          	beq	s2,s4,5e4 <vprintf+0x180>
 4c0:	f9d9079b          	addiw	a5,s2,-99
 4c4:	0ff7f793          	zext.b	a5,a5
 4c8:	12fb6763          	bltu	s6,a5,5f6 <vprintf+0x192>
 4cc:	f9d9079b          	addiw	a5,s2,-99
 4d0:	0ff7f713          	zext.b	a4,a5
 4d4:	12eb6163          	bltu	s6,a4,5f6 <vprintf+0x192>
 4d8:	00271793          	slli	a5,a4,0x2
 4dc:	00000717          	auipc	a4,0x0
 4e0:	37c70713          	addi	a4,a4,892 # 858 <malloc+0x142>
 4e4:	97ba                	add	a5,a5,a4
 4e6:	439c                	lw	a5,0(a5)
 4e8:	97ba                	add	a5,a5,a4
 4ea:	8782                	jr	a5
                printint(fd, va_arg(ap, int), 10, 1);
 4ec:	008b8913          	addi	s2,s7,8
 4f0:	4685                	li	a3,1
 4f2:	4629                	li	a2,10
 4f4:	000ba583          	lw	a1,0(s7)
 4f8:	8556                	mv	a0,s5
 4fa:	00000097          	auipc	ra,0x0
 4fe:	ebe080e7          	jalr	-322(ra) # 3b8 <printint>
 502:	8bca                	mv	s7,s2
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
                putc(fd, c);
            }
            state = 0;
 504:	4981                	li	s3,0
 506:	b745                	j	4a6 <vprintf+0x42>
                printint(fd, va_arg(ap, uint64), 10, 0);
 508:	008b8913          	addi	s2,s7,8
 50c:	4681                	li	a3,0
 50e:	4629                	li	a2,10
 510:	000ba583          	lw	a1,0(s7)
 514:	8556                	mv	a0,s5
 516:	00000097          	auipc	ra,0x0
 51a:	ea2080e7          	jalr	-350(ra) # 3b8 <printint>
 51e:	8bca                	mv	s7,s2
            state = 0;
 520:	4981                	li	s3,0
 522:	b751                	j	4a6 <vprintf+0x42>
                printint(fd, va_arg(ap, int), 16, 0);
 524:	008b8913          	addi	s2,s7,8
 528:	4681                	li	a3,0
 52a:	4641                	li	a2,16
 52c:	000ba583          	lw	a1,0(s7)
 530:	8556                	mv	a0,s5
 532:	00000097          	auipc	ra,0x0
 536:	e86080e7          	jalr	-378(ra) # 3b8 <printint>
 53a:	8bca                	mv	s7,s2
            state = 0;
 53c:	4981                	li	s3,0
 53e:	b7a5                	j	4a6 <vprintf+0x42>
 540:	e062                	sd	s8,0(sp)
                printptr(fd, va_arg(ap, uint64));
 542:	008b8c13          	addi	s8,s7,8
 546:	000bb983          	ld	s3,0(s7)
    putc(fd, '0');
 54a:	03000593          	li	a1,48
 54e:	8556                	mv	a0,s5
 550:	00000097          	auipc	ra,0x0
 554:	e46080e7          	jalr	-442(ra) # 396 <putc>
    putc(fd, 'x');
 558:	07800593          	li	a1,120
 55c:	8556                	mv	a0,s5
 55e:	00000097          	auipc	ra,0x0
 562:	e38080e7          	jalr	-456(ra) # 396 <putc>
 566:	4941                	li	s2,16
        putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 568:	00000b97          	auipc	s7,0x0
 56c:	348b8b93          	addi	s7,s7,840 # 8b0 <digits>
 570:	03c9d793          	srli	a5,s3,0x3c
 574:	97de                	add	a5,a5,s7
 576:	0007c583          	lbu	a1,0(a5)
 57a:	8556                	mv	a0,s5
 57c:	00000097          	auipc	ra,0x0
 580:	e1a080e7          	jalr	-486(ra) # 396 <putc>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 584:	0992                	slli	s3,s3,0x4
 586:	397d                	addiw	s2,s2,-1
 588:	fe0914e3          	bnez	s2,570 <vprintf+0x10c>
                printptr(fd, va_arg(ap, uint64));
 58c:	8be2                	mv	s7,s8
            state = 0;
 58e:	4981                	li	s3,0
 590:	6c02                	ld	s8,0(sp)
 592:	bf11                	j	4a6 <vprintf+0x42>
                s = va_arg(ap, char *);
 594:	008b8993          	addi	s3,s7,8
 598:	000bb903          	ld	s2,0(s7)
                if (s == 0)
 59c:	02090163          	beqz	s2,5be <vprintf+0x15a>
                while (*s != 0) {
 5a0:	00094583          	lbu	a1,0(s2)
 5a4:	c9a5                	beqz	a1,614 <vprintf+0x1b0>
                    putc(fd, *s);
 5a6:	8556                	mv	a0,s5
 5a8:	00000097          	auipc	ra,0x0
 5ac:	dee080e7          	jalr	-530(ra) # 396 <putc>
                    s++;
 5b0:	0905                	addi	s2,s2,1
                while (*s != 0) {
 5b2:	00094583          	lbu	a1,0(s2)
 5b6:	f9e5                	bnez	a1,5a6 <vprintf+0x142>
                s = va_arg(ap, char *);
 5b8:	8bce                	mv	s7,s3
            state = 0;
 5ba:	4981                	li	s3,0
 5bc:	b5ed                	j	4a6 <vprintf+0x42>
                    s = "(null)";
 5be:	00000917          	auipc	s2,0x0
 5c2:	29290913          	addi	s2,s2,658 # 850 <malloc+0x13a>
                while (*s != 0) {
 5c6:	02800593          	li	a1,40
 5ca:	bff1                	j	5a6 <vprintf+0x142>
                putc(fd, va_arg(ap, uint));
 5cc:	008b8913          	addi	s2,s7,8
 5d0:	000bc583          	lbu	a1,0(s7)
 5d4:	8556                	mv	a0,s5
 5d6:	00000097          	auipc	ra,0x0
 5da:	dc0080e7          	jalr	-576(ra) # 396 <putc>
 5de:	8bca                	mv	s7,s2
            state = 0;
 5e0:	4981                	li	s3,0
 5e2:	b5d1                	j	4a6 <vprintf+0x42>
                putc(fd, c);
 5e4:	02500593          	li	a1,37
 5e8:	8556                	mv	a0,s5
 5ea:	00000097          	auipc	ra,0x0
 5ee:	dac080e7          	jalr	-596(ra) # 396 <putc>
            state = 0;
 5f2:	4981                	li	s3,0
 5f4:	bd4d                	j	4a6 <vprintf+0x42>
                putc(fd, '%');
 5f6:	02500593          	li	a1,37
 5fa:	8556                	mv	a0,s5
 5fc:	00000097          	auipc	ra,0x0
 600:	d9a080e7          	jalr	-614(ra) # 396 <putc>
                putc(fd, c);
 604:	85ca                	mv	a1,s2
 606:	8556                	mv	a0,s5
 608:	00000097          	auipc	ra,0x0
 60c:	d8e080e7          	jalr	-626(ra) # 396 <putc>
            state = 0;
 610:	4981                	li	s3,0
 612:	bd51                	j	4a6 <vprintf+0x42>
                s = va_arg(ap, char *);
 614:	8bce                	mv	s7,s3
            state = 0;
 616:	4981                	li	s3,0
 618:	b579                	j	4a6 <vprintf+0x42>
 61a:	74e2                	ld	s1,56(sp)
 61c:	79a2                	ld	s3,40(sp)
 61e:	7a02                	ld	s4,32(sp)
 620:	6ae2                	ld	s5,24(sp)
 622:	6b42                	ld	s6,16(sp)
 624:	6ba2                	ld	s7,8(sp)
        }
    }
}
 626:	60a6                	ld	ra,72(sp)
 628:	6406                	ld	s0,64(sp)
 62a:	7942                	ld	s2,48(sp)
 62c:	6161                	addi	sp,sp,80
 62e:	8082                	ret

0000000000000630 <fprintf>:

void fprintf(int fd, const char *fmt, ...) {
 630:	715d                	addi	sp,sp,-80
 632:	ec06                	sd	ra,24(sp)
 634:	e822                	sd	s0,16(sp)
 636:	1000                	addi	s0,sp,32
 638:	e010                	sd	a2,0(s0)
 63a:	e414                	sd	a3,8(s0)
 63c:	e818                	sd	a4,16(s0)
 63e:	ec1c                	sd	a5,24(s0)
 640:	03043023          	sd	a6,32(s0)
 644:	03143423          	sd	a7,40(s0)
    va_list ap;

    va_start(ap, fmt);
 648:	fe843423          	sd	s0,-24(s0)
    vprintf(fd, fmt, ap);
 64c:	8622                	mv	a2,s0
 64e:	00000097          	auipc	ra,0x0
 652:	e16080e7          	jalr	-490(ra) # 464 <vprintf>
}
 656:	60e2                	ld	ra,24(sp)
 658:	6442                	ld	s0,16(sp)
 65a:	6161                	addi	sp,sp,80
 65c:	8082                	ret

000000000000065e <printf>:

void printf(const char *fmt, ...) {
 65e:	711d                	addi	sp,sp,-96
 660:	ec06                	sd	ra,24(sp)
 662:	e822                	sd	s0,16(sp)
 664:	1000                	addi	s0,sp,32
 666:	e40c                	sd	a1,8(s0)
 668:	e810                	sd	a2,16(s0)
 66a:	ec14                	sd	a3,24(s0)
 66c:	f018                	sd	a4,32(s0)
 66e:	f41c                	sd	a5,40(s0)
 670:	03043823          	sd	a6,48(s0)
 674:	03143c23          	sd	a7,56(s0)
    va_list ap;

    va_start(ap, fmt);
 678:	00840613          	addi	a2,s0,8
 67c:	fec43423          	sd	a2,-24(s0)
    vprintf(1, fmt, ap);
 680:	85aa                	mv	a1,a0
 682:	4505                	li	a0,1
 684:	00000097          	auipc	ra,0x0
 688:	de0080e7          	jalr	-544(ra) # 464 <vprintf>
}
 68c:	60e2                	ld	ra,24(sp)
 68e:	6442                	ld	s0,16(sp)
 690:	6125                	addi	sp,sp,96
 692:	8082                	ret

0000000000000694 <free>:
typedef union header Header;

static Header base;
static Header *freep;

void free(void *ap) {
 694:	1141                	addi	sp,sp,-16
 696:	e422                	sd	s0,8(sp)
 698:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 69a:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 69e:	00000797          	auipc	a5,0x0
 6a2:	5ea7b783          	ld	a5,1514(a5) # c88 <freep>
 6a6:	a02d                	j	6d0 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr) {
        bp->s.size += p->s.ptr->s.size;
 6a8:	4618                	lw	a4,8(a2)
 6aa:	9f2d                	addw	a4,a4,a1
 6ac:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 6b0:	6398                	ld	a4,0(a5)
 6b2:	6310                	ld	a2,0(a4)
 6b4:	a83d                	j	6f2 <free+0x5e>
    } else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp) {
        p->s.size += bp->s.size;
 6b6:	ff852703          	lw	a4,-8(a0)
 6ba:	9f31                	addw	a4,a4,a2
 6bc:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 6be:	ff053683          	ld	a3,-16(a0)
 6c2:	a091                	j	706 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c4:	6398                	ld	a4,0(a5)
 6c6:	00e7e463          	bltu	a5,a4,6ce <free+0x3a>
 6ca:	00e6ea63          	bltu	a3,a4,6de <free+0x4a>
void free(void *ap) {
 6ce:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d0:	fed7fae3          	bgeu	a5,a3,6c4 <free+0x30>
 6d4:	6398                	ld	a4,0(a5)
 6d6:	00e6e463          	bltu	a3,a4,6de <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6da:	fee7eae3          	bltu	a5,a4,6ce <free+0x3a>
    if (bp + bp->s.size == p->s.ptr) {
 6de:	ff852583          	lw	a1,-8(a0)
 6e2:	6390                	ld	a2,0(a5)
 6e4:	02059813          	slli	a6,a1,0x20
 6e8:	01c85713          	srli	a4,a6,0x1c
 6ec:	9736                	add	a4,a4,a3
 6ee:	fae60de3          	beq	a2,a4,6a8 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 6f2:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp) {
 6f6:	4790                	lw	a2,8(a5)
 6f8:	02061593          	slli	a1,a2,0x20
 6fc:	01c5d713          	srli	a4,a1,0x1c
 700:	973e                	add	a4,a4,a5
 702:	fae68ae3          	beq	a3,a4,6b6 <free+0x22>
        p->s.ptr = bp->s.ptr;
 706:	e394                	sd	a3,0(a5)
    } else
        p->s.ptr = bp;
    freep = p;
 708:	00000717          	auipc	a4,0x0
 70c:	58f73023          	sd	a5,1408(a4) # c88 <freep>
}
 710:	6422                	ld	s0,8(sp)
 712:	0141                	addi	sp,sp,16
 714:	8082                	ret

0000000000000716 <malloc>:
    hp->s.size = nu;
    free((void *)(hp + 1));
    return freep;
}

void *malloc(uint nbytes) {
 716:	7139                	addi	sp,sp,-64
 718:	fc06                	sd	ra,56(sp)
 71a:	f822                	sd	s0,48(sp)
 71c:	f426                	sd	s1,40(sp)
 71e:	ec4e                	sd	s3,24(sp)
 720:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 722:	02051493          	slli	s1,a0,0x20
 726:	9081                	srli	s1,s1,0x20
 728:	04bd                	addi	s1,s1,15
 72a:	8091                	srli	s1,s1,0x4
 72c:	0014899b          	addiw	s3,s1,1
 730:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0) {
 732:	00000517          	auipc	a0,0x0
 736:	55653503          	ld	a0,1366(a0) # c88 <freep>
 73a:	c915                	beqz	a0,76e <malloc+0x58>
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 73c:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits) {
 73e:	4798                	lw	a4,8(a5)
 740:	08977e63          	bgeu	a4,s1,7dc <malloc+0xc6>
 744:	f04a                	sd	s2,32(sp)
 746:	e852                	sd	s4,16(sp)
 748:	e456                	sd	s5,8(sp)
 74a:	e05a                	sd	s6,0(sp)
    if (nu < 4096)
 74c:	8a4e                	mv	s4,s3
 74e:	0009871b          	sext.w	a4,s3
 752:	6685                	lui	a3,0x1
 754:	00d77363          	bgeu	a4,a3,75a <malloc+0x44>
 758:	6a05                	lui	s4,0x1
 75a:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 75e:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 762:	00000917          	auipc	s2,0x0
 766:	52690913          	addi	s2,s2,1318 # c88 <freep>
    if (p == (char *)-1)
 76a:	5afd                	li	s5,-1
 76c:	a091                	j	7b0 <malloc+0x9a>
 76e:	f04a                	sd	s2,32(sp)
 770:	e852                	sd	s4,16(sp)
 772:	e456                	sd	s5,8(sp)
 774:	e05a                	sd	s6,0(sp)
        base.s.ptr = freep = prevp = &base;
 776:	00000797          	auipc	a5,0x0
 77a:	51a78793          	addi	a5,a5,1306 # c90 <base>
 77e:	00000717          	auipc	a4,0x0
 782:	50f73523          	sd	a5,1290(a4) # c88 <freep>
 786:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 788:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits) {
 78c:	b7c1                	j	74c <malloc+0x36>
                prevp->s.ptr = p->s.ptr;
 78e:	6398                	ld	a4,0(a5)
 790:	e118                	sd	a4,0(a0)
 792:	a08d                	j	7f4 <malloc+0xde>
    hp->s.size = nu;
 794:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 798:	0541                	addi	a0,a0,16
 79a:	00000097          	auipc	ra,0x0
 79e:	efa080e7          	jalr	-262(ra) # 694 <free>
    return freep;
 7a2:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 7a6:	c13d                	beqz	a0,80c <malloc+0xf6>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 7a8:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits) {
 7aa:	4798                	lw	a4,8(a5)
 7ac:	02977463          	bgeu	a4,s1,7d4 <malloc+0xbe>
        if (p == freep)
 7b0:	00093703          	ld	a4,0(s2)
 7b4:	853e                	mv	a0,a5
 7b6:	fef719e3          	bne	a4,a5,7a8 <malloc+0x92>
    p = sbrk(nu * sizeof(Header));
 7ba:	8552                	mv	a0,s4
 7bc:	00000097          	auipc	ra,0x0
 7c0:	bb2080e7          	jalr	-1102(ra) # 36e <sbrk>
    if (p == (char *)-1)
 7c4:	fd5518e3          	bne	a0,s5,794 <malloc+0x7e>
                return 0;
 7c8:	4501                	li	a0,0
 7ca:	7902                	ld	s2,32(sp)
 7cc:	6a42                	ld	s4,16(sp)
 7ce:	6aa2                	ld	s5,8(sp)
 7d0:	6b02                	ld	s6,0(sp)
 7d2:	a03d                	j	800 <malloc+0xea>
 7d4:	7902                	ld	s2,32(sp)
 7d6:	6a42                	ld	s4,16(sp)
 7d8:	6aa2                	ld	s5,8(sp)
 7da:	6b02                	ld	s6,0(sp)
            if (p->s.size == nunits)
 7dc:	fae489e3          	beq	s1,a4,78e <malloc+0x78>
                p->s.size -= nunits;
 7e0:	4137073b          	subw	a4,a4,s3
 7e4:	c798                	sw	a4,8(a5)
                p += p->s.size;
 7e6:	02071693          	slli	a3,a4,0x20
 7ea:	01c6d713          	srli	a4,a3,0x1c
 7ee:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 7f0:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 7f4:	00000717          	auipc	a4,0x0
 7f8:	48a73a23          	sd	a0,1172(a4) # c88 <freep>
            return (void *)(p + 1);
 7fc:	01078513          	addi	a0,a5,16
    }
}
 800:	70e2                	ld	ra,56(sp)
 802:	7442                	ld	s0,48(sp)
 804:	74a2                	ld	s1,40(sp)
 806:	69e2                	ld	s3,24(sp)
 808:	6121                	addi	sp,sp,64
 80a:	8082                	ret
 80c:	7902                	ld	s2,32(sp)
 80e:	6a42                	ld	s4,16(sp)
 810:	6aa2                	ld	s5,8(sp)
 812:	6b02                	ld	s6,0(sp)
 814:	b7f5                	j	800 <malloc+0xea>
