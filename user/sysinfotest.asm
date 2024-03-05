
user/_sysinfotest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <sinfo>:
#include "kernel/types.h"
#include "kernel/riscv.h"
#include "kernel/sysinfo.h"
#include "user/user.h"

void sinfo(struct sysinfo *info) {
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
    if (sysinfo(info) < 0) {
   8:	00000097          	auipc	ra,0x0
   c:	656080e7          	jalr	1622(ra) # 65e <sysinfo>
  10:	00054663          	bltz	a0,1c <sinfo+0x1c>
        printf("FAIL: sysinfo failed");
        exit(1);
    }
}
  14:	60a2                	ld	ra,8(sp)
  16:	6402                	ld	s0,0(sp)
  18:	0141                	addi	sp,sp,16
  1a:	8082                	ret
        printf("FAIL: sysinfo failed");
  1c:	00001517          	auipc	a0,0x1
  20:	acc50513          	addi	a0,a0,-1332 # ae8 <malloc+0x102>
  24:	00001097          	auipc	ra,0x1
  28:	90a080e7          	jalr	-1782(ra) # 92e <printf>
        exit(1);
  2c:	4505                	li	a0,1
  2e:	00000097          	auipc	ra,0x0
  32:	588080e7          	jalr	1416(ra) # 5b6 <exit>

0000000000000036 <countfree>:

//
// use sbrk() to count how many free physical memory pages there are.
//
int countfree() {
  36:	7139                	addi	sp,sp,-64
  38:	fc06                	sd	ra,56(sp)
  3a:	f822                	sd	s0,48(sp)
  3c:	f426                	sd	s1,40(sp)
  3e:	f04a                	sd	s2,32(sp)
  40:	ec4e                	sd	s3,24(sp)
  42:	e852                	sd	s4,16(sp)
  44:	0080                	addi	s0,sp,64
    uint64 sz0 = (uint64)sbrk(0);
  46:	4501                	li	a0,0
  48:	00000097          	auipc	ra,0x0
  4c:	5f6080e7          	jalr	1526(ra) # 63e <sbrk>
  50:	8a2a                	mv	s4,a0
    struct sysinfo info;
    int n = 0;
  52:	4481                	li	s1,0

    while (1) {
        if ((uint64)sbrk(PGSIZE) == 0xffffffffffffffff) {
  54:	597d                	li	s2,-1
            break;
        }
        n += PGSIZE;
  56:	6985                	lui	s3,0x1
  58:	a019                	j	5e <countfree+0x28>
  5a:	009984bb          	addw	s1,s3,s1
        if ((uint64)sbrk(PGSIZE) == 0xffffffffffffffff) {
  5e:	6505                	lui	a0,0x1
  60:	00000097          	auipc	ra,0x0
  64:	5de080e7          	jalr	1502(ra) # 63e <sbrk>
  68:	ff2519e3          	bne	a0,s2,5a <countfree+0x24>
    }
    sinfo(&info);
  6c:	fc040513          	addi	a0,s0,-64
  70:	00000097          	auipc	ra,0x0
  74:	f90080e7          	jalr	-112(ra) # 0 <sinfo>
    if (info.freemem != 0) {
  78:	fc043583          	ld	a1,-64(s0)
  7c:	e58d                	bnez	a1,a6 <countfree+0x70>
        printf("FAIL: there is no free mem, but sysinfo.freemem=%d\n",
               info.freemem);
        exit(1);
    }
    sbrk(-((uint64)sbrk(0) - sz0));
  7e:	4501                	li	a0,0
  80:	00000097          	auipc	ra,0x0
  84:	5be080e7          	jalr	1470(ra) # 63e <sbrk>
  88:	40aa053b          	subw	a0,s4,a0
  8c:	00000097          	auipc	ra,0x0
  90:	5b2080e7          	jalr	1458(ra) # 63e <sbrk>
    return n;
}
  94:	8526                	mv	a0,s1
  96:	70e2                	ld	ra,56(sp)
  98:	7442                	ld	s0,48(sp)
  9a:	74a2                	ld	s1,40(sp)
  9c:	7902                	ld	s2,32(sp)
  9e:	69e2                	ld	s3,24(sp)
  a0:	6a42                	ld	s4,16(sp)
  a2:	6121                	addi	sp,sp,64
  a4:	8082                	ret
        printf("FAIL: there is no free mem, but sysinfo.freemem=%d\n",
  a6:	00001517          	auipc	a0,0x1
  aa:	a5a50513          	addi	a0,a0,-1446 # b00 <malloc+0x11a>
  ae:	00001097          	auipc	ra,0x1
  b2:	880080e7          	jalr	-1920(ra) # 92e <printf>
        exit(1);
  b6:	4505                	li	a0,1
  b8:	00000097          	auipc	ra,0x0
  bc:	4fe080e7          	jalr	1278(ra) # 5b6 <exit>

00000000000000c0 <testmem>:

void testmem() {
  c0:	7179                	addi	sp,sp,-48
  c2:	f406                	sd	ra,40(sp)
  c4:	f022                	sd	s0,32(sp)
  c6:	ec26                	sd	s1,24(sp)
  c8:	e84a                	sd	s2,16(sp)
  ca:	1800                	addi	s0,sp,48
    struct sysinfo info;
    uint64 n = countfree();
  cc:	00000097          	auipc	ra,0x0
  d0:	f6a080e7          	jalr	-150(ra) # 36 <countfree>
  d4:	84aa                	mv	s1,a0

    sinfo(&info);
  d6:	fd040513          	addi	a0,s0,-48
  da:	00000097          	auipc	ra,0x0
  de:	f26080e7          	jalr	-218(ra) # 0 <sinfo>

    if (info.freemem != n) {
  e2:	fd043583          	ld	a1,-48(s0)
  e6:	04959e63          	bne	a1,s1,142 <testmem+0x82>
        printf("FAIL: free mem %d (bytes) instead of %d\n", info.freemem, n);
        exit(1);
    }

    if ((uint64)sbrk(PGSIZE) == 0xffffffffffffffff) {
  ea:	6505                	lui	a0,0x1
  ec:	00000097          	auipc	ra,0x0
  f0:	552080e7          	jalr	1362(ra) # 63e <sbrk>
  f4:	57fd                	li	a5,-1
  f6:	06f50463          	beq	a0,a5,15e <testmem+0x9e>
        printf("sbrk failed");
        exit(1);
    }

    sinfo(&info);
  fa:	fd040513          	addi	a0,s0,-48
  fe:	00000097          	auipc	ra,0x0
 102:	f02080e7          	jalr	-254(ra) # 0 <sinfo>

    if (info.freemem != n - PGSIZE) {
 106:	fd043603          	ld	a2,-48(s0)
 10a:	75fd                	lui	a1,0xfffff
 10c:	95a6                	add	a1,a1,s1
 10e:	06b61563          	bne	a2,a1,178 <testmem+0xb8>
        printf("FAIL: free mem %d (bytes) instead of %d\n", n - PGSIZE,
               info.freemem);
        exit(1);
    }

    if ((uint64)sbrk(-PGSIZE) == 0xffffffffffffffff) {
 112:	757d                	lui	a0,0xfffff
 114:	00000097          	auipc	ra,0x0
 118:	52a080e7          	jalr	1322(ra) # 63e <sbrk>
 11c:	57fd                	li	a5,-1
 11e:	06f50a63          	beq	a0,a5,192 <testmem+0xd2>
        printf("sbrk failed");
        exit(1);
    }

    sinfo(&info);
 122:	fd040513          	addi	a0,s0,-48
 126:	00000097          	auipc	ra,0x0
 12a:	eda080e7          	jalr	-294(ra) # 0 <sinfo>

    if (info.freemem != n) {
 12e:	fd043603          	ld	a2,-48(s0)
 132:	06961d63          	bne	a2,s1,1ac <testmem+0xec>
        printf("FAIL: free mem %d (bytes) instead of %d\n", n, info.freemem);
        exit(1);
    }
}
 136:	70a2                	ld	ra,40(sp)
 138:	7402                	ld	s0,32(sp)
 13a:	64e2                	ld	s1,24(sp)
 13c:	6942                	ld	s2,16(sp)
 13e:	6145                	addi	sp,sp,48
 140:	8082                	ret
        printf("FAIL: free mem %d (bytes) instead of %d\n", info.freemem, n);
 142:	8626                	mv	a2,s1
 144:	00001517          	auipc	a0,0x1
 148:	9f450513          	addi	a0,a0,-1548 # b38 <malloc+0x152>
 14c:	00000097          	auipc	ra,0x0
 150:	7e2080e7          	jalr	2018(ra) # 92e <printf>
        exit(1);
 154:	4505                	li	a0,1
 156:	00000097          	auipc	ra,0x0
 15a:	460080e7          	jalr	1120(ra) # 5b6 <exit>
        printf("sbrk failed");
 15e:	00001517          	auipc	a0,0x1
 162:	a0a50513          	addi	a0,a0,-1526 # b68 <malloc+0x182>
 166:	00000097          	auipc	ra,0x0
 16a:	7c8080e7          	jalr	1992(ra) # 92e <printf>
        exit(1);
 16e:	4505                	li	a0,1
 170:	00000097          	auipc	ra,0x0
 174:	446080e7          	jalr	1094(ra) # 5b6 <exit>
        printf("FAIL: free mem %d (bytes) instead of %d\n", n - PGSIZE,
 178:	00001517          	auipc	a0,0x1
 17c:	9c050513          	addi	a0,a0,-1600 # b38 <malloc+0x152>
 180:	00000097          	auipc	ra,0x0
 184:	7ae080e7          	jalr	1966(ra) # 92e <printf>
        exit(1);
 188:	4505                	li	a0,1
 18a:	00000097          	auipc	ra,0x0
 18e:	42c080e7          	jalr	1068(ra) # 5b6 <exit>
        printf("sbrk failed");
 192:	00001517          	auipc	a0,0x1
 196:	9d650513          	addi	a0,a0,-1578 # b68 <malloc+0x182>
 19a:	00000097          	auipc	ra,0x0
 19e:	794080e7          	jalr	1940(ra) # 92e <printf>
        exit(1);
 1a2:	4505                	li	a0,1
 1a4:	00000097          	auipc	ra,0x0
 1a8:	412080e7          	jalr	1042(ra) # 5b6 <exit>
        printf("FAIL: free mem %d (bytes) instead of %d\n", n, info.freemem);
 1ac:	85a6                	mv	a1,s1
 1ae:	00001517          	auipc	a0,0x1
 1b2:	98a50513          	addi	a0,a0,-1654 # b38 <malloc+0x152>
 1b6:	00000097          	auipc	ra,0x0
 1ba:	778080e7          	jalr	1912(ra) # 92e <printf>
        exit(1);
 1be:	4505                	li	a0,1
 1c0:	00000097          	auipc	ra,0x0
 1c4:	3f6080e7          	jalr	1014(ra) # 5b6 <exit>

00000000000001c8 <testcall>:

void testcall() {
 1c8:	1101                	addi	sp,sp,-32
 1ca:	ec06                	sd	ra,24(sp)
 1cc:	e822                	sd	s0,16(sp)
 1ce:	1000                	addi	s0,sp,32
    struct sysinfo info;

    if (sysinfo(&info) < 0) {
 1d0:	fe040513          	addi	a0,s0,-32
 1d4:	00000097          	auipc	ra,0x0
 1d8:	48a080e7          	jalr	1162(ra) # 65e <sysinfo>
 1dc:	02054663          	bltz	a0,208 <testcall+0x40>
        printf("FAIL: sysinfo failed\n");
        exit(1);
    }

    if (sysinfo((struct sysinfo *)0xeaeb0b5b00002f5e) != 0xffffffffffffffff) {
 1e0:	eaeb1537          	lui	a0,0xeaeb1
 1e4:	b5b50513          	addi	a0,a0,-1189 # ffffffffeaeb0b5b <__global_pointer$+0xffffffffeaeaf1f7>
 1e8:	0552                	slli	a0,a0,0x14
 1ea:	050d                	addi	a0,a0,3
 1ec:	0532                	slli	a0,a0,0xc
 1ee:	f5e50513          	addi	a0,a0,-162
 1f2:	00000097          	auipc	ra,0x0
 1f6:	46c080e7          	jalr	1132(ra) # 65e <sysinfo>
 1fa:	57fd                	li	a5,-1
 1fc:	02f51363          	bne	a0,a5,222 <testcall+0x5a>
        printf("FAIL: sysinfo succeeded with bad argument\n");
        exit(1);
    }
}
 200:	60e2                	ld	ra,24(sp)
 202:	6442                	ld	s0,16(sp)
 204:	6105                	addi	sp,sp,32
 206:	8082                	ret
        printf("FAIL: sysinfo failed\n");
 208:	00001517          	auipc	a0,0x1
 20c:	97050513          	addi	a0,a0,-1680 # b78 <malloc+0x192>
 210:	00000097          	auipc	ra,0x0
 214:	71e080e7          	jalr	1822(ra) # 92e <printf>
        exit(1);
 218:	4505                	li	a0,1
 21a:	00000097          	auipc	ra,0x0
 21e:	39c080e7          	jalr	924(ra) # 5b6 <exit>
        printf("FAIL: sysinfo succeeded with bad argument\n");
 222:	00001517          	auipc	a0,0x1
 226:	96e50513          	addi	a0,a0,-1682 # b90 <malloc+0x1aa>
 22a:	00000097          	auipc	ra,0x0
 22e:	704080e7          	jalr	1796(ra) # 92e <printf>
        exit(1);
 232:	4505                	li	a0,1
 234:	00000097          	auipc	ra,0x0
 238:	382080e7          	jalr	898(ra) # 5b6 <exit>

000000000000023c <testproc>:

void testproc() {
 23c:	7139                	addi	sp,sp,-64
 23e:	fc06                	sd	ra,56(sp)
 240:	f822                	sd	s0,48(sp)
 242:	f426                	sd	s1,40(sp)
 244:	0080                	addi	s0,sp,64
    struct sysinfo info;
    uint64 nproc;
    int status;
    int pid;

    sinfo(&info);
 246:	fd040513          	addi	a0,s0,-48
 24a:	00000097          	auipc	ra,0x0
 24e:	db6080e7          	jalr	-586(ra) # 0 <sinfo>
    nproc = info.nproc;
 252:	fd843483          	ld	s1,-40(s0)

    pid = fork();
 256:	00000097          	auipc	ra,0x0
 25a:	358080e7          	jalr	856(ra) # 5ae <fork>
    if (pid < 0) {
 25e:	02054c63          	bltz	a0,296 <testproc+0x5a>
        printf("sysinfotest: fork failed\n");
        exit(1);
    }
    if (pid == 0) {
 262:	ed21                	bnez	a0,2ba <testproc+0x7e>
        sinfo(&info);
 264:	fd040513          	addi	a0,s0,-48
 268:	00000097          	auipc	ra,0x0
 26c:	d98080e7          	jalr	-616(ra) # 0 <sinfo>
        if (info.nproc != nproc + 1) {
 270:	fd843583          	ld	a1,-40(s0)
 274:	00148613          	addi	a2,s1,1
 278:	02c58c63          	beq	a1,a2,2b0 <testproc+0x74>
            printf("sysinfotest: FAIL nproc is %d instead of %d\n", info.nproc,
 27c:	00001517          	auipc	a0,0x1
 280:	96450513          	addi	a0,a0,-1692 # be0 <malloc+0x1fa>
 284:	00000097          	auipc	ra,0x0
 288:	6aa080e7          	jalr	1706(ra) # 92e <printf>
                   nproc + 1);
            exit(1);
 28c:	4505                	li	a0,1
 28e:	00000097          	auipc	ra,0x0
 292:	328080e7          	jalr	808(ra) # 5b6 <exit>
        printf("sysinfotest: fork failed\n");
 296:	00001517          	auipc	a0,0x1
 29a:	92a50513          	addi	a0,a0,-1750 # bc0 <malloc+0x1da>
 29e:	00000097          	auipc	ra,0x0
 2a2:	690080e7          	jalr	1680(ra) # 92e <printf>
        exit(1);
 2a6:	4505                	li	a0,1
 2a8:	00000097          	auipc	ra,0x0
 2ac:	30e080e7          	jalr	782(ra) # 5b6 <exit>
        }
        exit(0);
 2b0:	4501                	li	a0,0
 2b2:	00000097          	auipc	ra,0x0
 2b6:	304080e7          	jalr	772(ra) # 5b6 <exit>
    }
    wait(&status);
 2ba:	fcc40513          	addi	a0,s0,-52
 2be:	00000097          	auipc	ra,0x0
 2c2:	300080e7          	jalr	768(ra) # 5be <wait>
    sinfo(&info);
 2c6:	fd040513          	addi	a0,s0,-48
 2ca:	00000097          	auipc	ra,0x0
 2ce:	d36080e7          	jalr	-714(ra) # 0 <sinfo>
    if (info.nproc != nproc) {
 2d2:	fd843583          	ld	a1,-40(s0)
 2d6:	00959763          	bne	a1,s1,2e4 <testproc+0xa8>
        printf("sysinfotest: FAIL nproc is %d instead of %d\n", info.nproc,
               nproc);
        exit(1);
    }
}
 2da:	70e2                	ld	ra,56(sp)
 2dc:	7442                	ld	s0,48(sp)
 2de:	74a2                	ld	s1,40(sp)
 2e0:	6121                	addi	sp,sp,64
 2e2:	8082                	ret
        printf("sysinfotest: FAIL nproc is %d instead of %d\n", info.nproc,
 2e4:	8626                	mv	a2,s1
 2e6:	00001517          	auipc	a0,0x1
 2ea:	8fa50513          	addi	a0,a0,-1798 # be0 <malloc+0x1fa>
 2ee:	00000097          	auipc	ra,0x0
 2f2:	640080e7          	jalr	1600(ra) # 92e <printf>
        exit(1);
 2f6:	4505                	li	a0,1
 2f8:	00000097          	auipc	ra,0x0
 2fc:	2be080e7          	jalr	702(ra) # 5b6 <exit>

0000000000000300 <main>:

int main(int argc, char *argv[]) {
 300:	1141                	addi	sp,sp,-16
 302:	e406                	sd	ra,8(sp)
 304:	e022                	sd	s0,0(sp)
 306:	0800                	addi	s0,sp,16
    printf("sysinfotest: start\n");
 308:	00001517          	auipc	a0,0x1
 30c:	90850513          	addi	a0,a0,-1784 # c10 <malloc+0x22a>
 310:	00000097          	auipc	ra,0x0
 314:	61e080e7          	jalr	1566(ra) # 92e <printf>
    testcall();
 318:	00000097          	auipc	ra,0x0
 31c:	eb0080e7          	jalr	-336(ra) # 1c8 <testcall>
    testmem();
 320:	00000097          	auipc	ra,0x0
 324:	da0080e7          	jalr	-608(ra) # c0 <testmem>
    testproc();
 328:	00000097          	auipc	ra,0x0
 32c:	f14080e7          	jalr	-236(ra) # 23c <testproc>
    printf("sysinfotest: OK\n");
 330:	00001517          	auipc	a0,0x1
 334:	8f850513          	addi	a0,a0,-1800 # c28 <malloc+0x242>
 338:	00000097          	auipc	ra,0x0
 33c:	5f6080e7          	jalr	1526(ra) # 92e <printf>
    exit(0);
 340:	4501                	li	a0,0
 342:	00000097          	auipc	ra,0x0
 346:	274080e7          	jalr	628(ra) # 5b6 <exit>

000000000000034a <strcpy>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "user/user.h"

char *strcpy(char *s, const char *t) {
 34a:	1141                	addi	sp,sp,-16
 34c:	e422                	sd	s0,8(sp)
 34e:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
 350:	87aa                	mv	a5,a0
 352:	0585                	addi	a1,a1,1 # fffffffffffff001 <__global_pointer$+0xffffffffffffd69d>
 354:	0785                	addi	a5,a5,1
 356:	fff5c703          	lbu	a4,-1(a1)
 35a:	fee78fa3          	sb	a4,-1(a5)
 35e:	fb75                	bnez	a4,352 <strcpy+0x8>
        ;
    return os;
}
 360:	6422                	ld	s0,8(sp)
 362:	0141                	addi	sp,sp,16
 364:	8082                	ret

0000000000000366 <strcmp>:

int strcmp(const char *p, const char *q) {
 366:	1141                	addi	sp,sp,-16
 368:	e422                	sd	s0,8(sp)
 36a:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
 36c:	00054783          	lbu	a5,0(a0)
 370:	cb91                	beqz	a5,384 <strcmp+0x1e>
 372:	0005c703          	lbu	a4,0(a1)
 376:	00f71763          	bne	a4,a5,384 <strcmp+0x1e>
        p++, q++;
 37a:	0505                	addi	a0,a0,1
 37c:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
 37e:	00054783          	lbu	a5,0(a0)
 382:	fbe5                	bnez	a5,372 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
 384:	0005c503          	lbu	a0,0(a1)
}
 388:	40a7853b          	subw	a0,a5,a0
 38c:	6422                	ld	s0,8(sp)
 38e:	0141                	addi	sp,sp,16
 390:	8082                	ret

0000000000000392 <strlen>:

uint strlen(const char *s) {
 392:	1141                	addi	sp,sp,-16
 394:	e422                	sd	s0,8(sp)
 396:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
 398:	00054783          	lbu	a5,0(a0)
 39c:	cf91                	beqz	a5,3b8 <strlen+0x26>
 39e:	0505                	addi	a0,a0,1
 3a0:	87aa                	mv	a5,a0
 3a2:	86be                	mv	a3,a5
 3a4:	0785                	addi	a5,a5,1
 3a6:	fff7c703          	lbu	a4,-1(a5)
 3aa:	ff65                	bnez	a4,3a2 <strlen+0x10>
 3ac:	40a6853b          	subw	a0,a3,a0
 3b0:	2505                	addiw	a0,a0,1
        ;
    return n;
}
 3b2:	6422                	ld	s0,8(sp)
 3b4:	0141                	addi	sp,sp,16
 3b6:	8082                	ret
    for (n = 0; s[n]; n++)
 3b8:	4501                	li	a0,0
 3ba:	bfe5                	j	3b2 <strlen+0x20>

00000000000003bc <memset>:

void *memset(void *dst, int c, uint n) {
 3bc:	1141                	addi	sp,sp,-16
 3be:	e422                	sd	s0,8(sp)
 3c0:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++) {
 3c2:	ca19                	beqz	a2,3d8 <memset+0x1c>
 3c4:	87aa                	mv	a5,a0
 3c6:	1602                	slli	a2,a2,0x20
 3c8:	9201                	srli	a2,a2,0x20
 3ca:	00a60733          	add	a4,a2,a0
        cdst[i] = c;
 3ce:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++) {
 3d2:	0785                	addi	a5,a5,1
 3d4:	fee79de3          	bne	a5,a4,3ce <memset+0x12>
    }
    return dst;
}
 3d8:	6422                	ld	s0,8(sp)
 3da:	0141                	addi	sp,sp,16
 3dc:	8082                	ret

00000000000003de <strchr>:

char *strchr(const char *s, char c) {
 3de:	1141                	addi	sp,sp,-16
 3e0:	e422                	sd	s0,8(sp)
 3e2:	0800                	addi	s0,sp,16
    for (; *s; s++)
 3e4:	00054783          	lbu	a5,0(a0)
 3e8:	cb99                	beqz	a5,3fe <strchr+0x20>
        if (*s == c)
 3ea:	00f58763          	beq	a1,a5,3f8 <strchr+0x1a>
    for (; *s; s++)
 3ee:	0505                	addi	a0,a0,1
 3f0:	00054783          	lbu	a5,0(a0)
 3f4:	fbfd                	bnez	a5,3ea <strchr+0xc>
            return (char *)s;
    return 0;
 3f6:	4501                	li	a0,0
}
 3f8:	6422                	ld	s0,8(sp)
 3fa:	0141                	addi	sp,sp,16
 3fc:	8082                	ret
    return 0;
 3fe:	4501                	li	a0,0
 400:	bfe5                	j	3f8 <strchr+0x1a>

0000000000000402 <gets>:

char *gets(char *buf, int max) {
 402:	711d                	addi	sp,sp,-96
 404:	ec86                	sd	ra,88(sp)
 406:	e8a2                	sd	s0,80(sp)
 408:	e4a6                	sd	s1,72(sp)
 40a:	e0ca                	sd	s2,64(sp)
 40c:	fc4e                	sd	s3,56(sp)
 40e:	f852                	sd	s4,48(sp)
 410:	f456                	sd	s5,40(sp)
 412:	f05a                	sd	s6,32(sp)
 414:	ec5e                	sd	s7,24(sp)
 416:	1080                	addi	s0,sp,96
 418:	8baa                	mv	s7,a0
 41a:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
 41c:	892a                	mv	s2,a0
 41e:	4481                	li	s1,0
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
 420:	4aa9                	li	s5,10
 422:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;) {
 424:	89a6                	mv	s3,s1
 426:	2485                	addiw	s1,s1,1
 428:	0344d863          	bge	s1,s4,458 <gets+0x56>
        cc = read(0, &c, 1);
 42c:	4605                	li	a2,1
 42e:	faf40593          	addi	a1,s0,-81
 432:	4501                	li	a0,0
 434:	00000097          	auipc	ra,0x0
 438:	19a080e7          	jalr	410(ra) # 5ce <read>
        if (cc < 1)
 43c:	00a05e63          	blez	a0,458 <gets+0x56>
        buf[i++] = c;
 440:	faf44783          	lbu	a5,-81(s0)
 444:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
 448:	01578763          	beq	a5,s5,456 <gets+0x54>
 44c:	0905                	addi	s2,s2,1
 44e:	fd679be3          	bne	a5,s6,424 <gets+0x22>
        buf[i++] = c;
 452:	89a6                	mv	s3,s1
 454:	a011                	j	458 <gets+0x56>
 456:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
 458:	99de                	add	s3,s3,s7
 45a:	00098023          	sb	zero,0(s3) # 1000 <digits+0x360>
    return buf;
}
 45e:	855e                	mv	a0,s7
 460:	60e6                	ld	ra,88(sp)
 462:	6446                	ld	s0,80(sp)
 464:	64a6                	ld	s1,72(sp)
 466:	6906                	ld	s2,64(sp)
 468:	79e2                	ld	s3,56(sp)
 46a:	7a42                	ld	s4,48(sp)
 46c:	7aa2                	ld	s5,40(sp)
 46e:	7b02                	ld	s6,32(sp)
 470:	6be2                	ld	s7,24(sp)
 472:	6125                	addi	sp,sp,96
 474:	8082                	ret

0000000000000476 <stat>:

int stat(const char *n, struct stat *st) {
 476:	1101                	addi	sp,sp,-32
 478:	ec06                	sd	ra,24(sp)
 47a:	e822                	sd	s0,16(sp)
 47c:	e04a                	sd	s2,0(sp)
 47e:	1000                	addi	s0,sp,32
 480:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
 482:	4581                	li	a1,0
 484:	00000097          	auipc	ra,0x0
 488:	172080e7          	jalr	370(ra) # 5f6 <open>
    if (fd < 0)
 48c:	02054663          	bltz	a0,4b8 <stat+0x42>
 490:	e426                	sd	s1,8(sp)
 492:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
 494:	85ca                	mv	a1,s2
 496:	00000097          	auipc	ra,0x0
 49a:	178080e7          	jalr	376(ra) # 60e <fstat>
 49e:	892a                	mv	s2,a0
    close(fd);
 4a0:	8526                	mv	a0,s1
 4a2:	00000097          	auipc	ra,0x0
 4a6:	13c080e7          	jalr	316(ra) # 5de <close>
    return r;
 4aa:	64a2                	ld	s1,8(sp)
}
 4ac:	854a                	mv	a0,s2
 4ae:	60e2                	ld	ra,24(sp)
 4b0:	6442                	ld	s0,16(sp)
 4b2:	6902                	ld	s2,0(sp)
 4b4:	6105                	addi	sp,sp,32
 4b6:	8082                	ret
        return -1;
 4b8:	597d                	li	s2,-1
 4ba:	bfcd                	j	4ac <stat+0x36>

00000000000004bc <atoi>:

int atoi(const char *s) {
 4bc:	1141                	addi	sp,sp,-16
 4be:	e422                	sd	s0,8(sp)
 4c0:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
 4c2:	00054683          	lbu	a3,0(a0)
 4c6:	fd06879b          	addiw	a5,a3,-48
 4ca:	0ff7f793          	zext.b	a5,a5
 4ce:	4625                	li	a2,9
 4d0:	02f66863          	bltu	a2,a5,500 <atoi+0x44>
 4d4:	872a                	mv	a4,a0
    n = 0;
 4d6:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
 4d8:	0705                	addi	a4,a4,1
 4da:	0025179b          	slliw	a5,a0,0x2
 4de:	9fa9                	addw	a5,a5,a0
 4e0:	0017979b          	slliw	a5,a5,0x1
 4e4:	9fb5                	addw	a5,a5,a3
 4e6:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
 4ea:	00074683          	lbu	a3,0(a4)
 4ee:	fd06879b          	addiw	a5,a3,-48
 4f2:	0ff7f793          	zext.b	a5,a5
 4f6:	fef671e3          	bgeu	a2,a5,4d8 <atoi+0x1c>
    return n;
}
 4fa:	6422                	ld	s0,8(sp)
 4fc:	0141                	addi	sp,sp,16
 4fe:	8082                	ret
    n = 0;
 500:	4501                	li	a0,0
 502:	bfe5                	j	4fa <atoi+0x3e>

0000000000000504 <memmove>:

void *memmove(void *vdst, const void *vsrc, int n) {
 504:	1141                	addi	sp,sp,-16
 506:	e422                	sd	s0,8(sp)
 508:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
 50a:	02b57463          	bgeu	a0,a1,532 <memmove+0x2e>
        while (n-- > 0)
 50e:	00c05f63          	blez	a2,52c <memmove+0x28>
 512:	1602                	slli	a2,a2,0x20
 514:	9201                	srli	a2,a2,0x20
 516:	00c507b3          	add	a5,a0,a2
    dst = vdst;
 51a:	872a                	mv	a4,a0
            *dst++ = *src++;
 51c:	0585                	addi	a1,a1,1
 51e:	0705                	addi	a4,a4,1
 520:	fff5c683          	lbu	a3,-1(a1)
 524:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
 528:	fef71ae3          	bne	a4,a5,51c <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
 52c:	6422                	ld	s0,8(sp)
 52e:	0141                	addi	sp,sp,16
 530:	8082                	ret
        dst += n;
 532:	00c50733          	add	a4,a0,a2
        src += n;
 536:	95b2                	add	a1,a1,a2
        while (n-- > 0)
 538:	fec05ae3          	blez	a2,52c <memmove+0x28>
 53c:	fff6079b          	addiw	a5,a2,-1
 540:	1782                	slli	a5,a5,0x20
 542:	9381                	srli	a5,a5,0x20
 544:	fff7c793          	not	a5,a5
 548:	97ba                	add	a5,a5,a4
            *--dst = *--src;
 54a:	15fd                	addi	a1,a1,-1
 54c:	177d                	addi	a4,a4,-1
 54e:	0005c683          	lbu	a3,0(a1)
 552:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
 556:	fee79ae3          	bne	a5,a4,54a <memmove+0x46>
 55a:	bfc9                	j	52c <memmove+0x28>

000000000000055c <memcmp>:

int memcmp(const void *s1, const void *s2, uint n) {
 55c:	1141                	addi	sp,sp,-16
 55e:	e422                	sd	s0,8(sp)
 560:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0) {
 562:	ca05                	beqz	a2,592 <memcmp+0x36>
 564:	fff6069b          	addiw	a3,a2,-1
 568:	1682                	slli	a3,a3,0x20
 56a:	9281                	srli	a3,a3,0x20
 56c:	0685                	addi	a3,a3,1
 56e:	96aa                	add	a3,a3,a0
        if (*p1 != *p2) {
 570:	00054783          	lbu	a5,0(a0)
 574:	0005c703          	lbu	a4,0(a1)
 578:	00e79863          	bne	a5,a4,588 <memcmp+0x2c>
            return *p1 - *p2;
        }
        p1++;
 57c:	0505                	addi	a0,a0,1
        p2++;
 57e:	0585                	addi	a1,a1,1
    while (n-- > 0) {
 580:	fed518e3          	bne	a0,a3,570 <memcmp+0x14>
    }
    return 0;
 584:	4501                	li	a0,0
 586:	a019                	j	58c <memcmp+0x30>
            return *p1 - *p2;
 588:	40e7853b          	subw	a0,a5,a4
}
 58c:	6422                	ld	s0,8(sp)
 58e:	0141                	addi	sp,sp,16
 590:	8082                	ret
    return 0;
 592:	4501                	li	a0,0
 594:	bfe5                	j	58c <memcmp+0x30>

0000000000000596 <memcpy>:

void *memcpy(void *dst, const void *src, uint n) {
 596:	1141                	addi	sp,sp,-16
 598:	e406                	sd	ra,8(sp)
 59a:	e022                	sd	s0,0(sp)
 59c:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
 59e:	00000097          	auipc	ra,0x0
 5a2:	f66080e7          	jalr	-154(ra) # 504 <memmove>
}
 5a6:	60a2                	ld	ra,8(sp)
 5a8:	6402                	ld	s0,0(sp)
 5aa:	0141                	addi	sp,sp,16
 5ac:	8082                	ret

00000000000005ae <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5ae:	4885                	li	a7,1
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5b6:	4889                	li	a7,2
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <wait>:
.global wait
wait:
 li a7, SYS_wait
 5be:	488d                	li	a7,3
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5c6:	4891                	li	a7,4
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <read>:
.global read
read:
 li a7, SYS_read
 5ce:	4895                	li	a7,5
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <write>:
.global write
write:
 li a7, SYS_write
 5d6:	48c1                	li	a7,16
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <close>:
.global close
close:
 li a7, SYS_close
 5de:	48d5                	li	a7,21
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5e6:	4899                	li	a7,6
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <exec>:
.global exec
exec:
 li a7, SYS_exec
 5ee:	489d                	li	a7,7
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <open>:
.global open
open:
 li a7, SYS_open
 5f6:	48bd                	li	a7,15
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5fe:	48c5                	li	a7,17
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 606:	48c9                	li	a7,18
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 60e:	48a1                	li	a7,8
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <link>:
.global link
link:
 li a7, SYS_link
 616:	48cd                	li	a7,19
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 61e:	48d1                	li	a7,20
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 626:	48a5                	li	a7,9
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <dup>:
.global dup
dup:
 li a7, SYS_dup
 62e:	48a9                	li	a7,10
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 636:	48ad                	li	a7,11
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 63e:	48b1                	li	a7,12
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 646:	48b5                	li	a7,13
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 64e:	48b9                	li	a7,14
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <trace>:
.global trace
trace:
 li a7, SYS_trace
 656:	48d9                	li	a7,22
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 65e:	48dd                	li	a7,23
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <putc>:

#include <stdarg.h>

static char digits[] = "0123456789ABCDEF";

static void putc(int fd, char c) { write(fd, &c, 1); }
 666:	1101                	addi	sp,sp,-32
 668:	ec06                	sd	ra,24(sp)
 66a:	e822                	sd	s0,16(sp)
 66c:	1000                	addi	s0,sp,32
 66e:	feb407a3          	sb	a1,-17(s0)
 672:	4605                	li	a2,1
 674:	fef40593          	addi	a1,s0,-17
 678:	00000097          	auipc	ra,0x0
 67c:	f5e080e7          	jalr	-162(ra) # 5d6 <write>
 680:	60e2                	ld	ra,24(sp)
 682:	6442                	ld	s0,16(sp)
 684:	6105                	addi	sp,sp,32
 686:	8082                	ret

0000000000000688 <printint>:

static void printint(int fd, int xx, int base, int sgn) {
 688:	7139                	addi	sp,sp,-64
 68a:	fc06                	sd	ra,56(sp)
 68c:	f822                	sd	s0,48(sp)
 68e:	f426                	sd	s1,40(sp)
 690:	0080                	addi	s0,sp,64
 692:	84aa                	mv	s1,a0
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if (sgn && xx < 0) {
 694:	c299                	beqz	a3,69a <printint+0x12>
 696:	0805cb63          	bltz	a1,72c <printint+0xa4>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
 69a:	2581                	sext.w	a1,a1
    neg = 0;
 69c:	4881                	li	a7,0
 69e:	fc040693          	addi	a3,s0,-64
    }

    i = 0;
 6a2:	4701                	li	a4,0
    do {
        buf[i++] = digits[x % base];
 6a4:	2601                	sext.w	a2,a2
 6a6:	00000517          	auipc	a0,0x0
 6aa:	5fa50513          	addi	a0,a0,1530 # ca0 <digits>
 6ae:	883a                	mv	a6,a4
 6b0:	2705                	addiw	a4,a4,1
 6b2:	02c5f7bb          	remuw	a5,a1,a2
 6b6:	1782                	slli	a5,a5,0x20
 6b8:	9381                	srli	a5,a5,0x20
 6ba:	97aa                	add	a5,a5,a0
 6bc:	0007c783          	lbu	a5,0(a5)
 6c0:	00f68023          	sb	a5,0(a3)
    } while ((x /= base) != 0);
 6c4:	0005879b          	sext.w	a5,a1
 6c8:	02c5d5bb          	divuw	a1,a1,a2
 6cc:	0685                	addi	a3,a3,1
 6ce:	fec7f0e3          	bgeu	a5,a2,6ae <printint+0x26>
    if (neg)
 6d2:	00088c63          	beqz	a7,6ea <printint+0x62>
        buf[i++] = '-';
 6d6:	fd070793          	addi	a5,a4,-48
 6da:	00878733          	add	a4,a5,s0
 6de:	02d00793          	li	a5,45
 6e2:	fef70823          	sb	a5,-16(a4)
 6e6:	0028071b          	addiw	a4,a6,2

    while (--i >= 0)
 6ea:	02e05c63          	blez	a4,722 <printint+0x9a>
 6ee:	f04a                	sd	s2,32(sp)
 6f0:	ec4e                	sd	s3,24(sp)
 6f2:	fc040793          	addi	a5,s0,-64
 6f6:	00e78933          	add	s2,a5,a4
 6fa:	fff78993          	addi	s3,a5,-1
 6fe:	99ba                	add	s3,s3,a4
 700:	377d                	addiw	a4,a4,-1
 702:	1702                	slli	a4,a4,0x20
 704:	9301                	srli	a4,a4,0x20
 706:	40e989b3          	sub	s3,s3,a4
        putc(fd, buf[i]);
 70a:	fff94583          	lbu	a1,-1(s2)
 70e:	8526                	mv	a0,s1
 710:	00000097          	auipc	ra,0x0
 714:	f56080e7          	jalr	-170(ra) # 666 <putc>
    while (--i >= 0)
 718:	197d                	addi	s2,s2,-1
 71a:	ff3918e3          	bne	s2,s3,70a <printint+0x82>
 71e:	7902                	ld	s2,32(sp)
 720:	69e2                	ld	s3,24(sp)
}
 722:	70e2                	ld	ra,56(sp)
 724:	7442                	ld	s0,48(sp)
 726:	74a2                	ld	s1,40(sp)
 728:	6121                	addi	sp,sp,64
 72a:	8082                	ret
        x = -xx;
 72c:	40b005bb          	negw	a1,a1
        neg = 1;
 730:	4885                	li	a7,1
        x = -xx;
 732:	b7b5                	j	69e <printint+0x16>

0000000000000734 <vprintf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void vprintf(int fd, const char *fmt, va_list ap) {
 734:	715d                	addi	sp,sp,-80
 736:	e486                	sd	ra,72(sp)
 738:	e0a2                	sd	s0,64(sp)
 73a:	f84a                	sd	s2,48(sp)
 73c:	0880                	addi	s0,sp,80
    char *s;
    int c, i, state;

    state = 0;
    for (i = 0; fmt[i]; i++) {
 73e:	0005c903          	lbu	s2,0(a1)
 742:	1a090a63          	beqz	s2,8f6 <vprintf+0x1c2>
 746:	fc26                	sd	s1,56(sp)
 748:	f44e                	sd	s3,40(sp)
 74a:	f052                	sd	s4,32(sp)
 74c:	ec56                	sd	s5,24(sp)
 74e:	e85a                	sd	s6,16(sp)
 750:	e45e                	sd	s7,8(sp)
 752:	8aaa                	mv	s5,a0
 754:	8bb2                	mv	s7,a2
 756:	00158493          	addi	s1,a1,1
    state = 0;
 75a:	4981                	li	s3,0
            if (c == '%') {
                state = '%';
            } else {
                putc(fd, c);
            }
        } else if (state == '%') {
 75c:	02500a13          	li	s4,37
 760:	4b55                	li	s6,21
 762:	a839                	j	780 <vprintf+0x4c>
                putc(fd, c);
 764:	85ca                	mv	a1,s2
 766:	8556                	mv	a0,s5
 768:	00000097          	auipc	ra,0x0
 76c:	efe080e7          	jalr	-258(ra) # 666 <putc>
 770:	a019                	j	776 <vprintf+0x42>
        } else if (state == '%') {
 772:	01498d63          	beq	s3,s4,78c <vprintf+0x58>
    for (i = 0; fmt[i]; i++) {
 776:	0485                	addi	s1,s1,1
 778:	fff4c903          	lbu	s2,-1(s1)
 77c:	16090763          	beqz	s2,8ea <vprintf+0x1b6>
        if (state == 0) {
 780:	fe0999e3          	bnez	s3,772 <vprintf+0x3e>
            if (c == '%') {
 784:	ff4910e3          	bne	s2,s4,764 <vprintf+0x30>
                state = '%';
 788:	89d2                	mv	s3,s4
 78a:	b7f5                	j	776 <vprintf+0x42>
            if (c == 'd') {
 78c:	13490463          	beq	s2,s4,8b4 <vprintf+0x180>
 790:	f9d9079b          	addiw	a5,s2,-99
 794:	0ff7f793          	zext.b	a5,a5
 798:	12fb6763          	bltu	s6,a5,8c6 <vprintf+0x192>
 79c:	f9d9079b          	addiw	a5,s2,-99
 7a0:	0ff7f713          	zext.b	a4,a5
 7a4:	12eb6163          	bltu	s6,a4,8c6 <vprintf+0x192>
 7a8:	00271793          	slli	a5,a4,0x2
 7ac:	00000717          	auipc	a4,0x0
 7b0:	49c70713          	addi	a4,a4,1180 # c48 <malloc+0x262>
 7b4:	97ba                	add	a5,a5,a4
 7b6:	439c                	lw	a5,0(a5)
 7b8:	97ba                	add	a5,a5,a4
 7ba:	8782                	jr	a5
                printint(fd, va_arg(ap, int), 10, 1);
 7bc:	008b8913          	addi	s2,s7,8
 7c0:	4685                	li	a3,1
 7c2:	4629                	li	a2,10
 7c4:	000ba583          	lw	a1,0(s7)
 7c8:	8556                	mv	a0,s5
 7ca:	00000097          	auipc	ra,0x0
 7ce:	ebe080e7          	jalr	-322(ra) # 688 <printint>
 7d2:	8bca                	mv	s7,s2
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
                putc(fd, c);
            }
            state = 0;
 7d4:	4981                	li	s3,0
 7d6:	b745                	j	776 <vprintf+0x42>
                printint(fd, va_arg(ap, uint64), 10, 0);
 7d8:	008b8913          	addi	s2,s7,8
 7dc:	4681                	li	a3,0
 7de:	4629                	li	a2,10
 7e0:	000ba583          	lw	a1,0(s7)
 7e4:	8556                	mv	a0,s5
 7e6:	00000097          	auipc	ra,0x0
 7ea:	ea2080e7          	jalr	-350(ra) # 688 <printint>
 7ee:	8bca                	mv	s7,s2
            state = 0;
 7f0:	4981                	li	s3,0
 7f2:	b751                	j	776 <vprintf+0x42>
                printint(fd, va_arg(ap, int), 16, 0);
 7f4:	008b8913          	addi	s2,s7,8
 7f8:	4681                	li	a3,0
 7fa:	4641                	li	a2,16
 7fc:	000ba583          	lw	a1,0(s7)
 800:	8556                	mv	a0,s5
 802:	00000097          	auipc	ra,0x0
 806:	e86080e7          	jalr	-378(ra) # 688 <printint>
 80a:	8bca                	mv	s7,s2
            state = 0;
 80c:	4981                	li	s3,0
 80e:	b7a5                	j	776 <vprintf+0x42>
 810:	e062                	sd	s8,0(sp)
                printptr(fd, va_arg(ap, uint64));
 812:	008b8c13          	addi	s8,s7,8
 816:	000bb983          	ld	s3,0(s7)
    putc(fd, '0');
 81a:	03000593          	li	a1,48
 81e:	8556                	mv	a0,s5
 820:	00000097          	auipc	ra,0x0
 824:	e46080e7          	jalr	-442(ra) # 666 <putc>
    putc(fd, 'x');
 828:	07800593          	li	a1,120
 82c:	8556                	mv	a0,s5
 82e:	00000097          	auipc	ra,0x0
 832:	e38080e7          	jalr	-456(ra) # 666 <putc>
 836:	4941                	li	s2,16
        putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 838:	00000b97          	auipc	s7,0x0
 83c:	468b8b93          	addi	s7,s7,1128 # ca0 <digits>
 840:	03c9d793          	srli	a5,s3,0x3c
 844:	97de                	add	a5,a5,s7
 846:	0007c583          	lbu	a1,0(a5)
 84a:	8556                	mv	a0,s5
 84c:	00000097          	auipc	ra,0x0
 850:	e1a080e7          	jalr	-486(ra) # 666 <putc>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 854:	0992                	slli	s3,s3,0x4
 856:	397d                	addiw	s2,s2,-1
 858:	fe0914e3          	bnez	s2,840 <vprintf+0x10c>
                printptr(fd, va_arg(ap, uint64));
 85c:	8be2                	mv	s7,s8
            state = 0;
 85e:	4981                	li	s3,0
 860:	6c02                	ld	s8,0(sp)
 862:	bf11                	j	776 <vprintf+0x42>
                s = va_arg(ap, char *);
 864:	008b8993          	addi	s3,s7,8
 868:	000bb903          	ld	s2,0(s7)
                if (s == 0)
 86c:	02090163          	beqz	s2,88e <vprintf+0x15a>
                while (*s != 0) {
 870:	00094583          	lbu	a1,0(s2)
 874:	c9a5                	beqz	a1,8e4 <vprintf+0x1b0>
                    putc(fd, *s);
 876:	8556                	mv	a0,s5
 878:	00000097          	auipc	ra,0x0
 87c:	dee080e7          	jalr	-530(ra) # 666 <putc>
                    s++;
 880:	0905                	addi	s2,s2,1
                while (*s != 0) {
 882:	00094583          	lbu	a1,0(s2)
 886:	f9e5                	bnez	a1,876 <vprintf+0x142>
                s = va_arg(ap, char *);
 888:	8bce                	mv	s7,s3
            state = 0;
 88a:	4981                	li	s3,0
 88c:	b5ed                	j	776 <vprintf+0x42>
                    s = "(null)";
 88e:	00000917          	auipc	s2,0x0
 892:	3b290913          	addi	s2,s2,946 # c40 <malloc+0x25a>
                while (*s != 0) {
 896:	02800593          	li	a1,40
 89a:	bff1                	j	876 <vprintf+0x142>
                putc(fd, va_arg(ap, uint));
 89c:	008b8913          	addi	s2,s7,8
 8a0:	000bc583          	lbu	a1,0(s7)
 8a4:	8556                	mv	a0,s5
 8a6:	00000097          	auipc	ra,0x0
 8aa:	dc0080e7          	jalr	-576(ra) # 666 <putc>
 8ae:	8bca                	mv	s7,s2
            state = 0;
 8b0:	4981                	li	s3,0
 8b2:	b5d1                	j	776 <vprintf+0x42>
                putc(fd, c);
 8b4:	02500593          	li	a1,37
 8b8:	8556                	mv	a0,s5
 8ba:	00000097          	auipc	ra,0x0
 8be:	dac080e7          	jalr	-596(ra) # 666 <putc>
            state = 0;
 8c2:	4981                	li	s3,0
 8c4:	bd4d                	j	776 <vprintf+0x42>
                putc(fd, '%');
 8c6:	02500593          	li	a1,37
 8ca:	8556                	mv	a0,s5
 8cc:	00000097          	auipc	ra,0x0
 8d0:	d9a080e7          	jalr	-614(ra) # 666 <putc>
                putc(fd, c);
 8d4:	85ca                	mv	a1,s2
 8d6:	8556                	mv	a0,s5
 8d8:	00000097          	auipc	ra,0x0
 8dc:	d8e080e7          	jalr	-626(ra) # 666 <putc>
            state = 0;
 8e0:	4981                	li	s3,0
 8e2:	bd51                	j	776 <vprintf+0x42>
                s = va_arg(ap, char *);
 8e4:	8bce                	mv	s7,s3
            state = 0;
 8e6:	4981                	li	s3,0
 8e8:	b579                	j	776 <vprintf+0x42>
 8ea:	74e2                	ld	s1,56(sp)
 8ec:	79a2                	ld	s3,40(sp)
 8ee:	7a02                	ld	s4,32(sp)
 8f0:	6ae2                	ld	s5,24(sp)
 8f2:	6b42                	ld	s6,16(sp)
 8f4:	6ba2                	ld	s7,8(sp)
        }
    }
}
 8f6:	60a6                	ld	ra,72(sp)
 8f8:	6406                	ld	s0,64(sp)
 8fa:	7942                	ld	s2,48(sp)
 8fc:	6161                	addi	sp,sp,80
 8fe:	8082                	ret

0000000000000900 <fprintf>:

void fprintf(int fd, const char *fmt, ...) {
 900:	715d                	addi	sp,sp,-80
 902:	ec06                	sd	ra,24(sp)
 904:	e822                	sd	s0,16(sp)
 906:	1000                	addi	s0,sp,32
 908:	e010                	sd	a2,0(s0)
 90a:	e414                	sd	a3,8(s0)
 90c:	e818                	sd	a4,16(s0)
 90e:	ec1c                	sd	a5,24(s0)
 910:	03043023          	sd	a6,32(s0)
 914:	03143423          	sd	a7,40(s0)
    va_list ap;

    va_start(ap, fmt);
 918:	fe843423          	sd	s0,-24(s0)
    vprintf(fd, fmt, ap);
 91c:	8622                	mv	a2,s0
 91e:	00000097          	auipc	ra,0x0
 922:	e16080e7          	jalr	-490(ra) # 734 <vprintf>
}
 926:	60e2                	ld	ra,24(sp)
 928:	6442                	ld	s0,16(sp)
 92a:	6161                	addi	sp,sp,80
 92c:	8082                	ret

000000000000092e <printf>:

void printf(const char *fmt, ...) {
 92e:	711d                	addi	sp,sp,-96
 930:	ec06                	sd	ra,24(sp)
 932:	e822                	sd	s0,16(sp)
 934:	1000                	addi	s0,sp,32
 936:	e40c                	sd	a1,8(s0)
 938:	e810                	sd	a2,16(s0)
 93a:	ec14                	sd	a3,24(s0)
 93c:	f018                	sd	a4,32(s0)
 93e:	f41c                	sd	a5,40(s0)
 940:	03043823          	sd	a6,48(s0)
 944:	03143c23          	sd	a7,56(s0)
    va_list ap;

    va_start(ap, fmt);
 948:	00840613          	addi	a2,s0,8
 94c:	fec43423          	sd	a2,-24(s0)
    vprintf(1, fmt, ap);
 950:	85aa                	mv	a1,a0
 952:	4505                	li	a0,1
 954:	00000097          	auipc	ra,0x0
 958:	de0080e7          	jalr	-544(ra) # 734 <vprintf>
}
 95c:	60e2                	ld	ra,24(sp)
 95e:	6442                	ld	s0,16(sp)
 960:	6125                	addi	sp,sp,96
 962:	8082                	ret

0000000000000964 <free>:
typedef union header Header;

static Header base;
static Header *freep;

void free(void *ap) {
 964:	1141                	addi	sp,sp,-16
 966:	e422                	sd	s0,8(sp)
 968:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
 96a:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 96e:	00000797          	auipc	a5,0x0
 972:	7fa7b783          	ld	a5,2042(a5) # 1168 <freep>
 976:	a02d                	j	9a0 <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr) {
        bp->s.size += p->s.ptr->s.size;
 978:	4618                	lw	a4,8(a2)
 97a:	9f2d                	addw	a4,a4,a1
 97c:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
 980:	6398                	ld	a4,0(a5)
 982:	6310                	ld	a2,0(a4)
 984:	a83d                	j	9c2 <free+0x5e>
    } else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp) {
        p->s.size += bp->s.size;
 986:	ff852703          	lw	a4,-8(a0)
 98a:	9f31                	addw	a4,a4,a2
 98c:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
 98e:	ff053683          	ld	a3,-16(a0)
 992:	a091                	j	9d6 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 994:	6398                	ld	a4,0(a5)
 996:	00e7e463          	bltu	a5,a4,99e <free+0x3a>
 99a:	00e6ea63          	bltu	a3,a4,9ae <free+0x4a>
void free(void *ap) {
 99e:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9a0:	fed7fae3          	bgeu	a5,a3,994 <free+0x30>
 9a4:	6398                	ld	a4,0(a5)
 9a6:	00e6e463          	bltu	a3,a4,9ae <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9aa:	fee7eae3          	bltu	a5,a4,99e <free+0x3a>
    if (bp + bp->s.size == p->s.ptr) {
 9ae:	ff852583          	lw	a1,-8(a0)
 9b2:	6390                	ld	a2,0(a5)
 9b4:	02059813          	slli	a6,a1,0x20
 9b8:	01c85713          	srli	a4,a6,0x1c
 9bc:	9736                	add	a4,a4,a3
 9be:	fae60de3          	beq	a2,a4,978 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
 9c2:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp) {
 9c6:	4790                	lw	a2,8(a5)
 9c8:	02061593          	slli	a1,a2,0x20
 9cc:	01c5d713          	srli	a4,a1,0x1c
 9d0:	973e                	add	a4,a4,a5
 9d2:	fae68ae3          	beq	a3,a4,986 <free+0x22>
        p->s.ptr = bp->s.ptr;
 9d6:	e394                	sd	a3,0(a5)
    } else
        p->s.ptr = bp;
    freep = p;
 9d8:	00000717          	auipc	a4,0x0
 9dc:	78f73823          	sd	a5,1936(a4) # 1168 <freep>
}
 9e0:	6422                	ld	s0,8(sp)
 9e2:	0141                	addi	sp,sp,16
 9e4:	8082                	ret

00000000000009e6 <malloc>:
    hp->s.size = nu;
    free((void *)(hp + 1));
    return freep;
}

void *malloc(uint nbytes) {
 9e6:	7139                	addi	sp,sp,-64
 9e8:	fc06                	sd	ra,56(sp)
 9ea:	f822                	sd	s0,48(sp)
 9ec:	f426                	sd	s1,40(sp)
 9ee:	ec4e                	sd	s3,24(sp)
 9f0:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
 9f2:	02051493          	slli	s1,a0,0x20
 9f6:	9081                	srli	s1,s1,0x20
 9f8:	04bd                	addi	s1,s1,15
 9fa:	8091                	srli	s1,s1,0x4
 9fc:	0014899b          	addiw	s3,s1,1
 a00:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0) {
 a02:	00000517          	auipc	a0,0x0
 a06:	76653503          	ld	a0,1894(a0) # 1168 <freep>
 a0a:	c915                	beqz	a0,a3e <malloc+0x58>
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 a0c:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits) {
 a0e:	4798                	lw	a4,8(a5)
 a10:	08977e63          	bgeu	a4,s1,aac <malloc+0xc6>
 a14:	f04a                	sd	s2,32(sp)
 a16:	e852                	sd	s4,16(sp)
 a18:	e456                	sd	s5,8(sp)
 a1a:	e05a                	sd	s6,0(sp)
    if (nu < 4096)
 a1c:	8a4e                	mv	s4,s3
 a1e:	0009871b          	sext.w	a4,s3
 a22:	6685                	lui	a3,0x1
 a24:	00d77363          	bgeu	a4,a3,a2a <malloc+0x44>
 a28:	6a05                	lui	s4,0x1
 a2a:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
 a2e:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
 a32:	00000917          	auipc	s2,0x0
 a36:	73690913          	addi	s2,s2,1846 # 1168 <freep>
    if (p == (char *)-1)
 a3a:	5afd                	li	s5,-1
 a3c:	a091                	j	a80 <malloc+0x9a>
 a3e:	f04a                	sd	s2,32(sp)
 a40:	e852                	sd	s4,16(sp)
 a42:	e456                	sd	s5,8(sp)
 a44:	e05a                	sd	s6,0(sp)
        base.s.ptr = freep = prevp = &base;
 a46:	00000797          	auipc	a5,0x0
 a4a:	72a78793          	addi	a5,a5,1834 # 1170 <base>
 a4e:	00000717          	auipc	a4,0x0
 a52:	70f73d23          	sd	a5,1818(a4) # 1168 <freep>
 a56:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
 a58:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits) {
 a5c:	b7c1                	j	a1c <malloc+0x36>
                prevp->s.ptr = p->s.ptr;
 a5e:	6398                	ld	a4,0(a5)
 a60:	e118                	sd	a4,0(a0)
 a62:	a08d                	j	ac4 <malloc+0xde>
    hp->s.size = nu;
 a64:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
 a68:	0541                	addi	a0,a0,16
 a6a:	00000097          	auipc	ra,0x0
 a6e:	efa080e7          	jalr	-262(ra) # 964 <free>
    return freep;
 a72:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
 a76:	c13d                	beqz	a0,adc <malloc+0xf6>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
 a78:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits) {
 a7a:	4798                	lw	a4,8(a5)
 a7c:	02977463          	bgeu	a4,s1,aa4 <malloc+0xbe>
        if (p == freep)
 a80:	00093703          	ld	a4,0(s2)
 a84:	853e                	mv	a0,a5
 a86:	fef719e3          	bne	a4,a5,a78 <malloc+0x92>
    p = sbrk(nu * sizeof(Header));
 a8a:	8552                	mv	a0,s4
 a8c:	00000097          	auipc	ra,0x0
 a90:	bb2080e7          	jalr	-1102(ra) # 63e <sbrk>
    if (p == (char *)-1)
 a94:	fd5518e3          	bne	a0,s5,a64 <malloc+0x7e>
                return 0;
 a98:	4501                	li	a0,0
 a9a:	7902                	ld	s2,32(sp)
 a9c:	6a42                	ld	s4,16(sp)
 a9e:	6aa2                	ld	s5,8(sp)
 aa0:	6b02                	ld	s6,0(sp)
 aa2:	a03d                	j	ad0 <malloc+0xea>
 aa4:	7902                	ld	s2,32(sp)
 aa6:	6a42                	ld	s4,16(sp)
 aa8:	6aa2                	ld	s5,8(sp)
 aaa:	6b02                	ld	s6,0(sp)
            if (p->s.size == nunits)
 aac:	fae489e3          	beq	s1,a4,a5e <malloc+0x78>
                p->s.size -= nunits;
 ab0:	4137073b          	subw	a4,a4,s3
 ab4:	c798                	sw	a4,8(a5)
                p += p->s.size;
 ab6:	02071693          	slli	a3,a4,0x20
 aba:	01c6d713          	srli	a4,a3,0x1c
 abe:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
 ac0:	0137a423          	sw	s3,8(a5)
            freep = prevp;
 ac4:	00000717          	auipc	a4,0x0
 ac8:	6aa73223          	sd	a0,1700(a4) # 1168 <freep>
            return (void *)(p + 1);
 acc:	01078513          	addi	a0,a5,16
    }
}
 ad0:	70e2                	ld	ra,56(sp)
 ad2:	7442                	ld	s0,48(sp)
 ad4:	74a2                	ld	s1,40(sp)
 ad6:	69e2                	ld	s3,24(sp)
 ad8:	6121                	addi	sp,sp,64
 ada:	8082                	ret
 adc:	7902                	ld	s2,32(sp)
 ade:	6a42                	ld	s4,16(sp)
 ae0:	6aa2                	ld	s5,8(sp)
 ae2:	6b02                	ld	s6,0(sp)
 ae4:	b7f5                	j	ad0 <malloc+0xea>
