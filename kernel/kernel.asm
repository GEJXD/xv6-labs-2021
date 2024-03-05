
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000b117          	auipc	sp,0xb
    80000004:	29013103          	ld	sp,656(sp) # 8000b290 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	0af050ef          	jal	800058c4 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:

// Free the page of physical memory pointed at by v,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void kfree(void *pa) {
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	addi	s0,sp,32
    struct run *r;

    if (((uint64)pa % PGSIZE) != 0 || (char *)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	03451793          	slli	a5,a0,0x34
    8000002c:	ebb9                	bnez	a5,80000082 <kfree+0x66>
    8000002e:	84aa                	mv	s1,a0
    80000030:	00029797          	auipc	a5,0x29
    80000034:	21078793          	addi	a5,a5,528 # 80029240 <end>
    80000038:	04f56563          	bltu	a0,a5,80000082 <kfree+0x66>
    8000003c:	47c5                	li	a5,17
    8000003e:	07ee                	slli	a5,a5,0x1b
    80000040:	04f57163          	bgeu	a0,a5,80000082 <kfree+0x66>
        panic("kfree");

    // Fill with junk to catch dangling refs.
    memset(pa, 1, PGSIZE);
    80000044:	6605                	lui	a2,0x1
    80000046:	4585                	li	a1,1
    80000048:	00000097          	auipc	ra,0x0
    8000004c:	17c080e7          	jalr	380(ra) # 800001c4 <memset>

    r = (struct run *)pa;

    acquire(&kmem.lock);
    80000050:	0000c917          	auipc	s2,0xc
    80000054:	fe090913          	addi	s2,s2,-32 # 8000c030 <kmem>
    80000058:	854a                	mv	a0,s2
    8000005a:	00006097          	auipc	ra,0x6
    8000005e:	2b2080e7          	jalr	690(ra) # 8000630c <acquire>
    r->next = kmem.freelist;
    80000062:	01893783          	ld	a5,24(s2)
    80000066:	e09c                	sd	a5,0(s1)
    kmem.freelist = r;
    80000068:	00993c23          	sd	s1,24(s2)
    release(&kmem.lock);
    8000006c:	854a                	mv	a0,s2
    8000006e:	00006097          	auipc	ra,0x6
    80000072:	352080e7          	jalr	850(ra) # 800063c0 <release>
}
    80000076:	60e2                	ld	ra,24(sp)
    80000078:	6442                	ld	s0,16(sp)
    8000007a:	64a2                	ld	s1,8(sp)
    8000007c:	6902                	ld	s2,0(sp)
    8000007e:	6105                	addi	sp,sp,32
    80000080:	8082                	ret
        panic("kfree");
    80000082:	00008517          	auipc	a0,0x8
    80000086:	f7e50513          	addi	a0,a0,-130 # 80008000 <etext>
    8000008a:	00006097          	auipc	ra,0x6
    8000008e:	d08080e7          	jalr	-760(ra) # 80005d92 <panic>

0000000080000092 <freerange>:
void freerange(void *pa_start, void *pa_end) {
    80000092:	7179                	addi	sp,sp,-48
    80000094:	f406                	sd	ra,40(sp)
    80000096:	f022                	sd	s0,32(sp)
    80000098:	ec26                	sd	s1,24(sp)
    8000009a:	1800                	addi	s0,sp,48
    p = (char *)PGROUNDUP((uint64)pa_start);
    8000009c:	6785                	lui	a5,0x1
    8000009e:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    800000a2:	00e504b3          	add	s1,a0,a4
    800000a6:	777d                	lui	a4,0xfffff
    800000a8:	8cf9                	and	s1,s1,a4
    for (; p + PGSIZE <= (char *)pa_end; p += PGSIZE)
    800000aa:	94be                	add	s1,s1,a5
    800000ac:	0295e463          	bltu	a1,s1,800000d4 <freerange+0x42>
    800000b0:	e84a                	sd	s2,16(sp)
    800000b2:	e44e                	sd	s3,8(sp)
    800000b4:	e052                	sd	s4,0(sp)
    800000b6:	892e                	mv	s2,a1
        kfree(p);
    800000b8:	7a7d                	lui	s4,0xfffff
    for (; p + PGSIZE <= (char *)pa_end; p += PGSIZE)
    800000ba:	6985                	lui	s3,0x1
        kfree(p);
    800000bc:	01448533          	add	a0,s1,s4
    800000c0:	00000097          	auipc	ra,0x0
    800000c4:	f5c080e7          	jalr	-164(ra) # 8000001c <kfree>
    for (; p + PGSIZE <= (char *)pa_end; p += PGSIZE)
    800000c8:	94ce                	add	s1,s1,s3
    800000ca:	fe9979e3          	bgeu	s2,s1,800000bc <freerange+0x2a>
    800000ce:	6942                	ld	s2,16(sp)
    800000d0:	69a2                	ld	s3,8(sp)
    800000d2:	6a02                	ld	s4,0(sp)
}
    800000d4:	70a2                	ld	ra,40(sp)
    800000d6:	7402                	ld	s0,32(sp)
    800000d8:	64e2                	ld	s1,24(sp)
    800000da:	6145                	addi	sp,sp,48
    800000dc:	8082                	ret

00000000800000de <kinit>:
void kinit() {
    800000de:	1141                	addi	sp,sp,-16
    800000e0:	e406                	sd	ra,8(sp)
    800000e2:	e022                	sd	s0,0(sp)
    800000e4:	0800                	addi	s0,sp,16
    initlock(&kmem.lock, "kmem");
    800000e6:	00008597          	auipc	a1,0x8
    800000ea:	f2a58593          	addi	a1,a1,-214 # 80008010 <etext+0x10>
    800000ee:	0000c517          	auipc	a0,0xc
    800000f2:	f4250513          	addi	a0,a0,-190 # 8000c030 <kmem>
    800000f6:	00006097          	auipc	ra,0x6
    800000fa:	186080e7          	jalr	390(ra) # 8000627c <initlock>
    freerange(end, (void *)PHYSTOP);
    800000fe:	45c5                	li	a1,17
    80000100:	05ee                	slli	a1,a1,0x1b
    80000102:	00029517          	auipc	a0,0x29
    80000106:	13e50513          	addi	a0,a0,318 # 80029240 <end>
    8000010a:	00000097          	auipc	ra,0x0
    8000010e:	f88080e7          	jalr	-120(ra) # 80000092 <freerange>
}
    80000112:	60a2                	ld	ra,8(sp)
    80000114:	6402                	ld	s0,0(sp)
    80000116:	0141                	addi	sp,sp,16
    80000118:	8082                	ret

000000008000011a <kalloc>:

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *kalloc(void) {
    8000011a:	1101                	addi	sp,sp,-32
    8000011c:	ec06                	sd	ra,24(sp)
    8000011e:	e822                	sd	s0,16(sp)
    80000120:	e426                	sd	s1,8(sp)
    80000122:	1000                	addi	s0,sp,32
    struct run *r;

    acquire(&kmem.lock);
    80000124:	0000c497          	auipc	s1,0xc
    80000128:	f0c48493          	addi	s1,s1,-244 # 8000c030 <kmem>
    8000012c:	8526                	mv	a0,s1
    8000012e:	00006097          	auipc	ra,0x6
    80000132:	1de080e7          	jalr	478(ra) # 8000630c <acquire>
    r = kmem.freelist;
    80000136:	6c84                	ld	s1,24(s1)
    if (r)
    80000138:	c885                	beqz	s1,80000168 <kalloc+0x4e>
        kmem.freelist = r->next;
    8000013a:	609c                	ld	a5,0(s1)
    8000013c:	0000c517          	auipc	a0,0xc
    80000140:	ef450513          	addi	a0,a0,-268 # 8000c030 <kmem>
    80000144:	ed1c                	sd	a5,24(a0)
    release(&kmem.lock);
    80000146:	00006097          	auipc	ra,0x6
    8000014a:	27a080e7          	jalr	634(ra) # 800063c0 <release>

    if (r)
        memset((char *)r, 5, PGSIZE); // fill with junk
    8000014e:	6605                	lui	a2,0x1
    80000150:	4595                	li	a1,5
    80000152:	8526                	mv	a0,s1
    80000154:	00000097          	auipc	ra,0x0
    80000158:	070080e7          	jalr	112(ra) # 800001c4 <memset>
    return (void *)r;
}
    8000015c:	8526                	mv	a0,s1
    8000015e:	60e2                	ld	ra,24(sp)
    80000160:	6442                	ld	s0,16(sp)
    80000162:	64a2                	ld	s1,8(sp)
    80000164:	6105                	addi	sp,sp,32
    80000166:	8082                	ret
    release(&kmem.lock);
    80000168:	0000c517          	auipc	a0,0xc
    8000016c:	ec850513          	addi	a0,a0,-312 # 8000c030 <kmem>
    80000170:	00006097          	auipc	ra,0x6
    80000174:	250080e7          	jalr	592(ra) # 800063c0 <release>
    if (r)
    80000178:	b7d5                	j	8000015c <kalloc+0x42>

000000008000017a <freemem>:

// lab2 - sysinfo system call:
// return the number of bytes of free memory.
uint64 freemem() {
    8000017a:	1101                	addi	sp,sp,-32
    8000017c:	ec06                	sd	ra,24(sp)
    8000017e:	e822                	sd	s0,16(sp)
    80000180:	e426                	sd	s1,8(sp)
    80000182:	1000                	addi	s0,sp,32
  struct run *r;
  acquire(&kmem.lock);
    80000184:	0000c497          	auipc	s1,0xc
    80000188:	eac48493          	addi	s1,s1,-340 # 8000c030 <kmem>
    8000018c:	8526                	mv	a0,s1
    8000018e:	00006097          	auipc	ra,0x6
    80000192:	17e080e7          	jalr	382(ra) # 8000630c <acquire>
  r = kmem.freelist;
    80000196:	6c9c                	ld	a5,24(s1)

  uint64 free_size = 0;
  while (r) {
    80000198:	c785                	beqz	a5,800001c0 <freemem+0x46>
  uint64 free_size = 0;
    8000019a:	4481                	li	s1,0
    if (!r) break;
    free_size += PGSIZE;
    8000019c:	6705                	lui	a4,0x1
    8000019e:	94ba                	add	s1,s1,a4
    r = r->next;
    800001a0:	639c                	ld	a5,0(a5)
  while (r) {
    800001a2:	fff5                	bnez	a5,8000019e <freemem+0x24>
  }

  release(&kmem.lock);
    800001a4:	0000c517          	auipc	a0,0xc
    800001a8:	e8c50513          	addi	a0,a0,-372 # 8000c030 <kmem>
    800001ac:	00006097          	auipc	ra,0x6
    800001b0:	214080e7          	jalr	532(ra) # 800063c0 <release>

  return free_size;
}
    800001b4:	8526                	mv	a0,s1
    800001b6:	60e2                	ld	ra,24(sp)
    800001b8:	6442                	ld	s0,16(sp)
    800001ba:	64a2                	ld	s1,8(sp)
    800001bc:	6105                	addi	sp,sp,32
    800001be:	8082                	ret
  uint64 free_size = 0;
    800001c0:	4481                	li	s1,0
    800001c2:	b7cd                	j	800001a4 <freemem+0x2a>

00000000800001c4 <memset>:
#include "types.h"

void *memset(void *dst, int c, uint n) {
    800001c4:	1141                	addi	sp,sp,-16
    800001c6:	e422                	sd	s0,8(sp)
    800001c8:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++) {
    800001ca:	ca19                	beqz	a2,800001e0 <memset+0x1c>
    800001cc:	87aa                	mv	a5,a0
    800001ce:	1602                	slli	a2,a2,0x20
    800001d0:	9201                	srli	a2,a2,0x20
    800001d2:	00a60733          	add	a4,a2,a0
        cdst[i] = c;
    800001d6:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++) {
    800001da:	0785                	addi	a5,a5,1
    800001dc:	fee79de3          	bne	a5,a4,800001d6 <memset+0x12>
    }
    return dst;
}
    800001e0:	6422                	ld	s0,8(sp)
    800001e2:	0141                	addi	sp,sp,16
    800001e4:	8082                	ret

00000000800001e6 <memcmp>:

int memcmp(const void *v1, const void *v2, uint n) {
    800001e6:	1141                	addi	sp,sp,-16
    800001e8:	e422                	sd	s0,8(sp)
    800001ea:	0800                	addi	s0,sp,16
    const uchar *s1, *s2;

    s1 = v1;
    s2 = v2;
    while (n-- > 0) {
    800001ec:	ca05                	beqz	a2,8000021c <memcmp+0x36>
    800001ee:	fff6069b          	addiw	a3,a2,-1 # fff <_entry-0x7ffff001>
    800001f2:	1682                	slli	a3,a3,0x20
    800001f4:	9281                	srli	a3,a3,0x20
    800001f6:	0685                	addi	a3,a3,1
    800001f8:	96aa                	add	a3,a3,a0
        if (*s1 != *s2)
    800001fa:	00054783          	lbu	a5,0(a0)
    800001fe:	0005c703          	lbu	a4,0(a1)
    80000202:	00e79863          	bne	a5,a4,80000212 <memcmp+0x2c>
            return *s1 - *s2;
        s1++, s2++;
    80000206:	0505                	addi	a0,a0,1
    80000208:	0585                	addi	a1,a1,1
    while (n-- > 0) {
    8000020a:	fed518e3          	bne	a0,a3,800001fa <memcmp+0x14>
    }

    return 0;
    8000020e:	4501                	li	a0,0
    80000210:	a019                	j	80000216 <memcmp+0x30>
            return *s1 - *s2;
    80000212:	40e7853b          	subw	a0,a5,a4
}
    80000216:	6422                	ld	s0,8(sp)
    80000218:	0141                	addi	sp,sp,16
    8000021a:	8082                	ret
    return 0;
    8000021c:	4501                	li	a0,0
    8000021e:	bfe5                	j	80000216 <memcmp+0x30>

0000000080000220 <memmove>:

void *memmove(void *dst, const void *src, uint n) {
    80000220:	1141                	addi	sp,sp,-16
    80000222:	e422                	sd	s0,8(sp)
    80000224:	0800                	addi	s0,sp,16
    const char *s;
    char *d;

    if (n == 0)
    80000226:	c205                	beqz	a2,80000246 <memmove+0x26>
        return dst;

    s = src;
    d = dst;
    if (s < d && s + n > d) {
    80000228:	02a5e263          	bltu	a1,a0,8000024c <memmove+0x2c>
        s += n;
        d += n;
        while (n-- > 0)
            *--d = *--s;
    } else
        while (n-- > 0)
    8000022c:	1602                	slli	a2,a2,0x20
    8000022e:	9201                	srli	a2,a2,0x20
    80000230:	00c587b3          	add	a5,a1,a2
void *memmove(void *dst, const void *src, uint n) {
    80000234:	872a                	mv	a4,a0
            *d++ = *s++;
    80000236:	0585                	addi	a1,a1,1
    80000238:	0705                	addi	a4,a4,1 # 1001 <_entry-0x7fffefff>
    8000023a:	fff5c683          	lbu	a3,-1(a1)
    8000023e:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
    80000242:	feb79ae3          	bne	a5,a1,80000236 <memmove+0x16>

    return dst;
}
    80000246:	6422                	ld	s0,8(sp)
    80000248:	0141                	addi	sp,sp,16
    8000024a:	8082                	ret
    if (s < d && s + n > d) {
    8000024c:	02061693          	slli	a3,a2,0x20
    80000250:	9281                	srli	a3,a3,0x20
    80000252:	00d58733          	add	a4,a1,a3
    80000256:	fce57be3          	bgeu	a0,a4,8000022c <memmove+0xc>
        d += n;
    8000025a:	96aa                	add	a3,a3,a0
        while (n-- > 0)
    8000025c:	fff6079b          	addiw	a5,a2,-1
    80000260:	1782                	slli	a5,a5,0x20
    80000262:	9381                	srli	a5,a5,0x20
    80000264:	fff7c793          	not	a5,a5
    80000268:	97ba                	add	a5,a5,a4
            *--d = *--s;
    8000026a:	177d                	addi	a4,a4,-1
    8000026c:	16fd                	addi	a3,a3,-1
    8000026e:	00074603          	lbu	a2,0(a4)
    80000272:	00c68023          	sb	a2,0(a3)
        while (n-- > 0)
    80000276:	fef71ae3          	bne	a4,a5,8000026a <memmove+0x4a>
    8000027a:	b7f1                	j	80000246 <memmove+0x26>

000000008000027c <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void *memcpy(void *dst, const void *src, uint n) {
    8000027c:	1141                	addi	sp,sp,-16
    8000027e:	e406                	sd	ra,8(sp)
    80000280:	e022                	sd	s0,0(sp)
    80000282:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
    80000284:	00000097          	auipc	ra,0x0
    80000288:	f9c080e7          	jalr	-100(ra) # 80000220 <memmove>
}
    8000028c:	60a2                	ld	ra,8(sp)
    8000028e:	6402                	ld	s0,0(sp)
    80000290:	0141                	addi	sp,sp,16
    80000292:	8082                	ret

0000000080000294 <strncmp>:

int strncmp(const char *p, const char *q, uint n) {
    80000294:	1141                	addi	sp,sp,-16
    80000296:	e422                	sd	s0,8(sp)
    80000298:	0800                	addi	s0,sp,16
    while (n > 0 && *p && *p == *q)
    8000029a:	ce11                	beqz	a2,800002b6 <strncmp+0x22>
    8000029c:	00054783          	lbu	a5,0(a0)
    800002a0:	cf89                	beqz	a5,800002ba <strncmp+0x26>
    800002a2:	0005c703          	lbu	a4,0(a1)
    800002a6:	00f71a63          	bne	a4,a5,800002ba <strncmp+0x26>
        n--, p++, q++;
    800002aa:	367d                	addiw	a2,a2,-1
    800002ac:	0505                	addi	a0,a0,1
    800002ae:	0585                	addi	a1,a1,1
    while (n > 0 && *p && *p == *q)
    800002b0:	f675                	bnez	a2,8000029c <strncmp+0x8>
    if (n == 0)
        return 0;
    800002b2:	4501                	li	a0,0
    800002b4:	a801                	j	800002c4 <strncmp+0x30>
    800002b6:	4501                	li	a0,0
    800002b8:	a031                	j	800002c4 <strncmp+0x30>
    return (uchar)*p - (uchar)*q;
    800002ba:	00054503          	lbu	a0,0(a0)
    800002be:	0005c783          	lbu	a5,0(a1)
    800002c2:	9d1d                	subw	a0,a0,a5
}
    800002c4:	6422                	ld	s0,8(sp)
    800002c6:	0141                	addi	sp,sp,16
    800002c8:	8082                	ret

00000000800002ca <strncpy>:

char *strncpy(char *s, const char *t, int n) {
    800002ca:	1141                	addi	sp,sp,-16
    800002cc:	e422                	sd	s0,8(sp)
    800002ce:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while (n-- > 0 && (*s++ = *t++) != 0)
    800002d0:	87aa                	mv	a5,a0
    800002d2:	86b2                	mv	a3,a2
    800002d4:	367d                	addiw	a2,a2,-1
    800002d6:	02d05563          	blez	a3,80000300 <strncpy+0x36>
    800002da:	0785                	addi	a5,a5,1
    800002dc:	0005c703          	lbu	a4,0(a1)
    800002e0:	fee78fa3          	sb	a4,-1(a5)
    800002e4:	0585                	addi	a1,a1,1
    800002e6:	f775                	bnez	a4,800002d2 <strncpy+0x8>
        ;
    while (n-- > 0)
    800002e8:	873e                	mv	a4,a5
    800002ea:	9fb5                	addw	a5,a5,a3
    800002ec:	37fd                	addiw	a5,a5,-1
    800002ee:	00c05963          	blez	a2,80000300 <strncpy+0x36>
        *s++ = 0;
    800002f2:	0705                	addi	a4,a4,1
    800002f4:	fe070fa3          	sb	zero,-1(a4)
    while (n-- > 0)
    800002f8:	40e786bb          	subw	a3,a5,a4
    800002fc:	fed04be3          	bgtz	a3,800002f2 <strncpy+0x28>
    return os;
}
    80000300:	6422                	ld	s0,8(sp)
    80000302:	0141                	addi	sp,sp,16
    80000304:	8082                	ret

0000000080000306 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char *safestrcpy(char *s, const char *t, int n) {
    80000306:	1141                	addi	sp,sp,-16
    80000308:	e422                	sd	s0,8(sp)
    8000030a:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    if (n <= 0)
    8000030c:	02c05363          	blez	a2,80000332 <safestrcpy+0x2c>
    80000310:	fff6069b          	addiw	a3,a2,-1
    80000314:	1682                	slli	a3,a3,0x20
    80000316:	9281                	srli	a3,a3,0x20
    80000318:	96ae                	add	a3,a3,a1
    8000031a:	87aa                	mv	a5,a0
        return os;
    while (--n > 0 && (*s++ = *t++) != 0)
    8000031c:	00d58963          	beq	a1,a3,8000032e <safestrcpy+0x28>
    80000320:	0585                	addi	a1,a1,1
    80000322:	0785                	addi	a5,a5,1
    80000324:	fff5c703          	lbu	a4,-1(a1)
    80000328:	fee78fa3          	sb	a4,-1(a5)
    8000032c:	fb65                	bnez	a4,8000031c <safestrcpy+0x16>
        ;
    *s = 0;
    8000032e:	00078023          	sb	zero,0(a5)
    return os;
}
    80000332:	6422                	ld	s0,8(sp)
    80000334:	0141                	addi	sp,sp,16
    80000336:	8082                	ret

0000000080000338 <strlen>:

int strlen(const char *s) {
    80000338:	1141                	addi	sp,sp,-16
    8000033a:	e422                	sd	s0,8(sp)
    8000033c:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
    8000033e:	00054783          	lbu	a5,0(a0)
    80000342:	cf91                	beqz	a5,8000035e <strlen+0x26>
    80000344:	0505                	addi	a0,a0,1
    80000346:	87aa                	mv	a5,a0
    80000348:	86be                	mv	a3,a5
    8000034a:	0785                	addi	a5,a5,1
    8000034c:	fff7c703          	lbu	a4,-1(a5)
    80000350:	ff65                	bnez	a4,80000348 <strlen+0x10>
    80000352:	40a6853b          	subw	a0,a3,a0
    80000356:	2505                	addiw	a0,a0,1
        ;
    return n;
}
    80000358:	6422                	ld	s0,8(sp)
    8000035a:	0141                	addi	sp,sp,16
    8000035c:	8082                	ret
    for (n = 0; s[n]; n++)
    8000035e:	4501                	li	a0,0
    80000360:	bfe5                	j	80000358 <strlen+0x20>

0000000080000362 <main>:
#include "defs.h"

volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void main() {
    80000362:	1141                	addi	sp,sp,-16
    80000364:	e406                	sd	ra,8(sp)
    80000366:	e022                	sd	s0,0(sp)
    80000368:	0800                	addi	s0,sp,16
    if (cpuid() == 0) {
    8000036a:	00001097          	auipc	ra,0x1
    8000036e:	b30080e7          	jalr	-1232(ra) # 80000e9a <cpuid>
        virtio_disk_init(); // emulated hard disk
        userinit();         // first user process
        __sync_synchronize();
        started = 1;
    } else {
        while (started == 0)
    80000372:	0000c717          	auipc	a4,0xc
    80000376:	c8e70713          	addi	a4,a4,-882 # 8000c000 <started>
    if (cpuid() == 0) {
    8000037a:	c139                	beqz	a0,800003c0 <main+0x5e>
        while (started == 0)
    8000037c:	431c                	lw	a5,0(a4)
    8000037e:	2781                	sext.w	a5,a5
    80000380:	dff5                	beqz	a5,8000037c <main+0x1a>
            ;
        __sync_synchronize();
    80000382:	0ff0000f          	fence
        printf("hart %d starting\n", cpuid());
    80000386:	00001097          	auipc	ra,0x1
    8000038a:	b14080e7          	jalr	-1260(ra) # 80000e9a <cpuid>
    8000038e:	85aa                	mv	a1,a0
    80000390:	00008517          	auipc	a0,0x8
    80000394:	ca850513          	addi	a0,a0,-856 # 80008038 <etext+0x38>
    80000398:	00006097          	auipc	ra,0x6
    8000039c:	a44080e7          	jalr	-1468(ra) # 80005ddc <printf>
        kvminithart();  // turn on paging
    800003a0:	00000097          	auipc	ra,0x0
    800003a4:	0d8080e7          	jalr	216(ra) # 80000478 <kvminithart>
        trapinithart(); // install kernel trap vector
    800003a8:	00001097          	auipc	ra,0x1
    800003ac:	7b0080e7          	jalr	1968(ra) # 80001b58 <trapinithart>
        plicinithart(); // ask PLIC for device interrupts
    800003b0:	00005097          	auipc	ra,0x5
    800003b4:	e44080e7          	jalr	-444(ra) # 800051f4 <plicinithart>
    }

    scheduler();
    800003b8:	00001097          	auipc	ra,0x1
    800003bc:	02e080e7          	jalr	46(ra) # 800013e6 <scheduler>
        consoleinit();
    800003c0:	00006097          	auipc	ra,0x6
    800003c4:	8e2080e7          	jalr	-1822(ra) # 80005ca2 <consoleinit>
        printfinit();
    800003c8:	00006097          	auipc	ra,0x6
    800003cc:	c1c080e7          	jalr	-996(ra) # 80005fe4 <printfinit>
        printf("\n");
    800003d0:	00008517          	auipc	a0,0x8
    800003d4:	c4850513          	addi	a0,a0,-952 # 80008018 <etext+0x18>
    800003d8:	00006097          	auipc	ra,0x6
    800003dc:	a04080e7          	jalr	-1532(ra) # 80005ddc <printf>
        printf("xv6 kernel is booting\n");
    800003e0:	00008517          	auipc	a0,0x8
    800003e4:	c4050513          	addi	a0,a0,-960 # 80008020 <etext+0x20>
    800003e8:	00006097          	auipc	ra,0x6
    800003ec:	9f4080e7          	jalr	-1548(ra) # 80005ddc <printf>
        printf("\n");
    800003f0:	00008517          	auipc	a0,0x8
    800003f4:	c2850513          	addi	a0,a0,-984 # 80008018 <etext+0x18>
    800003f8:	00006097          	auipc	ra,0x6
    800003fc:	9e4080e7          	jalr	-1564(ra) # 80005ddc <printf>
        kinit();            // physical page allocator
    80000400:	00000097          	auipc	ra,0x0
    80000404:	cde080e7          	jalr	-802(ra) # 800000de <kinit>
        kvminit();          // create kernel page table
    80000408:	00000097          	auipc	ra,0x0
    8000040c:	322080e7          	jalr	802(ra) # 8000072a <kvminit>
        kvminithart();      // turn on paging
    80000410:	00000097          	auipc	ra,0x0
    80000414:	068080e7          	jalr	104(ra) # 80000478 <kvminithart>
        procinit();         // process table
    80000418:	00001097          	auipc	ra,0x1
    8000041c:	9c4080e7          	jalr	-1596(ra) # 80000ddc <procinit>
        trapinit();         // trap vectors
    80000420:	00001097          	auipc	ra,0x1
    80000424:	710080e7          	jalr	1808(ra) # 80001b30 <trapinit>
        trapinithart();     // install kernel trap vector
    80000428:	00001097          	auipc	ra,0x1
    8000042c:	730080e7          	jalr	1840(ra) # 80001b58 <trapinithart>
        plicinit();         // set up interrupt controller
    80000430:	00005097          	auipc	ra,0x5
    80000434:	daa080e7          	jalr	-598(ra) # 800051da <plicinit>
        plicinithart();     // ask PLIC for device interrupts
    80000438:	00005097          	auipc	ra,0x5
    8000043c:	dbc080e7          	jalr	-580(ra) # 800051f4 <plicinithart>
        binit();            // buffer cache
    80000440:	00002097          	auipc	ra,0x2
    80000444:	ed8080e7          	jalr	-296(ra) # 80002318 <binit>
        iinit();            // inode table
    80000448:	00002097          	auipc	ra,0x2
    8000044c:	564080e7          	jalr	1380(ra) # 800029ac <iinit>
        fileinit();         // file table
    80000450:	00003097          	auipc	ra,0x3
    80000454:	508080e7          	jalr	1288(ra) # 80003958 <fileinit>
        virtio_disk_init(); // emulated hard disk
    80000458:	00005097          	auipc	ra,0x5
    8000045c:	ebc080e7          	jalr	-324(ra) # 80005314 <virtio_disk_init>
        userinit();         // first user process
    80000460:	00001097          	auipc	ra,0x1
    80000464:	d42080e7          	jalr	-702(ra) # 800011a2 <userinit>
        __sync_synchronize();
    80000468:	0ff0000f          	fence
        started = 1;
    8000046c:	4785                	li	a5,1
    8000046e:	0000c717          	auipc	a4,0xc
    80000472:	b8f72923          	sw	a5,-1134(a4) # 8000c000 <started>
    80000476:	b789                	j	800003b8 <main+0x56>

0000000080000478 <kvminithart>:
// Initialize the one kernel_pagetable
void kvminit(void) { kernel_pagetable = kvmmake(); }

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void kvminithart() {
    80000478:	1141                	addi	sp,sp,-16
    8000047a:	e422                	sd	s0,8(sp)
    8000047c:	0800                	addi	s0,sp,16
    w_satp(MAKE_SATP(kernel_pagetable));
    8000047e:	0000c797          	auipc	a5,0xc
    80000482:	b8a7b783          	ld	a5,-1142(a5) # 8000c008 <kernel_pagetable>
    80000486:	83b1                	srli	a5,a5,0xc
    80000488:	577d                	li	a4,-1
    8000048a:	177e                	slli	a4,a4,0x3f
    8000048c:	8fd9                	or	a5,a5,a4
#define MAKE_SATP(pagetable) (SATP_SV39 | (((uint64)pagetable) >> 12))

// supervisor address translation and protection;
// holds the address of the page table.
static inline void w_satp(uint64 x) {
    asm volatile("csrw satp, %0" : : "r"(x));
    8000048e:	18079073          	csrw	satp,a5
}

// flush the TLB.
static inline void sfence_vma() {
    // the zero, zero means flush all TLB entries.
    asm volatile("sfence.vma zero, zero");
    80000492:	12000073          	sfence.vma
    sfence_vma();
}
    80000496:	6422                	ld	s0,8(sp)
    80000498:	0141                	addi	sp,sp,16
    8000049a:	8082                	ret

000000008000049c <walk>:
//   39..63 -- must be zero.
//   30..38 -- 9 bits of level-2 index.
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *walk(pagetable_t pagetable, uint64 va, int alloc) {
    8000049c:	7139                	addi	sp,sp,-64
    8000049e:	fc06                	sd	ra,56(sp)
    800004a0:	f822                	sd	s0,48(sp)
    800004a2:	f426                	sd	s1,40(sp)
    800004a4:	f04a                	sd	s2,32(sp)
    800004a6:	ec4e                	sd	s3,24(sp)
    800004a8:	e852                	sd	s4,16(sp)
    800004aa:	e456                	sd	s5,8(sp)
    800004ac:	e05a                	sd	s6,0(sp)
    800004ae:	0080                	addi	s0,sp,64
    800004b0:	84aa                	mv	s1,a0
    800004b2:	89ae                	mv	s3,a1
    800004b4:	8ab2                	mv	s5,a2
    if (va >= MAXVA)
    800004b6:	57fd                	li	a5,-1
    800004b8:	83e9                	srli	a5,a5,0x1a
    800004ba:	4a79                	li	s4,30
        panic("walk");

    for (int level = 2; level > 0; level--) {
    800004bc:	4b31                	li	s6,12
    if (va >= MAXVA)
    800004be:	04b7f263          	bgeu	a5,a1,80000502 <walk+0x66>
        panic("walk");
    800004c2:	00008517          	auipc	a0,0x8
    800004c6:	b8e50513          	addi	a0,a0,-1138 # 80008050 <etext+0x50>
    800004ca:	00006097          	auipc	ra,0x6
    800004ce:	8c8080e7          	jalr	-1848(ra) # 80005d92 <panic>
        pte_t *pte = &pagetable[PX(level, va)];
        if (*pte & PTE_V) {
            pagetable = (pagetable_t)PTE2PA(*pte);
        } else {
            if (!alloc || (pagetable = (pde_t *)kalloc()) == 0)
    800004d2:	060a8663          	beqz	s5,8000053e <walk+0xa2>
    800004d6:	00000097          	auipc	ra,0x0
    800004da:	c44080e7          	jalr	-956(ra) # 8000011a <kalloc>
    800004de:	84aa                	mv	s1,a0
    800004e0:	c529                	beqz	a0,8000052a <walk+0x8e>
                return 0;
            memset(pagetable, 0, PGSIZE);
    800004e2:	6605                	lui	a2,0x1
    800004e4:	4581                	li	a1,0
    800004e6:	00000097          	auipc	ra,0x0
    800004ea:	cde080e7          	jalr	-802(ra) # 800001c4 <memset>
            *pte = PA2PTE(pagetable) | PTE_V;
    800004ee:	00c4d793          	srli	a5,s1,0xc
    800004f2:	07aa                	slli	a5,a5,0xa
    800004f4:	0017e793          	ori	a5,a5,1
    800004f8:	00f93023          	sd	a5,0(s2)
    for (int level = 2; level > 0; level--) {
    800004fc:	3a5d                	addiw	s4,s4,-9 # ffffffffffffeff7 <end+0xffffffff7ffd5db7>
    800004fe:	036a0063          	beq	s4,s6,8000051e <walk+0x82>
        pte_t *pte = &pagetable[PX(level, va)];
    80000502:	0149d933          	srl	s2,s3,s4
    80000506:	1ff97913          	andi	s2,s2,511
    8000050a:	090e                	slli	s2,s2,0x3
    8000050c:	9926                	add	s2,s2,s1
        if (*pte & PTE_V) {
    8000050e:	00093483          	ld	s1,0(s2)
    80000512:	0014f793          	andi	a5,s1,1
    80000516:	dfd5                	beqz	a5,800004d2 <walk+0x36>
            pagetable = (pagetable_t)PTE2PA(*pte);
    80000518:	80a9                	srli	s1,s1,0xa
    8000051a:	04b2                	slli	s1,s1,0xc
    8000051c:	b7c5                	j	800004fc <walk+0x60>
        }
    }
    return &pagetable[PX(0, va)];
    8000051e:	00c9d513          	srli	a0,s3,0xc
    80000522:	1ff57513          	andi	a0,a0,511
    80000526:	050e                	slli	a0,a0,0x3
    80000528:	9526                	add	a0,a0,s1
}
    8000052a:	70e2                	ld	ra,56(sp)
    8000052c:	7442                	ld	s0,48(sp)
    8000052e:	74a2                	ld	s1,40(sp)
    80000530:	7902                	ld	s2,32(sp)
    80000532:	69e2                	ld	s3,24(sp)
    80000534:	6a42                	ld	s4,16(sp)
    80000536:	6aa2                	ld	s5,8(sp)
    80000538:	6b02                	ld	s6,0(sp)
    8000053a:	6121                	addi	sp,sp,64
    8000053c:	8082                	ret
                return 0;
    8000053e:	4501                	li	a0,0
    80000540:	b7ed                	j	8000052a <walk+0x8e>

0000000080000542 <walkaddr>:
// Can only be used to look up user pages.
uint64 walkaddr(pagetable_t pagetable, uint64 va) {
    pte_t *pte;
    uint64 pa;

    if (va >= MAXVA)
    80000542:	57fd                	li	a5,-1
    80000544:	83e9                	srli	a5,a5,0x1a
    80000546:	00b7f463          	bgeu	a5,a1,8000054e <walkaddr+0xc>
        return 0;
    8000054a:	4501                	li	a0,0
        return 0;
    if ((*pte & PTE_U) == 0)
        return 0;
    pa = PTE2PA(*pte);
    return pa;
}
    8000054c:	8082                	ret
uint64 walkaddr(pagetable_t pagetable, uint64 va) {
    8000054e:	1141                	addi	sp,sp,-16
    80000550:	e406                	sd	ra,8(sp)
    80000552:	e022                	sd	s0,0(sp)
    80000554:	0800                	addi	s0,sp,16
    pte = walk(pagetable, va, 0);
    80000556:	4601                	li	a2,0
    80000558:	00000097          	auipc	ra,0x0
    8000055c:	f44080e7          	jalr	-188(ra) # 8000049c <walk>
    if (pte == 0)
    80000560:	c105                	beqz	a0,80000580 <walkaddr+0x3e>
    if ((*pte & PTE_V) == 0)
    80000562:	611c                	ld	a5,0(a0)
    if ((*pte & PTE_U) == 0)
    80000564:	0117f693          	andi	a3,a5,17
    80000568:	4745                	li	a4,17
        return 0;
    8000056a:	4501                	li	a0,0
    if ((*pte & PTE_U) == 0)
    8000056c:	00e68663          	beq	a3,a4,80000578 <walkaddr+0x36>
}
    80000570:	60a2                	ld	ra,8(sp)
    80000572:	6402                	ld	s0,0(sp)
    80000574:	0141                	addi	sp,sp,16
    80000576:	8082                	ret
    pa = PTE2PA(*pte);
    80000578:	83a9                	srli	a5,a5,0xa
    8000057a:	00c79513          	slli	a0,a5,0xc
    return pa;
    8000057e:	bfcd                	j	80000570 <walkaddr+0x2e>
        return 0;
    80000580:	4501                	li	a0,0
    80000582:	b7fd                	j	80000570 <walkaddr+0x2e>

0000000080000584 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa,
             int perm) {
    80000584:	715d                	addi	sp,sp,-80
    80000586:	e486                	sd	ra,72(sp)
    80000588:	e0a2                	sd	s0,64(sp)
    8000058a:	fc26                	sd	s1,56(sp)
    8000058c:	f84a                	sd	s2,48(sp)
    8000058e:	f44e                	sd	s3,40(sp)
    80000590:	f052                	sd	s4,32(sp)
    80000592:	ec56                	sd	s5,24(sp)
    80000594:	e85a                	sd	s6,16(sp)
    80000596:	e45e                	sd	s7,8(sp)
    80000598:	0880                	addi	s0,sp,80
    uint64 a, last;
    pte_t *pte;

    if (size == 0)
    8000059a:	c639                	beqz	a2,800005e8 <mappages+0x64>
    8000059c:	8aaa                	mv	s5,a0
    8000059e:	8b3a                	mv	s6,a4
        panic("mappages: size");

    a = PGROUNDDOWN(va);
    800005a0:	777d                	lui	a4,0xfffff
    800005a2:	00e5f7b3          	and	a5,a1,a4
    last = PGROUNDDOWN(va + size - 1);
    800005a6:	fff58993          	addi	s3,a1,-1
    800005aa:	99b2                	add	s3,s3,a2
    800005ac:	00e9f9b3          	and	s3,s3,a4
    a = PGROUNDDOWN(va);
    800005b0:	893e                	mv	s2,a5
    800005b2:	40f68a33          	sub	s4,a3,a5
        if (*pte & PTE_V)
            panic("mappages: remap");
        *pte = PA2PTE(pa) | perm | PTE_V;
        if (a == last)
            break;
        a += PGSIZE;
    800005b6:	6b85                	lui	s7,0x1
    800005b8:	014904b3          	add	s1,s2,s4
        if ((pte = walk(pagetable, a, 1)) == 0)
    800005bc:	4605                	li	a2,1
    800005be:	85ca                	mv	a1,s2
    800005c0:	8556                	mv	a0,s5
    800005c2:	00000097          	auipc	ra,0x0
    800005c6:	eda080e7          	jalr	-294(ra) # 8000049c <walk>
    800005ca:	cd1d                	beqz	a0,80000608 <mappages+0x84>
        if (*pte & PTE_V)
    800005cc:	611c                	ld	a5,0(a0)
    800005ce:	8b85                	andi	a5,a5,1
    800005d0:	e785                	bnez	a5,800005f8 <mappages+0x74>
        *pte = PA2PTE(pa) | perm | PTE_V;
    800005d2:	80b1                	srli	s1,s1,0xc
    800005d4:	04aa                	slli	s1,s1,0xa
    800005d6:	0164e4b3          	or	s1,s1,s6
    800005da:	0014e493          	ori	s1,s1,1
    800005de:	e104                	sd	s1,0(a0)
        if (a == last)
    800005e0:	05390063          	beq	s2,s3,80000620 <mappages+0x9c>
        a += PGSIZE;
    800005e4:	995e                	add	s2,s2,s7
        if ((pte = walk(pagetable, a, 1)) == 0)
    800005e6:	bfc9                	j	800005b8 <mappages+0x34>
        panic("mappages: size");
    800005e8:	00008517          	auipc	a0,0x8
    800005ec:	a7050513          	addi	a0,a0,-1424 # 80008058 <etext+0x58>
    800005f0:	00005097          	auipc	ra,0x5
    800005f4:	7a2080e7          	jalr	1954(ra) # 80005d92 <panic>
            panic("mappages: remap");
    800005f8:	00008517          	auipc	a0,0x8
    800005fc:	a7050513          	addi	a0,a0,-1424 # 80008068 <etext+0x68>
    80000600:	00005097          	auipc	ra,0x5
    80000604:	792080e7          	jalr	1938(ra) # 80005d92 <panic>
            return -1;
    80000608:	557d                	li	a0,-1
        pa += PGSIZE;
    }
    return 0;
}
    8000060a:	60a6                	ld	ra,72(sp)
    8000060c:	6406                	ld	s0,64(sp)
    8000060e:	74e2                	ld	s1,56(sp)
    80000610:	7942                	ld	s2,48(sp)
    80000612:	79a2                	ld	s3,40(sp)
    80000614:	7a02                	ld	s4,32(sp)
    80000616:	6ae2                	ld	s5,24(sp)
    80000618:	6b42                	ld	s6,16(sp)
    8000061a:	6ba2                	ld	s7,8(sp)
    8000061c:	6161                	addi	sp,sp,80
    8000061e:	8082                	ret
    return 0;
    80000620:	4501                	li	a0,0
    80000622:	b7e5                	j	8000060a <mappages+0x86>

0000000080000624 <kvmmap>:
void kvmmap(pagetable_t kpgtbl, uint64 va, uint64 pa, uint64 sz, int perm) {
    80000624:	1141                	addi	sp,sp,-16
    80000626:	e406                	sd	ra,8(sp)
    80000628:	e022                	sd	s0,0(sp)
    8000062a:	0800                	addi	s0,sp,16
    8000062c:	87b6                	mv	a5,a3
    if (mappages(kpgtbl, va, sz, pa, perm) != 0)
    8000062e:	86b2                	mv	a3,a2
    80000630:	863e                	mv	a2,a5
    80000632:	00000097          	auipc	ra,0x0
    80000636:	f52080e7          	jalr	-174(ra) # 80000584 <mappages>
    8000063a:	e509                	bnez	a0,80000644 <kvmmap+0x20>
}
    8000063c:	60a2                	ld	ra,8(sp)
    8000063e:	6402                	ld	s0,0(sp)
    80000640:	0141                	addi	sp,sp,16
    80000642:	8082                	ret
        panic("kvmmap");
    80000644:	00008517          	auipc	a0,0x8
    80000648:	a3450513          	addi	a0,a0,-1484 # 80008078 <etext+0x78>
    8000064c:	00005097          	auipc	ra,0x5
    80000650:	746080e7          	jalr	1862(ra) # 80005d92 <panic>

0000000080000654 <kvmmake>:
pagetable_t kvmmake(void) {
    80000654:	1101                	addi	sp,sp,-32
    80000656:	ec06                	sd	ra,24(sp)
    80000658:	e822                	sd	s0,16(sp)
    8000065a:	e426                	sd	s1,8(sp)
    8000065c:	e04a                	sd	s2,0(sp)
    8000065e:	1000                	addi	s0,sp,32
    kpgtbl = (pagetable_t)kalloc();
    80000660:	00000097          	auipc	ra,0x0
    80000664:	aba080e7          	jalr	-1350(ra) # 8000011a <kalloc>
    80000668:	84aa                	mv	s1,a0
    memset(kpgtbl, 0, PGSIZE);
    8000066a:	6605                	lui	a2,0x1
    8000066c:	4581                	li	a1,0
    8000066e:	00000097          	auipc	ra,0x0
    80000672:	b56080e7          	jalr	-1194(ra) # 800001c4 <memset>
    kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80000676:	4719                	li	a4,6
    80000678:	6685                	lui	a3,0x1
    8000067a:	10000637          	lui	a2,0x10000
    8000067e:	100005b7          	lui	a1,0x10000
    80000682:	8526                	mv	a0,s1
    80000684:	00000097          	auipc	ra,0x0
    80000688:	fa0080e7          	jalr	-96(ra) # 80000624 <kvmmap>
    kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    8000068c:	4719                	li	a4,6
    8000068e:	6685                	lui	a3,0x1
    80000690:	10001637          	lui	a2,0x10001
    80000694:	100015b7          	lui	a1,0x10001
    80000698:	8526                	mv	a0,s1
    8000069a:	00000097          	auipc	ra,0x0
    8000069e:	f8a080e7          	jalr	-118(ra) # 80000624 <kvmmap>
    kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    800006a2:	4719                	li	a4,6
    800006a4:	004006b7          	lui	a3,0x400
    800006a8:	0c000637          	lui	a2,0xc000
    800006ac:	0c0005b7          	lui	a1,0xc000
    800006b0:	8526                	mv	a0,s1
    800006b2:	00000097          	auipc	ra,0x0
    800006b6:	f72080e7          	jalr	-142(ra) # 80000624 <kvmmap>
    kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext - KERNBASE, PTE_R | PTE_X);
    800006ba:	00008917          	auipc	s2,0x8
    800006be:	94690913          	addi	s2,s2,-1722 # 80008000 <etext>
    800006c2:	4729                	li	a4,10
    800006c4:	80008697          	auipc	a3,0x80008
    800006c8:	93c68693          	addi	a3,a3,-1732 # 8000 <_entry-0x7fff8000>
    800006cc:	4605                	li	a2,1
    800006ce:	067e                	slli	a2,a2,0x1f
    800006d0:	85b2                	mv	a1,a2
    800006d2:	8526                	mv	a0,s1
    800006d4:	00000097          	auipc	ra,0x0
    800006d8:	f50080e7          	jalr	-176(ra) # 80000624 <kvmmap>
    kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP - (uint64)etext,
    800006dc:	46c5                	li	a3,17
    800006de:	06ee                	slli	a3,a3,0x1b
    800006e0:	4719                	li	a4,6
    800006e2:	412686b3          	sub	a3,a3,s2
    800006e6:	864a                	mv	a2,s2
    800006e8:	85ca                	mv	a1,s2
    800006ea:	8526                	mv	a0,s1
    800006ec:	00000097          	auipc	ra,0x0
    800006f0:	f38080e7          	jalr	-200(ra) # 80000624 <kvmmap>
    kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800006f4:	4729                	li	a4,10
    800006f6:	6685                	lui	a3,0x1
    800006f8:	00007617          	auipc	a2,0x7
    800006fc:	90860613          	addi	a2,a2,-1784 # 80007000 <_trampoline>
    80000700:	040005b7          	lui	a1,0x4000
    80000704:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000706:	05b2                	slli	a1,a1,0xc
    80000708:	8526                	mv	a0,s1
    8000070a:	00000097          	auipc	ra,0x0
    8000070e:	f1a080e7          	jalr	-230(ra) # 80000624 <kvmmap>
    proc_mapstacks(kpgtbl);
    80000712:	8526                	mv	a0,s1
    80000714:	00000097          	auipc	ra,0x0
    80000718:	624080e7          	jalr	1572(ra) # 80000d38 <proc_mapstacks>
}
    8000071c:	8526                	mv	a0,s1
    8000071e:	60e2                	ld	ra,24(sp)
    80000720:	6442                	ld	s0,16(sp)
    80000722:	64a2                	ld	s1,8(sp)
    80000724:	6902                	ld	s2,0(sp)
    80000726:	6105                	addi	sp,sp,32
    80000728:	8082                	ret

000000008000072a <kvminit>:
void kvminit(void) { kernel_pagetable = kvmmake(); }
    8000072a:	1141                	addi	sp,sp,-16
    8000072c:	e406                	sd	ra,8(sp)
    8000072e:	e022                	sd	s0,0(sp)
    80000730:	0800                	addi	s0,sp,16
    80000732:	00000097          	auipc	ra,0x0
    80000736:	f22080e7          	jalr	-222(ra) # 80000654 <kvmmake>
    8000073a:	0000c797          	auipc	a5,0xc
    8000073e:	8ca7b723          	sd	a0,-1842(a5) # 8000c008 <kernel_pagetable>
    80000742:	60a2                	ld	ra,8(sp)
    80000744:	6402                	ld	s0,0(sp)
    80000746:	0141                	addi	sp,sp,16
    80000748:	8082                	ret

000000008000074a <uvmunmap>:

// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free) {
    8000074a:	715d                	addi	sp,sp,-80
    8000074c:	e486                	sd	ra,72(sp)
    8000074e:	e0a2                	sd	s0,64(sp)
    80000750:	0880                	addi	s0,sp,80
    uint64 a;
    pte_t *pte;

    if ((va % PGSIZE) != 0)
    80000752:	03459793          	slli	a5,a1,0x34
    80000756:	e39d                	bnez	a5,8000077c <uvmunmap+0x32>
    80000758:	f84a                	sd	s2,48(sp)
    8000075a:	f44e                	sd	s3,40(sp)
    8000075c:	f052                	sd	s4,32(sp)
    8000075e:	ec56                	sd	s5,24(sp)
    80000760:	e85a                	sd	s6,16(sp)
    80000762:	e45e                	sd	s7,8(sp)
    80000764:	8a2a                	mv	s4,a0
    80000766:	892e                	mv	s2,a1
    80000768:	8ab6                	mv	s5,a3
        panic("uvmunmap: not aligned");

    for (a = va; a < va + npages * PGSIZE; a += PGSIZE) {
    8000076a:	0632                	slli	a2,a2,0xc
    8000076c:	00b609b3          	add	s3,a2,a1
        if ((pte = walk(pagetable, a, 0)) == 0)
            panic("uvmunmap: walk");
        if ((*pte & PTE_V) == 0)
            panic("uvmunmap: not mapped");
        if (PTE_FLAGS(*pte) == PTE_V)
    80000770:	4b85                	li	s7,1
    for (a = va; a < va + npages * PGSIZE; a += PGSIZE) {
    80000772:	6b05                	lui	s6,0x1
    80000774:	0935fb63          	bgeu	a1,s3,8000080a <uvmunmap+0xc0>
    80000778:	fc26                	sd	s1,56(sp)
    8000077a:	a8a9                	j	800007d4 <uvmunmap+0x8a>
    8000077c:	fc26                	sd	s1,56(sp)
    8000077e:	f84a                	sd	s2,48(sp)
    80000780:	f44e                	sd	s3,40(sp)
    80000782:	f052                	sd	s4,32(sp)
    80000784:	ec56                	sd	s5,24(sp)
    80000786:	e85a                	sd	s6,16(sp)
    80000788:	e45e                	sd	s7,8(sp)
        panic("uvmunmap: not aligned");
    8000078a:	00008517          	auipc	a0,0x8
    8000078e:	8f650513          	addi	a0,a0,-1802 # 80008080 <etext+0x80>
    80000792:	00005097          	auipc	ra,0x5
    80000796:	600080e7          	jalr	1536(ra) # 80005d92 <panic>
            panic("uvmunmap: walk");
    8000079a:	00008517          	auipc	a0,0x8
    8000079e:	8fe50513          	addi	a0,a0,-1794 # 80008098 <etext+0x98>
    800007a2:	00005097          	auipc	ra,0x5
    800007a6:	5f0080e7          	jalr	1520(ra) # 80005d92 <panic>
            panic("uvmunmap: not mapped");
    800007aa:	00008517          	auipc	a0,0x8
    800007ae:	8fe50513          	addi	a0,a0,-1794 # 800080a8 <etext+0xa8>
    800007b2:	00005097          	auipc	ra,0x5
    800007b6:	5e0080e7          	jalr	1504(ra) # 80005d92 <panic>
            panic("uvmunmap: not a leaf");
    800007ba:	00008517          	auipc	a0,0x8
    800007be:	90650513          	addi	a0,a0,-1786 # 800080c0 <etext+0xc0>
    800007c2:	00005097          	auipc	ra,0x5
    800007c6:	5d0080e7          	jalr	1488(ra) # 80005d92 <panic>
        if (do_free) {
            uint64 pa = PTE2PA(*pte);
            kfree((void *)pa);
        }
        *pte = 0;
    800007ca:	0004b023          	sd	zero,0(s1)
    for (a = va; a < va + npages * PGSIZE; a += PGSIZE) {
    800007ce:	995a                	add	s2,s2,s6
    800007d0:	03397c63          	bgeu	s2,s3,80000808 <uvmunmap+0xbe>
        if ((pte = walk(pagetable, a, 0)) == 0)
    800007d4:	4601                	li	a2,0
    800007d6:	85ca                	mv	a1,s2
    800007d8:	8552                	mv	a0,s4
    800007da:	00000097          	auipc	ra,0x0
    800007de:	cc2080e7          	jalr	-830(ra) # 8000049c <walk>
    800007e2:	84aa                	mv	s1,a0
    800007e4:	d95d                	beqz	a0,8000079a <uvmunmap+0x50>
        if ((*pte & PTE_V) == 0)
    800007e6:	6108                	ld	a0,0(a0)
    800007e8:	00157793          	andi	a5,a0,1
    800007ec:	dfdd                	beqz	a5,800007aa <uvmunmap+0x60>
        if (PTE_FLAGS(*pte) == PTE_V)
    800007ee:	3ff57793          	andi	a5,a0,1023
    800007f2:	fd7784e3          	beq	a5,s7,800007ba <uvmunmap+0x70>
        if (do_free) {
    800007f6:	fc0a8ae3          	beqz	s5,800007ca <uvmunmap+0x80>
            uint64 pa = PTE2PA(*pte);
    800007fa:	8129                	srli	a0,a0,0xa
            kfree((void *)pa);
    800007fc:	0532                	slli	a0,a0,0xc
    800007fe:	00000097          	auipc	ra,0x0
    80000802:	81e080e7          	jalr	-2018(ra) # 8000001c <kfree>
    80000806:	b7d1                	j	800007ca <uvmunmap+0x80>
    80000808:	74e2                	ld	s1,56(sp)
    8000080a:	7942                	ld	s2,48(sp)
    8000080c:	79a2                	ld	s3,40(sp)
    8000080e:	7a02                	ld	s4,32(sp)
    80000810:	6ae2                	ld	s5,24(sp)
    80000812:	6b42                	ld	s6,16(sp)
    80000814:	6ba2                	ld	s7,8(sp)
    }
}
    80000816:	60a6                	ld	ra,72(sp)
    80000818:	6406                	ld	s0,64(sp)
    8000081a:	6161                	addi	sp,sp,80
    8000081c:	8082                	ret

000000008000081e <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t uvmcreate() {
    8000081e:	1101                	addi	sp,sp,-32
    80000820:	ec06                	sd	ra,24(sp)
    80000822:	e822                	sd	s0,16(sp)
    80000824:	e426                	sd	s1,8(sp)
    80000826:	1000                	addi	s0,sp,32
    pagetable_t pagetable;
    pagetable = (pagetable_t)kalloc();
    80000828:	00000097          	auipc	ra,0x0
    8000082c:	8f2080e7          	jalr	-1806(ra) # 8000011a <kalloc>
    80000830:	84aa                	mv	s1,a0
    if (pagetable == 0)
    80000832:	c519                	beqz	a0,80000840 <uvmcreate+0x22>
        return 0;
    memset(pagetable, 0, PGSIZE);
    80000834:	6605                	lui	a2,0x1
    80000836:	4581                	li	a1,0
    80000838:	00000097          	auipc	ra,0x0
    8000083c:	98c080e7          	jalr	-1652(ra) # 800001c4 <memset>
    return pagetable;
}
    80000840:	8526                	mv	a0,s1
    80000842:	60e2                	ld	ra,24(sp)
    80000844:	6442                	ld	s0,16(sp)
    80000846:	64a2                	ld	s1,8(sp)
    80000848:	6105                	addi	sp,sp,32
    8000084a:	8082                	ret

000000008000084c <uvminit>:

// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void uvminit(pagetable_t pagetable, uchar *src, uint sz) {
    8000084c:	7179                	addi	sp,sp,-48
    8000084e:	f406                	sd	ra,40(sp)
    80000850:	f022                	sd	s0,32(sp)
    80000852:	ec26                	sd	s1,24(sp)
    80000854:	e84a                	sd	s2,16(sp)
    80000856:	e44e                	sd	s3,8(sp)
    80000858:	e052                	sd	s4,0(sp)
    8000085a:	1800                	addi	s0,sp,48
    char *mem;

    if (sz >= PGSIZE)
    8000085c:	6785                	lui	a5,0x1
    8000085e:	04f67863          	bgeu	a2,a5,800008ae <uvminit+0x62>
    80000862:	8a2a                	mv	s4,a0
    80000864:	89ae                	mv	s3,a1
    80000866:	84b2                	mv	s1,a2
        panic("inituvm: more than a page");
    mem = kalloc();
    80000868:	00000097          	auipc	ra,0x0
    8000086c:	8b2080e7          	jalr	-1870(ra) # 8000011a <kalloc>
    80000870:	892a                	mv	s2,a0
    memset(mem, 0, PGSIZE);
    80000872:	6605                	lui	a2,0x1
    80000874:	4581                	li	a1,0
    80000876:	00000097          	auipc	ra,0x0
    8000087a:	94e080e7          	jalr	-1714(ra) # 800001c4 <memset>
    mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W | PTE_R | PTE_X | PTE_U);
    8000087e:	4779                	li	a4,30
    80000880:	86ca                	mv	a3,s2
    80000882:	6605                	lui	a2,0x1
    80000884:	4581                	li	a1,0
    80000886:	8552                	mv	a0,s4
    80000888:	00000097          	auipc	ra,0x0
    8000088c:	cfc080e7          	jalr	-772(ra) # 80000584 <mappages>
    memmove(mem, src, sz);
    80000890:	8626                	mv	a2,s1
    80000892:	85ce                	mv	a1,s3
    80000894:	854a                	mv	a0,s2
    80000896:	00000097          	auipc	ra,0x0
    8000089a:	98a080e7          	jalr	-1654(ra) # 80000220 <memmove>
}
    8000089e:	70a2                	ld	ra,40(sp)
    800008a0:	7402                	ld	s0,32(sp)
    800008a2:	64e2                	ld	s1,24(sp)
    800008a4:	6942                	ld	s2,16(sp)
    800008a6:	69a2                	ld	s3,8(sp)
    800008a8:	6a02                	ld	s4,0(sp)
    800008aa:	6145                	addi	sp,sp,48
    800008ac:	8082                	ret
        panic("inituvm: more than a page");
    800008ae:	00008517          	auipc	a0,0x8
    800008b2:	82a50513          	addi	a0,a0,-2006 # 800080d8 <etext+0xd8>
    800008b6:	00005097          	auipc	ra,0x5
    800008ba:	4dc080e7          	jalr	1244(ra) # 80005d92 <panic>

00000000800008be <uvmdealloc>:

// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64 uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz) {
    800008be:	1101                	addi	sp,sp,-32
    800008c0:	ec06                	sd	ra,24(sp)
    800008c2:	e822                	sd	s0,16(sp)
    800008c4:	e426                	sd	s1,8(sp)
    800008c6:	1000                	addi	s0,sp,32
    if (newsz >= oldsz)
        return oldsz;
    800008c8:	84ae                	mv	s1,a1
    if (newsz >= oldsz)
    800008ca:	00b67d63          	bgeu	a2,a1,800008e4 <uvmdealloc+0x26>
    800008ce:	84b2                	mv	s1,a2

    if (PGROUNDUP(newsz) < PGROUNDUP(oldsz)) {
    800008d0:	6785                	lui	a5,0x1
    800008d2:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800008d4:	00f60733          	add	a4,a2,a5
    800008d8:	76fd                	lui	a3,0xfffff
    800008da:	8f75                	and	a4,a4,a3
    800008dc:	97ae                	add	a5,a5,a1
    800008de:	8ff5                	and	a5,a5,a3
    800008e0:	00f76863          	bltu	a4,a5,800008f0 <uvmdealloc+0x32>
        int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
        uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    }

    return newsz;
}
    800008e4:	8526                	mv	a0,s1
    800008e6:	60e2                	ld	ra,24(sp)
    800008e8:	6442                	ld	s0,16(sp)
    800008ea:	64a2                	ld	s1,8(sp)
    800008ec:	6105                	addi	sp,sp,32
    800008ee:	8082                	ret
        int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800008f0:	8f99                	sub	a5,a5,a4
    800008f2:	83b1                	srli	a5,a5,0xc
        uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800008f4:	4685                	li	a3,1
    800008f6:	0007861b          	sext.w	a2,a5
    800008fa:	85ba                	mv	a1,a4
    800008fc:	00000097          	auipc	ra,0x0
    80000900:	e4e080e7          	jalr	-434(ra) # 8000074a <uvmunmap>
    80000904:	b7c5                	j	800008e4 <uvmdealloc+0x26>

0000000080000906 <uvmalloc>:
    if (newsz < oldsz)
    80000906:	0ab66563          	bltu	a2,a1,800009b0 <uvmalloc+0xaa>
uint64 uvmalloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz) {
    8000090a:	7139                	addi	sp,sp,-64
    8000090c:	fc06                	sd	ra,56(sp)
    8000090e:	f822                	sd	s0,48(sp)
    80000910:	ec4e                	sd	s3,24(sp)
    80000912:	e852                	sd	s4,16(sp)
    80000914:	e456                	sd	s5,8(sp)
    80000916:	0080                	addi	s0,sp,64
    80000918:	8aaa                	mv	s5,a0
    8000091a:	8a32                	mv	s4,a2
    oldsz = PGROUNDUP(oldsz);
    8000091c:	6785                	lui	a5,0x1
    8000091e:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000920:	95be                	add	a1,a1,a5
    80000922:	77fd                	lui	a5,0xfffff
    80000924:	00f5f9b3          	and	s3,a1,a5
    for (a = oldsz; a < newsz; a += PGSIZE) {
    80000928:	08c9f663          	bgeu	s3,a2,800009b4 <uvmalloc+0xae>
    8000092c:	f426                	sd	s1,40(sp)
    8000092e:	f04a                	sd	s2,32(sp)
    80000930:	894e                	mv	s2,s3
        mem = kalloc();
    80000932:	fffff097          	auipc	ra,0xfffff
    80000936:	7e8080e7          	jalr	2024(ra) # 8000011a <kalloc>
    8000093a:	84aa                	mv	s1,a0
        if (mem == 0) {
    8000093c:	c90d                	beqz	a0,8000096e <uvmalloc+0x68>
        memset(mem, 0, PGSIZE);
    8000093e:	6605                	lui	a2,0x1
    80000940:	4581                	li	a1,0
    80000942:	00000097          	auipc	ra,0x0
    80000946:	882080e7          	jalr	-1918(ra) # 800001c4 <memset>
        if (mappages(pagetable, a, PGSIZE, (uint64)mem,
    8000094a:	4779                	li	a4,30
    8000094c:	86a6                	mv	a3,s1
    8000094e:	6605                	lui	a2,0x1
    80000950:	85ca                	mv	a1,s2
    80000952:	8556                	mv	a0,s5
    80000954:	00000097          	auipc	ra,0x0
    80000958:	c30080e7          	jalr	-976(ra) # 80000584 <mappages>
    8000095c:	e915                	bnez	a0,80000990 <uvmalloc+0x8a>
    for (a = oldsz; a < newsz; a += PGSIZE) {
    8000095e:	6785                	lui	a5,0x1
    80000960:	993e                	add	s2,s2,a5
    80000962:	fd4968e3          	bltu	s2,s4,80000932 <uvmalloc+0x2c>
    return newsz;
    80000966:	8552                	mv	a0,s4
    80000968:	74a2                	ld	s1,40(sp)
    8000096a:	7902                	ld	s2,32(sp)
    8000096c:	a819                	j	80000982 <uvmalloc+0x7c>
            uvmdealloc(pagetable, a, oldsz);
    8000096e:	864e                	mv	a2,s3
    80000970:	85ca                	mv	a1,s2
    80000972:	8556                	mv	a0,s5
    80000974:	00000097          	auipc	ra,0x0
    80000978:	f4a080e7          	jalr	-182(ra) # 800008be <uvmdealloc>
            return 0;
    8000097c:	4501                	li	a0,0
    8000097e:	74a2                	ld	s1,40(sp)
    80000980:	7902                	ld	s2,32(sp)
}
    80000982:	70e2                	ld	ra,56(sp)
    80000984:	7442                	ld	s0,48(sp)
    80000986:	69e2                	ld	s3,24(sp)
    80000988:	6a42                	ld	s4,16(sp)
    8000098a:	6aa2                	ld	s5,8(sp)
    8000098c:	6121                	addi	sp,sp,64
    8000098e:	8082                	ret
            kfree(mem);
    80000990:	8526                	mv	a0,s1
    80000992:	fffff097          	auipc	ra,0xfffff
    80000996:	68a080e7          	jalr	1674(ra) # 8000001c <kfree>
            uvmdealloc(pagetable, a, oldsz);
    8000099a:	864e                	mv	a2,s3
    8000099c:	85ca                	mv	a1,s2
    8000099e:	8556                	mv	a0,s5
    800009a0:	00000097          	auipc	ra,0x0
    800009a4:	f1e080e7          	jalr	-226(ra) # 800008be <uvmdealloc>
            return 0;
    800009a8:	4501                	li	a0,0
    800009aa:	74a2                	ld	s1,40(sp)
    800009ac:	7902                	ld	s2,32(sp)
    800009ae:	bfd1                	j	80000982 <uvmalloc+0x7c>
        return oldsz;
    800009b0:	852e                	mv	a0,a1
}
    800009b2:	8082                	ret
    return newsz;
    800009b4:	8532                	mv	a0,a2
    800009b6:	b7f1                	j	80000982 <uvmalloc+0x7c>

00000000800009b8 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void freewalk(pagetable_t pagetable) {
    800009b8:	7179                	addi	sp,sp,-48
    800009ba:	f406                	sd	ra,40(sp)
    800009bc:	f022                	sd	s0,32(sp)
    800009be:	ec26                	sd	s1,24(sp)
    800009c0:	e84a                	sd	s2,16(sp)
    800009c2:	e44e                	sd	s3,8(sp)
    800009c4:	e052                	sd	s4,0(sp)
    800009c6:	1800                	addi	s0,sp,48
    800009c8:	8a2a                	mv	s4,a0
    // there are 2^9 = 512 PTEs in a page table.
    for (int i = 0; i < 512; i++) {
    800009ca:	84aa                	mv	s1,a0
    800009cc:	6905                	lui	s2,0x1
    800009ce:	992a                	add	s2,s2,a0
        pte_t pte = pagetable[i];
        if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0) {
    800009d0:	4985                	li	s3,1
    800009d2:	a829                	j	800009ec <freewalk+0x34>
            // this PTE points to a lower-level page table.
            uint64 child = PTE2PA(pte);
    800009d4:	83a9                	srli	a5,a5,0xa
            freewalk((pagetable_t)child);
    800009d6:	00c79513          	slli	a0,a5,0xc
    800009da:	00000097          	auipc	ra,0x0
    800009de:	fde080e7          	jalr	-34(ra) # 800009b8 <freewalk>
            pagetable[i] = 0;
    800009e2:	0004b023          	sd	zero,0(s1)
    for (int i = 0; i < 512; i++) {
    800009e6:	04a1                	addi	s1,s1,8
    800009e8:	03248163          	beq	s1,s2,80000a0a <freewalk+0x52>
        pte_t pte = pagetable[i];
    800009ec:	609c                	ld	a5,0(s1)
        if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0) {
    800009ee:	00f7f713          	andi	a4,a5,15
    800009f2:	ff3701e3          	beq	a4,s3,800009d4 <freewalk+0x1c>
        } else if (pte & PTE_V) {
    800009f6:	8b85                	andi	a5,a5,1
    800009f8:	d7fd                	beqz	a5,800009e6 <freewalk+0x2e>
            panic("freewalk: leaf");
    800009fa:	00007517          	auipc	a0,0x7
    800009fe:	6fe50513          	addi	a0,a0,1790 # 800080f8 <etext+0xf8>
    80000a02:	00005097          	auipc	ra,0x5
    80000a06:	390080e7          	jalr	912(ra) # 80005d92 <panic>
        }
    }
    kfree((void *)pagetable);
    80000a0a:	8552                	mv	a0,s4
    80000a0c:	fffff097          	auipc	ra,0xfffff
    80000a10:	610080e7          	jalr	1552(ra) # 8000001c <kfree>
}
    80000a14:	70a2                	ld	ra,40(sp)
    80000a16:	7402                	ld	s0,32(sp)
    80000a18:	64e2                	ld	s1,24(sp)
    80000a1a:	6942                	ld	s2,16(sp)
    80000a1c:	69a2                	ld	s3,8(sp)
    80000a1e:	6a02                	ld	s4,0(sp)
    80000a20:	6145                	addi	sp,sp,48
    80000a22:	8082                	ret

0000000080000a24 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void uvmfree(pagetable_t pagetable, uint64 sz) {
    80000a24:	1101                	addi	sp,sp,-32
    80000a26:	ec06                	sd	ra,24(sp)
    80000a28:	e822                	sd	s0,16(sp)
    80000a2a:	e426                	sd	s1,8(sp)
    80000a2c:	1000                	addi	s0,sp,32
    80000a2e:	84aa                	mv	s1,a0
    if (sz > 0)
    80000a30:	e999                	bnez	a1,80000a46 <uvmfree+0x22>
        uvmunmap(pagetable, 0, PGROUNDUP(sz) / PGSIZE, 1);
    freewalk(pagetable);
    80000a32:	8526                	mv	a0,s1
    80000a34:	00000097          	auipc	ra,0x0
    80000a38:	f84080e7          	jalr	-124(ra) # 800009b8 <freewalk>
}
    80000a3c:	60e2                	ld	ra,24(sp)
    80000a3e:	6442                	ld	s0,16(sp)
    80000a40:	64a2                	ld	s1,8(sp)
    80000a42:	6105                	addi	sp,sp,32
    80000a44:	8082                	ret
        uvmunmap(pagetable, 0, PGROUNDUP(sz) / PGSIZE, 1);
    80000a46:	6785                	lui	a5,0x1
    80000a48:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000a4a:	95be                	add	a1,a1,a5
    80000a4c:	4685                	li	a3,1
    80000a4e:	00c5d613          	srli	a2,a1,0xc
    80000a52:	4581                	li	a1,0
    80000a54:	00000097          	auipc	ra,0x0
    80000a58:	cf6080e7          	jalr	-778(ra) # 8000074a <uvmunmap>
    80000a5c:	bfd9                	j	80000a32 <uvmfree+0xe>

0000000080000a5e <uvmcopy>:
    pte_t *pte;
    uint64 pa, i;
    uint flags;
    char *mem;

    for (i = 0; i < sz; i += PGSIZE) {
    80000a5e:	c679                	beqz	a2,80000b2c <uvmcopy+0xce>
int uvmcopy(pagetable_t old, pagetable_t new, uint64 sz) {
    80000a60:	715d                	addi	sp,sp,-80
    80000a62:	e486                	sd	ra,72(sp)
    80000a64:	e0a2                	sd	s0,64(sp)
    80000a66:	fc26                	sd	s1,56(sp)
    80000a68:	f84a                	sd	s2,48(sp)
    80000a6a:	f44e                	sd	s3,40(sp)
    80000a6c:	f052                	sd	s4,32(sp)
    80000a6e:	ec56                	sd	s5,24(sp)
    80000a70:	e85a                	sd	s6,16(sp)
    80000a72:	e45e                	sd	s7,8(sp)
    80000a74:	0880                	addi	s0,sp,80
    80000a76:	8b2a                	mv	s6,a0
    80000a78:	8aae                	mv	s5,a1
    80000a7a:	8a32                	mv	s4,a2
    for (i = 0; i < sz; i += PGSIZE) {
    80000a7c:	4981                	li	s3,0
        if ((pte = walk(old, i, 0)) == 0)
    80000a7e:	4601                	li	a2,0
    80000a80:	85ce                	mv	a1,s3
    80000a82:	855a                	mv	a0,s6
    80000a84:	00000097          	auipc	ra,0x0
    80000a88:	a18080e7          	jalr	-1512(ra) # 8000049c <walk>
    80000a8c:	c531                	beqz	a0,80000ad8 <uvmcopy+0x7a>
            panic("uvmcopy: pte should exist");
        if ((*pte & PTE_V) == 0)
    80000a8e:	6118                	ld	a4,0(a0)
    80000a90:	00177793          	andi	a5,a4,1
    80000a94:	cbb1                	beqz	a5,80000ae8 <uvmcopy+0x8a>
            panic("uvmcopy: page not present");
        pa = PTE2PA(*pte);
    80000a96:	00a75593          	srli	a1,a4,0xa
    80000a9a:	00c59b93          	slli	s7,a1,0xc
        flags = PTE_FLAGS(*pte);
    80000a9e:	3ff77493          	andi	s1,a4,1023
        if ((mem = kalloc()) == 0)
    80000aa2:	fffff097          	auipc	ra,0xfffff
    80000aa6:	678080e7          	jalr	1656(ra) # 8000011a <kalloc>
    80000aaa:	892a                	mv	s2,a0
    80000aac:	c939                	beqz	a0,80000b02 <uvmcopy+0xa4>
            goto err;
        memmove(mem, (char *)pa, PGSIZE);
    80000aae:	6605                	lui	a2,0x1
    80000ab0:	85de                	mv	a1,s7
    80000ab2:	fffff097          	auipc	ra,0xfffff
    80000ab6:	76e080e7          	jalr	1902(ra) # 80000220 <memmove>
        if (mappages(new, i, PGSIZE, (uint64)mem, flags) != 0) {
    80000aba:	8726                	mv	a4,s1
    80000abc:	86ca                	mv	a3,s2
    80000abe:	6605                	lui	a2,0x1
    80000ac0:	85ce                	mv	a1,s3
    80000ac2:	8556                	mv	a0,s5
    80000ac4:	00000097          	auipc	ra,0x0
    80000ac8:	ac0080e7          	jalr	-1344(ra) # 80000584 <mappages>
    80000acc:	e515                	bnez	a0,80000af8 <uvmcopy+0x9a>
    for (i = 0; i < sz; i += PGSIZE) {
    80000ace:	6785                	lui	a5,0x1
    80000ad0:	99be                	add	s3,s3,a5
    80000ad2:	fb49e6e3          	bltu	s3,s4,80000a7e <uvmcopy+0x20>
    80000ad6:	a081                	j	80000b16 <uvmcopy+0xb8>
            panic("uvmcopy: pte should exist");
    80000ad8:	00007517          	auipc	a0,0x7
    80000adc:	63050513          	addi	a0,a0,1584 # 80008108 <etext+0x108>
    80000ae0:	00005097          	auipc	ra,0x5
    80000ae4:	2b2080e7          	jalr	690(ra) # 80005d92 <panic>
            panic("uvmcopy: page not present");
    80000ae8:	00007517          	auipc	a0,0x7
    80000aec:	64050513          	addi	a0,a0,1600 # 80008128 <etext+0x128>
    80000af0:	00005097          	auipc	ra,0x5
    80000af4:	2a2080e7          	jalr	674(ra) # 80005d92 <panic>
            kfree(mem);
    80000af8:	854a                	mv	a0,s2
    80000afa:	fffff097          	auipc	ra,0xfffff
    80000afe:	522080e7          	jalr	1314(ra) # 8000001c <kfree>
        }
    }
    return 0;

err:
    uvmunmap(new, 0, i / PGSIZE, 1);
    80000b02:	4685                	li	a3,1
    80000b04:	00c9d613          	srli	a2,s3,0xc
    80000b08:	4581                	li	a1,0
    80000b0a:	8556                	mv	a0,s5
    80000b0c:	00000097          	auipc	ra,0x0
    80000b10:	c3e080e7          	jalr	-962(ra) # 8000074a <uvmunmap>
    return -1;
    80000b14:	557d                	li	a0,-1
}
    80000b16:	60a6                	ld	ra,72(sp)
    80000b18:	6406                	ld	s0,64(sp)
    80000b1a:	74e2                	ld	s1,56(sp)
    80000b1c:	7942                	ld	s2,48(sp)
    80000b1e:	79a2                	ld	s3,40(sp)
    80000b20:	7a02                	ld	s4,32(sp)
    80000b22:	6ae2                	ld	s5,24(sp)
    80000b24:	6b42                	ld	s6,16(sp)
    80000b26:	6ba2                	ld	s7,8(sp)
    80000b28:	6161                	addi	sp,sp,80
    80000b2a:	8082                	ret
    return 0;
    80000b2c:	4501                	li	a0,0
}
    80000b2e:	8082                	ret

0000000080000b30 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void uvmclear(pagetable_t pagetable, uint64 va) {
    80000b30:	1141                	addi	sp,sp,-16
    80000b32:	e406                	sd	ra,8(sp)
    80000b34:	e022                	sd	s0,0(sp)
    80000b36:	0800                	addi	s0,sp,16
    pte_t *pte;

    pte = walk(pagetable, va, 0);
    80000b38:	4601                	li	a2,0
    80000b3a:	00000097          	auipc	ra,0x0
    80000b3e:	962080e7          	jalr	-1694(ra) # 8000049c <walk>
    if (pte == 0)
    80000b42:	c901                	beqz	a0,80000b52 <uvmclear+0x22>
        panic("uvmclear");
    *pte &= ~PTE_U;
    80000b44:	611c                	ld	a5,0(a0)
    80000b46:	9bbd                	andi	a5,a5,-17
    80000b48:	e11c                	sd	a5,0(a0)
}
    80000b4a:	60a2                	ld	ra,8(sp)
    80000b4c:	6402                	ld	s0,0(sp)
    80000b4e:	0141                	addi	sp,sp,16
    80000b50:	8082                	ret
        panic("uvmclear");
    80000b52:	00007517          	auipc	a0,0x7
    80000b56:	5f650513          	addi	a0,a0,1526 # 80008148 <etext+0x148>
    80000b5a:	00005097          	auipc	ra,0x5
    80000b5e:	238080e7          	jalr	568(ra) # 80005d92 <panic>

0000000080000b62 <copyout>:
// Copy len bytes from src to virtual address dstva in a given page table.
// Return 0 on success, -1 on error.
int copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len) {
    uint64 n, va0, pa0;

    while (len > 0) {
    80000b62:	c6bd                	beqz	a3,80000bd0 <copyout+0x6e>
int copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len) {
    80000b64:	715d                	addi	sp,sp,-80
    80000b66:	e486                	sd	ra,72(sp)
    80000b68:	e0a2                	sd	s0,64(sp)
    80000b6a:	fc26                	sd	s1,56(sp)
    80000b6c:	f84a                	sd	s2,48(sp)
    80000b6e:	f44e                	sd	s3,40(sp)
    80000b70:	f052                	sd	s4,32(sp)
    80000b72:	ec56                	sd	s5,24(sp)
    80000b74:	e85a                	sd	s6,16(sp)
    80000b76:	e45e                	sd	s7,8(sp)
    80000b78:	e062                	sd	s8,0(sp)
    80000b7a:	0880                	addi	s0,sp,80
    80000b7c:	8b2a                	mv	s6,a0
    80000b7e:	8c2e                	mv	s8,a1
    80000b80:	8a32                	mv	s4,a2
    80000b82:	89b6                	mv	s3,a3
        va0 = PGROUNDDOWN(dstva);
    80000b84:	7bfd                	lui	s7,0xfffff
        pa0 = walkaddr(pagetable, va0);
        if (pa0 == 0)
            return -1;
        n = PGSIZE - (dstva - va0);
    80000b86:	6a85                	lui	s5,0x1
    80000b88:	a015                	j	80000bac <copyout+0x4a>
        if (n > len)
            n = len;
        memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000b8a:	9562                	add	a0,a0,s8
    80000b8c:	0004861b          	sext.w	a2,s1
    80000b90:	85d2                	mv	a1,s4
    80000b92:	41250533          	sub	a0,a0,s2
    80000b96:	fffff097          	auipc	ra,0xfffff
    80000b9a:	68a080e7          	jalr	1674(ra) # 80000220 <memmove>

        len -= n;
    80000b9e:	409989b3          	sub	s3,s3,s1
        src += n;
    80000ba2:	9a26                	add	s4,s4,s1
        dstva = va0 + PGSIZE;
    80000ba4:	01590c33          	add	s8,s2,s5
    while (len > 0) {
    80000ba8:	02098263          	beqz	s3,80000bcc <copyout+0x6a>
        va0 = PGROUNDDOWN(dstva);
    80000bac:	017c7933          	and	s2,s8,s7
        pa0 = walkaddr(pagetable, va0);
    80000bb0:	85ca                	mv	a1,s2
    80000bb2:	855a                	mv	a0,s6
    80000bb4:	00000097          	auipc	ra,0x0
    80000bb8:	98e080e7          	jalr	-1650(ra) # 80000542 <walkaddr>
        if (pa0 == 0)
    80000bbc:	cd01                	beqz	a0,80000bd4 <copyout+0x72>
        n = PGSIZE - (dstva - va0);
    80000bbe:	418904b3          	sub	s1,s2,s8
    80000bc2:	94d6                	add	s1,s1,s5
        if (n > len)
    80000bc4:	fc99f3e3          	bgeu	s3,s1,80000b8a <copyout+0x28>
    80000bc8:	84ce                	mv	s1,s3
    80000bca:	b7c1                	j	80000b8a <copyout+0x28>
    }
    return 0;
    80000bcc:	4501                	li	a0,0
    80000bce:	a021                	j	80000bd6 <copyout+0x74>
    80000bd0:	4501                	li	a0,0
}
    80000bd2:	8082                	ret
            return -1;
    80000bd4:	557d                	li	a0,-1
}
    80000bd6:	60a6                	ld	ra,72(sp)
    80000bd8:	6406                	ld	s0,64(sp)
    80000bda:	74e2                	ld	s1,56(sp)
    80000bdc:	7942                	ld	s2,48(sp)
    80000bde:	79a2                	ld	s3,40(sp)
    80000be0:	7a02                	ld	s4,32(sp)
    80000be2:	6ae2                	ld	s5,24(sp)
    80000be4:	6b42                	ld	s6,16(sp)
    80000be6:	6ba2                	ld	s7,8(sp)
    80000be8:	6c02                	ld	s8,0(sp)
    80000bea:	6161                	addi	sp,sp,80
    80000bec:	8082                	ret

0000000080000bee <copyin>:
// Copy len bytes to dst from virtual address srcva in a given page table.
// Return 0 on success, -1 on error.
int copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len) {
    uint64 n, va0, pa0;

    while (len > 0) {
    80000bee:	caa5                	beqz	a3,80000c5e <copyin+0x70>
int copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len) {
    80000bf0:	715d                	addi	sp,sp,-80
    80000bf2:	e486                	sd	ra,72(sp)
    80000bf4:	e0a2                	sd	s0,64(sp)
    80000bf6:	fc26                	sd	s1,56(sp)
    80000bf8:	f84a                	sd	s2,48(sp)
    80000bfa:	f44e                	sd	s3,40(sp)
    80000bfc:	f052                	sd	s4,32(sp)
    80000bfe:	ec56                	sd	s5,24(sp)
    80000c00:	e85a                	sd	s6,16(sp)
    80000c02:	e45e                	sd	s7,8(sp)
    80000c04:	e062                	sd	s8,0(sp)
    80000c06:	0880                	addi	s0,sp,80
    80000c08:	8b2a                	mv	s6,a0
    80000c0a:	8a2e                	mv	s4,a1
    80000c0c:	8c32                	mv	s8,a2
    80000c0e:	89b6                	mv	s3,a3
        va0 = PGROUNDDOWN(srcva);
    80000c10:	7bfd                	lui	s7,0xfffff
        pa0 = walkaddr(pagetable, va0);
        if (pa0 == 0)
            return -1;
        n = PGSIZE - (srcva - va0);
    80000c12:	6a85                	lui	s5,0x1
    80000c14:	a01d                	j	80000c3a <copyin+0x4c>
        if (n > len)
            n = len;
        memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000c16:	018505b3          	add	a1,a0,s8
    80000c1a:	0004861b          	sext.w	a2,s1
    80000c1e:	412585b3          	sub	a1,a1,s2
    80000c22:	8552                	mv	a0,s4
    80000c24:	fffff097          	auipc	ra,0xfffff
    80000c28:	5fc080e7          	jalr	1532(ra) # 80000220 <memmove>

        len -= n;
    80000c2c:	409989b3          	sub	s3,s3,s1
        dst += n;
    80000c30:	9a26                	add	s4,s4,s1
        srcva = va0 + PGSIZE;
    80000c32:	01590c33          	add	s8,s2,s5
    while (len > 0) {
    80000c36:	02098263          	beqz	s3,80000c5a <copyin+0x6c>
        va0 = PGROUNDDOWN(srcva);
    80000c3a:	017c7933          	and	s2,s8,s7
        pa0 = walkaddr(pagetable, va0);
    80000c3e:	85ca                	mv	a1,s2
    80000c40:	855a                	mv	a0,s6
    80000c42:	00000097          	auipc	ra,0x0
    80000c46:	900080e7          	jalr	-1792(ra) # 80000542 <walkaddr>
        if (pa0 == 0)
    80000c4a:	cd01                	beqz	a0,80000c62 <copyin+0x74>
        n = PGSIZE - (srcva - va0);
    80000c4c:	418904b3          	sub	s1,s2,s8
    80000c50:	94d6                	add	s1,s1,s5
        if (n > len)
    80000c52:	fc99f2e3          	bgeu	s3,s1,80000c16 <copyin+0x28>
    80000c56:	84ce                	mv	s1,s3
    80000c58:	bf7d                	j	80000c16 <copyin+0x28>
    }
    return 0;
    80000c5a:	4501                	li	a0,0
    80000c5c:	a021                	j	80000c64 <copyin+0x76>
    80000c5e:	4501                	li	a0,0
}
    80000c60:	8082                	ret
            return -1;
    80000c62:	557d                	li	a0,-1
}
    80000c64:	60a6                	ld	ra,72(sp)
    80000c66:	6406                	ld	s0,64(sp)
    80000c68:	74e2                	ld	s1,56(sp)
    80000c6a:	7942                	ld	s2,48(sp)
    80000c6c:	79a2                	ld	s3,40(sp)
    80000c6e:	7a02                	ld	s4,32(sp)
    80000c70:	6ae2                	ld	s5,24(sp)
    80000c72:	6b42                	ld	s6,16(sp)
    80000c74:	6ba2                	ld	s7,8(sp)
    80000c76:	6c02                	ld	s8,0(sp)
    80000c78:	6161                	addi	sp,sp,80
    80000c7a:	8082                	ret

0000000080000c7c <copyinstr>:
// Return 0 on success, -1 on error.
int copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max) {
    uint64 n, va0, pa0;
    int got_null = 0;

    while (got_null == 0 && max > 0) {
    80000c7c:	cacd                	beqz	a3,80000d2e <copyinstr+0xb2>
int copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max) {
    80000c7e:	715d                	addi	sp,sp,-80
    80000c80:	e486                	sd	ra,72(sp)
    80000c82:	e0a2                	sd	s0,64(sp)
    80000c84:	fc26                	sd	s1,56(sp)
    80000c86:	f84a                	sd	s2,48(sp)
    80000c88:	f44e                	sd	s3,40(sp)
    80000c8a:	f052                	sd	s4,32(sp)
    80000c8c:	ec56                	sd	s5,24(sp)
    80000c8e:	e85a                	sd	s6,16(sp)
    80000c90:	e45e                	sd	s7,8(sp)
    80000c92:	0880                	addi	s0,sp,80
    80000c94:	8a2a                	mv	s4,a0
    80000c96:	8b2e                	mv	s6,a1
    80000c98:	8bb2                	mv	s7,a2
    80000c9a:	8936                	mv	s2,a3
        va0 = PGROUNDDOWN(srcva);
    80000c9c:	7afd                	lui	s5,0xfffff
        pa0 = walkaddr(pagetable, va0);
        if (pa0 == 0)
            return -1;
        n = PGSIZE - (srcva - va0);
    80000c9e:	6985                	lui	s3,0x1
    80000ca0:	a825                	j	80000cd8 <copyinstr+0x5c>
            n = max;

        char *p = (char *)(pa0 + (srcva - va0));
        while (n > 0) {
            if (*p == '\0') {
                *dst = '\0';
    80000ca2:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80000ca6:	4785                	li	a5,1
            dst++;
        }

        srcva = va0 + PGSIZE;
    }
    if (got_null) {
    80000ca8:	37fd                	addiw	a5,a5,-1
    80000caa:	0007851b          	sext.w	a0,a5
        return 0;
    } else {
        return -1;
    }
}
    80000cae:	60a6                	ld	ra,72(sp)
    80000cb0:	6406                	ld	s0,64(sp)
    80000cb2:	74e2                	ld	s1,56(sp)
    80000cb4:	7942                	ld	s2,48(sp)
    80000cb6:	79a2                	ld	s3,40(sp)
    80000cb8:	7a02                	ld	s4,32(sp)
    80000cba:	6ae2                	ld	s5,24(sp)
    80000cbc:	6b42                	ld	s6,16(sp)
    80000cbe:	6ba2                	ld	s7,8(sp)
    80000cc0:	6161                	addi	sp,sp,80
    80000cc2:	8082                	ret
    80000cc4:	fff90713          	addi	a4,s2,-1 # fff <_entry-0x7ffff001>
    80000cc8:	9742                	add	a4,a4,a6
            --max;
    80000cca:	40b70933          	sub	s2,a4,a1
        srcva = va0 + PGSIZE;
    80000cce:	01348bb3          	add	s7,s1,s3
    while (got_null == 0 && max > 0) {
    80000cd2:	04e58663          	beq	a1,a4,80000d1e <copyinstr+0xa2>
int copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max) {
    80000cd6:	8b3e                	mv	s6,a5
        va0 = PGROUNDDOWN(srcva);
    80000cd8:	015bf4b3          	and	s1,s7,s5
        pa0 = walkaddr(pagetable, va0);
    80000cdc:	85a6                	mv	a1,s1
    80000cde:	8552                	mv	a0,s4
    80000ce0:	00000097          	auipc	ra,0x0
    80000ce4:	862080e7          	jalr	-1950(ra) # 80000542 <walkaddr>
        if (pa0 == 0)
    80000ce8:	cd0d                	beqz	a0,80000d22 <copyinstr+0xa6>
        n = PGSIZE - (srcva - va0);
    80000cea:	417486b3          	sub	a3,s1,s7
    80000cee:	96ce                	add	a3,a3,s3
        if (n > max)
    80000cf0:	00d97363          	bgeu	s2,a3,80000cf6 <copyinstr+0x7a>
    80000cf4:	86ca                	mv	a3,s2
        char *p = (char *)(pa0 + (srcva - va0));
    80000cf6:	955e                	add	a0,a0,s7
    80000cf8:	8d05                	sub	a0,a0,s1
        while (n > 0) {
    80000cfa:	c695                	beqz	a3,80000d26 <copyinstr+0xaa>
    80000cfc:	87da                	mv	a5,s6
    80000cfe:	885a                	mv	a6,s6
            if (*p == '\0') {
    80000d00:	41650633          	sub	a2,a0,s6
        while (n > 0) {
    80000d04:	96da                	add	a3,a3,s6
    80000d06:	85be                	mv	a1,a5
            if (*p == '\0') {
    80000d08:	00f60733          	add	a4,a2,a5
    80000d0c:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <end+0xffffffff7ffd5dc0>
    80000d10:	db49                	beqz	a4,80000ca2 <copyinstr+0x26>
                *dst = *p;
    80000d12:	00e78023          	sb	a4,0(a5)
            dst++;
    80000d16:	0785                	addi	a5,a5,1
        while (n > 0) {
    80000d18:	fed797e3          	bne	a5,a3,80000d06 <copyinstr+0x8a>
    80000d1c:	b765                	j	80000cc4 <copyinstr+0x48>
    80000d1e:	4781                	li	a5,0
    80000d20:	b761                	j	80000ca8 <copyinstr+0x2c>
            return -1;
    80000d22:	557d                	li	a0,-1
    80000d24:	b769                	j	80000cae <copyinstr+0x32>
        srcva = va0 + PGSIZE;
    80000d26:	6b85                	lui	s7,0x1
    80000d28:	9ba6                	add	s7,s7,s1
    80000d2a:	87da                	mv	a5,s6
    80000d2c:	b76d                	j	80000cd6 <copyinstr+0x5a>
    int got_null = 0;
    80000d2e:	4781                	li	a5,0
    if (got_null) {
    80000d30:	37fd                	addiw	a5,a5,-1
    80000d32:	0007851b          	sext.w	a0,a5
}
    80000d36:	8082                	ret

0000000080000d38 <proc_mapstacks>:
struct spinlock wait_lock;

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void proc_mapstacks(pagetable_t kpgtbl) {
    80000d38:	7139                	addi	sp,sp,-64
    80000d3a:	fc06                	sd	ra,56(sp)
    80000d3c:	f822                	sd	s0,48(sp)
    80000d3e:	f426                	sd	s1,40(sp)
    80000d40:	f04a                	sd	s2,32(sp)
    80000d42:	ec4e                	sd	s3,24(sp)
    80000d44:	e852                	sd	s4,16(sp)
    80000d46:	e456                	sd	s5,8(sp)
    80000d48:	e05a                	sd	s6,0(sp)
    80000d4a:	0080                	addi	s0,sp,64
    80000d4c:	8a2a                	mv	s4,a0
    struct proc *p;

    for (p = proc; p < &proc[NPROC]; p++) {
    80000d4e:	0000b497          	auipc	s1,0xb
    80000d52:	73248493          	addi	s1,s1,1842 # 8000c480 <proc>
        char *pa = kalloc();
        if (pa == 0)
            panic("kalloc");
        uint64 va = KSTACK((int)(p - proc));
    80000d56:	8b26                	mv	s6,s1
    80000d58:	ff4df937          	lui	s2,0xff4df
    80000d5c:	9bd90913          	addi	s2,s2,-1603 # ffffffffff4de9bd <end+0xffffffff7f4b577d>
    80000d60:	0936                	slli	s2,s2,0xd
    80000d62:	6f590913          	addi	s2,s2,1781
    80000d66:	0936                	slli	s2,s2,0xd
    80000d68:	bd390913          	addi	s2,s2,-1069
    80000d6c:	0932                	slli	s2,s2,0xc
    80000d6e:	7a790913          	addi	s2,s2,1959
    80000d72:	040009b7          	lui	s3,0x4000
    80000d76:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    80000d78:	09b2                	slli	s3,s3,0xc
    for (p = proc; p < &proc[NPROC]; p++) {
    80000d7a:	00011a97          	auipc	s5,0x11
    80000d7e:	306a8a93          	addi	s5,s5,774 # 80012080 <tickslock>
        char *pa = kalloc();
    80000d82:	fffff097          	auipc	ra,0xfffff
    80000d86:	398080e7          	jalr	920(ra) # 8000011a <kalloc>
    80000d8a:	862a                	mv	a2,a0
        if (pa == 0)
    80000d8c:	c121                	beqz	a0,80000dcc <proc_mapstacks+0x94>
        uint64 va = KSTACK((int)(p - proc));
    80000d8e:	416485b3          	sub	a1,s1,s6
    80000d92:	8591                	srai	a1,a1,0x4
    80000d94:	032585b3          	mul	a1,a1,s2
    80000d98:	2585                	addiw	a1,a1,1
    80000d9a:	00d5959b          	slliw	a1,a1,0xd
        kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000d9e:	4719                	li	a4,6
    80000da0:	6685                	lui	a3,0x1
    80000da2:	40b985b3          	sub	a1,s3,a1
    80000da6:	8552                	mv	a0,s4
    80000da8:	00000097          	auipc	ra,0x0
    80000dac:	87c080e7          	jalr	-1924(ra) # 80000624 <kvmmap>
    for (p = proc; p < &proc[NPROC]; p++) {
    80000db0:	17048493          	addi	s1,s1,368
    80000db4:	fd5497e3          	bne	s1,s5,80000d82 <proc_mapstacks+0x4a>
    }
}
    80000db8:	70e2                	ld	ra,56(sp)
    80000dba:	7442                	ld	s0,48(sp)
    80000dbc:	74a2                	ld	s1,40(sp)
    80000dbe:	7902                	ld	s2,32(sp)
    80000dc0:	69e2                	ld	s3,24(sp)
    80000dc2:	6a42                	ld	s4,16(sp)
    80000dc4:	6aa2                	ld	s5,8(sp)
    80000dc6:	6b02                	ld	s6,0(sp)
    80000dc8:	6121                	addi	sp,sp,64
    80000dca:	8082                	ret
            panic("kalloc");
    80000dcc:	00007517          	auipc	a0,0x7
    80000dd0:	38c50513          	addi	a0,a0,908 # 80008158 <etext+0x158>
    80000dd4:	00005097          	auipc	ra,0x5
    80000dd8:	fbe080e7          	jalr	-66(ra) # 80005d92 <panic>

0000000080000ddc <procinit>:

// initialize the proc table at boot time.
void procinit(void) {
    80000ddc:	7139                	addi	sp,sp,-64
    80000dde:	fc06                	sd	ra,56(sp)
    80000de0:	f822                	sd	s0,48(sp)
    80000de2:	f426                	sd	s1,40(sp)
    80000de4:	f04a                	sd	s2,32(sp)
    80000de6:	ec4e                	sd	s3,24(sp)
    80000de8:	e852                	sd	s4,16(sp)
    80000dea:	e456                	sd	s5,8(sp)
    80000dec:	e05a                	sd	s6,0(sp)
    80000dee:	0080                	addi	s0,sp,64
    struct proc *p;

    initlock(&pid_lock, "nextpid");
    80000df0:	00007597          	auipc	a1,0x7
    80000df4:	37058593          	addi	a1,a1,880 # 80008160 <etext+0x160>
    80000df8:	0000b517          	auipc	a0,0xb
    80000dfc:	25850513          	addi	a0,a0,600 # 8000c050 <pid_lock>
    80000e00:	00005097          	auipc	ra,0x5
    80000e04:	47c080e7          	jalr	1148(ra) # 8000627c <initlock>
    initlock(&wait_lock, "wait_lock");
    80000e08:	00007597          	auipc	a1,0x7
    80000e0c:	36058593          	addi	a1,a1,864 # 80008168 <etext+0x168>
    80000e10:	0000b517          	auipc	a0,0xb
    80000e14:	25850513          	addi	a0,a0,600 # 8000c068 <wait_lock>
    80000e18:	00005097          	auipc	ra,0x5
    80000e1c:	464080e7          	jalr	1124(ra) # 8000627c <initlock>
    for (p = proc; p < &proc[NPROC]; p++) {
    80000e20:	0000b497          	auipc	s1,0xb
    80000e24:	66048493          	addi	s1,s1,1632 # 8000c480 <proc>
        initlock(&p->lock, "proc");
    80000e28:	00007b17          	auipc	s6,0x7
    80000e2c:	350b0b13          	addi	s6,s6,848 # 80008178 <etext+0x178>
        p->kstack = KSTACK((int)(p - proc));
    80000e30:	8aa6                	mv	s5,s1
    80000e32:	ff4df937          	lui	s2,0xff4df
    80000e36:	9bd90913          	addi	s2,s2,-1603 # ffffffffff4de9bd <end+0xffffffff7f4b577d>
    80000e3a:	0936                	slli	s2,s2,0xd
    80000e3c:	6f590913          	addi	s2,s2,1781
    80000e40:	0936                	slli	s2,s2,0xd
    80000e42:	bd390913          	addi	s2,s2,-1069
    80000e46:	0932                	slli	s2,s2,0xc
    80000e48:	7a790913          	addi	s2,s2,1959
    80000e4c:	040009b7          	lui	s3,0x4000
    80000e50:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    80000e52:	09b2                	slli	s3,s3,0xc
    for (p = proc; p < &proc[NPROC]; p++) {
    80000e54:	00011a17          	auipc	s4,0x11
    80000e58:	22ca0a13          	addi	s4,s4,556 # 80012080 <tickslock>
        initlock(&p->lock, "proc");
    80000e5c:	85da                	mv	a1,s6
    80000e5e:	8526                	mv	a0,s1
    80000e60:	00005097          	auipc	ra,0x5
    80000e64:	41c080e7          	jalr	1052(ra) # 8000627c <initlock>
        p->kstack = KSTACK((int)(p - proc));
    80000e68:	415487b3          	sub	a5,s1,s5
    80000e6c:	8791                	srai	a5,a5,0x4
    80000e6e:	032787b3          	mul	a5,a5,s2
    80000e72:	2785                	addiw	a5,a5,1
    80000e74:	00d7979b          	slliw	a5,a5,0xd
    80000e78:	40f987b3          	sub	a5,s3,a5
    80000e7c:	e0bc                	sd	a5,64(s1)
    for (p = proc; p < &proc[NPROC]; p++) {
    80000e7e:	17048493          	addi	s1,s1,368
    80000e82:	fd449de3          	bne	s1,s4,80000e5c <procinit+0x80>
    }
}
    80000e86:	70e2                	ld	ra,56(sp)
    80000e88:	7442                	ld	s0,48(sp)
    80000e8a:	74a2                	ld	s1,40(sp)
    80000e8c:	7902                	ld	s2,32(sp)
    80000e8e:	69e2                	ld	s3,24(sp)
    80000e90:	6a42                	ld	s4,16(sp)
    80000e92:	6aa2                	ld	s5,8(sp)
    80000e94:	6b02                	ld	s6,0(sp)
    80000e96:	6121                	addi	sp,sp,64
    80000e98:	8082                	ret

0000000080000e9a <cpuid>:

// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int cpuid() {
    80000e9a:	1141                	addi	sp,sp,-16
    80000e9c:	e422                	sd	s0,8(sp)
    80000e9e:	0800                	addi	s0,sp,16
    asm volatile("mv %0, tp" : "=r"(x));
    80000ea0:	8512                	mv	a0,tp
    int id = r_tp();
    return id;
}
    80000ea2:	2501                	sext.w	a0,a0
    80000ea4:	6422                	ld	s0,8(sp)
    80000ea6:	0141                	addi	sp,sp,16
    80000ea8:	8082                	ret

0000000080000eaa <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu *mycpu(void) {
    80000eaa:	1141                	addi	sp,sp,-16
    80000eac:	e422                	sd	s0,8(sp)
    80000eae:	0800                	addi	s0,sp,16
    80000eb0:	8792                	mv	a5,tp
    int id = cpuid();
    struct cpu *c = &cpus[id];
    80000eb2:	2781                	sext.w	a5,a5
    80000eb4:	079e                	slli	a5,a5,0x7
    return c;
}
    80000eb6:	0000b517          	auipc	a0,0xb
    80000eba:	1ca50513          	addi	a0,a0,458 # 8000c080 <cpus>
    80000ebe:	953e                	add	a0,a0,a5
    80000ec0:	6422                	ld	s0,8(sp)
    80000ec2:	0141                	addi	sp,sp,16
    80000ec4:	8082                	ret

0000000080000ec6 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc *myproc(void) {
    80000ec6:	1101                	addi	sp,sp,-32
    80000ec8:	ec06                	sd	ra,24(sp)
    80000eca:	e822                	sd	s0,16(sp)
    80000ecc:	e426                	sd	s1,8(sp)
    80000ece:	1000                	addi	s0,sp,32
    push_off();
    80000ed0:	00005097          	auipc	ra,0x5
    80000ed4:	3f0080e7          	jalr	1008(ra) # 800062c0 <push_off>
    80000ed8:	8792                	mv	a5,tp
    struct cpu *c = mycpu();
    struct proc *p = c->proc;
    80000eda:	2781                	sext.w	a5,a5
    80000edc:	079e                	slli	a5,a5,0x7
    80000ede:	0000b717          	auipc	a4,0xb
    80000ee2:	17270713          	addi	a4,a4,370 # 8000c050 <pid_lock>
    80000ee6:	97ba                	add	a5,a5,a4
    80000ee8:	7b84                	ld	s1,48(a5)
    pop_off();
    80000eea:	00005097          	auipc	ra,0x5
    80000eee:	476080e7          	jalr	1142(ra) # 80006360 <pop_off>
    return p;
}
    80000ef2:	8526                	mv	a0,s1
    80000ef4:	60e2                	ld	ra,24(sp)
    80000ef6:	6442                	ld	s0,16(sp)
    80000ef8:	64a2                	ld	s1,8(sp)
    80000efa:	6105                	addi	sp,sp,32
    80000efc:	8082                	ret

0000000080000efe <forkret>:
    release(&p->lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void forkret(void) {
    80000efe:	1141                	addi	sp,sp,-16
    80000f00:	e406                	sd	ra,8(sp)
    80000f02:	e022                	sd	s0,0(sp)
    80000f04:	0800                	addi	s0,sp,16
    static int first = 1;

    // Still holding p->lock from scheduler.
    release(&myproc()->lock);
    80000f06:	00000097          	auipc	ra,0x0
    80000f0a:	fc0080e7          	jalr	-64(ra) # 80000ec6 <myproc>
    80000f0e:	00005097          	auipc	ra,0x5
    80000f12:	4b2080e7          	jalr	1202(ra) # 800063c0 <release>

    if (first) {
    80000f16:	0000a797          	auipc	a5,0xa
    80000f1a:	32a7a783          	lw	a5,810(a5) # 8000b240 <first.1>
    80000f1e:	eb89                	bnez	a5,80000f30 <forkret+0x32>
        // be run from main().
        first = 0;
        fsinit(ROOTDEV);
    }

    usertrapret();
    80000f20:	00001097          	auipc	ra,0x1
    80000f24:	c50080e7          	jalr	-944(ra) # 80001b70 <usertrapret>
}
    80000f28:	60a2                	ld	ra,8(sp)
    80000f2a:	6402                	ld	s0,0(sp)
    80000f2c:	0141                	addi	sp,sp,16
    80000f2e:	8082                	ret
        first = 0;
    80000f30:	0000a797          	auipc	a5,0xa
    80000f34:	3007a823          	sw	zero,784(a5) # 8000b240 <first.1>
        fsinit(ROOTDEV);
    80000f38:	4505                	li	a0,1
    80000f3a:	00002097          	auipc	ra,0x2
    80000f3e:	9f2080e7          	jalr	-1550(ra) # 8000292c <fsinit>
    80000f42:	bff9                	j	80000f20 <forkret+0x22>

0000000080000f44 <allocpid>:
int allocpid() {
    80000f44:	1101                	addi	sp,sp,-32
    80000f46:	ec06                	sd	ra,24(sp)
    80000f48:	e822                	sd	s0,16(sp)
    80000f4a:	e426                	sd	s1,8(sp)
    80000f4c:	e04a                	sd	s2,0(sp)
    80000f4e:	1000                	addi	s0,sp,32
    acquire(&pid_lock);
    80000f50:	0000b917          	auipc	s2,0xb
    80000f54:	10090913          	addi	s2,s2,256 # 8000c050 <pid_lock>
    80000f58:	854a                	mv	a0,s2
    80000f5a:	00005097          	auipc	ra,0x5
    80000f5e:	3b2080e7          	jalr	946(ra) # 8000630c <acquire>
    pid = nextpid;
    80000f62:	0000a797          	auipc	a5,0xa
    80000f66:	2e278793          	addi	a5,a5,738 # 8000b244 <nextpid>
    80000f6a:	4384                	lw	s1,0(a5)
    nextpid = nextpid + 1;
    80000f6c:	0014871b          	addiw	a4,s1,1
    80000f70:	c398                	sw	a4,0(a5)
    release(&pid_lock);
    80000f72:	854a                	mv	a0,s2
    80000f74:	00005097          	auipc	ra,0x5
    80000f78:	44c080e7          	jalr	1100(ra) # 800063c0 <release>
}
    80000f7c:	8526                	mv	a0,s1
    80000f7e:	60e2                	ld	ra,24(sp)
    80000f80:	6442                	ld	s0,16(sp)
    80000f82:	64a2                	ld	s1,8(sp)
    80000f84:	6902                	ld	s2,0(sp)
    80000f86:	6105                	addi	sp,sp,32
    80000f88:	8082                	ret

0000000080000f8a <proc_pagetable>:
pagetable_t proc_pagetable(struct proc *p) {
    80000f8a:	1101                	addi	sp,sp,-32
    80000f8c:	ec06                	sd	ra,24(sp)
    80000f8e:	e822                	sd	s0,16(sp)
    80000f90:	e426                	sd	s1,8(sp)
    80000f92:	e04a                	sd	s2,0(sp)
    80000f94:	1000                	addi	s0,sp,32
    80000f96:	892a                	mv	s2,a0
    pagetable = uvmcreate();
    80000f98:	00000097          	auipc	ra,0x0
    80000f9c:	886080e7          	jalr	-1914(ra) # 8000081e <uvmcreate>
    80000fa0:	84aa                	mv	s1,a0
    if (pagetable == 0)
    80000fa2:	c121                	beqz	a0,80000fe2 <proc_pagetable+0x58>
    if (mappages(pagetable, TRAMPOLINE, PGSIZE, (uint64)trampoline,
    80000fa4:	4729                	li	a4,10
    80000fa6:	00006697          	auipc	a3,0x6
    80000faa:	05a68693          	addi	a3,a3,90 # 80007000 <_trampoline>
    80000fae:	6605                	lui	a2,0x1
    80000fb0:	040005b7          	lui	a1,0x4000
    80000fb4:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000fb6:	05b2                	slli	a1,a1,0xc
    80000fb8:	fffff097          	auipc	ra,0xfffff
    80000fbc:	5cc080e7          	jalr	1484(ra) # 80000584 <mappages>
    80000fc0:	02054863          	bltz	a0,80000ff0 <proc_pagetable+0x66>
    if (mappages(pagetable, TRAPFRAME, PGSIZE, (uint64)(p->trapframe),
    80000fc4:	4719                	li	a4,6
    80000fc6:	05893683          	ld	a3,88(s2)
    80000fca:	6605                	lui	a2,0x1
    80000fcc:	020005b7          	lui	a1,0x2000
    80000fd0:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000fd2:	05b6                	slli	a1,a1,0xd
    80000fd4:	8526                	mv	a0,s1
    80000fd6:	fffff097          	auipc	ra,0xfffff
    80000fda:	5ae080e7          	jalr	1454(ra) # 80000584 <mappages>
    80000fde:	02054163          	bltz	a0,80001000 <proc_pagetable+0x76>
}
    80000fe2:	8526                	mv	a0,s1
    80000fe4:	60e2                	ld	ra,24(sp)
    80000fe6:	6442                	ld	s0,16(sp)
    80000fe8:	64a2                	ld	s1,8(sp)
    80000fea:	6902                	ld	s2,0(sp)
    80000fec:	6105                	addi	sp,sp,32
    80000fee:	8082                	ret
        uvmfree(pagetable, 0);
    80000ff0:	4581                	li	a1,0
    80000ff2:	8526                	mv	a0,s1
    80000ff4:	00000097          	auipc	ra,0x0
    80000ff8:	a30080e7          	jalr	-1488(ra) # 80000a24 <uvmfree>
        return 0;
    80000ffc:	4481                	li	s1,0
    80000ffe:	b7d5                	j	80000fe2 <proc_pagetable+0x58>
        uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001000:	4681                	li	a3,0
    80001002:	4605                	li	a2,1
    80001004:	040005b7          	lui	a1,0x4000
    80001008:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    8000100a:	05b2                	slli	a1,a1,0xc
    8000100c:	8526                	mv	a0,s1
    8000100e:	fffff097          	auipc	ra,0xfffff
    80001012:	73c080e7          	jalr	1852(ra) # 8000074a <uvmunmap>
        uvmfree(pagetable, 0);
    80001016:	4581                	li	a1,0
    80001018:	8526                	mv	a0,s1
    8000101a:	00000097          	auipc	ra,0x0
    8000101e:	a0a080e7          	jalr	-1526(ra) # 80000a24 <uvmfree>
        return 0;
    80001022:	4481                	li	s1,0
    80001024:	bf7d                	j	80000fe2 <proc_pagetable+0x58>

0000000080001026 <proc_freepagetable>:
void proc_freepagetable(pagetable_t pagetable, uint64 sz) {
    80001026:	1101                	addi	sp,sp,-32
    80001028:	ec06                	sd	ra,24(sp)
    8000102a:	e822                	sd	s0,16(sp)
    8000102c:	e426                	sd	s1,8(sp)
    8000102e:	e04a                	sd	s2,0(sp)
    80001030:	1000                	addi	s0,sp,32
    80001032:	84aa                	mv	s1,a0
    80001034:	892e                	mv	s2,a1
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001036:	4681                	li	a3,0
    80001038:	4605                	li	a2,1
    8000103a:	040005b7          	lui	a1,0x4000
    8000103e:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001040:	05b2                	slli	a1,a1,0xc
    80001042:	fffff097          	auipc	ra,0xfffff
    80001046:	708080e7          	jalr	1800(ra) # 8000074a <uvmunmap>
    uvmunmap(pagetable, TRAPFRAME, 1, 0);
    8000104a:	4681                	li	a3,0
    8000104c:	4605                	li	a2,1
    8000104e:	020005b7          	lui	a1,0x2000
    80001052:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001054:	05b6                	slli	a1,a1,0xd
    80001056:	8526                	mv	a0,s1
    80001058:	fffff097          	auipc	ra,0xfffff
    8000105c:	6f2080e7          	jalr	1778(ra) # 8000074a <uvmunmap>
    uvmfree(pagetable, sz);
    80001060:	85ca                	mv	a1,s2
    80001062:	8526                	mv	a0,s1
    80001064:	00000097          	auipc	ra,0x0
    80001068:	9c0080e7          	jalr	-1600(ra) # 80000a24 <uvmfree>
}
    8000106c:	60e2                	ld	ra,24(sp)
    8000106e:	6442                	ld	s0,16(sp)
    80001070:	64a2                	ld	s1,8(sp)
    80001072:	6902                	ld	s2,0(sp)
    80001074:	6105                	addi	sp,sp,32
    80001076:	8082                	ret

0000000080001078 <freeproc>:
static void freeproc(struct proc *p) {
    80001078:	1101                	addi	sp,sp,-32
    8000107a:	ec06                	sd	ra,24(sp)
    8000107c:	e822                	sd	s0,16(sp)
    8000107e:	e426                	sd	s1,8(sp)
    80001080:	1000                	addi	s0,sp,32
    80001082:	84aa                	mv	s1,a0
    if (p->trapframe)
    80001084:	6d28                	ld	a0,88(a0)
    80001086:	c509                	beqz	a0,80001090 <freeproc+0x18>
        kfree((void *)p->trapframe);
    80001088:	fffff097          	auipc	ra,0xfffff
    8000108c:	f94080e7          	jalr	-108(ra) # 8000001c <kfree>
    p->trapframe = 0;
    80001090:	0404bc23          	sd	zero,88(s1)
    if (p->pagetable)
    80001094:	68a8                	ld	a0,80(s1)
    80001096:	c511                	beqz	a0,800010a2 <freeproc+0x2a>
        proc_freepagetable(p->pagetable, p->sz);
    80001098:	64ac                	ld	a1,72(s1)
    8000109a:	00000097          	auipc	ra,0x0
    8000109e:	f8c080e7          	jalr	-116(ra) # 80001026 <proc_freepagetable>
    p->pagetable = 0;
    800010a2:	0404b823          	sd	zero,80(s1)
    p->sz = 0;
    800010a6:	0404b423          	sd	zero,72(s1)
    p->pid = 0;
    800010aa:	0204a823          	sw	zero,48(s1)
    p->parent = 0;
    800010ae:	0204bc23          	sd	zero,56(s1)
    p->name[0] = 0;
    800010b2:	14048c23          	sb	zero,344(s1)
    p->chan = 0;
    800010b6:	0204b023          	sd	zero,32(s1)
    p->killed = 0;
    800010ba:	0204a423          	sw	zero,40(s1)
    p->xstate = 0;
    800010be:	0204a623          	sw	zero,44(s1)
    p->state = UNUSED;
    800010c2:	0004ac23          	sw	zero,24(s1)
    p->trace_mask = 0;
    800010c6:	1604b423          	sd	zero,360(s1)
}
    800010ca:	60e2                	ld	ra,24(sp)
    800010cc:	6442                	ld	s0,16(sp)
    800010ce:	64a2                	ld	s1,8(sp)
    800010d0:	6105                	addi	sp,sp,32
    800010d2:	8082                	ret

00000000800010d4 <allocproc>:
static struct proc *allocproc(void) {
    800010d4:	1101                	addi	sp,sp,-32
    800010d6:	ec06                	sd	ra,24(sp)
    800010d8:	e822                	sd	s0,16(sp)
    800010da:	e426                	sd	s1,8(sp)
    800010dc:	e04a                	sd	s2,0(sp)
    800010de:	1000                	addi	s0,sp,32
    for (p = proc; p < &proc[NPROC]; p++) {
    800010e0:	0000b497          	auipc	s1,0xb
    800010e4:	3a048493          	addi	s1,s1,928 # 8000c480 <proc>
    800010e8:	00011917          	auipc	s2,0x11
    800010ec:	f9890913          	addi	s2,s2,-104 # 80012080 <tickslock>
        acquire(&p->lock);
    800010f0:	8526                	mv	a0,s1
    800010f2:	00005097          	auipc	ra,0x5
    800010f6:	21a080e7          	jalr	538(ra) # 8000630c <acquire>
        if (p->state == UNUSED) {
    800010fa:	4c9c                	lw	a5,24(s1)
    800010fc:	cf81                	beqz	a5,80001114 <allocproc+0x40>
            release(&p->lock);
    800010fe:	8526                	mv	a0,s1
    80001100:	00005097          	auipc	ra,0x5
    80001104:	2c0080e7          	jalr	704(ra) # 800063c0 <release>
    for (p = proc; p < &proc[NPROC]; p++) {
    80001108:	17048493          	addi	s1,s1,368
    8000110c:	ff2492e3          	bne	s1,s2,800010f0 <allocproc+0x1c>
    return 0;
    80001110:	4481                	li	s1,0
    80001112:	a889                	j	80001164 <allocproc+0x90>
    p->pid = allocpid();
    80001114:	00000097          	auipc	ra,0x0
    80001118:	e30080e7          	jalr	-464(ra) # 80000f44 <allocpid>
    8000111c:	d888                	sw	a0,48(s1)
    p->state = USED;
    8000111e:	4785                	li	a5,1
    80001120:	cc9c                	sw	a5,24(s1)
    if ((p->trapframe = (struct trapframe *)kalloc()) == 0) {
    80001122:	fffff097          	auipc	ra,0xfffff
    80001126:	ff8080e7          	jalr	-8(ra) # 8000011a <kalloc>
    8000112a:	892a                	mv	s2,a0
    8000112c:	eca8                	sd	a0,88(s1)
    8000112e:	c131                	beqz	a0,80001172 <allocproc+0x9e>
    p->pagetable = proc_pagetable(p);
    80001130:	8526                	mv	a0,s1
    80001132:	00000097          	auipc	ra,0x0
    80001136:	e58080e7          	jalr	-424(ra) # 80000f8a <proc_pagetable>
    8000113a:	892a                	mv	s2,a0
    8000113c:	e8a8                	sd	a0,80(s1)
    if (p->pagetable == 0) {
    8000113e:	c531                	beqz	a0,8000118a <allocproc+0xb6>
    memset(&p->context, 0, sizeof(p->context));
    80001140:	07000613          	li	a2,112
    80001144:	4581                	li	a1,0
    80001146:	06048513          	addi	a0,s1,96
    8000114a:	fffff097          	auipc	ra,0xfffff
    8000114e:	07a080e7          	jalr	122(ra) # 800001c4 <memset>
    p->context.ra = (uint64)forkret;
    80001152:	00000797          	auipc	a5,0x0
    80001156:	dac78793          	addi	a5,a5,-596 # 80000efe <forkret>
    8000115a:	f0bc                	sd	a5,96(s1)
    p->context.sp = p->kstack + PGSIZE;
    8000115c:	60bc                	ld	a5,64(s1)
    8000115e:	6705                	lui	a4,0x1
    80001160:	97ba                	add	a5,a5,a4
    80001162:	f4bc                	sd	a5,104(s1)
}
    80001164:	8526                	mv	a0,s1
    80001166:	60e2                	ld	ra,24(sp)
    80001168:	6442                	ld	s0,16(sp)
    8000116a:	64a2                	ld	s1,8(sp)
    8000116c:	6902                	ld	s2,0(sp)
    8000116e:	6105                	addi	sp,sp,32
    80001170:	8082                	ret
        freeproc(p);
    80001172:	8526                	mv	a0,s1
    80001174:	00000097          	auipc	ra,0x0
    80001178:	f04080e7          	jalr	-252(ra) # 80001078 <freeproc>
        release(&p->lock);
    8000117c:	8526                	mv	a0,s1
    8000117e:	00005097          	auipc	ra,0x5
    80001182:	242080e7          	jalr	578(ra) # 800063c0 <release>
        return 0;
    80001186:	84ca                	mv	s1,s2
    80001188:	bff1                	j	80001164 <allocproc+0x90>
        freeproc(p);
    8000118a:	8526                	mv	a0,s1
    8000118c:	00000097          	auipc	ra,0x0
    80001190:	eec080e7          	jalr	-276(ra) # 80001078 <freeproc>
        release(&p->lock);
    80001194:	8526                	mv	a0,s1
    80001196:	00005097          	auipc	ra,0x5
    8000119a:	22a080e7          	jalr	554(ra) # 800063c0 <release>
        return 0;
    8000119e:	84ca                	mv	s1,s2
    800011a0:	b7d1                	j	80001164 <allocproc+0x90>

00000000800011a2 <userinit>:
void userinit(void) {
    800011a2:	1101                	addi	sp,sp,-32
    800011a4:	ec06                	sd	ra,24(sp)
    800011a6:	e822                	sd	s0,16(sp)
    800011a8:	e426                	sd	s1,8(sp)
    800011aa:	1000                	addi	s0,sp,32
    p = allocproc();
    800011ac:	00000097          	auipc	ra,0x0
    800011b0:	f28080e7          	jalr	-216(ra) # 800010d4 <allocproc>
    800011b4:	84aa                	mv	s1,a0
    initproc = p;
    800011b6:	0000b797          	auipc	a5,0xb
    800011ba:	e4a7bd23          	sd	a0,-422(a5) # 8000c010 <initproc>
    uvminit(p->pagetable, initcode, sizeof(initcode));
    800011be:	03400613          	li	a2,52
    800011c2:	0000a597          	auipc	a1,0xa
    800011c6:	08e58593          	addi	a1,a1,142 # 8000b250 <initcode>
    800011ca:	6928                	ld	a0,80(a0)
    800011cc:	fffff097          	auipc	ra,0xfffff
    800011d0:	680080e7          	jalr	1664(ra) # 8000084c <uvminit>
    p->sz = PGSIZE;
    800011d4:	6785                	lui	a5,0x1
    800011d6:	e4bc                	sd	a5,72(s1)
    p->trapframe->epc = 0;     // user program counter
    800011d8:	6cb8                	ld	a4,88(s1)
    800011da:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
    p->trapframe->sp = PGSIZE; // user stack pointer
    800011de:	6cb8                	ld	a4,88(s1)
    800011e0:	fb1c                	sd	a5,48(a4)
    safestrcpy(p->name, "initcode", sizeof(p->name));
    800011e2:	4641                	li	a2,16
    800011e4:	00007597          	auipc	a1,0x7
    800011e8:	f9c58593          	addi	a1,a1,-100 # 80008180 <etext+0x180>
    800011ec:	15848513          	addi	a0,s1,344
    800011f0:	fffff097          	auipc	ra,0xfffff
    800011f4:	116080e7          	jalr	278(ra) # 80000306 <safestrcpy>
    p->cwd = namei("/");
    800011f8:	00007517          	auipc	a0,0x7
    800011fc:	f9850513          	addi	a0,a0,-104 # 80008190 <etext+0x190>
    80001200:	00002097          	auipc	ra,0x2
    80001204:	172080e7          	jalr	370(ra) # 80003372 <namei>
    80001208:	14a4b823          	sd	a0,336(s1)
    p->state = RUNNABLE;
    8000120c:	478d                	li	a5,3
    8000120e:	cc9c                	sw	a5,24(s1)
    release(&p->lock);
    80001210:	8526                	mv	a0,s1
    80001212:	00005097          	auipc	ra,0x5
    80001216:	1ae080e7          	jalr	430(ra) # 800063c0 <release>
}
    8000121a:	60e2                	ld	ra,24(sp)
    8000121c:	6442                	ld	s0,16(sp)
    8000121e:	64a2                	ld	s1,8(sp)
    80001220:	6105                	addi	sp,sp,32
    80001222:	8082                	ret

0000000080001224 <growproc>:
int growproc(int n) {
    80001224:	1101                	addi	sp,sp,-32
    80001226:	ec06                	sd	ra,24(sp)
    80001228:	e822                	sd	s0,16(sp)
    8000122a:	e426                	sd	s1,8(sp)
    8000122c:	e04a                	sd	s2,0(sp)
    8000122e:	1000                	addi	s0,sp,32
    80001230:	84aa                	mv	s1,a0
    struct proc *p = myproc();
    80001232:	00000097          	auipc	ra,0x0
    80001236:	c94080e7          	jalr	-876(ra) # 80000ec6 <myproc>
    8000123a:	892a                	mv	s2,a0
    sz = p->sz;
    8000123c:	652c                	ld	a1,72(a0)
    8000123e:	0005879b          	sext.w	a5,a1
    if (n > 0) {
    80001242:	00904f63          	bgtz	s1,80001260 <growproc+0x3c>
    } else if (n < 0) {
    80001246:	0204cd63          	bltz	s1,80001280 <growproc+0x5c>
    p->sz = sz;
    8000124a:	1782                	slli	a5,a5,0x20
    8000124c:	9381                	srli	a5,a5,0x20
    8000124e:	04f93423          	sd	a5,72(s2)
    return 0;
    80001252:	4501                	li	a0,0
}
    80001254:	60e2                	ld	ra,24(sp)
    80001256:	6442                	ld	s0,16(sp)
    80001258:	64a2                	ld	s1,8(sp)
    8000125a:	6902                	ld	s2,0(sp)
    8000125c:	6105                	addi	sp,sp,32
    8000125e:	8082                	ret
        if ((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    80001260:	00f4863b          	addw	a2,s1,a5
    80001264:	1602                	slli	a2,a2,0x20
    80001266:	9201                	srli	a2,a2,0x20
    80001268:	1582                	slli	a1,a1,0x20
    8000126a:	9181                	srli	a1,a1,0x20
    8000126c:	6928                	ld	a0,80(a0)
    8000126e:	fffff097          	auipc	ra,0xfffff
    80001272:	698080e7          	jalr	1688(ra) # 80000906 <uvmalloc>
    80001276:	0005079b          	sext.w	a5,a0
    8000127a:	fbe1                	bnez	a5,8000124a <growproc+0x26>
            return -1;
    8000127c:	557d                	li	a0,-1
    8000127e:	bfd9                	j	80001254 <growproc+0x30>
        sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001280:	00f4863b          	addw	a2,s1,a5
    80001284:	1602                	slli	a2,a2,0x20
    80001286:	9201                	srli	a2,a2,0x20
    80001288:	1582                	slli	a1,a1,0x20
    8000128a:	9181                	srli	a1,a1,0x20
    8000128c:	6928                	ld	a0,80(a0)
    8000128e:	fffff097          	auipc	ra,0xfffff
    80001292:	630080e7          	jalr	1584(ra) # 800008be <uvmdealloc>
    80001296:	0005079b          	sext.w	a5,a0
    8000129a:	bf45                	j	8000124a <growproc+0x26>

000000008000129c <fork>:
int fork(void) {
    8000129c:	7139                	addi	sp,sp,-64
    8000129e:	fc06                	sd	ra,56(sp)
    800012a0:	f822                	sd	s0,48(sp)
    800012a2:	f04a                	sd	s2,32(sp)
    800012a4:	e456                	sd	s5,8(sp)
    800012a6:	0080                	addi	s0,sp,64
    struct proc *p = myproc();
    800012a8:	00000097          	auipc	ra,0x0
    800012ac:	c1e080e7          	jalr	-994(ra) # 80000ec6 <myproc>
    800012b0:	8aaa                	mv	s5,a0
    if ((np = allocproc()) == 0) {
    800012b2:	00000097          	auipc	ra,0x0
    800012b6:	e22080e7          	jalr	-478(ra) # 800010d4 <allocproc>
    800012ba:	12050463          	beqz	a0,800013e2 <fork+0x146>
    800012be:	ec4e                	sd	s3,24(sp)
    800012c0:	89aa                	mv	s3,a0
    if (uvmcopy(p->pagetable, np->pagetable, p->sz) < 0) {
    800012c2:	048ab603          	ld	a2,72(s5)
    800012c6:	692c                	ld	a1,80(a0)
    800012c8:	050ab503          	ld	a0,80(s5)
    800012cc:	fffff097          	auipc	ra,0xfffff
    800012d0:	792080e7          	jalr	1938(ra) # 80000a5e <uvmcopy>
    800012d4:	04054a63          	bltz	a0,80001328 <fork+0x8c>
    800012d8:	f426                	sd	s1,40(sp)
    800012da:	e852                	sd	s4,16(sp)
    np->sz = p->sz;
    800012dc:	048ab783          	ld	a5,72(s5)
    800012e0:	04f9b423          	sd	a5,72(s3)
    *(np->trapframe) = *(p->trapframe);
    800012e4:	058ab683          	ld	a3,88(s5)
    800012e8:	87b6                	mv	a5,a3
    800012ea:	0589b703          	ld	a4,88(s3)
    800012ee:	12068693          	addi	a3,a3,288
    800012f2:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    800012f6:	6788                	ld	a0,8(a5)
    800012f8:	6b8c                	ld	a1,16(a5)
    800012fa:	6f90                	ld	a2,24(a5)
    800012fc:	01073023          	sd	a6,0(a4)
    80001300:	e708                	sd	a0,8(a4)
    80001302:	eb0c                	sd	a1,16(a4)
    80001304:	ef10                	sd	a2,24(a4)
    80001306:	02078793          	addi	a5,a5,32
    8000130a:	02070713          	addi	a4,a4,32
    8000130e:	fed792e3          	bne	a5,a3,800012f2 <fork+0x56>
    np->trapframe->a0 = 0;
    80001312:	0589b783          	ld	a5,88(s3)
    80001316:	0607b823          	sd	zero,112(a5)
    for (i = 0; i < NOFILE; i++)
    8000131a:	0d0a8493          	addi	s1,s5,208
    8000131e:	0d098913          	addi	s2,s3,208
    80001322:	150a8a13          	addi	s4,s5,336
    80001326:	a015                	j	8000134a <fork+0xae>
        freeproc(np);
    80001328:	854e                	mv	a0,s3
    8000132a:	00000097          	auipc	ra,0x0
    8000132e:	d4e080e7          	jalr	-690(ra) # 80001078 <freeproc>
        release(&np->lock);
    80001332:	854e                	mv	a0,s3
    80001334:	00005097          	auipc	ra,0x5
    80001338:	08c080e7          	jalr	140(ra) # 800063c0 <release>
        return -1;
    8000133c:	597d                	li	s2,-1
    8000133e:	69e2                	ld	s3,24(sp)
    80001340:	a851                	j	800013d4 <fork+0x138>
    for (i = 0; i < NOFILE; i++)
    80001342:	04a1                	addi	s1,s1,8
    80001344:	0921                	addi	s2,s2,8
    80001346:	01448b63          	beq	s1,s4,8000135c <fork+0xc0>
        if (p->ofile[i])
    8000134a:	6088                	ld	a0,0(s1)
    8000134c:	d97d                	beqz	a0,80001342 <fork+0xa6>
            np->ofile[i] = filedup(p->ofile[i]);
    8000134e:	00002097          	auipc	ra,0x2
    80001352:	69c080e7          	jalr	1692(ra) # 800039ea <filedup>
    80001356:	00a93023          	sd	a0,0(s2)
    8000135a:	b7e5                	j	80001342 <fork+0xa6>
    np->cwd = idup(p->cwd);
    8000135c:	150ab503          	ld	a0,336(s5)
    80001360:	00002097          	auipc	ra,0x2
    80001364:	802080e7          	jalr	-2046(ra) # 80002b62 <idup>
    80001368:	14a9b823          	sd	a0,336(s3)
    safestrcpy(np->name, p->name, sizeof(p->name));
    8000136c:	4641                	li	a2,16
    8000136e:	158a8593          	addi	a1,s5,344
    80001372:	15898513          	addi	a0,s3,344
    80001376:	fffff097          	auipc	ra,0xfffff
    8000137a:	f90080e7          	jalr	-112(ra) # 80000306 <safestrcpy>
    pid = np->pid;
    8000137e:	0309a903          	lw	s2,48(s3)
    release(&np->lock);
    80001382:	854e                	mv	a0,s3
    80001384:	00005097          	auipc	ra,0x5
    80001388:	03c080e7          	jalr	60(ra) # 800063c0 <release>
    acquire(&wait_lock);
    8000138c:	0000b497          	auipc	s1,0xb
    80001390:	cdc48493          	addi	s1,s1,-804 # 8000c068 <wait_lock>
    80001394:	8526                	mv	a0,s1
    80001396:	00005097          	auipc	ra,0x5
    8000139a:	f76080e7          	jalr	-138(ra) # 8000630c <acquire>
    np->parent = p;
    8000139e:	0359bc23          	sd	s5,56(s3)
    release(&wait_lock);
    800013a2:	8526                	mv	a0,s1
    800013a4:	00005097          	auipc	ra,0x5
    800013a8:	01c080e7          	jalr	28(ra) # 800063c0 <release>
    acquire(&np->lock);
    800013ac:	854e                	mv	a0,s3
    800013ae:	00005097          	auipc	ra,0x5
    800013b2:	f5e080e7          	jalr	-162(ra) # 8000630c <acquire>
    np->state = RUNNABLE;
    800013b6:	478d                	li	a5,3
    800013b8:	00f9ac23          	sw	a5,24(s3)
    release(&np->lock);
    800013bc:	854e                	mv	a0,s3
    800013be:	00005097          	auipc	ra,0x5
    800013c2:	002080e7          	jalr	2(ra) # 800063c0 <release>
    np->trace_mask = p->trace_mask;
    800013c6:	168ab783          	ld	a5,360(s5)
    800013ca:	16f9b423          	sd	a5,360(s3)
    return pid;
    800013ce:	74a2                	ld	s1,40(sp)
    800013d0:	69e2                	ld	s3,24(sp)
    800013d2:	6a42                	ld	s4,16(sp)
}
    800013d4:	854a                	mv	a0,s2
    800013d6:	70e2                	ld	ra,56(sp)
    800013d8:	7442                	ld	s0,48(sp)
    800013da:	7902                	ld	s2,32(sp)
    800013dc:	6aa2                	ld	s5,8(sp)
    800013de:	6121                	addi	sp,sp,64
    800013e0:	8082                	ret
        return -1;
    800013e2:	597d                	li	s2,-1
    800013e4:	bfc5                	j	800013d4 <fork+0x138>

00000000800013e6 <scheduler>:
void scheduler(void) {
    800013e6:	7139                	addi	sp,sp,-64
    800013e8:	fc06                	sd	ra,56(sp)
    800013ea:	f822                	sd	s0,48(sp)
    800013ec:	f426                	sd	s1,40(sp)
    800013ee:	f04a                	sd	s2,32(sp)
    800013f0:	ec4e                	sd	s3,24(sp)
    800013f2:	e852                	sd	s4,16(sp)
    800013f4:	e456                	sd	s5,8(sp)
    800013f6:	e05a                	sd	s6,0(sp)
    800013f8:	0080                	addi	s0,sp,64
    800013fa:	8792                	mv	a5,tp
    int id = r_tp();
    800013fc:	2781                	sext.w	a5,a5
    c->proc = 0;
    800013fe:	00779a93          	slli	s5,a5,0x7
    80001402:	0000b717          	auipc	a4,0xb
    80001406:	c4e70713          	addi	a4,a4,-946 # 8000c050 <pid_lock>
    8000140a:	9756                	add	a4,a4,s5
    8000140c:	02073823          	sd	zero,48(a4)
                swtch(&c->context, &p->context);
    80001410:	0000b717          	auipc	a4,0xb
    80001414:	c7870713          	addi	a4,a4,-904 # 8000c088 <cpus+0x8>
    80001418:	9aba                	add	s5,s5,a4
            if (p->state == RUNNABLE) {
    8000141a:	498d                	li	s3,3
                p->state = RUNNING;
    8000141c:	4b11                	li	s6,4
                c->proc = p;
    8000141e:	079e                	slli	a5,a5,0x7
    80001420:	0000ba17          	auipc	s4,0xb
    80001424:	c30a0a13          	addi	s4,s4,-976 # 8000c050 <pid_lock>
    80001428:	9a3e                	add	s4,s4,a5
        for (p = proc; p < &proc[NPROC]; p++) {
    8000142a:	00011917          	auipc	s2,0x11
    8000142e:	c5690913          	addi	s2,s2,-938 # 80012080 <tickslock>
    asm volatile("csrr %0, sstatus" : "=r"(x));
    80001432:	100027f3          	csrr	a5,sstatus
static inline void intr_on() { w_sstatus(r_sstatus() | SSTATUS_SIE); }
    80001436:	0027e793          	ori	a5,a5,2
    asm volatile("csrw sstatus, %0" : : "r"(x));
    8000143a:	10079073          	csrw	sstatus,a5
    8000143e:	0000b497          	auipc	s1,0xb
    80001442:	04248493          	addi	s1,s1,66 # 8000c480 <proc>
    80001446:	a811                	j	8000145a <scheduler+0x74>
            release(&p->lock);
    80001448:	8526                	mv	a0,s1
    8000144a:	00005097          	auipc	ra,0x5
    8000144e:	f76080e7          	jalr	-138(ra) # 800063c0 <release>
        for (p = proc; p < &proc[NPROC]; p++) {
    80001452:	17048493          	addi	s1,s1,368
    80001456:	fd248ee3          	beq	s1,s2,80001432 <scheduler+0x4c>
            acquire(&p->lock);
    8000145a:	8526                	mv	a0,s1
    8000145c:	00005097          	auipc	ra,0x5
    80001460:	eb0080e7          	jalr	-336(ra) # 8000630c <acquire>
            if (p->state == RUNNABLE) {
    80001464:	4c9c                	lw	a5,24(s1)
    80001466:	ff3791e3          	bne	a5,s3,80001448 <scheduler+0x62>
                p->state = RUNNING;
    8000146a:	0164ac23          	sw	s6,24(s1)
                c->proc = p;
    8000146e:	029a3823          	sd	s1,48(s4)
                swtch(&c->context, &p->context);
    80001472:	06048593          	addi	a1,s1,96
    80001476:	8556                	mv	a0,s5
    80001478:	00000097          	auipc	ra,0x0
    8000147c:	64e080e7          	jalr	1614(ra) # 80001ac6 <swtch>
                c->proc = 0;
    80001480:	020a3823          	sd	zero,48(s4)
    80001484:	b7d1                	j	80001448 <scheduler+0x62>

0000000080001486 <sched>:
void sched(void) {
    80001486:	7179                	addi	sp,sp,-48
    80001488:	f406                	sd	ra,40(sp)
    8000148a:	f022                	sd	s0,32(sp)
    8000148c:	ec26                	sd	s1,24(sp)
    8000148e:	e84a                	sd	s2,16(sp)
    80001490:	e44e                	sd	s3,8(sp)
    80001492:	1800                	addi	s0,sp,48
    struct proc *p = myproc();
    80001494:	00000097          	auipc	ra,0x0
    80001498:	a32080e7          	jalr	-1486(ra) # 80000ec6 <myproc>
    8000149c:	84aa                	mv	s1,a0
    if (!holding(&p->lock))
    8000149e:	00005097          	auipc	ra,0x5
    800014a2:	df4080e7          	jalr	-524(ra) # 80006292 <holding>
    800014a6:	c93d                	beqz	a0,8000151c <sched+0x96>
    asm volatile("mv %0, tp" : "=r"(x));
    800014a8:	8792                	mv	a5,tp
    if (mycpu()->noff != 1)
    800014aa:	2781                	sext.w	a5,a5
    800014ac:	079e                	slli	a5,a5,0x7
    800014ae:	0000b717          	auipc	a4,0xb
    800014b2:	ba270713          	addi	a4,a4,-1118 # 8000c050 <pid_lock>
    800014b6:	97ba                	add	a5,a5,a4
    800014b8:	0a87a703          	lw	a4,168(a5)
    800014bc:	4785                	li	a5,1
    800014be:	06f71763          	bne	a4,a5,8000152c <sched+0xa6>
    if (p->state == RUNNING)
    800014c2:	4c98                	lw	a4,24(s1)
    800014c4:	4791                	li	a5,4
    800014c6:	06f70b63          	beq	a4,a5,8000153c <sched+0xb6>
    asm volatile("csrr %0, sstatus" : "=r"(x));
    800014ca:	100027f3          	csrr	a5,sstatus
    return (x & SSTATUS_SIE) != 0;
    800014ce:	8b89                	andi	a5,a5,2
    if (intr_get())
    800014d0:	efb5                	bnez	a5,8000154c <sched+0xc6>
    asm volatile("mv %0, tp" : "=r"(x));
    800014d2:	8792                	mv	a5,tp
    intena = mycpu()->intena;
    800014d4:	0000b917          	auipc	s2,0xb
    800014d8:	b7c90913          	addi	s2,s2,-1156 # 8000c050 <pid_lock>
    800014dc:	2781                	sext.w	a5,a5
    800014de:	079e                	slli	a5,a5,0x7
    800014e0:	97ca                	add	a5,a5,s2
    800014e2:	0ac7a983          	lw	s3,172(a5)
    800014e6:	8792                	mv	a5,tp
    swtch(&p->context, &mycpu()->context);
    800014e8:	2781                	sext.w	a5,a5
    800014ea:	079e                	slli	a5,a5,0x7
    800014ec:	0000b597          	auipc	a1,0xb
    800014f0:	b9c58593          	addi	a1,a1,-1124 # 8000c088 <cpus+0x8>
    800014f4:	95be                	add	a1,a1,a5
    800014f6:	06048513          	addi	a0,s1,96
    800014fa:	00000097          	auipc	ra,0x0
    800014fe:	5cc080e7          	jalr	1484(ra) # 80001ac6 <swtch>
    80001502:	8792                	mv	a5,tp
    mycpu()->intena = intena;
    80001504:	2781                	sext.w	a5,a5
    80001506:	079e                	slli	a5,a5,0x7
    80001508:	993e                	add	s2,s2,a5
    8000150a:	0b392623          	sw	s3,172(s2)
}
    8000150e:	70a2                	ld	ra,40(sp)
    80001510:	7402                	ld	s0,32(sp)
    80001512:	64e2                	ld	s1,24(sp)
    80001514:	6942                	ld	s2,16(sp)
    80001516:	69a2                	ld	s3,8(sp)
    80001518:	6145                	addi	sp,sp,48
    8000151a:	8082                	ret
        panic("sched p->lock");
    8000151c:	00007517          	auipc	a0,0x7
    80001520:	c7c50513          	addi	a0,a0,-900 # 80008198 <etext+0x198>
    80001524:	00005097          	auipc	ra,0x5
    80001528:	86e080e7          	jalr	-1938(ra) # 80005d92 <panic>
        panic("sched locks");
    8000152c:	00007517          	auipc	a0,0x7
    80001530:	c7c50513          	addi	a0,a0,-900 # 800081a8 <etext+0x1a8>
    80001534:	00005097          	auipc	ra,0x5
    80001538:	85e080e7          	jalr	-1954(ra) # 80005d92 <panic>
        panic("sched running");
    8000153c:	00007517          	auipc	a0,0x7
    80001540:	c7c50513          	addi	a0,a0,-900 # 800081b8 <etext+0x1b8>
    80001544:	00005097          	auipc	ra,0x5
    80001548:	84e080e7          	jalr	-1970(ra) # 80005d92 <panic>
        panic("sched interruptible");
    8000154c:	00007517          	auipc	a0,0x7
    80001550:	c7c50513          	addi	a0,a0,-900 # 800081c8 <etext+0x1c8>
    80001554:	00005097          	auipc	ra,0x5
    80001558:	83e080e7          	jalr	-1986(ra) # 80005d92 <panic>

000000008000155c <yield>:
void yield(void) {
    8000155c:	1101                	addi	sp,sp,-32
    8000155e:	ec06                	sd	ra,24(sp)
    80001560:	e822                	sd	s0,16(sp)
    80001562:	e426                	sd	s1,8(sp)
    80001564:	1000                	addi	s0,sp,32
    struct proc *p = myproc();
    80001566:	00000097          	auipc	ra,0x0
    8000156a:	960080e7          	jalr	-1696(ra) # 80000ec6 <myproc>
    8000156e:	84aa                	mv	s1,a0
    acquire(&p->lock);
    80001570:	00005097          	auipc	ra,0x5
    80001574:	d9c080e7          	jalr	-612(ra) # 8000630c <acquire>
    p->state = RUNNABLE;
    80001578:	478d                	li	a5,3
    8000157a:	cc9c                	sw	a5,24(s1)
    sched();
    8000157c:	00000097          	auipc	ra,0x0
    80001580:	f0a080e7          	jalr	-246(ra) # 80001486 <sched>
    release(&p->lock);
    80001584:	8526                	mv	a0,s1
    80001586:	00005097          	auipc	ra,0x5
    8000158a:	e3a080e7          	jalr	-454(ra) # 800063c0 <release>
}
    8000158e:	60e2                	ld	ra,24(sp)
    80001590:	6442                	ld	s0,16(sp)
    80001592:	64a2                	ld	s1,8(sp)
    80001594:	6105                	addi	sp,sp,32
    80001596:	8082                	ret

0000000080001598 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void sleep(void *chan, struct spinlock *lk) {
    80001598:	7179                	addi	sp,sp,-48
    8000159a:	f406                	sd	ra,40(sp)
    8000159c:	f022                	sd	s0,32(sp)
    8000159e:	ec26                	sd	s1,24(sp)
    800015a0:	e84a                	sd	s2,16(sp)
    800015a2:	e44e                	sd	s3,8(sp)
    800015a4:	1800                	addi	s0,sp,48
    800015a6:	89aa                	mv	s3,a0
    800015a8:	892e                	mv	s2,a1
    struct proc *p = myproc();
    800015aa:	00000097          	auipc	ra,0x0
    800015ae:	91c080e7          	jalr	-1764(ra) # 80000ec6 <myproc>
    800015b2:	84aa                	mv	s1,a0
    // Once we hold p->lock, we can be
    // guaranteed that we won't miss any wakeup
    // (wakeup locks p->lock),
    // so it's okay to release lk.

    acquire(&p->lock); // DOC: sleeplock1
    800015b4:	00005097          	auipc	ra,0x5
    800015b8:	d58080e7          	jalr	-680(ra) # 8000630c <acquire>
    release(lk);
    800015bc:	854a                	mv	a0,s2
    800015be:	00005097          	auipc	ra,0x5
    800015c2:	e02080e7          	jalr	-510(ra) # 800063c0 <release>

    // Go to sleep.
    p->chan = chan;
    800015c6:	0334b023          	sd	s3,32(s1)
    p->state = SLEEPING;
    800015ca:	4789                	li	a5,2
    800015cc:	cc9c                	sw	a5,24(s1)

    sched();
    800015ce:	00000097          	auipc	ra,0x0
    800015d2:	eb8080e7          	jalr	-328(ra) # 80001486 <sched>

    // Tidy up.
    p->chan = 0;
    800015d6:	0204b023          	sd	zero,32(s1)

    // Reacquire original lock.
    release(&p->lock);
    800015da:	8526                	mv	a0,s1
    800015dc:	00005097          	auipc	ra,0x5
    800015e0:	de4080e7          	jalr	-540(ra) # 800063c0 <release>
    acquire(lk);
    800015e4:	854a                	mv	a0,s2
    800015e6:	00005097          	auipc	ra,0x5
    800015ea:	d26080e7          	jalr	-730(ra) # 8000630c <acquire>
}
    800015ee:	70a2                	ld	ra,40(sp)
    800015f0:	7402                	ld	s0,32(sp)
    800015f2:	64e2                	ld	s1,24(sp)
    800015f4:	6942                	ld	s2,16(sp)
    800015f6:	69a2                	ld	s3,8(sp)
    800015f8:	6145                	addi	sp,sp,48
    800015fa:	8082                	ret

00000000800015fc <wait>:
int wait(uint64 addr) {
    800015fc:	715d                	addi	sp,sp,-80
    800015fe:	e486                	sd	ra,72(sp)
    80001600:	e0a2                	sd	s0,64(sp)
    80001602:	fc26                	sd	s1,56(sp)
    80001604:	f84a                	sd	s2,48(sp)
    80001606:	f44e                	sd	s3,40(sp)
    80001608:	f052                	sd	s4,32(sp)
    8000160a:	ec56                	sd	s5,24(sp)
    8000160c:	e85a                	sd	s6,16(sp)
    8000160e:	e45e                	sd	s7,8(sp)
    80001610:	e062                	sd	s8,0(sp)
    80001612:	0880                	addi	s0,sp,80
    80001614:	8b2a                	mv	s6,a0
    struct proc *p = myproc();
    80001616:	00000097          	auipc	ra,0x0
    8000161a:	8b0080e7          	jalr	-1872(ra) # 80000ec6 <myproc>
    8000161e:	892a                	mv	s2,a0
    acquire(&wait_lock);
    80001620:	0000b517          	auipc	a0,0xb
    80001624:	a4850513          	addi	a0,a0,-1464 # 8000c068 <wait_lock>
    80001628:	00005097          	auipc	ra,0x5
    8000162c:	ce4080e7          	jalr	-796(ra) # 8000630c <acquire>
        havekids = 0;
    80001630:	4b81                	li	s7,0
                if (np->state == ZOMBIE) {
    80001632:	4a15                	li	s4,5
                havekids = 1;
    80001634:	4a85                	li	s5,1
        for (np = proc; np < &proc[NPROC]; np++) {
    80001636:	00011997          	auipc	s3,0x11
    8000163a:	a4a98993          	addi	s3,s3,-1462 # 80012080 <tickslock>
        sleep(p, &wait_lock); // DOC: wait-sleep
    8000163e:	0000bc17          	auipc	s8,0xb
    80001642:	a2ac0c13          	addi	s8,s8,-1494 # 8000c068 <wait_lock>
    80001646:	a87d                	j	80001704 <wait+0x108>
                    pid = np->pid;
    80001648:	0304a983          	lw	s3,48(s1)
                    if (addr != 0 &&
    8000164c:	000b0e63          	beqz	s6,80001668 <wait+0x6c>
                        copyout(p->pagetable, addr, (char *)&np->xstate,
    80001650:	4691                	li	a3,4
    80001652:	02c48613          	addi	a2,s1,44
    80001656:	85da                	mv	a1,s6
    80001658:	05093503          	ld	a0,80(s2)
    8000165c:	fffff097          	auipc	ra,0xfffff
    80001660:	506080e7          	jalr	1286(ra) # 80000b62 <copyout>
                    if (addr != 0 &&
    80001664:	04054163          	bltz	a0,800016a6 <wait+0xaa>
                    freeproc(np);
    80001668:	8526                	mv	a0,s1
    8000166a:	00000097          	auipc	ra,0x0
    8000166e:	a0e080e7          	jalr	-1522(ra) # 80001078 <freeproc>
                    release(&np->lock);
    80001672:	8526                	mv	a0,s1
    80001674:	00005097          	auipc	ra,0x5
    80001678:	d4c080e7          	jalr	-692(ra) # 800063c0 <release>
                    release(&wait_lock);
    8000167c:	0000b517          	auipc	a0,0xb
    80001680:	9ec50513          	addi	a0,a0,-1556 # 8000c068 <wait_lock>
    80001684:	00005097          	auipc	ra,0x5
    80001688:	d3c080e7          	jalr	-708(ra) # 800063c0 <release>
}
    8000168c:	854e                	mv	a0,s3
    8000168e:	60a6                	ld	ra,72(sp)
    80001690:	6406                	ld	s0,64(sp)
    80001692:	74e2                	ld	s1,56(sp)
    80001694:	7942                	ld	s2,48(sp)
    80001696:	79a2                	ld	s3,40(sp)
    80001698:	7a02                	ld	s4,32(sp)
    8000169a:	6ae2                	ld	s5,24(sp)
    8000169c:	6b42                	ld	s6,16(sp)
    8000169e:	6ba2                	ld	s7,8(sp)
    800016a0:	6c02                	ld	s8,0(sp)
    800016a2:	6161                	addi	sp,sp,80
    800016a4:	8082                	ret
                        release(&np->lock);
    800016a6:	8526                	mv	a0,s1
    800016a8:	00005097          	auipc	ra,0x5
    800016ac:	d18080e7          	jalr	-744(ra) # 800063c0 <release>
                        release(&wait_lock);
    800016b0:	0000b517          	auipc	a0,0xb
    800016b4:	9b850513          	addi	a0,a0,-1608 # 8000c068 <wait_lock>
    800016b8:	00005097          	auipc	ra,0x5
    800016bc:	d08080e7          	jalr	-760(ra) # 800063c0 <release>
                        return -1;
    800016c0:	59fd                	li	s3,-1
    800016c2:	b7e9                	j	8000168c <wait+0x90>
        for (np = proc; np < &proc[NPROC]; np++) {
    800016c4:	17048493          	addi	s1,s1,368
    800016c8:	03348463          	beq	s1,s3,800016f0 <wait+0xf4>
            if (np->parent == p) {
    800016cc:	7c9c                	ld	a5,56(s1)
    800016ce:	ff279be3          	bne	a5,s2,800016c4 <wait+0xc8>
                acquire(&np->lock);
    800016d2:	8526                	mv	a0,s1
    800016d4:	00005097          	auipc	ra,0x5
    800016d8:	c38080e7          	jalr	-968(ra) # 8000630c <acquire>
                if (np->state == ZOMBIE) {
    800016dc:	4c9c                	lw	a5,24(s1)
    800016de:	f74785e3          	beq	a5,s4,80001648 <wait+0x4c>
                release(&np->lock);
    800016e2:	8526                	mv	a0,s1
    800016e4:	00005097          	auipc	ra,0x5
    800016e8:	cdc080e7          	jalr	-804(ra) # 800063c0 <release>
                havekids = 1;
    800016ec:	8756                	mv	a4,s5
    800016ee:	bfd9                	j	800016c4 <wait+0xc8>
        if (!havekids || p->killed) {
    800016f0:	c305                	beqz	a4,80001710 <wait+0x114>
    800016f2:	02892783          	lw	a5,40(s2)
    800016f6:	ef89                	bnez	a5,80001710 <wait+0x114>
        sleep(p, &wait_lock); // DOC: wait-sleep
    800016f8:	85e2                	mv	a1,s8
    800016fa:	854a                	mv	a0,s2
    800016fc:	00000097          	auipc	ra,0x0
    80001700:	e9c080e7          	jalr	-356(ra) # 80001598 <sleep>
        havekids = 0;
    80001704:	875e                	mv	a4,s7
        for (np = proc; np < &proc[NPROC]; np++) {
    80001706:	0000b497          	auipc	s1,0xb
    8000170a:	d7a48493          	addi	s1,s1,-646 # 8000c480 <proc>
    8000170e:	bf7d                	j	800016cc <wait+0xd0>
            release(&wait_lock);
    80001710:	0000b517          	auipc	a0,0xb
    80001714:	95850513          	addi	a0,a0,-1704 # 8000c068 <wait_lock>
    80001718:	00005097          	auipc	ra,0x5
    8000171c:	ca8080e7          	jalr	-856(ra) # 800063c0 <release>
            return -1;
    80001720:	59fd                	li	s3,-1
    80001722:	b7ad                	j	8000168c <wait+0x90>

0000000080001724 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void wakeup(void *chan) {
    80001724:	7139                	addi	sp,sp,-64
    80001726:	fc06                	sd	ra,56(sp)
    80001728:	f822                	sd	s0,48(sp)
    8000172a:	f426                	sd	s1,40(sp)
    8000172c:	f04a                	sd	s2,32(sp)
    8000172e:	ec4e                	sd	s3,24(sp)
    80001730:	e852                	sd	s4,16(sp)
    80001732:	e456                	sd	s5,8(sp)
    80001734:	0080                	addi	s0,sp,64
    80001736:	8a2a                	mv	s4,a0
    struct proc *p;

    for (p = proc; p < &proc[NPROC]; p++) {
    80001738:	0000b497          	auipc	s1,0xb
    8000173c:	d4848493          	addi	s1,s1,-696 # 8000c480 <proc>
        if (p != myproc()) {
            acquire(&p->lock);
            if (p->state == SLEEPING && p->chan == chan) {
    80001740:	4989                	li	s3,2
                p->state = RUNNABLE;
    80001742:	4a8d                	li	s5,3
    for (p = proc; p < &proc[NPROC]; p++) {
    80001744:	00011917          	auipc	s2,0x11
    80001748:	93c90913          	addi	s2,s2,-1732 # 80012080 <tickslock>
    8000174c:	a811                	j	80001760 <wakeup+0x3c>
            }
            release(&p->lock);
    8000174e:	8526                	mv	a0,s1
    80001750:	00005097          	auipc	ra,0x5
    80001754:	c70080e7          	jalr	-912(ra) # 800063c0 <release>
    for (p = proc; p < &proc[NPROC]; p++) {
    80001758:	17048493          	addi	s1,s1,368
    8000175c:	03248663          	beq	s1,s2,80001788 <wakeup+0x64>
        if (p != myproc()) {
    80001760:	fffff097          	auipc	ra,0xfffff
    80001764:	766080e7          	jalr	1894(ra) # 80000ec6 <myproc>
    80001768:	fea488e3          	beq	s1,a0,80001758 <wakeup+0x34>
            acquire(&p->lock);
    8000176c:	8526                	mv	a0,s1
    8000176e:	00005097          	auipc	ra,0x5
    80001772:	b9e080e7          	jalr	-1122(ra) # 8000630c <acquire>
            if (p->state == SLEEPING && p->chan == chan) {
    80001776:	4c9c                	lw	a5,24(s1)
    80001778:	fd379be3          	bne	a5,s3,8000174e <wakeup+0x2a>
    8000177c:	709c                	ld	a5,32(s1)
    8000177e:	fd4798e3          	bne	a5,s4,8000174e <wakeup+0x2a>
                p->state = RUNNABLE;
    80001782:	0154ac23          	sw	s5,24(s1)
    80001786:	b7e1                	j	8000174e <wakeup+0x2a>
        }
    }
}
    80001788:	70e2                	ld	ra,56(sp)
    8000178a:	7442                	ld	s0,48(sp)
    8000178c:	74a2                	ld	s1,40(sp)
    8000178e:	7902                	ld	s2,32(sp)
    80001790:	69e2                	ld	s3,24(sp)
    80001792:	6a42                	ld	s4,16(sp)
    80001794:	6aa2                	ld	s5,8(sp)
    80001796:	6121                	addi	sp,sp,64
    80001798:	8082                	ret

000000008000179a <reparent>:
void reparent(struct proc *p) {
    8000179a:	7179                	addi	sp,sp,-48
    8000179c:	f406                	sd	ra,40(sp)
    8000179e:	f022                	sd	s0,32(sp)
    800017a0:	ec26                	sd	s1,24(sp)
    800017a2:	e84a                	sd	s2,16(sp)
    800017a4:	e44e                	sd	s3,8(sp)
    800017a6:	e052                	sd	s4,0(sp)
    800017a8:	1800                	addi	s0,sp,48
    800017aa:	892a                	mv	s2,a0
    for (pp = proc; pp < &proc[NPROC]; pp++) {
    800017ac:	0000b497          	auipc	s1,0xb
    800017b0:	cd448493          	addi	s1,s1,-812 # 8000c480 <proc>
            pp->parent = initproc;
    800017b4:	0000ba17          	auipc	s4,0xb
    800017b8:	85ca0a13          	addi	s4,s4,-1956 # 8000c010 <initproc>
    for (pp = proc; pp < &proc[NPROC]; pp++) {
    800017bc:	00011997          	auipc	s3,0x11
    800017c0:	8c498993          	addi	s3,s3,-1852 # 80012080 <tickslock>
    800017c4:	a029                	j	800017ce <reparent+0x34>
    800017c6:	17048493          	addi	s1,s1,368
    800017ca:	01348d63          	beq	s1,s3,800017e4 <reparent+0x4a>
        if (pp->parent == p) {
    800017ce:	7c9c                	ld	a5,56(s1)
    800017d0:	ff279be3          	bne	a5,s2,800017c6 <reparent+0x2c>
            pp->parent = initproc;
    800017d4:	000a3503          	ld	a0,0(s4)
    800017d8:	fc88                	sd	a0,56(s1)
            wakeup(initproc);
    800017da:	00000097          	auipc	ra,0x0
    800017de:	f4a080e7          	jalr	-182(ra) # 80001724 <wakeup>
    800017e2:	b7d5                	j	800017c6 <reparent+0x2c>
}
    800017e4:	70a2                	ld	ra,40(sp)
    800017e6:	7402                	ld	s0,32(sp)
    800017e8:	64e2                	ld	s1,24(sp)
    800017ea:	6942                	ld	s2,16(sp)
    800017ec:	69a2                	ld	s3,8(sp)
    800017ee:	6a02                	ld	s4,0(sp)
    800017f0:	6145                	addi	sp,sp,48
    800017f2:	8082                	ret

00000000800017f4 <exit>:
void exit(int status) {
    800017f4:	7179                	addi	sp,sp,-48
    800017f6:	f406                	sd	ra,40(sp)
    800017f8:	f022                	sd	s0,32(sp)
    800017fa:	ec26                	sd	s1,24(sp)
    800017fc:	e84a                	sd	s2,16(sp)
    800017fe:	e44e                	sd	s3,8(sp)
    80001800:	e052                	sd	s4,0(sp)
    80001802:	1800                	addi	s0,sp,48
    80001804:	8a2a                	mv	s4,a0
    struct proc *p = myproc();
    80001806:	fffff097          	auipc	ra,0xfffff
    8000180a:	6c0080e7          	jalr	1728(ra) # 80000ec6 <myproc>
    8000180e:	89aa                	mv	s3,a0
    if (p == initproc)
    80001810:	0000b797          	auipc	a5,0xb
    80001814:	8007b783          	ld	a5,-2048(a5) # 8000c010 <initproc>
    80001818:	0d050493          	addi	s1,a0,208
    8000181c:	15050913          	addi	s2,a0,336
    80001820:	02a79363          	bne	a5,a0,80001846 <exit+0x52>
        panic("init exiting");
    80001824:	00007517          	auipc	a0,0x7
    80001828:	9bc50513          	addi	a0,a0,-1604 # 800081e0 <etext+0x1e0>
    8000182c:	00004097          	auipc	ra,0x4
    80001830:	566080e7          	jalr	1382(ra) # 80005d92 <panic>
            fileclose(f);
    80001834:	00002097          	auipc	ra,0x2
    80001838:	208080e7          	jalr	520(ra) # 80003a3c <fileclose>
            p->ofile[fd] = 0;
    8000183c:	0004b023          	sd	zero,0(s1)
    for (int fd = 0; fd < NOFILE; fd++) {
    80001840:	04a1                	addi	s1,s1,8
    80001842:	01248563          	beq	s1,s2,8000184c <exit+0x58>
        if (p->ofile[fd]) {
    80001846:	6088                	ld	a0,0(s1)
    80001848:	f575                	bnez	a0,80001834 <exit+0x40>
    8000184a:	bfdd                	j	80001840 <exit+0x4c>
    begin_op();
    8000184c:	00002097          	auipc	ra,0x2
    80001850:	d26080e7          	jalr	-730(ra) # 80003572 <begin_op>
    iput(p->cwd);
    80001854:	1509b503          	ld	a0,336(s3)
    80001858:	00001097          	auipc	ra,0x1
    8000185c:	506080e7          	jalr	1286(ra) # 80002d5e <iput>
    end_op();
    80001860:	00002097          	auipc	ra,0x2
    80001864:	d8c080e7          	jalr	-628(ra) # 800035ec <end_op>
    p->cwd = 0;
    80001868:	1409b823          	sd	zero,336(s3)
    acquire(&wait_lock);
    8000186c:	0000a497          	auipc	s1,0xa
    80001870:	7fc48493          	addi	s1,s1,2044 # 8000c068 <wait_lock>
    80001874:	8526                	mv	a0,s1
    80001876:	00005097          	auipc	ra,0x5
    8000187a:	a96080e7          	jalr	-1386(ra) # 8000630c <acquire>
    reparent(p);
    8000187e:	854e                	mv	a0,s3
    80001880:	00000097          	auipc	ra,0x0
    80001884:	f1a080e7          	jalr	-230(ra) # 8000179a <reparent>
    wakeup(p->parent);
    80001888:	0389b503          	ld	a0,56(s3)
    8000188c:	00000097          	auipc	ra,0x0
    80001890:	e98080e7          	jalr	-360(ra) # 80001724 <wakeup>
    acquire(&p->lock);
    80001894:	854e                	mv	a0,s3
    80001896:	00005097          	auipc	ra,0x5
    8000189a:	a76080e7          	jalr	-1418(ra) # 8000630c <acquire>
    p->xstate = status;
    8000189e:	0349a623          	sw	s4,44(s3)
    p->state = ZOMBIE;
    800018a2:	4795                	li	a5,5
    800018a4:	00f9ac23          	sw	a5,24(s3)
    release(&wait_lock);
    800018a8:	8526                	mv	a0,s1
    800018aa:	00005097          	auipc	ra,0x5
    800018ae:	b16080e7          	jalr	-1258(ra) # 800063c0 <release>
    sched();
    800018b2:	00000097          	auipc	ra,0x0
    800018b6:	bd4080e7          	jalr	-1068(ra) # 80001486 <sched>
    panic("zombie exit");
    800018ba:	00007517          	auipc	a0,0x7
    800018be:	93650513          	addi	a0,a0,-1738 # 800081f0 <etext+0x1f0>
    800018c2:	00004097          	auipc	ra,0x4
    800018c6:	4d0080e7          	jalr	1232(ra) # 80005d92 <panic>

00000000800018ca <kill>:

// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int kill(int pid) {
    800018ca:	7179                	addi	sp,sp,-48
    800018cc:	f406                	sd	ra,40(sp)
    800018ce:	f022                	sd	s0,32(sp)
    800018d0:	ec26                	sd	s1,24(sp)
    800018d2:	e84a                	sd	s2,16(sp)
    800018d4:	e44e                	sd	s3,8(sp)
    800018d6:	1800                	addi	s0,sp,48
    800018d8:	892a                	mv	s2,a0
    struct proc *p;

    for (p = proc; p < &proc[NPROC]; p++) {
    800018da:	0000b497          	auipc	s1,0xb
    800018de:	ba648493          	addi	s1,s1,-1114 # 8000c480 <proc>
    800018e2:	00010997          	auipc	s3,0x10
    800018e6:	79e98993          	addi	s3,s3,1950 # 80012080 <tickslock>
        acquire(&p->lock);
    800018ea:	8526                	mv	a0,s1
    800018ec:	00005097          	auipc	ra,0x5
    800018f0:	a20080e7          	jalr	-1504(ra) # 8000630c <acquire>
        if (p->pid == pid) {
    800018f4:	589c                	lw	a5,48(s1)
    800018f6:	01278d63          	beq	a5,s2,80001910 <kill+0x46>
                p->state = RUNNABLE;
            }
            release(&p->lock);
            return 0;
        }
        release(&p->lock);
    800018fa:	8526                	mv	a0,s1
    800018fc:	00005097          	auipc	ra,0x5
    80001900:	ac4080e7          	jalr	-1340(ra) # 800063c0 <release>
    for (p = proc; p < &proc[NPROC]; p++) {
    80001904:	17048493          	addi	s1,s1,368
    80001908:	ff3491e3          	bne	s1,s3,800018ea <kill+0x20>
    }
    return -1;
    8000190c:	557d                	li	a0,-1
    8000190e:	a829                	j	80001928 <kill+0x5e>
            p->killed = 1;
    80001910:	4785                	li	a5,1
    80001912:	d49c                	sw	a5,40(s1)
            if (p->state == SLEEPING) {
    80001914:	4c98                	lw	a4,24(s1)
    80001916:	4789                	li	a5,2
    80001918:	00f70f63          	beq	a4,a5,80001936 <kill+0x6c>
            release(&p->lock);
    8000191c:	8526                	mv	a0,s1
    8000191e:	00005097          	auipc	ra,0x5
    80001922:	aa2080e7          	jalr	-1374(ra) # 800063c0 <release>
            return 0;
    80001926:	4501                	li	a0,0
}
    80001928:	70a2                	ld	ra,40(sp)
    8000192a:	7402                	ld	s0,32(sp)
    8000192c:	64e2                	ld	s1,24(sp)
    8000192e:	6942                	ld	s2,16(sp)
    80001930:	69a2                	ld	s3,8(sp)
    80001932:	6145                	addi	sp,sp,48
    80001934:	8082                	ret
                p->state = RUNNABLE;
    80001936:	478d                	li	a5,3
    80001938:	cc9c                	sw	a5,24(s1)
    8000193a:	b7cd                	j	8000191c <kill+0x52>

000000008000193c <either_copyout>:

// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int either_copyout(int user_dst, uint64 dst, void *src, uint64 len) {
    8000193c:	7179                	addi	sp,sp,-48
    8000193e:	f406                	sd	ra,40(sp)
    80001940:	f022                	sd	s0,32(sp)
    80001942:	ec26                	sd	s1,24(sp)
    80001944:	e84a                	sd	s2,16(sp)
    80001946:	e44e                	sd	s3,8(sp)
    80001948:	e052                	sd	s4,0(sp)
    8000194a:	1800                	addi	s0,sp,48
    8000194c:	84aa                	mv	s1,a0
    8000194e:	892e                	mv	s2,a1
    80001950:	89b2                	mv	s3,a2
    80001952:	8a36                	mv	s4,a3
    struct proc *p = myproc();
    80001954:	fffff097          	auipc	ra,0xfffff
    80001958:	572080e7          	jalr	1394(ra) # 80000ec6 <myproc>
    if (user_dst) {
    8000195c:	c08d                	beqz	s1,8000197e <either_copyout+0x42>
        return copyout(p->pagetable, dst, src, len);
    8000195e:	86d2                	mv	a3,s4
    80001960:	864e                	mv	a2,s3
    80001962:	85ca                	mv	a1,s2
    80001964:	6928                	ld	a0,80(a0)
    80001966:	fffff097          	auipc	ra,0xfffff
    8000196a:	1fc080e7          	jalr	508(ra) # 80000b62 <copyout>
    } else {
        memmove((char *)dst, src, len);
        return 0;
    }
}
    8000196e:	70a2                	ld	ra,40(sp)
    80001970:	7402                	ld	s0,32(sp)
    80001972:	64e2                	ld	s1,24(sp)
    80001974:	6942                	ld	s2,16(sp)
    80001976:	69a2                	ld	s3,8(sp)
    80001978:	6a02                	ld	s4,0(sp)
    8000197a:	6145                	addi	sp,sp,48
    8000197c:	8082                	ret
        memmove((char *)dst, src, len);
    8000197e:	000a061b          	sext.w	a2,s4
    80001982:	85ce                	mv	a1,s3
    80001984:	854a                	mv	a0,s2
    80001986:	fffff097          	auipc	ra,0xfffff
    8000198a:	89a080e7          	jalr	-1894(ra) # 80000220 <memmove>
        return 0;
    8000198e:	8526                	mv	a0,s1
    80001990:	bff9                	j	8000196e <either_copyout+0x32>

0000000080001992 <either_copyin>:

// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int either_copyin(void *dst, int user_src, uint64 src, uint64 len) {
    80001992:	7179                	addi	sp,sp,-48
    80001994:	f406                	sd	ra,40(sp)
    80001996:	f022                	sd	s0,32(sp)
    80001998:	ec26                	sd	s1,24(sp)
    8000199a:	e84a                	sd	s2,16(sp)
    8000199c:	e44e                	sd	s3,8(sp)
    8000199e:	e052                	sd	s4,0(sp)
    800019a0:	1800                	addi	s0,sp,48
    800019a2:	892a                	mv	s2,a0
    800019a4:	84ae                	mv	s1,a1
    800019a6:	89b2                	mv	s3,a2
    800019a8:	8a36                	mv	s4,a3
    struct proc *p = myproc();
    800019aa:	fffff097          	auipc	ra,0xfffff
    800019ae:	51c080e7          	jalr	1308(ra) # 80000ec6 <myproc>
    if (user_src) {
    800019b2:	c08d                	beqz	s1,800019d4 <either_copyin+0x42>
        return copyin(p->pagetable, dst, src, len);
    800019b4:	86d2                	mv	a3,s4
    800019b6:	864e                	mv	a2,s3
    800019b8:	85ca                	mv	a1,s2
    800019ba:	6928                	ld	a0,80(a0)
    800019bc:	fffff097          	auipc	ra,0xfffff
    800019c0:	232080e7          	jalr	562(ra) # 80000bee <copyin>
    } else {
        memmove(dst, (char *)src, len);
        return 0;
    }
}
    800019c4:	70a2                	ld	ra,40(sp)
    800019c6:	7402                	ld	s0,32(sp)
    800019c8:	64e2                	ld	s1,24(sp)
    800019ca:	6942                	ld	s2,16(sp)
    800019cc:	69a2                	ld	s3,8(sp)
    800019ce:	6a02                	ld	s4,0(sp)
    800019d0:	6145                	addi	sp,sp,48
    800019d2:	8082                	ret
        memmove(dst, (char *)src, len);
    800019d4:	000a061b          	sext.w	a2,s4
    800019d8:	85ce                	mv	a1,s3
    800019da:	854a                	mv	a0,s2
    800019dc:	fffff097          	auipc	ra,0xfffff
    800019e0:	844080e7          	jalr	-1980(ra) # 80000220 <memmove>
        return 0;
    800019e4:	8526                	mv	a0,s1
    800019e6:	bff9                	j	800019c4 <either_copyin+0x32>

00000000800019e8 <procdump>:

// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void procdump(void) {
    800019e8:	715d                	addi	sp,sp,-80
    800019ea:	e486                	sd	ra,72(sp)
    800019ec:	e0a2                	sd	s0,64(sp)
    800019ee:	fc26                	sd	s1,56(sp)
    800019f0:	f84a                	sd	s2,48(sp)
    800019f2:	f44e                	sd	s3,40(sp)
    800019f4:	f052                	sd	s4,32(sp)
    800019f6:	ec56                	sd	s5,24(sp)
    800019f8:	e85a                	sd	s6,16(sp)
    800019fa:	e45e                	sd	s7,8(sp)
    800019fc:	0880                	addi	s0,sp,80
                             [RUNNING] "run   ",
                             [ZOMBIE] "zombie"};
    struct proc *p;
    char *state;

    printf("\n");
    800019fe:	00006517          	auipc	a0,0x6
    80001a02:	61a50513          	addi	a0,a0,1562 # 80008018 <etext+0x18>
    80001a06:	00004097          	auipc	ra,0x4
    80001a0a:	3d6080e7          	jalr	982(ra) # 80005ddc <printf>
    for (p = proc; p < &proc[NPROC]; p++) {
    80001a0e:	0000b497          	auipc	s1,0xb
    80001a12:	bca48493          	addi	s1,s1,-1078 # 8000c5d8 <proc+0x158>
    80001a16:	00010917          	auipc	s2,0x10
    80001a1a:	7c290913          	addi	s2,s2,1986 # 800121d8 <bcache+0x140>
        if (p->state == UNUSED)
            continue;
        if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a1e:	4b15                	li	s6,5
            state = states[p->state];
        else
            state = "???";
    80001a20:	00006997          	auipc	s3,0x6
    80001a24:	7e098993          	addi	s3,s3,2016 # 80008200 <etext+0x200>
        printf("%d %s %s", p->pid, state, p->name);
    80001a28:	00006a97          	auipc	s5,0x6
    80001a2c:	7e0a8a93          	addi	s5,s5,2016 # 80008208 <etext+0x208>
        printf("\n");
    80001a30:	00006a17          	auipc	s4,0x6
    80001a34:	5e8a0a13          	addi	s4,s4,1512 # 80008018 <etext+0x18>
        if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a38:	00007b97          	auipc	s7,0x7
    80001a3c:	d88b8b93          	addi	s7,s7,-632 # 800087c0 <states.0>
    80001a40:	a00d                	j	80001a62 <procdump+0x7a>
        printf("%d %s %s", p->pid, state, p->name);
    80001a42:	ed86a583          	lw	a1,-296(a3)
    80001a46:	8556                	mv	a0,s5
    80001a48:	00004097          	auipc	ra,0x4
    80001a4c:	394080e7          	jalr	916(ra) # 80005ddc <printf>
        printf("\n");
    80001a50:	8552                	mv	a0,s4
    80001a52:	00004097          	auipc	ra,0x4
    80001a56:	38a080e7          	jalr	906(ra) # 80005ddc <printf>
    for (p = proc; p < &proc[NPROC]; p++) {
    80001a5a:	17048493          	addi	s1,s1,368
    80001a5e:	03248263          	beq	s1,s2,80001a82 <procdump+0x9a>
        if (p->state == UNUSED)
    80001a62:	86a6                	mv	a3,s1
    80001a64:	ec04a783          	lw	a5,-320(s1)
    80001a68:	dbed                	beqz	a5,80001a5a <procdump+0x72>
            state = "???";
    80001a6a:	864e                	mv	a2,s3
        if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a6c:	fcfb6be3          	bltu	s6,a5,80001a42 <procdump+0x5a>
    80001a70:	02079713          	slli	a4,a5,0x20
    80001a74:	01d75793          	srli	a5,a4,0x1d
    80001a78:	97de                	add	a5,a5,s7
    80001a7a:	6390                	ld	a2,0(a5)
    80001a7c:	f279                	bnez	a2,80001a42 <procdump+0x5a>
            state = "???";
    80001a7e:	864e                	mv	a2,s3
    80001a80:	b7c9                	j	80001a42 <procdump+0x5a>
    }
}
    80001a82:	60a6                	ld	ra,72(sp)
    80001a84:	6406                	ld	s0,64(sp)
    80001a86:	74e2                	ld	s1,56(sp)
    80001a88:	7942                	ld	s2,48(sp)
    80001a8a:	79a2                	ld	s3,40(sp)
    80001a8c:	7a02                	ld	s4,32(sp)
    80001a8e:	6ae2                	ld	s5,24(sp)
    80001a90:	6b42                	ld	s6,16(sp)
    80001a92:	6ba2                	ld	s7,8(sp)
    80001a94:	6161                	addi	sp,sp,80
    80001a96:	8082                	ret

0000000080001a98 <num_proc>:

// lab2 - sysinfo system call
// return the number of processes whose state is not UNUSED
uint64 num_proc() {
    80001a98:	1141                	addi	sp,sp,-16
    80001a9a:	e422                	sd	s0,8(sp)
    80001a9c:	0800                	addi	s0,sp,16
  struct proc *p;
  uint64 n = 0;
    80001a9e:	4501                	li	a0,0

  for (p = proc;p < &proc[NPROC];p ++) {
    80001aa0:	0000b797          	auipc	a5,0xb
    80001aa4:	9e078793          	addi	a5,a5,-1568 # 8000c480 <proc>
    80001aa8:	00010697          	auipc	a3,0x10
    80001aac:	5d868693          	addi	a3,a3,1496 # 80012080 <tickslock>
    if (p->state != UNUSED)
    80001ab0:	4f98                	lw	a4,24(a5)
      n += 1;
    80001ab2:	00e03733          	snez	a4,a4
    80001ab6:	953a                	add	a0,a0,a4
  for (p = proc;p < &proc[NPROC];p ++) {
    80001ab8:	17078793          	addi	a5,a5,368
    80001abc:	fed79ae3          	bne	a5,a3,80001ab0 <num_proc+0x18>
  }

  return  n;
}
    80001ac0:	6422                	ld	s0,8(sp)
    80001ac2:	0141                	addi	sp,sp,16
    80001ac4:	8082                	ret

0000000080001ac6 <swtch>:
    80001ac6:	00153023          	sd	ra,0(a0)
    80001aca:	00253423          	sd	sp,8(a0)
    80001ace:	e900                	sd	s0,16(a0)
    80001ad0:	ed04                	sd	s1,24(a0)
    80001ad2:	03253023          	sd	s2,32(a0)
    80001ad6:	03353423          	sd	s3,40(a0)
    80001ada:	03453823          	sd	s4,48(a0)
    80001ade:	03553c23          	sd	s5,56(a0)
    80001ae2:	05653023          	sd	s6,64(a0)
    80001ae6:	05753423          	sd	s7,72(a0)
    80001aea:	05853823          	sd	s8,80(a0)
    80001aee:	05953c23          	sd	s9,88(a0)
    80001af2:	07a53023          	sd	s10,96(a0)
    80001af6:	07b53423          	sd	s11,104(a0)
    80001afa:	0005b083          	ld	ra,0(a1)
    80001afe:	0085b103          	ld	sp,8(a1)
    80001b02:	6980                	ld	s0,16(a1)
    80001b04:	6d84                	ld	s1,24(a1)
    80001b06:	0205b903          	ld	s2,32(a1)
    80001b0a:	0285b983          	ld	s3,40(a1)
    80001b0e:	0305ba03          	ld	s4,48(a1)
    80001b12:	0385ba83          	ld	s5,56(a1)
    80001b16:	0405bb03          	ld	s6,64(a1)
    80001b1a:	0485bb83          	ld	s7,72(a1)
    80001b1e:	0505bc03          	ld	s8,80(a1)
    80001b22:	0585bc83          	ld	s9,88(a1)
    80001b26:	0605bd03          	ld	s10,96(a1)
    80001b2a:	0685bd83          	ld	s11,104(a1)
    80001b2e:	8082                	ret

0000000080001b30 <trapinit>:
// in kernelvec.S, calls kerneltrap().
void kernelvec();

extern int devintr();

void trapinit(void) { initlock(&tickslock, "time"); }
    80001b30:	1141                	addi	sp,sp,-16
    80001b32:	e406                	sd	ra,8(sp)
    80001b34:	e022                	sd	s0,0(sp)
    80001b36:	0800                	addi	s0,sp,16
    80001b38:	00006597          	auipc	a1,0x6
    80001b3c:	70858593          	addi	a1,a1,1800 # 80008240 <etext+0x240>
    80001b40:	00010517          	auipc	a0,0x10
    80001b44:	54050513          	addi	a0,a0,1344 # 80012080 <tickslock>
    80001b48:	00004097          	auipc	ra,0x4
    80001b4c:	734080e7          	jalr	1844(ra) # 8000627c <initlock>
    80001b50:	60a2                	ld	ra,8(sp)
    80001b52:	6402                	ld	s0,0(sp)
    80001b54:	0141                	addi	sp,sp,16
    80001b56:	8082                	ret

0000000080001b58 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void trapinithart(void) { w_stvec((uint64)kernelvec); }
    80001b58:	1141                	addi	sp,sp,-16
    80001b5a:	e422                	sd	s0,8(sp)
    80001b5c:	0800                	addi	s0,sp,16
    asm volatile("csrw stvec, %0" : : "r"(x));
    80001b5e:	00003797          	auipc	a5,0x3
    80001b62:	5c278793          	addi	a5,a5,1474 # 80005120 <kernelvec>
    80001b66:	10579073          	csrw	stvec,a5
    80001b6a:	6422                	ld	s0,8(sp)
    80001b6c:	0141                	addi	sp,sp,16
    80001b6e:	8082                	ret

0000000080001b70 <usertrapret>:
}

//
// return to user space
//
void usertrapret(void) {
    80001b70:	1141                	addi	sp,sp,-16
    80001b72:	e406                	sd	ra,8(sp)
    80001b74:	e022                	sd	s0,0(sp)
    80001b76:	0800                	addi	s0,sp,16
    struct proc *p = myproc();
    80001b78:	fffff097          	auipc	ra,0xfffff
    80001b7c:	34e080e7          	jalr	846(ra) # 80000ec6 <myproc>
    asm volatile("csrr %0, sstatus" : "=r"(x));
    80001b80:	100027f3          	csrr	a5,sstatus
static inline void intr_off() { w_sstatus(r_sstatus() & ~SSTATUS_SIE); }
    80001b84:	9bf5                	andi	a5,a5,-3
    asm volatile("csrw sstatus, %0" : : "r"(x));
    80001b86:	10079073          	csrw	sstatus,a5
    // kerneltrap() to usertrap(), so turn off interrupts until
    // we're back in user space, where usertrap() is correct.
    intr_off();

    // send syscalls, interrupts, and exceptions to trampoline.S
    w_stvec(TRAMPOLINE + (uservec - trampoline));
    80001b8a:	00005697          	auipc	a3,0x5
    80001b8e:	47668693          	addi	a3,a3,1142 # 80007000 <_trampoline>
    80001b92:	00005717          	auipc	a4,0x5
    80001b96:	46e70713          	addi	a4,a4,1134 # 80007000 <_trampoline>
    80001b9a:	8f15                	sub	a4,a4,a3
    80001b9c:	040007b7          	lui	a5,0x4000
    80001ba0:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80001ba2:	07b2                	slli	a5,a5,0xc
    80001ba4:	973e                	add	a4,a4,a5
    asm volatile("csrw stvec, %0" : : "r"(x));
    80001ba6:	10571073          	csrw	stvec,a4

    // set up trapframe values that uservec will need when
    // the process next re-enters the kernel.
    p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001baa:	6d38                	ld	a4,88(a0)
    asm volatile("csrr %0, satp" : "=r"(x));
    80001bac:	18002673          	csrr	a2,satp
    80001bb0:	e310                	sd	a2,0(a4)
    p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001bb2:	6d30                	ld	a2,88(a0)
    80001bb4:	6138                	ld	a4,64(a0)
    80001bb6:	6585                	lui	a1,0x1
    80001bb8:	972e                	add	a4,a4,a1
    80001bba:	e618                	sd	a4,8(a2)
    p->trapframe->kernel_trap = (uint64)usertrap;
    80001bbc:	6d38                	ld	a4,88(a0)
    80001bbe:	00000617          	auipc	a2,0x0
    80001bc2:	14060613          	addi	a2,a2,320 # 80001cfe <usertrap>
    80001bc6:	eb10                	sd	a2,16(a4)
    p->trapframe->kernel_hartid = r_tp(); // hartid for cpuid()
    80001bc8:	6d38                	ld	a4,88(a0)
    asm volatile("mv %0, tp" : "=r"(x));
    80001bca:	8612                	mv	a2,tp
    80001bcc:	f310                	sd	a2,32(a4)
    asm volatile("csrr %0, sstatus" : "=r"(x));
    80001bce:	10002773          	csrr	a4,sstatus
    // set up the registers that trampoline.S's sret will use
    // to get to user space.

    // set S Previous Privilege mode to User.
    unsigned long x = r_sstatus();
    x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001bd2:	eff77713          	andi	a4,a4,-257
    x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001bd6:	02076713          	ori	a4,a4,32
    asm volatile("csrw sstatus, %0" : : "r"(x));
    80001bda:	10071073          	csrw	sstatus,a4
    w_sstatus(x);

    // set S Exception Program Counter to the saved user pc.
    w_sepc(p->trapframe->epc);
    80001bde:	6d38                	ld	a4,88(a0)
    asm volatile("csrw sepc, %0" : : "r"(x));
    80001be0:	6f18                	ld	a4,24(a4)
    80001be2:	14171073          	csrw	sepc,a4

    // tell trampoline.S the user page table to switch to.
    uint64 satp = MAKE_SATP(p->pagetable);
    80001be6:	692c                	ld	a1,80(a0)
    80001be8:	81b1                	srli	a1,a1,0xc

    // jump to trampoline.S at the top of memory, which
    // switches to the user page table, restores user registers,
    // and switches to user mode with sret.
    uint64 fn = TRAMPOLINE + (userret - trampoline);
    80001bea:	00005717          	auipc	a4,0x5
    80001bee:	4a670713          	addi	a4,a4,1190 # 80007090 <userret>
    80001bf2:	8f15                	sub	a4,a4,a3
    80001bf4:	97ba                	add	a5,a5,a4
    ((void (*)(uint64, uint64))fn)(TRAPFRAME, satp);
    80001bf6:	577d                	li	a4,-1
    80001bf8:	177e                	slli	a4,a4,0x3f
    80001bfa:	8dd9                	or	a1,a1,a4
    80001bfc:	02000537          	lui	a0,0x2000
    80001c00:	157d                	addi	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    80001c02:	0536                	slli	a0,a0,0xd
    80001c04:	9782                	jalr	a5
}
    80001c06:	60a2                	ld	ra,8(sp)
    80001c08:	6402                	ld	s0,0(sp)
    80001c0a:	0141                	addi	sp,sp,16
    80001c0c:	8082                	ret

0000000080001c0e <clockintr>:
    // so restore trap registers for use by kernelvec.S's sepc instruction.
    w_sepc(sepc);
    w_sstatus(sstatus);
}

void clockintr() {
    80001c0e:	1101                	addi	sp,sp,-32
    80001c10:	ec06                	sd	ra,24(sp)
    80001c12:	e822                	sd	s0,16(sp)
    80001c14:	e426                	sd	s1,8(sp)
    80001c16:	1000                	addi	s0,sp,32
    acquire(&tickslock);
    80001c18:	00010497          	auipc	s1,0x10
    80001c1c:	46848493          	addi	s1,s1,1128 # 80012080 <tickslock>
    80001c20:	8526                	mv	a0,s1
    80001c22:	00004097          	auipc	ra,0x4
    80001c26:	6ea080e7          	jalr	1770(ra) # 8000630c <acquire>
    ticks++;
    80001c2a:	0000a517          	auipc	a0,0xa
    80001c2e:	3ee50513          	addi	a0,a0,1006 # 8000c018 <ticks>
    80001c32:	411c                	lw	a5,0(a0)
    80001c34:	2785                	addiw	a5,a5,1
    80001c36:	c11c                	sw	a5,0(a0)
    wakeup(&ticks);
    80001c38:	00000097          	auipc	ra,0x0
    80001c3c:	aec080e7          	jalr	-1300(ra) # 80001724 <wakeup>
    release(&tickslock);
    80001c40:	8526                	mv	a0,s1
    80001c42:	00004097          	auipc	ra,0x4
    80001c46:	77e080e7          	jalr	1918(ra) # 800063c0 <release>
}
    80001c4a:	60e2                	ld	ra,24(sp)
    80001c4c:	6442                	ld	s0,16(sp)
    80001c4e:	64a2                	ld	s1,8(sp)
    80001c50:	6105                	addi	sp,sp,32
    80001c52:	8082                	ret

0000000080001c54 <devintr>:
    asm volatile("csrr %0, scause" : "=r"(x));
    80001c54:	142027f3          	csrr	a5,scause
        // the SSIP bit in sip.
        w_sip(r_sip() & ~2);

        return 2;
    } else {
        return 0;
    80001c58:	4501                	li	a0,0
    if ((scause & 0x8000000000000000L) && (scause & 0xff) == 9) {
    80001c5a:	0a07d163          	bgez	a5,80001cfc <devintr+0xa8>
int devintr() {
    80001c5e:	1101                	addi	sp,sp,-32
    80001c60:	ec06                	sd	ra,24(sp)
    80001c62:	e822                	sd	s0,16(sp)
    80001c64:	1000                	addi	s0,sp,32
    if ((scause & 0x8000000000000000L) && (scause & 0xff) == 9) {
    80001c66:	0ff7f713          	zext.b	a4,a5
    80001c6a:	46a5                	li	a3,9
    80001c6c:	00d70c63          	beq	a4,a3,80001c84 <devintr+0x30>
    } else if (scause == 0x8000000000000001L) {
    80001c70:	577d                	li	a4,-1
    80001c72:	177e                	slli	a4,a4,0x3f
    80001c74:	0705                	addi	a4,a4,1
        return 0;
    80001c76:	4501                	li	a0,0
    } else if (scause == 0x8000000000000001L) {
    80001c78:	06e78163          	beq	a5,a4,80001cda <devintr+0x86>
    }
}
    80001c7c:	60e2                	ld	ra,24(sp)
    80001c7e:	6442                	ld	s0,16(sp)
    80001c80:	6105                	addi	sp,sp,32
    80001c82:	8082                	ret
    80001c84:	e426                	sd	s1,8(sp)
        int irq = plic_claim();
    80001c86:	00003097          	auipc	ra,0x3
    80001c8a:	5a6080e7          	jalr	1446(ra) # 8000522c <plic_claim>
    80001c8e:	84aa                	mv	s1,a0
        if (irq == UART0_IRQ) {
    80001c90:	47a9                	li	a5,10
    80001c92:	00f50963          	beq	a0,a5,80001ca4 <devintr+0x50>
        } else if (irq == VIRTIO0_IRQ) {
    80001c96:	4785                	li	a5,1
    80001c98:	00f50b63          	beq	a0,a5,80001cae <devintr+0x5a>
        return 1;
    80001c9c:	4505                	li	a0,1
        } else if (irq) {
    80001c9e:	ec89                	bnez	s1,80001cb8 <devintr+0x64>
    80001ca0:	64a2                	ld	s1,8(sp)
    80001ca2:	bfe9                	j	80001c7c <devintr+0x28>
            uartintr();
    80001ca4:	00004097          	auipc	ra,0x4
    80001ca8:	588080e7          	jalr	1416(ra) # 8000622c <uartintr>
        if (irq)
    80001cac:	a839                	j	80001cca <devintr+0x76>
            virtio_disk_intr();
    80001cae:	00004097          	auipc	ra,0x4
    80001cb2:	a52080e7          	jalr	-1454(ra) # 80005700 <virtio_disk_intr>
        if (irq)
    80001cb6:	a811                	j	80001cca <devintr+0x76>
            printf("unexpected interrupt irq=%d\n", irq);
    80001cb8:	85a6                	mv	a1,s1
    80001cba:	00006517          	auipc	a0,0x6
    80001cbe:	58e50513          	addi	a0,a0,1422 # 80008248 <etext+0x248>
    80001cc2:	00004097          	auipc	ra,0x4
    80001cc6:	11a080e7          	jalr	282(ra) # 80005ddc <printf>
            plic_complete(irq);
    80001cca:	8526                	mv	a0,s1
    80001ccc:	00003097          	auipc	ra,0x3
    80001cd0:	584080e7          	jalr	1412(ra) # 80005250 <plic_complete>
        return 1;
    80001cd4:	4505                	li	a0,1
    80001cd6:	64a2                	ld	s1,8(sp)
    80001cd8:	b755                	j	80001c7c <devintr+0x28>
        if (cpuid() == 0) {
    80001cda:	fffff097          	auipc	ra,0xfffff
    80001cde:	1c0080e7          	jalr	448(ra) # 80000e9a <cpuid>
    80001ce2:	c901                	beqz	a0,80001cf2 <devintr+0x9e>
    asm volatile("csrr %0, sip" : "=r"(x));
    80001ce4:	144027f3          	csrr	a5,sip
        w_sip(r_sip() & ~2);
    80001ce8:	9bf5                	andi	a5,a5,-3
static inline void w_sip(uint64 x) { asm volatile("csrw sip, %0" : : "r"(x)); }
    80001cea:	14479073          	csrw	sip,a5
        return 2;
    80001cee:	4509                	li	a0,2
    80001cf0:	b771                	j	80001c7c <devintr+0x28>
            clockintr();
    80001cf2:	00000097          	auipc	ra,0x0
    80001cf6:	f1c080e7          	jalr	-228(ra) # 80001c0e <clockintr>
    80001cfa:	b7ed                	j	80001ce4 <devintr+0x90>
}
    80001cfc:	8082                	ret

0000000080001cfe <usertrap>:
void usertrap(void) {
    80001cfe:	1101                	addi	sp,sp,-32
    80001d00:	ec06                	sd	ra,24(sp)
    80001d02:	e822                	sd	s0,16(sp)
    80001d04:	e426                	sd	s1,8(sp)
    80001d06:	e04a                	sd	s2,0(sp)
    80001d08:	1000                	addi	s0,sp,32
    asm volatile("csrr %0, sstatus" : "=r"(x));
    80001d0a:	100027f3          	csrr	a5,sstatus
    if ((r_sstatus() & SSTATUS_SPP) != 0)
    80001d0e:	1007f793          	andi	a5,a5,256
    80001d12:	e3ad                	bnez	a5,80001d74 <usertrap+0x76>
    asm volatile("csrw stvec, %0" : : "r"(x));
    80001d14:	00003797          	auipc	a5,0x3
    80001d18:	40c78793          	addi	a5,a5,1036 # 80005120 <kernelvec>
    80001d1c:	10579073          	csrw	stvec,a5
    struct proc *p = myproc();
    80001d20:	fffff097          	auipc	ra,0xfffff
    80001d24:	1a6080e7          	jalr	422(ra) # 80000ec6 <myproc>
    80001d28:	84aa                	mv	s1,a0
    p->trapframe->epc = r_sepc();
    80001d2a:	6d3c                	ld	a5,88(a0)
    asm volatile("csrr %0, sepc" : "=r"(x));
    80001d2c:	14102773          	csrr	a4,sepc
    80001d30:	ef98                	sd	a4,24(a5)
    asm volatile("csrr %0, scause" : "=r"(x));
    80001d32:	14202773          	csrr	a4,scause
    if (r_scause() == 8) {
    80001d36:	47a1                	li	a5,8
    80001d38:	04f71c63          	bne	a4,a5,80001d90 <usertrap+0x92>
        if (p->killed)
    80001d3c:	551c                	lw	a5,40(a0)
    80001d3e:	e3b9                	bnez	a5,80001d84 <usertrap+0x86>
        p->trapframe->epc += 4;
    80001d40:	6cb8                	ld	a4,88(s1)
    80001d42:	6f1c                	ld	a5,24(a4)
    80001d44:	0791                	addi	a5,a5,4
    80001d46:	ef1c                	sd	a5,24(a4)
    asm volatile("csrr %0, sstatus" : "=r"(x));
    80001d48:	100027f3          	csrr	a5,sstatus
static inline void intr_on() { w_sstatus(r_sstatus() | SSTATUS_SIE); }
    80001d4c:	0027e793          	ori	a5,a5,2
    asm volatile("csrw sstatus, %0" : : "r"(x));
    80001d50:	10079073          	csrw	sstatus,a5
        syscall();
    80001d54:	00000097          	auipc	ra,0x0
    80001d58:	2e0080e7          	jalr	736(ra) # 80002034 <syscall>
    if (p->killed)
    80001d5c:	549c                	lw	a5,40(s1)
    80001d5e:	ebc1                	bnez	a5,80001dee <usertrap+0xf0>
    usertrapret();
    80001d60:	00000097          	auipc	ra,0x0
    80001d64:	e10080e7          	jalr	-496(ra) # 80001b70 <usertrapret>
}
    80001d68:	60e2                	ld	ra,24(sp)
    80001d6a:	6442                	ld	s0,16(sp)
    80001d6c:	64a2                	ld	s1,8(sp)
    80001d6e:	6902                	ld	s2,0(sp)
    80001d70:	6105                	addi	sp,sp,32
    80001d72:	8082                	ret
        panic("usertrap: not from user mode");
    80001d74:	00006517          	auipc	a0,0x6
    80001d78:	4f450513          	addi	a0,a0,1268 # 80008268 <etext+0x268>
    80001d7c:	00004097          	auipc	ra,0x4
    80001d80:	016080e7          	jalr	22(ra) # 80005d92 <panic>
            exit(-1);
    80001d84:	557d                	li	a0,-1
    80001d86:	00000097          	auipc	ra,0x0
    80001d8a:	a6e080e7          	jalr	-1426(ra) # 800017f4 <exit>
    80001d8e:	bf4d                	j	80001d40 <usertrap+0x42>
    } else if ((which_dev = devintr()) != 0) {
    80001d90:	00000097          	auipc	ra,0x0
    80001d94:	ec4080e7          	jalr	-316(ra) # 80001c54 <devintr>
    80001d98:	892a                	mv	s2,a0
    80001d9a:	c501                	beqz	a0,80001da2 <usertrap+0xa4>
    if (p->killed)
    80001d9c:	549c                	lw	a5,40(s1)
    80001d9e:	c3a1                	beqz	a5,80001dde <usertrap+0xe0>
    80001da0:	a815                	j	80001dd4 <usertrap+0xd6>
    asm volatile("csrr %0, scause" : "=r"(x));
    80001da2:	142025f3          	csrr	a1,scause
        printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80001da6:	5890                	lw	a2,48(s1)
    80001da8:	00006517          	auipc	a0,0x6
    80001dac:	4e050513          	addi	a0,a0,1248 # 80008288 <etext+0x288>
    80001db0:	00004097          	auipc	ra,0x4
    80001db4:	02c080e7          	jalr	44(ra) # 80005ddc <printf>
    asm volatile("csrr %0, sepc" : "=r"(x));
    80001db8:	141025f3          	csrr	a1,sepc
    asm volatile("csrr %0, stval" : "=r"(x));
    80001dbc:	14302673          	csrr	a2,stval
        printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001dc0:	00006517          	auipc	a0,0x6
    80001dc4:	4f850513          	addi	a0,a0,1272 # 800082b8 <etext+0x2b8>
    80001dc8:	00004097          	auipc	ra,0x4
    80001dcc:	014080e7          	jalr	20(ra) # 80005ddc <printf>
        p->killed = 1;
    80001dd0:	4785                	li	a5,1
    80001dd2:	d49c                	sw	a5,40(s1)
        exit(-1);
    80001dd4:	557d                	li	a0,-1
    80001dd6:	00000097          	auipc	ra,0x0
    80001dda:	a1e080e7          	jalr	-1506(ra) # 800017f4 <exit>
    if (which_dev == 2)
    80001dde:	4789                	li	a5,2
    80001de0:	f8f910e3          	bne	s2,a5,80001d60 <usertrap+0x62>
        yield();
    80001de4:	fffff097          	auipc	ra,0xfffff
    80001de8:	778080e7          	jalr	1912(ra) # 8000155c <yield>
    80001dec:	bf95                	j	80001d60 <usertrap+0x62>
    int which_dev = 0;
    80001dee:	4901                	li	s2,0
    80001df0:	b7d5                	j	80001dd4 <usertrap+0xd6>

0000000080001df2 <kerneltrap>:
void kerneltrap() {
    80001df2:	7179                	addi	sp,sp,-48
    80001df4:	f406                	sd	ra,40(sp)
    80001df6:	f022                	sd	s0,32(sp)
    80001df8:	ec26                	sd	s1,24(sp)
    80001dfa:	e84a                	sd	s2,16(sp)
    80001dfc:	e44e                	sd	s3,8(sp)
    80001dfe:	1800                	addi	s0,sp,48
    asm volatile("csrr %0, sepc" : "=r"(x));
    80001e00:	14102973          	csrr	s2,sepc
    asm volatile("csrr %0, sstatus" : "=r"(x));
    80001e04:	100024f3          	csrr	s1,sstatus
    asm volatile("csrr %0, scause" : "=r"(x));
    80001e08:	142029f3          	csrr	s3,scause
    if ((sstatus & SSTATUS_SPP) == 0)
    80001e0c:	1004f793          	andi	a5,s1,256
    80001e10:	cb85                	beqz	a5,80001e40 <kerneltrap+0x4e>
    asm volatile("csrr %0, sstatus" : "=r"(x));
    80001e12:	100027f3          	csrr	a5,sstatus
    return (x & SSTATUS_SIE) != 0;
    80001e16:	8b89                	andi	a5,a5,2
    if (intr_get() != 0)
    80001e18:	ef85                	bnez	a5,80001e50 <kerneltrap+0x5e>
    if ((which_dev = devintr()) == 0) {
    80001e1a:	00000097          	auipc	ra,0x0
    80001e1e:	e3a080e7          	jalr	-454(ra) # 80001c54 <devintr>
    80001e22:	cd1d                	beqz	a0,80001e60 <kerneltrap+0x6e>
    if (which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001e24:	4789                	li	a5,2
    80001e26:	06f50a63          	beq	a0,a5,80001e9a <kerneltrap+0xa8>
    asm volatile("csrw sepc, %0" : : "r"(x));
    80001e2a:	14191073          	csrw	sepc,s2
    asm volatile("csrw sstatus, %0" : : "r"(x));
    80001e2e:	10049073          	csrw	sstatus,s1
}
    80001e32:	70a2                	ld	ra,40(sp)
    80001e34:	7402                	ld	s0,32(sp)
    80001e36:	64e2                	ld	s1,24(sp)
    80001e38:	6942                	ld	s2,16(sp)
    80001e3a:	69a2                	ld	s3,8(sp)
    80001e3c:	6145                	addi	sp,sp,48
    80001e3e:	8082                	ret
        panic("kerneltrap: not from supervisor mode");
    80001e40:	00006517          	auipc	a0,0x6
    80001e44:	49850513          	addi	a0,a0,1176 # 800082d8 <etext+0x2d8>
    80001e48:	00004097          	auipc	ra,0x4
    80001e4c:	f4a080e7          	jalr	-182(ra) # 80005d92 <panic>
        panic("kerneltrap: interrupts enabled");
    80001e50:	00006517          	auipc	a0,0x6
    80001e54:	4b050513          	addi	a0,a0,1200 # 80008300 <etext+0x300>
    80001e58:	00004097          	auipc	ra,0x4
    80001e5c:	f3a080e7          	jalr	-198(ra) # 80005d92 <panic>
        printf("scause %p\n", scause);
    80001e60:	85ce                	mv	a1,s3
    80001e62:	00006517          	auipc	a0,0x6
    80001e66:	4be50513          	addi	a0,a0,1214 # 80008320 <etext+0x320>
    80001e6a:	00004097          	auipc	ra,0x4
    80001e6e:	f72080e7          	jalr	-142(ra) # 80005ddc <printf>
    asm volatile("csrr %0, sepc" : "=r"(x));
    80001e72:	141025f3          	csrr	a1,sepc
    asm volatile("csrr %0, stval" : "=r"(x));
    80001e76:	14302673          	csrr	a2,stval
        printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001e7a:	00006517          	auipc	a0,0x6
    80001e7e:	4b650513          	addi	a0,a0,1206 # 80008330 <etext+0x330>
    80001e82:	00004097          	auipc	ra,0x4
    80001e86:	f5a080e7          	jalr	-166(ra) # 80005ddc <printf>
        panic("kerneltrap");
    80001e8a:	00006517          	auipc	a0,0x6
    80001e8e:	4be50513          	addi	a0,a0,1214 # 80008348 <etext+0x348>
    80001e92:	00004097          	auipc	ra,0x4
    80001e96:	f00080e7          	jalr	-256(ra) # 80005d92 <panic>
    if (which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001e9a:	fffff097          	auipc	ra,0xfffff
    80001e9e:	02c080e7          	jalr	44(ra) # 80000ec6 <myproc>
    80001ea2:	d541                	beqz	a0,80001e2a <kerneltrap+0x38>
    80001ea4:	fffff097          	auipc	ra,0xfffff
    80001ea8:	022080e7          	jalr	34(ra) # 80000ec6 <myproc>
    80001eac:	4d18                	lw	a4,24(a0)
    80001eae:	4791                	li	a5,4
    80001eb0:	f6f71de3          	bne	a4,a5,80001e2a <kerneltrap+0x38>
        yield();
    80001eb4:	fffff097          	auipc	ra,0xfffff
    80001eb8:	6a8080e7          	jalr	1704(ra) # 8000155c <yield>
    80001ebc:	b7bd                	j	80001e2a <kerneltrap+0x38>

0000000080001ebe <argraw>:
    if (err < 0)
        return err;
    return strlen(buf);
}

static uint64 argraw(int n) {
    80001ebe:	1101                	addi	sp,sp,-32
    80001ec0:	ec06                	sd	ra,24(sp)
    80001ec2:	e822                	sd	s0,16(sp)
    80001ec4:	e426                	sd	s1,8(sp)
    80001ec6:	1000                	addi	s0,sp,32
    80001ec8:	84aa                	mv	s1,a0
    struct proc *p = myproc();
    80001eca:	fffff097          	auipc	ra,0xfffff
    80001ece:	ffc080e7          	jalr	-4(ra) # 80000ec6 <myproc>
    switch (n) {
    80001ed2:	4795                	li	a5,5
    80001ed4:	0497e163          	bltu	a5,s1,80001f16 <argraw+0x58>
    80001ed8:	048a                	slli	s1,s1,0x2
    80001eda:	00007717          	auipc	a4,0x7
    80001ede:	91670713          	addi	a4,a4,-1770 # 800087f0 <states.0+0x30>
    80001ee2:	94ba                	add	s1,s1,a4
    80001ee4:	409c                	lw	a5,0(s1)
    80001ee6:	97ba                	add	a5,a5,a4
    80001ee8:	8782                	jr	a5
    case 0:
        return p->trapframe->a0;
    80001eea:	6d3c                	ld	a5,88(a0)
    80001eec:	7ba8                	ld	a0,112(a5)
    case 5:
        return p->trapframe->a5;
    }
    panic("argraw");
    return -1;
}
    80001eee:	60e2                	ld	ra,24(sp)
    80001ef0:	6442                	ld	s0,16(sp)
    80001ef2:	64a2                	ld	s1,8(sp)
    80001ef4:	6105                	addi	sp,sp,32
    80001ef6:	8082                	ret
        return p->trapframe->a1;
    80001ef8:	6d3c                	ld	a5,88(a0)
    80001efa:	7fa8                	ld	a0,120(a5)
    80001efc:	bfcd                	j	80001eee <argraw+0x30>
        return p->trapframe->a2;
    80001efe:	6d3c                	ld	a5,88(a0)
    80001f00:	63c8                	ld	a0,128(a5)
    80001f02:	b7f5                	j	80001eee <argraw+0x30>
        return p->trapframe->a3;
    80001f04:	6d3c                	ld	a5,88(a0)
    80001f06:	67c8                	ld	a0,136(a5)
    80001f08:	b7dd                	j	80001eee <argraw+0x30>
        return p->trapframe->a4;
    80001f0a:	6d3c                	ld	a5,88(a0)
    80001f0c:	6bc8                	ld	a0,144(a5)
    80001f0e:	b7c5                	j	80001eee <argraw+0x30>
        return p->trapframe->a5;
    80001f10:	6d3c                	ld	a5,88(a0)
    80001f12:	6fc8                	ld	a0,152(a5)
    80001f14:	bfe9                	j	80001eee <argraw+0x30>
    panic("argraw");
    80001f16:	00006517          	auipc	a0,0x6
    80001f1a:	44250513          	addi	a0,a0,1090 # 80008358 <etext+0x358>
    80001f1e:	00004097          	auipc	ra,0x4
    80001f22:	e74080e7          	jalr	-396(ra) # 80005d92 <panic>

0000000080001f26 <fetchaddr>:
int fetchaddr(uint64 addr, uint64 *ip) {
    80001f26:	1101                	addi	sp,sp,-32
    80001f28:	ec06                	sd	ra,24(sp)
    80001f2a:	e822                	sd	s0,16(sp)
    80001f2c:	e426                	sd	s1,8(sp)
    80001f2e:	e04a                	sd	s2,0(sp)
    80001f30:	1000                	addi	s0,sp,32
    80001f32:	84aa                	mv	s1,a0
    80001f34:	892e                	mv	s2,a1
    struct proc *p = myproc();
    80001f36:	fffff097          	auipc	ra,0xfffff
    80001f3a:	f90080e7          	jalr	-112(ra) # 80000ec6 <myproc>
    if (addr >= p->sz || addr + sizeof(uint64) > p->sz)
    80001f3e:	653c                	ld	a5,72(a0)
    80001f40:	02f4f863          	bgeu	s1,a5,80001f70 <fetchaddr+0x4a>
    80001f44:	00848713          	addi	a4,s1,8
    80001f48:	02e7e663          	bltu	a5,a4,80001f74 <fetchaddr+0x4e>
    if (copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80001f4c:	46a1                	li	a3,8
    80001f4e:	8626                	mv	a2,s1
    80001f50:	85ca                	mv	a1,s2
    80001f52:	6928                	ld	a0,80(a0)
    80001f54:	fffff097          	auipc	ra,0xfffff
    80001f58:	c9a080e7          	jalr	-870(ra) # 80000bee <copyin>
    80001f5c:	00a03533          	snez	a0,a0
    80001f60:	40a00533          	neg	a0,a0
}
    80001f64:	60e2                	ld	ra,24(sp)
    80001f66:	6442                	ld	s0,16(sp)
    80001f68:	64a2                	ld	s1,8(sp)
    80001f6a:	6902                	ld	s2,0(sp)
    80001f6c:	6105                	addi	sp,sp,32
    80001f6e:	8082                	ret
        return -1;
    80001f70:	557d                	li	a0,-1
    80001f72:	bfcd                	j	80001f64 <fetchaddr+0x3e>
    80001f74:	557d                	li	a0,-1
    80001f76:	b7fd                	j	80001f64 <fetchaddr+0x3e>

0000000080001f78 <fetchstr>:
int fetchstr(uint64 addr, char *buf, int max) {
    80001f78:	7179                	addi	sp,sp,-48
    80001f7a:	f406                	sd	ra,40(sp)
    80001f7c:	f022                	sd	s0,32(sp)
    80001f7e:	ec26                	sd	s1,24(sp)
    80001f80:	e84a                	sd	s2,16(sp)
    80001f82:	e44e                	sd	s3,8(sp)
    80001f84:	1800                	addi	s0,sp,48
    80001f86:	892a                	mv	s2,a0
    80001f88:	84ae                	mv	s1,a1
    80001f8a:	89b2                	mv	s3,a2
    struct proc *p = myproc();
    80001f8c:	fffff097          	auipc	ra,0xfffff
    80001f90:	f3a080e7          	jalr	-198(ra) # 80000ec6 <myproc>
    int err = copyinstr(p->pagetable, buf, addr, max);
    80001f94:	86ce                	mv	a3,s3
    80001f96:	864a                	mv	a2,s2
    80001f98:	85a6                	mv	a1,s1
    80001f9a:	6928                	ld	a0,80(a0)
    80001f9c:	fffff097          	auipc	ra,0xfffff
    80001fa0:	ce0080e7          	jalr	-800(ra) # 80000c7c <copyinstr>
    if (err < 0)
    80001fa4:	00054763          	bltz	a0,80001fb2 <fetchstr+0x3a>
    return strlen(buf);
    80001fa8:	8526                	mv	a0,s1
    80001faa:	ffffe097          	auipc	ra,0xffffe
    80001fae:	38e080e7          	jalr	910(ra) # 80000338 <strlen>
}
    80001fb2:	70a2                	ld	ra,40(sp)
    80001fb4:	7402                	ld	s0,32(sp)
    80001fb6:	64e2                	ld	s1,24(sp)
    80001fb8:	6942                	ld	s2,16(sp)
    80001fba:	69a2                	ld	s3,8(sp)
    80001fbc:	6145                	addi	sp,sp,48
    80001fbe:	8082                	ret

0000000080001fc0 <argint>:

// Fetch the nth 32-bit system call argument.
int argint(int n, int *ip) {
    80001fc0:	1101                	addi	sp,sp,-32
    80001fc2:	ec06                	sd	ra,24(sp)
    80001fc4:	e822                	sd	s0,16(sp)
    80001fc6:	e426                	sd	s1,8(sp)
    80001fc8:	1000                	addi	s0,sp,32
    80001fca:	84ae                	mv	s1,a1
    *ip = argraw(n);
    80001fcc:	00000097          	auipc	ra,0x0
    80001fd0:	ef2080e7          	jalr	-270(ra) # 80001ebe <argraw>
    80001fd4:	c088                	sw	a0,0(s1)
    return 0;
}
    80001fd6:	4501                	li	a0,0
    80001fd8:	60e2                	ld	ra,24(sp)
    80001fda:	6442                	ld	s0,16(sp)
    80001fdc:	64a2                	ld	s1,8(sp)
    80001fde:	6105                	addi	sp,sp,32
    80001fe0:	8082                	ret

0000000080001fe2 <argaddr>:

// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int argaddr(int n, uint64 *ip) {
    80001fe2:	1101                	addi	sp,sp,-32
    80001fe4:	ec06                	sd	ra,24(sp)
    80001fe6:	e822                	sd	s0,16(sp)
    80001fe8:	e426                	sd	s1,8(sp)
    80001fea:	1000                	addi	s0,sp,32
    80001fec:	84ae                	mv	s1,a1
    *ip = argraw(n);
    80001fee:	00000097          	auipc	ra,0x0
    80001ff2:	ed0080e7          	jalr	-304(ra) # 80001ebe <argraw>
    80001ff6:	e088                	sd	a0,0(s1)
    return 0;
}
    80001ff8:	4501                	li	a0,0
    80001ffa:	60e2                	ld	ra,24(sp)
    80001ffc:	6442                	ld	s0,16(sp)
    80001ffe:	64a2                	ld	s1,8(sp)
    80002000:	6105                	addi	sp,sp,32
    80002002:	8082                	ret

0000000080002004 <argstr>:

// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int argstr(int n, char *buf, int max) {
    80002004:	1101                	addi	sp,sp,-32
    80002006:	ec06                	sd	ra,24(sp)
    80002008:	e822                	sd	s0,16(sp)
    8000200a:	e426                	sd	s1,8(sp)
    8000200c:	e04a                	sd	s2,0(sp)
    8000200e:	1000                	addi	s0,sp,32
    80002010:	84ae                	mv	s1,a1
    80002012:	8932                	mv	s2,a2
    *ip = argraw(n);
    80002014:	00000097          	auipc	ra,0x0
    80002018:	eaa080e7          	jalr	-342(ra) # 80001ebe <argraw>
    uint64 addr;
    if (argaddr(n, &addr) < 0)
        return -1;
    return fetchstr(addr, buf, max);
    8000201c:	864a                	mv	a2,s2
    8000201e:	85a6                	mv	a1,s1
    80002020:	00000097          	auipc	ra,0x0
    80002024:	f58080e7          	jalr	-168(ra) # 80001f78 <fetchstr>
}
    80002028:	60e2                	ld	ra,24(sp)
    8000202a:	6442                	ld	s0,16(sp)
    8000202c:	64a2                	ld	s1,8(sp)
    8000202e:	6902                	ld	s2,0(sp)
    80002030:	6105                	addi	sp,sp,32
    80002032:	8082                	ret

0000000080002034 <syscall>:
    "fstat", "chdir", "dup", "getpid", "sbrk", "sleep", "uptime",
    "open", "write", "mknod", "unlink", "link", "mkdir", "close",
    "trace"
};

void syscall(void) {
    80002034:	7179                	addi	sp,sp,-48
    80002036:	f406                	sd	ra,40(sp)
    80002038:	f022                	sd	s0,32(sp)
    8000203a:	ec26                	sd	s1,24(sp)
    8000203c:	e84a                	sd	s2,16(sp)
    8000203e:	e44e                	sd	s3,8(sp)
    80002040:	1800                	addi	s0,sp,48
    int num;
    struct proc *p = myproc();
    80002042:	fffff097          	auipc	ra,0xfffff
    80002046:	e84080e7          	jalr	-380(ra) # 80000ec6 <myproc>
    8000204a:	84aa                	mv	s1,a0

    num = p->trapframe->a7;
    8000204c:	05853903          	ld	s2,88(a0)
    80002050:	0a893783          	ld	a5,168(s2)
    80002054:	0007899b          	sext.w	s3,a5
    if (num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002058:	37fd                	addiw	a5,a5,-1
    8000205a:	4759                	li	a4,22
    8000205c:	04f76763          	bltu	a4,a5,800020aa <syscall+0x76>
    80002060:	00399713          	slli	a4,s3,0x3
    80002064:	00006797          	auipc	a5,0x6
    80002068:	7a478793          	addi	a5,a5,1956 # 80008808 <syscalls>
    8000206c:	97ba                	add	a5,a5,a4
    8000206e:	639c                	ld	a5,0(a5)
    80002070:	cf8d                	beqz	a5,800020aa <syscall+0x76>
        p->trapframe->a0 = syscalls[num]();
    80002072:	9782                	jalr	a5
    80002074:	06a93823          	sd	a0,112(s2)
        uint32 trace_mask = p->trace_mask;
    80002078:	1684b783          	ld	a5,360(s1)
        if  ((trace_mask >> num) & 1) {
    8000207c:	0137d7bb          	srlw	a5,a5,s3
    80002080:	8b85                	andi	a5,a5,1
    80002082:	c3b9                	beqz	a5,800020c8 <syscall+0x94>
          printf("%d: syscall %s -> %d\n", p->pid, syscall_name[num], p->trapframe->a0);
    80002084:	6cb8                	ld	a4,88(s1)
    80002086:	098e                	slli	s3,s3,0x3
    80002088:	00006797          	auipc	a5,0x6
    8000208c:	78078793          	addi	a5,a5,1920 # 80008808 <syscalls>
    80002090:	97ce                	add	a5,a5,s3
    80002092:	7b34                	ld	a3,112(a4)
    80002094:	63f0                	ld	a2,192(a5)
    80002096:	588c                	lw	a1,48(s1)
    80002098:	00006517          	auipc	a0,0x6
    8000209c:	2c850513          	addi	a0,a0,712 # 80008360 <etext+0x360>
    800020a0:	00004097          	auipc	ra,0x4
    800020a4:	d3c080e7          	jalr	-708(ra) # 80005ddc <printf>
    800020a8:	a005                	j	800020c8 <syscall+0x94>
        }
    } else {
        printf("%d %s: unknown sys call %d\n", p->pid, p->name, num);
    800020aa:	86ce                	mv	a3,s3
    800020ac:	15848613          	addi	a2,s1,344
    800020b0:	588c                	lw	a1,48(s1)
    800020b2:	00006517          	auipc	a0,0x6
    800020b6:	2c650513          	addi	a0,a0,710 # 80008378 <etext+0x378>
    800020ba:	00004097          	auipc	ra,0x4
    800020be:	d22080e7          	jalr	-734(ra) # 80005ddc <printf>
        p->trapframe->a0 = -1;
    800020c2:	6cbc                	ld	a5,88(s1)
    800020c4:	577d                	li	a4,-1
    800020c6:	fbb8                	sd	a4,112(a5)
    }
}
    800020c8:	70a2                	ld	ra,40(sp)
    800020ca:	7402                	ld	s0,32(sp)
    800020cc:	64e2                	ld	s1,24(sp)
    800020ce:	6942                	ld	s2,16(sp)
    800020d0:	69a2                	ld	s3,8(sp)
    800020d2:	6145                	addi	sp,sp,48
    800020d4:	8082                	ret

00000000800020d6 <sys_exit>:
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"

uint64 sys_exit(void) {
    800020d6:	1101                	addi	sp,sp,-32
    800020d8:	ec06                	sd	ra,24(sp)
    800020da:	e822                	sd	s0,16(sp)
    800020dc:	1000                	addi	s0,sp,32
    int n;
    if (argint(0, &n) < 0)
    800020de:	fec40593          	addi	a1,s0,-20
    800020e2:	4501                	li	a0,0
    800020e4:	00000097          	auipc	ra,0x0
    800020e8:	edc080e7          	jalr	-292(ra) # 80001fc0 <argint>
        return -1;
    800020ec:	57fd                	li	a5,-1
    if (argint(0, &n) < 0)
    800020ee:	00054963          	bltz	a0,80002100 <sys_exit+0x2a>
    exit(n);
    800020f2:	fec42503          	lw	a0,-20(s0)
    800020f6:	fffff097          	auipc	ra,0xfffff
    800020fa:	6fe080e7          	jalr	1790(ra) # 800017f4 <exit>
    return 0; // not reached
    800020fe:	4781                	li	a5,0
}
    80002100:	853e                	mv	a0,a5
    80002102:	60e2                	ld	ra,24(sp)
    80002104:	6442                	ld	s0,16(sp)
    80002106:	6105                	addi	sp,sp,32
    80002108:	8082                	ret

000000008000210a <sys_getpid>:

uint64 sys_getpid(void) { return myproc()->pid; }
    8000210a:	1141                	addi	sp,sp,-16
    8000210c:	e406                	sd	ra,8(sp)
    8000210e:	e022                	sd	s0,0(sp)
    80002110:	0800                	addi	s0,sp,16
    80002112:	fffff097          	auipc	ra,0xfffff
    80002116:	db4080e7          	jalr	-588(ra) # 80000ec6 <myproc>
    8000211a:	5908                	lw	a0,48(a0)
    8000211c:	60a2                	ld	ra,8(sp)
    8000211e:	6402                	ld	s0,0(sp)
    80002120:	0141                	addi	sp,sp,16
    80002122:	8082                	ret

0000000080002124 <sys_fork>:

uint64 sys_fork(void) { return fork(); }
    80002124:	1141                	addi	sp,sp,-16
    80002126:	e406                	sd	ra,8(sp)
    80002128:	e022                	sd	s0,0(sp)
    8000212a:	0800                	addi	s0,sp,16
    8000212c:	fffff097          	auipc	ra,0xfffff
    80002130:	170080e7          	jalr	368(ra) # 8000129c <fork>
    80002134:	60a2                	ld	ra,8(sp)
    80002136:	6402                	ld	s0,0(sp)
    80002138:	0141                	addi	sp,sp,16
    8000213a:	8082                	ret

000000008000213c <sys_wait>:

uint64 sys_wait(void) {
    8000213c:	1101                	addi	sp,sp,-32
    8000213e:	ec06                	sd	ra,24(sp)
    80002140:	e822                	sd	s0,16(sp)
    80002142:	1000                	addi	s0,sp,32
    uint64 p;
    if (argaddr(0, &p) < 0)
    80002144:	fe840593          	addi	a1,s0,-24
    80002148:	4501                	li	a0,0
    8000214a:	00000097          	auipc	ra,0x0
    8000214e:	e98080e7          	jalr	-360(ra) # 80001fe2 <argaddr>
    80002152:	87aa                	mv	a5,a0
        return -1;
    80002154:	557d                	li	a0,-1
    if (argaddr(0, &p) < 0)
    80002156:	0007c863          	bltz	a5,80002166 <sys_wait+0x2a>
    return wait(p);
    8000215a:	fe843503          	ld	a0,-24(s0)
    8000215e:	fffff097          	auipc	ra,0xfffff
    80002162:	49e080e7          	jalr	1182(ra) # 800015fc <wait>
}
    80002166:	60e2                	ld	ra,24(sp)
    80002168:	6442                	ld	s0,16(sp)
    8000216a:	6105                	addi	sp,sp,32
    8000216c:	8082                	ret

000000008000216e <sys_sbrk>:

uint64 sys_sbrk(void) {
    8000216e:	7179                	addi	sp,sp,-48
    80002170:	f406                	sd	ra,40(sp)
    80002172:	f022                	sd	s0,32(sp)
    80002174:	1800                	addi	s0,sp,48
    int addr;
    int n;

    if (argint(0, &n) < 0)
    80002176:	fdc40593          	addi	a1,s0,-36
    8000217a:	4501                	li	a0,0
    8000217c:	00000097          	auipc	ra,0x0
    80002180:	e44080e7          	jalr	-444(ra) # 80001fc0 <argint>
    80002184:	87aa                	mv	a5,a0
        return -1;
    80002186:	557d                	li	a0,-1
    if (argint(0, &n) < 0)
    80002188:	0207c263          	bltz	a5,800021ac <sys_sbrk+0x3e>
    8000218c:	ec26                	sd	s1,24(sp)
    addr = myproc()->sz;
    8000218e:	fffff097          	auipc	ra,0xfffff
    80002192:	d38080e7          	jalr	-712(ra) # 80000ec6 <myproc>
    80002196:	4524                	lw	s1,72(a0)
    if (growproc(n) < 0)
    80002198:	fdc42503          	lw	a0,-36(s0)
    8000219c:	fffff097          	auipc	ra,0xfffff
    800021a0:	088080e7          	jalr	136(ra) # 80001224 <growproc>
    800021a4:	00054863          	bltz	a0,800021b4 <sys_sbrk+0x46>
        return -1;
    return addr;
    800021a8:	8526                	mv	a0,s1
    800021aa:	64e2                	ld	s1,24(sp)
}
    800021ac:	70a2                	ld	ra,40(sp)
    800021ae:	7402                	ld	s0,32(sp)
    800021b0:	6145                	addi	sp,sp,48
    800021b2:	8082                	ret
        return -1;
    800021b4:	557d                	li	a0,-1
    800021b6:	64e2                	ld	s1,24(sp)
    800021b8:	bfd5                	j	800021ac <sys_sbrk+0x3e>

00000000800021ba <sys_sleep>:

uint64 sys_sleep(void) {
    800021ba:	7139                	addi	sp,sp,-64
    800021bc:	fc06                	sd	ra,56(sp)
    800021be:	f822                	sd	s0,48(sp)
    800021c0:	0080                	addi	s0,sp,64
    int n;
    uint ticks0;

    if (argint(0, &n) < 0)
    800021c2:	fcc40593          	addi	a1,s0,-52
    800021c6:	4501                	li	a0,0
    800021c8:	00000097          	auipc	ra,0x0
    800021cc:	df8080e7          	jalr	-520(ra) # 80001fc0 <argint>
        return -1;
    800021d0:	57fd                	li	a5,-1
    if (argint(0, &n) < 0)
    800021d2:	06054b63          	bltz	a0,80002248 <sys_sleep+0x8e>
    800021d6:	f04a                	sd	s2,32(sp)
    acquire(&tickslock);
    800021d8:	00010517          	auipc	a0,0x10
    800021dc:	ea850513          	addi	a0,a0,-344 # 80012080 <tickslock>
    800021e0:	00004097          	auipc	ra,0x4
    800021e4:	12c080e7          	jalr	300(ra) # 8000630c <acquire>
    ticks0 = ticks;
    800021e8:	0000a917          	auipc	s2,0xa
    800021ec:	e3092903          	lw	s2,-464(s2) # 8000c018 <ticks>
    while (ticks - ticks0 < n) {
    800021f0:	fcc42783          	lw	a5,-52(s0)
    800021f4:	c3a1                	beqz	a5,80002234 <sys_sleep+0x7a>
    800021f6:	f426                	sd	s1,40(sp)
    800021f8:	ec4e                	sd	s3,24(sp)
        if (myproc()->killed) {
            release(&tickslock);
            return -1;
        }
        sleep(&ticks, &tickslock);
    800021fa:	00010997          	auipc	s3,0x10
    800021fe:	e8698993          	addi	s3,s3,-378 # 80012080 <tickslock>
    80002202:	0000a497          	auipc	s1,0xa
    80002206:	e1648493          	addi	s1,s1,-490 # 8000c018 <ticks>
        if (myproc()->killed) {
    8000220a:	fffff097          	auipc	ra,0xfffff
    8000220e:	cbc080e7          	jalr	-836(ra) # 80000ec6 <myproc>
    80002212:	551c                	lw	a5,40(a0)
    80002214:	ef9d                	bnez	a5,80002252 <sys_sleep+0x98>
        sleep(&ticks, &tickslock);
    80002216:	85ce                	mv	a1,s3
    80002218:	8526                	mv	a0,s1
    8000221a:	fffff097          	auipc	ra,0xfffff
    8000221e:	37e080e7          	jalr	894(ra) # 80001598 <sleep>
    while (ticks - ticks0 < n) {
    80002222:	409c                	lw	a5,0(s1)
    80002224:	412787bb          	subw	a5,a5,s2
    80002228:	fcc42703          	lw	a4,-52(s0)
    8000222c:	fce7efe3          	bltu	a5,a4,8000220a <sys_sleep+0x50>
    80002230:	74a2                	ld	s1,40(sp)
    80002232:	69e2                	ld	s3,24(sp)
    }
    release(&tickslock);
    80002234:	00010517          	auipc	a0,0x10
    80002238:	e4c50513          	addi	a0,a0,-436 # 80012080 <tickslock>
    8000223c:	00004097          	auipc	ra,0x4
    80002240:	184080e7          	jalr	388(ra) # 800063c0 <release>
    return 0;
    80002244:	4781                	li	a5,0
    80002246:	7902                	ld	s2,32(sp)
}
    80002248:	853e                	mv	a0,a5
    8000224a:	70e2                	ld	ra,56(sp)
    8000224c:	7442                	ld	s0,48(sp)
    8000224e:	6121                	addi	sp,sp,64
    80002250:	8082                	ret
            release(&tickslock);
    80002252:	00010517          	auipc	a0,0x10
    80002256:	e2e50513          	addi	a0,a0,-466 # 80012080 <tickslock>
    8000225a:	00004097          	auipc	ra,0x4
    8000225e:	166080e7          	jalr	358(ra) # 800063c0 <release>
            return -1;
    80002262:	57fd                	li	a5,-1
    80002264:	74a2                	ld	s1,40(sp)
    80002266:	7902                	ld	s2,32(sp)
    80002268:	69e2                	ld	s3,24(sp)
    8000226a:	bff9                	j	80002248 <sys_sleep+0x8e>

000000008000226c <sys_kill>:

uint64 sys_kill(void) {
    8000226c:	1101                	addi	sp,sp,-32
    8000226e:	ec06                	sd	ra,24(sp)
    80002270:	e822                	sd	s0,16(sp)
    80002272:	1000                	addi	s0,sp,32
    int pid;

    if (argint(0, &pid) < 0)
    80002274:	fec40593          	addi	a1,s0,-20
    80002278:	4501                	li	a0,0
    8000227a:	00000097          	auipc	ra,0x0
    8000227e:	d46080e7          	jalr	-698(ra) # 80001fc0 <argint>
    80002282:	87aa                	mv	a5,a0
        return -1;
    80002284:	557d                	li	a0,-1
    if (argint(0, &pid) < 0)
    80002286:	0007c863          	bltz	a5,80002296 <sys_kill+0x2a>
    return kill(pid);
    8000228a:	fec42503          	lw	a0,-20(s0)
    8000228e:	fffff097          	auipc	ra,0xfffff
    80002292:	63c080e7          	jalr	1596(ra) # 800018ca <kill>
}
    80002296:	60e2                	ld	ra,24(sp)
    80002298:	6442                	ld	s0,16(sp)
    8000229a:	6105                	addi	sp,sp,32
    8000229c:	8082                	ret

000000008000229e <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64 sys_uptime(void) {
    8000229e:	1101                	addi	sp,sp,-32
    800022a0:	ec06                	sd	ra,24(sp)
    800022a2:	e822                	sd	s0,16(sp)
    800022a4:	e426                	sd	s1,8(sp)
    800022a6:	1000                	addi	s0,sp,32
    uint xticks;

    acquire(&tickslock);
    800022a8:	00010517          	auipc	a0,0x10
    800022ac:	dd850513          	addi	a0,a0,-552 # 80012080 <tickslock>
    800022b0:	00004097          	auipc	ra,0x4
    800022b4:	05c080e7          	jalr	92(ra) # 8000630c <acquire>
    xticks = ticks;
    800022b8:	0000a497          	auipc	s1,0xa
    800022bc:	d604a483          	lw	s1,-672(s1) # 8000c018 <ticks>
    release(&tickslock);
    800022c0:	00010517          	auipc	a0,0x10
    800022c4:	dc050513          	addi	a0,a0,-576 # 80012080 <tickslock>
    800022c8:	00004097          	auipc	ra,0x4
    800022cc:	0f8080e7          	jalr	248(ra) # 800063c0 <release>
    return xticks;
}
    800022d0:	02049513          	slli	a0,s1,0x20
    800022d4:	9101                	srli	a0,a0,0x20
    800022d6:	60e2                	ld	ra,24(sp)
    800022d8:	6442                	ld	s0,16(sp)
    800022da:	64a2                	ld	s1,8(sp)
    800022dc:	6105                	addi	sp,sp,32
    800022de:	8082                	ret

00000000800022e0 <sys_trace>:

// lab2 - trace system call: hint 3
// add a sys_trace() function in kernel/sysproc.c
uint64 sys_trace() {
    800022e0:	1101                	addi	sp,sp,-32
    800022e2:	ec06                	sd	ra,24(sp)
    800022e4:	e822                	sd	s0,16(sp)
    800022e6:	1000                	addi	s0,sp,32
  int n;
  if (argint(0, &n) < 0) {
    800022e8:	fec40593          	addi	a1,s0,-20
    800022ec:	4501                	li	a0,0
    800022ee:	00000097          	auipc	ra,0x0
    800022f2:	cd2080e7          	jalr	-814(ra) # 80001fc0 <argint>
    return -1;
    800022f6:	57fd                	li	a5,-1
  if (argint(0, &n) < 0) {
    800022f8:	00054b63          	bltz	a0,8000230e <sys_trace+0x2e>
  }

  struct proc *p = myproc();
    800022fc:	fffff097          	auipc	ra,0xfffff
    80002300:	bca080e7          	jalr	-1078(ra) # 80000ec6 <myproc>
  p->trace_mask = n;
    80002304:	fec42783          	lw	a5,-20(s0)
    80002308:	16f53423          	sd	a5,360(a0)

  return 0;
    8000230c:	4781                	li	a5,0
}
    8000230e:	853e                	mv	a0,a5
    80002310:	60e2                	ld	ra,24(sp)
    80002312:	6442                	ld	s0,16(sp)
    80002314:	6105                	addi	sp,sp,32
    80002316:	8082                	ret

0000000080002318 <binit>:
    // Sorted by how recently the buffer was used.
    // head.next is most recent, head.prev is least.
    struct buf head;
} bcache;

void binit(void) {
    80002318:	7179                	addi	sp,sp,-48
    8000231a:	f406                	sd	ra,40(sp)
    8000231c:	f022                	sd	s0,32(sp)
    8000231e:	ec26                	sd	s1,24(sp)
    80002320:	e84a                	sd	s2,16(sp)
    80002322:	e44e                	sd	s3,8(sp)
    80002324:	e052                	sd	s4,0(sp)
    80002326:	1800                	addi	s0,sp,48
    struct buf *b;

    initlock(&bcache.lock, "bcache");
    80002328:	00006597          	auipc	a1,0x6
    8000232c:	12058593          	addi	a1,a1,288 # 80008448 <etext+0x448>
    80002330:	00010517          	auipc	a0,0x10
    80002334:	d6850513          	addi	a0,a0,-664 # 80012098 <bcache>
    80002338:	00004097          	auipc	ra,0x4
    8000233c:	f44080e7          	jalr	-188(ra) # 8000627c <initlock>

    // Create linked list of buffers
    bcache.head.prev = &bcache.head;
    80002340:	00018797          	auipc	a5,0x18
    80002344:	d5878793          	addi	a5,a5,-680 # 8001a098 <bcache+0x8000>
    80002348:	00018717          	auipc	a4,0x18
    8000234c:	fb870713          	addi	a4,a4,-72 # 8001a300 <bcache+0x8268>
    80002350:	2ae7b823          	sd	a4,688(a5)
    bcache.head.next = &bcache.head;
    80002354:	2ae7bc23          	sd	a4,696(a5)
    for (b = bcache.buf; b < bcache.buf + NBUF; b++) {
    80002358:	00010497          	auipc	s1,0x10
    8000235c:	d5848493          	addi	s1,s1,-680 # 800120b0 <bcache+0x18>
        b->next = bcache.head.next;
    80002360:	893e                	mv	s2,a5
        b->prev = &bcache.head;
    80002362:	89ba                	mv	s3,a4
        initsleeplock(&b->lock, "buffer");
    80002364:	00006a17          	auipc	s4,0x6
    80002368:	0eca0a13          	addi	s4,s4,236 # 80008450 <etext+0x450>
        b->next = bcache.head.next;
    8000236c:	2b893783          	ld	a5,696(s2)
    80002370:	e8bc                	sd	a5,80(s1)
        b->prev = &bcache.head;
    80002372:	0534b423          	sd	s3,72(s1)
        initsleeplock(&b->lock, "buffer");
    80002376:	85d2                	mv	a1,s4
    80002378:	01048513          	addi	a0,s1,16
    8000237c:	00001097          	auipc	ra,0x1
    80002380:	4b2080e7          	jalr	1202(ra) # 8000382e <initsleeplock>
        bcache.head.next->prev = b;
    80002384:	2b893783          	ld	a5,696(s2)
    80002388:	e7a4                	sd	s1,72(a5)
        bcache.head.next = b;
    8000238a:	2a993c23          	sd	s1,696(s2)
    for (b = bcache.buf; b < bcache.buf + NBUF; b++) {
    8000238e:	45848493          	addi	s1,s1,1112
    80002392:	fd349de3          	bne	s1,s3,8000236c <binit+0x54>
    }
}
    80002396:	70a2                	ld	ra,40(sp)
    80002398:	7402                	ld	s0,32(sp)
    8000239a:	64e2                	ld	s1,24(sp)
    8000239c:	6942                	ld	s2,16(sp)
    8000239e:	69a2                	ld	s3,8(sp)
    800023a0:	6a02                	ld	s4,0(sp)
    800023a2:	6145                	addi	sp,sp,48
    800023a4:	8082                	ret

00000000800023a6 <bread>:
    }
    panic("bget: no buffers");
}

// Return a locked buf with the contents of the indicated block.
struct buf *bread(uint dev, uint blockno) {
    800023a6:	7179                	addi	sp,sp,-48
    800023a8:	f406                	sd	ra,40(sp)
    800023aa:	f022                	sd	s0,32(sp)
    800023ac:	ec26                	sd	s1,24(sp)
    800023ae:	e84a                	sd	s2,16(sp)
    800023b0:	e44e                	sd	s3,8(sp)
    800023b2:	1800                	addi	s0,sp,48
    800023b4:	892a                	mv	s2,a0
    800023b6:	89ae                	mv	s3,a1
    acquire(&bcache.lock);
    800023b8:	00010517          	auipc	a0,0x10
    800023bc:	ce050513          	addi	a0,a0,-800 # 80012098 <bcache>
    800023c0:	00004097          	auipc	ra,0x4
    800023c4:	f4c080e7          	jalr	-180(ra) # 8000630c <acquire>
    for (b = bcache.head.next; b != &bcache.head; b = b->next) {
    800023c8:	00018497          	auipc	s1,0x18
    800023cc:	f884b483          	ld	s1,-120(s1) # 8001a350 <bcache+0x82b8>
    800023d0:	00018797          	auipc	a5,0x18
    800023d4:	f3078793          	addi	a5,a5,-208 # 8001a300 <bcache+0x8268>
    800023d8:	02f48f63          	beq	s1,a5,80002416 <bread+0x70>
    800023dc:	873e                	mv	a4,a5
    800023de:	a021                	j	800023e6 <bread+0x40>
    800023e0:	68a4                	ld	s1,80(s1)
    800023e2:	02e48a63          	beq	s1,a4,80002416 <bread+0x70>
        if (b->dev == dev && b->blockno == blockno) {
    800023e6:	449c                	lw	a5,8(s1)
    800023e8:	ff279ce3          	bne	a5,s2,800023e0 <bread+0x3a>
    800023ec:	44dc                	lw	a5,12(s1)
    800023ee:	ff3799e3          	bne	a5,s3,800023e0 <bread+0x3a>
            b->refcnt++;
    800023f2:	40bc                	lw	a5,64(s1)
    800023f4:	2785                	addiw	a5,a5,1
    800023f6:	c0bc                	sw	a5,64(s1)
            release(&bcache.lock);
    800023f8:	00010517          	auipc	a0,0x10
    800023fc:	ca050513          	addi	a0,a0,-864 # 80012098 <bcache>
    80002400:	00004097          	auipc	ra,0x4
    80002404:	fc0080e7          	jalr	-64(ra) # 800063c0 <release>
            acquiresleep(&b->lock);
    80002408:	01048513          	addi	a0,s1,16
    8000240c:	00001097          	auipc	ra,0x1
    80002410:	45c080e7          	jalr	1116(ra) # 80003868 <acquiresleep>
            return b;
    80002414:	a8b9                	j	80002472 <bread+0xcc>
    for (b = bcache.head.prev; b != &bcache.head; b = b->prev) {
    80002416:	00018497          	auipc	s1,0x18
    8000241a:	f324b483          	ld	s1,-206(s1) # 8001a348 <bcache+0x82b0>
    8000241e:	00018797          	auipc	a5,0x18
    80002422:	ee278793          	addi	a5,a5,-286 # 8001a300 <bcache+0x8268>
    80002426:	00f48863          	beq	s1,a5,80002436 <bread+0x90>
    8000242a:	873e                	mv	a4,a5
        if (b->refcnt == 0) {
    8000242c:	40bc                	lw	a5,64(s1)
    8000242e:	cf81                	beqz	a5,80002446 <bread+0xa0>
    for (b = bcache.head.prev; b != &bcache.head; b = b->prev) {
    80002430:	64a4                	ld	s1,72(s1)
    80002432:	fee49de3          	bne	s1,a4,8000242c <bread+0x86>
    panic("bget: no buffers");
    80002436:	00006517          	auipc	a0,0x6
    8000243a:	02250513          	addi	a0,a0,34 # 80008458 <etext+0x458>
    8000243e:	00004097          	auipc	ra,0x4
    80002442:	954080e7          	jalr	-1708(ra) # 80005d92 <panic>
            b->dev = dev;
    80002446:	0124a423          	sw	s2,8(s1)
            b->blockno = blockno;
    8000244a:	0134a623          	sw	s3,12(s1)
            b->valid = 0;
    8000244e:	0004a023          	sw	zero,0(s1)
            b->refcnt = 1;
    80002452:	4785                	li	a5,1
    80002454:	c0bc                	sw	a5,64(s1)
            release(&bcache.lock);
    80002456:	00010517          	auipc	a0,0x10
    8000245a:	c4250513          	addi	a0,a0,-958 # 80012098 <bcache>
    8000245e:	00004097          	auipc	ra,0x4
    80002462:	f62080e7          	jalr	-158(ra) # 800063c0 <release>
            acquiresleep(&b->lock);
    80002466:	01048513          	addi	a0,s1,16
    8000246a:	00001097          	auipc	ra,0x1
    8000246e:	3fe080e7          	jalr	1022(ra) # 80003868 <acquiresleep>
    struct buf *b;

    b = bget(dev, blockno);
    if (!b->valid) {
    80002472:	409c                	lw	a5,0(s1)
    80002474:	cb89                	beqz	a5,80002486 <bread+0xe0>
        virtio_disk_rw(b, 0);
        b->valid = 1;
    }
    return b;
}
    80002476:	8526                	mv	a0,s1
    80002478:	70a2                	ld	ra,40(sp)
    8000247a:	7402                	ld	s0,32(sp)
    8000247c:	64e2                	ld	s1,24(sp)
    8000247e:	6942                	ld	s2,16(sp)
    80002480:	69a2                	ld	s3,8(sp)
    80002482:	6145                	addi	sp,sp,48
    80002484:	8082                	ret
        virtio_disk_rw(b, 0);
    80002486:	4581                	li	a1,0
    80002488:	8526                	mv	a0,s1
    8000248a:	00003097          	auipc	ra,0x3
    8000248e:	fe8080e7          	jalr	-24(ra) # 80005472 <virtio_disk_rw>
        b->valid = 1;
    80002492:	4785                	li	a5,1
    80002494:	c09c                	sw	a5,0(s1)
    return b;
    80002496:	b7c5                	j	80002476 <bread+0xd0>

0000000080002498 <bwrite>:

// Write b's contents to disk.  Must be locked.
void bwrite(struct buf *b) {
    80002498:	1101                	addi	sp,sp,-32
    8000249a:	ec06                	sd	ra,24(sp)
    8000249c:	e822                	sd	s0,16(sp)
    8000249e:	e426                	sd	s1,8(sp)
    800024a0:	1000                	addi	s0,sp,32
    800024a2:	84aa                	mv	s1,a0
    if (!holdingsleep(&b->lock))
    800024a4:	0541                	addi	a0,a0,16
    800024a6:	00001097          	auipc	ra,0x1
    800024aa:	45c080e7          	jalr	1116(ra) # 80003902 <holdingsleep>
    800024ae:	cd01                	beqz	a0,800024c6 <bwrite+0x2e>
        panic("bwrite");
    virtio_disk_rw(b, 1);
    800024b0:	4585                	li	a1,1
    800024b2:	8526                	mv	a0,s1
    800024b4:	00003097          	auipc	ra,0x3
    800024b8:	fbe080e7          	jalr	-66(ra) # 80005472 <virtio_disk_rw>
}
    800024bc:	60e2                	ld	ra,24(sp)
    800024be:	6442                	ld	s0,16(sp)
    800024c0:	64a2                	ld	s1,8(sp)
    800024c2:	6105                	addi	sp,sp,32
    800024c4:	8082                	ret
        panic("bwrite");
    800024c6:	00006517          	auipc	a0,0x6
    800024ca:	faa50513          	addi	a0,a0,-86 # 80008470 <etext+0x470>
    800024ce:	00004097          	auipc	ra,0x4
    800024d2:	8c4080e7          	jalr	-1852(ra) # 80005d92 <panic>

00000000800024d6 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void brelse(struct buf *b) {
    800024d6:	1101                	addi	sp,sp,-32
    800024d8:	ec06                	sd	ra,24(sp)
    800024da:	e822                	sd	s0,16(sp)
    800024dc:	e426                	sd	s1,8(sp)
    800024de:	e04a                	sd	s2,0(sp)
    800024e0:	1000                	addi	s0,sp,32
    800024e2:	84aa                	mv	s1,a0
    if (!holdingsleep(&b->lock))
    800024e4:	01050913          	addi	s2,a0,16
    800024e8:	854a                	mv	a0,s2
    800024ea:	00001097          	auipc	ra,0x1
    800024ee:	418080e7          	jalr	1048(ra) # 80003902 <holdingsleep>
    800024f2:	c925                	beqz	a0,80002562 <brelse+0x8c>
        panic("brelse");

    releasesleep(&b->lock);
    800024f4:	854a                	mv	a0,s2
    800024f6:	00001097          	auipc	ra,0x1
    800024fa:	3c8080e7          	jalr	968(ra) # 800038be <releasesleep>

    acquire(&bcache.lock);
    800024fe:	00010517          	auipc	a0,0x10
    80002502:	b9a50513          	addi	a0,a0,-1126 # 80012098 <bcache>
    80002506:	00004097          	auipc	ra,0x4
    8000250a:	e06080e7          	jalr	-506(ra) # 8000630c <acquire>
    b->refcnt--;
    8000250e:	40bc                	lw	a5,64(s1)
    80002510:	37fd                	addiw	a5,a5,-1
    80002512:	0007871b          	sext.w	a4,a5
    80002516:	c0bc                	sw	a5,64(s1)
    if (b->refcnt == 0) {
    80002518:	e71d                	bnez	a4,80002546 <brelse+0x70>
        // no one is waiting for it.
        b->next->prev = b->prev;
    8000251a:	68b8                	ld	a4,80(s1)
    8000251c:	64bc                	ld	a5,72(s1)
    8000251e:	e73c                	sd	a5,72(a4)
        b->prev->next = b->next;
    80002520:	68b8                	ld	a4,80(s1)
    80002522:	ebb8                	sd	a4,80(a5)
        b->next = bcache.head.next;
    80002524:	00018797          	auipc	a5,0x18
    80002528:	b7478793          	addi	a5,a5,-1164 # 8001a098 <bcache+0x8000>
    8000252c:	2b87b703          	ld	a4,696(a5)
    80002530:	e8b8                	sd	a4,80(s1)
        b->prev = &bcache.head;
    80002532:	00018717          	auipc	a4,0x18
    80002536:	dce70713          	addi	a4,a4,-562 # 8001a300 <bcache+0x8268>
    8000253a:	e4b8                	sd	a4,72(s1)
        bcache.head.next->prev = b;
    8000253c:	2b87b703          	ld	a4,696(a5)
    80002540:	e724                	sd	s1,72(a4)
        bcache.head.next = b;
    80002542:	2a97bc23          	sd	s1,696(a5)
    }

    release(&bcache.lock);
    80002546:	00010517          	auipc	a0,0x10
    8000254a:	b5250513          	addi	a0,a0,-1198 # 80012098 <bcache>
    8000254e:	00004097          	auipc	ra,0x4
    80002552:	e72080e7          	jalr	-398(ra) # 800063c0 <release>
}
    80002556:	60e2                	ld	ra,24(sp)
    80002558:	6442                	ld	s0,16(sp)
    8000255a:	64a2                	ld	s1,8(sp)
    8000255c:	6902                	ld	s2,0(sp)
    8000255e:	6105                	addi	sp,sp,32
    80002560:	8082                	ret
        panic("brelse");
    80002562:	00006517          	auipc	a0,0x6
    80002566:	f1650513          	addi	a0,a0,-234 # 80008478 <etext+0x478>
    8000256a:	00004097          	auipc	ra,0x4
    8000256e:	828080e7          	jalr	-2008(ra) # 80005d92 <panic>

0000000080002572 <bpin>:

void bpin(struct buf *b) {
    80002572:	1101                	addi	sp,sp,-32
    80002574:	ec06                	sd	ra,24(sp)
    80002576:	e822                	sd	s0,16(sp)
    80002578:	e426                	sd	s1,8(sp)
    8000257a:	1000                	addi	s0,sp,32
    8000257c:	84aa                	mv	s1,a0
    acquire(&bcache.lock);
    8000257e:	00010517          	auipc	a0,0x10
    80002582:	b1a50513          	addi	a0,a0,-1254 # 80012098 <bcache>
    80002586:	00004097          	auipc	ra,0x4
    8000258a:	d86080e7          	jalr	-634(ra) # 8000630c <acquire>
    b->refcnt++;
    8000258e:	40bc                	lw	a5,64(s1)
    80002590:	2785                	addiw	a5,a5,1
    80002592:	c0bc                	sw	a5,64(s1)
    release(&bcache.lock);
    80002594:	00010517          	auipc	a0,0x10
    80002598:	b0450513          	addi	a0,a0,-1276 # 80012098 <bcache>
    8000259c:	00004097          	auipc	ra,0x4
    800025a0:	e24080e7          	jalr	-476(ra) # 800063c0 <release>
}
    800025a4:	60e2                	ld	ra,24(sp)
    800025a6:	6442                	ld	s0,16(sp)
    800025a8:	64a2                	ld	s1,8(sp)
    800025aa:	6105                	addi	sp,sp,32
    800025ac:	8082                	ret

00000000800025ae <bunpin>:

void bunpin(struct buf *b) {
    800025ae:	1101                	addi	sp,sp,-32
    800025b0:	ec06                	sd	ra,24(sp)
    800025b2:	e822                	sd	s0,16(sp)
    800025b4:	e426                	sd	s1,8(sp)
    800025b6:	1000                	addi	s0,sp,32
    800025b8:	84aa                	mv	s1,a0
    acquire(&bcache.lock);
    800025ba:	00010517          	auipc	a0,0x10
    800025be:	ade50513          	addi	a0,a0,-1314 # 80012098 <bcache>
    800025c2:	00004097          	auipc	ra,0x4
    800025c6:	d4a080e7          	jalr	-694(ra) # 8000630c <acquire>
    b->refcnt--;
    800025ca:	40bc                	lw	a5,64(s1)
    800025cc:	37fd                	addiw	a5,a5,-1
    800025ce:	c0bc                	sw	a5,64(s1)
    release(&bcache.lock);
    800025d0:	00010517          	auipc	a0,0x10
    800025d4:	ac850513          	addi	a0,a0,-1336 # 80012098 <bcache>
    800025d8:	00004097          	auipc	ra,0x4
    800025dc:	de8080e7          	jalr	-536(ra) # 800063c0 <release>
}
    800025e0:	60e2                	ld	ra,24(sp)
    800025e2:	6442                	ld	s0,16(sp)
    800025e4:	64a2                	ld	s1,8(sp)
    800025e6:	6105                	addi	sp,sp,32
    800025e8:	8082                	ret

00000000800025ea <bfree>:
    }
    panic("balloc: out of blocks");
}

// Free a disk block.
static void bfree(int dev, uint b) {
    800025ea:	1101                	addi	sp,sp,-32
    800025ec:	ec06                	sd	ra,24(sp)
    800025ee:	e822                	sd	s0,16(sp)
    800025f0:	e426                	sd	s1,8(sp)
    800025f2:	e04a                	sd	s2,0(sp)
    800025f4:	1000                	addi	s0,sp,32
    800025f6:	84ae                	mv	s1,a1
    struct buf *bp;
    int bi, m;

    bp = bread(dev, BBLOCK(b, sb));
    800025f8:	00d5d59b          	srliw	a1,a1,0xd
    800025fc:	00018797          	auipc	a5,0x18
    80002600:	1787a783          	lw	a5,376(a5) # 8001a774 <sb+0x1c>
    80002604:	9dbd                	addw	a1,a1,a5
    80002606:	00000097          	auipc	ra,0x0
    8000260a:	da0080e7          	jalr	-608(ra) # 800023a6 <bread>
    bi = b % BPB;
    m = 1 << (bi % 8);
    8000260e:	0074f713          	andi	a4,s1,7
    80002612:	4785                	li	a5,1
    80002614:	00e797bb          	sllw	a5,a5,a4
    if ((bp->data[bi / 8] & m) == 0)
    80002618:	14ce                	slli	s1,s1,0x33
    8000261a:	90d9                	srli	s1,s1,0x36
    8000261c:	00950733          	add	a4,a0,s1
    80002620:	05874703          	lbu	a4,88(a4)
    80002624:	00e7f6b3          	and	a3,a5,a4
    80002628:	c69d                	beqz	a3,80002656 <bfree+0x6c>
    8000262a:	892a                	mv	s2,a0
        panic("freeing free block");
    bp->data[bi / 8] &= ~m;
    8000262c:	94aa                	add	s1,s1,a0
    8000262e:	fff7c793          	not	a5,a5
    80002632:	8f7d                	and	a4,a4,a5
    80002634:	04e48c23          	sb	a4,88(s1)
    log_write(bp);
    80002638:	00001097          	auipc	ra,0x1
    8000263c:	112080e7          	jalr	274(ra) # 8000374a <log_write>
    brelse(bp);
    80002640:	854a                	mv	a0,s2
    80002642:	00000097          	auipc	ra,0x0
    80002646:	e94080e7          	jalr	-364(ra) # 800024d6 <brelse>
}
    8000264a:	60e2                	ld	ra,24(sp)
    8000264c:	6442                	ld	s0,16(sp)
    8000264e:	64a2                	ld	s1,8(sp)
    80002650:	6902                	ld	s2,0(sp)
    80002652:	6105                	addi	sp,sp,32
    80002654:	8082                	ret
        panic("freeing free block");
    80002656:	00006517          	auipc	a0,0x6
    8000265a:	e2a50513          	addi	a0,a0,-470 # 80008480 <etext+0x480>
    8000265e:	00003097          	auipc	ra,0x3
    80002662:	734080e7          	jalr	1844(ra) # 80005d92 <panic>

0000000080002666 <balloc>:
static uint balloc(uint dev) {
    80002666:	711d                	addi	sp,sp,-96
    80002668:	ec86                	sd	ra,88(sp)
    8000266a:	e8a2                	sd	s0,80(sp)
    8000266c:	e4a6                	sd	s1,72(sp)
    8000266e:	e0ca                	sd	s2,64(sp)
    80002670:	fc4e                	sd	s3,56(sp)
    80002672:	f852                	sd	s4,48(sp)
    80002674:	f456                	sd	s5,40(sp)
    80002676:	f05a                	sd	s6,32(sp)
    80002678:	ec5e                	sd	s7,24(sp)
    8000267a:	e862                	sd	s8,16(sp)
    8000267c:	e466                	sd	s9,8(sp)
    8000267e:	1080                	addi	s0,sp,96
    for (b = 0; b < sb.size; b += BPB) {
    80002680:	00018797          	auipc	a5,0x18
    80002684:	0dc7a783          	lw	a5,220(a5) # 8001a75c <sb+0x4>
    80002688:	cbc1                	beqz	a5,80002718 <balloc+0xb2>
    8000268a:	8baa                	mv	s7,a0
    8000268c:	4a81                	li	s5,0
        bp = bread(dev, BBLOCK(b, sb));
    8000268e:	00018b17          	auipc	s6,0x18
    80002692:	0cab0b13          	addi	s6,s6,202 # 8001a758 <sb>
        for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
    80002696:	4c01                	li	s8,0
            m = 1 << (bi % 8);
    80002698:	4985                	li	s3,1
        for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
    8000269a:	6a09                	lui	s4,0x2
    for (b = 0; b < sb.size; b += BPB) {
    8000269c:	6c89                	lui	s9,0x2
    8000269e:	a831                	j	800026ba <balloc+0x54>
        brelse(bp);
    800026a0:	854a                	mv	a0,s2
    800026a2:	00000097          	auipc	ra,0x0
    800026a6:	e34080e7          	jalr	-460(ra) # 800024d6 <brelse>
    for (b = 0; b < sb.size; b += BPB) {
    800026aa:	015c87bb          	addw	a5,s9,s5
    800026ae:	00078a9b          	sext.w	s5,a5
    800026b2:	004b2703          	lw	a4,4(s6)
    800026b6:	06eaf163          	bgeu	s5,a4,80002718 <balloc+0xb2>
        bp = bread(dev, BBLOCK(b, sb));
    800026ba:	41fad79b          	sraiw	a5,s5,0x1f
    800026be:	0137d79b          	srliw	a5,a5,0x13
    800026c2:	015787bb          	addw	a5,a5,s5
    800026c6:	40d7d79b          	sraiw	a5,a5,0xd
    800026ca:	01cb2583          	lw	a1,28(s6)
    800026ce:	9dbd                	addw	a1,a1,a5
    800026d0:	855e                	mv	a0,s7
    800026d2:	00000097          	auipc	ra,0x0
    800026d6:	cd4080e7          	jalr	-812(ra) # 800023a6 <bread>
    800026da:	892a                	mv	s2,a0
        for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
    800026dc:	004b2503          	lw	a0,4(s6)
    800026e0:	000a849b          	sext.w	s1,s5
    800026e4:	8762                	mv	a4,s8
    800026e6:	faa4fde3          	bgeu	s1,a0,800026a0 <balloc+0x3a>
            m = 1 << (bi % 8);
    800026ea:	00777693          	andi	a3,a4,7
    800026ee:	00d996bb          	sllw	a3,s3,a3
            if ((bp->data[bi / 8] & m) == 0) { // Is block free?
    800026f2:	41f7579b          	sraiw	a5,a4,0x1f
    800026f6:	01d7d79b          	srliw	a5,a5,0x1d
    800026fa:	9fb9                	addw	a5,a5,a4
    800026fc:	4037d79b          	sraiw	a5,a5,0x3
    80002700:	00f90633          	add	a2,s2,a5
    80002704:	05864603          	lbu	a2,88(a2)
    80002708:	00c6f5b3          	and	a1,a3,a2
    8000270c:	cd91                	beqz	a1,80002728 <balloc+0xc2>
        for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
    8000270e:	2705                	addiw	a4,a4,1
    80002710:	2485                	addiw	s1,s1,1
    80002712:	fd471ae3          	bne	a4,s4,800026e6 <balloc+0x80>
    80002716:	b769                	j	800026a0 <balloc+0x3a>
    panic("balloc: out of blocks");
    80002718:	00006517          	auipc	a0,0x6
    8000271c:	d8050513          	addi	a0,a0,-640 # 80008498 <etext+0x498>
    80002720:	00003097          	auipc	ra,0x3
    80002724:	672080e7          	jalr	1650(ra) # 80005d92 <panic>
                bp->data[bi / 8] |= m;         // Mark block in use.
    80002728:	97ca                	add	a5,a5,s2
    8000272a:	8e55                	or	a2,a2,a3
    8000272c:	04c78c23          	sb	a2,88(a5)
                log_write(bp);
    80002730:	854a                	mv	a0,s2
    80002732:	00001097          	auipc	ra,0x1
    80002736:	018080e7          	jalr	24(ra) # 8000374a <log_write>
                brelse(bp);
    8000273a:	854a                	mv	a0,s2
    8000273c:	00000097          	auipc	ra,0x0
    80002740:	d9a080e7          	jalr	-614(ra) # 800024d6 <brelse>
    bp = bread(dev, bno);
    80002744:	85a6                	mv	a1,s1
    80002746:	855e                	mv	a0,s7
    80002748:	00000097          	auipc	ra,0x0
    8000274c:	c5e080e7          	jalr	-930(ra) # 800023a6 <bread>
    80002750:	892a                	mv	s2,a0
    memset(bp->data, 0, BSIZE);
    80002752:	40000613          	li	a2,1024
    80002756:	4581                	li	a1,0
    80002758:	05850513          	addi	a0,a0,88
    8000275c:	ffffe097          	auipc	ra,0xffffe
    80002760:	a68080e7          	jalr	-1432(ra) # 800001c4 <memset>
    log_write(bp);
    80002764:	854a                	mv	a0,s2
    80002766:	00001097          	auipc	ra,0x1
    8000276a:	fe4080e7          	jalr	-28(ra) # 8000374a <log_write>
    brelse(bp);
    8000276e:	854a                	mv	a0,s2
    80002770:	00000097          	auipc	ra,0x0
    80002774:	d66080e7          	jalr	-666(ra) # 800024d6 <brelse>
}
    80002778:	8526                	mv	a0,s1
    8000277a:	60e6                	ld	ra,88(sp)
    8000277c:	6446                	ld	s0,80(sp)
    8000277e:	64a6                	ld	s1,72(sp)
    80002780:	6906                	ld	s2,64(sp)
    80002782:	79e2                	ld	s3,56(sp)
    80002784:	7a42                	ld	s4,48(sp)
    80002786:	7aa2                	ld	s5,40(sp)
    80002788:	7b02                	ld	s6,32(sp)
    8000278a:	6be2                	ld	s7,24(sp)
    8000278c:	6c42                	ld	s8,16(sp)
    8000278e:	6ca2                	ld	s9,8(sp)
    80002790:	6125                	addi	sp,sp,96
    80002792:	8082                	ret

0000000080002794 <bmap>:
// are listed in ip->addrs[].  The next NINDIRECT blocks are
// listed in block ip->addrs[NDIRECT].

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint bmap(struct inode *ip, uint bn) {
    80002794:	7179                	addi	sp,sp,-48
    80002796:	f406                	sd	ra,40(sp)
    80002798:	f022                	sd	s0,32(sp)
    8000279a:	ec26                	sd	s1,24(sp)
    8000279c:	e84a                	sd	s2,16(sp)
    8000279e:	e44e                	sd	s3,8(sp)
    800027a0:	1800                	addi	s0,sp,48
    800027a2:	892a                	mv	s2,a0
    uint addr, *a;
    struct buf *bp;

    if (bn < NDIRECT) {
    800027a4:	47ad                	li	a5,11
    800027a6:	04b7ff63          	bgeu	a5,a1,80002804 <bmap+0x70>
    800027aa:	e052                	sd	s4,0(sp)
        if ((addr = ip->addrs[bn]) == 0)
            ip->addrs[bn] = addr = balloc(ip->dev);
        return addr;
    }
    bn -= NDIRECT;
    800027ac:	ff45849b          	addiw	s1,a1,-12
    800027b0:	0004871b          	sext.w	a4,s1

    if (bn < NINDIRECT) {
    800027b4:	0ff00793          	li	a5,255
    800027b8:	0ae7e463          	bltu	a5,a4,80002860 <bmap+0xcc>
        // Load indirect block, allocating if necessary.
        if ((addr = ip->addrs[NDIRECT]) == 0)
    800027bc:	08052583          	lw	a1,128(a0)
    800027c0:	c5b5                	beqz	a1,8000282c <bmap+0x98>
            ip->addrs[NDIRECT] = addr = balloc(ip->dev);
        bp = bread(ip->dev, addr);
    800027c2:	00092503          	lw	a0,0(s2)
    800027c6:	00000097          	auipc	ra,0x0
    800027ca:	be0080e7          	jalr	-1056(ra) # 800023a6 <bread>
    800027ce:	8a2a                	mv	s4,a0
        a = (uint *)bp->data;
    800027d0:	05850793          	addi	a5,a0,88
        if ((addr = a[bn]) == 0) {
    800027d4:	02049713          	slli	a4,s1,0x20
    800027d8:	01e75593          	srli	a1,a4,0x1e
    800027dc:	00b784b3          	add	s1,a5,a1
    800027e0:	0004a983          	lw	s3,0(s1)
    800027e4:	04098e63          	beqz	s3,80002840 <bmap+0xac>
            a[bn] = addr = balloc(ip->dev);
            log_write(bp);
        }
        brelse(bp);
    800027e8:	8552                	mv	a0,s4
    800027ea:	00000097          	auipc	ra,0x0
    800027ee:	cec080e7          	jalr	-788(ra) # 800024d6 <brelse>
        return addr;
    800027f2:	6a02                	ld	s4,0(sp)
    }

    panic("bmap: out of range");
}
    800027f4:	854e                	mv	a0,s3
    800027f6:	70a2                	ld	ra,40(sp)
    800027f8:	7402                	ld	s0,32(sp)
    800027fa:	64e2                	ld	s1,24(sp)
    800027fc:	6942                	ld	s2,16(sp)
    800027fe:	69a2                	ld	s3,8(sp)
    80002800:	6145                	addi	sp,sp,48
    80002802:	8082                	ret
        if ((addr = ip->addrs[bn]) == 0)
    80002804:	02059793          	slli	a5,a1,0x20
    80002808:	01e7d593          	srli	a1,a5,0x1e
    8000280c:	00b504b3          	add	s1,a0,a1
    80002810:	0504a983          	lw	s3,80(s1)
    80002814:	fe0990e3          	bnez	s3,800027f4 <bmap+0x60>
            ip->addrs[bn] = addr = balloc(ip->dev);
    80002818:	4108                	lw	a0,0(a0)
    8000281a:	00000097          	auipc	ra,0x0
    8000281e:	e4c080e7          	jalr	-436(ra) # 80002666 <balloc>
    80002822:	0005099b          	sext.w	s3,a0
    80002826:	0534a823          	sw	s3,80(s1)
    8000282a:	b7e9                	j	800027f4 <bmap+0x60>
            ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    8000282c:	4108                	lw	a0,0(a0)
    8000282e:	00000097          	auipc	ra,0x0
    80002832:	e38080e7          	jalr	-456(ra) # 80002666 <balloc>
    80002836:	0005059b          	sext.w	a1,a0
    8000283a:	08b92023          	sw	a1,128(s2)
    8000283e:	b751                	j	800027c2 <bmap+0x2e>
            a[bn] = addr = balloc(ip->dev);
    80002840:	00092503          	lw	a0,0(s2)
    80002844:	00000097          	auipc	ra,0x0
    80002848:	e22080e7          	jalr	-478(ra) # 80002666 <balloc>
    8000284c:	0005099b          	sext.w	s3,a0
    80002850:	0134a023          	sw	s3,0(s1)
            log_write(bp);
    80002854:	8552                	mv	a0,s4
    80002856:	00001097          	auipc	ra,0x1
    8000285a:	ef4080e7          	jalr	-268(ra) # 8000374a <log_write>
    8000285e:	b769                	j	800027e8 <bmap+0x54>
    panic("bmap: out of range");
    80002860:	00006517          	auipc	a0,0x6
    80002864:	c5050513          	addi	a0,a0,-944 # 800084b0 <etext+0x4b0>
    80002868:	00003097          	auipc	ra,0x3
    8000286c:	52a080e7          	jalr	1322(ra) # 80005d92 <panic>

0000000080002870 <iget>:
static struct inode *iget(uint dev, uint inum) {
    80002870:	7179                	addi	sp,sp,-48
    80002872:	f406                	sd	ra,40(sp)
    80002874:	f022                	sd	s0,32(sp)
    80002876:	ec26                	sd	s1,24(sp)
    80002878:	e84a                	sd	s2,16(sp)
    8000287a:	e44e                	sd	s3,8(sp)
    8000287c:	e052                	sd	s4,0(sp)
    8000287e:	1800                	addi	s0,sp,48
    80002880:	89aa                	mv	s3,a0
    80002882:	8a2e                	mv	s4,a1
    acquire(&itable.lock);
    80002884:	00018517          	auipc	a0,0x18
    80002888:	ef450513          	addi	a0,a0,-268 # 8001a778 <itable>
    8000288c:	00004097          	auipc	ra,0x4
    80002890:	a80080e7          	jalr	-1408(ra) # 8000630c <acquire>
    empty = 0;
    80002894:	4901                	li	s2,0
    for (ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++) {
    80002896:	00018497          	auipc	s1,0x18
    8000289a:	efa48493          	addi	s1,s1,-262 # 8001a790 <itable+0x18>
    8000289e:	0001a697          	auipc	a3,0x1a
    800028a2:	98268693          	addi	a3,a3,-1662 # 8001c220 <log>
    800028a6:	a039                	j	800028b4 <iget+0x44>
        if (empty == 0 && ip->ref == 0) // Remember empty slot.
    800028a8:	02090b63          	beqz	s2,800028de <iget+0x6e>
    for (ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++) {
    800028ac:	08848493          	addi	s1,s1,136
    800028b0:	02d48a63          	beq	s1,a3,800028e4 <iget+0x74>
        if (ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
    800028b4:	449c                	lw	a5,8(s1)
    800028b6:	fef059e3          	blez	a5,800028a8 <iget+0x38>
    800028ba:	4098                	lw	a4,0(s1)
    800028bc:	ff3716e3          	bne	a4,s3,800028a8 <iget+0x38>
    800028c0:	40d8                	lw	a4,4(s1)
    800028c2:	ff4713e3          	bne	a4,s4,800028a8 <iget+0x38>
            ip->ref++;
    800028c6:	2785                	addiw	a5,a5,1
    800028c8:	c49c                	sw	a5,8(s1)
            release(&itable.lock);
    800028ca:	00018517          	auipc	a0,0x18
    800028ce:	eae50513          	addi	a0,a0,-338 # 8001a778 <itable>
    800028d2:	00004097          	auipc	ra,0x4
    800028d6:	aee080e7          	jalr	-1298(ra) # 800063c0 <release>
            return ip;
    800028da:	8926                	mv	s2,s1
    800028dc:	a03d                	j	8000290a <iget+0x9a>
        if (empty == 0 && ip->ref == 0) // Remember empty slot.
    800028de:	f7f9                	bnez	a5,800028ac <iget+0x3c>
            empty = ip;
    800028e0:	8926                	mv	s2,s1
    800028e2:	b7e9                	j	800028ac <iget+0x3c>
    if (empty == 0)
    800028e4:	02090c63          	beqz	s2,8000291c <iget+0xac>
    ip->dev = dev;
    800028e8:	01392023          	sw	s3,0(s2)
    ip->inum = inum;
    800028ec:	01492223          	sw	s4,4(s2)
    ip->ref = 1;
    800028f0:	4785                	li	a5,1
    800028f2:	00f92423          	sw	a5,8(s2)
    ip->valid = 0;
    800028f6:	04092023          	sw	zero,64(s2)
    release(&itable.lock);
    800028fa:	00018517          	auipc	a0,0x18
    800028fe:	e7e50513          	addi	a0,a0,-386 # 8001a778 <itable>
    80002902:	00004097          	auipc	ra,0x4
    80002906:	abe080e7          	jalr	-1346(ra) # 800063c0 <release>
}
    8000290a:	854a                	mv	a0,s2
    8000290c:	70a2                	ld	ra,40(sp)
    8000290e:	7402                	ld	s0,32(sp)
    80002910:	64e2                	ld	s1,24(sp)
    80002912:	6942                	ld	s2,16(sp)
    80002914:	69a2                	ld	s3,8(sp)
    80002916:	6a02                	ld	s4,0(sp)
    80002918:	6145                	addi	sp,sp,48
    8000291a:	8082                	ret
        panic("iget: no inodes");
    8000291c:	00006517          	auipc	a0,0x6
    80002920:	bac50513          	addi	a0,a0,-1108 # 800084c8 <etext+0x4c8>
    80002924:	00003097          	auipc	ra,0x3
    80002928:	46e080e7          	jalr	1134(ra) # 80005d92 <panic>

000000008000292c <fsinit>:
void fsinit(int dev) {
    8000292c:	7179                	addi	sp,sp,-48
    8000292e:	f406                	sd	ra,40(sp)
    80002930:	f022                	sd	s0,32(sp)
    80002932:	ec26                	sd	s1,24(sp)
    80002934:	e84a                	sd	s2,16(sp)
    80002936:	e44e                	sd	s3,8(sp)
    80002938:	1800                	addi	s0,sp,48
    8000293a:	892a                	mv	s2,a0
    bp = bread(dev, 1);
    8000293c:	4585                	li	a1,1
    8000293e:	00000097          	auipc	ra,0x0
    80002942:	a68080e7          	jalr	-1432(ra) # 800023a6 <bread>
    80002946:	84aa                	mv	s1,a0
    memmove(sb, bp->data, sizeof(*sb));
    80002948:	00018997          	auipc	s3,0x18
    8000294c:	e1098993          	addi	s3,s3,-496 # 8001a758 <sb>
    80002950:	02000613          	li	a2,32
    80002954:	05850593          	addi	a1,a0,88
    80002958:	854e                	mv	a0,s3
    8000295a:	ffffe097          	auipc	ra,0xffffe
    8000295e:	8c6080e7          	jalr	-1850(ra) # 80000220 <memmove>
    brelse(bp);
    80002962:	8526                	mv	a0,s1
    80002964:	00000097          	auipc	ra,0x0
    80002968:	b72080e7          	jalr	-1166(ra) # 800024d6 <brelse>
    if (sb.magic != FSMAGIC)
    8000296c:	0009a703          	lw	a4,0(s3)
    80002970:	102037b7          	lui	a5,0x10203
    80002974:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002978:	02f71263          	bne	a4,a5,8000299c <fsinit+0x70>
    initlog(dev, &sb);
    8000297c:	00018597          	auipc	a1,0x18
    80002980:	ddc58593          	addi	a1,a1,-548 # 8001a758 <sb>
    80002984:	854a                	mv	a0,s2
    80002986:	00001097          	auipc	ra,0x1
    8000298a:	b54080e7          	jalr	-1196(ra) # 800034da <initlog>
}
    8000298e:	70a2                	ld	ra,40(sp)
    80002990:	7402                	ld	s0,32(sp)
    80002992:	64e2                	ld	s1,24(sp)
    80002994:	6942                	ld	s2,16(sp)
    80002996:	69a2                	ld	s3,8(sp)
    80002998:	6145                	addi	sp,sp,48
    8000299a:	8082                	ret
        panic("invalid file system");
    8000299c:	00006517          	auipc	a0,0x6
    800029a0:	b3c50513          	addi	a0,a0,-1220 # 800084d8 <etext+0x4d8>
    800029a4:	00003097          	auipc	ra,0x3
    800029a8:	3ee080e7          	jalr	1006(ra) # 80005d92 <panic>

00000000800029ac <iinit>:
void iinit() {
    800029ac:	7179                	addi	sp,sp,-48
    800029ae:	f406                	sd	ra,40(sp)
    800029b0:	f022                	sd	s0,32(sp)
    800029b2:	ec26                	sd	s1,24(sp)
    800029b4:	e84a                	sd	s2,16(sp)
    800029b6:	e44e                	sd	s3,8(sp)
    800029b8:	1800                	addi	s0,sp,48
    initlock(&itable.lock, "itable");
    800029ba:	00006597          	auipc	a1,0x6
    800029be:	b3658593          	addi	a1,a1,-1226 # 800084f0 <etext+0x4f0>
    800029c2:	00018517          	auipc	a0,0x18
    800029c6:	db650513          	addi	a0,a0,-586 # 8001a778 <itable>
    800029ca:	00004097          	auipc	ra,0x4
    800029ce:	8b2080e7          	jalr	-1870(ra) # 8000627c <initlock>
    for (i = 0; i < NINODE; i++) {
    800029d2:	00018497          	auipc	s1,0x18
    800029d6:	dce48493          	addi	s1,s1,-562 # 8001a7a0 <itable+0x28>
    800029da:	0001a997          	auipc	s3,0x1a
    800029de:	85698993          	addi	s3,s3,-1962 # 8001c230 <log+0x10>
        initsleeplock(&itable.inode[i].lock, "inode");
    800029e2:	00006917          	auipc	s2,0x6
    800029e6:	b1690913          	addi	s2,s2,-1258 # 800084f8 <etext+0x4f8>
    800029ea:	85ca                	mv	a1,s2
    800029ec:	8526                	mv	a0,s1
    800029ee:	00001097          	auipc	ra,0x1
    800029f2:	e40080e7          	jalr	-448(ra) # 8000382e <initsleeplock>
    for (i = 0; i < NINODE; i++) {
    800029f6:	08848493          	addi	s1,s1,136
    800029fa:	ff3498e3          	bne	s1,s3,800029ea <iinit+0x3e>
}
    800029fe:	70a2                	ld	ra,40(sp)
    80002a00:	7402                	ld	s0,32(sp)
    80002a02:	64e2                	ld	s1,24(sp)
    80002a04:	6942                	ld	s2,16(sp)
    80002a06:	69a2                	ld	s3,8(sp)
    80002a08:	6145                	addi	sp,sp,48
    80002a0a:	8082                	ret

0000000080002a0c <ialloc>:
struct inode *ialloc(uint dev, short type) {
    80002a0c:	7139                	addi	sp,sp,-64
    80002a0e:	fc06                	sd	ra,56(sp)
    80002a10:	f822                	sd	s0,48(sp)
    80002a12:	f426                	sd	s1,40(sp)
    80002a14:	f04a                	sd	s2,32(sp)
    80002a16:	ec4e                	sd	s3,24(sp)
    80002a18:	e852                	sd	s4,16(sp)
    80002a1a:	e456                	sd	s5,8(sp)
    80002a1c:	e05a                	sd	s6,0(sp)
    80002a1e:	0080                	addi	s0,sp,64
    for (inum = 1; inum < sb.ninodes; inum++) {
    80002a20:	00018717          	auipc	a4,0x18
    80002a24:	d4472703          	lw	a4,-700(a4) # 8001a764 <sb+0xc>
    80002a28:	4785                	li	a5,1
    80002a2a:	04e7f863          	bgeu	a5,a4,80002a7a <ialloc+0x6e>
    80002a2e:	8aaa                	mv	s5,a0
    80002a30:	8b2e                	mv	s6,a1
    80002a32:	4905                	li	s2,1
        bp = bread(dev, IBLOCK(inum, sb));
    80002a34:	00018a17          	auipc	s4,0x18
    80002a38:	d24a0a13          	addi	s4,s4,-732 # 8001a758 <sb>
    80002a3c:	00495593          	srli	a1,s2,0x4
    80002a40:	018a2783          	lw	a5,24(s4)
    80002a44:	9dbd                	addw	a1,a1,a5
    80002a46:	8556                	mv	a0,s5
    80002a48:	00000097          	auipc	ra,0x0
    80002a4c:	95e080e7          	jalr	-1698(ra) # 800023a6 <bread>
    80002a50:	84aa                	mv	s1,a0
        dip = (struct dinode *)bp->data + inum % IPB;
    80002a52:	05850993          	addi	s3,a0,88
    80002a56:	00f97793          	andi	a5,s2,15
    80002a5a:	079a                	slli	a5,a5,0x6
    80002a5c:	99be                	add	s3,s3,a5
        if (dip->type == 0) { // a free inode
    80002a5e:	00099783          	lh	a5,0(s3)
    80002a62:	c785                	beqz	a5,80002a8a <ialloc+0x7e>
        brelse(bp);
    80002a64:	00000097          	auipc	ra,0x0
    80002a68:	a72080e7          	jalr	-1422(ra) # 800024d6 <brelse>
    for (inum = 1; inum < sb.ninodes; inum++) {
    80002a6c:	0905                	addi	s2,s2,1
    80002a6e:	00ca2703          	lw	a4,12(s4)
    80002a72:	0009079b          	sext.w	a5,s2
    80002a76:	fce7e3e3          	bltu	a5,a4,80002a3c <ialloc+0x30>
    panic("ialloc: no inodes");
    80002a7a:	00006517          	auipc	a0,0x6
    80002a7e:	a8650513          	addi	a0,a0,-1402 # 80008500 <etext+0x500>
    80002a82:	00003097          	auipc	ra,0x3
    80002a86:	310080e7          	jalr	784(ra) # 80005d92 <panic>
            memset(dip, 0, sizeof(*dip));
    80002a8a:	04000613          	li	a2,64
    80002a8e:	4581                	li	a1,0
    80002a90:	854e                	mv	a0,s3
    80002a92:	ffffd097          	auipc	ra,0xffffd
    80002a96:	732080e7          	jalr	1842(ra) # 800001c4 <memset>
            dip->type = type;
    80002a9a:	01699023          	sh	s6,0(s3)
            log_write(bp); // mark it allocated on the disk
    80002a9e:	8526                	mv	a0,s1
    80002aa0:	00001097          	auipc	ra,0x1
    80002aa4:	caa080e7          	jalr	-854(ra) # 8000374a <log_write>
            brelse(bp);
    80002aa8:	8526                	mv	a0,s1
    80002aaa:	00000097          	auipc	ra,0x0
    80002aae:	a2c080e7          	jalr	-1492(ra) # 800024d6 <brelse>
            return iget(dev, inum);
    80002ab2:	0009059b          	sext.w	a1,s2
    80002ab6:	8556                	mv	a0,s5
    80002ab8:	00000097          	auipc	ra,0x0
    80002abc:	db8080e7          	jalr	-584(ra) # 80002870 <iget>
}
    80002ac0:	70e2                	ld	ra,56(sp)
    80002ac2:	7442                	ld	s0,48(sp)
    80002ac4:	74a2                	ld	s1,40(sp)
    80002ac6:	7902                	ld	s2,32(sp)
    80002ac8:	69e2                	ld	s3,24(sp)
    80002aca:	6a42                	ld	s4,16(sp)
    80002acc:	6aa2                	ld	s5,8(sp)
    80002ace:	6b02                	ld	s6,0(sp)
    80002ad0:	6121                	addi	sp,sp,64
    80002ad2:	8082                	ret

0000000080002ad4 <iupdate>:
void iupdate(struct inode *ip) {
    80002ad4:	1101                	addi	sp,sp,-32
    80002ad6:	ec06                	sd	ra,24(sp)
    80002ad8:	e822                	sd	s0,16(sp)
    80002ada:	e426                	sd	s1,8(sp)
    80002adc:	e04a                	sd	s2,0(sp)
    80002ade:	1000                	addi	s0,sp,32
    80002ae0:	84aa                	mv	s1,a0
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002ae2:	415c                	lw	a5,4(a0)
    80002ae4:	0047d79b          	srliw	a5,a5,0x4
    80002ae8:	00018597          	auipc	a1,0x18
    80002aec:	c885a583          	lw	a1,-888(a1) # 8001a770 <sb+0x18>
    80002af0:	9dbd                	addw	a1,a1,a5
    80002af2:	4108                	lw	a0,0(a0)
    80002af4:	00000097          	auipc	ra,0x0
    80002af8:	8b2080e7          	jalr	-1870(ra) # 800023a6 <bread>
    80002afc:	892a                	mv	s2,a0
    dip = (struct dinode *)bp->data + ip->inum % IPB;
    80002afe:	05850793          	addi	a5,a0,88
    80002b02:	40d8                	lw	a4,4(s1)
    80002b04:	8b3d                	andi	a4,a4,15
    80002b06:	071a                	slli	a4,a4,0x6
    80002b08:	97ba                	add	a5,a5,a4
    dip->type = ip->type;
    80002b0a:	04449703          	lh	a4,68(s1)
    80002b0e:	00e79023          	sh	a4,0(a5)
    dip->major = ip->major;
    80002b12:	04649703          	lh	a4,70(s1)
    80002b16:	00e79123          	sh	a4,2(a5)
    dip->minor = ip->minor;
    80002b1a:	04849703          	lh	a4,72(s1)
    80002b1e:	00e79223          	sh	a4,4(a5)
    dip->nlink = ip->nlink;
    80002b22:	04a49703          	lh	a4,74(s1)
    80002b26:	00e79323          	sh	a4,6(a5)
    dip->size = ip->size;
    80002b2a:	44f8                	lw	a4,76(s1)
    80002b2c:	c798                	sw	a4,8(a5)
    memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002b2e:	03400613          	li	a2,52
    80002b32:	05048593          	addi	a1,s1,80
    80002b36:	00c78513          	addi	a0,a5,12
    80002b3a:	ffffd097          	auipc	ra,0xffffd
    80002b3e:	6e6080e7          	jalr	1766(ra) # 80000220 <memmove>
    log_write(bp);
    80002b42:	854a                	mv	a0,s2
    80002b44:	00001097          	auipc	ra,0x1
    80002b48:	c06080e7          	jalr	-1018(ra) # 8000374a <log_write>
    brelse(bp);
    80002b4c:	854a                	mv	a0,s2
    80002b4e:	00000097          	auipc	ra,0x0
    80002b52:	988080e7          	jalr	-1656(ra) # 800024d6 <brelse>
}
    80002b56:	60e2                	ld	ra,24(sp)
    80002b58:	6442                	ld	s0,16(sp)
    80002b5a:	64a2                	ld	s1,8(sp)
    80002b5c:	6902                	ld	s2,0(sp)
    80002b5e:	6105                	addi	sp,sp,32
    80002b60:	8082                	ret

0000000080002b62 <idup>:
struct inode *idup(struct inode *ip) {
    80002b62:	1101                	addi	sp,sp,-32
    80002b64:	ec06                	sd	ra,24(sp)
    80002b66:	e822                	sd	s0,16(sp)
    80002b68:	e426                	sd	s1,8(sp)
    80002b6a:	1000                	addi	s0,sp,32
    80002b6c:	84aa                	mv	s1,a0
    acquire(&itable.lock);
    80002b6e:	00018517          	auipc	a0,0x18
    80002b72:	c0a50513          	addi	a0,a0,-1014 # 8001a778 <itable>
    80002b76:	00003097          	auipc	ra,0x3
    80002b7a:	796080e7          	jalr	1942(ra) # 8000630c <acquire>
    ip->ref++;
    80002b7e:	449c                	lw	a5,8(s1)
    80002b80:	2785                	addiw	a5,a5,1
    80002b82:	c49c                	sw	a5,8(s1)
    release(&itable.lock);
    80002b84:	00018517          	auipc	a0,0x18
    80002b88:	bf450513          	addi	a0,a0,-1036 # 8001a778 <itable>
    80002b8c:	00004097          	auipc	ra,0x4
    80002b90:	834080e7          	jalr	-1996(ra) # 800063c0 <release>
}
    80002b94:	8526                	mv	a0,s1
    80002b96:	60e2                	ld	ra,24(sp)
    80002b98:	6442                	ld	s0,16(sp)
    80002b9a:	64a2                	ld	s1,8(sp)
    80002b9c:	6105                	addi	sp,sp,32
    80002b9e:	8082                	ret

0000000080002ba0 <ilock>:
void ilock(struct inode *ip) {
    80002ba0:	1101                	addi	sp,sp,-32
    80002ba2:	ec06                	sd	ra,24(sp)
    80002ba4:	e822                	sd	s0,16(sp)
    80002ba6:	e426                	sd	s1,8(sp)
    80002ba8:	1000                	addi	s0,sp,32
    if (ip == 0 || ip->ref < 1)
    80002baa:	c10d                	beqz	a0,80002bcc <ilock+0x2c>
    80002bac:	84aa                	mv	s1,a0
    80002bae:	451c                	lw	a5,8(a0)
    80002bb0:	00f05e63          	blez	a5,80002bcc <ilock+0x2c>
    acquiresleep(&ip->lock);
    80002bb4:	0541                	addi	a0,a0,16
    80002bb6:	00001097          	auipc	ra,0x1
    80002bba:	cb2080e7          	jalr	-846(ra) # 80003868 <acquiresleep>
    if (ip->valid == 0) {
    80002bbe:	40bc                	lw	a5,64(s1)
    80002bc0:	cf99                	beqz	a5,80002bde <ilock+0x3e>
}
    80002bc2:	60e2                	ld	ra,24(sp)
    80002bc4:	6442                	ld	s0,16(sp)
    80002bc6:	64a2                	ld	s1,8(sp)
    80002bc8:	6105                	addi	sp,sp,32
    80002bca:	8082                	ret
    80002bcc:	e04a                	sd	s2,0(sp)
        panic("ilock");
    80002bce:	00006517          	auipc	a0,0x6
    80002bd2:	94a50513          	addi	a0,a0,-1718 # 80008518 <etext+0x518>
    80002bd6:	00003097          	auipc	ra,0x3
    80002bda:	1bc080e7          	jalr	444(ra) # 80005d92 <panic>
    80002bde:	e04a                	sd	s2,0(sp)
        bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002be0:	40dc                	lw	a5,4(s1)
    80002be2:	0047d79b          	srliw	a5,a5,0x4
    80002be6:	00018597          	auipc	a1,0x18
    80002bea:	b8a5a583          	lw	a1,-1142(a1) # 8001a770 <sb+0x18>
    80002bee:	9dbd                	addw	a1,a1,a5
    80002bf0:	4088                	lw	a0,0(s1)
    80002bf2:	fffff097          	auipc	ra,0xfffff
    80002bf6:	7b4080e7          	jalr	1972(ra) # 800023a6 <bread>
    80002bfa:	892a                	mv	s2,a0
        dip = (struct dinode *)bp->data + ip->inum % IPB;
    80002bfc:	05850593          	addi	a1,a0,88
    80002c00:	40dc                	lw	a5,4(s1)
    80002c02:	8bbd                	andi	a5,a5,15
    80002c04:	079a                	slli	a5,a5,0x6
    80002c06:	95be                	add	a1,a1,a5
        ip->type = dip->type;
    80002c08:	00059783          	lh	a5,0(a1)
    80002c0c:	04f49223          	sh	a5,68(s1)
        ip->major = dip->major;
    80002c10:	00259783          	lh	a5,2(a1)
    80002c14:	04f49323          	sh	a5,70(s1)
        ip->minor = dip->minor;
    80002c18:	00459783          	lh	a5,4(a1)
    80002c1c:	04f49423          	sh	a5,72(s1)
        ip->nlink = dip->nlink;
    80002c20:	00659783          	lh	a5,6(a1)
    80002c24:	04f49523          	sh	a5,74(s1)
        ip->size = dip->size;
    80002c28:	459c                	lw	a5,8(a1)
    80002c2a:	c4fc                	sw	a5,76(s1)
        memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002c2c:	03400613          	li	a2,52
    80002c30:	05b1                	addi	a1,a1,12
    80002c32:	05048513          	addi	a0,s1,80
    80002c36:	ffffd097          	auipc	ra,0xffffd
    80002c3a:	5ea080e7          	jalr	1514(ra) # 80000220 <memmove>
        brelse(bp);
    80002c3e:	854a                	mv	a0,s2
    80002c40:	00000097          	auipc	ra,0x0
    80002c44:	896080e7          	jalr	-1898(ra) # 800024d6 <brelse>
        ip->valid = 1;
    80002c48:	4785                	li	a5,1
    80002c4a:	c0bc                	sw	a5,64(s1)
        if (ip->type == 0)
    80002c4c:	04449783          	lh	a5,68(s1)
    80002c50:	c399                	beqz	a5,80002c56 <ilock+0xb6>
    80002c52:	6902                	ld	s2,0(sp)
    80002c54:	b7bd                	j	80002bc2 <ilock+0x22>
            panic("ilock: no type");
    80002c56:	00006517          	auipc	a0,0x6
    80002c5a:	8ca50513          	addi	a0,a0,-1846 # 80008520 <etext+0x520>
    80002c5e:	00003097          	auipc	ra,0x3
    80002c62:	134080e7          	jalr	308(ra) # 80005d92 <panic>

0000000080002c66 <iunlock>:
void iunlock(struct inode *ip) {
    80002c66:	1101                	addi	sp,sp,-32
    80002c68:	ec06                	sd	ra,24(sp)
    80002c6a:	e822                	sd	s0,16(sp)
    80002c6c:	e426                	sd	s1,8(sp)
    80002c6e:	e04a                	sd	s2,0(sp)
    80002c70:	1000                	addi	s0,sp,32
    if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80002c72:	c905                	beqz	a0,80002ca2 <iunlock+0x3c>
    80002c74:	84aa                	mv	s1,a0
    80002c76:	01050913          	addi	s2,a0,16
    80002c7a:	854a                	mv	a0,s2
    80002c7c:	00001097          	auipc	ra,0x1
    80002c80:	c86080e7          	jalr	-890(ra) # 80003902 <holdingsleep>
    80002c84:	cd19                	beqz	a0,80002ca2 <iunlock+0x3c>
    80002c86:	449c                	lw	a5,8(s1)
    80002c88:	00f05d63          	blez	a5,80002ca2 <iunlock+0x3c>
    releasesleep(&ip->lock);
    80002c8c:	854a                	mv	a0,s2
    80002c8e:	00001097          	auipc	ra,0x1
    80002c92:	c30080e7          	jalr	-976(ra) # 800038be <releasesleep>
}
    80002c96:	60e2                	ld	ra,24(sp)
    80002c98:	6442                	ld	s0,16(sp)
    80002c9a:	64a2                	ld	s1,8(sp)
    80002c9c:	6902                	ld	s2,0(sp)
    80002c9e:	6105                	addi	sp,sp,32
    80002ca0:	8082                	ret
        panic("iunlock");
    80002ca2:	00006517          	auipc	a0,0x6
    80002ca6:	88e50513          	addi	a0,a0,-1906 # 80008530 <etext+0x530>
    80002caa:	00003097          	auipc	ra,0x3
    80002cae:	0e8080e7          	jalr	232(ra) # 80005d92 <panic>

0000000080002cb2 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void itrunc(struct inode *ip) {
    80002cb2:	7179                	addi	sp,sp,-48
    80002cb4:	f406                	sd	ra,40(sp)
    80002cb6:	f022                	sd	s0,32(sp)
    80002cb8:	ec26                	sd	s1,24(sp)
    80002cba:	e84a                	sd	s2,16(sp)
    80002cbc:	e44e                	sd	s3,8(sp)
    80002cbe:	1800                	addi	s0,sp,48
    80002cc0:	89aa                	mv	s3,a0
    int i, j;
    struct buf *bp;
    uint *a;

    for (i = 0; i < NDIRECT; i++) {
    80002cc2:	05050493          	addi	s1,a0,80
    80002cc6:	08050913          	addi	s2,a0,128
    80002cca:	a021                	j	80002cd2 <itrunc+0x20>
    80002ccc:	0491                	addi	s1,s1,4
    80002cce:	01248d63          	beq	s1,s2,80002ce8 <itrunc+0x36>
        if (ip->addrs[i]) {
    80002cd2:	408c                	lw	a1,0(s1)
    80002cd4:	dde5                	beqz	a1,80002ccc <itrunc+0x1a>
            bfree(ip->dev, ip->addrs[i]);
    80002cd6:	0009a503          	lw	a0,0(s3)
    80002cda:	00000097          	auipc	ra,0x0
    80002cde:	910080e7          	jalr	-1776(ra) # 800025ea <bfree>
            ip->addrs[i] = 0;
    80002ce2:	0004a023          	sw	zero,0(s1)
    80002ce6:	b7dd                	j	80002ccc <itrunc+0x1a>
        }
    }

    if (ip->addrs[NDIRECT]) {
    80002ce8:	0809a583          	lw	a1,128(s3)
    80002cec:	ed99                	bnez	a1,80002d0a <itrunc+0x58>
        brelse(bp);
        bfree(ip->dev, ip->addrs[NDIRECT]);
        ip->addrs[NDIRECT] = 0;
    }

    ip->size = 0;
    80002cee:	0409a623          	sw	zero,76(s3)
    iupdate(ip);
    80002cf2:	854e                	mv	a0,s3
    80002cf4:	00000097          	auipc	ra,0x0
    80002cf8:	de0080e7          	jalr	-544(ra) # 80002ad4 <iupdate>
}
    80002cfc:	70a2                	ld	ra,40(sp)
    80002cfe:	7402                	ld	s0,32(sp)
    80002d00:	64e2                	ld	s1,24(sp)
    80002d02:	6942                	ld	s2,16(sp)
    80002d04:	69a2                	ld	s3,8(sp)
    80002d06:	6145                	addi	sp,sp,48
    80002d08:	8082                	ret
    80002d0a:	e052                	sd	s4,0(sp)
        bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002d0c:	0009a503          	lw	a0,0(s3)
    80002d10:	fffff097          	auipc	ra,0xfffff
    80002d14:	696080e7          	jalr	1686(ra) # 800023a6 <bread>
    80002d18:	8a2a                	mv	s4,a0
        for (j = 0; j < NINDIRECT; j++) {
    80002d1a:	05850493          	addi	s1,a0,88
    80002d1e:	45850913          	addi	s2,a0,1112
    80002d22:	a021                	j	80002d2a <itrunc+0x78>
    80002d24:	0491                	addi	s1,s1,4
    80002d26:	01248b63          	beq	s1,s2,80002d3c <itrunc+0x8a>
            if (a[j])
    80002d2a:	408c                	lw	a1,0(s1)
    80002d2c:	dde5                	beqz	a1,80002d24 <itrunc+0x72>
                bfree(ip->dev, a[j]);
    80002d2e:	0009a503          	lw	a0,0(s3)
    80002d32:	00000097          	auipc	ra,0x0
    80002d36:	8b8080e7          	jalr	-1864(ra) # 800025ea <bfree>
    80002d3a:	b7ed                	j	80002d24 <itrunc+0x72>
        brelse(bp);
    80002d3c:	8552                	mv	a0,s4
    80002d3e:	fffff097          	auipc	ra,0xfffff
    80002d42:	798080e7          	jalr	1944(ra) # 800024d6 <brelse>
        bfree(ip->dev, ip->addrs[NDIRECT]);
    80002d46:	0809a583          	lw	a1,128(s3)
    80002d4a:	0009a503          	lw	a0,0(s3)
    80002d4e:	00000097          	auipc	ra,0x0
    80002d52:	89c080e7          	jalr	-1892(ra) # 800025ea <bfree>
        ip->addrs[NDIRECT] = 0;
    80002d56:	0809a023          	sw	zero,128(s3)
    80002d5a:	6a02                	ld	s4,0(sp)
    80002d5c:	bf49                	j	80002cee <itrunc+0x3c>

0000000080002d5e <iput>:
void iput(struct inode *ip) {
    80002d5e:	1101                	addi	sp,sp,-32
    80002d60:	ec06                	sd	ra,24(sp)
    80002d62:	e822                	sd	s0,16(sp)
    80002d64:	e426                	sd	s1,8(sp)
    80002d66:	1000                	addi	s0,sp,32
    80002d68:	84aa                	mv	s1,a0
    acquire(&itable.lock);
    80002d6a:	00018517          	auipc	a0,0x18
    80002d6e:	a0e50513          	addi	a0,a0,-1522 # 8001a778 <itable>
    80002d72:	00003097          	auipc	ra,0x3
    80002d76:	59a080e7          	jalr	1434(ra) # 8000630c <acquire>
    if (ip->ref == 1 && ip->valid && ip->nlink == 0) {
    80002d7a:	4498                	lw	a4,8(s1)
    80002d7c:	4785                	li	a5,1
    80002d7e:	02f70263          	beq	a4,a5,80002da2 <iput+0x44>
    ip->ref--;
    80002d82:	449c                	lw	a5,8(s1)
    80002d84:	37fd                	addiw	a5,a5,-1
    80002d86:	c49c                	sw	a5,8(s1)
    release(&itable.lock);
    80002d88:	00018517          	auipc	a0,0x18
    80002d8c:	9f050513          	addi	a0,a0,-1552 # 8001a778 <itable>
    80002d90:	00003097          	auipc	ra,0x3
    80002d94:	630080e7          	jalr	1584(ra) # 800063c0 <release>
}
    80002d98:	60e2                	ld	ra,24(sp)
    80002d9a:	6442                	ld	s0,16(sp)
    80002d9c:	64a2                	ld	s1,8(sp)
    80002d9e:	6105                	addi	sp,sp,32
    80002da0:	8082                	ret
    if (ip->ref == 1 && ip->valid && ip->nlink == 0) {
    80002da2:	40bc                	lw	a5,64(s1)
    80002da4:	dff9                	beqz	a5,80002d82 <iput+0x24>
    80002da6:	04a49783          	lh	a5,74(s1)
    80002daa:	ffe1                	bnez	a5,80002d82 <iput+0x24>
    80002dac:	e04a                	sd	s2,0(sp)
        acquiresleep(&ip->lock);
    80002dae:	01048913          	addi	s2,s1,16
    80002db2:	854a                	mv	a0,s2
    80002db4:	00001097          	auipc	ra,0x1
    80002db8:	ab4080e7          	jalr	-1356(ra) # 80003868 <acquiresleep>
        release(&itable.lock);
    80002dbc:	00018517          	auipc	a0,0x18
    80002dc0:	9bc50513          	addi	a0,a0,-1604 # 8001a778 <itable>
    80002dc4:	00003097          	auipc	ra,0x3
    80002dc8:	5fc080e7          	jalr	1532(ra) # 800063c0 <release>
        itrunc(ip);
    80002dcc:	8526                	mv	a0,s1
    80002dce:	00000097          	auipc	ra,0x0
    80002dd2:	ee4080e7          	jalr	-284(ra) # 80002cb2 <itrunc>
        ip->type = 0;
    80002dd6:	04049223          	sh	zero,68(s1)
        iupdate(ip);
    80002dda:	8526                	mv	a0,s1
    80002ddc:	00000097          	auipc	ra,0x0
    80002de0:	cf8080e7          	jalr	-776(ra) # 80002ad4 <iupdate>
        ip->valid = 0;
    80002de4:	0404a023          	sw	zero,64(s1)
        releasesleep(&ip->lock);
    80002de8:	854a                	mv	a0,s2
    80002dea:	00001097          	auipc	ra,0x1
    80002dee:	ad4080e7          	jalr	-1324(ra) # 800038be <releasesleep>
        acquire(&itable.lock);
    80002df2:	00018517          	auipc	a0,0x18
    80002df6:	98650513          	addi	a0,a0,-1658 # 8001a778 <itable>
    80002dfa:	00003097          	auipc	ra,0x3
    80002dfe:	512080e7          	jalr	1298(ra) # 8000630c <acquire>
    80002e02:	6902                	ld	s2,0(sp)
    80002e04:	bfbd                	j	80002d82 <iput+0x24>

0000000080002e06 <iunlockput>:
void iunlockput(struct inode *ip) {
    80002e06:	1101                	addi	sp,sp,-32
    80002e08:	ec06                	sd	ra,24(sp)
    80002e0a:	e822                	sd	s0,16(sp)
    80002e0c:	e426                	sd	s1,8(sp)
    80002e0e:	1000                	addi	s0,sp,32
    80002e10:	84aa                	mv	s1,a0
    iunlock(ip);
    80002e12:	00000097          	auipc	ra,0x0
    80002e16:	e54080e7          	jalr	-428(ra) # 80002c66 <iunlock>
    iput(ip);
    80002e1a:	8526                	mv	a0,s1
    80002e1c:	00000097          	auipc	ra,0x0
    80002e20:	f42080e7          	jalr	-190(ra) # 80002d5e <iput>
}
    80002e24:	60e2                	ld	ra,24(sp)
    80002e26:	6442                	ld	s0,16(sp)
    80002e28:	64a2                	ld	s1,8(sp)
    80002e2a:	6105                	addi	sp,sp,32
    80002e2c:	8082                	ret

0000000080002e2e <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void stati(struct inode *ip, struct stat *st) {
    80002e2e:	1141                	addi	sp,sp,-16
    80002e30:	e422                	sd	s0,8(sp)
    80002e32:	0800                	addi	s0,sp,16
    st->dev = ip->dev;
    80002e34:	411c                	lw	a5,0(a0)
    80002e36:	c19c                	sw	a5,0(a1)
    st->ino = ip->inum;
    80002e38:	415c                	lw	a5,4(a0)
    80002e3a:	c1dc                	sw	a5,4(a1)
    st->type = ip->type;
    80002e3c:	04451783          	lh	a5,68(a0)
    80002e40:	00f59423          	sh	a5,8(a1)
    st->nlink = ip->nlink;
    80002e44:	04a51783          	lh	a5,74(a0)
    80002e48:	00f59523          	sh	a5,10(a1)
    st->size = ip->size;
    80002e4c:	04c56783          	lwu	a5,76(a0)
    80002e50:	e99c                	sd	a5,16(a1)
}
    80002e52:	6422                	ld	s0,8(sp)
    80002e54:	0141                	addi	sp,sp,16
    80002e56:	8082                	ret

0000000080002e58 <readi>:
// otherwise, dst is a kernel address.
int readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n) {
    uint tot, m;
    struct buf *bp;

    if (off > ip->size || off + n < off)
    80002e58:	457c                	lw	a5,76(a0)
    80002e5a:	0ed7ef63          	bltu	a5,a3,80002f58 <readi+0x100>
int readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n) {
    80002e5e:	7159                	addi	sp,sp,-112
    80002e60:	f486                	sd	ra,104(sp)
    80002e62:	f0a2                	sd	s0,96(sp)
    80002e64:	eca6                	sd	s1,88(sp)
    80002e66:	fc56                	sd	s5,56(sp)
    80002e68:	f85a                	sd	s6,48(sp)
    80002e6a:	f45e                	sd	s7,40(sp)
    80002e6c:	f062                	sd	s8,32(sp)
    80002e6e:	1880                	addi	s0,sp,112
    80002e70:	8baa                	mv	s7,a0
    80002e72:	8c2e                	mv	s8,a1
    80002e74:	8ab2                	mv	s5,a2
    80002e76:	84b6                	mv	s1,a3
    80002e78:	8b3a                	mv	s6,a4
    if (off > ip->size || off + n < off)
    80002e7a:	9f35                	addw	a4,a4,a3
        return 0;
    80002e7c:	4501                	li	a0,0
    if (off > ip->size || off + n < off)
    80002e7e:	0ad76c63          	bltu	a4,a3,80002f36 <readi+0xde>
    80002e82:	e4ce                	sd	s3,72(sp)
    if (off + n > ip->size)
    80002e84:	00e7f463          	bgeu	a5,a4,80002e8c <readi+0x34>
        n = ip->size - off;
    80002e88:	40d78b3b          	subw	s6,a5,a3

    for (tot = 0; tot < n; tot += m, off += m, dst += m) {
    80002e8c:	0c0b0463          	beqz	s6,80002f54 <readi+0xfc>
    80002e90:	e8ca                	sd	s2,80(sp)
    80002e92:	e0d2                	sd	s4,64(sp)
    80002e94:	ec66                	sd	s9,24(sp)
    80002e96:	e86a                	sd	s10,16(sp)
    80002e98:	e46e                	sd	s11,8(sp)
    80002e9a:	4981                	li	s3,0
        bp = bread(ip->dev, bmap(ip, off / BSIZE));
        m = min(n - tot, BSIZE - off % BSIZE);
    80002e9c:	40000d13          	li	s10,1024
        if (either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80002ea0:	5cfd                	li	s9,-1
    80002ea2:	a82d                	j	80002edc <readi+0x84>
    80002ea4:	020a1d93          	slli	s11,s4,0x20
    80002ea8:	020ddd93          	srli	s11,s11,0x20
    80002eac:	05890613          	addi	a2,s2,88
    80002eb0:	86ee                	mv	a3,s11
    80002eb2:	963a                	add	a2,a2,a4
    80002eb4:	85d6                	mv	a1,s5
    80002eb6:	8562                	mv	a0,s8
    80002eb8:	fffff097          	auipc	ra,0xfffff
    80002ebc:	a84080e7          	jalr	-1404(ra) # 8000193c <either_copyout>
    80002ec0:	05950d63          	beq	a0,s9,80002f1a <readi+0xc2>
            brelse(bp);
            tot = -1;
            break;
        }
        brelse(bp);
    80002ec4:	854a                	mv	a0,s2
    80002ec6:	fffff097          	auipc	ra,0xfffff
    80002eca:	610080e7          	jalr	1552(ra) # 800024d6 <brelse>
    for (tot = 0; tot < n; tot += m, off += m, dst += m) {
    80002ece:	013a09bb          	addw	s3,s4,s3
    80002ed2:	009a04bb          	addw	s1,s4,s1
    80002ed6:	9aee                	add	s5,s5,s11
    80002ed8:	0769f863          	bgeu	s3,s6,80002f48 <readi+0xf0>
        bp = bread(ip->dev, bmap(ip, off / BSIZE));
    80002edc:	000ba903          	lw	s2,0(s7)
    80002ee0:	00a4d59b          	srliw	a1,s1,0xa
    80002ee4:	855e                	mv	a0,s7
    80002ee6:	00000097          	auipc	ra,0x0
    80002eea:	8ae080e7          	jalr	-1874(ra) # 80002794 <bmap>
    80002eee:	0005059b          	sext.w	a1,a0
    80002ef2:	854a                	mv	a0,s2
    80002ef4:	fffff097          	auipc	ra,0xfffff
    80002ef8:	4b2080e7          	jalr	1202(ra) # 800023a6 <bread>
    80002efc:	892a                	mv	s2,a0
        m = min(n - tot, BSIZE - off % BSIZE);
    80002efe:	3ff4f713          	andi	a4,s1,1023
    80002f02:	40ed07bb          	subw	a5,s10,a4
    80002f06:	413b06bb          	subw	a3,s6,s3
    80002f0a:	8a3e                	mv	s4,a5
    80002f0c:	2781                	sext.w	a5,a5
    80002f0e:	0006861b          	sext.w	a2,a3
    80002f12:	f8f679e3          	bgeu	a2,a5,80002ea4 <readi+0x4c>
    80002f16:	8a36                	mv	s4,a3
    80002f18:	b771                	j	80002ea4 <readi+0x4c>
            brelse(bp);
    80002f1a:	854a                	mv	a0,s2
    80002f1c:	fffff097          	auipc	ra,0xfffff
    80002f20:	5ba080e7          	jalr	1466(ra) # 800024d6 <brelse>
            tot = -1;
    80002f24:	59fd                	li	s3,-1
            break;
    80002f26:	6946                	ld	s2,80(sp)
    80002f28:	6a06                	ld	s4,64(sp)
    80002f2a:	6ce2                	ld	s9,24(sp)
    80002f2c:	6d42                	ld	s10,16(sp)
    80002f2e:	6da2                	ld	s11,8(sp)
    }
    return tot;
    80002f30:	0009851b          	sext.w	a0,s3
    80002f34:	69a6                	ld	s3,72(sp)
}
    80002f36:	70a6                	ld	ra,104(sp)
    80002f38:	7406                	ld	s0,96(sp)
    80002f3a:	64e6                	ld	s1,88(sp)
    80002f3c:	7ae2                	ld	s5,56(sp)
    80002f3e:	7b42                	ld	s6,48(sp)
    80002f40:	7ba2                	ld	s7,40(sp)
    80002f42:	7c02                	ld	s8,32(sp)
    80002f44:	6165                	addi	sp,sp,112
    80002f46:	8082                	ret
    80002f48:	6946                	ld	s2,80(sp)
    80002f4a:	6a06                	ld	s4,64(sp)
    80002f4c:	6ce2                	ld	s9,24(sp)
    80002f4e:	6d42                	ld	s10,16(sp)
    80002f50:	6da2                	ld	s11,8(sp)
    80002f52:	bff9                	j	80002f30 <readi+0xd8>
    for (tot = 0; tot < n; tot += m, off += m, dst += m) {
    80002f54:	89da                	mv	s3,s6
    80002f56:	bfe9                	j	80002f30 <readi+0xd8>
        return 0;
    80002f58:	4501                	li	a0,0
}
    80002f5a:	8082                	ret

0000000080002f5c <writei>:
// there was an error of some kind.
int writei(struct inode *ip, int user_src, uint64 src, uint off, uint n) {
    uint tot, m;
    struct buf *bp;

    if (off > ip->size || off + n < off)
    80002f5c:	457c                	lw	a5,76(a0)
    80002f5e:	10d7ee63          	bltu	a5,a3,8000307a <writei+0x11e>
int writei(struct inode *ip, int user_src, uint64 src, uint off, uint n) {
    80002f62:	7159                	addi	sp,sp,-112
    80002f64:	f486                	sd	ra,104(sp)
    80002f66:	f0a2                	sd	s0,96(sp)
    80002f68:	e8ca                	sd	s2,80(sp)
    80002f6a:	fc56                	sd	s5,56(sp)
    80002f6c:	f85a                	sd	s6,48(sp)
    80002f6e:	f45e                	sd	s7,40(sp)
    80002f70:	f062                	sd	s8,32(sp)
    80002f72:	1880                	addi	s0,sp,112
    80002f74:	8b2a                	mv	s6,a0
    80002f76:	8c2e                	mv	s8,a1
    80002f78:	8ab2                	mv	s5,a2
    80002f7a:	8936                	mv	s2,a3
    80002f7c:	8bba                	mv	s7,a4
    if (off > ip->size || off + n < off)
    80002f7e:	00e687bb          	addw	a5,a3,a4
    80002f82:	0ed7ee63          	bltu	a5,a3,8000307e <writei+0x122>
        return -1;
    if (off + n > MAXFILE * BSIZE)
    80002f86:	00043737          	lui	a4,0x43
    80002f8a:	0ef76c63          	bltu	a4,a5,80003082 <writei+0x126>
    80002f8e:	e0d2                	sd	s4,64(sp)
        return -1;

    for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80002f90:	0c0b8d63          	beqz	s7,8000306a <writei+0x10e>
    80002f94:	eca6                	sd	s1,88(sp)
    80002f96:	e4ce                	sd	s3,72(sp)
    80002f98:	ec66                	sd	s9,24(sp)
    80002f9a:	e86a                	sd	s10,16(sp)
    80002f9c:	e46e                	sd	s11,8(sp)
    80002f9e:	4a01                	li	s4,0
        bp = bread(ip->dev, bmap(ip, off / BSIZE));
        m = min(n - tot, BSIZE - off % BSIZE);
    80002fa0:	40000d13          	li	s10,1024
        if (either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002fa4:	5cfd                	li	s9,-1
    80002fa6:	a091                	j	80002fea <writei+0x8e>
    80002fa8:	02099d93          	slli	s11,s3,0x20
    80002fac:	020ddd93          	srli	s11,s11,0x20
    80002fb0:	05848513          	addi	a0,s1,88
    80002fb4:	86ee                	mv	a3,s11
    80002fb6:	8656                	mv	a2,s5
    80002fb8:	85e2                	mv	a1,s8
    80002fba:	953a                	add	a0,a0,a4
    80002fbc:	fffff097          	auipc	ra,0xfffff
    80002fc0:	9d6080e7          	jalr	-1578(ra) # 80001992 <either_copyin>
    80002fc4:	07950263          	beq	a0,s9,80003028 <writei+0xcc>
            brelse(bp);
            break;
        }
        log_write(bp);
    80002fc8:	8526                	mv	a0,s1
    80002fca:	00000097          	auipc	ra,0x0
    80002fce:	780080e7          	jalr	1920(ra) # 8000374a <log_write>
        brelse(bp);
    80002fd2:	8526                	mv	a0,s1
    80002fd4:	fffff097          	auipc	ra,0xfffff
    80002fd8:	502080e7          	jalr	1282(ra) # 800024d6 <brelse>
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80002fdc:	01498a3b          	addw	s4,s3,s4
    80002fe0:	0129893b          	addw	s2,s3,s2
    80002fe4:	9aee                	add	s5,s5,s11
    80002fe6:	057a7663          	bgeu	s4,s7,80003032 <writei+0xd6>
        bp = bread(ip->dev, bmap(ip, off / BSIZE));
    80002fea:	000b2483          	lw	s1,0(s6)
    80002fee:	00a9559b          	srliw	a1,s2,0xa
    80002ff2:	855a                	mv	a0,s6
    80002ff4:	fffff097          	auipc	ra,0xfffff
    80002ff8:	7a0080e7          	jalr	1952(ra) # 80002794 <bmap>
    80002ffc:	0005059b          	sext.w	a1,a0
    80003000:	8526                	mv	a0,s1
    80003002:	fffff097          	auipc	ra,0xfffff
    80003006:	3a4080e7          	jalr	932(ra) # 800023a6 <bread>
    8000300a:	84aa                	mv	s1,a0
        m = min(n - tot, BSIZE - off % BSIZE);
    8000300c:	3ff97713          	andi	a4,s2,1023
    80003010:	40ed07bb          	subw	a5,s10,a4
    80003014:	414b86bb          	subw	a3,s7,s4
    80003018:	89be                	mv	s3,a5
    8000301a:	2781                	sext.w	a5,a5
    8000301c:	0006861b          	sext.w	a2,a3
    80003020:	f8f674e3          	bgeu	a2,a5,80002fa8 <writei+0x4c>
    80003024:	89b6                	mv	s3,a3
    80003026:	b749                	j	80002fa8 <writei+0x4c>
            brelse(bp);
    80003028:	8526                	mv	a0,s1
    8000302a:	fffff097          	auipc	ra,0xfffff
    8000302e:	4ac080e7          	jalr	1196(ra) # 800024d6 <brelse>
    }

    if (off > ip->size)
    80003032:	04cb2783          	lw	a5,76(s6)
    80003036:	0327fc63          	bgeu	a5,s2,8000306e <writei+0x112>
        ip->size = off;
    8000303a:	052b2623          	sw	s2,76(s6)
    8000303e:	64e6                	ld	s1,88(sp)
    80003040:	69a6                	ld	s3,72(sp)
    80003042:	6ce2                	ld	s9,24(sp)
    80003044:	6d42                	ld	s10,16(sp)
    80003046:	6da2                	ld	s11,8(sp)

    // write the i-node back to disk even if the size didn't change
    // because the loop above might have called bmap() and added a new
    // block to ip->addrs[].
    iupdate(ip);
    80003048:	855a                	mv	a0,s6
    8000304a:	00000097          	auipc	ra,0x0
    8000304e:	a8a080e7          	jalr	-1398(ra) # 80002ad4 <iupdate>

    return tot;
    80003052:	000a051b          	sext.w	a0,s4
    80003056:	6a06                	ld	s4,64(sp)
}
    80003058:	70a6                	ld	ra,104(sp)
    8000305a:	7406                	ld	s0,96(sp)
    8000305c:	6946                	ld	s2,80(sp)
    8000305e:	7ae2                	ld	s5,56(sp)
    80003060:	7b42                	ld	s6,48(sp)
    80003062:	7ba2                	ld	s7,40(sp)
    80003064:	7c02                	ld	s8,32(sp)
    80003066:	6165                	addi	sp,sp,112
    80003068:	8082                	ret
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
    8000306a:	8a5e                	mv	s4,s7
    8000306c:	bff1                	j	80003048 <writei+0xec>
    8000306e:	64e6                	ld	s1,88(sp)
    80003070:	69a6                	ld	s3,72(sp)
    80003072:	6ce2                	ld	s9,24(sp)
    80003074:	6d42                	ld	s10,16(sp)
    80003076:	6da2                	ld	s11,8(sp)
    80003078:	bfc1                	j	80003048 <writei+0xec>
        return -1;
    8000307a:	557d                	li	a0,-1
}
    8000307c:	8082                	ret
        return -1;
    8000307e:	557d                	li	a0,-1
    80003080:	bfe1                	j	80003058 <writei+0xfc>
        return -1;
    80003082:	557d                	li	a0,-1
    80003084:	bfd1                	j	80003058 <writei+0xfc>

0000000080003086 <namecmp>:

// Directories

int namecmp(const char *s, const char *t) { return strncmp(s, t, DIRSIZ); }
    80003086:	1141                	addi	sp,sp,-16
    80003088:	e406                	sd	ra,8(sp)
    8000308a:	e022                	sd	s0,0(sp)
    8000308c:	0800                	addi	s0,sp,16
    8000308e:	4639                	li	a2,14
    80003090:	ffffd097          	auipc	ra,0xffffd
    80003094:	204080e7          	jalr	516(ra) # 80000294 <strncmp>
    80003098:	60a2                	ld	ra,8(sp)
    8000309a:	6402                	ld	s0,0(sp)
    8000309c:	0141                	addi	sp,sp,16
    8000309e:	8082                	ret

00000000800030a0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode *dirlookup(struct inode *dp, char *name, uint *poff) {
    800030a0:	7139                	addi	sp,sp,-64
    800030a2:	fc06                	sd	ra,56(sp)
    800030a4:	f822                	sd	s0,48(sp)
    800030a6:	f426                	sd	s1,40(sp)
    800030a8:	f04a                	sd	s2,32(sp)
    800030aa:	ec4e                	sd	s3,24(sp)
    800030ac:	e852                	sd	s4,16(sp)
    800030ae:	0080                	addi	s0,sp,64
    uint off, inum;
    struct dirent de;

    if (dp->type != T_DIR)
    800030b0:	04451703          	lh	a4,68(a0)
    800030b4:	4785                	li	a5,1
    800030b6:	00f71a63          	bne	a4,a5,800030ca <dirlookup+0x2a>
    800030ba:	892a                	mv	s2,a0
    800030bc:	89ae                	mv	s3,a1
    800030be:	8a32                	mv	s4,a2
        panic("dirlookup not DIR");

    for (off = 0; off < dp->size; off += sizeof(de)) {
    800030c0:	457c                	lw	a5,76(a0)
    800030c2:	4481                	li	s1,0
            inum = de.inum;
            return iget(dp->dev, inum);
        }
    }

    return 0;
    800030c4:	4501                	li	a0,0
    for (off = 0; off < dp->size; off += sizeof(de)) {
    800030c6:	e79d                	bnez	a5,800030f4 <dirlookup+0x54>
    800030c8:	a8a5                	j	80003140 <dirlookup+0xa0>
        panic("dirlookup not DIR");
    800030ca:	00005517          	auipc	a0,0x5
    800030ce:	46e50513          	addi	a0,a0,1134 # 80008538 <etext+0x538>
    800030d2:	00003097          	auipc	ra,0x3
    800030d6:	cc0080e7          	jalr	-832(ra) # 80005d92 <panic>
            panic("dirlookup read");
    800030da:	00005517          	auipc	a0,0x5
    800030de:	47650513          	addi	a0,a0,1142 # 80008550 <etext+0x550>
    800030e2:	00003097          	auipc	ra,0x3
    800030e6:	cb0080e7          	jalr	-848(ra) # 80005d92 <panic>
    for (off = 0; off < dp->size; off += sizeof(de)) {
    800030ea:	24c1                	addiw	s1,s1,16
    800030ec:	04c92783          	lw	a5,76(s2)
    800030f0:	04f4f763          	bgeu	s1,a5,8000313e <dirlookup+0x9e>
        if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800030f4:	4741                	li	a4,16
    800030f6:	86a6                	mv	a3,s1
    800030f8:	fc040613          	addi	a2,s0,-64
    800030fc:	4581                	li	a1,0
    800030fe:	854a                	mv	a0,s2
    80003100:	00000097          	auipc	ra,0x0
    80003104:	d58080e7          	jalr	-680(ra) # 80002e58 <readi>
    80003108:	47c1                	li	a5,16
    8000310a:	fcf518e3          	bne	a0,a5,800030da <dirlookup+0x3a>
        if (de.inum == 0)
    8000310e:	fc045783          	lhu	a5,-64(s0)
    80003112:	dfe1                	beqz	a5,800030ea <dirlookup+0x4a>
        if (namecmp(name, de.name) == 0) {
    80003114:	fc240593          	addi	a1,s0,-62
    80003118:	854e                	mv	a0,s3
    8000311a:	00000097          	auipc	ra,0x0
    8000311e:	f6c080e7          	jalr	-148(ra) # 80003086 <namecmp>
    80003122:	f561                	bnez	a0,800030ea <dirlookup+0x4a>
            if (poff)
    80003124:	000a0463          	beqz	s4,8000312c <dirlookup+0x8c>
                *poff = off;
    80003128:	009a2023          	sw	s1,0(s4)
            return iget(dp->dev, inum);
    8000312c:	fc045583          	lhu	a1,-64(s0)
    80003130:	00092503          	lw	a0,0(s2)
    80003134:	fffff097          	auipc	ra,0xfffff
    80003138:	73c080e7          	jalr	1852(ra) # 80002870 <iget>
    8000313c:	a011                	j	80003140 <dirlookup+0xa0>
    return 0;
    8000313e:	4501                	li	a0,0
}
    80003140:	70e2                	ld	ra,56(sp)
    80003142:	7442                	ld	s0,48(sp)
    80003144:	74a2                	ld	s1,40(sp)
    80003146:	7902                	ld	s2,32(sp)
    80003148:	69e2                	ld	s3,24(sp)
    8000314a:	6a42                	ld	s4,16(sp)
    8000314c:	6121                	addi	sp,sp,64
    8000314e:	8082                	ret

0000000080003150 <namex>:

// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode *namex(char *path, int nameiparent, char *name) {
    80003150:	711d                	addi	sp,sp,-96
    80003152:	ec86                	sd	ra,88(sp)
    80003154:	e8a2                	sd	s0,80(sp)
    80003156:	e4a6                	sd	s1,72(sp)
    80003158:	e0ca                	sd	s2,64(sp)
    8000315a:	fc4e                	sd	s3,56(sp)
    8000315c:	f852                	sd	s4,48(sp)
    8000315e:	f456                	sd	s5,40(sp)
    80003160:	f05a                	sd	s6,32(sp)
    80003162:	ec5e                	sd	s7,24(sp)
    80003164:	e862                	sd	s8,16(sp)
    80003166:	e466                	sd	s9,8(sp)
    80003168:	1080                	addi	s0,sp,96
    8000316a:	84aa                	mv	s1,a0
    8000316c:	8b2e                	mv	s6,a1
    8000316e:	8ab2                	mv	s5,a2
    struct inode *ip, *next;

    if (*path == '/')
    80003170:	00054703          	lbu	a4,0(a0)
    80003174:	02f00793          	li	a5,47
    80003178:	02f70263          	beq	a4,a5,8000319c <namex+0x4c>
        ip = iget(ROOTDEV, ROOTINO);
    else
        ip = idup(myproc()->cwd);
    8000317c:	ffffe097          	auipc	ra,0xffffe
    80003180:	d4a080e7          	jalr	-694(ra) # 80000ec6 <myproc>
    80003184:	15053503          	ld	a0,336(a0)
    80003188:	00000097          	auipc	ra,0x0
    8000318c:	9da080e7          	jalr	-1574(ra) # 80002b62 <idup>
    80003190:	8a2a                	mv	s4,a0
    while (*path == '/')
    80003192:	02f00913          	li	s2,47
    if (len >= DIRSIZ)
    80003196:	4c35                	li	s8,13

    while ((path = skipelem(path, name)) != 0) {
        ilock(ip);
        if (ip->type != T_DIR) {
    80003198:	4b85                	li	s7,1
    8000319a:	a875                	j	80003256 <namex+0x106>
        ip = iget(ROOTDEV, ROOTINO);
    8000319c:	4585                	li	a1,1
    8000319e:	4505                	li	a0,1
    800031a0:	fffff097          	auipc	ra,0xfffff
    800031a4:	6d0080e7          	jalr	1744(ra) # 80002870 <iget>
    800031a8:	8a2a                	mv	s4,a0
    800031aa:	b7e5                	j	80003192 <namex+0x42>
            iunlockput(ip);
    800031ac:	8552                	mv	a0,s4
    800031ae:	00000097          	auipc	ra,0x0
    800031b2:	c58080e7          	jalr	-936(ra) # 80002e06 <iunlockput>
            return 0;
    800031b6:	4a01                	li	s4,0
    if (nameiparent) {
        iput(ip);
        return 0;
    }
    return ip;
}
    800031b8:	8552                	mv	a0,s4
    800031ba:	60e6                	ld	ra,88(sp)
    800031bc:	6446                	ld	s0,80(sp)
    800031be:	64a6                	ld	s1,72(sp)
    800031c0:	6906                	ld	s2,64(sp)
    800031c2:	79e2                	ld	s3,56(sp)
    800031c4:	7a42                	ld	s4,48(sp)
    800031c6:	7aa2                	ld	s5,40(sp)
    800031c8:	7b02                	ld	s6,32(sp)
    800031ca:	6be2                	ld	s7,24(sp)
    800031cc:	6c42                	ld	s8,16(sp)
    800031ce:	6ca2                	ld	s9,8(sp)
    800031d0:	6125                	addi	sp,sp,96
    800031d2:	8082                	ret
            iunlock(ip);
    800031d4:	8552                	mv	a0,s4
    800031d6:	00000097          	auipc	ra,0x0
    800031da:	a90080e7          	jalr	-1392(ra) # 80002c66 <iunlock>
            return ip;
    800031de:	bfe9                	j	800031b8 <namex+0x68>
            iunlockput(ip);
    800031e0:	8552                	mv	a0,s4
    800031e2:	00000097          	auipc	ra,0x0
    800031e6:	c24080e7          	jalr	-988(ra) # 80002e06 <iunlockput>
            return 0;
    800031ea:	8a4e                	mv	s4,s3
    800031ec:	b7f1                	j	800031b8 <namex+0x68>
    len = path - s;
    800031ee:	40998633          	sub	a2,s3,s1
    800031f2:	00060c9b          	sext.w	s9,a2
    if (len >= DIRSIZ)
    800031f6:	099c5863          	bge	s8,s9,80003286 <namex+0x136>
        memmove(name, s, DIRSIZ);
    800031fa:	4639                	li	a2,14
    800031fc:	85a6                	mv	a1,s1
    800031fe:	8556                	mv	a0,s5
    80003200:	ffffd097          	auipc	ra,0xffffd
    80003204:	020080e7          	jalr	32(ra) # 80000220 <memmove>
    80003208:	84ce                	mv	s1,s3
    while (*path == '/')
    8000320a:	0004c783          	lbu	a5,0(s1)
    8000320e:	01279763          	bne	a5,s2,8000321c <namex+0xcc>
        path++;
    80003212:	0485                	addi	s1,s1,1
    while (*path == '/')
    80003214:	0004c783          	lbu	a5,0(s1)
    80003218:	ff278de3          	beq	a5,s2,80003212 <namex+0xc2>
        ilock(ip);
    8000321c:	8552                	mv	a0,s4
    8000321e:	00000097          	auipc	ra,0x0
    80003222:	982080e7          	jalr	-1662(ra) # 80002ba0 <ilock>
        if (ip->type != T_DIR) {
    80003226:	044a1783          	lh	a5,68(s4)
    8000322a:	f97791e3          	bne	a5,s7,800031ac <namex+0x5c>
        if (nameiparent && *path == '\0') {
    8000322e:	000b0563          	beqz	s6,80003238 <namex+0xe8>
    80003232:	0004c783          	lbu	a5,0(s1)
    80003236:	dfd9                	beqz	a5,800031d4 <namex+0x84>
        if ((next = dirlookup(ip, name, 0)) == 0) {
    80003238:	4601                	li	a2,0
    8000323a:	85d6                	mv	a1,s5
    8000323c:	8552                	mv	a0,s4
    8000323e:	00000097          	auipc	ra,0x0
    80003242:	e62080e7          	jalr	-414(ra) # 800030a0 <dirlookup>
    80003246:	89aa                	mv	s3,a0
    80003248:	dd41                	beqz	a0,800031e0 <namex+0x90>
        iunlockput(ip);
    8000324a:	8552                	mv	a0,s4
    8000324c:	00000097          	auipc	ra,0x0
    80003250:	bba080e7          	jalr	-1094(ra) # 80002e06 <iunlockput>
        ip = next;
    80003254:	8a4e                	mv	s4,s3
    while (*path == '/')
    80003256:	0004c783          	lbu	a5,0(s1)
    8000325a:	01279763          	bne	a5,s2,80003268 <namex+0x118>
        path++;
    8000325e:	0485                	addi	s1,s1,1
    while (*path == '/')
    80003260:	0004c783          	lbu	a5,0(s1)
    80003264:	ff278de3          	beq	a5,s2,8000325e <namex+0x10e>
    if (*path == 0)
    80003268:	cb9d                	beqz	a5,8000329e <namex+0x14e>
    while (*path != '/' && *path != 0)
    8000326a:	0004c783          	lbu	a5,0(s1)
    8000326e:	89a6                	mv	s3,s1
    len = path - s;
    80003270:	4c81                	li	s9,0
    80003272:	4601                	li	a2,0
    while (*path != '/' && *path != 0)
    80003274:	01278963          	beq	a5,s2,80003286 <namex+0x136>
    80003278:	dbbd                	beqz	a5,800031ee <namex+0x9e>
        path++;
    8000327a:	0985                	addi	s3,s3,1
    while (*path != '/' && *path != 0)
    8000327c:	0009c783          	lbu	a5,0(s3)
    80003280:	ff279ce3          	bne	a5,s2,80003278 <namex+0x128>
    80003284:	b7ad                	j	800031ee <namex+0x9e>
        memmove(name, s, len);
    80003286:	2601                	sext.w	a2,a2
    80003288:	85a6                	mv	a1,s1
    8000328a:	8556                	mv	a0,s5
    8000328c:	ffffd097          	auipc	ra,0xffffd
    80003290:	f94080e7          	jalr	-108(ra) # 80000220 <memmove>
        name[len] = 0;
    80003294:	9cd6                	add	s9,s9,s5
    80003296:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    8000329a:	84ce                	mv	s1,s3
    8000329c:	b7bd                	j	8000320a <namex+0xba>
    if (nameiparent) {
    8000329e:	f00b0de3          	beqz	s6,800031b8 <namex+0x68>
        iput(ip);
    800032a2:	8552                	mv	a0,s4
    800032a4:	00000097          	auipc	ra,0x0
    800032a8:	aba080e7          	jalr	-1350(ra) # 80002d5e <iput>
        return 0;
    800032ac:	4a01                	li	s4,0
    800032ae:	b729                	j	800031b8 <namex+0x68>

00000000800032b0 <dirlink>:
int dirlink(struct inode *dp, char *name, uint inum) {
    800032b0:	7139                	addi	sp,sp,-64
    800032b2:	fc06                	sd	ra,56(sp)
    800032b4:	f822                	sd	s0,48(sp)
    800032b6:	f04a                	sd	s2,32(sp)
    800032b8:	ec4e                	sd	s3,24(sp)
    800032ba:	e852                	sd	s4,16(sp)
    800032bc:	0080                	addi	s0,sp,64
    800032be:	892a                	mv	s2,a0
    800032c0:	8a2e                	mv	s4,a1
    800032c2:	89b2                	mv	s3,a2
    if ((ip = dirlookup(dp, name, 0)) != 0) {
    800032c4:	4601                	li	a2,0
    800032c6:	00000097          	auipc	ra,0x0
    800032ca:	dda080e7          	jalr	-550(ra) # 800030a0 <dirlookup>
    800032ce:	ed25                	bnez	a0,80003346 <dirlink+0x96>
    800032d0:	f426                	sd	s1,40(sp)
    for (off = 0; off < dp->size; off += sizeof(de)) {
    800032d2:	04c92483          	lw	s1,76(s2)
    800032d6:	c49d                	beqz	s1,80003304 <dirlink+0x54>
    800032d8:	4481                	li	s1,0
        if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800032da:	4741                	li	a4,16
    800032dc:	86a6                	mv	a3,s1
    800032de:	fc040613          	addi	a2,s0,-64
    800032e2:	4581                	li	a1,0
    800032e4:	854a                	mv	a0,s2
    800032e6:	00000097          	auipc	ra,0x0
    800032ea:	b72080e7          	jalr	-1166(ra) # 80002e58 <readi>
    800032ee:	47c1                	li	a5,16
    800032f0:	06f51163          	bne	a0,a5,80003352 <dirlink+0xa2>
        if (de.inum == 0)
    800032f4:	fc045783          	lhu	a5,-64(s0)
    800032f8:	c791                	beqz	a5,80003304 <dirlink+0x54>
    for (off = 0; off < dp->size; off += sizeof(de)) {
    800032fa:	24c1                	addiw	s1,s1,16
    800032fc:	04c92783          	lw	a5,76(s2)
    80003300:	fcf4ede3          	bltu	s1,a5,800032da <dirlink+0x2a>
    strncpy(de.name, name, DIRSIZ);
    80003304:	4639                	li	a2,14
    80003306:	85d2                	mv	a1,s4
    80003308:	fc240513          	addi	a0,s0,-62
    8000330c:	ffffd097          	auipc	ra,0xffffd
    80003310:	fbe080e7          	jalr	-66(ra) # 800002ca <strncpy>
    de.inum = inum;
    80003314:	fd341023          	sh	s3,-64(s0)
    if (writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003318:	4741                	li	a4,16
    8000331a:	86a6                	mv	a3,s1
    8000331c:	fc040613          	addi	a2,s0,-64
    80003320:	4581                	li	a1,0
    80003322:	854a                	mv	a0,s2
    80003324:	00000097          	auipc	ra,0x0
    80003328:	c38080e7          	jalr	-968(ra) # 80002f5c <writei>
    8000332c:	872a                	mv	a4,a0
    8000332e:	47c1                	li	a5,16
    return 0;
    80003330:	4501                	li	a0,0
    if (writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003332:	02f71863          	bne	a4,a5,80003362 <dirlink+0xb2>
    80003336:	74a2                	ld	s1,40(sp)
}
    80003338:	70e2                	ld	ra,56(sp)
    8000333a:	7442                	ld	s0,48(sp)
    8000333c:	7902                	ld	s2,32(sp)
    8000333e:	69e2                	ld	s3,24(sp)
    80003340:	6a42                	ld	s4,16(sp)
    80003342:	6121                	addi	sp,sp,64
    80003344:	8082                	ret
        iput(ip);
    80003346:	00000097          	auipc	ra,0x0
    8000334a:	a18080e7          	jalr	-1512(ra) # 80002d5e <iput>
        return -1;
    8000334e:	557d                	li	a0,-1
    80003350:	b7e5                	j	80003338 <dirlink+0x88>
            panic("dirlink read");
    80003352:	00005517          	auipc	a0,0x5
    80003356:	20e50513          	addi	a0,a0,526 # 80008560 <etext+0x560>
    8000335a:	00003097          	auipc	ra,0x3
    8000335e:	a38080e7          	jalr	-1480(ra) # 80005d92 <panic>
        panic("dirlink");
    80003362:	00005517          	auipc	a0,0x5
    80003366:	30650513          	addi	a0,a0,774 # 80008668 <etext+0x668>
    8000336a:	00003097          	auipc	ra,0x3
    8000336e:	a28080e7          	jalr	-1496(ra) # 80005d92 <panic>

0000000080003372 <namei>:

struct inode *namei(char *path) {
    80003372:	1101                	addi	sp,sp,-32
    80003374:	ec06                	sd	ra,24(sp)
    80003376:	e822                	sd	s0,16(sp)
    80003378:	1000                	addi	s0,sp,32
    char name[DIRSIZ];
    return namex(path, 0, name);
    8000337a:	fe040613          	addi	a2,s0,-32
    8000337e:	4581                	li	a1,0
    80003380:	00000097          	auipc	ra,0x0
    80003384:	dd0080e7          	jalr	-560(ra) # 80003150 <namex>
}
    80003388:	60e2                	ld	ra,24(sp)
    8000338a:	6442                	ld	s0,16(sp)
    8000338c:	6105                	addi	sp,sp,32
    8000338e:	8082                	ret

0000000080003390 <nameiparent>:

struct inode *nameiparent(char *path, char *name) {
    80003390:	1141                	addi	sp,sp,-16
    80003392:	e406                	sd	ra,8(sp)
    80003394:	e022                	sd	s0,0(sp)
    80003396:	0800                	addi	s0,sp,16
    80003398:	862e                	mv	a2,a1
    return namex(path, 1, name);
    8000339a:	4585                	li	a1,1
    8000339c:	00000097          	auipc	ra,0x0
    800033a0:	db4080e7          	jalr	-588(ra) # 80003150 <namex>
}
    800033a4:	60a2                	ld	ra,8(sp)
    800033a6:	6402                	ld	s0,0(sp)
    800033a8:	0141                	addi	sp,sp,16
    800033aa:	8082                	ret

00000000800033ac <write_head>:
}

// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void write_head(void) {
    800033ac:	1101                	addi	sp,sp,-32
    800033ae:	ec06                	sd	ra,24(sp)
    800033b0:	e822                	sd	s0,16(sp)
    800033b2:	e426                	sd	s1,8(sp)
    800033b4:	e04a                	sd	s2,0(sp)
    800033b6:	1000                	addi	s0,sp,32
    struct buf *buf = bread(log.dev, log.start);
    800033b8:	00019917          	auipc	s2,0x19
    800033bc:	e6890913          	addi	s2,s2,-408 # 8001c220 <log>
    800033c0:	01892583          	lw	a1,24(s2)
    800033c4:	02892503          	lw	a0,40(s2)
    800033c8:	fffff097          	auipc	ra,0xfffff
    800033cc:	fde080e7          	jalr	-34(ra) # 800023a6 <bread>
    800033d0:	84aa                	mv	s1,a0
    struct logheader *hb = (struct logheader *)(buf->data);
    int i;
    hb->n = log.lh.n;
    800033d2:	02c92603          	lw	a2,44(s2)
    800033d6:	cd30                	sw	a2,88(a0)
    for (i = 0; i < log.lh.n; i++) {
    800033d8:	00c05f63          	blez	a2,800033f6 <write_head+0x4a>
    800033dc:	00019717          	auipc	a4,0x19
    800033e0:	e7470713          	addi	a4,a4,-396 # 8001c250 <log+0x30>
    800033e4:	87aa                	mv	a5,a0
    800033e6:	060a                	slli	a2,a2,0x2
    800033e8:	962a                	add	a2,a2,a0
        hb->block[i] = log.lh.block[i];
    800033ea:	4314                	lw	a3,0(a4)
    800033ec:	cff4                	sw	a3,92(a5)
    for (i = 0; i < log.lh.n; i++) {
    800033ee:	0711                	addi	a4,a4,4
    800033f0:	0791                	addi	a5,a5,4
    800033f2:	fec79ce3          	bne	a5,a2,800033ea <write_head+0x3e>
    }
    bwrite(buf);
    800033f6:	8526                	mv	a0,s1
    800033f8:	fffff097          	auipc	ra,0xfffff
    800033fc:	0a0080e7          	jalr	160(ra) # 80002498 <bwrite>
    brelse(buf);
    80003400:	8526                	mv	a0,s1
    80003402:	fffff097          	auipc	ra,0xfffff
    80003406:	0d4080e7          	jalr	212(ra) # 800024d6 <brelse>
}
    8000340a:	60e2                	ld	ra,24(sp)
    8000340c:	6442                	ld	s0,16(sp)
    8000340e:	64a2                	ld	s1,8(sp)
    80003410:	6902                	ld	s2,0(sp)
    80003412:	6105                	addi	sp,sp,32
    80003414:	8082                	ret

0000000080003416 <install_trans>:
    for (tail = 0; tail < log.lh.n; tail++) {
    80003416:	00019797          	auipc	a5,0x19
    8000341a:	e367a783          	lw	a5,-458(a5) # 8001c24c <log+0x2c>
    8000341e:	0af05d63          	blez	a5,800034d8 <install_trans+0xc2>
static void install_trans(int recovering) {
    80003422:	7139                	addi	sp,sp,-64
    80003424:	fc06                	sd	ra,56(sp)
    80003426:	f822                	sd	s0,48(sp)
    80003428:	f426                	sd	s1,40(sp)
    8000342a:	f04a                	sd	s2,32(sp)
    8000342c:	ec4e                	sd	s3,24(sp)
    8000342e:	e852                	sd	s4,16(sp)
    80003430:	e456                	sd	s5,8(sp)
    80003432:	e05a                	sd	s6,0(sp)
    80003434:	0080                	addi	s0,sp,64
    80003436:	8b2a                	mv	s6,a0
    80003438:	00019a97          	auipc	s5,0x19
    8000343c:	e18a8a93          	addi	s5,s5,-488 # 8001c250 <log+0x30>
    for (tail = 0; tail < log.lh.n; tail++) {
    80003440:	4a01                	li	s4,0
            bread(log.dev, log.start + tail + 1);              // read log block
    80003442:	00019997          	auipc	s3,0x19
    80003446:	dde98993          	addi	s3,s3,-546 # 8001c220 <log>
    8000344a:	a00d                	j	8000346c <install_trans+0x56>
        brelse(lbuf);
    8000344c:	854a                	mv	a0,s2
    8000344e:	fffff097          	auipc	ra,0xfffff
    80003452:	088080e7          	jalr	136(ra) # 800024d6 <brelse>
        brelse(dbuf);
    80003456:	8526                	mv	a0,s1
    80003458:	fffff097          	auipc	ra,0xfffff
    8000345c:	07e080e7          	jalr	126(ra) # 800024d6 <brelse>
    for (tail = 0; tail < log.lh.n; tail++) {
    80003460:	2a05                	addiw	s4,s4,1
    80003462:	0a91                	addi	s5,s5,4
    80003464:	02c9a783          	lw	a5,44(s3)
    80003468:	04fa5e63          	bge	s4,a5,800034c4 <install_trans+0xae>
            bread(log.dev, log.start + tail + 1);              // read log block
    8000346c:	0189a583          	lw	a1,24(s3)
    80003470:	014585bb          	addw	a1,a1,s4
    80003474:	2585                	addiw	a1,a1,1
    80003476:	0289a503          	lw	a0,40(s3)
    8000347a:	fffff097          	auipc	ra,0xfffff
    8000347e:	f2c080e7          	jalr	-212(ra) # 800023a6 <bread>
    80003482:	892a                	mv	s2,a0
        struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80003484:	000aa583          	lw	a1,0(s5)
    80003488:	0289a503          	lw	a0,40(s3)
    8000348c:	fffff097          	auipc	ra,0xfffff
    80003490:	f1a080e7          	jalr	-230(ra) # 800023a6 <bread>
    80003494:	84aa                	mv	s1,a0
        memmove(dbuf->data, lbuf->data, BSIZE); // copy block to dst
    80003496:	40000613          	li	a2,1024
    8000349a:	05890593          	addi	a1,s2,88
    8000349e:	05850513          	addi	a0,a0,88
    800034a2:	ffffd097          	auipc	ra,0xffffd
    800034a6:	d7e080e7          	jalr	-642(ra) # 80000220 <memmove>
        bwrite(dbuf);                           // write dst to disk
    800034aa:	8526                	mv	a0,s1
    800034ac:	fffff097          	auipc	ra,0xfffff
    800034b0:	fec080e7          	jalr	-20(ra) # 80002498 <bwrite>
        if (recovering == 0)
    800034b4:	f80b1ce3          	bnez	s6,8000344c <install_trans+0x36>
            bunpin(dbuf);
    800034b8:	8526                	mv	a0,s1
    800034ba:	fffff097          	auipc	ra,0xfffff
    800034be:	0f4080e7          	jalr	244(ra) # 800025ae <bunpin>
    800034c2:	b769                	j	8000344c <install_trans+0x36>
}
    800034c4:	70e2                	ld	ra,56(sp)
    800034c6:	7442                	ld	s0,48(sp)
    800034c8:	74a2                	ld	s1,40(sp)
    800034ca:	7902                	ld	s2,32(sp)
    800034cc:	69e2                	ld	s3,24(sp)
    800034ce:	6a42                	ld	s4,16(sp)
    800034d0:	6aa2                	ld	s5,8(sp)
    800034d2:	6b02                	ld	s6,0(sp)
    800034d4:	6121                	addi	sp,sp,64
    800034d6:	8082                	ret
    800034d8:	8082                	ret

00000000800034da <initlog>:
void initlog(int dev, struct superblock *sb) {
    800034da:	7179                	addi	sp,sp,-48
    800034dc:	f406                	sd	ra,40(sp)
    800034de:	f022                	sd	s0,32(sp)
    800034e0:	ec26                	sd	s1,24(sp)
    800034e2:	e84a                	sd	s2,16(sp)
    800034e4:	e44e                	sd	s3,8(sp)
    800034e6:	1800                	addi	s0,sp,48
    800034e8:	892a                	mv	s2,a0
    800034ea:	89ae                	mv	s3,a1
    initlock(&log.lock, "log");
    800034ec:	00019497          	auipc	s1,0x19
    800034f0:	d3448493          	addi	s1,s1,-716 # 8001c220 <log>
    800034f4:	00005597          	auipc	a1,0x5
    800034f8:	07c58593          	addi	a1,a1,124 # 80008570 <etext+0x570>
    800034fc:	8526                	mv	a0,s1
    800034fe:	00003097          	auipc	ra,0x3
    80003502:	d7e080e7          	jalr	-642(ra) # 8000627c <initlock>
    log.start = sb->logstart;
    80003506:	0149a583          	lw	a1,20(s3)
    8000350a:	cc8c                	sw	a1,24(s1)
    log.size = sb->nlog;
    8000350c:	0109a783          	lw	a5,16(s3)
    80003510:	ccdc                	sw	a5,28(s1)
    log.dev = dev;
    80003512:	0324a423          	sw	s2,40(s1)
    struct buf *buf = bread(log.dev, log.start);
    80003516:	854a                	mv	a0,s2
    80003518:	fffff097          	auipc	ra,0xfffff
    8000351c:	e8e080e7          	jalr	-370(ra) # 800023a6 <bread>
    log.lh.n = lh->n;
    80003520:	4d30                	lw	a2,88(a0)
    80003522:	d4d0                	sw	a2,44(s1)
    for (i = 0; i < log.lh.n; i++) {
    80003524:	00c05f63          	blez	a2,80003542 <initlog+0x68>
    80003528:	87aa                	mv	a5,a0
    8000352a:	00019717          	auipc	a4,0x19
    8000352e:	d2670713          	addi	a4,a4,-730 # 8001c250 <log+0x30>
    80003532:	060a                	slli	a2,a2,0x2
    80003534:	962a                	add	a2,a2,a0
        log.lh.block[i] = lh->block[i];
    80003536:	4ff4                	lw	a3,92(a5)
    80003538:	c314                	sw	a3,0(a4)
    for (i = 0; i < log.lh.n; i++) {
    8000353a:	0791                	addi	a5,a5,4
    8000353c:	0711                	addi	a4,a4,4
    8000353e:	fec79ce3          	bne	a5,a2,80003536 <initlog+0x5c>
    brelse(buf);
    80003542:	fffff097          	auipc	ra,0xfffff
    80003546:	f94080e7          	jalr	-108(ra) # 800024d6 <brelse>

static void recover_from_log(void) {
    read_head();
    install_trans(1); // if committed, copy from log to disk
    8000354a:	4505                	li	a0,1
    8000354c:	00000097          	auipc	ra,0x0
    80003550:	eca080e7          	jalr	-310(ra) # 80003416 <install_trans>
    log.lh.n = 0;
    80003554:	00019797          	auipc	a5,0x19
    80003558:	ce07ac23          	sw	zero,-776(a5) # 8001c24c <log+0x2c>
    write_head(); // clear the log
    8000355c:	00000097          	auipc	ra,0x0
    80003560:	e50080e7          	jalr	-432(ra) # 800033ac <write_head>
}
    80003564:	70a2                	ld	ra,40(sp)
    80003566:	7402                	ld	s0,32(sp)
    80003568:	64e2                	ld	s1,24(sp)
    8000356a:	6942                	ld	s2,16(sp)
    8000356c:	69a2                	ld	s3,8(sp)
    8000356e:	6145                	addi	sp,sp,48
    80003570:	8082                	ret

0000000080003572 <begin_op>:
}

// called at the start of each FS system call.
void begin_op(void) {
    80003572:	1101                	addi	sp,sp,-32
    80003574:	ec06                	sd	ra,24(sp)
    80003576:	e822                	sd	s0,16(sp)
    80003578:	e426                	sd	s1,8(sp)
    8000357a:	e04a                	sd	s2,0(sp)
    8000357c:	1000                	addi	s0,sp,32
    acquire(&log.lock);
    8000357e:	00019517          	auipc	a0,0x19
    80003582:	ca250513          	addi	a0,a0,-862 # 8001c220 <log>
    80003586:	00003097          	auipc	ra,0x3
    8000358a:	d86080e7          	jalr	-634(ra) # 8000630c <acquire>
    while (1) {
        if (log.committing) {
    8000358e:	00019497          	auipc	s1,0x19
    80003592:	c9248493          	addi	s1,s1,-878 # 8001c220 <log>
            sleep(&log, &log.lock);
        } else if (log.lh.n + (log.outstanding + 1) * MAXOPBLOCKS > LOGSIZE) {
    80003596:	4979                	li	s2,30
    80003598:	a039                	j	800035a6 <begin_op+0x34>
            sleep(&log, &log.lock);
    8000359a:	85a6                	mv	a1,s1
    8000359c:	8526                	mv	a0,s1
    8000359e:	ffffe097          	auipc	ra,0xffffe
    800035a2:	ffa080e7          	jalr	-6(ra) # 80001598 <sleep>
        if (log.committing) {
    800035a6:	50dc                	lw	a5,36(s1)
    800035a8:	fbed                	bnez	a5,8000359a <begin_op+0x28>
        } else if (log.lh.n + (log.outstanding + 1) * MAXOPBLOCKS > LOGSIZE) {
    800035aa:	5098                	lw	a4,32(s1)
    800035ac:	2705                	addiw	a4,a4,1
    800035ae:	0027179b          	slliw	a5,a4,0x2
    800035b2:	9fb9                	addw	a5,a5,a4
    800035b4:	0017979b          	slliw	a5,a5,0x1
    800035b8:	54d4                	lw	a3,44(s1)
    800035ba:	9fb5                	addw	a5,a5,a3
    800035bc:	00f95963          	bge	s2,a5,800035ce <begin_op+0x5c>
            // this op might exhaust log space; wait for commit.
            sleep(&log, &log.lock);
    800035c0:	85a6                	mv	a1,s1
    800035c2:	8526                	mv	a0,s1
    800035c4:	ffffe097          	auipc	ra,0xffffe
    800035c8:	fd4080e7          	jalr	-44(ra) # 80001598 <sleep>
    800035cc:	bfe9                	j	800035a6 <begin_op+0x34>
        } else {
            log.outstanding += 1;
    800035ce:	00019517          	auipc	a0,0x19
    800035d2:	c5250513          	addi	a0,a0,-942 # 8001c220 <log>
    800035d6:	d118                	sw	a4,32(a0)
            release(&log.lock);
    800035d8:	00003097          	auipc	ra,0x3
    800035dc:	de8080e7          	jalr	-536(ra) # 800063c0 <release>
            break;
        }
    }
}
    800035e0:	60e2                	ld	ra,24(sp)
    800035e2:	6442                	ld	s0,16(sp)
    800035e4:	64a2                	ld	s1,8(sp)
    800035e6:	6902                	ld	s2,0(sp)
    800035e8:	6105                	addi	sp,sp,32
    800035ea:	8082                	ret

00000000800035ec <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void end_op(void) {
    800035ec:	7139                	addi	sp,sp,-64
    800035ee:	fc06                	sd	ra,56(sp)
    800035f0:	f822                	sd	s0,48(sp)
    800035f2:	f426                	sd	s1,40(sp)
    800035f4:	f04a                	sd	s2,32(sp)
    800035f6:	0080                	addi	s0,sp,64
    int do_commit = 0;

    acquire(&log.lock);
    800035f8:	00019497          	auipc	s1,0x19
    800035fc:	c2848493          	addi	s1,s1,-984 # 8001c220 <log>
    80003600:	8526                	mv	a0,s1
    80003602:	00003097          	auipc	ra,0x3
    80003606:	d0a080e7          	jalr	-758(ra) # 8000630c <acquire>
    log.outstanding -= 1;
    8000360a:	509c                	lw	a5,32(s1)
    8000360c:	37fd                	addiw	a5,a5,-1
    8000360e:	0007891b          	sext.w	s2,a5
    80003612:	d09c                	sw	a5,32(s1)
    if (log.committing)
    80003614:	50dc                	lw	a5,36(s1)
    80003616:	e7b9                	bnez	a5,80003664 <end_op+0x78>
        panic("log.committing");
    if (log.outstanding == 0) {
    80003618:	06091163          	bnez	s2,8000367a <end_op+0x8e>
        do_commit = 1;
        log.committing = 1;
    8000361c:	00019497          	auipc	s1,0x19
    80003620:	c0448493          	addi	s1,s1,-1020 # 8001c220 <log>
    80003624:	4785                	li	a5,1
    80003626:	d0dc                	sw	a5,36(s1)
        // begin_op() may be waiting for log space,
        // and decrementing log.outstanding has decreased
        // the amount of reserved space.
        wakeup(&log);
    }
    release(&log.lock);
    80003628:	8526                	mv	a0,s1
    8000362a:	00003097          	auipc	ra,0x3
    8000362e:	d96080e7          	jalr	-618(ra) # 800063c0 <release>
        brelse(to);
    }
}

static void commit() {
    if (log.lh.n > 0) {
    80003632:	54dc                	lw	a5,44(s1)
    80003634:	06f04763          	bgtz	a5,800036a2 <end_op+0xb6>
        acquire(&log.lock);
    80003638:	00019497          	auipc	s1,0x19
    8000363c:	be848493          	addi	s1,s1,-1048 # 8001c220 <log>
    80003640:	8526                	mv	a0,s1
    80003642:	00003097          	auipc	ra,0x3
    80003646:	cca080e7          	jalr	-822(ra) # 8000630c <acquire>
        log.committing = 0;
    8000364a:	0204a223          	sw	zero,36(s1)
        wakeup(&log);
    8000364e:	8526                	mv	a0,s1
    80003650:	ffffe097          	auipc	ra,0xffffe
    80003654:	0d4080e7          	jalr	212(ra) # 80001724 <wakeup>
        release(&log.lock);
    80003658:	8526                	mv	a0,s1
    8000365a:	00003097          	auipc	ra,0x3
    8000365e:	d66080e7          	jalr	-666(ra) # 800063c0 <release>
}
    80003662:	a815                	j	80003696 <end_op+0xaa>
    80003664:	ec4e                	sd	s3,24(sp)
    80003666:	e852                	sd	s4,16(sp)
    80003668:	e456                	sd	s5,8(sp)
        panic("log.committing");
    8000366a:	00005517          	auipc	a0,0x5
    8000366e:	f0e50513          	addi	a0,a0,-242 # 80008578 <etext+0x578>
    80003672:	00002097          	auipc	ra,0x2
    80003676:	720080e7          	jalr	1824(ra) # 80005d92 <panic>
        wakeup(&log);
    8000367a:	00019497          	auipc	s1,0x19
    8000367e:	ba648493          	addi	s1,s1,-1114 # 8001c220 <log>
    80003682:	8526                	mv	a0,s1
    80003684:	ffffe097          	auipc	ra,0xffffe
    80003688:	0a0080e7          	jalr	160(ra) # 80001724 <wakeup>
    release(&log.lock);
    8000368c:	8526                	mv	a0,s1
    8000368e:	00003097          	auipc	ra,0x3
    80003692:	d32080e7          	jalr	-718(ra) # 800063c0 <release>
}
    80003696:	70e2                	ld	ra,56(sp)
    80003698:	7442                	ld	s0,48(sp)
    8000369a:	74a2                	ld	s1,40(sp)
    8000369c:	7902                	ld	s2,32(sp)
    8000369e:	6121                	addi	sp,sp,64
    800036a0:	8082                	ret
    800036a2:	ec4e                	sd	s3,24(sp)
    800036a4:	e852                	sd	s4,16(sp)
    800036a6:	e456                	sd	s5,8(sp)
    for (tail = 0; tail < log.lh.n; tail++) {
    800036a8:	00019a97          	auipc	s5,0x19
    800036ac:	ba8a8a93          	addi	s5,s5,-1112 # 8001c250 <log+0x30>
        struct buf *to = bread(log.dev, log.start + tail + 1); // log block
    800036b0:	00019a17          	auipc	s4,0x19
    800036b4:	b70a0a13          	addi	s4,s4,-1168 # 8001c220 <log>
    800036b8:	018a2583          	lw	a1,24(s4)
    800036bc:	012585bb          	addw	a1,a1,s2
    800036c0:	2585                	addiw	a1,a1,1
    800036c2:	028a2503          	lw	a0,40(s4)
    800036c6:	fffff097          	auipc	ra,0xfffff
    800036ca:	ce0080e7          	jalr	-800(ra) # 800023a6 <bread>
    800036ce:	84aa                	mv	s1,a0
        struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800036d0:	000aa583          	lw	a1,0(s5)
    800036d4:	028a2503          	lw	a0,40(s4)
    800036d8:	fffff097          	auipc	ra,0xfffff
    800036dc:	cce080e7          	jalr	-818(ra) # 800023a6 <bread>
    800036e0:	89aa                	mv	s3,a0
        memmove(to->data, from->data, BSIZE);
    800036e2:	40000613          	li	a2,1024
    800036e6:	05850593          	addi	a1,a0,88
    800036ea:	05848513          	addi	a0,s1,88
    800036ee:	ffffd097          	auipc	ra,0xffffd
    800036f2:	b32080e7          	jalr	-1230(ra) # 80000220 <memmove>
        bwrite(to); // write the log
    800036f6:	8526                	mv	a0,s1
    800036f8:	fffff097          	auipc	ra,0xfffff
    800036fc:	da0080e7          	jalr	-608(ra) # 80002498 <bwrite>
        brelse(from);
    80003700:	854e                	mv	a0,s3
    80003702:	fffff097          	auipc	ra,0xfffff
    80003706:	dd4080e7          	jalr	-556(ra) # 800024d6 <brelse>
        brelse(to);
    8000370a:	8526                	mv	a0,s1
    8000370c:	fffff097          	auipc	ra,0xfffff
    80003710:	dca080e7          	jalr	-566(ra) # 800024d6 <brelse>
    for (tail = 0; tail < log.lh.n; tail++) {
    80003714:	2905                	addiw	s2,s2,1
    80003716:	0a91                	addi	s5,s5,4
    80003718:	02ca2783          	lw	a5,44(s4)
    8000371c:	f8f94ee3          	blt	s2,a5,800036b8 <end_op+0xcc>
        write_log();      // Write modified blocks from cache to log
        write_head();     // Write header to disk -- the real commit
    80003720:	00000097          	auipc	ra,0x0
    80003724:	c8c080e7          	jalr	-884(ra) # 800033ac <write_head>
        install_trans(0); // Now install writes to home locations
    80003728:	4501                	li	a0,0
    8000372a:	00000097          	auipc	ra,0x0
    8000372e:	cec080e7          	jalr	-788(ra) # 80003416 <install_trans>
        log.lh.n = 0;
    80003732:	00019797          	auipc	a5,0x19
    80003736:	b007ad23          	sw	zero,-1254(a5) # 8001c24c <log+0x2c>
        write_head(); // Erase the transaction from the log
    8000373a:	00000097          	auipc	ra,0x0
    8000373e:	c72080e7          	jalr	-910(ra) # 800033ac <write_head>
    80003742:	69e2                	ld	s3,24(sp)
    80003744:	6a42                	ld	s4,16(sp)
    80003746:	6aa2                	ld	s5,8(sp)
    80003748:	bdc5                	j	80003638 <end_op+0x4c>

000000008000374a <log_write>:
// log_write() replaces bwrite(); a typical use is:
//   bp = bread(...)
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void log_write(struct buf *b) {
    8000374a:	1101                	addi	sp,sp,-32
    8000374c:	ec06                	sd	ra,24(sp)
    8000374e:	e822                	sd	s0,16(sp)
    80003750:	e426                	sd	s1,8(sp)
    80003752:	e04a                	sd	s2,0(sp)
    80003754:	1000                	addi	s0,sp,32
    80003756:	84aa                	mv	s1,a0
    int i;

    acquire(&log.lock);
    80003758:	00019917          	auipc	s2,0x19
    8000375c:	ac890913          	addi	s2,s2,-1336 # 8001c220 <log>
    80003760:	854a                	mv	a0,s2
    80003762:	00003097          	auipc	ra,0x3
    80003766:	baa080e7          	jalr	-1110(ra) # 8000630c <acquire>
    if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    8000376a:	02c92603          	lw	a2,44(s2)
    8000376e:	47f5                	li	a5,29
    80003770:	06c7c563          	blt	a5,a2,800037da <log_write+0x90>
    80003774:	00019797          	auipc	a5,0x19
    80003778:	ac87a783          	lw	a5,-1336(a5) # 8001c23c <log+0x1c>
    8000377c:	37fd                	addiw	a5,a5,-1
    8000377e:	04f65e63          	bge	a2,a5,800037da <log_write+0x90>
        panic("too big a transaction");
    if (log.outstanding < 1)
    80003782:	00019797          	auipc	a5,0x19
    80003786:	abe7a783          	lw	a5,-1346(a5) # 8001c240 <log+0x20>
    8000378a:	06f05063          	blez	a5,800037ea <log_write+0xa0>
        panic("log_write outside of trans");

    for (i = 0; i < log.lh.n; i++) {
    8000378e:	4781                	li	a5,0
    80003790:	06c05563          	blez	a2,800037fa <log_write+0xb0>
        if (log.lh.block[i] == b->blockno) // log absorption
    80003794:	44cc                	lw	a1,12(s1)
    80003796:	00019717          	auipc	a4,0x19
    8000379a:	aba70713          	addi	a4,a4,-1350 # 8001c250 <log+0x30>
    for (i = 0; i < log.lh.n; i++) {
    8000379e:	4781                	li	a5,0
        if (log.lh.block[i] == b->blockno) // log absorption
    800037a0:	4314                	lw	a3,0(a4)
    800037a2:	04b68c63          	beq	a3,a1,800037fa <log_write+0xb0>
    for (i = 0; i < log.lh.n; i++) {
    800037a6:	2785                	addiw	a5,a5,1
    800037a8:	0711                	addi	a4,a4,4
    800037aa:	fef61be3          	bne	a2,a5,800037a0 <log_write+0x56>
            break;
    }
    log.lh.block[i] = b->blockno;
    800037ae:	0621                	addi	a2,a2,8
    800037b0:	060a                	slli	a2,a2,0x2
    800037b2:	00019797          	auipc	a5,0x19
    800037b6:	a6e78793          	addi	a5,a5,-1426 # 8001c220 <log>
    800037ba:	97b2                	add	a5,a5,a2
    800037bc:	44d8                	lw	a4,12(s1)
    800037be:	cb98                	sw	a4,16(a5)
    if (i == log.lh.n) { // Add new block to log?
        bpin(b);
    800037c0:	8526                	mv	a0,s1
    800037c2:	fffff097          	auipc	ra,0xfffff
    800037c6:	db0080e7          	jalr	-592(ra) # 80002572 <bpin>
        log.lh.n++;
    800037ca:	00019717          	auipc	a4,0x19
    800037ce:	a5670713          	addi	a4,a4,-1450 # 8001c220 <log>
    800037d2:	575c                	lw	a5,44(a4)
    800037d4:	2785                	addiw	a5,a5,1
    800037d6:	d75c                	sw	a5,44(a4)
    800037d8:	a82d                	j	80003812 <log_write+0xc8>
        panic("too big a transaction");
    800037da:	00005517          	auipc	a0,0x5
    800037de:	dae50513          	addi	a0,a0,-594 # 80008588 <etext+0x588>
    800037e2:	00002097          	auipc	ra,0x2
    800037e6:	5b0080e7          	jalr	1456(ra) # 80005d92 <panic>
        panic("log_write outside of trans");
    800037ea:	00005517          	auipc	a0,0x5
    800037ee:	db650513          	addi	a0,a0,-586 # 800085a0 <etext+0x5a0>
    800037f2:	00002097          	auipc	ra,0x2
    800037f6:	5a0080e7          	jalr	1440(ra) # 80005d92 <panic>
    log.lh.block[i] = b->blockno;
    800037fa:	00878693          	addi	a3,a5,8
    800037fe:	068a                	slli	a3,a3,0x2
    80003800:	00019717          	auipc	a4,0x19
    80003804:	a2070713          	addi	a4,a4,-1504 # 8001c220 <log>
    80003808:	9736                	add	a4,a4,a3
    8000380a:	44d4                	lw	a3,12(s1)
    8000380c:	cb14                	sw	a3,16(a4)
    if (i == log.lh.n) { // Add new block to log?
    8000380e:	faf609e3          	beq	a2,a5,800037c0 <log_write+0x76>
    }
    release(&log.lock);
    80003812:	00019517          	auipc	a0,0x19
    80003816:	a0e50513          	addi	a0,a0,-1522 # 8001c220 <log>
    8000381a:	00003097          	auipc	ra,0x3
    8000381e:	ba6080e7          	jalr	-1114(ra) # 800063c0 <release>
}
    80003822:	60e2                	ld	ra,24(sp)
    80003824:	6442                	ld	s0,16(sp)
    80003826:	64a2                	ld	s1,8(sp)
    80003828:	6902                	ld	s2,0(sp)
    8000382a:	6105                	addi	sp,sp,32
    8000382c:	8082                	ret

000000008000382e <initsleeplock>:
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"
#include "sleeplock.h"

void initsleeplock(struct sleeplock *lk, char *name) {
    8000382e:	1101                	addi	sp,sp,-32
    80003830:	ec06                	sd	ra,24(sp)
    80003832:	e822                	sd	s0,16(sp)
    80003834:	e426                	sd	s1,8(sp)
    80003836:	e04a                	sd	s2,0(sp)
    80003838:	1000                	addi	s0,sp,32
    8000383a:	84aa                	mv	s1,a0
    8000383c:	892e                	mv	s2,a1
    initlock(&lk->lk, "sleep lock");
    8000383e:	00005597          	auipc	a1,0x5
    80003842:	d8258593          	addi	a1,a1,-638 # 800085c0 <etext+0x5c0>
    80003846:	0521                	addi	a0,a0,8
    80003848:	00003097          	auipc	ra,0x3
    8000384c:	a34080e7          	jalr	-1484(ra) # 8000627c <initlock>
    lk->name = name;
    80003850:	0324b023          	sd	s2,32(s1)
    lk->locked = 0;
    80003854:	0004a023          	sw	zero,0(s1)
    lk->pid = 0;
    80003858:	0204a423          	sw	zero,40(s1)
}
    8000385c:	60e2                	ld	ra,24(sp)
    8000385e:	6442                	ld	s0,16(sp)
    80003860:	64a2                	ld	s1,8(sp)
    80003862:	6902                	ld	s2,0(sp)
    80003864:	6105                	addi	sp,sp,32
    80003866:	8082                	ret

0000000080003868 <acquiresleep>:

void acquiresleep(struct sleeplock *lk) {
    80003868:	1101                	addi	sp,sp,-32
    8000386a:	ec06                	sd	ra,24(sp)
    8000386c:	e822                	sd	s0,16(sp)
    8000386e:	e426                	sd	s1,8(sp)
    80003870:	e04a                	sd	s2,0(sp)
    80003872:	1000                	addi	s0,sp,32
    80003874:	84aa                	mv	s1,a0
    acquire(&lk->lk);
    80003876:	00850913          	addi	s2,a0,8
    8000387a:	854a                	mv	a0,s2
    8000387c:	00003097          	auipc	ra,0x3
    80003880:	a90080e7          	jalr	-1392(ra) # 8000630c <acquire>
    while (lk->locked) {
    80003884:	409c                	lw	a5,0(s1)
    80003886:	cb89                	beqz	a5,80003898 <acquiresleep+0x30>
        sleep(lk, &lk->lk);
    80003888:	85ca                	mv	a1,s2
    8000388a:	8526                	mv	a0,s1
    8000388c:	ffffe097          	auipc	ra,0xffffe
    80003890:	d0c080e7          	jalr	-756(ra) # 80001598 <sleep>
    while (lk->locked) {
    80003894:	409c                	lw	a5,0(s1)
    80003896:	fbed                	bnez	a5,80003888 <acquiresleep+0x20>
    }
    lk->locked = 1;
    80003898:	4785                	li	a5,1
    8000389a:	c09c                	sw	a5,0(s1)
    lk->pid = myproc()->pid;
    8000389c:	ffffd097          	auipc	ra,0xffffd
    800038a0:	62a080e7          	jalr	1578(ra) # 80000ec6 <myproc>
    800038a4:	591c                	lw	a5,48(a0)
    800038a6:	d49c                	sw	a5,40(s1)
    release(&lk->lk);
    800038a8:	854a                	mv	a0,s2
    800038aa:	00003097          	auipc	ra,0x3
    800038ae:	b16080e7          	jalr	-1258(ra) # 800063c0 <release>
}
    800038b2:	60e2                	ld	ra,24(sp)
    800038b4:	6442                	ld	s0,16(sp)
    800038b6:	64a2                	ld	s1,8(sp)
    800038b8:	6902                	ld	s2,0(sp)
    800038ba:	6105                	addi	sp,sp,32
    800038bc:	8082                	ret

00000000800038be <releasesleep>:

void releasesleep(struct sleeplock *lk) {
    800038be:	1101                	addi	sp,sp,-32
    800038c0:	ec06                	sd	ra,24(sp)
    800038c2:	e822                	sd	s0,16(sp)
    800038c4:	e426                	sd	s1,8(sp)
    800038c6:	e04a                	sd	s2,0(sp)
    800038c8:	1000                	addi	s0,sp,32
    800038ca:	84aa                	mv	s1,a0
    acquire(&lk->lk);
    800038cc:	00850913          	addi	s2,a0,8
    800038d0:	854a                	mv	a0,s2
    800038d2:	00003097          	auipc	ra,0x3
    800038d6:	a3a080e7          	jalr	-1478(ra) # 8000630c <acquire>
    lk->locked = 0;
    800038da:	0004a023          	sw	zero,0(s1)
    lk->pid = 0;
    800038de:	0204a423          	sw	zero,40(s1)
    wakeup(lk);
    800038e2:	8526                	mv	a0,s1
    800038e4:	ffffe097          	auipc	ra,0xffffe
    800038e8:	e40080e7          	jalr	-448(ra) # 80001724 <wakeup>
    release(&lk->lk);
    800038ec:	854a                	mv	a0,s2
    800038ee:	00003097          	auipc	ra,0x3
    800038f2:	ad2080e7          	jalr	-1326(ra) # 800063c0 <release>
}
    800038f6:	60e2                	ld	ra,24(sp)
    800038f8:	6442                	ld	s0,16(sp)
    800038fa:	64a2                	ld	s1,8(sp)
    800038fc:	6902                	ld	s2,0(sp)
    800038fe:	6105                	addi	sp,sp,32
    80003900:	8082                	ret

0000000080003902 <holdingsleep>:

int holdingsleep(struct sleeplock *lk) {
    80003902:	7179                	addi	sp,sp,-48
    80003904:	f406                	sd	ra,40(sp)
    80003906:	f022                	sd	s0,32(sp)
    80003908:	ec26                	sd	s1,24(sp)
    8000390a:	e84a                	sd	s2,16(sp)
    8000390c:	1800                	addi	s0,sp,48
    8000390e:	84aa                	mv	s1,a0
    int r;

    acquire(&lk->lk);
    80003910:	00850913          	addi	s2,a0,8
    80003914:	854a                	mv	a0,s2
    80003916:	00003097          	auipc	ra,0x3
    8000391a:	9f6080e7          	jalr	-1546(ra) # 8000630c <acquire>
    r = lk->locked && (lk->pid == myproc()->pid);
    8000391e:	409c                	lw	a5,0(s1)
    80003920:	ef91                	bnez	a5,8000393c <holdingsleep+0x3a>
    80003922:	4481                	li	s1,0
    release(&lk->lk);
    80003924:	854a                	mv	a0,s2
    80003926:	00003097          	auipc	ra,0x3
    8000392a:	a9a080e7          	jalr	-1382(ra) # 800063c0 <release>
    return r;
}
    8000392e:	8526                	mv	a0,s1
    80003930:	70a2                	ld	ra,40(sp)
    80003932:	7402                	ld	s0,32(sp)
    80003934:	64e2                	ld	s1,24(sp)
    80003936:	6942                	ld	s2,16(sp)
    80003938:	6145                	addi	sp,sp,48
    8000393a:	8082                	ret
    8000393c:	e44e                	sd	s3,8(sp)
    r = lk->locked && (lk->pid == myproc()->pid);
    8000393e:	0284a983          	lw	s3,40(s1)
    80003942:	ffffd097          	auipc	ra,0xffffd
    80003946:	584080e7          	jalr	1412(ra) # 80000ec6 <myproc>
    8000394a:	5904                	lw	s1,48(a0)
    8000394c:	413484b3          	sub	s1,s1,s3
    80003950:	0014b493          	seqz	s1,s1
    80003954:	69a2                	ld	s3,8(sp)
    80003956:	b7f9                	j	80003924 <holdingsleep+0x22>

0000000080003958 <fileinit>:
struct {
    struct spinlock lock;
    struct file file[NFILE];
} ftable;

void fileinit(void) { initlock(&ftable.lock, "ftable"); }
    80003958:	1141                	addi	sp,sp,-16
    8000395a:	e406                	sd	ra,8(sp)
    8000395c:	e022                	sd	s0,0(sp)
    8000395e:	0800                	addi	s0,sp,16
    80003960:	00005597          	auipc	a1,0x5
    80003964:	c7058593          	addi	a1,a1,-912 # 800085d0 <etext+0x5d0>
    80003968:	00019517          	auipc	a0,0x19
    8000396c:	a0050513          	addi	a0,a0,-1536 # 8001c368 <ftable>
    80003970:	00003097          	auipc	ra,0x3
    80003974:	90c080e7          	jalr	-1780(ra) # 8000627c <initlock>
    80003978:	60a2                	ld	ra,8(sp)
    8000397a:	6402                	ld	s0,0(sp)
    8000397c:	0141                	addi	sp,sp,16
    8000397e:	8082                	ret

0000000080003980 <filealloc>:

// Allocate a file structure.
struct file *filealloc(void) {
    80003980:	1101                	addi	sp,sp,-32
    80003982:	ec06                	sd	ra,24(sp)
    80003984:	e822                	sd	s0,16(sp)
    80003986:	e426                	sd	s1,8(sp)
    80003988:	1000                	addi	s0,sp,32
    struct file *f;

    acquire(&ftable.lock);
    8000398a:	00019517          	auipc	a0,0x19
    8000398e:	9de50513          	addi	a0,a0,-1570 # 8001c368 <ftable>
    80003992:	00003097          	auipc	ra,0x3
    80003996:	97a080e7          	jalr	-1670(ra) # 8000630c <acquire>
    for (f = ftable.file; f < ftable.file + NFILE; f++) {
    8000399a:	00019497          	auipc	s1,0x19
    8000399e:	9e648493          	addi	s1,s1,-1562 # 8001c380 <ftable+0x18>
    800039a2:	0001a717          	auipc	a4,0x1a
    800039a6:	97e70713          	addi	a4,a4,-1666 # 8001d320 <ftable+0xfb8>
        if (f->ref == 0) {
    800039aa:	40dc                	lw	a5,4(s1)
    800039ac:	cf99                	beqz	a5,800039ca <filealloc+0x4a>
    for (f = ftable.file; f < ftable.file + NFILE; f++) {
    800039ae:	02848493          	addi	s1,s1,40
    800039b2:	fee49ce3          	bne	s1,a4,800039aa <filealloc+0x2a>
            f->ref = 1;
            release(&ftable.lock);
            return f;
        }
    }
    release(&ftable.lock);
    800039b6:	00019517          	auipc	a0,0x19
    800039ba:	9b250513          	addi	a0,a0,-1614 # 8001c368 <ftable>
    800039be:	00003097          	auipc	ra,0x3
    800039c2:	a02080e7          	jalr	-1534(ra) # 800063c0 <release>
    return 0;
    800039c6:	4481                	li	s1,0
    800039c8:	a819                	j	800039de <filealloc+0x5e>
            f->ref = 1;
    800039ca:	4785                	li	a5,1
    800039cc:	c0dc                	sw	a5,4(s1)
            release(&ftable.lock);
    800039ce:	00019517          	auipc	a0,0x19
    800039d2:	99a50513          	addi	a0,a0,-1638 # 8001c368 <ftable>
    800039d6:	00003097          	auipc	ra,0x3
    800039da:	9ea080e7          	jalr	-1558(ra) # 800063c0 <release>
}
    800039de:	8526                	mv	a0,s1
    800039e0:	60e2                	ld	ra,24(sp)
    800039e2:	6442                	ld	s0,16(sp)
    800039e4:	64a2                	ld	s1,8(sp)
    800039e6:	6105                	addi	sp,sp,32
    800039e8:	8082                	ret

00000000800039ea <filedup>:

// Increment ref count for file f.
struct file *filedup(struct file *f) {
    800039ea:	1101                	addi	sp,sp,-32
    800039ec:	ec06                	sd	ra,24(sp)
    800039ee:	e822                	sd	s0,16(sp)
    800039f0:	e426                	sd	s1,8(sp)
    800039f2:	1000                	addi	s0,sp,32
    800039f4:	84aa                	mv	s1,a0
    acquire(&ftable.lock);
    800039f6:	00019517          	auipc	a0,0x19
    800039fa:	97250513          	addi	a0,a0,-1678 # 8001c368 <ftable>
    800039fe:	00003097          	auipc	ra,0x3
    80003a02:	90e080e7          	jalr	-1778(ra) # 8000630c <acquire>
    if (f->ref < 1)
    80003a06:	40dc                	lw	a5,4(s1)
    80003a08:	02f05263          	blez	a5,80003a2c <filedup+0x42>
        panic("filedup");
    f->ref++;
    80003a0c:	2785                	addiw	a5,a5,1
    80003a0e:	c0dc                	sw	a5,4(s1)
    release(&ftable.lock);
    80003a10:	00019517          	auipc	a0,0x19
    80003a14:	95850513          	addi	a0,a0,-1704 # 8001c368 <ftable>
    80003a18:	00003097          	auipc	ra,0x3
    80003a1c:	9a8080e7          	jalr	-1624(ra) # 800063c0 <release>
    return f;
}
    80003a20:	8526                	mv	a0,s1
    80003a22:	60e2                	ld	ra,24(sp)
    80003a24:	6442                	ld	s0,16(sp)
    80003a26:	64a2                	ld	s1,8(sp)
    80003a28:	6105                	addi	sp,sp,32
    80003a2a:	8082                	ret
        panic("filedup");
    80003a2c:	00005517          	auipc	a0,0x5
    80003a30:	bac50513          	addi	a0,a0,-1108 # 800085d8 <etext+0x5d8>
    80003a34:	00002097          	auipc	ra,0x2
    80003a38:	35e080e7          	jalr	862(ra) # 80005d92 <panic>

0000000080003a3c <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void fileclose(struct file *f) {
    80003a3c:	7139                	addi	sp,sp,-64
    80003a3e:	fc06                	sd	ra,56(sp)
    80003a40:	f822                	sd	s0,48(sp)
    80003a42:	f426                	sd	s1,40(sp)
    80003a44:	0080                	addi	s0,sp,64
    80003a46:	84aa                	mv	s1,a0
    struct file ff;

    acquire(&ftable.lock);
    80003a48:	00019517          	auipc	a0,0x19
    80003a4c:	92050513          	addi	a0,a0,-1760 # 8001c368 <ftable>
    80003a50:	00003097          	auipc	ra,0x3
    80003a54:	8bc080e7          	jalr	-1860(ra) # 8000630c <acquire>
    if (f->ref < 1)
    80003a58:	40dc                	lw	a5,4(s1)
    80003a5a:	04f05c63          	blez	a5,80003ab2 <fileclose+0x76>
        panic("fileclose");
    if (--f->ref > 0) {
    80003a5e:	37fd                	addiw	a5,a5,-1
    80003a60:	0007871b          	sext.w	a4,a5
    80003a64:	c0dc                	sw	a5,4(s1)
    80003a66:	06e04263          	bgtz	a4,80003aca <fileclose+0x8e>
    80003a6a:	f04a                	sd	s2,32(sp)
    80003a6c:	ec4e                	sd	s3,24(sp)
    80003a6e:	e852                	sd	s4,16(sp)
    80003a70:	e456                	sd	s5,8(sp)
        release(&ftable.lock);
        return;
    }
    ff = *f;
    80003a72:	0004a903          	lw	s2,0(s1)
    80003a76:	0094ca83          	lbu	s5,9(s1)
    80003a7a:	0104ba03          	ld	s4,16(s1)
    80003a7e:	0184b983          	ld	s3,24(s1)
    f->ref = 0;
    80003a82:	0004a223          	sw	zero,4(s1)
    f->type = FD_NONE;
    80003a86:	0004a023          	sw	zero,0(s1)
    release(&ftable.lock);
    80003a8a:	00019517          	auipc	a0,0x19
    80003a8e:	8de50513          	addi	a0,a0,-1826 # 8001c368 <ftable>
    80003a92:	00003097          	auipc	ra,0x3
    80003a96:	92e080e7          	jalr	-1746(ra) # 800063c0 <release>

    if (ff.type == FD_PIPE) {
    80003a9a:	4785                	li	a5,1
    80003a9c:	04f90463          	beq	s2,a5,80003ae4 <fileclose+0xa8>
        pipeclose(ff.pipe, ff.writable);
    } else if (ff.type == FD_INODE || ff.type == FD_DEVICE) {
    80003aa0:	3979                	addiw	s2,s2,-2
    80003aa2:	4785                	li	a5,1
    80003aa4:	0527fb63          	bgeu	a5,s2,80003afa <fileclose+0xbe>
    80003aa8:	7902                	ld	s2,32(sp)
    80003aaa:	69e2                	ld	s3,24(sp)
    80003aac:	6a42                	ld	s4,16(sp)
    80003aae:	6aa2                	ld	s5,8(sp)
    80003ab0:	a02d                	j	80003ada <fileclose+0x9e>
    80003ab2:	f04a                	sd	s2,32(sp)
    80003ab4:	ec4e                	sd	s3,24(sp)
    80003ab6:	e852                	sd	s4,16(sp)
    80003ab8:	e456                	sd	s5,8(sp)
        panic("fileclose");
    80003aba:	00005517          	auipc	a0,0x5
    80003abe:	b2650513          	addi	a0,a0,-1242 # 800085e0 <etext+0x5e0>
    80003ac2:	00002097          	auipc	ra,0x2
    80003ac6:	2d0080e7          	jalr	720(ra) # 80005d92 <panic>
        release(&ftable.lock);
    80003aca:	00019517          	auipc	a0,0x19
    80003ace:	89e50513          	addi	a0,a0,-1890 # 8001c368 <ftable>
    80003ad2:	00003097          	auipc	ra,0x3
    80003ad6:	8ee080e7          	jalr	-1810(ra) # 800063c0 <release>
        begin_op();
        iput(ff.ip);
        end_op();
    }
}
    80003ada:	70e2                	ld	ra,56(sp)
    80003adc:	7442                	ld	s0,48(sp)
    80003ade:	74a2                	ld	s1,40(sp)
    80003ae0:	6121                	addi	sp,sp,64
    80003ae2:	8082                	ret
        pipeclose(ff.pipe, ff.writable);
    80003ae4:	85d6                	mv	a1,s5
    80003ae6:	8552                	mv	a0,s4
    80003ae8:	00000097          	auipc	ra,0x0
    80003aec:	3a2080e7          	jalr	930(ra) # 80003e8a <pipeclose>
    80003af0:	7902                	ld	s2,32(sp)
    80003af2:	69e2                	ld	s3,24(sp)
    80003af4:	6a42                	ld	s4,16(sp)
    80003af6:	6aa2                	ld	s5,8(sp)
    80003af8:	b7cd                	j	80003ada <fileclose+0x9e>
        begin_op();
    80003afa:	00000097          	auipc	ra,0x0
    80003afe:	a78080e7          	jalr	-1416(ra) # 80003572 <begin_op>
        iput(ff.ip);
    80003b02:	854e                	mv	a0,s3
    80003b04:	fffff097          	auipc	ra,0xfffff
    80003b08:	25a080e7          	jalr	602(ra) # 80002d5e <iput>
        end_op();
    80003b0c:	00000097          	auipc	ra,0x0
    80003b10:	ae0080e7          	jalr	-1312(ra) # 800035ec <end_op>
    80003b14:	7902                	ld	s2,32(sp)
    80003b16:	69e2                	ld	s3,24(sp)
    80003b18:	6a42                	ld	s4,16(sp)
    80003b1a:	6aa2                	ld	s5,8(sp)
    80003b1c:	bf7d                	j	80003ada <fileclose+0x9e>

0000000080003b1e <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int filestat(struct file *f, uint64 addr) {
    80003b1e:	715d                	addi	sp,sp,-80
    80003b20:	e486                	sd	ra,72(sp)
    80003b22:	e0a2                	sd	s0,64(sp)
    80003b24:	fc26                	sd	s1,56(sp)
    80003b26:	f44e                	sd	s3,40(sp)
    80003b28:	0880                	addi	s0,sp,80
    80003b2a:	84aa                	mv	s1,a0
    80003b2c:	89ae                	mv	s3,a1
    struct proc *p = myproc();
    80003b2e:	ffffd097          	auipc	ra,0xffffd
    80003b32:	398080e7          	jalr	920(ra) # 80000ec6 <myproc>
    struct stat st;

    if (f->type == FD_INODE || f->type == FD_DEVICE) {
    80003b36:	409c                	lw	a5,0(s1)
    80003b38:	37f9                	addiw	a5,a5,-2
    80003b3a:	4705                	li	a4,1
    80003b3c:	04f76863          	bltu	a4,a5,80003b8c <filestat+0x6e>
    80003b40:	f84a                	sd	s2,48(sp)
    80003b42:	892a                	mv	s2,a0
        ilock(f->ip);
    80003b44:	6c88                	ld	a0,24(s1)
    80003b46:	fffff097          	auipc	ra,0xfffff
    80003b4a:	05a080e7          	jalr	90(ra) # 80002ba0 <ilock>
        stati(f->ip, &st);
    80003b4e:	fb840593          	addi	a1,s0,-72
    80003b52:	6c88                	ld	a0,24(s1)
    80003b54:	fffff097          	auipc	ra,0xfffff
    80003b58:	2da080e7          	jalr	730(ra) # 80002e2e <stati>
        iunlock(f->ip);
    80003b5c:	6c88                	ld	a0,24(s1)
    80003b5e:	fffff097          	auipc	ra,0xfffff
    80003b62:	108080e7          	jalr	264(ra) # 80002c66 <iunlock>
        if (copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003b66:	46e1                	li	a3,24
    80003b68:	fb840613          	addi	a2,s0,-72
    80003b6c:	85ce                	mv	a1,s3
    80003b6e:	05093503          	ld	a0,80(s2)
    80003b72:	ffffd097          	auipc	ra,0xffffd
    80003b76:	ff0080e7          	jalr	-16(ra) # 80000b62 <copyout>
    80003b7a:	41f5551b          	sraiw	a0,a0,0x1f
    80003b7e:	7942                	ld	s2,48(sp)
            return -1;
        return 0;
    }
    return -1;
}
    80003b80:	60a6                	ld	ra,72(sp)
    80003b82:	6406                	ld	s0,64(sp)
    80003b84:	74e2                	ld	s1,56(sp)
    80003b86:	79a2                	ld	s3,40(sp)
    80003b88:	6161                	addi	sp,sp,80
    80003b8a:	8082                	ret
    return -1;
    80003b8c:	557d                	li	a0,-1
    80003b8e:	bfcd                	j	80003b80 <filestat+0x62>

0000000080003b90 <fileread>:

// Read from file f.
// addr is a user virtual address.
int fileread(struct file *f, uint64 addr, int n) {
    80003b90:	7179                	addi	sp,sp,-48
    80003b92:	f406                	sd	ra,40(sp)
    80003b94:	f022                	sd	s0,32(sp)
    80003b96:	e84a                	sd	s2,16(sp)
    80003b98:	1800                	addi	s0,sp,48
    int r = 0;

    if (f->readable == 0)
    80003b9a:	00854783          	lbu	a5,8(a0)
    80003b9e:	cbc5                	beqz	a5,80003c4e <fileread+0xbe>
    80003ba0:	ec26                	sd	s1,24(sp)
    80003ba2:	e44e                	sd	s3,8(sp)
    80003ba4:	84aa                	mv	s1,a0
    80003ba6:	89ae                	mv	s3,a1
    80003ba8:	8932                	mv	s2,a2
        return -1;

    if (f->type == FD_PIPE) {
    80003baa:	411c                	lw	a5,0(a0)
    80003bac:	4705                	li	a4,1
    80003bae:	04e78963          	beq	a5,a4,80003c00 <fileread+0x70>
        r = piperead(f->pipe, addr, n);
    } else if (f->type == FD_DEVICE) {
    80003bb2:	470d                	li	a4,3
    80003bb4:	04e78f63          	beq	a5,a4,80003c12 <fileread+0x82>
        if (f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
            return -1;
        r = devsw[f->major].read(1, addr, n);
    } else if (f->type == FD_INODE) {
    80003bb8:	4709                	li	a4,2
    80003bba:	08e79263          	bne	a5,a4,80003c3e <fileread+0xae>
        ilock(f->ip);
    80003bbe:	6d08                	ld	a0,24(a0)
    80003bc0:	fffff097          	auipc	ra,0xfffff
    80003bc4:	fe0080e7          	jalr	-32(ra) # 80002ba0 <ilock>
        if ((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003bc8:	874a                	mv	a4,s2
    80003bca:	5094                	lw	a3,32(s1)
    80003bcc:	864e                	mv	a2,s3
    80003bce:	4585                	li	a1,1
    80003bd0:	6c88                	ld	a0,24(s1)
    80003bd2:	fffff097          	auipc	ra,0xfffff
    80003bd6:	286080e7          	jalr	646(ra) # 80002e58 <readi>
    80003bda:	892a                	mv	s2,a0
    80003bdc:	00a05563          	blez	a0,80003be6 <fileread+0x56>
            f->off += r;
    80003be0:	509c                	lw	a5,32(s1)
    80003be2:	9fa9                	addw	a5,a5,a0
    80003be4:	d09c                	sw	a5,32(s1)
        iunlock(f->ip);
    80003be6:	6c88                	ld	a0,24(s1)
    80003be8:	fffff097          	auipc	ra,0xfffff
    80003bec:	07e080e7          	jalr	126(ra) # 80002c66 <iunlock>
    80003bf0:	64e2                	ld	s1,24(sp)
    80003bf2:	69a2                	ld	s3,8(sp)
    } else {
        panic("fileread");
    }

    return r;
}
    80003bf4:	854a                	mv	a0,s2
    80003bf6:	70a2                	ld	ra,40(sp)
    80003bf8:	7402                	ld	s0,32(sp)
    80003bfa:	6942                	ld	s2,16(sp)
    80003bfc:	6145                	addi	sp,sp,48
    80003bfe:	8082                	ret
        r = piperead(f->pipe, addr, n);
    80003c00:	6908                	ld	a0,16(a0)
    80003c02:	00000097          	auipc	ra,0x0
    80003c06:	3fa080e7          	jalr	1018(ra) # 80003ffc <piperead>
    80003c0a:	892a                	mv	s2,a0
    80003c0c:	64e2                	ld	s1,24(sp)
    80003c0e:	69a2                	ld	s3,8(sp)
    80003c10:	b7d5                	j	80003bf4 <fileread+0x64>
        if (f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003c12:	02451783          	lh	a5,36(a0)
    80003c16:	03079693          	slli	a3,a5,0x30
    80003c1a:	92c1                	srli	a3,a3,0x30
    80003c1c:	4725                	li	a4,9
    80003c1e:	02d76a63          	bltu	a4,a3,80003c52 <fileread+0xc2>
    80003c22:	0792                	slli	a5,a5,0x4
    80003c24:	00018717          	auipc	a4,0x18
    80003c28:	6a470713          	addi	a4,a4,1700 # 8001c2c8 <devsw>
    80003c2c:	97ba                	add	a5,a5,a4
    80003c2e:	639c                	ld	a5,0(a5)
    80003c30:	c78d                	beqz	a5,80003c5a <fileread+0xca>
        r = devsw[f->major].read(1, addr, n);
    80003c32:	4505                	li	a0,1
    80003c34:	9782                	jalr	a5
    80003c36:	892a                	mv	s2,a0
    80003c38:	64e2                	ld	s1,24(sp)
    80003c3a:	69a2                	ld	s3,8(sp)
    80003c3c:	bf65                	j	80003bf4 <fileread+0x64>
        panic("fileread");
    80003c3e:	00005517          	auipc	a0,0x5
    80003c42:	9b250513          	addi	a0,a0,-1614 # 800085f0 <etext+0x5f0>
    80003c46:	00002097          	auipc	ra,0x2
    80003c4a:	14c080e7          	jalr	332(ra) # 80005d92 <panic>
        return -1;
    80003c4e:	597d                	li	s2,-1
    80003c50:	b755                	j	80003bf4 <fileread+0x64>
            return -1;
    80003c52:	597d                	li	s2,-1
    80003c54:	64e2                	ld	s1,24(sp)
    80003c56:	69a2                	ld	s3,8(sp)
    80003c58:	bf71                	j	80003bf4 <fileread+0x64>
    80003c5a:	597d                	li	s2,-1
    80003c5c:	64e2                	ld	s1,24(sp)
    80003c5e:	69a2                	ld	s3,8(sp)
    80003c60:	bf51                	j	80003bf4 <fileread+0x64>

0000000080003c62 <filewrite>:
// Write to file f.
// addr is a user virtual address.
int filewrite(struct file *f, uint64 addr, int n) {
    int r, ret = 0;

    if (f->writable == 0)
    80003c62:	00954783          	lbu	a5,9(a0)
    80003c66:	12078963          	beqz	a5,80003d98 <filewrite+0x136>
int filewrite(struct file *f, uint64 addr, int n) {
    80003c6a:	715d                	addi	sp,sp,-80
    80003c6c:	e486                	sd	ra,72(sp)
    80003c6e:	e0a2                	sd	s0,64(sp)
    80003c70:	f84a                	sd	s2,48(sp)
    80003c72:	f052                	sd	s4,32(sp)
    80003c74:	e85a                	sd	s6,16(sp)
    80003c76:	0880                	addi	s0,sp,80
    80003c78:	892a                	mv	s2,a0
    80003c7a:	8b2e                	mv	s6,a1
    80003c7c:	8a32                	mv	s4,a2
        return -1;

    if (f->type == FD_PIPE) {
    80003c7e:	411c                	lw	a5,0(a0)
    80003c80:	4705                	li	a4,1
    80003c82:	02e78763          	beq	a5,a4,80003cb0 <filewrite+0x4e>
        ret = pipewrite(f->pipe, addr, n);
    } else if (f->type == FD_DEVICE) {
    80003c86:	470d                	li	a4,3
    80003c88:	02e78a63          	beq	a5,a4,80003cbc <filewrite+0x5a>
        if (f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
            return -1;
        ret = devsw[f->major].write(1, addr, n);
    } else if (f->type == FD_INODE) {
    80003c8c:	4709                	li	a4,2
    80003c8e:	0ee79863          	bne	a5,a4,80003d7e <filewrite+0x11c>
    80003c92:	f44e                	sd	s3,40(sp)
        // and 2 blocks of slop for non-aligned writes.
        // this really belongs lower down, since writei()
        // might be writing a device like the console.
        int max = ((MAXOPBLOCKS - 1 - 1 - 2) / 2) * BSIZE;
        int i = 0;
        while (i < n) {
    80003c94:	0cc05463          	blez	a2,80003d5c <filewrite+0xfa>
    80003c98:	fc26                	sd	s1,56(sp)
    80003c9a:	ec56                	sd	s5,24(sp)
    80003c9c:	e45e                	sd	s7,8(sp)
    80003c9e:	e062                	sd	s8,0(sp)
        int i = 0;
    80003ca0:	4981                	li	s3,0
            int n1 = n - i;
            if (n1 > max)
    80003ca2:	6b85                	lui	s7,0x1
    80003ca4:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    80003ca8:	6c05                	lui	s8,0x1
    80003caa:	c00c0c1b          	addiw	s8,s8,-1024 # c00 <_entry-0x7ffff400>
    80003cae:	a851                	j	80003d42 <filewrite+0xe0>
        ret = pipewrite(f->pipe, addr, n);
    80003cb0:	6908                	ld	a0,16(a0)
    80003cb2:	00000097          	auipc	ra,0x0
    80003cb6:	248080e7          	jalr	584(ra) # 80003efa <pipewrite>
    80003cba:	a85d                	j	80003d70 <filewrite+0x10e>
        if (f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003cbc:	02451783          	lh	a5,36(a0)
    80003cc0:	03079693          	slli	a3,a5,0x30
    80003cc4:	92c1                	srli	a3,a3,0x30
    80003cc6:	4725                	li	a4,9
    80003cc8:	0cd76a63          	bltu	a4,a3,80003d9c <filewrite+0x13a>
    80003ccc:	0792                	slli	a5,a5,0x4
    80003cce:	00018717          	auipc	a4,0x18
    80003cd2:	5fa70713          	addi	a4,a4,1530 # 8001c2c8 <devsw>
    80003cd6:	97ba                	add	a5,a5,a4
    80003cd8:	679c                	ld	a5,8(a5)
    80003cda:	c3f9                	beqz	a5,80003da0 <filewrite+0x13e>
        ret = devsw[f->major].write(1, addr, n);
    80003cdc:	4505                	li	a0,1
    80003cde:	9782                	jalr	a5
    80003ce0:	a841                	j	80003d70 <filewrite+0x10e>
            if (n1 > max)
    80003ce2:	00048a9b          	sext.w	s5,s1
                n1 = max;

            begin_op();
    80003ce6:	00000097          	auipc	ra,0x0
    80003cea:	88c080e7          	jalr	-1908(ra) # 80003572 <begin_op>
            ilock(f->ip);
    80003cee:	01893503          	ld	a0,24(s2)
    80003cf2:	fffff097          	auipc	ra,0xfffff
    80003cf6:	eae080e7          	jalr	-338(ra) # 80002ba0 <ilock>
            if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003cfa:	8756                	mv	a4,s5
    80003cfc:	02092683          	lw	a3,32(s2)
    80003d00:	01698633          	add	a2,s3,s6
    80003d04:	4585                	li	a1,1
    80003d06:	01893503          	ld	a0,24(s2)
    80003d0a:	fffff097          	auipc	ra,0xfffff
    80003d0e:	252080e7          	jalr	594(ra) # 80002f5c <writei>
    80003d12:	84aa                	mv	s1,a0
    80003d14:	00a05763          	blez	a0,80003d22 <filewrite+0xc0>
                f->off += r;
    80003d18:	02092783          	lw	a5,32(s2)
    80003d1c:	9fa9                	addw	a5,a5,a0
    80003d1e:	02f92023          	sw	a5,32(s2)
            iunlock(f->ip);
    80003d22:	01893503          	ld	a0,24(s2)
    80003d26:	fffff097          	auipc	ra,0xfffff
    80003d2a:	f40080e7          	jalr	-192(ra) # 80002c66 <iunlock>
            end_op();
    80003d2e:	00000097          	auipc	ra,0x0
    80003d32:	8be080e7          	jalr	-1858(ra) # 800035ec <end_op>

            if (r != n1) {
    80003d36:	029a9563          	bne	s5,s1,80003d60 <filewrite+0xfe>
                // error from writei
                break;
            }
            i += r;
    80003d3a:	013489bb          	addw	s3,s1,s3
        while (i < n) {
    80003d3e:	0149da63          	bge	s3,s4,80003d52 <filewrite+0xf0>
            int n1 = n - i;
    80003d42:	413a04bb          	subw	s1,s4,s3
            if (n1 > max)
    80003d46:	0004879b          	sext.w	a5,s1
    80003d4a:	f8fbdce3          	bge	s7,a5,80003ce2 <filewrite+0x80>
    80003d4e:	84e2                	mv	s1,s8
    80003d50:	bf49                	j	80003ce2 <filewrite+0x80>
    80003d52:	74e2                	ld	s1,56(sp)
    80003d54:	6ae2                	ld	s5,24(sp)
    80003d56:	6ba2                	ld	s7,8(sp)
    80003d58:	6c02                	ld	s8,0(sp)
    80003d5a:	a039                	j	80003d68 <filewrite+0x106>
        int i = 0;
    80003d5c:	4981                	li	s3,0
    80003d5e:	a029                	j	80003d68 <filewrite+0x106>
    80003d60:	74e2                	ld	s1,56(sp)
    80003d62:	6ae2                	ld	s5,24(sp)
    80003d64:	6ba2                	ld	s7,8(sp)
    80003d66:	6c02                	ld	s8,0(sp)
        }
        ret = (i == n ? n : -1);
    80003d68:	033a1e63          	bne	s4,s3,80003da4 <filewrite+0x142>
    80003d6c:	8552                	mv	a0,s4
    80003d6e:	79a2                	ld	s3,40(sp)
    } else {
        panic("filewrite");
    }

    return ret;
}
    80003d70:	60a6                	ld	ra,72(sp)
    80003d72:	6406                	ld	s0,64(sp)
    80003d74:	7942                	ld	s2,48(sp)
    80003d76:	7a02                	ld	s4,32(sp)
    80003d78:	6b42                	ld	s6,16(sp)
    80003d7a:	6161                	addi	sp,sp,80
    80003d7c:	8082                	ret
    80003d7e:	fc26                	sd	s1,56(sp)
    80003d80:	f44e                	sd	s3,40(sp)
    80003d82:	ec56                	sd	s5,24(sp)
    80003d84:	e45e                	sd	s7,8(sp)
    80003d86:	e062                	sd	s8,0(sp)
        panic("filewrite");
    80003d88:	00005517          	auipc	a0,0x5
    80003d8c:	87850513          	addi	a0,a0,-1928 # 80008600 <etext+0x600>
    80003d90:	00002097          	auipc	ra,0x2
    80003d94:	002080e7          	jalr	2(ra) # 80005d92 <panic>
        return -1;
    80003d98:	557d                	li	a0,-1
}
    80003d9a:	8082                	ret
            return -1;
    80003d9c:	557d                	li	a0,-1
    80003d9e:	bfc9                	j	80003d70 <filewrite+0x10e>
    80003da0:	557d                	li	a0,-1
    80003da2:	b7f9                	j	80003d70 <filewrite+0x10e>
        ret = (i == n ? n : -1);
    80003da4:	557d                	li	a0,-1
    80003da6:	79a2                	ld	s3,40(sp)
    80003da8:	b7e1                	j	80003d70 <filewrite+0x10e>

0000000080003daa <pipealloc>:
    uint nwrite;   // number of bytes written
    int readopen;  // read fd is still open
    int writeopen; // write fd is still open
};

int pipealloc(struct file **f0, struct file **f1) {
    80003daa:	7179                	addi	sp,sp,-48
    80003dac:	f406                	sd	ra,40(sp)
    80003dae:	f022                	sd	s0,32(sp)
    80003db0:	ec26                	sd	s1,24(sp)
    80003db2:	e052                	sd	s4,0(sp)
    80003db4:	1800                	addi	s0,sp,48
    80003db6:	84aa                	mv	s1,a0
    80003db8:	8a2e                	mv	s4,a1
    struct pipe *pi;

    pi = 0;
    *f0 = *f1 = 0;
    80003dba:	0005b023          	sd	zero,0(a1)
    80003dbe:	00053023          	sd	zero,0(a0)
    if ((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003dc2:	00000097          	auipc	ra,0x0
    80003dc6:	bbe080e7          	jalr	-1090(ra) # 80003980 <filealloc>
    80003dca:	e088                	sd	a0,0(s1)
    80003dcc:	cd49                	beqz	a0,80003e66 <pipealloc+0xbc>
    80003dce:	00000097          	auipc	ra,0x0
    80003dd2:	bb2080e7          	jalr	-1102(ra) # 80003980 <filealloc>
    80003dd6:	00aa3023          	sd	a0,0(s4)
    80003dda:	c141                	beqz	a0,80003e5a <pipealloc+0xb0>
    80003ddc:	e84a                	sd	s2,16(sp)
        goto bad;
    if ((pi = (struct pipe *)kalloc()) == 0)
    80003dde:	ffffc097          	auipc	ra,0xffffc
    80003de2:	33c080e7          	jalr	828(ra) # 8000011a <kalloc>
    80003de6:	892a                	mv	s2,a0
    80003de8:	c13d                	beqz	a0,80003e4e <pipealloc+0xa4>
    80003dea:	e44e                	sd	s3,8(sp)
        goto bad;
    pi->readopen = 1;
    80003dec:	4985                	li	s3,1
    80003dee:	23352023          	sw	s3,544(a0)
    pi->writeopen = 1;
    80003df2:	23352223          	sw	s3,548(a0)
    pi->nwrite = 0;
    80003df6:	20052e23          	sw	zero,540(a0)
    pi->nread = 0;
    80003dfa:	20052c23          	sw	zero,536(a0)
    initlock(&pi->lock, "pipe");
    80003dfe:	00004597          	auipc	a1,0x4
    80003e02:	5ba58593          	addi	a1,a1,1466 # 800083b8 <etext+0x3b8>
    80003e06:	00002097          	auipc	ra,0x2
    80003e0a:	476080e7          	jalr	1142(ra) # 8000627c <initlock>
    (*f0)->type = FD_PIPE;
    80003e0e:	609c                	ld	a5,0(s1)
    80003e10:	0137a023          	sw	s3,0(a5)
    (*f0)->readable = 1;
    80003e14:	609c                	ld	a5,0(s1)
    80003e16:	01378423          	sb	s3,8(a5)
    (*f0)->writable = 0;
    80003e1a:	609c                	ld	a5,0(s1)
    80003e1c:	000784a3          	sb	zero,9(a5)
    (*f0)->pipe = pi;
    80003e20:	609c                	ld	a5,0(s1)
    80003e22:	0127b823          	sd	s2,16(a5)
    (*f1)->type = FD_PIPE;
    80003e26:	000a3783          	ld	a5,0(s4)
    80003e2a:	0137a023          	sw	s3,0(a5)
    (*f1)->readable = 0;
    80003e2e:	000a3783          	ld	a5,0(s4)
    80003e32:	00078423          	sb	zero,8(a5)
    (*f1)->writable = 1;
    80003e36:	000a3783          	ld	a5,0(s4)
    80003e3a:	013784a3          	sb	s3,9(a5)
    (*f1)->pipe = pi;
    80003e3e:	000a3783          	ld	a5,0(s4)
    80003e42:	0127b823          	sd	s2,16(a5)
    return 0;
    80003e46:	4501                	li	a0,0
    80003e48:	6942                	ld	s2,16(sp)
    80003e4a:	69a2                	ld	s3,8(sp)
    80003e4c:	a03d                	j	80003e7a <pipealloc+0xd0>

bad:
    if (pi)
        kfree((char *)pi);
    if (*f0)
    80003e4e:	6088                	ld	a0,0(s1)
    80003e50:	c119                	beqz	a0,80003e56 <pipealloc+0xac>
    80003e52:	6942                	ld	s2,16(sp)
    80003e54:	a029                	j	80003e5e <pipealloc+0xb4>
    80003e56:	6942                	ld	s2,16(sp)
    80003e58:	a039                	j	80003e66 <pipealloc+0xbc>
    80003e5a:	6088                	ld	a0,0(s1)
    80003e5c:	c50d                	beqz	a0,80003e86 <pipealloc+0xdc>
        fileclose(*f0);
    80003e5e:	00000097          	auipc	ra,0x0
    80003e62:	bde080e7          	jalr	-1058(ra) # 80003a3c <fileclose>
    if (*f1)
    80003e66:	000a3783          	ld	a5,0(s4)
        fileclose(*f1);
    return -1;
    80003e6a:	557d                	li	a0,-1
    if (*f1)
    80003e6c:	c799                	beqz	a5,80003e7a <pipealloc+0xd0>
        fileclose(*f1);
    80003e6e:	853e                	mv	a0,a5
    80003e70:	00000097          	auipc	ra,0x0
    80003e74:	bcc080e7          	jalr	-1076(ra) # 80003a3c <fileclose>
    return -1;
    80003e78:	557d                	li	a0,-1
}
    80003e7a:	70a2                	ld	ra,40(sp)
    80003e7c:	7402                	ld	s0,32(sp)
    80003e7e:	64e2                	ld	s1,24(sp)
    80003e80:	6a02                	ld	s4,0(sp)
    80003e82:	6145                	addi	sp,sp,48
    80003e84:	8082                	ret
    return -1;
    80003e86:	557d                	li	a0,-1
    80003e88:	bfcd                	j	80003e7a <pipealloc+0xd0>

0000000080003e8a <pipeclose>:

void pipeclose(struct pipe *pi, int writable) {
    80003e8a:	1101                	addi	sp,sp,-32
    80003e8c:	ec06                	sd	ra,24(sp)
    80003e8e:	e822                	sd	s0,16(sp)
    80003e90:	e426                	sd	s1,8(sp)
    80003e92:	e04a                	sd	s2,0(sp)
    80003e94:	1000                	addi	s0,sp,32
    80003e96:	84aa                	mv	s1,a0
    80003e98:	892e                	mv	s2,a1
    acquire(&pi->lock);
    80003e9a:	00002097          	auipc	ra,0x2
    80003e9e:	472080e7          	jalr	1138(ra) # 8000630c <acquire>
    if (writable) {
    80003ea2:	02090d63          	beqz	s2,80003edc <pipeclose+0x52>
        pi->writeopen = 0;
    80003ea6:	2204a223          	sw	zero,548(s1)
        wakeup(&pi->nread);
    80003eaa:	21848513          	addi	a0,s1,536
    80003eae:	ffffe097          	auipc	ra,0xffffe
    80003eb2:	876080e7          	jalr	-1930(ra) # 80001724 <wakeup>
    } else {
        pi->readopen = 0;
        wakeup(&pi->nwrite);
    }
    if (pi->readopen == 0 && pi->writeopen == 0) {
    80003eb6:	2204b783          	ld	a5,544(s1)
    80003eba:	eb95                	bnez	a5,80003eee <pipeclose+0x64>
        release(&pi->lock);
    80003ebc:	8526                	mv	a0,s1
    80003ebe:	00002097          	auipc	ra,0x2
    80003ec2:	502080e7          	jalr	1282(ra) # 800063c0 <release>
        kfree((char *)pi);
    80003ec6:	8526                	mv	a0,s1
    80003ec8:	ffffc097          	auipc	ra,0xffffc
    80003ecc:	154080e7          	jalr	340(ra) # 8000001c <kfree>
    } else
        release(&pi->lock);
}
    80003ed0:	60e2                	ld	ra,24(sp)
    80003ed2:	6442                	ld	s0,16(sp)
    80003ed4:	64a2                	ld	s1,8(sp)
    80003ed6:	6902                	ld	s2,0(sp)
    80003ed8:	6105                	addi	sp,sp,32
    80003eda:	8082                	ret
        pi->readopen = 0;
    80003edc:	2204a023          	sw	zero,544(s1)
        wakeup(&pi->nwrite);
    80003ee0:	21c48513          	addi	a0,s1,540
    80003ee4:	ffffe097          	auipc	ra,0xffffe
    80003ee8:	840080e7          	jalr	-1984(ra) # 80001724 <wakeup>
    80003eec:	b7e9                	j	80003eb6 <pipeclose+0x2c>
        release(&pi->lock);
    80003eee:	8526                	mv	a0,s1
    80003ef0:	00002097          	auipc	ra,0x2
    80003ef4:	4d0080e7          	jalr	1232(ra) # 800063c0 <release>
}
    80003ef8:	bfe1                	j	80003ed0 <pipeclose+0x46>

0000000080003efa <pipewrite>:

int pipewrite(struct pipe *pi, uint64 addr, int n) {
    80003efa:	711d                	addi	sp,sp,-96
    80003efc:	ec86                	sd	ra,88(sp)
    80003efe:	e8a2                	sd	s0,80(sp)
    80003f00:	e4a6                	sd	s1,72(sp)
    80003f02:	e0ca                	sd	s2,64(sp)
    80003f04:	fc4e                	sd	s3,56(sp)
    80003f06:	f852                	sd	s4,48(sp)
    80003f08:	f456                	sd	s5,40(sp)
    80003f0a:	1080                	addi	s0,sp,96
    80003f0c:	84aa                	mv	s1,a0
    80003f0e:	8aae                	mv	s5,a1
    80003f10:	8a32                	mv	s4,a2
    int i = 0;
    struct proc *pr = myproc();
    80003f12:	ffffd097          	auipc	ra,0xffffd
    80003f16:	fb4080e7          	jalr	-76(ra) # 80000ec6 <myproc>
    80003f1a:	89aa                	mv	s3,a0

    acquire(&pi->lock);
    80003f1c:	8526                	mv	a0,s1
    80003f1e:	00002097          	auipc	ra,0x2
    80003f22:	3ee080e7          	jalr	1006(ra) # 8000630c <acquire>
    while (i < n) {
    80003f26:	0d405563          	blez	s4,80003ff0 <pipewrite+0xf6>
    80003f2a:	f05a                	sd	s6,32(sp)
    80003f2c:	ec5e                	sd	s7,24(sp)
    80003f2e:	e862                	sd	s8,16(sp)
    int i = 0;
    80003f30:	4901                	li	s2,0
        if (pi->nwrite == pi->nread + PIPESIZE) { // DOC: pipewrite-full
            wakeup(&pi->nread);
            sleep(&pi->nwrite, &pi->lock);
        } else {
            char ch;
            if (copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003f32:	5b7d                	li	s6,-1
            wakeup(&pi->nread);
    80003f34:	21848c13          	addi	s8,s1,536
            sleep(&pi->nwrite, &pi->lock);
    80003f38:	21c48b93          	addi	s7,s1,540
    80003f3c:	a089                	j	80003f7e <pipewrite+0x84>
            release(&pi->lock);
    80003f3e:	8526                	mv	a0,s1
    80003f40:	00002097          	auipc	ra,0x2
    80003f44:	480080e7          	jalr	1152(ra) # 800063c0 <release>
            return -1;
    80003f48:	597d                	li	s2,-1
    80003f4a:	7b02                	ld	s6,32(sp)
    80003f4c:	6be2                	ld	s7,24(sp)
    80003f4e:	6c42                	ld	s8,16(sp)
    }
    wakeup(&pi->nread);
    release(&pi->lock);

    return i;
}
    80003f50:	854a                	mv	a0,s2
    80003f52:	60e6                	ld	ra,88(sp)
    80003f54:	6446                	ld	s0,80(sp)
    80003f56:	64a6                	ld	s1,72(sp)
    80003f58:	6906                	ld	s2,64(sp)
    80003f5a:	79e2                	ld	s3,56(sp)
    80003f5c:	7a42                	ld	s4,48(sp)
    80003f5e:	7aa2                	ld	s5,40(sp)
    80003f60:	6125                	addi	sp,sp,96
    80003f62:	8082                	ret
            wakeup(&pi->nread);
    80003f64:	8562                	mv	a0,s8
    80003f66:	ffffd097          	auipc	ra,0xffffd
    80003f6a:	7be080e7          	jalr	1982(ra) # 80001724 <wakeup>
            sleep(&pi->nwrite, &pi->lock);
    80003f6e:	85a6                	mv	a1,s1
    80003f70:	855e                	mv	a0,s7
    80003f72:	ffffd097          	auipc	ra,0xffffd
    80003f76:	626080e7          	jalr	1574(ra) # 80001598 <sleep>
    while (i < n) {
    80003f7a:	05495c63          	bge	s2,s4,80003fd2 <pipewrite+0xd8>
        if (pi->readopen == 0 || pr->killed) {
    80003f7e:	2204a783          	lw	a5,544(s1)
    80003f82:	dfd5                	beqz	a5,80003f3e <pipewrite+0x44>
    80003f84:	0289a783          	lw	a5,40(s3)
    80003f88:	fbdd                	bnez	a5,80003f3e <pipewrite+0x44>
        if (pi->nwrite == pi->nread + PIPESIZE) { // DOC: pipewrite-full
    80003f8a:	2184a783          	lw	a5,536(s1)
    80003f8e:	21c4a703          	lw	a4,540(s1)
    80003f92:	2007879b          	addiw	a5,a5,512
    80003f96:	fcf707e3          	beq	a4,a5,80003f64 <pipewrite+0x6a>
            if (copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003f9a:	4685                	li	a3,1
    80003f9c:	01590633          	add	a2,s2,s5
    80003fa0:	faf40593          	addi	a1,s0,-81
    80003fa4:	0509b503          	ld	a0,80(s3)
    80003fa8:	ffffd097          	auipc	ra,0xffffd
    80003fac:	c46080e7          	jalr	-954(ra) # 80000bee <copyin>
    80003fb0:	05650263          	beq	a0,s6,80003ff4 <pipewrite+0xfa>
            pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80003fb4:	21c4a783          	lw	a5,540(s1)
    80003fb8:	0017871b          	addiw	a4,a5,1
    80003fbc:	20e4ae23          	sw	a4,540(s1)
    80003fc0:	1ff7f793          	andi	a5,a5,511
    80003fc4:	97a6                	add	a5,a5,s1
    80003fc6:	faf44703          	lbu	a4,-81(s0)
    80003fca:	00e78c23          	sb	a4,24(a5)
            i++;
    80003fce:	2905                	addiw	s2,s2,1
    80003fd0:	b76d                	j	80003f7a <pipewrite+0x80>
    80003fd2:	7b02                	ld	s6,32(sp)
    80003fd4:	6be2                	ld	s7,24(sp)
    80003fd6:	6c42                	ld	s8,16(sp)
    wakeup(&pi->nread);
    80003fd8:	21848513          	addi	a0,s1,536
    80003fdc:	ffffd097          	auipc	ra,0xffffd
    80003fe0:	748080e7          	jalr	1864(ra) # 80001724 <wakeup>
    release(&pi->lock);
    80003fe4:	8526                	mv	a0,s1
    80003fe6:	00002097          	auipc	ra,0x2
    80003fea:	3da080e7          	jalr	986(ra) # 800063c0 <release>
    return i;
    80003fee:	b78d                	j	80003f50 <pipewrite+0x56>
    int i = 0;
    80003ff0:	4901                	li	s2,0
    80003ff2:	b7dd                	j	80003fd8 <pipewrite+0xde>
    80003ff4:	7b02                	ld	s6,32(sp)
    80003ff6:	6be2                	ld	s7,24(sp)
    80003ff8:	6c42                	ld	s8,16(sp)
    80003ffa:	bff9                	j	80003fd8 <pipewrite+0xde>

0000000080003ffc <piperead>:

int piperead(struct pipe *pi, uint64 addr, int n) {
    80003ffc:	715d                	addi	sp,sp,-80
    80003ffe:	e486                	sd	ra,72(sp)
    80004000:	e0a2                	sd	s0,64(sp)
    80004002:	fc26                	sd	s1,56(sp)
    80004004:	f84a                	sd	s2,48(sp)
    80004006:	f44e                	sd	s3,40(sp)
    80004008:	f052                	sd	s4,32(sp)
    8000400a:	ec56                	sd	s5,24(sp)
    8000400c:	0880                	addi	s0,sp,80
    8000400e:	84aa                	mv	s1,a0
    80004010:	892e                	mv	s2,a1
    80004012:	8ab2                	mv	s5,a2
    int i;
    struct proc *pr = myproc();
    80004014:	ffffd097          	auipc	ra,0xffffd
    80004018:	eb2080e7          	jalr	-334(ra) # 80000ec6 <myproc>
    8000401c:	8a2a                	mv	s4,a0
    char ch;

    acquire(&pi->lock);
    8000401e:	8526                	mv	a0,s1
    80004020:	00002097          	auipc	ra,0x2
    80004024:	2ec080e7          	jalr	748(ra) # 8000630c <acquire>
    while (pi->nread == pi->nwrite && pi->writeopen) { // DOC: pipe-empty
    80004028:	2184a703          	lw	a4,536(s1)
    8000402c:	21c4a783          	lw	a5,540(s1)
        if (pr->killed) {
            release(&pi->lock);
            return -1;
        }
        sleep(&pi->nread, &pi->lock); // DOC: piperead-sleep
    80004030:	21848993          	addi	s3,s1,536
    while (pi->nread == pi->nwrite && pi->writeopen) { // DOC: pipe-empty
    80004034:	02f71663          	bne	a4,a5,80004060 <piperead+0x64>
    80004038:	2244a783          	lw	a5,548(s1)
    8000403c:	cb9d                	beqz	a5,80004072 <piperead+0x76>
        if (pr->killed) {
    8000403e:	028a2783          	lw	a5,40(s4)
    80004042:	e38d                	bnez	a5,80004064 <piperead+0x68>
        sleep(&pi->nread, &pi->lock); // DOC: piperead-sleep
    80004044:	85a6                	mv	a1,s1
    80004046:	854e                	mv	a0,s3
    80004048:	ffffd097          	auipc	ra,0xffffd
    8000404c:	550080e7          	jalr	1360(ra) # 80001598 <sleep>
    while (pi->nread == pi->nwrite && pi->writeopen) { // DOC: pipe-empty
    80004050:	2184a703          	lw	a4,536(s1)
    80004054:	21c4a783          	lw	a5,540(s1)
    80004058:	fef700e3          	beq	a4,a5,80004038 <piperead+0x3c>
    8000405c:	e85a                	sd	s6,16(sp)
    8000405e:	a819                	j	80004074 <piperead+0x78>
    80004060:	e85a                	sd	s6,16(sp)
    80004062:	a809                	j	80004074 <piperead+0x78>
            release(&pi->lock);
    80004064:	8526                	mv	a0,s1
    80004066:	00002097          	auipc	ra,0x2
    8000406a:	35a080e7          	jalr	858(ra) # 800063c0 <release>
            return -1;
    8000406e:	59fd                	li	s3,-1
    80004070:	a0a5                	j	800040d8 <piperead+0xdc>
    80004072:	e85a                	sd	s6,16(sp)
    }
    for (i = 0; i < n; i++) { // DOC: piperead-copy
    80004074:	4981                	li	s3,0
        if (pi->nread == pi->nwrite)
            break;
        ch = pi->data[pi->nread++ % PIPESIZE];
        if (copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004076:	5b7d                	li	s6,-1
    for (i = 0; i < n; i++) { // DOC: piperead-copy
    80004078:	05505463          	blez	s5,800040c0 <piperead+0xc4>
        if (pi->nread == pi->nwrite)
    8000407c:	2184a783          	lw	a5,536(s1)
    80004080:	21c4a703          	lw	a4,540(s1)
    80004084:	02f70e63          	beq	a4,a5,800040c0 <piperead+0xc4>
        ch = pi->data[pi->nread++ % PIPESIZE];
    80004088:	0017871b          	addiw	a4,a5,1
    8000408c:	20e4ac23          	sw	a4,536(s1)
    80004090:	1ff7f793          	andi	a5,a5,511
    80004094:	97a6                	add	a5,a5,s1
    80004096:	0187c783          	lbu	a5,24(a5)
    8000409a:	faf40fa3          	sb	a5,-65(s0)
        if (copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    8000409e:	4685                	li	a3,1
    800040a0:	fbf40613          	addi	a2,s0,-65
    800040a4:	85ca                	mv	a1,s2
    800040a6:	050a3503          	ld	a0,80(s4)
    800040aa:	ffffd097          	auipc	ra,0xffffd
    800040ae:	ab8080e7          	jalr	-1352(ra) # 80000b62 <copyout>
    800040b2:	01650763          	beq	a0,s6,800040c0 <piperead+0xc4>
    for (i = 0; i < n; i++) { // DOC: piperead-copy
    800040b6:	2985                	addiw	s3,s3,1
    800040b8:	0905                	addi	s2,s2,1
    800040ba:	fd3a91e3          	bne	s5,s3,8000407c <piperead+0x80>
    800040be:	89d6                	mv	s3,s5
            break;
    }
    wakeup(&pi->nwrite); // DOC: piperead-wakeup
    800040c0:	21c48513          	addi	a0,s1,540
    800040c4:	ffffd097          	auipc	ra,0xffffd
    800040c8:	660080e7          	jalr	1632(ra) # 80001724 <wakeup>
    release(&pi->lock);
    800040cc:	8526                	mv	a0,s1
    800040ce:	00002097          	auipc	ra,0x2
    800040d2:	2f2080e7          	jalr	754(ra) # 800063c0 <release>
    800040d6:	6b42                	ld	s6,16(sp)
    return i;
}
    800040d8:	854e                	mv	a0,s3
    800040da:	60a6                	ld	ra,72(sp)
    800040dc:	6406                	ld	s0,64(sp)
    800040de:	74e2                	ld	s1,56(sp)
    800040e0:	7942                	ld	s2,48(sp)
    800040e2:	79a2                	ld	s3,40(sp)
    800040e4:	7a02                	ld	s4,32(sp)
    800040e6:	6ae2                	ld	s5,24(sp)
    800040e8:	6161                	addi	sp,sp,80
    800040ea:	8082                	ret

00000000800040ec <exec>:
#include "elf.h"

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset,
                   uint sz);

int exec(char *path, char **argv) {
    800040ec:	df010113          	addi	sp,sp,-528
    800040f0:	20113423          	sd	ra,520(sp)
    800040f4:	20813023          	sd	s0,512(sp)
    800040f8:	ffa6                	sd	s1,504(sp)
    800040fa:	fbca                	sd	s2,496(sp)
    800040fc:	0c00                	addi	s0,sp,528
    800040fe:	892a                	mv	s2,a0
    80004100:	dea43c23          	sd	a0,-520(s0)
    80004104:	e0b43023          	sd	a1,-512(s0)
    uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    struct elfhdr elf;
    struct inode *ip;
    struct proghdr ph;
    pagetable_t pagetable = 0, oldpagetable;
    struct proc *p = myproc();
    80004108:	ffffd097          	auipc	ra,0xffffd
    8000410c:	dbe080e7          	jalr	-578(ra) # 80000ec6 <myproc>
    80004110:	84aa                	mv	s1,a0

    begin_op();
    80004112:	fffff097          	auipc	ra,0xfffff
    80004116:	460080e7          	jalr	1120(ra) # 80003572 <begin_op>

    if ((ip = namei(path)) == 0) {
    8000411a:	854a                	mv	a0,s2
    8000411c:	fffff097          	auipc	ra,0xfffff
    80004120:	256080e7          	jalr	598(ra) # 80003372 <namei>
    80004124:	c135                	beqz	a0,80004188 <exec+0x9c>
    80004126:	f3d2                	sd	s4,480(sp)
    80004128:	8a2a                	mv	s4,a0
        end_op();
        return -1;
    }
    ilock(ip);
    8000412a:	fffff097          	auipc	ra,0xfffff
    8000412e:	a76080e7          	jalr	-1418(ra) # 80002ba0 <ilock>

    // Check ELF header
    if (readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80004132:	04000713          	li	a4,64
    80004136:	4681                	li	a3,0
    80004138:	e5040613          	addi	a2,s0,-432
    8000413c:	4581                	li	a1,0
    8000413e:	8552                	mv	a0,s4
    80004140:	fffff097          	auipc	ra,0xfffff
    80004144:	d18080e7          	jalr	-744(ra) # 80002e58 <readi>
    80004148:	04000793          	li	a5,64
    8000414c:	00f51a63          	bne	a0,a5,80004160 <exec+0x74>
        goto bad;
    if (elf.magic != ELF_MAGIC)
    80004150:	e5042703          	lw	a4,-432(s0)
    80004154:	464c47b7          	lui	a5,0x464c4
    80004158:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    8000415c:	02f70c63          	beq	a4,a5,80004194 <exec+0xa8>

bad:
    if (pagetable)
        proc_freepagetable(pagetable, sz);
    if (ip) {
        iunlockput(ip);
    80004160:	8552                	mv	a0,s4
    80004162:	fffff097          	auipc	ra,0xfffff
    80004166:	ca4080e7          	jalr	-860(ra) # 80002e06 <iunlockput>
        end_op();
    8000416a:	fffff097          	auipc	ra,0xfffff
    8000416e:	482080e7          	jalr	1154(ra) # 800035ec <end_op>
    }
    return -1;
    80004172:	557d                	li	a0,-1
    80004174:	7a1e                	ld	s4,480(sp)
}
    80004176:	20813083          	ld	ra,520(sp)
    8000417a:	20013403          	ld	s0,512(sp)
    8000417e:	74fe                	ld	s1,504(sp)
    80004180:	795e                	ld	s2,496(sp)
    80004182:	21010113          	addi	sp,sp,528
    80004186:	8082                	ret
        end_op();
    80004188:	fffff097          	auipc	ra,0xfffff
    8000418c:	464080e7          	jalr	1124(ra) # 800035ec <end_op>
        return -1;
    80004190:	557d                	li	a0,-1
    80004192:	b7d5                	j	80004176 <exec+0x8a>
    80004194:	ebda                	sd	s6,464(sp)
    if ((pagetable = proc_pagetable(p)) == 0)
    80004196:	8526                	mv	a0,s1
    80004198:	ffffd097          	auipc	ra,0xffffd
    8000419c:	df2080e7          	jalr	-526(ra) # 80000f8a <proc_pagetable>
    800041a0:	8b2a                	mv	s6,a0
    800041a2:	30050563          	beqz	a0,800044ac <exec+0x3c0>
    800041a6:	f7ce                	sd	s3,488(sp)
    800041a8:	efd6                	sd	s5,472(sp)
    800041aa:	e7de                	sd	s7,456(sp)
    800041ac:	e3e2                	sd	s8,448(sp)
    800041ae:	ff66                	sd	s9,440(sp)
    800041b0:	fb6a                	sd	s10,432(sp)
    for (i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)) {
    800041b2:	e7042d03          	lw	s10,-400(s0)
    800041b6:	e8845783          	lhu	a5,-376(s0)
    800041ba:	14078563          	beqz	a5,80004304 <exec+0x218>
    800041be:	f76e                	sd	s11,424(sp)
    uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    800041c0:	4481                	li	s1,0
    for (i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)) {
    800041c2:	4d81                	li	s11,0
        if ((ph.vaddr % PGSIZE) != 0)
    800041c4:	6c85                	lui	s9,0x1
    800041c6:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    800041ca:	def43823          	sd	a5,-528(s0)

    for (i = 0; i < sz; i += PGSIZE) {
        pa = walkaddr(pagetable, va + i);
        if (pa == 0)
            panic("loadseg: address should exist");
        if (sz - i < PGSIZE)
    800041ce:	6a85                	lui	s5,0x1
    800041d0:	a0b5                	j	8000423c <exec+0x150>
            panic("loadseg: address should exist");
    800041d2:	00004517          	auipc	a0,0x4
    800041d6:	43e50513          	addi	a0,a0,1086 # 80008610 <etext+0x610>
    800041da:	00002097          	auipc	ra,0x2
    800041de:	bb8080e7          	jalr	-1096(ra) # 80005d92 <panic>
        if (sz - i < PGSIZE)
    800041e2:	2481                	sext.w	s1,s1
            n = sz - i;
        else
            n = PGSIZE;
        if (readi(ip, 0, (uint64)pa, offset + i, n) != n)
    800041e4:	8726                	mv	a4,s1
    800041e6:	012c06bb          	addw	a3,s8,s2
    800041ea:	4581                	li	a1,0
    800041ec:	8552                	mv	a0,s4
    800041ee:	fffff097          	auipc	ra,0xfffff
    800041f2:	c6a080e7          	jalr	-918(ra) # 80002e58 <readi>
    800041f6:	2501                	sext.w	a0,a0
    800041f8:	26a49e63          	bne	s1,a0,80004474 <exec+0x388>
    for (i = 0; i < sz; i += PGSIZE) {
    800041fc:	012a893b          	addw	s2,s5,s2
    80004200:	03397563          	bgeu	s2,s3,8000422a <exec+0x13e>
        pa = walkaddr(pagetable, va + i);
    80004204:	02091593          	slli	a1,s2,0x20
    80004208:	9181                	srli	a1,a1,0x20
    8000420a:	95de                	add	a1,a1,s7
    8000420c:	855a                	mv	a0,s6
    8000420e:	ffffc097          	auipc	ra,0xffffc
    80004212:	334080e7          	jalr	820(ra) # 80000542 <walkaddr>
    80004216:	862a                	mv	a2,a0
        if (pa == 0)
    80004218:	dd4d                	beqz	a0,800041d2 <exec+0xe6>
        if (sz - i < PGSIZE)
    8000421a:	412984bb          	subw	s1,s3,s2
    8000421e:	0004879b          	sext.w	a5,s1
    80004222:	fcfcf0e3          	bgeu	s9,a5,800041e2 <exec+0xf6>
    80004226:	84d6                	mv	s1,s5
    80004228:	bf6d                	j	800041e2 <exec+0xf6>
        sz = sz1;
    8000422a:	e0843483          	ld	s1,-504(s0)
    for (i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)) {
    8000422e:	2d85                	addiw	s11,s11,1
    80004230:	038d0d1b          	addiw	s10,s10,56
    80004234:	e8845783          	lhu	a5,-376(s0)
    80004238:	06fddf63          	bge	s11,a5,800042b6 <exec+0x1ca>
        if (readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    8000423c:	2d01                	sext.w	s10,s10
    8000423e:	03800713          	li	a4,56
    80004242:	86ea                	mv	a3,s10
    80004244:	e1840613          	addi	a2,s0,-488
    80004248:	4581                	li	a1,0
    8000424a:	8552                	mv	a0,s4
    8000424c:	fffff097          	auipc	ra,0xfffff
    80004250:	c0c080e7          	jalr	-1012(ra) # 80002e58 <readi>
    80004254:	03800793          	li	a5,56
    80004258:	1ef51863          	bne	a0,a5,80004448 <exec+0x35c>
        if (ph.type != ELF_PROG_LOAD)
    8000425c:	e1842783          	lw	a5,-488(s0)
    80004260:	4705                	li	a4,1
    80004262:	fce796e3          	bne	a5,a4,8000422e <exec+0x142>
        if (ph.memsz < ph.filesz)
    80004266:	e4043603          	ld	a2,-448(s0)
    8000426a:	e3843783          	ld	a5,-456(s0)
    8000426e:	1ef66163          	bltu	a2,a5,80004450 <exec+0x364>
        if (ph.vaddr + ph.memsz < ph.vaddr)
    80004272:	e2843783          	ld	a5,-472(s0)
    80004276:	963e                	add	a2,a2,a5
    80004278:	1ef66063          	bltu	a2,a5,80004458 <exec+0x36c>
        if ((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    8000427c:	85a6                	mv	a1,s1
    8000427e:	855a                	mv	a0,s6
    80004280:	ffffc097          	auipc	ra,0xffffc
    80004284:	686080e7          	jalr	1670(ra) # 80000906 <uvmalloc>
    80004288:	e0a43423          	sd	a0,-504(s0)
    8000428c:	1c050a63          	beqz	a0,80004460 <exec+0x374>
        if ((ph.vaddr % PGSIZE) != 0)
    80004290:	e2843b83          	ld	s7,-472(s0)
    80004294:	df043783          	ld	a5,-528(s0)
    80004298:	00fbf7b3          	and	a5,s7,a5
    8000429c:	1c079a63          	bnez	a5,80004470 <exec+0x384>
        if (loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    800042a0:	e2042c03          	lw	s8,-480(s0)
    800042a4:	e3842983          	lw	s3,-456(s0)
    for (i = 0; i < sz; i += PGSIZE) {
    800042a8:	00098463          	beqz	s3,800042b0 <exec+0x1c4>
    800042ac:	4901                	li	s2,0
    800042ae:	bf99                	j	80004204 <exec+0x118>
        sz = sz1;
    800042b0:	e0843483          	ld	s1,-504(s0)
    800042b4:	bfad                	j	8000422e <exec+0x142>
    800042b6:	7dba                	ld	s11,424(sp)
    iunlockput(ip);
    800042b8:	8552                	mv	a0,s4
    800042ba:	fffff097          	auipc	ra,0xfffff
    800042be:	b4c080e7          	jalr	-1204(ra) # 80002e06 <iunlockput>
    end_op();
    800042c2:	fffff097          	auipc	ra,0xfffff
    800042c6:	32a080e7          	jalr	810(ra) # 800035ec <end_op>
    p = myproc();
    800042ca:	ffffd097          	auipc	ra,0xffffd
    800042ce:	bfc080e7          	jalr	-1028(ra) # 80000ec6 <myproc>
    800042d2:	8aaa                	mv	s5,a0
    uint64 oldsz = p->sz;
    800042d4:	04853c83          	ld	s9,72(a0)
    sz = PGROUNDUP(sz);
    800042d8:	6985                	lui	s3,0x1
    800042da:	19fd                	addi	s3,s3,-1 # fff <_entry-0x7ffff001>
    800042dc:	99a6                	add	s3,s3,s1
    800042de:	77fd                	lui	a5,0xfffff
    800042e0:	00f9f9b3          	and	s3,s3,a5
    if ((sz1 = uvmalloc(pagetable, sz, sz + 2 * PGSIZE)) == 0)
    800042e4:	6609                	lui	a2,0x2
    800042e6:	964e                	add	a2,a2,s3
    800042e8:	85ce                	mv	a1,s3
    800042ea:	855a                	mv	a0,s6
    800042ec:	ffffc097          	auipc	ra,0xffffc
    800042f0:	61a080e7          	jalr	1562(ra) # 80000906 <uvmalloc>
    800042f4:	892a                	mv	s2,a0
    800042f6:	e0a43423          	sd	a0,-504(s0)
    800042fa:	e519                	bnez	a0,80004308 <exec+0x21c>
    if (pagetable)
    800042fc:	e1343423          	sd	s3,-504(s0)
    80004300:	4a01                	li	s4,0
    80004302:	aa95                	j	80004476 <exec+0x38a>
    uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004304:	4481                	li	s1,0
    80004306:	bf4d                	j	800042b8 <exec+0x1cc>
    uvmclear(pagetable, sz - 2 * PGSIZE);
    80004308:	75f9                	lui	a1,0xffffe
    8000430a:	95aa                	add	a1,a1,a0
    8000430c:	855a                	mv	a0,s6
    8000430e:	ffffd097          	auipc	ra,0xffffd
    80004312:	822080e7          	jalr	-2014(ra) # 80000b30 <uvmclear>
    stackbase = sp - PGSIZE;
    80004316:	7bfd                	lui	s7,0xfffff
    80004318:	9bca                	add	s7,s7,s2
    for (argc = 0; argv[argc]; argc++) {
    8000431a:	e0043783          	ld	a5,-512(s0)
    8000431e:	6388                	ld	a0,0(a5)
    80004320:	c52d                	beqz	a0,8000438a <exec+0x29e>
    80004322:	e9040993          	addi	s3,s0,-368
    80004326:	f9040c13          	addi	s8,s0,-112
    8000432a:	4481                	li	s1,0
        sp -= strlen(argv[argc]) + 1;
    8000432c:	ffffc097          	auipc	ra,0xffffc
    80004330:	00c080e7          	jalr	12(ra) # 80000338 <strlen>
    80004334:	0015079b          	addiw	a5,a0,1
    80004338:	40f907b3          	sub	a5,s2,a5
        sp -= sp % 16; // riscv sp must be 16-byte aligned
    8000433c:	ff07f913          	andi	s2,a5,-16
        if (sp < stackbase)
    80004340:	13796463          	bltu	s2,s7,80004468 <exec+0x37c>
        if (copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80004344:	e0043d03          	ld	s10,-512(s0)
    80004348:	000d3a03          	ld	s4,0(s10)
    8000434c:	8552                	mv	a0,s4
    8000434e:	ffffc097          	auipc	ra,0xffffc
    80004352:	fea080e7          	jalr	-22(ra) # 80000338 <strlen>
    80004356:	0015069b          	addiw	a3,a0,1
    8000435a:	8652                	mv	a2,s4
    8000435c:	85ca                	mv	a1,s2
    8000435e:	855a                	mv	a0,s6
    80004360:	ffffd097          	auipc	ra,0xffffd
    80004364:	802080e7          	jalr	-2046(ra) # 80000b62 <copyout>
    80004368:	10054263          	bltz	a0,8000446c <exec+0x380>
        ustack[argc] = sp;
    8000436c:	0129b023          	sd	s2,0(s3)
    for (argc = 0; argv[argc]; argc++) {
    80004370:	0485                	addi	s1,s1,1
    80004372:	008d0793          	addi	a5,s10,8
    80004376:	e0f43023          	sd	a5,-512(s0)
    8000437a:	008d3503          	ld	a0,8(s10)
    8000437e:	c909                	beqz	a0,80004390 <exec+0x2a4>
        if (argc >= MAXARG)
    80004380:	09a1                	addi	s3,s3,8
    80004382:	fb8995e3          	bne	s3,s8,8000432c <exec+0x240>
    ip = 0;
    80004386:	4a01                	li	s4,0
    80004388:	a0fd                	j	80004476 <exec+0x38a>
    sp = sz;
    8000438a:	e0843903          	ld	s2,-504(s0)
    for (argc = 0; argv[argc]; argc++) {
    8000438e:	4481                	li	s1,0
    ustack[argc] = 0;
    80004390:	00349793          	slli	a5,s1,0x3
    80004394:	f9078793          	addi	a5,a5,-112 # ffffffffffffef90 <end+0xffffffff7ffd5d50>
    80004398:	97a2                	add	a5,a5,s0
    8000439a:	f007b023          	sd	zero,-256(a5)
    sp -= (argc + 1) * sizeof(uint64);
    8000439e:	00148693          	addi	a3,s1,1
    800043a2:	068e                	slli	a3,a3,0x3
    800043a4:	40d90933          	sub	s2,s2,a3
    sp -= sp % 16;
    800043a8:	ff097913          	andi	s2,s2,-16
    sz = sz1;
    800043ac:	e0843983          	ld	s3,-504(s0)
    if (sp < stackbase)
    800043b0:	f57966e3          	bltu	s2,s7,800042fc <exec+0x210>
    if (copyout(pagetable, sp, (char *)ustack, (argc + 1) * sizeof(uint64)) < 0)
    800043b4:	e9040613          	addi	a2,s0,-368
    800043b8:	85ca                	mv	a1,s2
    800043ba:	855a                	mv	a0,s6
    800043bc:	ffffc097          	auipc	ra,0xffffc
    800043c0:	7a6080e7          	jalr	1958(ra) # 80000b62 <copyout>
    800043c4:	0e054663          	bltz	a0,800044b0 <exec+0x3c4>
    p->trapframe->a1 = sp;
    800043c8:	058ab783          	ld	a5,88(s5) # 1058 <_entry-0x7fffefa8>
    800043cc:	0727bc23          	sd	s2,120(a5)
    for (last = s = path; *s; s++)
    800043d0:	df843783          	ld	a5,-520(s0)
    800043d4:	0007c703          	lbu	a4,0(a5)
    800043d8:	cf11                	beqz	a4,800043f4 <exec+0x308>
    800043da:	0785                	addi	a5,a5,1
        if (*s == '/')
    800043dc:	02f00693          	li	a3,47
    800043e0:	a039                	j	800043ee <exec+0x302>
            last = s + 1;
    800043e2:	def43c23          	sd	a5,-520(s0)
    for (last = s = path; *s; s++)
    800043e6:	0785                	addi	a5,a5,1
    800043e8:	fff7c703          	lbu	a4,-1(a5)
    800043ec:	c701                	beqz	a4,800043f4 <exec+0x308>
        if (*s == '/')
    800043ee:	fed71ce3          	bne	a4,a3,800043e6 <exec+0x2fa>
    800043f2:	bfc5                	j	800043e2 <exec+0x2f6>
    safestrcpy(p->name, last, sizeof(p->name));
    800043f4:	4641                	li	a2,16
    800043f6:	df843583          	ld	a1,-520(s0)
    800043fa:	158a8513          	addi	a0,s5,344
    800043fe:	ffffc097          	auipc	ra,0xffffc
    80004402:	f08080e7          	jalr	-248(ra) # 80000306 <safestrcpy>
    oldpagetable = p->pagetable;
    80004406:	050ab503          	ld	a0,80(s5)
    p->pagetable = pagetable;
    8000440a:	056ab823          	sd	s6,80(s5)
    p->sz = sz;
    8000440e:	e0843783          	ld	a5,-504(s0)
    80004412:	04fab423          	sd	a5,72(s5)
    p->trapframe->epc = elf.entry; // initial program counter = main
    80004416:	058ab783          	ld	a5,88(s5)
    8000441a:	e6843703          	ld	a4,-408(s0)
    8000441e:	ef98                	sd	a4,24(a5)
    p->trapframe->sp = sp;         // initial stack pointer
    80004420:	058ab783          	ld	a5,88(s5)
    80004424:	0327b823          	sd	s2,48(a5)
    proc_freepagetable(oldpagetable, oldsz);
    80004428:	85e6                	mv	a1,s9
    8000442a:	ffffd097          	auipc	ra,0xffffd
    8000442e:	bfc080e7          	jalr	-1028(ra) # 80001026 <proc_freepagetable>
    return argc; // this ends up in a0, the first argument to main(argc, argv)
    80004432:	0004851b          	sext.w	a0,s1
    80004436:	79be                	ld	s3,488(sp)
    80004438:	7a1e                	ld	s4,480(sp)
    8000443a:	6afe                	ld	s5,472(sp)
    8000443c:	6b5e                	ld	s6,464(sp)
    8000443e:	6bbe                	ld	s7,456(sp)
    80004440:	6c1e                	ld	s8,448(sp)
    80004442:	7cfa                	ld	s9,440(sp)
    80004444:	7d5a                	ld	s10,432(sp)
    80004446:	bb05                	j	80004176 <exec+0x8a>
    80004448:	e0943423          	sd	s1,-504(s0)
    8000444c:	7dba                	ld	s11,424(sp)
    8000444e:	a025                	j	80004476 <exec+0x38a>
    80004450:	e0943423          	sd	s1,-504(s0)
    80004454:	7dba                	ld	s11,424(sp)
    80004456:	a005                	j	80004476 <exec+0x38a>
    80004458:	e0943423          	sd	s1,-504(s0)
    8000445c:	7dba                	ld	s11,424(sp)
    8000445e:	a821                	j	80004476 <exec+0x38a>
    80004460:	e0943423          	sd	s1,-504(s0)
    80004464:	7dba                	ld	s11,424(sp)
    80004466:	a801                	j	80004476 <exec+0x38a>
    ip = 0;
    80004468:	4a01                	li	s4,0
    8000446a:	a031                	j	80004476 <exec+0x38a>
    8000446c:	4a01                	li	s4,0
    if (pagetable)
    8000446e:	a021                	j	80004476 <exec+0x38a>
    80004470:	7dba                	ld	s11,424(sp)
    80004472:	a011                	j	80004476 <exec+0x38a>
    80004474:	7dba                	ld	s11,424(sp)
        proc_freepagetable(pagetable, sz);
    80004476:	e0843583          	ld	a1,-504(s0)
    8000447a:	855a                	mv	a0,s6
    8000447c:	ffffd097          	auipc	ra,0xffffd
    80004480:	baa080e7          	jalr	-1110(ra) # 80001026 <proc_freepagetable>
    return -1;
    80004484:	557d                	li	a0,-1
    if (ip) {
    80004486:	000a1b63          	bnez	s4,8000449c <exec+0x3b0>
    8000448a:	79be                	ld	s3,488(sp)
    8000448c:	7a1e                	ld	s4,480(sp)
    8000448e:	6afe                	ld	s5,472(sp)
    80004490:	6b5e                	ld	s6,464(sp)
    80004492:	6bbe                	ld	s7,456(sp)
    80004494:	6c1e                	ld	s8,448(sp)
    80004496:	7cfa                	ld	s9,440(sp)
    80004498:	7d5a                	ld	s10,432(sp)
    8000449a:	b9f1                	j	80004176 <exec+0x8a>
    8000449c:	79be                	ld	s3,488(sp)
    8000449e:	6afe                	ld	s5,472(sp)
    800044a0:	6b5e                	ld	s6,464(sp)
    800044a2:	6bbe                	ld	s7,456(sp)
    800044a4:	6c1e                	ld	s8,448(sp)
    800044a6:	7cfa                	ld	s9,440(sp)
    800044a8:	7d5a                	ld	s10,432(sp)
    800044aa:	b95d                	j	80004160 <exec+0x74>
    800044ac:	6b5e                	ld	s6,464(sp)
    800044ae:	b94d                	j	80004160 <exec+0x74>
    sz = sz1;
    800044b0:	e0843983          	ld	s3,-504(s0)
    800044b4:	b5a1                	j	800042fc <exec+0x210>

00000000800044b6 <argfd>:
#include "file.h"
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int argfd(int n, int *pfd, struct file **pf) {
    800044b6:	7179                	addi	sp,sp,-48
    800044b8:	f406                	sd	ra,40(sp)
    800044ba:	f022                	sd	s0,32(sp)
    800044bc:	ec26                	sd	s1,24(sp)
    800044be:	e84a                	sd	s2,16(sp)
    800044c0:	1800                	addi	s0,sp,48
    800044c2:	892e                	mv	s2,a1
    800044c4:	84b2                	mv	s1,a2
    int fd;
    struct file *f;

    if (argint(n, &fd) < 0)
    800044c6:	fdc40593          	addi	a1,s0,-36
    800044ca:	ffffe097          	auipc	ra,0xffffe
    800044ce:	af6080e7          	jalr	-1290(ra) # 80001fc0 <argint>
    800044d2:	04054063          	bltz	a0,80004512 <argfd+0x5c>
        return -1;
    if (fd < 0 || fd >= NOFILE || (f = myproc()->ofile[fd]) == 0)
    800044d6:	fdc42703          	lw	a4,-36(s0)
    800044da:	47bd                	li	a5,15
    800044dc:	02e7ed63          	bltu	a5,a4,80004516 <argfd+0x60>
    800044e0:	ffffd097          	auipc	ra,0xffffd
    800044e4:	9e6080e7          	jalr	-1562(ra) # 80000ec6 <myproc>
    800044e8:	fdc42703          	lw	a4,-36(s0)
    800044ec:	01a70793          	addi	a5,a4,26
    800044f0:	078e                	slli	a5,a5,0x3
    800044f2:	953e                	add	a0,a0,a5
    800044f4:	611c                	ld	a5,0(a0)
    800044f6:	c395                	beqz	a5,8000451a <argfd+0x64>
        return -1;
    if (pfd)
    800044f8:	00090463          	beqz	s2,80004500 <argfd+0x4a>
        *pfd = fd;
    800044fc:	00e92023          	sw	a4,0(s2)
    if (pf)
        *pf = f;
    return 0;
    80004500:	4501                	li	a0,0
    if (pf)
    80004502:	c091                	beqz	s1,80004506 <argfd+0x50>
        *pf = f;
    80004504:	e09c                	sd	a5,0(s1)
}
    80004506:	70a2                	ld	ra,40(sp)
    80004508:	7402                	ld	s0,32(sp)
    8000450a:	64e2                	ld	s1,24(sp)
    8000450c:	6942                	ld	s2,16(sp)
    8000450e:	6145                	addi	sp,sp,48
    80004510:	8082                	ret
        return -1;
    80004512:	557d                	li	a0,-1
    80004514:	bfcd                	j	80004506 <argfd+0x50>
        return -1;
    80004516:	557d                	li	a0,-1
    80004518:	b7fd                	j	80004506 <argfd+0x50>
    8000451a:	557d                	li	a0,-1
    8000451c:	b7ed                	j	80004506 <argfd+0x50>

000000008000451e <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int fdalloc(struct file *f) {
    8000451e:	1101                	addi	sp,sp,-32
    80004520:	ec06                	sd	ra,24(sp)
    80004522:	e822                	sd	s0,16(sp)
    80004524:	e426                	sd	s1,8(sp)
    80004526:	1000                	addi	s0,sp,32
    80004528:	84aa                	mv	s1,a0
    int fd;
    struct proc *p = myproc();
    8000452a:	ffffd097          	auipc	ra,0xffffd
    8000452e:	99c080e7          	jalr	-1636(ra) # 80000ec6 <myproc>
    80004532:	862a                	mv	a2,a0

    for (fd = 0; fd < NOFILE; fd++) {
    80004534:	0d050793          	addi	a5,a0,208
    80004538:	4501                	li	a0,0
    8000453a:	46c1                	li	a3,16
        if (p->ofile[fd] == 0) {
    8000453c:	6398                	ld	a4,0(a5)
    8000453e:	cb19                	beqz	a4,80004554 <fdalloc+0x36>
    for (fd = 0; fd < NOFILE; fd++) {
    80004540:	2505                	addiw	a0,a0,1
    80004542:	07a1                	addi	a5,a5,8
    80004544:	fed51ce3          	bne	a0,a3,8000453c <fdalloc+0x1e>
            p->ofile[fd] = f;
            return fd;
        }
    }
    return -1;
    80004548:	557d                	li	a0,-1
}
    8000454a:	60e2                	ld	ra,24(sp)
    8000454c:	6442                	ld	s0,16(sp)
    8000454e:	64a2                	ld	s1,8(sp)
    80004550:	6105                	addi	sp,sp,32
    80004552:	8082                	ret
            p->ofile[fd] = f;
    80004554:	01a50793          	addi	a5,a0,26
    80004558:	078e                	slli	a5,a5,0x3
    8000455a:	963e                	add	a2,a2,a5
    8000455c:	e204                	sd	s1,0(a2)
            return fd;
    8000455e:	b7f5                	j	8000454a <fdalloc+0x2c>

0000000080004560 <create>:
    iunlockput(dp);
    end_op();
    return -1;
}

static struct inode *create(char *path, short type, short major, short minor) {
    80004560:	715d                	addi	sp,sp,-80
    80004562:	e486                	sd	ra,72(sp)
    80004564:	e0a2                	sd	s0,64(sp)
    80004566:	fc26                	sd	s1,56(sp)
    80004568:	f84a                	sd	s2,48(sp)
    8000456a:	f44e                	sd	s3,40(sp)
    8000456c:	f052                	sd	s4,32(sp)
    8000456e:	ec56                	sd	s5,24(sp)
    80004570:	0880                	addi	s0,sp,80
    80004572:	8aae                	mv	s5,a1
    80004574:	8a32                	mv	s4,a2
    80004576:	89b6                	mv	s3,a3
    struct inode *ip, *dp;
    char name[DIRSIZ];

    if ((dp = nameiparent(path, name)) == 0)
    80004578:	fb040593          	addi	a1,s0,-80
    8000457c:	fffff097          	auipc	ra,0xfffff
    80004580:	e14080e7          	jalr	-492(ra) # 80003390 <nameiparent>
    80004584:	892a                	mv	s2,a0
    80004586:	12050c63          	beqz	a0,800046be <create+0x15e>
        return 0;

    ilock(dp);
    8000458a:	ffffe097          	auipc	ra,0xffffe
    8000458e:	616080e7          	jalr	1558(ra) # 80002ba0 <ilock>

    if ((ip = dirlookup(dp, name, 0)) != 0) {
    80004592:	4601                	li	a2,0
    80004594:	fb040593          	addi	a1,s0,-80
    80004598:	854a                	mv	a0,s2
    8000459a:	fffff097          	auipc	ra,0xfffff
    8000459e:	b06080e7          	jalr	-1274(ra) # 800030a0 <dirlookup>
    800045a2:	84aa                	mv	s1,a0
    800045a4:	c539                	beqz	a0,800045f2 <create+0x92>
        iunlockput(dp);
    800045a6:	854a                	mv	a0,s2
    800045a8:	fffff097          	auipc	ra,0xfffff
    800045ac:	85e080e7          	jalr	-1954(ra) # 80002e06 <iunlockput>
        ilock(ip);
    800045b0:	8526                	mv	a0,s1
    800045b2:	ffffe097          	auipc	ra,0xffffe
    800045b6:	5ee080e7          	jalr	1518(ra) # 80002ba0 <ilock>
        if (type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    800045ba:	4789                	li	a5,2
    800045bc:	02fa9463          	bne	s5,a5,800045e4 <create+0x84>
    800045c0:	0444d783          	lhu	a5,68(s1)
    800045c4:	37f9                	addiw	a5,a5,-2
    800045c6:	17c2                	slli	a5,a5,0x30
    800045c8:	93c1                	srli	a5,a5,0x30
    800045ca:	4705                	li	a4,1
    800045cc:	00f76c63          	bltu	a4,a5,800045e4 <create+0x84>
        panic("create: dirlink");

    iunlockput(dp);

    return ip;
}
    800045d0:	8526                	mv	a0,s1
    800045d2:	60a6                	ld	ra,72(sp)
    800045d4:	6406                	ld	s0,64(sp)
    800045d6:	74e2                	ld	s1,56(sp)
    800045d8:	7942                	ld	s2,48(sp)
    800045da:	79a2                	ld	s3,40(sp)
    800045dc:	7a02                	ld	s4,32(sp)
    800045de:	6ae2                	ld	s5,24(sp)
    800045e0:	6161                	addi	sp,sp,80
    800045e2:	8082                	ret
        iunlockput(ip);
    800045e4:	8526                	mv	a0,s1
    800045e6:	fffff097          	auipc	ra,0xfffff
    800045ea:	820080e7          	jalr	-2016(ra) # 80002e06 <iunlockput>
        return 0;
    800045ee:	4481                	li	s1,0
    800045f0:	b7c5                	j	800045d0 <create+0x70>
    if ((ip = ialloc(dp->dev, type)) == 0)
    800045f2:	85d6                	mv	a1,s5
    800045f4:	00092503          	lw	a0,0(s2)
    800045f8:	ffffe097          	auipc	ra,0xffffe
    800045fc:	414080e7          	jalr	1044(ra) # 80002a0c <ialloc>
    80004600:	84aa                	mv	s1,a0
    80004602:	c139                	beqz	a0,80004648 <create+0xe8>
    ilock(ip);
    80004604:	ffffe097          	auipc	ra,0xffffe
    80004608:	59c080e7          	jalr	1436(ra) # 80002ba0 <ilock>
    ip->major = major;
    8000460c:	05449323          	sh	s4,70(s1)
    ip->minor = minor;
    80004610:	05349423          	sh	s3,72(s1)
    ip->nlink = 1;
    80004614:	4985                	li	s3,1
    80004616:	05349523          	sh	s3,74(s1)
    iupdate(ip);
    8000461a:	8526                	mv	a0,s1
    8000461c:	ffffe097          	auipc	ra,0xffffe
    80004620:	4b8080e7          	jalr	1208(ra) # 80002ad4 <iupdate>
    if (type == T_DIR) { // Create . and .. entries.
    80004624:	033a8a63          	beq	s5,s3,80004658 <create+0xf8>
    if (dirlink(dp, name, ip->inum) < 0)
    80004628:	40d0                	lw	a2,4(s1)
    8000462a:	fb040593          	addi	a1,s0,-80
    8000462e:	854a                	mv	a0,s2
    80004630:	fffff097          	auipc	ra,0xfffff
    80004634:	c80080e7          	jalr	-896(ra) # 800032b0 <dirlink>
    80004638:	06054b63          	bltz	a0,800046ae <create+0x14e>
    iunlockput(dp);
    8000463c:	854a                	mv	a0,s2
    8000463e:	ffffe097          	auipc	ra,0xffffe
    80004642:	7c8080e7          	jalr	1992(ra) # 80002e06 <iunlockput>
    return ip;
    80004646:	b769                	j	800045d0 <create+0x70>
        panic("create: ialloc");
    80004648:	00004517          	auipc	a0,0x4
    8000464c:	fe850513          	addi	a0,a0,-24 # 80008630 <etext+0x630>
    80004650:	00001097          	auipc	ra,0x1
    80004654:	742080e7          	jalr	1858(ra) # 80005d92 <panic>
        dp->nlink++;     // for ".."
    80004658:	04a95783          	lhu	a5,74(s2)
    8000465c:	2785                	addiw	a5,a5,1
    8000465e:	04f91523          	sh	a5,74(s2)
        iupdate(dp);
    80004662:	854a                	mv	a0,s2
    80004664:	ffffe097          	auipc	ra,0xffffe
    80004668:	470080e7          	jalr	1136(ra) # 80002ad4 <iupdate>
        if (dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    8000466c:	40d0                	lw	a2,4(s1)
    8000466e:	00004597          	auipc	a1,0x4
    80004672:	fd258593          	addi	a1,a1,-46 # 80008640 <etext+0x640>
    80004676:	8526                	mv	a0,s1
    80004678:	fffff097          	auipc	ra,0xfffff
    8000467c:	c38080e7          	jalr	-968(ra) # 800032b0 <dirlink>
    80004680:	00054f63          	bltz	a0,8000469e <create+0x13e>
    80004684:	00492603          	lw	a2,4(s2)
    80004688:	00004597          	auipc	a1,0x4
    8000468c:	fc058593          	addi	a1,a1,-64 # 80008648 <etext+0x648>
    80004690:	8526                	mv	a0,s1
    80004692:	fffff097          	auipc	ra,0xfffff
    80004696:	c1e080e7          	jalr	-994(ra) # 800032b0 <dirlink>
    8000469a:	f80557e3          	bgez	a0,80004628 <create+0xc8>
            panic("create dots");
    8000469e:	00004517          	auipc	a0,0x4
    800046a2:	fb250513          	addi	a0,a0,-78 # 80008650 <etext+0x650>
    800046a6:	00001097          	auipc	ra,0x1
    800046aa:	6ec080e7          	jalr	1772(ra) # 80005d92 <panic>
        panic("create: dirlink");
    800046ae:	00004517          	auipc	a0,0x4
    800046b2:	fb250513          	addi	a0,a0,-78 # 80008660 <etext+0x660>
    800046b6:	00001097          	auipc	ra,0x1
    800046ba:	6dc080e7          	jalr	1756(ra) # 80005d92 <panic>
        return 0;
    800046be:	84aa                	mv	s1,a0
    800046c0:	bf01                	j	800045d0 <create+0x70>

00000000800046c2 <sys_dup>:
uint64 sys_dup(void) {
    800046c2:	7179                	addi	sp,sp,-48
    800046c4:	f406                	sd	ra,40(sp)
    800046c6:	f022                	sd	s0,32(sp)
    800046c8:	1800                	addi	s0,sp,48
    if (argfd(0, 0, &f) < 0)
    800046ca:	fd840613          	addi	a2,s0,-40
    800046ce:	4581                	li	a1,0
    800046d0:	4501                	li	a0,0
    800046d2:	00000097          	auipc	ra,0x0
    800046d6:	de4080e7          	jalr	-540(ra) # 800044b6 <argfd>
        return -1;
    800046da:	57fd                	li	a5,-1
    if (argfd(0, 0, &f) < 0)
    800046dc:	02054763          	bltz	a0,8000470a <sys_dup+0x48>
    800046e0:	ec26                	sd	s1,24(sp)
    800046e2:	e84a                	sd	s2,16(sp)
    if ((fd = fdalloc(f)) < 0)
    800046e4:	fd843903          	ld	s2,-40(s0)
    800046e8:	854a                	mv	a0,s2
    800046ea:	00000097          	auipc	ra,0x0
    800046ee:	e34080e7          	jalr	-460(ra) # 8000451e <fdalloc>
    800046f2:	84aa                	mv	s1,a0
        return -1;
    800046f4:	57fd                	li	a5,-1
    if ((fd = fdalloc(f)) < 0)
    800046f6:	00054f63          	bltz	a0,80004714 <sys_dup+0x52>
    filedup(f);
    800046fa:	854a                	mv	a0,s2
    800046fc:	fffff097          	auipc	ra,0xfffff
    80004700:	2ee080e7          	jalr	750(ra) # 800039ea <filedup>
    return fd;
    80004704:	87a6                	mv	a5,s1
    80004706:	64e2                	ld	s1,24(sp)
    80004708:	6942                	ld	s2,16(sp)
}
    8000470a:	853e                	mv	a0,a5
    8000470c:	70a2                	ld	ra,40(sp)
    8000470e:	7402                	ld	s0,32(sp)
    80004710:	6145                	addi	sp,sp,48
    80004712:	8082                	ret
    80004714:	64e2                	ld	s1,24(sp)
    80004716:	6942                	ld	s2,16(sp)
    80004718:	bfcd                	j	8000470a <sys_dup+0x48>

000000008000471a <sys_read>:
uint64 sys_read(void) {
    8000471a:	7179                	addi	sp,sp,-48
    8000471c:	f406                	sd	ra,40(sp)
    8000471e:	f022                	sd	s0,32(sp)
    80004720:	1800                	addi	s0,sp,48
    if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004722:	fe840613          	addi	a2,s0,-24
    80004726:	4581                	li	a1,0
    80004728:	4501                	li	a0,0
    8000472a:	00000097          	auipc	ra,0x0
    8000472e:	d8c080e7          	jalr	-628(ra) # 800044b6 <argfd>
        return -1;
    80004732:	57fd                	li	a5,-1
    if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004734:	04054163          	bltz	a0,80004776 <sys_read+0x5c>
    80004738:	fe440593          	addi	a1,s0,-28
    8000473c:	4509                	li	a0,2
    8000473e:	ffffe097          	auipc	ra,0xffffe
    80004742:	882080e7          	jalr	-1918(ra) # 80001fc0 <argint>
        return -1;
    80004746:	57fd                	li	a5,-1
    if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004748:	02054763          	bltz	a0,80004776 <sys_read+0x5c>
    8000474c:	fd840593          	addi	a1,s0,-40
    80004750:	4505                	li	a0,1
    80004752:	ffffe097          	auipc	ra,0xffffe
    80004756:	890080e7          	jalr	-1904(ra) # 80001fe2 <argaddr>
        return -1;
    8000475a:	57fd                	li	a5,-1
    if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000475c:	00054d63          	bltz	a0,80004776 <sys_read+0x5c>
    return fileread(f, p, n);
    80004760:	fe442603          	lw	a2,-28(s0)
    80004764:	fd843583          	ld	a1,-40(s0)
    80004768:	fe843503          	ld	a0,-24(s0)
    8000476c:	fffff097          	auipc	ra,0xfffff
    80004770:	424080e7          	jalr	1060(ra) # 80003b90 <fileread>
    80004774:	87aa                	mv	a5,a0
}
    80004776:	853e                	mv	a0,a5
    80004778:	70a2                	ld	ra,40(sp)
    8000477a:	7402                	ld	s0,32(sp)
    8000477c:	6145                	addi	sp,sp,48
    8000477e:	8082                	ret

0000000080004780 <sys_write>:
uint64 sys_write(void) {
    80004780:	7179                	addi	sp,sp,-48
    80004782:	f406                	sd	ra,40(sp)
    80004784:	f022                	sd	s0,32(sp)
    80004786:	1800                	addi	s0,sp,48
    if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004788:	fe840613          	addi	a2,s0,-24
    8000478c:	4581                	li	a1,0
    8000478e:	4501                	li	a0,0
    80004790:	00000097          	auipc	ra,0x0
    80004794:	d26080e7          	jalr	-730(ra) # 800044b6 <argfd>
        return -1;
    80004798:	57fd                	li	a5,-1
    if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000479a:	04054163          	bltz	a0,800047dc <sys_write+0x5c>
    8000479e:	fe440593          	addi	a1,s0,-28
    800047a2:	4509                	li	a0,2
    800047a4:	ffffe097          	auipc	ra,0xffffe
    800047a8:	81c080e7          	jalr	-2020(ra) # 80001fc0 <argint>
        return -1;
    800047ac:	57fd                	li	a5,-1
    if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800047ae:	02054763          	bltz	a0,800047dc <sys_write+0x5c>
    800047b2:	fd840593          	addi	a1,s0,-40
    800047b6:	4505                	li	a0,1
    800047b8:	ffffe097          	auipc	ra,0xffffe
    800047bc:	82a080e7          	jalr	-2006(ra) # 80001fe2 <argaddr>
        return -1;
    800047c0:	57fd                	li	a5,-1
    if (argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800047c2:	00054d63          	bltz	a0,800047dc <sys_write+0x5c>
    return filewrite(f, p, n);
    800047c6:	fe442603          	lw	a2,-28(s0)
    800047ca:	fd843583          	ld	a1,-40(s0)
    800047ce:	fe843503          	ld	a0,-24(s0)
    800047d2:	fffff097          	auipc	ra,0xfffff
    800047d6:	490080e7          	jalr	1168(ra) # 80003c62 <filewrite>
    800047da:	87aa                	mv	a5,a0
}
    800047dc:	853e                	mv	a0,a5
    800047de:	70a2                	ld	ra,40(sp)
    800047e0:	7402                	ld	s0,32(sp)
    800047e2:	6145                	addi	sp,sp,48
    800047e4:	8082                	ret

00000000800047e6 <sys_close>:
uint64 sys_close(void) {
    800047e6:	1101                	addi	sp,sp,-32
    800047e8:	ec06                	sd	ra,24(sp)
    800047ea:	e822                	sd	s0,16(sp)
    800047ec:	1000                	addi	s0,sp,32
    if (argfd(0, &fd, &f) < 0)
    800047ee:	fe040613          	addi	a2,s0,-32
    800047f2:	fec40593          	addi	a1,s0,-20
    800047f6:	4501                	li	a0,0
    800047f8:	00000097          	auipc	ra,0x0
    800047fc:	cbe080e7          	jalr	-834(ra) # 800044b6 <argfd>
        return -1;
    80004800:	57fd                	li	a5,-1
    if (argfd(0, &fd, &f) < 0)
    80004802:	02054463          	bltz	a0,8000482a <sys_close+0x44>
    myproc()->ofile[fd] = 0;
    80004806:	ffffc097          	auipc	ra,0xffffc
    8000480a:	6c0080e7          	jalr	1728(ra) # 80000ec6 <myproc>
    8000480e:	fec42783          	lw	a5,-20(s0)
    80004812:	07e9                	addi	a5,a5,26
    80004814:	078e                	slli	a5,a5,0x3
    80004816:	953e                	add	a0,a0,a5
    80004818:	00053023          	sd	zero,0(a0)
    fileclose(f);
    8000481c:	fe043503          	ld	a0,-32(s0)
    80004820:	fffff097          	auipc	ra,0xfffff
    80004824:	21c080e7          	jalr	540(ra) # 80003a3c <fileclose>
    return 0;
    80004828:	4781                	li	a5,0
}
    8000482a:	853e                	mv	a0,a5
    8000482c:	60e2                	ld	ra,24(sp)
    8000482e:	6442                	ld	s0,16(sp)
    80004830:	6105                	addi	sp,sp,32
    80004832:	8082                	ret

0000000080004834 <sys_fstat>:
uint64 sys_fstat(void) {
    80004834:	1101                	addi	sp,sp,-32
    80004836:	ec06                	sd	ra,24(sp)
    80004838:	e822                	sd	s0,16(sp)
    8000483a:	1000                	addi	s0,sp,32
    if (argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    8000483c:	fe840613          	addi	a2,s0,-24
    80004840:	4581                	li	a1,0
    80004842:	4501                	li	a0,0
    80004844:	00000097          	auipc	ra,0x0
    80004848:	c72080e7          	jalr	-910(ra) # 800044b6 <argfd>
        return -1;
    8000484c:	57fd                	li	a5,-1
    if (argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    8000484e:	02054563          	bltz	a0,80004878 <sys_fstat+0x44>
    80004852:	fe040593          	addi	a1,s0,-32
    80004856:	4505                	li	a0,1
    80004858:	ffffd097          	auipc	ra,0xffffd
    8000485c:	78a080e7          	jalr	1930(ra) # 80001fe2 <argaddr>
        return -1;
    80004860:	57fd                	li	a5,-1
    if (argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004862:	00054b63          	bltz	a0,80004878 <sys_fstat+0x44>
    return filestat(f, st);
    80004866:	fe043583          	ld	a1,-32(s0)
    8000486a:	fe843503          	ld	a0,-24(s0)
    8000486e:	fffff097          	auipc	ra,0xfffff
    80004872:	2b0080e7          	jalr	688(ra) # 80003b1e <filestat>
    80004876:	87aa                	mv	a5,a0
}
    80004878:	853e                	mv	a0,a5
    8000487a:	60e2                	ld	ra,24(sp)
    8000487c:	6442                	ld	s0,16(sp)
    8000487e:	6105                	addi	sp,sp,32
    80004880:	8082                	ret

0000000080004882 <sys_link>:
uint64 sys_link(void) {
    80004882:	7169                	addi	sp,sp,-304
    80004884:	f606                	sd	ra,296(sp)
    80004886:	f222                	sd	s0,288(sp)
    80004888:	1a00                	addi	s0,sp,304
    if (argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000488a:	08000613          	li	a2,128
    8000488e:	ed040593          	addi	a1,s0,-304
    80004892:	4501                	li	a0,0
    80004894:	ffffd097          	auipc	ra,0xffffd
    80004898:	770080e7          	jalr	1904(ra) # 80002004 <argstr>
        return -1;
    8000489c:	57fd                	li	a5,-1
    if (argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000489e:	12054663          	bltz	a0,800049ca <sys_link+0x148>
    800048a2:	08000613          	li	a2,128
    800048a6:	f5040593          	addi	a1,s0,-176
    800048aa:	4505                	li	a0,1
    800048ac:	ffffd097          	auipc	ra,0xffffd
    800048b0:	758080e7          	jalr	1880(ra) # 80002004 <argstr>
        return -1;
    800048b4:	57fd                	li	a5,-1
    if (argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800048b6:	10054a63          	bltz	a0,800049ca <sys_link+0x148>
    800048ba:	ee26                	sd	s1,280(sp)
    begin_op();
    800048bc:	fffff097          	auipc	ra,0xfffff
    800048c0:	cb6080e7          	jalr	-842(ra) # 80003572 <begin_op>
    if ((ip = namei(old)) == 0) {
    800048c4:	ed040513          	addi	a0,s0,-304
    800048c8:	fffff097          	auipc	ra,0xfffff
    800048cc:	aaa080e7          	jalr	-1366(ra) # 80003372 <namei>
    800048d0:	84aa                	mv	s1,a0
    800048d2:	c949                	beqz	a0,80004964 <sys_link+0xe2>
    ilock(ip);
    800048d4:	ffffe097          	auipc	ra,0xffffe
    800048d8:	2cc080e7          	jalr	716(ra) # 80002ba0 <ilock>
    if (ip->type == T_DIR) {
    800048dc:	04449703          	lh	a4,68(s1)
    800048e0:	4785                	li	a5,1
    800048e2:	08f70863          	beq	a4,a5,80004972 <sys_link+0xf0>
    800048e6:	ea4a                	sd	s2,272(sp)
    ip->nlink++;
    800048e8:	04a4d783          	lhu	a5,74(s1)
    800048ec:	2785                	addiw	a5,a5,1
    800048ee:	04f49523          	sh	a5,74(s1)
    iupdate(ip);
    800048f2:	8526                	mv	a0,s1
    800048f4:	ffffe097          	auipc	ra,0xffffe
    800048f8:	1e0080e7          	jalr	480(ra) # 80002ad4 <iupdate>
    iunlock(ip);
    800048fc:	8526                	mv	a0,s1
    800048fe:	ffffe097          	auipc	ra,0xffffe
    80004902:	368080e7          	jalr	872(ra) # 80002c66 <iunlock>
    if ((dp = nameiparent(new, name)) == 0)
    80004906:	fd040593          	addi	a1,s0,-48
    8000490a:	f5040513          	addi	a0,s0,-176
    8000490e:	fffff097          	auipc	ra,0xfffff
    80004912:	a82080e7          	jalr	-1406(ra) # 80003390 <nameiparent>
    80004916:	892a                	mv	s2,a0
    80004918:	cd35                	beqz	a0,80004994 <sys_link+0x112>
    ilock(dp);
    8000491a:	ffffe097          	auipc	ra,0xffffe
    8000491e:	286080e7          	jalr	646(ra) # 80002ba0 <ilock>
    if (dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0) {
    80004922:	00092703          	lw	a4,0(s2)
    80004926:	409c                	lw	a5,0(s1)
    80004928:	06f71163          	bne	a4,a5,8000498a <sys_link+0x108>
    8000492c:	40d0                	lw	a2,4(s1)
    8000492e:	fd040593          	addi	a1,s0,-48
    80004932:	854a                	mv	a0,s2
    80004934:	fffff097          	auipc	ra,0xfffff
    80004938:	97c080e7          	jalr	-1668(ra) # 800032b0 <dirlink>
    8000493c:	04054763          	bltz	a0,8000498a <sys_link+0x108>
    iunlockput(dp);
    80004940:	854a                	mv	a0,s2
    80004942:	ffffe097          	auipc	ra,0xffffe
    80004946:	4c4080e7          	jalr	1220(ra) # 80002e06 <iunlockput>
    iput(ip);
    8000494a:	8526                	mv	a0,s1
    8000494c:	ffffe097          	auipc	ra,0xffffe
    80004950:	412080e7          	jalr	1042(ra) # 80002d5e <iput>
    end_op();
    80004954:	fffff097          	auipc	ra,0xfffff
    80004958:	c98080e7          	jalr	-872(ra) # 800035ec <end_op>
    return 0;
    8000495c:	4781                	li	a5,0
    8000495e:	64f2                	ld	s1,280(sp)
    80004960:	6952                	ld	s2,272(sp)
    80004962:	a0a5                	j	800049ca <sys_link+0x148>
        end_op();
    80004964:	fffff097          	auipc	ra,0xfffff
    80004968:	c88080e7          	jalr	-888(ra) # 800035ec <end_op>
        return -1;
    8000496c:	57fd                	li	a5,-1
    8000496e:	64f2                	ld	s1,280(sp)
    80004970:	a8a9                	j	800049ca <sys_link+0x148>
        iunlockput(ip);
    80004972:	8526                	mv	a0,s1
    80004974:	ffffe097          	auipc	ra,0xffffe
    80004978:	492080e7          	jalr	1170(ra) # 80002e06 <iunlockput>
        end_op();
    8000497c:	fffff097          	auipc	ra,0xfffff
    80004980:	c70080e7          	jalr	-912(ra) # 800035ec <end_op>
        return -1;
    80004984:	57fd                	li	a5,-1
    80004986:	64f2                	ld	s1,280(sp)
    80004988:	a089                	j	800049ca <sys_link+0x148>
        iunlockput(dp);
    8000498a:	854a                	mv	a0,s2
    8000498c:	ffffe097          	auipc	ra,0xffffe
    80004990:	47a080e7          	jalr	1146(ra) # 80002e06 <iunlockput>
    ilock(ip);
    80004994:	8526                	mv	a0,s1
    80004996:	ffffe097          	auipc	ra,0xffffe
    8000499a:	20a080e7          	jalr	522(ra) # 80002ba0 <ilock>
    ip->nlink--;
    8000499e:	04a4d783          	lhu	a5,74(s1)
    800049a2:	37fd                	addiw	a5,a5,-1
    800049a4:	04f49523          	sh	a5,74(s1)
    iupdate(ip);
    800049a8:	8526                	mv	a0,s1
    800049aa:	ffffe097          	auipc	ra,0xffffe
    800049ae:	12a080e7          	jalr	298(ra) # 80002ad4 <iupdate>
    iunlockput(ip);
    800049b2:	8526                	mv	a0,s1
    800049b4:	ffffe097          	auipc	ra,0xffffe
    800049b8:	452080e7          	jalr	1106(ra) # 80002e06 <iunlockput>
    end_op();
    800049bc:	fffff097          	auipc	ra,0xfffff
    800049c0:	c30080e7          	jalr	-976(ra) # 800035ec <end_op>
    return -1;
    800049c4:	57fd                	li	a5,-1
    800049c6:	64f2                	ld	s1,280(sp)
    800049c8:	6952                	ld	s2,272(sp)
}
    800049ca:	853e                	mv	a0,a5
    800049cc:	70b2                	ld	ra,296(sp)
    800049ce:	7412                	ld	s0,288(sp)
    800049d0:	6155                	addi	sp,sp,304
    800049d2:	8082                	ret

00000000800049d4 <sys_unlink>:
uint64 sys_unlink(void) {
    800049d4:	7151                	addi	sp,sp,-240
    800049d6:	f586                	sd	ra,232(sp)
    800049d8:	f1a2                	sd	s0,224(sp)
    800049da:	1980                	addi	s0,sp,240
    if (argstr(0, path, MAXPATH) < 0)
    800049dc:	08000613          	li	a2,128
    800049e0:	f3040593          	addi	a1,s0,-208
    800049e4:	4501                	li	a0,0
    800049e6:	ffffd097          	auipc	ra,0xffffd
    800049ea:	61e080e7          	jalr	1566(ra) # 80002004 <argstr>
    800049ee:	1a054a63          	bltz	a0,80004ba2 <sys_unlink+0x1ce>
    800049f2:	eda6                	sd	s1,216(sp)
    begin_op();
    800049f4:	fffff097          	auipc	ra,0xfffff
    800049f8:	b7e080e7          	jalr	-1154(ra) # 80003572 <begin_op>
    if ((dp = nameiparent(path, name)) == 0) {
    800049fc:	fb040593          	addi	a1,s0,-80
    80004a00:	f3040513          	addi	a0,s0,-208
    80004a04:	fffff097          	auipc	ra,0xfffff
    80004a08:	98c080e7          	jalr	-1652(ra) # 80003390 <nameiparent>
    80004a0c:	84aa                	mv	s1,a0
    80004a0e:	cd71                	beqz	a0,80004aea <sys_unlink+0x116>
    ilock(dp);
    80004a10:	ffffe097          	auipc	ra,0xffffe
    80004a14:	190080e7          	jalr	400(ra) # 80002ba0 <ilock>
    if (namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004a18:	00004597          	auipc	a1,0x4
    80004a1c:	c2858593          	addi	a1,a1,-984 # 80008640 <etext+0x640>
    80004a20:	fb040513          	addi	a0,s0,-80
    80004a24:	ffffe097          	auipc	ra,0xffffe
    80004a28:	662080e7          	jalr	1634(ra) # 80003086 <namecmp>
    80004a2c:	14050c63          	beqz	a0,80004b84 <sys_unlink+0x1b0>
    80004a30:	00004597          	auipc	a1,0x4
    80004a34:	c1858593          	addi	a1,a1,-1000 # 80008648 <etext+0x648>
    80004a38:	fb040513          	addi	a0,s0,-80
    80004a3c:	ffffe097          	auipc	ra,0xffffe
    80004a40:	64a080e7          	jalr	1610(ra) # 80003086 <namecmp>
    80004a44:	14050063          	beqz	a0,80004b84 <sys_unlink+0x1b0>
    80004a48:	e9ca                	sd	s2,208(sp)
    if ((ip = dirlookup(dp, name, &off)) == 0)
    80004a4a:	f2c40613          	addi	a2,s0,-212
    80004a4e:	fb040593          	addi	a1,s0,-80
    80004a52:	8526                	mv	a0,s1
    80004a54:	ffffe097          	auipc	ra,0xffffe
    80004a58:	64c080e7          	jalr	1612(ra) # 800030a0 <dirlookup>
    80004a5c:	892a                	mv	s2,a0
    80004a5e:	12050263          	beqz	a0,80004b82 <sys_unlink+0x1ae>
    ilock(ip);
    80004a62:	ffffe097          	auipc	ra,0xffffe
    80004a66:	13e080e7          	jalr	318(ra) # 80002ba0 <ilock>
    if (ip->nlink < 1)
    80004a6a:	04a91783          	lh	a5,74(s2)
    80004a6e:	08f05563          	blez	a5,80004af8 <sys_unlink+0x124>
    if (ip->type == T_DIR && !isdirempty(ip)) {
    80004a72:	04491703          	lh	a4,68(s2)
    80004a76:	4785                	li	a5,1
    80004a78:	08f70963          	beq	a4,a5,80004b0a <sys_unlink+0x136>
    memset(&de, 0, sizeof(de));
    80004a7c:	4641                	li	a2,16
    80004a7e:	4581                	li	a1,0
    80004a80:	fc040513          	addi	a0,s0,-64
    80004a84:	ffffb097          	auipc	ra,0xffffb
    80004a88:	740080e7          	jalr	1856(ra) # 800001c4 <memset>
    if (writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004a8c:	4741                	li	a4,16
    80004a8e:	f2c42683          	lw	a3,-212(s0)
    80004a92:	fc040613          	addi	a2,s0,-64
    80004a96:	4581                	li	a1,0
    80004a98:	8526                	mv	a0,s1
    80004a9a:	ffffe097          	auipc	ra,0xffffe
    80004a9e:	4c2080e7          	jalr	1218(ra) # 80002f5c <writei>
    80004aa2:	47c1                	li	a5,16
    80004aa4:	0af51b63          	bne	a0,a5,80004b5a <sys_unlink+0x186>
    if (ip->type == T_DIR) {
    80004aa8:	04491703          	lh	a4,68(s2)
    80004aac:	4785                	li	a5,1
    80004aae:	0af70f63          	beq	a4,a5,80004b6c <sys_unlink+0x198>
    iunlockput(dp);
    80004ab2:	8526                	mv	a0,s1
    80004ab4:	ffffe097          	auipc	ra,0xffffe
    80004ab8:	352080e7          	jalr	850(ra) # 80002e06 <iunlockput>
    ip->nlink--;
    80004abc:	04a95783          	lhu	a5,74(s2)
    80004ac0:	37fd                	addiw	a5,a5,-1
    80004ac2:	04f91523          	sh	a5,74(s2)
    iupdate(ip);
    80004ac6:	854a                	mv	a0,s2
    80004ac8:	ffffe097          	auipc	ra,0xffffe
    80004acc:	00c080e7          	jalr	12(ra) # 80002ad4 <iupdate>
    iunlockput(ip);
    80004ad0:	854a                	mv	a0,s2
    80004ad2:	ffffe097          	auipc	ra,0xffffe
    80004ad6:	334080e7          	jalr	820(ra) # 80002e06 <iunlockput>
    end_op();
    80004ada:	fffff097          	auipc	ra,0xfffff
    80004ade:	b12080e7          	jalr	-1262(ra) # 800035ec <end_op>
    return 0;
    80004ae2:	4501                	li	a0,0
    80004ae4:	64ee                	ld	s1,216(sp)
    80004ae6:	694e                	ld	s2,208(sp)
    80004ae8:	a84d                	j	80004b9a <sys_unlink+0x1c6>
        end_op();
    80004aea:	fffff097          	auipc	ra,0xfffff
    80004aee:	b02080e7          	jalr	-1278(ra) # 800035ec <end_op>
        return -1;
    80004af2:	557d                	li	a0,-1
    80004af4:	64ee                	ld	s1,216(sp)
    80004af6:	a055                	j	80004b9a <sys_unlink+0x1c6>
    80004af8:	e5ce                	sd	s3,200(sp)
        panic("unlink: nlink < 1");
    80004afa:	00004517          	auipc	a0,0x4
    80004afe:	b7650513          	addi	a0,a0,-1162 # 80008670 <etext+0x670>
    80004b02:	00001097          	auipc	ra,0x1
    80004b06:	290080e7          	jalr	656(ra) # 80005d92 <panic>
    for (off = 2 * sizeof(de); off < dp->size; off += sizeof(de)) {
    80004b0a:	04c92703          	lw	a4,76(s2)
    80004b0e:	02000793          	li	a5,32
    80004b12:	f6e7f5e3          	bgeu	a5,a4,80004a7c <sys_unlink+0xa8>
    80004b16:	e5ce                	sd	s3,200(sp)
    80004b18:	02000993          	li	s3,32
        if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004b1c:	4741                	li	a4,16
    80004b1e:	86ce                	mv	a3,s3
    80004b20:	f1840613          	addi	a2,s0,-232
    80004b24:	4581                	li	a1,0
    80004b26:	854a                	mv	a0,s2
    80004b28:	ffffe097          	auipc	ra,0xffffe
    80004b2c:	330080e7          	jalr	816(ra) # 80002e58 <readi>
    80004b30:	47c1                	li	a5,16
    80004b32:	00f51c63          	bne	a0,a5,80004b4a <sys_unlink+0x176>
        if (de.inum != 0)
    80004b36:	f1845783          	lhu	a5,-232(s0)
    80004b3a:	e7b5                	bnez	a5,80004ba6 <sys_unlink+0x1d2>
    for (off = 2 * sizeof(de); off < dp->size; off += sizeof(de)) {
    80004b3c:	29c1                	addiw	s3,s3,16
    80004b3e:	04c92783          	lw	a5,76(s2)
    80004b42:	fcf9ede3          	bltu	s3,a5,80004b1c <sys_unlink+0x148>
    80004b46:	69ae                	ld	s3,200(sp)
    80004b48:	bf15                	j	80004a7c <sys_unlink+0xa8>
            panic("isdirempty: readi");
    80004b4a:	00004517          	auipc	a0,0x4
    80004b4e:	b3e50513          	addi	a0,a0,-1218 # 80008688 <etext+0x688>
    80004b52:	00001097          	auipc	ra,0x1
    80004b56:	240080e7          	jalr	576(ra) # 80005d92 <panic>
    80004b5a:	e5ce                	sd	s3,200(sp)
        panic("unlink: writei");
    80004b5c:	00004517          	auipc	a0,0x4
    80004b60:	b4450513          	addi	a0,a0,-1212 # 800086a0 <etext+0x6a0>
    80004b64:	00001097          	auipc	ra,0x1
    80004b68:	22e080e7          	jalr	558(ra) # 80005d92 <panic>
        dp->nlink--;
    80004b6c:	04a4d783          	lhu	a5,74(s1)
    80004b70:	37fd                	addiw	a5,a5,-1
    80004b72:	04f49523          	sh	a5,74(s1)
        iupdate(dp);
    80004b76:	8526                	mv	a0,s1
    80004b78:	ffffe097          	auipc	ra,0xffffe
    80004b7c:	f5c080e7          	jalr	-164(ra) # 80002ad4 <iupdate>
    80004b80:	bf0d                	j	80004ab2 <sys_unlink+0xde>
    80004b82:	694e                	ld	s2,208(sp)
    iunlockput(dp);
    80004b84:	8526                	mv	a0,s1
    80004b86:	ffffe097          	auipc	ra,0xffffe
    80004b8a:	280080e7          	jalr	640(ra) # 80002e06 <iunlockput>
    end_op();
    80004b8e:	fffff097          	auipc	ra,0xfffff
    80004b92:	a5e080e7          	jalr	-1442(ra) # 800035ec <end_op>
    return -1;
    80004b96:	557d                	li	a0,-1
    80004b98:	64ee                	ld	s1,216(sp)
}
    80004b9a:	70ae                	ld	ra,232(sp)
    80004b9c:	740e                	ld	s0,224(sp)
    80004b9e:	616d                	addi	sp,sp,240
    80004ba0:	8082                	ret
        return -1;
    80004ba2:	557d                	li	a0,-1
    80004ba4:	bfdd                	j	80004b9a <sys_unlink+0x1c6>
        iunlockput(ip);
    80004ba6:	854a                	mv	a0,s2
    80004ba8:	ffffe097          	auipc	ra,0xffffe
    80004bac:	25e080e7          	jalr	606(ra) # 80002e06 <iunlockput>
        goto bad;
    80004bb0:	694e                	ld	s2,208(sp)
    80004bb2:	69ae                	ld	s3,200(sp)
    80004bb4:	bfc1                	j	80004b84 <sys_unlink+0x1b0>

0000000080004bb6 <sys_open>:

uint64 sys_open(void) {
    80004bb6:	7131                	addi	sp,sp,-192
    80004bb8:	fd06                	sd	ra,184(sp)
    80004bba:	f922                	sd	s0,176(sp)
    80004bbc:	f526                	sd	s1,168(sp)
    80004bbe:	0180                	addi	s0,sp,192
    int fd, omode;
    struct file *f;
    struct inode *ip;
    int n;

    if ((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004bc0:	08000613          	li	a2,128
    80004bc4:	f5040593          	addi	a1,s0,-176
    80004bc8:	4501                	li	a0,0
    80004bca:	ffffd097          	auipc	ra,0xffffd
    80004bce:	43a080e7          	jalr	1082(ra) # 80002004 <argstr>
        return -1;
    80004bd2:	54fd                	li	s1,-1
    if ((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004bd4:	0c054463          	bltz	a0,80004c9c <sys_open+0xe6>
    80004bd8:	f4c40593          	addi	a1,s0,-180
    80004bdc:	4505                	li	a0,1
    80004bde:	ffffd097          	auipc	ra,0xffffd
    80004be2:	3e2080e7          	jalr	994(ra) # 80001fc0 <argint>
    80004be6:	0a054b63          	bltz	a0,80004c9c <sys_open+0xe6>
    80004bea:	f14a                	sd	s2,160(sp)

    begin_op();
    80004bec:	fffff097          	auipc	ra,0xfffff
    80004bf0:	986080e7          	jalr	-1658(ra) # 80003572 <begin_op>

    if (omode & O_CREATE) {
    80004bf4:	f4c42783          	lw	a5,-180(s0)
    80004bf8:	2007f793          	andi	a5,a5,512
    80004bfc:	cfc5                	beqz	a5,80004cb4 <sys_open+0xfe>
        ip = create(path, T_FILE, 0, 0);
    80004bfe:	4681                	li	a3,0
    80004c00:	4601                	li	a2,0
    80004c02:	4589                	li	a1,2
    80004c04:	f5040513          	addi	a0,s0,-176
    80004c08:	00000097          	auipc	ra,0x0
    80004c0c:	958080e7          	jalr	-1704(ra) # 80004560 <create>
    80004c10:	892a                	mv	s2,a0
        if (ip == 0) {
    80004c12:	c959                	beqz	a0,80004ca8 <sys_open+0xf2>
            end_op();
            return -1;
        }
    }

    if (ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)) {
    80004c14:	04491703          	lh	a4,68(s2)
    80004c18:	478d                	li	a5,3
    80004c1a:	00f71763          	bne	a4,a5,80004c28 <sys_open+0x72>
    80004c1e:	04695703          	lhu	a4,70(s2)
    80004c22:	47a5                	li	a5,9
    80004c24:	0ce7ef63          	bltu	a5,a4,80004d02 <sys_open+0x14c>
    80004c28:	ed4e                	sd	s3,152(sp)
        iunlockput(ip);
        end_op();
        return -1;
    }

    if ((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0) {
    80004c2a:	fffff097          	auipc	ra,0xfffff
    80004c2e:	d56080e7          	jalr	-682(ra) # 80003980 <filealloc>
    80004c32:	89aa                	mv	s3,a0
    80004c34:	c965                	beqz	a0,80004d24 <sys_open+0x16e>
    80004c36:	00000097          	auipc	ra,0x0
    80004c3a:	8e8080e7          	jalr	-1816(ra) # 8000451e <fdalloc>
    80004c3e:	84aa                	mv	s1,a0
    80004c40:	0c054d63          	bltz	a0,80004d1a <sys_open+0x164>
        iunlockput(ip);
        end_op();
        return -1;
    }

    if (ip->type == T_DEVICE) {
    80004c44:	04491703          	lh	a4,68(s2)
    80004c48:	478d                	li	a5,3
    80004c4a:	0ef70a63          	beq	a4,a5,80004d3e <sys_open+0x188>
        f->type = FD_DEVICE;
        f->major = ip->major;
    } else {
        f->type = FD_INODE;
    80004c4e:	4789                	li	a5,2
    80004c50:	00f9a023          	sw	a5,0(s3)
        f->off = 0;
    80004c54:	0209a023          	sw	zero,32(s3)
    }
    f->ip = ip;
    80004c58:	0129bc23          	sd	s2,24(s3)
    f->readable = !(omode & O_WRONLY);
    80004c5c:	f4c42783          	lw	a5,-180(s0)
    80004c60:	0017c713          	xori	a4,a5,1
    80004c64:	8b05                	andi	a4,a4,1
    80004c66:	00e98423          	sb	a4,8(s3)
    f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004c6a:	0037f713          	andi	a4,a5,3
    80004c6e:	00e03733          	snez	a4,a4
    80004c72:	00e984a3          	sb	a4,9(s3)

    if ((omode & O_TRUNC) && ip->type == T_FILE) {
    80004c76:	4007f793          	andi	a5,a5,1024
    80004c7a:	c791                	beqz	a5,80004c86 <sys_open+0xd0>
    80004c7c:	04491703          	lh	a4,68(s2)
    80004c80:	4789                	li	a5,2
    80004c82:	0cf70563          	beq	a4,a5,80004d4c <sys_open+0x196>
        itrunc(ip);
    }

    iunlock(ip);
    80004c86:	854a                	mv	a0,s2
    80004c88:	ffffe097          	auipc	ra,0xffffe
    80004c8c:	fde080e7          	jalr	-34(ra) # 80002c66 <iunlock>
    end_op();
    80004c90:	fffff097          	auipc	ra,0xfffff
    80004c94:	95c080e7          	jalr	-1700(ra) # 800035ec <end_op>
    80004c98:	790a                	ld	s2,160(sp)
    80004c9a:	69ea                	ld	s3,152(sp)

    return fd;
}
    80004c9c:	8526                	mv	a0,s1
    80004c9e:	70ea                	ld	ra,184(sp)
    80004ca0:	744a                	ld	s0,176(sp)
    80004ca2:	74aa                	ld	s1,168(sp)
    80004ca4:	6129                	addi	sp,sp,192
    80004ca6:	8082                	ret
            end_op();
    80004ca8:	fffff097          	auipc	ra,0xfffff
    80004cac:	944080e7          	jalr	-1724(ra) # 800035ec <end_op>
            return -1;
    80004cb0:	790a                	ld	s2,160(sp)
    80004cb2:	b7ed                	j	80004c9c <sys_open+0xe6>
        if ((ip = namei(path)) == 0) {
    80004cb4:	f5040513          	addi	a0,s0,-176
    80004cb8:	ffffe097          	auipc	ra,0xffffe
    80004cbc:	6ba080e7          	jalr	1722(ra) # 80003372 <namei>
    80004cc0:	892a                	mv	s2,a0
    80004cc2:	c90d                	beqz	a0,80004cf4 <sys_open+0x13e>
        ilock(ip);
    80004cc4:	ffffe097          	auipc	ra,0xffffe
    80004cc8:	edc080e7          	jalr	-292(ra) # 80002ba0 <ilock>
        if (ip->type == T_DIR && omode != O_RDONLY) {
    80004ccc:	04491703          	lh	a4,68(s2)
    80004cd0:	4785                	li	a5,1
    80004cd2:	f4f711e3          	bne	a4,a5,80004c14 <sys_open+0x5e>
    80004cd6:	f4c42783          	lw	a5,-180(s0)
    80004cda:	d7b9                	beqz	a5,80004c28 <sys_open+0x72>
            iunlockput(ip);
    80004cdc:	854a                	mv	a0,s2
    80004cde:	ffffe097          	auipc	ra,0xffffe
    80004ce2:	128080e7          	jalr	296(ra) # 80002e06 <iunlockput>
            end_op();
    80004ce6:	fffff097          	auipc	ra,0xfffff
    80004cea:	906080e7          	jalr	-1786(ra) # 800035ec <end_op>
            return -1;
    80004cee:	54fd                	li	s1,-1
    80004cf0:	790a                	ld	s2,160(sp)
    80004cf2:	b76d                	j	80004c9c <sys_open+0xe6>
            end_op();
    80004cf4:	fffff097          	auipc	ra,0xfffff
    80004cf8:	8f8080e7          	jalr	-1800(ra) # 800035ec <end_op>
            return -1;
    80004cfc:	54fd                	li	s1,-1
    80004cfe:	790a                	ld	s2,160(sp)
    80004d00:	bf71                	j	80004c9c <sys_open+0xe6>
        iunlockput(ip);
    80004d02:	854a                	mv	a0,s2
    80004d04:	ffffe097          	auipc	ra,0xffffe
    80004d08:	102080e7          	jalr	258(ra) # 80002e06 <iunlockput>
        end_op();
    80004d0c:	fffff097          	auipc	ra,0xfffff
    80004d10:	8e0080e7          	jalr	-1824(ra) # 800035ec <end_op>
        return -1;
    80004d14:	54fd                	li	s1,-1
    80004d16:	790a                	ld	s2,160(sp)
    80004d18:	b751                	j	80004c9c <sys_open+0xe6>
            fileclose(f);
    80004d1a:	854e                	mv	a0,s3
    80004d1c:	fffff097          	auipc	ra,0xfffff
    80004d20:	d20080e7          	jalr	-736(ra) # 80003a3c <fileclose>
        iunlockput(ip);
    80004d24:	854a                	mv	a0,s2
    80004d26:	ffffe097          	auipc	ra,0xffffe
    80004d2a:	0e0080e7          	jalr	224(ra) # 80002e06 <iunlockput>
        end_op();
    80004d2e:	fffff097          	auipc	ra,0xfffff
    80004d32:	8be080e7          	jalr	-1858(ra) # 800035ec <end_op>
        return -1;
    80004d36:	54fd                	li	s1,-1
    80004d38:	790a                	ld	s2,160(sp)
    80004d3a:	69ea                	ld	s3,152(sp)
    80004d3c:	b785                	j	80004c9c <sys_open+0xe6>
        f->type = FD_DEVICE;
    80004d3e:	00f9a023          	sw	a5,0(s3)
        f->major = ip->major;
    80004d42:	04691783          	lh	a5,70(s2)
    80004d46:	02f99223          	sh	a5,36(s3)
    80004d4a:	b739                	j	80004c58 <sys_open+0xa2>
        itrunc(ip);
    80004d4c:	854a                	mv	a0,s2
    80004d4e:	ffffe097          	auipc	ra,0xffffe
    80004d52:	f64080e7          	jalr	-156(ra) # 80002cb2 <itrunc>
    80004d56:	bf05                	j	80004c86 <sys_open+0xd0>

0000000080004d58 <sys_mkdir>:

uint64 sys_mkdir(void) {
    80004d58:	7175                	addi	sp,sp,-144
    80004d5a:	e506                	sd	ra,136(sp)
    80004d5c:	e122                	sd	s0,128(sp)
    80004d5e:	0900                	addi	s0,sp,144
    char path[MAXPATH];
    struct inode *ip;

    begin_op();
    80004d60:	fffff097          	auipc	ra,0xfffff
    80004d64:	812080e7          	jalr	-2030(ra) # 80003572 <begin_op>
    if (argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0) {
    80004d68:	08000613          	li	a2,128
    80004d6c:	f7040593          	addi	a1,s0,-144
    80004d70:	4501                	li	a0,0
    80004d72:	ffffd097          	auipc	ra,0xffffd
    80004d76:	292080e7          	jalr	658(ra) # 80002004 <argstr>
    80004d7a:	02054963          	bltz	a0,80004dac <sys_mkdir+0x54>
    80004d7e:	4681                	li	a3,0
    80004d80:	4601                	li	a2,0
    80004d82:	4585                	li	a1,1
    80004d84:	f7040513          	addi	a0,s0,-144
    80004d88:	fffff097          	auipc	ra,0xfffff
    80004d8c:	7d8080e7          	jalr	2008(ra) # 80004560 <create>
    80004d90:	cd11                	beqz	a0,80004dac <sys_mkdir+0x54>
        end_op();
        return -1;
    }
    iunlockput(ip);
    80004d92:	ffffe097          	auipc	ra,0xffffe
    80004d96:	074080e7          	jalr	116(ra) # 80002e06 <iunlockput>
    end_op();
    80004d9a:	fffff097          	auipc	ra,0xfffff
    80004d9e:	852080e7          	jalr	-1966(ra) # 800035ec <end_op>
    return 0;
    80004da2:	4501                	li	a0,0
}
    80004da4:	60aa                	ld	ra,136(sp)
    80004da6:	640a                	ld	s0,128(sp)
    80004da8:	6149                	addi	sp,sp,144
    80004daa:	8082                	ret
        end_op();
    80004dac:	fffff097          	auipc	ra,0xfffff
    80004db0:	840080e7          	jalr	-1984(ra) # 800035ec <end_op>
        return -1;
    80004db4:	557d                	li	a0,-1
    80004db6:	b7fd                	j	80004da4 <sys_mkdir+0x4c>

0000000080004db8 <sys_mknod>:

uint64 sys_mknod(void) {
    80004db8:	7135                	addi	sp,sp,-160
    80004dba:	ed06                	sd	ra,152(sp)
    80004dbc:	e922                	sd	s0,144(sp)
    80004dbe:	1100                	addi	s0,sp,160
    struct inode *ip;
    char path[MAXPATH];
    int major, minor;

    begin_op();
    80004dc0:	ffffe097          	auipc	ra,0xffffe
    80004dc4:	7b2080e7          	jalr	1970(ra) # 80003572 <begin_op>
    if ((argstr(0, path, MAXPATH)) < 0 || argint(1, &major) < 0 ||
    80004dc8:	08000613          	li	a2,128
    80004dcc:	f7040593          	addi	a1,s0,-144
    80004dd0:	4501                	li	a0,0
    80004dd2:	ffffd097          	auipc	ra,0xffffd
    80004dd6:	232080e7          	jalr	562(ra) # 80002004 <argstr>
    80004dda:	04054a63          	bltz	a0,80004e2e <sys_mknod+0x76>
    80004dde:	f6c40593          	addi	a1,s0,-148
    80004de2:	4505                	li	a0,1
    80004de4:	ffffd097          	auipc	ra,0xffffd
    80004de8:	1dc080e7          	jalr	476(ra) # 80001fc0 <argint>
    80004dec:	04054163          	bltz	a0,80004e2e <sys_mknod+0x76>
        argint(2, &minor) < 0 ||
    80004df0:	f6840593          	addi	a1,s0,-152
    80004df4:	4509                	li	a0,2
    80004df6:	ffffd097          	auipc	ra,0xffffd
    80004dfa:	1ca080e7          	jalr	458(ra) # 80001fc0 <argint>
    if ((argstr(0, path, MAXPATH)) < 0 || argint(1, &major) < 0 ||
    80004dfe:	02054863          	bltz	a0,80004e2e <sys_mknod+0x76>
        (ip = create(path, T_DEVICE, major, minor)) == 0) {
    80004e02:	f6841683          	lh	a3,-152(s0)
    80004e06:	f6c41603          	lh	a2,-148(s0)
    80004e0a:	458d                	li	a1,3
    80004e0c:	f7040513          	addi	a0,s0,-144
    80004e10:	fffff097          	auipc	ra,0xfffff
    80004e14:	750080e7          	jalr	1872(ra) # 80004560 <create>
        argint(2, &minor) < 0 ||
    80004e18:	c919                	beqz	a0,80004e2e <sys_mknod+0x76>
        end_op();
        return -1;
    }
    iunlockput(ip);
    80004e1a:	ffffe097          	auipc	ra,0xffffe
    80004e1e:	fec080e7          	jalr	-20(ra) # 80002e06 <iunlockput>
    end_op();
    80004e22:	ffffe097          	auipc	ra,0xffffe
    80004e26:	7ca080e7          	jalr	1994(ra) # 800035ec <end_op>
    return 0;
    80004e2a:	4501                	li	a0,0
    80004e2c:	a031                	j	80004e38 <sys_mknod+0x80>
        end_op();
    80004e2e:	ffffe097          	auipc	ra,0xffffe
    80004e32:	7be080e7          	jalr	1982(ra) # 800035ec <end_op>
        return -1;
    80004e36:	557d                	li	a0,-1
}
    80004e38:	60ea                	ld	ra,152(sp)
    80004e3a:	644a                	ld	s0,144(sp)
    80004e3c:	610d                	addi	sp,sp,160
    80004e3e:	8082                	ret

0000000080004e40 <sys_chdir>:

uint64 sys_chdir(void) {
    80004e40:	7135                	addi	sp,sp,-160
    80004e42:	ed06                	sd	ra,152(sp)
    80004e44:	e922                	sd	s0,144(sp)
    80004e46:	e14a                	sd	s2,128(sp)
    80004e48:	1100                	addi	s0,sp,160
    char path[MAXPATH];
    struct inode *ip;
    struct proc *p = myproc();
    80004e4a:	ffffc097          	auipc	ra,0xffffc
    80004e4e:	07c080e7          	jalr	124(ra) # 80000ec6 <myproc>
    80004e52:	892a                	mv	s2,a0

    begin_op();
    80004e54:	ffffe097          	auipc	ra,0xffffe
    80004e58:	71e080e7          	jalr	1822(ra) # 80003572 <begin_op>
    if (argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0) {
    80004e5c:	08000613          	li	a2,128
    80004e60:	f6040593          	addi	a1,s0,-160
    80004e64:	4501                	li	a0,0
    80004e66:	ffffd097          	auipc	ra,0xffffd
    80004e6a:	19e080e7          	jalr	414(ra) # 80002004 <argstr>
    80004e6e:	04054d63          	bltz	a0,80004ec8 <sys_chdir+0x88>
    80004e72:	e526                	sd	s1,136(sp)
    80004e74:	f6040513          	addi	a0,s0,-160
    80004e78:	ffffe097          	auipc	ra,0xffffe
    80004e7c:	4fa080e7          	jalr	1274(ra) # 80003372 <namei>
    80004e80:	84aa                	mv	s1,a0
    80004e82:	c131                	beqz	a0,80004ec6 <sys_chdir+0x86>
        end_op();
        return -1;
    }
    ilock(ip);
    80004e84:	ffffe097          	auipc	ra,0xffffe
    80004e88:	d1c080e7          	jalr	-740(ra) # 80002ba0 <ilock>
    if (ip->type != T_DIR) {
    80004e8c:	04449703          	lh	a4,68(s1)
    80004e90:	4785                	li	a5,1
    80004e92:	04f71163          	bne	a4,a5,80004ed4 <sys_chdir+0x94>
        iunlockput(ip);
        end_op();
        return -1;
    }
    iunlock(ip);
    80004e96:	8526                	mv	a0,s1
    80004e98:	ffffe097          	auipc	ra,0xffffe
    80004e9c:	dce080e7          	jalr	-562(ra) # 80002c66 <iunlock>
    iput(p->cwd);
    80004ea0:	15093503          	ld	a0,336(s2)
    80004ea4:	ffffe097          	auipc	ra,0xffffe
    80004ea8:	eba080e7          	jalr	-326(ra) # 80002d5e <iput>
    end_op();
    80004eac:	ffffe097          	auipc	ra,0xffffe
    80004eb0:	740080e7          	jalr	1856(ra) # 800035ec <end_op>
    p->cwd = ip;
    80004eb4:	14993823          	sd	s1,336(s2)
    return 0;
    80004eb8:	4501                	li	a0,0
    80004eba:	64aa                	ld	s1,136(sp)
}
    80004ebc:	60ea                	ld	ra,152(sp)
    80004ebe:	644a                	ld	s0,144(sp)
    80004ec0:	690a                	ld	s2,128(sp)
    80004ec2:	610d                	addi	sp,sp,160
    80004ec4:	8082                	ret
    80004ec6:	64aa                	ld	s1,136(sp)
        end_op();
    80004ec8:	ffffe097          	auipc	ra,0xffffe
    80004ecc:	724080e7          	jalr	1828(ra) # 800035ec <end_op>
        return -1;
    80004ed0:	557d                	li	a0,-1
    80004ed2:	b7ed                	j	80004ebc <sys_chdir+0x7c>
        iunlockput(ip);
    80004ed4:	8526                	mv	a0,s1
    80004ed6:	ffffe097          	auipc	ra,0xffffe
    80004eda:	f30080e7          	jalr	-208(ra) # 80002e06 <iunlockput>
        end_op();
    80004ede:	ffffe097          	auipc	ra,0xffffe
    80004ee2:	70e080e7          	jalr	1806(ra) # 800035ec <end_op>
        return -1;
    80004ee6:	557d                	li	a0,-1
    80004ee8:	64aa                	ld	s1,136(sp)
    80004eea:	bfc9                	j	80004ebc <sys_chdir+0x7c>

0000000080004eec <sys_exec>:

uint64 sys_exec(void) {
    80004eec:	7121                	addi	sp,sp,-448
    80004eee:	ff06                	sd	ra,440(sp)
    80004ef0:	fb22                	sd	s0,432(sp)
    80004ef2:	f34a                	sd	s2,416(sp)
    80004ef4:	0380                	addi	s0,sp,448
    char path[MAXPATH], *argv[MAXARG];
    int i;
    uint64 uargv, uarg;

    if (argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0) {
    80004ef6:	08000613          	li	a2,128
    80004efa:	f5040593          	addi	a1,s0,-176
    80004efe:	4501                	li	a0,0
    80004f00:	ffffd097          	auipc	ra,0xffffd
    80004f04:	104080e7          	jalr	260(ra) # 80002004 <argstr>
        return -1;
    80004f08:	597d                	li	s2,-1
    if (argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0) {
    80004f0a:	0e054a63          	bltz	a0,80004ffe <sys_exec+0x112>
    80004f0e:	e4840593          	addi	a1,s0,-440
    80004f12:	4505                	li	a0,1
    80004f14:	ffffd097          	auipc	ra,0xffffd
    80004f18:	0ce080e7          	jalr	206(ra) # 80001fe2 <argaddr>
    80004f1c:	0e054163          	bltz	a0,80004ffe <sys_exec+0x112>
    80004f20:	f726                	sd	s1,424(sp)
    80004f22:	ef4e                	sd	s3,408(sp)
    80004f24:	eb52                	sd	s4,400(sp)
    }
    memset(argv, 0, sizeof(argv));
    80004f26:	10000613          	li	a2,256
    80004f2a:	4581                	li	a1,0
    80004f2c:	e5040513          	addi	a0,s0,-432
    80004f30:	ffffb097          	auipc	ra,0xffffb
    80004f34:	294080e7          	jalr	660(ra) # 800001c4 <memset>
    for (i = 0;; i++) {
        if (i >= NELEM(argv)) {
    80004f38:	e5040493          	addi	s1,s0,-432
    memset(argv, 0, sizeof(argv));
    80004f3c:	89a6                	mv	s3,s1
    80004f3e:	4901                	li	s2,0
        if (i >= NELEM(argv)) {
    80004f40:	02000a13          	li	s4,32
            goto bad;
        }
        if (fetchaddr(uargv + sizeof(uint64) * i, (uint64 *)&uarg) < 0) {
    80004f44:	00391513          	slli	a0,s2,0x3
    80004f48:	e4040593          	addi	a1,s0,-448
    80004f4c:	e4843783          	ld	a5,-440(s0)
    80004f50:	953e                	add	a0,a0,a5
    80004f52:	ffffd097          	auipc	ra,0xffffd
    80004f56:	fd4080e7          	jalr	-44(ra) # 80001f26 <fetchaddr>
    80004f5a:	02054a63          	bltz	a0,80004f8e <sys_exec+0xa2>
            goto bad;
        }
        if (uarg == 0) {
    80004f5e:	e4043783          	ld	a5,-448(s0)
    80004f62:	c7b1                	beqz	a5,80004fae <sys_exec+0xc2>
            argv[i] = 0;
            break;
        }
        argv[i] = kalloc();
    80004f64:	ffffb097          	auipc	ra,0xffffb
    80004f68:	1b6080e7          	jalr	438(ra) # 8000011a <kalloc>
    80004f6c:	85aa                	mv	a1,a0
    80004f6e:	00a9b023          	sd	a0,0(s3)
        if (argv[i] == 0)
    80004f72:	cd11                	beqz	a0,80004f8e <sys_exec+0xa2>
            goto bad;
        if (fetchstr(uarg, argv[i], PGSIZE) < 0)
    80004f74:	6605                	lui	a2,0x1
    80004f76:	e4043503          	ld	a0,-448(s0)
    80004f7a:	ffffd097          	auipc	ra,0xffffd
    80004f7e:	ffe080e7          	jalr	-2(ra) # 80001f78 <fetchstr>
    80004f82:	00054663          	bltz	a0,80004f8e <sys_exec+0xa2>
        if (i >= NELEM(argv)) {
    80004f86:	0905                	addi	s2,s2,1
    80004f88:	09a1                	addi	s3,s3,8
    80004f8a:	fb491de3          	bne	s2,s4,80004f44 <sys_exec+0x58>
        kfree(argv[i]);

    return ret;

bad:
    for (i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004f8e:	f5040913          	addi	s2,s0,-176
    80004f92:	6088                	ld	a0,0(s1)
    80004f94:	c12d                	beqz	a0,80004ff6 <sys_exec+0x10a>
        kfree(argv[i]);
    80004f96:	ffffb097          	auipc	ra,0xffffb
    80004f9a:	086080e7          	jalr	134(ra) # 8000001c <kfree>
    for (i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004f9e:	04a1                	addi	s1,s1,8
    80004fa0:	ff2499e3          	bne	s1,s2,80004f92 <sys_exec+0xa6>
    return -1;
    80004fa4:	597d                	li	s2,-1
    80004fa6:	74ba                	ld	s1,424(sp)
    80004fa8:	69fa                	ld	s3,408(sp)
    80004faa:	6a5a                	ld	s4,400(sp)
    80004fac:	a889                	j	80004ffe <sys_exec+0x112>
            argv[i] = 0;
    80004fae:	0009079b          	sext.w	a5,s2
    80004fb2:	078e                	slli	a5,a5,0x3
    80004fb4:	fd078793          	addi	a5,a5,-48
    80004fb8:	97a2                	add	a5,a5,s0
    80004fba:	e807b023          	sd	zero,-384(a5)
    int ret = exec(path, argv);
    80004fbe:	e5040593          	addi	a1,s0,-432
    80004fc2:	f5040513          	addi	a0,s0,-176
    80004fc6:	fffff097          	auipc	ra,0xfffff
    80004fca:	126080e7          	jalr	294(ra) # 800040ec <exec>
    80004fce:	892a                	mv	s2,a0
    for (i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004fd0:	f5040993          	addi	s3,s0,-176
    80004fd4:	6088                	ld	a0,0(s1)
    80004fd6:	cd01                	beqz	a0,80004fee <sys_exec+0x102>
        kfree(argv[i]);
    80004fd8:	ffffb097          	auipc	ra,0xffffb
    80004fdc:	044080e7          	jalr	68(ra) # 8000001c <kfree>
    for (i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004fe0:	04a1                	addi	s1,s1,8
    80004fe2:	ff3499e3          	bne	s1,s3,80004fd4 <sys_exec+0xe8>
    80004fe6:	74ba                	ld	s1,424(sp)
    80004fe8:	69fa                	ld	s3,408(sp)
    80004fea:	6a5a                	ld	s4,400(sp)
    80004fec:	a809                	j	80004ffe <sys_exec+0x112>
    return ret;
    80004fee:	74ba                	ld	s1,424(sp)
    80004ff0:	69fa                	ld	s3,408(sp)
    80004ff2:	6a5a                	ld	s4,400(sp)
    80004ff4:	a029                	j	80004ffe <sys_exec+0x112>
    return -1;
    80004ff6:	597d                	li	s2,-1
    80004ff8:	74ba                	ld	s1,424(sp)
    80004ffa:	69fa                	ld	s3,408(sp)
    80004ffc:	6a5a                	ld	s4,400(sp)
}
    80004ffe:	854a                	mv	a0,s2
    80005000:	70fa                	ld	ra,440(sp)
    80005002:	745a                	ld	s0,432(sp)
    80005004:	791a                	ld	s2,416(sp)
    80005006:	6139                	addi	sp,sp,448
    80005008:	8082                	ret

000000008000500a <sys_pipe>:

uint64 sys_pipe(void) {
    8000500a:	7139                	addi	sp,sp,-64
    8000500c:	fc06                	sd	ra,56(sp)
    8000500e:	f822                	sd	s0,48(sp)
    80005010:	f426                	sd	s1,40(sp)
    80005012:	0080                	addi	s0,sp,64
    uint64 fdarray; // user pointer to array of two integers
    struct file *rf, *wf;
    int fd0, fd1;
    struct proc *p = myproc();
    80005014:	ffffc097          	auipc	ra,0xffffc
    80005018:	eb2080e7          	jalr	-334(ra) # 80000ec6 <myproc>
    8000501c:	84aa                	mv	s1,a0

    if (argaddr(0, &fdarray) < 0)
    8000501e:	fd840593          	addi	a1,s0,-40
    80005022:	4501                	li	a0,0
    80005024:	ffffd097          	auipc	ra,0xffffd
    80005028:	fbe080e7          	jalr	-66(ra) # 80001fe2 <argaddr>
        return -1;
    8000502c:	57fd                	li	a5,-1
    if (argaddr(0, &fdarray) < 0)
    8000502e:	0e054063          	bltz	a0,8000510e <sys_pipe+0x104>
    if (pipealloc(&rf, &wf) < 0)
    80005032:	fc840593          	addi	a1,s0,-56
    80005036:	fd040513          	addi	a0,s0,-48
    8000503a:	fffff097          	auipc	ra,0xfffff
    8000503e:	d70080e7          	jalr	-656(ra) # 80003daa <pipealloc>
        return -1;
    80005042:	57fd                	li	a5,-1
    if (pipealloc(&rf, &wf) < 0)
    80005044:	0c054563          	bltz	a0,8000510e <sys_pipe+0x104>
    fd0 = -1;
    80005048:	fcf42223          	sw	a5,-60(s0)
    if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0) {
    8000504c:	fd043503          	ld	a0,-48(s0)
    80005050:	fffff097          	auipc	ra,0xfffff
    80005054:	4ce080e7          	jalr	1230(ra) # 8000451e <fdalloc>
    80005058:	fca42223          	sw	a0,-60(s0)
    8000505c:	08054c63          	bltz	a0,800050f4 <sys_pipe+0xea>
    80005060:	fc843503          	ld	a0,-56(s0)
    80005064:	fffff097          	auipc	ra,0xfffff
    80005068:	4ba080e7          	jalr	1210(ra) # 8000451e <fdalloc>
    8000506c:	fca42023          	sw	a0,-64(s0)
    80005070:	06054963          	bltz	a0,800050e2 <sys_pipe+0xd8>
            p->ofile[fd0] = 0;
        fileclose(rf);
        fileclose(wf);
        return -1;
    }
    if (copyout(p->pagetable, fdarray, (char *)&fd0, sizeof(fd0)) < 0 ||
    80005074:	4691                	li	a3,4
    80005076:	fc440613          	addi	a2,s0,-60
    8000507a:	fd843583          	ld	a1,-40(s0)
    8000507e:	68a8                	ld	a0,80(s1)
    80005080:	ffffc097          	auipc	ra,0xffffc
    80005084:	ae2080e7          	jalr	-1310(ra) # 80000b62 <copyout>
    80005088:	02054063          	bltz	a0,800050a8 <sys_pipe+0x9e>
        copyout(p->pagetable, fdarray + sizeof(fd0), (char *)&fd1,
    8000508c:	4691                	li	a3,4
    8000508e:	fc040613          	addi	a2,s0,-64
    80005092:	fd843583          	ld	a1,-40(s0)
    80005096:	0591                	addi	a1,a1,4
    80005098:	68a8                	ld	a0,80(s1)
    8000509a:	ffffc097          	auipc	ra,0xffffc
    8000509e:	ac8080e7          	jalr	-1336(ra) # 80000b62 <copyout>
        p->ofile[fd1] = 0;
        fileclose(rf);
        fileclose(wf);
        return -1;
    }
    return 0;
    800050a2:	4781                	li	a5,0
    if (copyout(p->pagetable, fdarray, (char *)&fd0, sizeof(fd0)) < 0 ||
    800050a4:	06055563          	bgez	a0,8000510e <sys_pipe+0x104>
        p->ofile[fd0] = 0;
    800050a8:	fc442783          	lw	a5,-60(s0)
    800050ac:	07e9                	addi	a5,a5,26
    800050ae:	078e                	slli	a5,a5,0x3
    800050b0:	97a6                	add	a5,a5,s1
    800050b2:	0007b023          	sd	zero,0(a5)
        p->ofile[fd1] = 0;
    800050b6:	fc042783          	lw	a5,-64(s0)
    800050ba:	07e9                	addi	a5,a5,26
    800050bc:	078e                	slli	a5,a5,0x3
    800050be:	00f48533          	add	a0,s1,a5
    800050c2:	00053023          	sd	zero,0(a0)
        fileclose(rf);
    800050c6:	fd043503          	ld	a0,-48(s0)
    800050ca:	fffff097          	auipc	ra,0xfffff
    800050ce:	972080e7          	jalr	-1678(ra) # 80003a3c <fileclose>
        fileclose(wf);
    800050d2:	fc843503          	ld	a0,-56(s0)
    800050d6:	fffff097          	auipc	ra,0xfffff
    800050da:	966080e7          	jalr	-1690(ra) # 80003a3c <fileclose>
        return -1;
    800050de:	57fd                	li	a5,-1
    800050e0:	a03d                	j	8000510e <sys_pipe+0x104>
        if (fd0 >= 0)
    800050e2:	fc442783          	lw	a5,-60(s0)
    800050e6:	0007c763          	bltz	a5,800050f4 <sys_pipe+0xea>
            p->ofile[fd0] = 0;
    800050ea:	07e9                	addi	a5,a5,26
    800050ec:	078e                	slli	a5,a5,0x3
    800050ee:	97a6                	add	a5,a5,s1
    800050f0:	0007b023          	sd	zero,0(a5)
        fileclose(rf);
    800050f4:	fd043503          	ld	a0,-48(s0)
    800050f8:	fffff097          	auipc	ra,0xfffff
    800050fc:	944080e7          	jalr	-1724(ra) # 80003a3c <fileclose>
        fileclose(wf);
    80005100:	fc843503          	ld	a0,-56(s0)
    80005104:	fffff097          	auipc	ra,0xfffff
    80005108:	938080e7          	jalr	-1736(ra) # 80003a3c <fileclose>
        return -1;
    8000510c:	57fd                	li	a5,-1
}
    8000510e:	853e                	mv	a0,a5
    80005110:	70e2                	ld	ra,56(sp)
    80005112:	7442                	ld	s0,48(sp)
    80005114:	74a2                	ld	s1,40(sp)
    80005116:	6121                	addi	sp,sp,64
    80005118:	8082                	ret
    8000511a:	0000                	unimp
    8000511c:	0000                	unimp
	...

0000000080005120 <kernelvec>:
    80005120:	7111                	addi	sp,sp,-256
    80005122:	e006                	sd	ra,0(sp)
    80005124:	e40a                	sd	sp,8(sp)
    80005126:	e80e                	sd	gp,16(sp)
    80005128:	ec12                	sd	tp,24(sp)
    8000512a:	f016                	sd	t0,32(sp)
    8000512c:	f41a                	sd	t1,40(sp)
    8000512e:	f81e                	sd	t2,48(sp)
    80005130:	fc22                	sd	s0,56(sp)
    80005132:	e0a6                	sd	s1,64(sp)
    80005134:	e4aa                	sd	a0,72(sp)
    80005136:	e8ae                	sd	a1,80(sp)
    80005138:	ecb2                	sd	a2,88(sp)
    8000513a:	f0b6                	sd	a3,96(sp)
    8000513c:	f4ba                	sd	a4,104(sp)
    8000513e:	f8be                	sd	a5,112(sp)
    80005140:	fcc2                	sd	a6,120(sp)
    80005142:	e146                	sd	a7,128(sp)
    80005144:	e54a                	sd	s2,136(sp)
    80005146:	e94e                	sd	s3,144(sp)
    80005148:	ed52                	sd	s4,152(sp)
    8000514a:	f156                	sd	s5,160(sp)
    8000514c:	f55a                	sd	s6,168(sp)
    8000514e:	f95e                	sd	s7,176(sp)
    80005150:	fd62                	sd	s8,184(sp)
    80005152:	e1e6                	sd	s9,192(sp)
    80005154:	e5ea                	sd	s10,200(sp)
    80005156:	e9ee                	sd	s11,208(sp)
    80005158:	edf2                	sd	t3,216(sp)
    8000515a:	f1f6                	sd	t4,224(sp)
    8000515c:	f5fa                	sd	t5,232(sp)
    8000515e:	f9fe                	sd	t6,240(sp)
    80005160:	c93fc0ef          	jal	80001df2 <kerneltrap>
    80005164:	6082                	ld	ra,0(sp)
    80005166:	6122                	ld	sp,8(sp)
    80005168:	61c2                	ld	gp,16(sp)
    8000516a:	7282                	ld	t0,32(sp)
    8000516c:	7322                	ld	t1,40(sp)
    8000516e:	73c2                	ld	t2,48(sp)
    80005170:	7462                	ld	s0,56(sp)
    80005172:	6486                	ld	s1,64(sp)
    80005174:	6526                	ld	a0,72(sp)
    80005176:	65c6                	ld	a1,80(sp)
    80005178:	6666                	ld	a2,88(sp)
    8000517a:	7686                	ld	a3,96(sp)
    8000517c:	7726                	ld	a4,104(sp)
    8000517e:	77c6                	ld	a5,112(sp)
    80005180:	7866                	ld	a6,120(sp)
    80005182:	688a                	ld	a7,128(sp)
    80005184:	692a                	ld	s2,136(sp)
    80005186:	69ca                	ld	s3,144(sp)
    80005188:	6a6a                	ld	s4,152(sp)
    8000518a:	7a8a                	ld	s5,160(sp)
    8000518c:	7b2a                	ld	s6,168(sp)
    8000518e:	7bca                	ld	s7,176(sp)
    80005190:	7c6a                	ld	s8,184(sp)
    80005192:	6c8e                	ld	s9,192(sp)
    80005194:	6d2e                	ld	s10,200(sp)
    80005196:	6dce                	ld	s11,208(sp)
    80005198:	6e6e                	ld	t3,216(sp)
    8000519a:	7e8e                	ld	t4,224(sp)
    8000519c:	7f2e                	ld	t5,232(sp)
    8000519e:	7fce                	ld	t6,240(sp)
    800051a0:	6111                	addi	sp,sp,256
    800051a2:	10200073          	sret
    800051a6:	00000013          	nop
    800051aa:	00000013          	nop
    800051ae:	0001                	nop

00000000800051b0 <timervec>:
    800051b0:	34051573          	csrrw	a0,mscratch,a0
    800051b4:	e10c                	sd	a1,0(a0)
    800051b6:	e510                	sd	a2,8(a0)
    800051b8:	e914                	sd	a3,16(a0)
    800051ba:	6d0c                	ld	a1,24(a0)
    800051bc:	7110                	ld	a2,32(a0)
    800051be:	6194                	ld	a3,0(a1)
    800051c0:	96b2                	add	a3,a3,a2
    800051c2:	e194                	sd	a3,0(a1)
    800051c4:	4589                	li	a1,2
    800051c6:	14459073          	csrw	sip,a1
    800051ca:	6914                	ld	a3,16(a0)
    800051cc:	6510                	ld	a2,8(a0)
    800051ce:	610c                	ld	a1,0(a0)
    800051d0:	34051573          	csrrw	a0,mscratch,a0
    800051d4:	30200073          	mret
	...

00000000800051da <plicinit>:

//
// the riscv Platform Level Interrupt Controller (PLIC).
//

void plicinit(void) {
    800051da:	1141                	addi	sp,sp,-16
    800051dc:	e422                	sd	s0,8(sp)
    800051de:	0800                	addi	s0,sp,16
    // set desired IRQ priorities non-zero (otherwise disabled).
    *(uint32 *)(PLIC + UART0_IRQ * 4) = 1;
    800051e0:	0c0007b7          	lui	a5,0xc000
    800051e4:	4705                	li	a4,1
    800051e6:	d798                	sw	a4,40(a5)
    *(uint32 *)(PLIC + VIRTIO0_IRQ * 4) = 1;
    800051e8:	0c0007b7          	lui	a5,0xc000
    800051ec:	c3d8                	sw	a4,4(a5)
}
    800051ee:	6422                	ld	s0,8(sp)
    800051f0:	0141                	addi	sp,sp,16
    800051f2:	8082                	ret

00000000800051f4 <plicinithart>:

void plicinithart(void) {
    800051f4:	1141                	addi	sp,sp,-16
    800051f6:	e406                	sd	ra,8(sp)
    800051f8:	e022                	sd	s0,0(sp)
    800051fa:	0800                	addi	s0,sp,16
    int hart = cpuid();
    800051fc:	ffffc097          	auipc	ra,0xffffc
    80005200:	c9e080e7          	jalr	-866(ra) # 80000e9a <cpuid>

    // set uart's enable bit for this hart's S-mode.
    *(uint32 *)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005204:	0085171b          	slliw	a4,a0,0x8
    80005208:	0c0027b7          	lui	a5,0xc002
    8000520c:	97ba                	add	a5,a5,a4
    8000520e:	40200713          	li	a4,1026
    80005212:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

    // set this hart's S-mode priority threshold to 0.
    *(uint32 *)PLIC_SPRIORITY(hart) = 0;
    80005216:	00d5151b          	slliw	a0,a0,0xd
    8000521a:	0c2017b7          	lui	a5,0xc201
    8000521e:	97aa                	add	a5,a5,a0
    80005220:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80005224:	60a2                	ld	ra,8(sp)
    80005226:	6402                	ld	s0,0(sp)
    80005228:	0141                	addi	sp,sp,16
    8000522a:	8082                	ret

000000008000522c <plic_claim>:

// ask the PLIC what interrupt we should serve.
int plic_claim(void) {
    8000522c:	1141                	addi	sp,sp,-16
    8000522e:	e406                	sd	ra,8(sp)
    80005230:	e022                	sd	s0,0(sp)
    80005232:	0800                	addi	s0,sp,16
    int hart = cpuid();
    80005234:	ffffc097          	auipc	ra,0xffffc
    80005238:	c66080e7          	jalr	-922(ra) # 80000e9a <cpuid>
    int irq = *(uint32 *)PLIC_SCLAIM(hart);
    8000523c:	00d5151b          	slliw	a0,a0,0xd
    80005240:	0c2017b7          	lui	a5,0xc201
    80005244:	97aa                	add	a5,a5,a0
    return irq;
}
    80005246:	43c8                	lw	a0,4(a5)
    80005248:	60a2                	ld	ra,8(sp)
    8000524a:	6402                	ld	s0,0(sp)
    8000524c:	0141                	addi	sp,sp,16
    8000524e:	8082                	ret

0000000080005250 <plic_complete>:

// tell the PLIC we've served this IRQ.
void plic_complete(int irq) {
    80005250:	1101                	addi	sp,sp,-32
    80005252:	ec06                	sd	ra,24(sp)
    80005254:	e822                	sd	s0,16(sp)
    80005256:	e426                	sd	s1,8(sp)
    80005258:	1000                	addi	s0,sp,32
    8000525a:	84aa                	mv	s1,a0
    int hart = cpuid();
    8000525c:	ffffc097          	auipc	ra,0xffffc
    80005260:	c3e080e7          	jalr	-962(ra) # 80000e9a <cpuid>
    *(uint32 *)PLIC_SCLAIM(hart) = irq;
    80005264:	00d5151b          	slliw	a0,a0,0xd
    80005268:	0c2017b7          	lui	a5,0xc201
    8000526c:	97aa                	add	a5,a5,a0
    8000526e:	c3c4                	sw	s1,4(a5)
}
    80005270:	60e2                	ld	ra,24(sp)
    80005272:	6442                	ld	s0,16(sp)
    80005274:	64a2                	ld	s1,8(sp)
    80005276:	6105                	addi	sp,sp,32
    80005278:	8082                	ret

000000008000527a <free_desc>:
    }
    return -1;
}

// mark a descriptor as free.
static void free_desc(int i) {
    8000527a:	1141                	addi	sp,sp,-16
    8000527c:	e406                	sd	ra,8(sp)
    8000527e:	e022                	sd	s0,0(sp)
    80005280:	0800                	addi	s0,sp,16
    if (i >= NUM)
    80005282:	479d                	li	a5,7
    80005284:	06a7c863          	blt	a5,a0,800052f4 <free_desc+0x7a>
        panic("free_desc 1");
    if (disk.free[i])
    80005288:	00019717          	auipc	a4,0x19
    8000528c:	d7870713          	addi	a4,a4,-648 # 8001e000 <disk>
    80005290:	972a                	add	a4,a4,a0
    80005292:	6789                	lui	a5,0x2
    80005294:	97ba                	add	a5,a5,a4
    80005296:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    8000529a:	e7ad                	bnez	a5,80005304 <free_desc+0x8a>
        panic("free_desc 2");
    disk.desc[i].addr = 0;
    8000529c:	00451793          	slli	a5,a0,0x4
    800052a0:	0001b717          	auipc	a4,0x1b
    800052a4:	d6070713          	addi	a4,a4,-672 # 80020000 <disk+0x2000>
    800052a8:	6314                	ld	a3,0(a4)
    800052aa:	96be                	add	a3,a3,a5
    800052ac:	0006b023          	sd	zero,0(a3)
    disk.desc[i].len = 0;
    800052b0:	6314                	ld	a3,0(a4)
    800052b2:	96be                	add	a3,a3,a5
    800052b4:	0006a423          	sw	zero,8(a3)
    disk.desc[i].flags = 0;
    800052b8:	6314                	ld	a3,0(a4)
    800052ba:	96be                	add	a3,a3,a5
    800052bc:	00069623          	sh	zero,12(a3)
    disk.desc[i].next = 0;
    800052c0:	6318                	ld	a4,0(a4)
    800052c2:	97ba                	add	a5,a5,a4
    800052c4:	00079723          	sh	zero,14(a5)
    disk.free[i] = 1;
    800052c8:	00019717          	auipc	a4,0x19
    800052cc:	d3870713          	addi	a4,a4,-712 # 8001e000 <disk>
    800052d0:	972a                	add	a4,a4,a0
    800052d2:	6789                	lui	a5,0x2
    800052d4:	97ba                	add	a5,a5,a4
    800052d6:	4705                	li	a4,1
    800052d8:	00e78c23          	sb	a4,24(a5) # 2018 <_entry-0x7fffdfe8>
    wakeup(&disk.free[0]);
    800052dc:	0001b517          	auipc	a0,0x1b
    800052e0:	d3c50513          	addi	a0,a0,-708 # 80020018 <disk+0x2018>
    800052e4:	ffffc097          	auipc	ra,0xffffc
    800052e8:	440080e7          	jalr	1088(ra) # 80001724 <wakeup>
}
    800052ec:	60a2                	ld	ra,8(sp)
    800052ee:	6402                	ld	s0,0(sp)
    800052f0:	0141                	addi	sp,sp,16
    800052f2:	8082                	ret
        panic("free_desc 1");
    800052f4:	00003517          	auipc	a0,0x3
    800052f8:	3bc50513          	addi	a0,a0,956 # 800086b0 <etext+0x6b0>
    800052fc:	00001097          	auipc	ra,0x1
    80005300:	a96080e7          	jalr	-1386(ra) # 80005d92 <panic>
        panic("free_desc 2");
    80005304:	00003517          	auipc	a0,0x3
    80005308:	3bc50513          	addi	a0,a0,956 # 800086c0 <etext+0x6c0>
    8000530c:	00001097          	auipc	ra,0x1
    80005310:	a86080e7          	jalr	-1402(ra) # 80005d92 <panic>

0000000080005314 <virtio_disk_init>:
void virtio_disk_init(void) {
    80005314:	1141                	addi	sp,sp,-16
    80005316:	e406                	sd	ra,8(sp)
    80005318:	e022                	sd	s0,0(sp)
    8000531a:	0800                	addi	s0,sp,16
    initlock(&disk.vdisk_lock, "virtio_disk");
    8000531c:	00003597          	auipc	a1,0x3
    80005320:	3b458593          	addi	a1,a1,948 # 800086d0 <etext+0x6d0>
    80005324:	0001b517          	auipc	a0,0x1b
    80005328:	e0450513          	addi	a0,a0,-508 # 80020128 <disk+0x2128>
    8000532c:	00001097          	auipc	ra,0x1
    80005330:	f50080e7          	jalr	-176(ra) # 8000627c <initlock>
    if (*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005334:	100017b7          	lui	a5,0x10001
    80005338:	4398                	lw	a4,0(a5)
    8000533a:	2701                	sext.w	a4,a4
    8000533c:	747277b7          	lui	a5,0x74727
    80005340:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80005344:	0ef71f63          	bne	a4,a5,80005442 <virtio_disk_init+0x12e>
        *R(VIRTIO_MMIO_VERSION) != 1 || *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005348:	100017b7          	lui	a5,0x10001
    8000534c:	0791                	addi	a5,a5,4 # 10001004 <_entry-0x6fffeffc>
    8000534e:	439c                	lw	a5,0(a5)
    80005350:	2781                	sext.w	a5,a5
    if (*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005352:	4705                	li	a4,1
    80005354:	0ee79763          	bne	a5,a4,80005442 <virtio_disk_init+0x12e>
        *R(VIRTIO_MMIO_VERSION) != 1 || *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005358:	100017b7          	lui	a5,0x10001
    8000535c:	07a1                	addi	a5,a5,8 # 10001008 <_entry-0x6fffeff8>
    8000535e:	439c                	lw	a5,0(a5)
    80005360:	2781                	sext.w	a5,a5
    80005362:	4709                	li	a4,2
    80005364:	0ce79f63          	bne	a5,a4,80005442 <virtio_disk_init+0x12e>
        *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551) {
    80005368:	100017b7          	lui	a5,0x10001
    8000536c:	47d8                	lw	a4,12(a5)
    8000536e:	2701                	sext.w	a4,a4
        *R(VIRTIO_MMIO_VERSION) != 1 || *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005370:	554d47b7          	lui	a5,0x554d4
    80005374:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80005378:	0cf71563          	bne	a4,a5,80005442 <virtio_disk_init+0x12e>
    *R(VIRTIO_MMIO_STATUS) = status;
    8000537c:	100017b7          	lui	a5,0x10001
    80005380:	4705                	li	a4,1
    80005382:	dbb8                	sw	a4,112(a5)
    *R(VIRTIO_MMIO_STATUS) = status;
    80005384:	470d                	li	a4,3
    80005386:	dbb8                	sw	a4,112(a5)
    uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80005388:	10001737          	lui	a4,0x10001
    8000538c:	4b14                	lw	a3,16(a4)
    features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    8000538e:	c7ffe737          	lui	a4,0xc7ffe
    80005392:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fd551f>
    *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005396:	8ef9                	and	a3,a3,a4
    80005398:	10001737          	lui	a4,0x10001
    8000539c:	d314                	sw	a3,32(a4)
    *R(VIRTIO_MMIO_STATUS) = status;
    8000539e:	472d                	li	a4,11
    800053a0:	dbb8                	sw	a4,112(a5)
    *R(VIRTIO_MMIO_STATUS) = status;
    800053a2:	473d                	li	a4,15
    800053a4:	dbb8                	sw	a4,112(a5)
    *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    800053a6:	100017b7          	lui	a5,0x10001
    800053aa:	6705                	lui	a4,0x1
    800053ac:	d798                	sw	a4,40(a5)
    *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    800053ae:	100017b7          	lui	a5,0x10001
    800053b2:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
    uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    800053b6:	100017b7          	lui	a5,0x10001
    800053ba:	03478793          	addi	a5,a5,52 # 10001034 <_entry-0x6fffefcc>
    800053be:	439c                	lw	a5,0(a5)
    800053c0:	2781                	sext.w	a5,a5
    if (max == 0)
    800053c2:	cbc1                	beqz	a5,80005452 <virtio_disk_init+0x13e>
    if (max < NUM)
    800053c4:	471d                	li	a4,7
    800053c6:	08f77e63          	bgeu	a4,a5,80005462 <virtio_disk_init+0x14e>
    *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    800053ca:	100017b7          	lui	a5,0x10001
    800053ce:	4721                	li	a4,8
    800053d0:	df98                	sw	a4,56(a5)
    memset(disk.pages, 0, sizeof(disk.pages));
    800053d2:	6609                	lui	a2,0x2
    800053d4:	4581                	li	a1,0
    800053d6:	00019517          	auipc	a0,0x19
    800053da:	c2a50513          	addi	a0,a0,-982 # 8001e000 <disk>
    800053de:	ffffb097          	auipc	ra,0xffffb
    800053e2:	de6080e7          	jalr	-538(ra) # 800001c4 <memset>
    *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    800053e6:	00019697          	auipc	a3,0x19
    800053ea:	c1a68693          	addi	a3,a3,-998 # 8001e000 <disk>
    800053ee:	00c6d713          	srli	a4,a3,0xc
    800053f2:	2701                	sext.w	a4,a4
    800053f4:	100017b7          	lui	a5,0x10001
    800053f8:	c3b8                	sw	a4,64(a5)
    disk.desc = (struct virtq_desc *)disk.pages;
    800053fa:	0001b797          	auipc	a5,0x1b
    800053fe:	c0678793          	addi	a5,a5,-1018 # 80020000 <disk+0x2000>
    80005402:	e394                	sd	a3,0(a5)
    disk.avail =
    80005404:	00019717          	auipc	a4,0x19
    80005408:	c7c70713          	addi	a4,a4,-900 # 8001e080 <disk+0x80>
    8000540c:	e798                	sd	a4,8(a5)
    disk.used = (struct virtq_used *)(disk.pages + PGSIZE);
    8000540e:	0001a717          	auipc	a4,0x1a
    80005412:	bf270713          	addi	a4,a4,-1038 # 8001f000 <disk+0x1000>
    80005416:	eb98                	sd	a4,16(a5)
        disk.free[i] = 1;
    80005418:	4705                	li	a4,1
    8000541a:	00e78c23          	sb	a4,24(a5)
    8000541e:	00e78ca3          	sb	a4,25(a5)
    80005422:	00e78d23          	sb	a4,26(a5)
    80005426:	00e78da3          	sb	a4,27(a5)
    8000542a:	00e78e23          	sb	a4,28(a5)
    8000542e:	00e78ea3          	sb	a4,29(a5)
    80005432:	00e78f23          	sb	a4,30(a5)
    80005436:	00e78fa3          	sb	a4,31(a5)
}
    8000543a:	60a2                	ld	ra,8(sp)
    8000543c:	6402                	ld	s0,0(sp)
    8000543e:	0141                	addi	sp,sp,16
    80005440:	8082                	ret
        panic("could not find virtio disk");
    80005442:	00003517          	auipc	a0,0x3
    80005446:	29e50513          	addi	a0,a0,670 # 800086e0 <etext+0x6e0>
    8000544a:	00001097          	auipc	ra,0x1
    8000544e:	948080e7          	jalr	-1720(ra) # 80005d92 <panic>
        panic("virtio disk has no queue 0");
    80005452:	00003517          	auipc	a0,0x3
    80005456:	2ae50513          	addi	a0,a0,686 # 80008700 <etext+0x700>
    8000545a:	00001097          	auipc	ra,0x1
    8000545e:	938080e7          	jalr	-1736(ra) # 80005d92 <panic>
        panic("virtio disk max queue too short");
    80005462:	00003517          	auipc	a0,0x3
    80005466:	2be50513          	addi	a0,a0,702 # 80008720 <etext+0x720>
    8000546a:	00001097          	auipc	ra,0x1
    8000546e:	928080e7          	jalr	-1752(ra) # 80005d92 <panic>

0000000080005472 <virtio_disk_rw>:
        }
    }
    return 0;
}

void virtio_disk_rw(struct buf *b, int write) {
    80005472:	7159                	addi	sp,sp,-112
    80005474:	f486                	sd	ra,104(sp)
    80005476:	f0a2                	sd	s0,96(sp)
    80005478:	eca6                	sd	s1,88(sp)
    8000547a:	e8ca                	sd	s2,80(sp)
    8000547c:	e4ce                	sd	s3,72(sp)
    8000547e:	e0d2                	sd	s4,64(sp)
    80005480:	fc56                	sd	s5,56(sp)
    80005482:	f85a                	sd	s6,48(sp)
    80005484:	f45e                	sd	s7,40(sp)
    80005486:	f062                	sd	s8,32(sp)
    80005488:	ec66                	sd	s9,24(sp)
    8000548a:	1880                	addi	s0,sp,112
    8000548c:	8a2a                	mv	s4,a0
    8000548e:	8cae                	mv	s9,a1
    uint64 sector = b->blockno * (BSIZE / 512);
    80005490:	00c52c03          	lw	s8,12(a0)
    80005494:	001c1c1b          	slliw	s8,s8,0x1
    80005498:	1c02                	slli	s8,s8,0x20
    8000549a:	020c5c13          	srli	s8,s8,0x20

    acquire(&disk.vdisk_lock);
    8000549e:	0001b517          	auipc	a0,0x1b
    800054a2:	c8a50513          	addi	a0,a0,-886 # 80020128 <disk+0x2128>
    800054a6:	00001097          	auipc	ra,0x1
    800054aa:	e66080e7          	jalr	-410(ra) # 8000630c <acquire>
    for (int i = 0; i < 3; i++) {
    800054ae:	4981                	li	s3,0
    for (int i = 0; i < NUM; i++) {
    800054b0:	44a1                	li	s1,8
            disk.free[i] = 0;
    800054b2:	00019b97          	auipc	s7,0x19
    800054b6:	b4eb8b93          	addi	s7,s7,-1202 # 8001e000 <disk>
    800054ba:	6b09                	lui	s6,0x2
    for (int i = 0; i < 3; i++) {
    800054bc:	4a8d                	li	s5,3
    800054be:	a88d                	j	80005530 <virtio_disk_rw+0xbe>
            disk.free[i] = 0;
    800054c0:	00fb8733          	add	a4,s7,a5
    800054c4:	975a                	add	a4,a4,s6
    800054c6:	00070c23          	sb	zero,24(a4)
        idx[i] = alloc_desc();
    800054ca:	c19c                	sw	a5,0(a1)
        if (idx[i] < 0) {
    800054cc:	0207c563          	bltz	a5,800054f6 <virtio_disk_rw+0x84>
    for (int i = 0; i < 3; i++) {
    800054d0:	2905                	addiw	s2,s2,1
    800054d2:	0611                	addi	a2,a2,4 # 2004 <_entry-0x7fffdffc>
    800054d4:	1b590163          	beq	s2,s5,80005676 <virtio_disk_rw+0x204>
        idx[i] = alloc_desc();
    800054d8:	85b2                	mv	a1,a2
    for (int i = 0; i < NUM; i++) {
    800054da:	0001b717          	auipc	a4,0x1b
    800054de:	b3e70713          	addi	a4,a4,-1218 # 80020018 <disk+0x2018>
    800054e2:	87ce                	mv	a5,s3
        if (disk.free[i]) {
    800054e4:	00074683          	lbu	a3,0(a4)
    800054e8:	fee1                	bnez	a3,800054c0 <virtio_disk_rw+0x4e>
    for (int i = 0; i < NUM; i++) {
    800054ea:	2785                	addiw	a5,a5,1
    800054ec:	0705                	addi	a4,a4,1
    800054ee:	fe979be3          	bne	a5,s1,800054e4 <virtio_disk_rw+0x72>
        idx[i] = alloc_desc();
    800054f2:	57fd                	li	a5,-1
    800054f4:	c19c                	sw	a5,0(a1)
            for (int j = 0; j < i; j++)
    800054f6:	03205163          	blez	s2,80005518 <virtio_disk_rw+0xa6>
                free_desc(idx[j]);
    800054fa:	f9042503          	lw	a0,-112(s0)
    800054fe:	00000097          	auipc	ra,0x0
    80005502:	d7c080e7          	jalr	-644(ra) # 8000527a <free_desc>
            for (int j = 0; j < i; j++)
    80005506:	4785                	li	a5,1
    80005508:	0127d863          	bge	a5,s2,80005518 <virtio_disk_rw+0xa6>
                free_desc(idx[j]);
    8000550c:	f9442503          	lw	a0,-108(s0)
    80005510:	00000097          	auipc	ra,0x0
    80005514:	d6a080e7          	jalr	-662(ra) # 8000527a <free_desc>
    int idx[3];
    while (1) {
        if (alloc3_desc(idx) == 0) {
            break;
        }
        sleep(&disk.free[0], &disk.vdisk_lock);
    80005518:	0001b597          	auipc	a1,0x1b
    8000551c:	c1058593          	addi	a1,a1,-1008 # 80020128 <disk+0x2128>
    80005520:	0001b517          	auipc	a0,0x1b
    80005524:	af850513          	addi	a0,a0,-1288 # 80020018 <disk+0x2018>
    80005528:	ffffc097          	auipc	ra,0xffffc
    8000552c:	070080e7          	jalr	112(ra) # 80001598 <sleep>
    for (int i = 0; i < 3; i++) {
    80005530:	f9040613          	addi	a2,s0,-112
    80005534:	894e                	mv	s2,s3
    80005536:	b74d                	j	800054d8 <virtio_disk_rw+0x66>
    disk.desc[idx[0]].next = idx[1];

    disk.desc[idx[1]].addr = (uint64)b->data;
    disk.desc[idx[1]].len = BSIZE;
    if (write)
        disk.desc[idx[1]].flags = 0; // device reads b->data
    80005538:	0001b717          	auipc	a4,0x1b
    8000553c:	ac873703          	ld	a4,-1336(a4) # 80020000 <disk+0x2000>
    80005540:	973e                	add	a4,a4,a5
    80005542:	00071623          	sh	zero,12(a4)
    else
        disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80005546:	00019897          	auipc	a7,0x19
    8000554a:	aba88893          	addi	a7,a7,-1350 # 8001e000 <disk>
    8000554e:	0001b717          	auipc	a4,0x1b
    80005552:	ab270713          	addi	a4,a4,-1358 # 80020000 <disk+0x2000>
    80005556:	6314                	ld	a3,0(a4)
    80005558:	96be                	add	a3,a3,a5
    8000555a:	00c6d583          	lhu	a1,12(a3)
    8000555e:	0015e593          	ori	a1,a1,1
    80005562:	00b69623          	sh	a1,12(a3)
    disk.desc[idx[1]].next = idx[2];
    80005566:	f9842683          	lw	a3,-104(s0)
    8000556a:	630c                	ld	a1,0(a4)
    8000556c:	97ae                	add	a5,a5,a1
    8000556e:	00d79723          	sh	a3,14(a5)

    disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80005572:	20050593          	addi	a1,a0,512
    80005576:	0592                	slli	a1,a1,0x4
    80005578:	95c6                	add	a1,a1,a7
    8000557a:	57fd                	li	a5,-1
    8000557c:	02f58823          	sb	a5,48(a1)
    disk.desc[idx[2]].addr = (uint64)&disk.info[idx[0]].status;
    80005580:	00469793          	slli	a5,a3,0x4
    80005584:	00073803          	ld	a6,0(a4)
    80005588:	983e                	add	a6,a6,a5
    8000558a:	6689                	lui	a3,0x2
    8000558c:	03068693          	addi	a3,a3,48 # 2030 <_entry-0x7fffdfd0>
    80005590:	96b2                	add	a3,a3,a2
    80005592:	96c6                	add	a3,a3,a7
    80005594:	00d83023          	sd	a3,0(a6)
    disk.desc[idx[2]].len = 1;
    80005598:	6314                	ld	a3,0(a4)
    8000559a:	96be                	add	a3,a3,a5
    8000559c:	4605                	li	a2,1
    8000559e:	c690                	sw	a2,8(a3)
    disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    800055a0:	6314                	ld	a3,0(a4)
    800055a2:	96be                	add	a3,a3,a5
    800055a4:	4809                	li	a6,2
    800055a6:	01069623          	sh	a6,12(a3)
    disk.desc[idx[2]].next = 0;
    800055aa:	6314                	ld	a3,0(a4)
    800055ac:	97b6                	add	a5,a5,a3
    800055ae:	00079723          	sh	zero,14(a5)

    // record struct buf for virtio_disk_intr().
    b->disk = 1;
    800055b2:	00ca2223          	sw	a2,4(s4)
    disk.info[idx[0]].b = b;
    800055b6:	0345b423          	sd	s4,40(a1)

    // tell the device the first index in our chain of descriptors.
    disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    800055ba:	6714                	ld	a3,8(a4)
    800055bc:	0026d783          	lhu	a5,2(a3)
    800055c0:	8b9d                	andi	a5,a5,7
    800055c2:	0786                	slli	a5,a5,0x1
    800055c4:	96be                	add	a3,a3,a5
    800055c6:	00a69223          	sh	a0,4(a3)

    __sync_synchronize();
    800055ca:	0ff0000f          	fence

    // tell the device another avail ring entry is available.
    disk.avail->idx += 1; // not % NUM ...
    800055ce:	6718                	ld	a4,8(a4)
    800055d0:	00275783          	lhu	a5,2(a4)
    800055d4:	2785                	addiw	a5,a5,1
    800055d6:	00f71123          	sh	a5,2(a4)

    __sync_synchronize();
    800055da:	0ff0000f          	fence

    *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    800055de:	100017b7          	lui	a5,0x10001
    800055e2:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

    // Wait for virtio_disk_intr() to say request has finished.
    while (b->disk == 1) {
    800055e6:	004a2783          	lw	a5,4(s4)
    800055ea:	02c79163          	bne	a5,a2,8000560c <virtio_disk_rw+0x19a>
        sleep(b, &disk.vdisk_lock);
    800055ee:	0001b917          	auipc	s2,0x1b
    800055f2:	b3a90913          	addi	s2,s2,-1222 # 80020128 <disk+0x2128>
    while (b->disk == 1) {
    800055f6:	4485                	li	s1,1
        sleep(b, &disk.vdisk_lock);
    800055f8:	85ca                	mv	a1,s2
    800055fa:	8552                	mv	a0,s4
    800055fc:	ffffc097          	auipc	ra,0xffffc
    80005600:	f9c080e7          	jalr	-100(ra) # 80001598 <sleep>
    while (b->disk == 1) {
    80005604:	004a2783          	lw	a5,4(s4)
    80005608:	fe9788e3          	beq	a5,s1,800055f8 <virtio_disk_rw+0x186>
    }

    disk.info[idx[0]].b = 0;
    8000560c:	f9042903          	lw	s2,-112(s0)
    80005610:	20090713          	addi	a4,s2,512
    80005614:	0712                	slli	a4,a4,0x4
    80005616:	00019797          	auipc	a5,0x19
    8000561a:	9ea78793          	addi	a5,a5,-1558 # 8001e000 <disk>
    8000561e:	97ba                	add	a5,a5,a4
    80005620:	0207b423          	sd	zero,40(a5)
        int flag = disk.desc[i].flags;
    80005624:	0001b997          	auipc	s3,0x1b
    80005628:	9dc98993          	addi	s3,s3,-1572 # 80020000 <disk+0x2000>
    8000562c:	00491713          	slli	a4,s2,0x4
    80005630:	0009b783          	ld	a5,0(s3)
    80005634:	97ba                	add	a5,a5,a4
    80005636:	00c7d483          	lhu	s1,12(a5)
        int nxt = disk.desc[i].next;
    8000563a:	854a                	mv	a0,s2
    8000563c:	00e7d903          	lhu	s2,14(a5)
        free_desc(i);
    80005640:	00000097          	auipc	ra,0x0
    80005644:	c3a080e7          	jalr	-966(ra) # 8000527a <free_desc>
        if (flag & VRING_DESC_F_NEXT)
    80005648:	8885                	andi	s1,s1,1
    8000564a:	f0ed                	bnez	s1,8000562c <virtio_disk_rw+0x1ba>
    free_chain(idx[0]);

    release(&disk.vdisk_lock);
    8000564c:	0001b517          	auipc	a0,0x1b
    80005650:	adc50513          	addi	a0,a0,-1316 # 80020128 <disk+0x2128>
    80005654:	00001097          	auipc	ra,0x1
    80005658:	d6c080e7          	jalr	-660(ra) # 800063c0 <release>
}
    8000565c:	70a6                	ld	ra,104(sp)
    8000565e:	7406                	ld	s0,96(sp)
    80005660:	64e6                	ld	s1,88(sp)
    80005662:	6946                	ld	s2,80(sp)
    80005664:	69a6                	ld	s3,72(sp)
    80005666:	6a06                	ld	s4,64(sp)
    80005668:	7ae2                	ld	s5,56(sp)
    8000566a:	7b42                	ld	s6,48(sp)
    8000566c:	7ba2                	ld	s7,40(sp)
    8000566e:	7c02                	ld	s8,32(sp)
    80005670:	6ce2                	ld	s9,24(sp)
    80005672:	6165                	addi	sp,sp,112
    80005674:	8082                	ret
    struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80005676:	f9042503          	lw	a0,-112(s0)
    8000567a:	00451613          	slli	a2,a0,0x4
    if (write)
    8000567e:	00019597          	auipc	a1,0x19
    80005682:	98258593          	addi	a1,a1,-1662 # 8001e000 <disk>
    80005686:	20050793          	addi	a5,a0,512
    8000568a:	0792                	slli	a5,a5,0x4
    8000568c:	97ae                	add	a5,a5,a1
    8000568e:	01903733          	snez	a4,s9
    80005692:	0ae7a423          	sw	a4,168(a5)
    buf0->reserved = 0;
    80005696:	0a07a623          	sw	zero,172(a5)
    buf0->sector = sector;
    8000569a:	0b87b823          	sd	s8,176(a5)
    disk.desc[idx[0]].addr = (uint64)buf0;
    8000569e:	0001b717          	auipc	a4,0x1b
    800056a2:	96270713          	addi	a4,a4,-1694 # 80020000 <disk+0x2000>
    800056a6:	6314                	ld	a3,0(a4)
    800056a8:	96b2                	add	a3,a3,a2
    struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800056aa:	6789                	lui	a5,0x2
    800056ac:	0a878793          	addi	a5,a5,168 # 20a8 <_entry-0x7fffdf58>
    800056b0:	97b2                	add	a5,a5,a2
    800056b2:	97ae                	add	a5,a5,a1
    disk.desc[idx[0]].addr = (uint64)buf0;
    800056b4:	e29c                	sd	a5,0(a3)
    disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    800056b6:	631c                	ld	a5,0(a4)
    800056b8:	97b2                	add	a5,a5,a2
    800056ba:	46c1                	li	a3,16
    800056bc:	c794                	sw	a3,8(a5)
    disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800056be:	631c                	ld	a5,0(a4)
    800056c0:	97b2                	add	a5,a5,a2
    800056c2:	4685                	li	a3,1
    800056c4:	00d79623          	sh	a3,12(a5)
    disk.desc[idx[0]].next = idx[1];
    800056c8:	f9442783          	lw	a5,-108(s0)
    800056cc:	6314                	ld	a3,0(a4)
    800056ce:	96b2                	add	a3,a3,a2
    800056d0:	00f69723          	sh	a5,14(a3)
    disk.desc[idx[1]].addr = (uint64)b->data;
    800056d4:	0792                	slli	a5,a5,0x4
    800056d6:	6314                	ld	a3,0(a4)
    800056d8:	96be                	add	a3,a3,a5
    800056da:	058a0593          	addi	a1,s4,88
    800056de:	e28c                	sd	a1,0(a3)
    disk.desc[idx[1]].len = BSIZE;
    800056e0:	6318                	ld	a4,0(a4)
    800056e2:	973e                	add	a4,a4,a5
    800056e4:	40000693          	li	a3,1024
    800056e8:	c714                	sw	a3,8(a4)
    if (write)
    800056ea:	e40c97e3          	bnez	s9,80005538 <virtio_disk_rw+0xc6>
        disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    800056ee:	0001b717          	auipc	a4,0x1b
    800056f2:	91273703          	ld	a4,-1774(a4) # 80020000 <disk+0x2000>
    800056f6:	973e                	add	a4,a4,a5
    800056f8:	4689                	li	a3,2
    800056fa:	00d71623          	sh	a3,12(a4)
    800056fe:	b5a1                	j	80005546 <virtio_disk_rw+0xd4>

0000000080005700 <virtio_disk_intr>:

void virtio_disk_intr() {
    80005700:	1101                	addi	sp,sp,-32
    80005702:	ec06                	sd	ra,24(sp)
    80005704:	e822                	sd	s0,16(sp)
    80005706:	1000                	addi	s0,sp,32
    acquire(&disk.vdisk_lock);
    80005708:	0001b517          	auipc	a0,0x1b
    8000570c:	a2050513          	addi	a0,a0,-1504 # 80020128 <disk+0x2128>
    80005710:	00001097          	auipc	ra,0x1
    80005714:	bfc080e7          	jalr	-1028(ra) # 8000630c <acquire>
    // we've seen this interrupt, which the following line does.
    // this may race with the device writing new entries to
    // the "used" ring, in which case we may process the new
    // completion entries in this interrupt, and have nothing to do
    // in the next interrupt, which is harmless.
    *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80005718:	100017b7          	lui	a5,0x10001
    8000571c:	53b8                	lw	a4,96(a5)
    8000571e:	8b0d                	andi	a4,a4,3
    80005720:	100017b7          	lui	a5,0x10001
    80005724:	d3f8                	sw	a4,100(a5)

    __sync_synchronize();
    80005726:	0ff0000f          	fence

    // the device increments disk.used->idx when it
    // adds an entry to the used ring.

    while (disk.used_idx != disk.used->idx) {
    8000572a:	0001b797          	auipc	a5,0x1b
    8000572e:	8d678793          	addi	a5,a5,-1834 # 80020000 <disk+0x2000>
    80005732:	6b94                	ld	a3,16(a5)
    80005734:	0207d703          	lhu	a4,32(a5)
    80005738:	0026d783          	lhu	a5,2(a3)
    8000573c:	06f70563          	beq	a4,a5,800057a6 <virtio_disk_intr+0xa6>
    80005740:	e426                	sd	s1,8(sp)
    80005742:	e04a                	sd	s2,0(sp)
        __sync_synchronize();
        int id = disk.used->ring[disk.used_idx % NUM].id;
    80005744:	00019917          	auipc	s2,0x19
    80005748:	8bc90913          	addi	s2,s2,-1860 # 8001e000 <disk>
    8000574c:	0001b497          	auipc	s1,0x1b
    80005750:	8b448493          	addi	s1,s1,-1868 # 80020000 <disk+0x2000>
        __sync_synchronize();
    80005754:	0ff0000f          	fence
        int id = disk.used->ring[disk.used_idx % NUM].id;
    80005758:	6898                	ld	a4,16(s1)
    8000575a:	0204d783          	lhu	a5,32(s1)
    8000575e:	8b9d                	andi	a5,a5,7
    80005760:	078e                	slli	a5,a5,0x3
    80005762:	97ba                	add	a5,a5,a4
    80005764:	43dc                	lw	a5,4(a5)

        if (disk.info[id].status != 0)
    80005766:	20078713          	addi	a4,a5,512
    8000576a:	0712                	slli	a4,a4,0x4
    8000576c:	974a                	add	a4,a4,s2
    8000576e:	03074703          	lbu	a4,48(a4)
    80005772:	e731                	bnez	a4,800057be <virtio_disk_intr+0xbe>
            panic("virtio_disk_intr status");

        struct buf *b = disk.info[id].b;
    80005774:	20078793          	addi	a5,a5,512
    80005778:	0792                	slli	a5,a5,0x4
    8000577a:	97ca                	add	a5,a5,s2
    8000577c:	7788                	ld	a0,40(a5)
        b->disk = 0; // disk is done with buf
    8000577e:	00052223          	sw	zero,4(a0)
        wakeup(b);
    80005782:	ffffc097          	auipc	ra,0xffffc
    80005786:	fa2080e7          	jalr	-94(ra) # 80001724 <wakeup>

        disk.used_idx += 1;
    8000578a:	0204d783          	lhu	a5,32(s1)
    8000578e:	2785                	addiw	a5,a5,1
    80005790:	17c2                	slli	a5,a5,0x30
    80005792:	93c1                	srli	a5,a5,0x30
    80005794:	02f49023          	sh	a5,32(s1)
    while (disk.used_idx != disk.used->idx) {
    80005798:	6898                	ld	a4,16(s1)
    8000579a:	00275703          	lhu	a4,2(a4)
    8000579e:	faf71be3          	bne	a4,a5,80005754 <virtio_disk_intr+0x54>
    800057a2:	64a2                	ld	s1,8(sp)
    800057a4:	6902                	ld	s2,0(sp)
    }

    release(&disk.vdisk_lock);
    800057a6:	0001b517          	auipc	a0,0x1b
    800057aa:	98250513          	addi	a0,a0,-1662 # 80020128 <disk+0x2128>
    800057ae:	00001097          	auipc	ra,0x1
    800057b2:	c12080e7          	jalr	-1006(ra) # 800063c0 <release>
}
    800057b6:	60e2                	ld	ra,24(sp)
    800057b8:	6442                	ld	s0,16(sp)
    800057ba:	6105                	addi	sp,sp,32
    800057bc:	8082                	ret
            panic("virtio_disk_intr status");
    800057be:	00003517          	auipc	a0,0x3
    800057c2:	f8250513          	addi	a0,a0,-126 # 80008740 <etext+0x740>
    800057c6:	00000097          	auipc	ra,0x0
    800057ca:	5cc080e7          	jalr	1484(ra) # 80005d92 <panic>

00000000800057ce <copy_sysinfo>:
#include "sysinfo.h"

extern uint64 freemem();
extern uint64 num_proc();

int copy_sysinfo(struct sysinfo *info, uint64 addr) {
    800057ce:	1101                	addi	sp,sp,-32
    800057d0:	ec06                	sd	ra,24(sp)
    800057d2:	e822                	sd	s0,16(sp)
    800057d4:	e426                	sd	s1,8(sp)
    800057d6:	e04a                	sd	s2,0(sp)
    800057d8:	1000                	addi	s0,sp,32
    800057da:	892a                	mv	s2,a0
    800057dc:	84ae                	mv	s1,a1
  struct proc *p = myproc();
    800057de:	ffffb097          	auipc	ra,0xffffb
    800057e2:	6e8080e7          	jalr	1768(ra) # 80000ec6 <myproc>
  if (copyout(p->pagetable, addr, (char *)info, sizeof(*info)) < 0)
    800057e6:	46c1                	li	a3,16
    800057e8:	864a                	mv	a2,s2
    800057ea:	85a6                	mv	a1,s1
    800057ec:	6928                	ld	a0,80(a0)
    800057ee:	ffffb097          	auipc	ra,0xffffb
    800057f2:	374080e7          	jalr	884(ra) # 80000b62 <copyout>
    return -1;

  return 0;
}
    800057f6:	41f5551b          	sraiw	a0,a0,0x1f
    800057fa:	60e2                	ld	ra,24(sp)
    800057fc:	6442                	ld	s0,16(sp)
    800057fe:	64a2                	ld	s1,8(sp)
    80005800:	6902                	ld	s2,0(sp)
    80005802:	6105                	addi	sp,sp,32
    80005804:	8082                	ret

0000000080005806 <sys_sysinfo>:

uint64 sys_sysinfo(void) {
    80005806:	7179                	addi	sp,sp,-48
    80005808:	f406                	sd	ra,40(sp)
    8000580a:	f022                	sd	s0,32(sp)
    8000580c:	1800                	addi	s0,sp,48
  struct sysinfo info;
  uint64 info_addr;
  if (argaddr(0, &info_addr) < 0)
    8000580e:	fd840593          	addi	a1,s0,-40
    80005812:	4501                	li	a0,0
    80005814:	ffffc097          	auipc	ra,0xffffc
    80005818:	7ce080e7          	jalr	1998(ra) # 80001fe2 <argaddr>
    8000581c:	87aa                	mv	a5,a0
    return -1;
    8000581e:	557d                	li	a0,-1
  if (argaddr(0, &info_addr) < 0)
    80005820:	0207c663          	bltz	a5,8000584c <sys_sysinfo+0x46>

  info.freemem = freemem();
    80005824:	ffffb097          	auipc	ra,0xffffb
    80005828:	956080e7          	jalr	-1706(ra) # 8000017a <freemem>
    8000582c:	fea43023          	sd	a0,-32(s0)
  info.nproc = num_proc();
    80005830:	ffffc097          	auipc	ra,0xffffc
    80005834:	268080e7          	jalr	616(ra) # 80001a98 <num_proc>
    80005838:	fea43423          	sd	a0,-24(s0)

  return copy_sysinfo(&info, info_addr);
    8000583c:	fd843583          	ld	a1,-40(s0)
    80005840:	fe040513          	addi	a0,s0,-32
    80005844:	00000097          	auipc	ra,0x0
    80005848:	f8a080e7          	jalr	-118(ra) # 800057ce <copy_sysinfo>
}
    8000584c:	70a2                	ld	ra,40(sp)
    8000584e:	7402                	ld	s0,32(sp)
    80005850:	6145                	addi	sp,sp,48
    80005852:	8082                	ret

0000000080005854 <timerinit>:

// set up to receive timer interrupts in machine mode,
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void timerinit() {
    80005854:	1141                	addi	sp,sp,-16
    80005856:	e422                	sd	s0,8(sp)
    80005858:	0800                	addi	s0,sp,16
    asm volatile("csrr %0, mhartid" : "=r"(x));
    8000585a:	f14027f3          	csrr	a5,mhartid
    // each CPU has a separate source of timer interrupts.
    int id = r_mhartid();
    8000585e:	0007859b          	sext.w	a1,a5

    // ask the CLINT for a timer interrupt.
    int interval = 1000000; // cycles; about 1/10th second in qemu.
    *(uint64 *)CLINT_MTIMECMP(id) = *(uint64 *)CLINT_MTIME + interval;
    80005862:	0037979b          	slliw	a5,a5,0x3
    80005866:	02004737          	lui	a4,0x2004
    8000586a:	97ba                	add	a5,a5,a4
    8000586c:	0200c737          	lui	a4,0x200c
    80005870:	1761                	addi	a4,a4,-8 # 200bff8 <_entry-0x7dff4008>
    80005872:	6318                	ld	a4,0(a4)
    80005874:	000f4637          	lui	a2,0xf4
    80005878:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000587c:	9732                	add	a4,a4,a2
    8000587e:	e398                	sd	a4,0(a5)

    // prepare information in scratch[] for timervec.
    // scratch[0..2] : space for timervec to save registers.
    // scratch[3] : address of CLINT MTIMECMP register.
    // scratch[4] : desired interval (in cycles) between timer interrupts.
    uint64 *scratch = &timer_scratch[id][0];
    80005880:	00259693          	slli	a3,a1,0x2
    80005884:	96ae                	add	a3,a3,a1
    80005886:	068e                	slli	a3,a3,0x3
    80005888:	0001b717          	auipc	a4,0x1b
    8000588c:	77870713          	addi	a4,a4,1912 # 80021000 <timer_scratch>
    80005890:	9736                	add	a4,a4,a3
    scratch[3] = CLINT_MTIMECMP(id);
    80005892:	ef1c                	sd	a5,24(a4)
    scratch[4] = interval;
    80005894:	f310                	sd	a2,32(a4)
    asm volatile("csrw mscratch, %0" : : "r"(x));
    80005896:	34071073          	csrw	mscratch,a4
    asm volatile("csrw mtvec, %0" : : "r"(x));
    8000589a:	00000797          	auipc	a5,0x0
    8000589e:	91678793          	addi	a5,a5,-1770 # 800051b0 <timervec>
    800058a2:	30579073          	csrw	mtvec,a5
    asm volatile("csrr %0, mstatus" : "=r"(x));
    800058a6:	300027f3          	csrr	a5,mstatus

    // set the machine-mode trap handler.
    w_mtvec((uint64)timervec);

    // enable machine-mode interrupts.
    w_mstatus(r_mstatus() | MSTATUS_MIE);
    800058aa:	0087e793          	ori	a5,a5,8
    asm volatile("csrw mstatus, %0" : : "r"(x));
    800058ae:	30079073          	csrw	mstatus,a5
    asm volatile("csrr %0, mie" : "=r"(x));
    800058b2:	304027f3          	csrr	a5,mie

    // enable machine-mode timer interrupts.
    w_mie(r_mie() | MIE_MTIE);
    800058b6:	0807e793          	ori	a5,a5,128
static inline void w_mie(uint64 x) { asm volatile("csrw mie, %0" : : "r"(x)); }
    800058ba:	30479073          	csrw	mie,a5
}
    800058be:	6422                	ld	s0,8(sp)
    800058c0:	0141                	addi	sp,sp,16
    800058c2:	8082                	ret

00000000800058c4 <start>:
void start() {
    800058c4:	1141                	addi	sp,sp,-16
    800058c6:	e406                	sd	ra,8(sp)
    800058c8:	e022                	sd	s0,0(sp)
    800058ca:	0800                	addi	s0,sp,16
    asm volatile("csrr %0, mstatus" : "=r"(x));
    800058cc:	300027f3          	csrr	a5,mstatus
    x &= ~MSTATUS_MPP_MASK;
    800058d0:	7779                	lui	a4,0xffffe
    800058d2:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd55bf>
    800058d6:	8ff9                	and	a5,a5,a4
    x |= MSTATUS_MPP_S;
    800058d8:	6705                	lui	a4,0x1
    800058da:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800058de:	8fd9                	or	a5,a5,a4
    asm volatile("csrw mstatus, %0" : : "r"(x));
    800058e0:	30079073          	csrw	mstatus,a5
    asm volatile("csrw mepc, %0" : : "r"(x));
    800058e4:	ffffb797          	auipc	a5,0xffffb
    800058e8:	a7e78793          	addi	a5,a5,-1410 # 80000362 <main>
    800058ec:	34179073          	csrw	mepc,a5
    asm volatile("csrw satp, %0" : : "r"(x));
    800058f0:	4781                	li	a5,0
    800058f2:	18079073          	csrw	satp,a5
    asm volatile("csrw medeleg, %0" : : "r"(x));
    800058f6:	67c1                	lui	a5,0x10
    800058f8:	17fd                	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800058fa:	30279073          	csrw	medeleg,a5
    asm volatile("csrw mideleg, %0" : : "r"(x));
    800058fe:	30379073          	csrw	mideleg,a5
    asm volatile("csrr %0, sie" : "=r"(x));
    80005902:	104027f3          	csrr	a5,sie
    w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80005906:	2227e793          	ori	a5,a5,546
static inline void w_sie(uint64 x) { asm volatile("csrw sie, %0" : : "r"(x)); }
    8000590a:	10479073          	csrw	sie,a5
    asm volatile("csrw pmpaddr0, %0" : : "r"(x));
    8000590e:	57fd                	li	a5,-1
    80005910:	83a9                	srli	a5,a5,0xa
    80005912:	3b079073          	csrw	pmpaddr0,a5
    asm volatile("csrw pmpcfg0, %0" : : "r"(x));
    80005916:	47bd                	li	a5,15
    80005918:	3a079073          	csrw	pmpcfg0,a5
    timerinit();
    8000591c:	00000097          	auipc	ra,0x0
    80005920:	f38080e7          	jalr	-200(ra) # 80005854 <timerinit>
    asm volatile("csrr %0, mhartid" : "=r"(x));
    80005924:	f14027f3          	csrr	a5,mhartid
    w_tp(id);
    80005928:	2781                	sext.w	a5,a5
static inline void w_tp(uint64 x) { asm volatile("mv tp, %0" : : "r"(x)); }
    8000592a:	823e                	mv	tp,a5
    asm volatile("mret");
    8000592c:	30200073          	mret
}
    80005930:	60a2                	ld	ra,8(sp)
    80005932:	6402                	ld	s0,0(sp)
    80005934:	0141                	addi	sp,sp,16
    80005936:	8082                	ret

0000000080005938 <consolewrite>:
} cons;

//
// user write()s to the console go here.
//
int consolewrite(int user_src, uint64 src, int n) {
    80005938:	715d                	addi	sp,sp,-80
    8000593a:	e486                	sd	ra,72(sp)
    8000593c:	e0a2                	sd	s0,64(sp)
    8000593e:	f84a                	sd	s2,48(sp)
    80005940:	0880                	addi	s0,sp,80
    int i;

    for (i = 0; i < n; i++) {
    80005942:	04c05663          	blez	a2,8000598e <consolewrite+0x56>
    80005946:	fc26                	sd	s1,56(sp)
    80005948:	f44e                	sd	s3,40(sp)
    8000594a:	f052                	sd	s4,32(sp)
    8000594c:	ec56                	sd	s5,24(sp)
    8000594e:	8a2a                	mv	s4,a0
    80005950:	84ae                	mv	s1,a1
    80005952:	89b2                	mv	s3,a2
    80005954:	4901                	li	s2,0
        char c;
        if (either_copyin(&c, user_src, src + i, 1) == -1)
    80005956:	5afd                	li	s5,-1
    80005958:	4685                	li	a3,1
    8000595a:	8626                	mv	a2,s1
    8000595c:	85d2                	mv	a1,s4
    8000595e:	fbf40513          	addi	a0,s0,-65
    80005962:	ffffc097          	auipc	ra,0xffffc
    80005966:	030080e7          	jalr	48(ra) # 80001992 <either_copyin>
    8000596a:	03550463          	beq	a0,s5,80005992 <consolewrite+0x5a>
            break;
        uartputc(c);
    8000596e:	fbf44503          	lbu	a0,-65(s0)
    80005972:	00000097          	auipc	ra,0x0
    80005976:	7de080e7          	jalr	2014(ra) # 80006150 <uartputc>
    for (i = 0; i < n; i++) {
    8000597a:	2905                	addiw	s2,s2,1
    8000597c:	0485                	addi	s1,s1,1
    8000597e:	fd299de3          	bne	s3,s2,80005958 <consolewrite+0x20>
    80005982:	894e                	mv	s2,s3
    80005984:	74e2                	ld	s1,56(sp)
    80005986:	79a2                	ld	s3,40(sp)
    80005988:	7a02                	ld	s4,32(sp)
    8000598a:	6ae2                	ld	s5,24(sp)
    8000598c:	a039                	j	8000599a <consolewrite+0x62>
    8000598e:	4901                	li	s2,0
    80005990:	a029                	j	8000599a <consolewrite+0x62>
    80005992:	74e2                	ld	s1,56(sp)
    80005994:	79a2                	ld	s3,40(sp)
    80005996:	7a02                	ld	s4,32(sp)
    80005998:	6ae2                	ld	s5,24(sp)
    }

    return i;
}
    8000599a:	854a                	mv	a0,s2
    8000599c:	60a6                	ld	ra,72(sp)
    8000599e:	6406                	ld	s0,64(sp)
    800059a0:	7942                	ld	s2,48(sp)
    800059a2:	6161                	addi	sp,sp,80
    800059a4:	8082                	ret

00000000800059a6 <consoleread>:
// user read()s from the console go here.
// copy (up to) a whole input line to dst.
// user_dist indicates whether dst is a user
// or kernel address.
//
int consoleread(int user_dst, uint64 dst, int n) {
    800059a6:	711d                	addi	sp,sp,-96
    800059a8:	ec86                	sd	ra,88(sp)
    800059aa:	e8a2                	sd	s0,80(sp)
    800059ac:	e4a6                	sd	s1,72(sp)
    800059ae:	e0ca                	sd	s2,64(sp)
    800059b0:	fc4e                	sd	s3,56(sp)
    800059b2:	f852                	sd	s4,48(sp)
    800059b4:	f456                	sd	s5,40(sp)
    800059b6:	f05a                	sd	s6,32(sp)
    800059b8:	1080                	addi	s0,sp,96
    800059ba:	8aaa                	mv	s5,a0
    800059bc:	8a2e                	mv	s4,a1
    800059be:	89b2                	mv	s3,a2
    uint target;
    int c;
    char cbuf;

    target = n;
    800059c0:	00060b1b          	sext.w	s6,a2
    acquire(&cons.lock);
    800059c4:	00023517          	auipc	a0,0x23
    800059c8:	77c50513          	addi	a0,a0,1916 # 80029140 <cons>
    800059cc:	00001097          	auipc	ra,0x1
    800059d0:	940080e7          	jalr	-1728(ra) # 8000630c <acquire>
    while (n > 0) {
        // wait until interrupt handler has put some
        // input into cons.buffer.
        while (cons.r == cons.w) {
    800059d4:	00023497          	auipc	s1,0x23
    800059d8:	76c48493          	addi	s1,s1,1900 # 80029140 <cons>
            if (myproc()->killed) {
                release(&cons.lock);
                return -1;
            }
            sleep(&cons.r, &cons.lock);
    800059dc:	00023917          	auipc	s2,0x23
    800059e0:	7fc90913          	addi	s2,s2,2044 # 800291d8 <cons+0x98>
    while (n > 0) {
    800059e4:	0d305463          	blez	s3,80005aac <consoleread+0x106>
        while (cons.r == cons.w) {
    800059e8:	0984a783          	lw	a5,152(s1)
    800059ec:	09c4a703          	lw	a4,156(s1)
    800059f0:	0af71963          	bne	a4,a5,80005aa2 <consoleread+0xfc>
            if (myproc()->killed) {
    800059f4:	ffffb097          	auipc	ra,0xffffb
    800059f8:	4d2080e7          	jalr	1234(ra) # 80000ec6 <myproc>
    800059fc:	551c                	lw	a5,40(a0)
    800059fe:	e7ad                	bnez	a5,80005a68 <consoleread+0xc2>
            sleep(&cons.r, &cons.lock);
    80005a00:	85a6                	mv	a1,s1
    80005a02:	854a                	mv	a0,s2
    80005a04:	ffffc097          	auipc	ra,0xffffc
    80005a08:	b94080e7          	jalr	-1132(ra) # 80001598 <sleep>
        while (cons.r == cons.w) {
    80005a0c:	0984a783          	lw	a5,152(s1)
    80005a10:	09c4a703          	lw	a4,156(s1)
    80005a14:	fef700e3          	beq	a4,a5,800059f4 <consoleread+0x4e>
    80005a18:	ec5e                	sd	s7,24(sp)
        }

        c = cons.buf[cons.r++ % INPUT_BUF];
    80005a1a:	00023717          	auipc	a4,0x23
    80005a1e:	72670713          	addi	a4,a4,1830 # 80029140 <cons>
    80005a22:	0017869b          	addiw	a3,a5,1
    80005a26:	08d72c23          	sw	a3,152(a4)
    80005a2a:	07f7f693          	andi	a3,a5,127
    80005a2e:	9736                	add	a4,a4,a3
    80005a30:	01874703          	lbu	a4,24(a4)
    80005a34:	00070b9b          	sext.w	s7,a4

        if (c == C('D')) { // end-of-file
    80005a38:	4691                	li	a3,4
    80005a3a:	04db8a63          	beq	s7,a3,80005a8e <consoleread+0xe8>
            }
            break;
        }

        // copy the input byte to the user-space buffer.
        cbuf = c;
    80005a3e:	fae407a3          	sb	a4,-81(s0)
        if (either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005a42:	4685                	li	a3,1
    80005a44:	faf40613          	addi	a2,s0,-81
    80005a48:	85d2                	mv	a1,s4
    80005a4a:	8556                	mv	a0,s5
    80005a4c:	ffffc097          	auipc	ra,0xffffc
    80005a50:	ef0080e7          	jalr	-272(ra) # 8000193c <either_copyout>
    80005a54:	57fd                	li	a5,-1
    80005a56:	04f50a63          	beq	a0,a5,80005aaa <consoleread+0x104>
            break;

        dst++;
    80005a5a:	0a05                	addi	s4,s4,1
        --n;
    80005a5c:	39fd                	addiw	s3,s3,-1

        if (c == '\n') {
    80005a5e:	47a9                	li	a5,10
    80005a60:	06fb8163          	beq	s7,a5,80005ac2 <consoleread+0x11c>
    80005a64:	6be2                	ld	s7,24(sp)
    80005a66:	bfbd                	j	800059e4 <consoleread+0x3e>
                release(&cons.lock);
    80005a68:	00023517          	auipc	a0,0x23
    80005a6c:	6d850513          	addi	a0,a0,1752 # 80029140 <cons>
    80005a70:	00001097          	auipc	ra,0x1
    80005a74:	950080e7          	jalr	-1712(ra) # 800063c0 <release>
                return -1;
    80005a78:	557d                	li	a0,-1
        }
    }
    release(&cons.lock);

    return target - n;
}
    80005a7a:	60e6                	ld	ra,88(sp)
    80005a7c:	6446                	ld	s0,80(sp)
    80005a7e:	64a6                	ld	s1,72(sp)
    80005a80:	6906                	ld	s2,64(sp)
    80005a82:	79e2                	ld	s3,56(sp)
    80005a84:	7a42                	ld	s4,48(sp)
    80005a86:	7aa2                	ld	s5,40(sp)
    80005a88:	7b02                	ld	s6,32(sp)
    80005a8a:	6125                	addi	sp,sp,96
    80005a8c:	8082                	ret
            if (n < target) {
    80005a8e:	0009871b          	sext.w	a4,s3
    80005a92:	01677a63          	bgeu	a4,s6,80005aa6 <consoleread+0x100>
                cons.r--;
    80005a96:	00023717          	auipc	a4,0x23
    80005a9a:	74f72123          	sw	a5,1858(a4) # 800291d8 <cons+0x98>
    80005a9e:	6be2                	ld	s7,24(sp)
    80005aa0:	a031                	j	80005aac <consoleread+0x106>
    80005aa2:	ec5e                	sd	s7,24(sp)
    80005aa4:	bf9d                	j	80005a1a <consoleread+0x74>
    80005aa6:	6be2                	ld	s7,24(sp)
    80005aa8:	a011                	j	80005aac <consoleread+0x106>
    80005aaa:	6be2                	ld	s7,24(sp)
    release(&cons.lock);
    80005aac:	00023517          	auipc	a0,0x23
    80005ab0:	69450513          	addi	a0,a0,1684 # 80029140 <cons>
    80005ab4:	00001097          	auipc	ra,0x1
    80005ab8:	90c080e7          	jalr	-1780(ra) # 800063c0 <release>
    return target - n;
    80005abc:	413b053b          	subw	a0,s6,s3
    80005ac0:	bf6d                	j	80005a7a <consoleread+0xd4>
    80005ac2:	6be2                	ld	s7,24(sp)
    80005ac4:	b7e5                	j	80005aac <consoleread+0x106>

0000000080005ac6 <consputc>:
void consputc(int c) {
    80005ac6:	1141                	addi	sp,sp,-16
    80005ac8:	e406                	sd	ra,8(sp)
    80005aca:	e022                	sd	s0,0(sp)
    80005acc:	0800                	addi	s0,sp,16
    if (c == BACKSPACE) {
    80005ace:	10000793          	li	a5,256
    80005ad2:	00f50a63          	beq	a0,a5,80005ae6 <consputc+0x20>
        uartputc_sync(c);
    80005ad6:	00000097          	auipc	ra,0x0
    80005ada:	59c080e7          	jalr	1436(ra) # 80006072 <uartputc_sync>
}
    80005ade:	60a2                	ld	ra,8(sp)
    80005ae0:	6402                	ld	s0,0(sp)
    80005ae2:	0141                	addi	sp,sp,16
    80005ae4:	8082                	ret
        uartputc_sync('\b');
    80005ae6:	4521                	li	a0,8
    80005ae8:	00000097          	auipc	ra,0x0
    80005aec:	58a080e7          	jalr	1418(ra) # 80006072 <uartputc_sync>
        uartputc_sync(' ');
    80005af0:	02000513          	li	a0,32
    80005af4:	00000097          	auipc	ra,0x0
    80005af8:	57e080e7          	jalr	1406(ra) # 80006072 <uartputc_sync>
        uartputc_sync('\b');
    80005afc:	4521                	li	a0,8
    80005afe:	00000097          	auipc	ra,0x0
    80005b02:	574080e7          	jalr	1396(ra) # 80006072 <uartputc_sync>
    80005b06:	bfe1                	j	80005ade <consputc+0x18>

0000000080005b08 <consoleintr>:
// the console input interrupt handler.
// uartintr() calls this for input character.
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void consoleintr(int c) {
    80005b08:	1101                	addi	sp,sp,-32
    80005b0a:	ec06                	sd	ra,24(sp)
    80005b0c:	e822                	sd	s0,16(sp)
    80005b0e:	e426                	sd	s1,8(sp)
    80005b10:	1000                	addi	s0,sp,32
    80005b12:	84aa                	mv	s1,a0
    acquire(&cons.lock);
    80005b14:	00023517          	auipc	a0,0x23
    80005b18:	62c50513          	addi	a0,a0,1580 # 80029140 <cons>
    80005b1c:	00000097          	auipc	ra,0x0
    80005b20:	7f0080e7          	jalr	2032(ra) # 8000630c <acquire>

    switch (c) {
    80005b24:	47d5                	li	a5,21
    80005b26:	0af48563          	beq	s1,a5,80005bd0 <consoleintr+0xc8>
    80005b2a:	0297c963          	blt	a5,s1,80005b5c <consoleintr+0x54>
    80005b2e:	47a1                	li	a5,8
    80005b30:	0ef48c63          	beq	s1,a5,80005c28 <consoleintr+0x120>
    80005b34:	47c1                	li	a5,16
    80005b36:	10f49f63          	bne	s1,a5,80005c54 <consoleintr+0x14c>
    case C('P'): // Print process list.
        procdump();
    80005b3a:	ffffc097          	auipc	ra,0xffffc
    80005b3e:	eae080e7          	jalr	-338(ra) # 800019e8 <procdump>
            }
        }
        break;
    }

    release(&cons.lock);
    80005b42:	00023517          	auipc	a0,0x23
    80005b46:	5fe50513          	addi	a0,a0,1534 # 80029140 <cons>
    80005b4a:	00001097          	auipc	ra,0x1
    80005b4e:	876080e7          	jalr	-1930(ra) # 800063c0 <release>
}
    80005b52:	60e2                	ld	ra,24(sp)
    80005b54:	6442                	ld	s0,16(sp)
    80005b56:	64a2                	ld	s1,8(sp)
    80005b58:	6105                	addi	sp,sp,32
    80005b5a:	8082                	ret
    switch (c) {
    80005b5c:	07f00793          	li	a5,127
    80005b60:	0cf48463          	beq	s1,a5,80005c28 <consoleintr+0x120>
        if (c != 0 && cons.e - cons.r < INPUT_BUF) {
    80005b64:	00023717          	auipc	a4,0x23
    80005b68:	5dc70713          	addi	a4,a4,1500 # 80029140 <cons>
    80005b6c:	0a072783          	lw	a5,160(a4)
    80005b70:	09872703          	lw	a4,152(a4)
    80005b74:	9f99                	subw	a5,a5,a4
    80005b76:	07f00713          	li	a4,127
    80005b7a:	fcf764e3          	bltu	a4,a5,80005b42 <consoleintr+0x3a>
            c = (c == '\r') ? '\n' : c;
    80005b7e:	47b5                	li	a5,13
    80005b80:	0cf48d63          	beq	s1,a5,80005c5a <consoleintr+0x152>
            consputc(c);
    80005b84:	8526                	mv	a0,s1
    80005b86:	00000097          	auipc	ra,0x0
    80005b8a:	f40080e7          	jalr	-192(ra) # 80005ac6 <consputc>
            cons.buf[cons.e++ % INPUT_BUF] = c;
    80005b8e:	00023797          	auipc	a5,0x23
    80005b92:	5b278793          	addi	a5,a5,1458 # 80029140 <cons>
    80005b96:	0a07a703          	lw	a4,160(a5)
    80005b9a:	0017069b          	addiw	a3,a4,1
    80005b9e:	0006861b          	sext.w	a2,a3
    80005ba2:	0ad7a023          	sw	a3,160(a5)
    80005ba6:	07f77713          	andi	a4,a4,127
    80005baa:	97ba                	add	a5,a5,a4
    80005bac:	00978c23          	sb	s1,24(a5)
            if (c == '\n' || c == C('D') || cons.e == cons.r + INPUT_BUF) {
    80005bb0:	47a9                	li	a5,10
    80005bb2:	0cf48b63          	beq	s1,a5,80005c88 <consoleintr+0x180>
    80005bb6:	4791                	li	a5,4
    80005bb8:	0cf48863          	beq	s1,a5,80005c88 <consoleintr+0x180>
    80005bbc:	00023797          	auipc	a5,0x23
    80005bc0:	61c7a783          	lw	a5,1564(a5) # 800291d8 <cons+0x98>
    80005bc4:	0807879b          	addiw	a5,a5,128
    80005bc8:	f6f61de3          	bne	a2,a5,80005b42 <consoleintr+0x3a>
    80005bcc:	863e                	mv	a2,a5
    80005bce:	a86d                	j	80005c88 <consoleintr+0x180>
    80005bd0:	e04a                	sd	s2,0(sp)
        while (cons.e != cons.w && cons.buf[(cons.e - 1) % INPUT_BUF] != '\n') {
    80005bd2:	00023717          	auipc	a4,0x23
    80005bd6:	56e70713          	addi	a4,a4,1390 # 80029140 <cons>
    80005bda:	0a072783          	lw	a5,160(a4)
    80005bde:	09c72703          	lw	a4,156(a4)
    80005be2:	00023497          	auipc	s1,0x23
    80005be6:	55e48493          	addi	s1,s1,1374 # 80029140 <cons>
    80005bea:	4929                	li	s2,10
    80005bec:	02f70a63          	beq	a4,a5,80005c20 <consoleintr+0x118>
    80005bf0:	37fd                	addiw	a5,a5,-1
    80005bf2:	07f7f713          	andi	a4,a5,127
    80005bf6:	9726                	add	a4,a4,s1
    80005bf8:	01874703          	lbu	a4,24(a4)
    80005bfc:	03270463          	beq	a4,s2,80005c24 <consoleintr+0x11c>
            cons.e--;
    80005c00:	0af4a023          	sw	a5,160(s1)
            consputc(BACKSPACE);
    80005c04:	10000513          	li	a0,256
    80005c08:	00000097          	auipc	ra,0x0
    80005c0c:	ebe080e7          	jalr	-322(ra) # 80005ac6 <consputc>
        while (cons.e != cons.w && cons.buf[(cons.e - 1) % INPUT_BUF] != '\n') {
    80005c10:	0a04a783          	lw	a5,160(s1)
    80005c14:	09c4a703          	lw	a4,156(s1)
    80005c18:	fcf71ce3          	bne	a4,a5,80005bf0 <consoleintr+0xe8>
    80005c1c:	6902                	ld	s2,0(sp)
    80005c1e:	b715                	j	80005b42 <consoleintr+0x3a>
    80005c20:	6902                	ld	s2,0(sp)
    80005c22:	b705                	j	80005b42 <consoleintr+0x3a>
    80005c24:	6902                	ld	s2,0(sp)
    80005c26:	bf31                	j	80005b42 <consoleintr+0x3a>
        if (cons.e != cons.w) {
    80005c28:	00023717          	auipc	a4,0x23
    80005c2c:	51870713          	addi	a4,a4,1304 # 80029140 <cons>
    80005c30:	0a072783          	lw	a5,160(a4)
    80005c34:	09c72703          	lw	a4,156(a4)
    80005c38:	f0f705e3          	beq	a4,a5,80005b42 <consoleintr+0x3a>
            cons.e--;
    80005c3c:	37fd                	addiw	a5,a5,-1
    80005c3e:	00023717          	auipc	a4,0x23
    80005c42:	5af72123          	sw	a5,1442(a4) # 800291e0 <cons+0xa0>
            consputc(BACKSPACE);
    80005c46:	10000513          	li	a0,256
    80005c4a:	00000097          	auipc	ra,0x0
    80005c4e:	e7c080e7          	jalr	-388(ra) # 80005ac6 <consputc>
    80005c52:	bdc5                	j	80005b42 <consoleintr+0x3a>
        if (c != 0 && cons.e - cons.r < INPUT_BUF) {
    80005c54:	ee0487e3          	beqz	s1,80005b42 <consoleintr+0x3a>
    80005c58:	b731                	j	80005b64 <consoleintr+0x5c>
            consputc(c);
    80005c5a:	4529                	li	a0,10
    80005c5c:	00000097          	auipc	ra,0x0
    80005c60:	e6a080e7          	jalr	-406(ra) # 80005ac6 <consputc>
            cons.buf[cons.e++ % INPUT_BUF] = c;
    80005c64:	00023797          	auipc	a5,0x23
    80005c68:	4dc78793          	addi	a5,a5,1244 # 80029140 <cons>
    80005c6c:	0a07a703          	lw	a4,160(a5)
    80005c70:	0017069b          	addiw	a3,a4,1
    80005c74:	0006861b          	sext.w	a2,a3
    80005c78:	0ad7a023          	sw	a3,160(a5)
    80005c7c:	07f77713          	andi	a4,a4,127
    80005c80:	97ba                	add	a5,a5,a4
    80005c82:	4729                	li	a4,10
    80005c84:	00e78c23          	sb	a4,24(a5)
                cons.w = cons.e;
    80005c88:	00023797          	auipc	a5,0x23
    80005c8c:	54c7aa23          	sw	a2,1364(a5) # 800291dc <cons+0x9c>
                wakeup(&cons.r);
    80005c90:	00023517          	auipc	a0,0x23
    80005c94:	54850513          	addi	a0,a0,1352 # 800291d8 <cons+0x98>
    80005c98:	ffffc097          	auipc	ra,0xffffc
    80005c9c:	a8c080e7          	jalr	-1396(ra) # 80001724 <wakeup>
    80005ca0:	b54d                	j	80005b42 <consoleintr+0x3a>

0000000080005ca2 <consoleinit>:

void consoleinit(void) {
    80005ca2:	1141                	addi	sp,sp,-16
    80005ca4:	e406                	sd	ra,8(sp)
    80005ca6:	e022                	sd	s0,0(sp)
    80005ca8:	0800                	addi	s0,sp,16
    initlock(&cons.lock, "cons");
    80005caa:	00003597          	auipc	a1,0x3
    80005cae:	aae58593          	addi	a1,a1,-1362 # 80008758 <etext+0x758>
    80005cb2:	00023517          	auipc	a0,0x23
    80005cb6:	48e50513          	addi	a0,a0,1166 # 80029140 <cons>
    80005cba:	00000097          	auipc	ra,0x0
    80005cbe:	5c2080e7          	jalr	1474(ra) # 8000627c <initlock>

    uartinit();
    80005cc2:	00000097          	auipc	ra,0x0
    80005cc6:	354080e7          	jalr	852(ra) # 80006016 <uartinit>

    // connect read and write system calls
    // to consoleread and consolewrite.
    devsw[CONSOLE].read = consoleread;
    80005cca:	00016797          	auipc	a5,0x16
    80005cce:	5fe78793          	addi	a5,a5,1534 # 8001c2c8 <devsw>
    80005cd2:	00000717          	auipc	a4,0x0
    80005cd6:	cd470713          	addi	a4,a4,-812 # 800059a6 <consoleread>
    80005cda:	eb98                	sd	a4,16(a5)
    devsw[CONSOLE].write = consolewrite;
    80005cdc:	00000717          	auipc	a4,0x0
    80005ce0:	c5c70713          	addi	a4,a4,-932 # 80005938 <consolewrite>
    80005ce4:	ef98                	sd	a4,24(a5)
}
    80005ce6:	60a2                	ld	ra,8(sp)
    80005ce8:	6402                	ld	s0,0(sp)
    80005cea:	0141                	addi	sp,sp,16
    80005cec:	8082                	ret

0000000080005cee <printint>:
    int locking;
} pr;

static char digits[] = "0123456789abcdef";

static void printint(int xx, int base, int sign) {
    80005cee:	7179                	addi	sp,sp,-48
    80005cf0:	f406                	sd	ra,40(sp)
    80005cf2:	f022                	sd	s0,32(sp)
    80005cf4:	1800                	addi	s0,sp,48
    char buf[16];
    int i;
    uint x;

    if (sign && (sign = xx < 0))
    80005cf6:	c219                	beqz	a2,80005cfc <printint+0xe>
    80005cf8:	08054963          	bltz	a0,80005d8a <printint+0x9c>
        x = -xx;
    else
        x = xx;
    80005cfc:	2501                	sext.w	a0,a0
    80005cfe:	4881                	li	a7,0
    80005d00:	fd040693          	addi	a3,s0,-48

    i = 0;
    80005d04:	4701                	li	a4,0
    do {
        buf[i++] = digits[x % base];
    80005d06:	2581                	sext.w	a1,a1
    80005d08:	00003617          	auipc	a2,0x3
    80005d0c:	c7860613          	addi	a2,a2,-904 # 80008980 <digits>
    80005d10:	883a                	mv	a6,a4
    80005d12:	2705                	addiw	a4,a4,1
    80005d14:	02b577bb          	remuw	a5,a0,a1
    80005d18:	1782                	slli	a5,a5,0x20
    80005d1a:	9381                	srli	a5,a5,0x20
    80005d1c:	97b2                	add	a5,a5,a2
    80005d1e:	0007c783          	lbu	a5,0(a5)
    80005d22:	00f68023          	sb	a5,0(a3)
    } while ((x /= base) != 0);
    80005d26:	0005079b          	sext.w	a5,a0
    80005d2a:	02b5553b          	divuw	a0,a0,a1
    80005d2e:	0685                	addi	a3,a3,1
    80005d30:	feb7f0e3          	bgeu	a5,a1,80005d10 <printint+0x22>

    if (sign)
    80005d34:	00088c63          	beqz	a7,80005d4c <printint+0x5e>
        buf[i++] = '-';
    80005d38:	fe070793          	addi	a5,a4,-32
    80005d3c:	00878733          	add	a4,a5,s0
    80005d40:	02d00793          	li	a5,45
    80005d44:	fef70823          	sb	a5,-16(a4)
    80005d48:	0028071b          	addiw	a4,a6,2

    while (--i >= 0)
    80005d4c:	02e05b63          	blez	a4,80005d82 <printint+0x94>
    80005d50:	ec26                	sd	s1,24(sp)
    80005d52:	e84a                	sd	s2,16(sp)
    80005d54:	fd040793          	addi	a5,s0,-48
    80005d58:	00e784b3          	add	s1,a5,a4
    80005d5c:	fff78913          	addi	s2,a5,-1
    80005d60:	993a                	add	s2,s2,a4
    80005d62:	377d                	addiw	a4,a4,-1
    80005d64:	1702                	slli	a4,a4,0x20
    80005d66:	9301                	srli	a4,a4,0x20
    80005d68:	40e90933          	sub	s2,s2,a4
        consputc(buf[i]);
    80005d6c:	fff4c503          	lbu	a0,-1(s1)
    80005d70:	00000097          	auipc	ra,0x0
    80005d74:	d56080e7          	jalr	-682(ra) # 80005ac6 <consputc>
    while (--i >= 0)
    80005d78:	14fd                	addi	s1,s1,-1
    80005d7a:	ff2499e3          	bne	s1,s2,80005d6c <printint+0x7e>
    80005d7e:	64e2                	ld	s1,24(sp)
    80005d80:	6942                	ld	s2,16(sp)
}
    80005d82:	70a2                	ld	ra,40(sp)
    80005d84:	7402                	ld	s0,32(sp)
    80005d86:	6145                	addi	sp,sp,48
    80005d88:	8082                	ret
        x = -xx;
    80005d8a:	40a0053b          	negw	a0,a0
    if (sign && (sign = xx < 0))
    80005d8e:	4885                	li	a7,1
        x = -xx;
    80005d90:	bf85                	j	80005d00 <printint+0x12>

0000000080005d92 <panic>:

    if (locking)
        release(&pr.lock);
}

void panic(char *s) {
    80005d92:	1101                	addi	sp,sp,-32
    80005d94:	ec06                	sd	ra,24(sp)
    80005d96:	e822                	sd	s0,16(sp)
    80005d98:	e426                	sd	s1,8(sp)
    80005d9a:	1000                	addi	s0,sp,32
    80005d9c:	84aa                	mv	s1,a0
    pr.locking = 0;
    80005d9e:	00023797          	auipc	a5,0x23
    80005da2:	4607a123          	sw	zero,1122(a5) # 80029200 <pr+0x18>
    printf("panic: ");
    80005da6:	00003517          	auipc	a0,0x3
    80005daa:	9ba50513          	addi	a0,a0,-1606 # 80008760 <etext+0x760>
    80005dae:	00000097          	auipc	ra,0x0
    80005db2:	02e080e7          	jalr	46(ra) # 80005ddc <printf>
    printf(s);
    80005db6:	8526                	mv	a0,s1
    80005db8:	00000097          	auipc	ra,0x0
    80005dbc:	024080e7          	jalr	36(ra) # 80005ddc <printf>
    printf("\n");
    80005dc0:	00002517          	auipc	a0,0x2
    80005dc4:	25850513          	addi	a0,a0,600 # 80008018 <etext+0x18>
    80005dc8:	00000097          	auipc	ra,0x0
    80005dcc:	014080e7          	jalr	20(ra) # 80005ddc <printf>
    panicked = 1; // freeze uart output from other CPUs
    80005dd0:	4785                	li	a5,1
    80005dd2:	00006717          	auipc	a4,0x6
    80005dd6:	24f72523          	sw	a5,586(a4) # 8000c01c <panicked>
    for (;;)
    80005dda:	a001                	j	80005dda <panic+0x48>

0000000080005ddc <printf>:
void printf(char *fmt, ...) {
    80005ddc:	7131                	addi	sp,sp,-192
    80005dde:	fc86                	sd	ra,120(sp)
    80005de0:	f8a2                	sd	s0,112(sp)
    80005de2:	e8d2                	sd	s4,80(sp)
    80005de4:	f06a                	sd	s10,32(sp)
    80005de6:	0100                	addi	s0,sp,128
    80005de8:	8a2a                	mv	s4,a0
    80005dea:	e40c                	sd	a1,8(s0)
    80005dec:	e810                	sd	a2,16(s0)
    80005dee:	ec14                	sd	a3,24(s0)
    80005df0:	f018                	sd	a4,32(s0)
    80005df2:	f41c                	sd	a5,40(s0)
    80005df4:	03043823          	sd	a6,48(s0)
    80005df8:	03143c23          	sd	a7,56(s0)
    locking = pr.locking;
    80005dfc:	00023d17          	auipc	s10,0x23
    80005e00:	404d2d03          	lw	s10,1028(s10) # 80029200 <pr+0x18>
    if (locking)
    80005e04:	040d1463          	bnez	s10,80005e4c <printf+0x70>
    if (fmt == 0)
    80005e08:	040a0b63          	beqz	s4,80005e5e <printf+0x82>
    va_start(ap, fmt);
    80005e0c:	00840793          	addi	a5,s0,8
    80005e10:	f8f43423          	sd	a5,-120(s0)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    80005e14:	000a4503          	lbu	a0,0(s4)
    80005e18:	18050b63          	beqz	a0,80005fae <printf+0x1d2>
    80005e1c:	f4a6                	sd	s1,104(sp)
    80005e1e:	f0ca                	sd	s2,96(sp)
    80005e20:	ecce                	sd	s3,88(sp)
    80005e22:	e4d6                	sd	s5,72(sp)
    80005e24:	e0da                	sd	s6,64(sp)
    80005e26:	fc5e                	sd	s7,56(sp)
    80005e28:	f862                	sd	s8,48(sp)
    80005e2a:	f466                	sd	s9,40(sp)
    80005e2c:	ec6e                	sd	s11,24(sp)
    80005e2e:	4981                	li	s3,0
        if (c != '%') {
    80005e30:	02500b13          	li	s6,37
        switch (c) {
    80005e34:	07000b93          	li	s7,112
    consputc('x');
    80005e38:	4cc1                	li	s9,16
        consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005e3a:	00003a97          	auipc	s5,0x3
    80005e3e:	b46a8a93          	addi	s5,s5,-1210 # 80008980 <digits>
        switch (c) {
    80005e42:	07300c13          	li	s8,115
    80005e46:	06400d93          	li	s11,100
    80005e4a:	a0b1                	j	80005e96 <printf+0xba>
        acquire(&pr.lock);
    80005e4c:	00023517          	auipc	a0,0x23
    80005e50:	39c50513          	addi	a0,a0,924 # 800291e8 <pr>
    80005e54:	00000097          	auipc	ra,0x0
    80005e58:	4b8080e7          	jalr	1208(ra) # 8000630c <acquire>
    80005e5c:	b775                	j	80005e08 <printf+0x2c>
    80005e5e:	f4a6                	sd	s1,104(sp)
    80005e60:	f0ca                	sd	s2,96(sp)
    80005e62:	ecce                	sd	s3,88(sp)
    80005e64:	e4d6                	sd	s5,72(sp)
    80005e66:	e0da                	sd	s6,64(sp)
    80005e68:	fc5e                	sd	s7,56(sp)
    80005e6a:	f862                	sd	s8,48(sp)
    80005e6c:	f466                	sd	s9,40(sp)
    80005e6e:	ec6e                	sd	s11,24(sp)
        panic("null fmt");
    80005e70:	00003517          	auipc	a0,0x3
    80005e74:	90050513          	addi	a0,a0,-1792 # 80008770 <etext+0x770>
    80005e78:	00000097          	auipc	ra,0x0
    80005e7c:	f1a080e7          	jalr	-230(ra) # 80005d92 <panic>
            consputc(c);
    80005e80:	00000097          	auipc	ra,0x0
    80005e84:	c46080e7          	jalr	-954(ra) # 80005ac6 <consputc>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    80005e88:	2985                	addiw	s3,s3,1
    80005e8a:	013a07b3          	add	a5,s4,s3
    80005e8e:	0007c503          	lbu	a0,0(a5)
    80005e92:	10050563          	beqz	a0,80005f9c <printf+0x1c0>
        if (c != '%') {
    80005e96:	ff6515e3          	bne	a0,s6,80005e80 <printf+0xa4>
        c = fmt[++i] & 0xff;
    80005e9a:	2985                	addiw	s3,s3,1
    80005e9c:	013a07b3          	add	a5,s4,s3
    80005ea0:	0007c783          	lbu	a5,0(a5)
    80005ea4:	0007849b          	sext.w	s1,a5
        if (c == 0)
    80005ea8:	10078b63          	beqz	a5,80005fbe <printf+0x1e2>
        switch (c) {
    80005eac:	05778a63          	beq	a5,s7,80005f00 <printf+0x124>
    80005eb0:	02fbf663          	bgeu	s7,a5,80005edc <printf+0x100>
    80005eb4:	09878863          	beq	a5,s8,80005f44 <printf+0x168>
    80005eb8:	07800713          	li	a4,120
    80005ebc:	0ce79563          	bne	a5,a4,80005f86 <printf+0x1aa>
            printint(va_arg(ap, int), 16, 1);
    80005ec0:	f8843783          	ld	a5,-120(s0)
    80005ec4:	00878713          	addi	a4,a5,8
    80005ec8:	f8e43423          	sd	a4,-120(s0)
    80005ecc:	4605                	li	a2,1
    80005ece:	85e6                	mv	a1,s9
    80005ed0:	4388                	lw	a0,0(a5)
    80005ed2:	00000097          	auipc	ra,0x0
    80005ed6:	e1c080e7          	jalr	-484(ra) # 80005cee <printint>
            break;
    80005eda:	b77d                	j	80005e88 <printf+0xac>
        switch (c) {
    80005edc:	09678f63          	beq	a5,s6,80005f7a <printf+0x19e>
    80005ee0:	0bb79363          	bne	a5,s11,80005f86 <printf+0x1aa>
            printint(va_arg(ap, int), 10, 1);
    80005ee4:	f8843783          	ld	a5,-120(s0)
    80005ee8:	00878713          	addi	a4,a5,8
    80005eec:	f8e43423          	sd	a4,-120(s0)
    80005ef0:	4605                	li	a2,1
    80005ef2:	45a9                	li	a1,10
    80005ef4:	4388                	lw	a0,0(a5)
    80005ef6:	00000097          	auipc	ra,0x0
    80005efa:	df8080e7          	jalr	-520(ra) # 80005cee <printint>
            break;
    80005efe:	b769                	j	80005e88 <printf+0xac>
            printptr(va_arg(ap, uint64));
    80005f00:	f8843783          	ld	a5,-120(s0)
    80005f04:	00878713          	addi	a4,a5,8
    80005f08:	f8e43423          	sd	a4,-120(s0)
    80005f0c:	0007b903          	ld	s2,0(a5)
    consputc('0');
    80005f10:	03000513          	li	a0,48
    80005f14:	00000097          	auipc	ra,0x0
    80005f18:	bb2080e7          	jalr	-1102(ra) # 80005ac6 <consputc>
    consputc('x');
    80005f1c:	07800513          	li	a0,120
    80005f20:	00000097          	auipc	ra,0x0
    80005f24:	ba6080e7          	jalr	-1114(ra) # 80005ac6 <consputc>
    80005f28:	84e6                	mv	s1,s9
        consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005f2a:	03c95793          	srli	a5,s2,0x3c
    80005f2e:	97d6                	add	a5,a5,s5
    80005f30:	0007c503          	lbu	a0,0(a5)
    80005f34:	00000097          	auipc	ra,0x0
    80005f38:	b92080e7          	jalr	-1134(ra) # 80005ac6 <consputc>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80005f3c:	0912                	slli	s2,s2,0x4
    80005f3e:	34fd                	addiw	s1,s1,-1
    80005f40:	f4ed                	bnez	s1,80005f2a <printf+0x14e>
    80005f42:	b799                	j	80005e88 <printf+0xac>
            if ((s = va_arg(ap, char *)) == 0)
    80005f44:	f8843783          	ld	a5,-120(s0)
    80005f48:	00878713          	addi	a4,a5,8
    80005f4c:	f8e43423          	sd	a4,-120(s0)
    80005f50:	6384                	ld	s1,0(a5)
    80005f52:	cc89                	beqz	s1,80005f6c <printf+0x190>
            for (; *s; s++)
    80005f54:	0004c503          	lbu	a0,0(s1)
    80005f58:	d905                	beqz	a0,80005e88 <printf+0xac>
                consputc(*s);
    80005f5a:	00000097          	auipc	ra,0x0
    80005f5e:	b6c080e7          	jalr	-1172(ra) # 80005ac6 <consputc>
            for (; *s; s++)
    80005f62:	0485                	addi	s1,s1,1
    80005f64:	0004c503          	lbu	a0,0(s1)
    80005f68:	f96d                	bnez	a0,80005f5a <printf+0x17e>
    80005f6a:	bf39                	j	80005e88 <printf+0xac>
                s = "(null)";
    80005f6c:	00002497          	auipc	s1,0x2
    80005f70:	7fc48493          	addi	s1,s1,2044 # 80008768 <etext+0x768>
            for (; *s; s++)
    80005f74:	02800513          	li	a0,40
    80005f78:	b7cd                	j	80005f5a <printf+0x17e>
            consputc('%');
    80005f7a:	855a                	mv	a0,s6
    80005f7c:	00000097          	auipc	ra,0x0
    80005f80:	b4a080e7          	jalr	-1206(ra) # 80005ac6 <consputc>
            break;
    80005f84:	b711                	j	80005e88 <printf+0xac>
            consputc('%');
    80005f86:	855a                	mv	a0,s6
    80005f88:	00000097          	auipc	ra,0x0
    80005f8c:	b3e080e7          	jalr	-1218(ra) # 80005ac6 <consputc>
            consputc(c);
    80005f90:	8526                	mv	a0,s1
    80005f92:	00000097          	auipc	ra,0x0
    80005f96:	b34080e7          	jalr	-1228(ra) # 80005ac6 <consputc>
            break;
    80005f9a:	b5fd                	j	80005e88 <printf+0xac>
    80005f9c:	74a6                	ld	s1,104(sp)
    80005f9e:	7906                	ld	s2,96(sp)
    80005fa0:	69e6                	ld	s3,88(sp)
    80005fa2:	6aa6                	ld	s5,72(sp)
    80005fa4:	6b06                	ld	s6,64(sp)
    80005fa6:	7be2                	ld	s7,56(sp)
    80005fa8:	7c42                	ld	s8,48(sp)
    80005faa:	7ca2                	ld	s9,40(sp)
    80005fac:	6de2                	ld	s11,24(sp)
    if (locking)
    80005fae:	020d1263          	bnez	s10,80005fd2 <printf+0x1f6>
}
    80005fb2:	70e6                	ld	ra,120(sp)
    80005fb4:	7446                	ld	s0,112(sp)
    80005fb6:	6a46                	ld	s4,80(sp)
    80005fb8:	7d02                	ld	s10,32(sp)
    80005fba:	6129                	addi	sp,sp,192
    80005fbc:	8082                	ret
    80005fbe:	74a6                	ld	s1,104(sp)
    80005fc0:	7906                	ld	s2,96(sp)
    80005fc2:	69e6                	ld	s3,88(sp)
    80005fc4:	6aa6                	ld	s5,72(sp)
    80005fc6:	6b06                	ld	s6,64(sp)
    80005fc8:	7be2                	ld	s7,56(sp)
    80005fca:	7c42                	ld	s8,48(sp)
    80005fcc:	7ca2                	ld	s9,40(sp)
    80005fce:	6de2                	ld	s11,24(sp)
    80005fd0:	bff9                	j	80005fae <printf+0x1d2>
        release(&pr.lock);
    80005fd2:	00023517          	auipc	a0,0x23
    80005fd6:	21650513          	addi	a0,a0,534 # 800291e8 <pr>
    80005fda:	00000097          	auipc	ra,0x0
    80005fde:	3e6080e7          	jalr	998(ra) # 800063c0 <release>
}
    80005fe2:	bfc1                	j	80005fb2 <printf+0x1d6>

0000000080005fe4 <printfinit>:
        ;
}

void printfinit(void) {
    80005fe4:	1101                	addi	sp,sp,-32
    80005fe6:	ec06                	sd	ra,24(sp)
    80005fe8:	e822                	sd	s0,16(sp)
    80005fea:	e426                	sd	s1,8(sp)
    80005fec:	1000                	addi	s0,sp,32
    initlock(&pr.lock, "pr");
    80005fee:	00023497          	auipc	s1,0x23
    80005ff2:	1fa48493          	addi	s1,s1,506 # 800291e8 <pr>
    80005ff6:	00002597          	auipc	a1,0x2
    80005ffa:	78a58593          	addi	a1,a1,1930 # 80008780 <etext+0x780>
    80005ffe:	8526                	mv	a0,s1
    80006000:	00000097          	auipc	ra,0x0
    80006004:	27c080e7          	jalr	636(ra) # 8000627c <initlock>
    pr.locking = 1;
    80006008:	4785                	li	a5,1
    8000600a:	cc9c                	sw	a5,24(s1)
}
    8000600c:	60e2                	ld	ra,24(sp)
    8000600e:	6442                	ld	s0,16(sp)
    80006010:	64a2                	ld	s1,8(sp)
    80006012:	6105                	addi	sp,sp,32
    80006014:	8082                	ret

0000000080006016 <uartinit>:

extern volatile int panicked; // from printf.c

void uartstart();

void uartinit(void) {
    80006016:	1141                	addi	sp,sp,-16
    80006018:	e406                	sd	ra,8(sp)
    8000601a:	e022                	sd	s0,0(sp)
    8000601c:	0800                	addi	s0,sp,16
    // disable interrupts.
    WriteReg(IER, 0x00);
    8000601e:	100007b7          	lui	a5,0x10000
    80006022:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

    // special mode to set baud rate.
    WriteReg(LCR, LCR_BAUD_LATCH);
    80006026:	10000737          	lui	a4,0x10000
    8000602a:	f8000693          	li	a3,-128
    8000602e:	00d701a3          	sb	a3,3(a4) # 10000003 <_entry-0x6ffffffd>

    // LSB for baud rate of 38.4K.
    WriteReg(0, 0x03);
    80006032:	468d                	li	a3,3
    80006034:	10000637          	lui	a2,0x10000
    80006038:	00d60023          	sb	a3,0(a2) # 10000000 <_entry-0x70000000>

    // MSB for baud rate of 38.4K.
    WriteReg(1, 0x00);
    8000603c:	000780a3          	sb	zero,1(a5)

    // leave set-baud mode,
    // and set word length to 8 bits, no parity.
    WriteReg(LCR, LCR_EIGHT_BITS);
    80006040:	00d701a3          	sb	a3,3(a4)

    // reset and enable FIFOs.
    WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80006044:	10000737          	lui	a4,0x10000
    80006048:	461d                	li	a2,7
    8000604a:	00c70123          	sb	a2,2(a4) # 10000002 <_entry-0x6ffffffe>

    // enable transmit and receive interrupts.
    WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    8000604e:	00d780a3          	sb	a3,1(a5)

    initlock(&uart_tx_lock, "uart");
    80006052:	00002597          	auipc	a1,0x2
    80006056:	73658593          	addi	a1,a1,1846 # 80008788 <etext+0x788>
    8000605a:	00023517          	auipc	a0,0x23
    8000605e:	1ae50513          	addi	a0,a0,430 # 80029208 <uart_tx_lock>
    80006062:	00000097          	auipc	ra,0x0
    80006066:	21a080e7          	jalr	538(ra) # 8000627c <initlock>
}
    8000606a:	60a2                	ld	ra,8(sp)
    8000606c:	6402                	ld	s0,0(sp)
    8000606e:	0141                	addi	sp,sp,16
    80006070:	8082                	ret

0000000080006072 <uartputc_sync>:

// alternate version of uartputc() that doesn't
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void uartputc_sync(int c) {
    80006072:	1101                	addi	sp,sp,-32
    80006074:	ec06                	sd	ra,24(sp)
    80006076:	e822                	sd	s0,16(sp)
    80006078:	e426                	sd	s1,8(sp)
    8000607a:	1000                	addi	s0,sp,32
    8000607c:	84aa                	mv	s1,a0
    push_off();
    8000607e:	00000097          	auipc	ra,0x0
    80006082:	242080e7          	jalr	578(ra) # 800062c0 <push_off>

    if (panicked) {
    80006086:	00006797          	auipc	a5,0x6
    8000608a:	f967a783          	lw	a5,-106(a5) # 8000c01c <panicked>
    8000608e:	eb85                	bnez	a5,800060be <uartputc_sync+0x4c>
        for (;;)
            ;
    }

    // wait for Transmit Holding Empty to be set in LSR.
    while ((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80006090:	10000737          	lui	a4,0x10000
    80006094:	0715                	addi	a4,a4,5 # 10000005 <_entry-0x6ffffffb>
    80006096:	00074783          	lbu	a5,0(a4)
    8000609a:	0207f793          	andi	a5,a5,32
    8000609e:	dfe5                	beqz	a5,80006096 <uartputc_sync+0x24>
        ;
    WriteReg(THR, c);
    800060a0:	0ff4f513          	zext.b	a0,s1
    800060a4:	100007b7          	lui	a5,0x10000
    800060a8:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

    pop_off();
    800060ac:	00000097          	auipc	ra,0x0
    800060b0:	2b4080e7          	jalr	692(ra) # 80006360 <pop_off>
}
    800060b4:	60e2                	ld	ra,24(sp)
    800060b6:	6442                	ld	s0,16(sp)
    800060b8:	64a2                	ld	s1,8(sp)
    800060ba:	6105                	addi	sp,sp,32
    800060bc:	8082                	ret
        for (;;)
    800060be:	a001                	j	800060be <uartputc_sync+0x4c>

00000000800060c0 <uartstart>:
// in the transmit buffer, send it.
// caller must hold uart_tx_lock.
// called from both the top- and bottom-half.
void uartstart() {
    while (1) {
        if (uart_tx_w == uart_tx_r) {
    800060c0:	00006797          	auipc	a5,0x6
    800060c4:	f607b783          	ld	a5,-160(a5) # 8000c020 <uart_tx_r>
    800060c8:	00006717          	auipc	a4,0x6
    800060cc:	f6073703          	ld	a4,-160(a4) # 8000c028 <uart_tx_w>
    800060d0:	06f70f63          	beq	a4,a5,8000614e <uartstart+0x8e>
void uartstart() {
    800060d4:	7139                	addi	sp,sp,-64
    800060d6:	fc06                	sd	ra,56(sp)
    800060d8:	f822                	sd	s0,48(sp)
    800060da:	f426                	sd	s1,40(sp)
    800060dc:	f04a                	sd	s2,32(sp)
    800060de:	ec4e                	sd	s3,24(sp)
    800060e0:	e852                	sd	s4,16(sp)
    800060e2:	e456                	sd	s5,8(sp)
    800060e4:	e05a                	sd	s6,0(sp)
    800060e6:	0080                	addi	s0,sp,64
            // transmit buffer is empty.
            return;
        }

        if ((ReadReg(LSR) & LSR_TX_IDLE) == 0) {
    800060e8:	10000937          	lui	s2,0x10000
    800060ec:	0915                	addi	s2,s2,5 # 10000005 <_entry-0x6ffffffb>
            // so we cannot give it another byte.
            // it will interrupt when it's ready for a new byte.
            return;
        }

        int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    800060ee:	00023a97          	auipc	s5,0x23
    800060f2:	11aa8a93          	addi	s5,s5,282 # 80029208 <uart_tx_lock>
        uart_tx_r += 1;
    800060f6:	00006497          	auipc	s1,0x6
    800060fa:	f2a48493          	addi	s1,s1,-214 # 8000c020 <uart_tx_r>

        // maybe uartputc() is waiting for space in the buffer.
        wakeup(&uart_tx_r);

        WriteReg(THR, c);
    800060fe:	10000a37          	lui	s4,0x10000
        if (uart_tx_w == uart_tx_r) {
    80006102:	00006997          	auipc	s3,0x6
    80006106:	f2698993          	addi	s3,s3,-218 # 8000c028 <uart_tx_w>
        if ((ReadReg(LSR) & LSR_TX_IDLE) == 0) {
    8000610a:	00094703          	lbu	a4,0(s2)
    8000610e:	02077713          	andi	a4,a4,32
    80006112:	c705                	beqz	a4,8000613a <uartstart+0x7a>
        int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80006114:	01f7f713          	andi	a4,a5,31
    80006118:	9756                	add	a4,a4,s5
    8000611a:	01874b03          	lbu	s6,24(a4)
        uart_tx_r += 1;
    8000611e:	0785                	addi	a5,a5,1
    80006120:	e09c                	sd	a5,0(s1)
        wakeup(&uart_tx_r);
    80006122:	8526                	mv	a0,s1
    80006124:	ffffb097          	auipc	ra,0xffffb
    80006128:	600080e7          	jalr	1536(ra) # 80001724 <wakeup>
        WriteReg(THR, c);
    8000612c:	016a0023          	sb	s6,0(s4) # 10000000 <_entry-0x70000000>
        if (uart_tx_w == uart_tx_r) {
    80006130:	609c                	ld	a5,0(s1)
    80006132:	0009b703          	ld	a4,0(s3)
    80006136:	fcf71ae3          	bne	a4,a5,8000610a <uartstart+0x4a>
    }
}
    8000613a:	70e2                	ld	ra,56(sp)
    8000613c:	7442                	ld	s0,48(sp)
    8000613e:	74a2                	ld	s1,40(sp)
    80006140:	7902                	ld	s2,32(sp)
    80006142:	69e2                	ld	s3,24(sp)
    80006144:	6a42                	ld	s4,16(sp)
    80006146:	6aa2                	ld	s5,8(sp)
    80006148:	6b02                	ld	s6,0(sp)
    8000614a:	6121                	addi	sp,sp,64
    8000614c:	8082                	ret
    8000614e:	8082                	ret

0000000080006150 <uartputc>:
void uartputc(int c) {
    80006150:	7179                	addi	sp,sp,-48
    80006152:	f406                	sd	ra,40(sp)
    80006154:	f022                	sd	s0,32(sp)
    80006156:	e052                	sd	s4,0(sp)
    80006158:	1800                	addi	s0,sp,48
    8000615a:	8a2a                	mv	s4,a0
    acquire(&uart_tx_lock);
    8000615c:	00023517          	auipc	a0,0x23
    80006160:	0ac50513          	addi	a0,a0,172 # 80029208 <uart_tx_lock>
    80006164:	00000097          	auipc	ra,0x0
    80006168:	1a8080e7          	jalr	424(ra) # 8000630c <acquire>
    if (panicked) {
    8000616c:	00006797          	auipc	a5,0x6
    80006170:	eb07a783          	lw	a5,-336(a5) # 8000c01c <panicked>
    80006174:	c391                	beqz	a5,80006178 <uartputc+0x28>
        for (;;)
    80006176:	a001                	j	80006176 <uartputc+0x26>
    80006178:	ec26                	sd	s1,24(sp)
        if (uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE) {
    8000617a:	00006717          	auipc	a4,0x6
    8000617e:	eae73703          	ld	a4,-338(a4) # 8000c028 <uart_tx_w>
    80006182:	00006797          	auipc	a5,0x6
    80006186:	e9e7b783          	ld	a5,-354(a5) # 8000c020 <uart_tx_r>
    8000618a:	02078793          	addi	a5,a5,32
    8000618e:	02e79f63          	bne	a5,a4,800061cc <uartputc+0x7c>
    80006192:	e84a                	sd	s2,16(sp)
    80006194:	e44e                	sd	s3,8(sp)
            sleep(&uart_tx_r, &uart_tx_lock);
    80006196:	00023997          	auipc	s3,0x23
    8000619a:	07298993          	addi	s3,s3,114 # 80029208 <uart_tx_lock>
    8000619e:	00006497          	auipc	s1,0x6
    800061a2:	e8248493          	addi	s1,s1,-382 # 8000c020 <uart_tx_r>
        if (uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE) {
    800061a6:	00006917          	auipc	s2,0x6
    800061aa:	e8290913          	addi	s2,s2,-382 # 8000c028 <uart_tx_w>
            sleep(&uart_tx_r, &uart_tx_lock);
    800061ae:	85ce                	mv	a1,s3
    800061b0:	8526                	mv	a0,s1
    800061b2:	ffffb097          	auipc	ra,0xffffb
    800061b6:	3e6080e7          	jalr	998(ra) # 80001598 <sleep>
        if (uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE) {
    800061ba:	00093703          	ld	a4,0(s2)
    800061be:	609c                	ld	a5,0(s1)
    800061c0:	02078793          	addi	a5,a5,32
    800061c4:	fee785e3          	beq	a5,a4,800061ae <uartputc+0x5e>
    800061c8:	6942                	ld	s2,16(sp)
    800061ca:	69a2                	ld	s3,8(sp)
            uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    800061cc:	00023497          	auipc	s1,0x23
    800061d0:	03c48493          	addi	s1,s1,60 # 80029208 <uart_tx_lock>
    800061d4:	01f77793          	andi	a5,a4,31
    800061d8:	97a6                	add	a5,a5,s1
    800061da:	01478c23          	sb	s4,24(a5)
            uart_tx_w += 1;
    800061de:	0705                	addi	a4,a4,1
    800061e0:	00006797          	auipc	a5,0x6
    800061e4:	e4e7b423          	sd	a4,-440(a5) # 8000c028 <uart_tx_w>
            uartstart();
    800061e8:	00000097          	auipc	ra,0x0
    800061ec:	ed8080e7          	jalr	-296(ra) # 800060c0 <uartstart>
            release(&uart_tx_lock);
    800061f0:	8526                	mv	a0,s1
    800061f2:	00000097          	auipc	ra,0x0
    800061f6:	1ce080e7          	jalr	462(ra) # 800063c0 <release>
    800061fa:	64e2                	ld	s1,24(sp)
}
    800061fc:	70a2                	ld	ra,40(sp)
    800061fe:	7402                	ld	s0,32(sp)
    80006200:	6a02                	ld	s4,0(sp)
    80006202:	6145                	addi	sp,sp,48
    80006204:	8082                	ret

0000000080006206 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int uartgetc(void) {
    80006206:	1141                	addi	sp,sp,-16
    80006208:	e422                	sd	s0,8(sp)
    8000620a:	0800                	addi	s0,sp,16
    if (ReadReg(LSR) & 0x01) {
    8000620c:	100007b7          	lui	a5,0x10000
    80006210:	0795                	addi	a5,a5,5 # 10000005 <_entry-0x6ffffffb>
    80006212:	0007c783          	lbu	a5,0(a5)
    80006216:	8b85                	andi	a5,a5,1
    80006218:	cb81                	beqz	a5,80006228 <uartgetc+0x22>
        // input data is ready.
        return ReadReg(RHR);
    8000621a:	100007b7          	lui	a5,0x10000
    8000621e:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    } else {
        return -1;
    }
}
    80006222:	6422                	ld	s0,8(sp)
    80006224:	0141                	addi	sp,sp,16
    80006226:	8082                	ret
        return -1;
    80006228:	557d                	li	a0,-1
    8000622a:	bfe5                	j	80006222 <uartgetc+0x1c>

000000008000622c <uartintr>:

// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void uartintr(void) {
    8000622c:	1101                	addi	sp,sp,-32
    8000622e:	ec06                	sd	ra,24(sp)
    80006230:	e822                	sd	s0,16(sp)
    80006232:	e426                	sd	s1,8(sp)
    80006234:	1000                	addi	s0,sp,32
    // read and process incoming characters.
    while (1) {
        int c = uartgetc();
        if (c == -1)
    80006236:	54fd                	li	s1,-1
    80006238:	a029                	j	80006242 <uartintr+0x16>
            break;
        consoleintr(c);
    8000623a:	00000097          	auipc	ra,0x0
    8000623e:	8ce080e7          	jalr	-1842(ra) # 80005b08 <consoleintr>
        int c = uartgetc();
    80006242:	00000097          	auipc	ra,0x0
    80006246:	fc4080e7          	jalr	-60(ra) # 80006206 <uartgetc>
        if (c == -1)
    8000624a:	fe9518e3          	bne	a0,s1,8000623a <uartintr+0xe>
    }

    // send buffered characters.
    acquire(&uart_tx_lock);
    8000624e:	00023497          	auipc	s1,0x23
    80006252:	fba48493          	addi	s1,s1,-70 # 80029208 <uart_tx_lock>
    80006256:	8526                	mv	a0,s1
    80006258:	00000097          	auipc	ra,0x0
    8000625c:	0b4080e7          	jalr	180(ra) # 8000630c <acquire>
    uartstart();
    80006260:	00000097          	auipc	ra,0x0
    80006264:	e60080e7          	jalr	-416(ra) # 800060c0 <uartstart>
    release(&uart_tx_lock);
    80006268:	8526                	mv	a0,s1
    8000626a:	00000097          	auipc	ra,0x0
    8000626e:	156080e7          	jalr	342(ra) # 800063c0 <release>
}
    80006272:	60e2                	ld	ra,24(sp)
    80006274:	6442                	ld	s0,16(sp)
    80006276:	64a2                	ld	s1,8(sp)
    80006278:	6105                	addi	sp,sp,32
    8000627a:	8082                	ret

000000008000627c <initlock>:
#include "spinlock.h"
#include "riscv.h"
#include "proc.h"
#include "defs.h"

void initlock(struct spinlock *lk, char *name) {
    8000627c:	1141                	addi	sp,sp,-16
    8000627e:	e422                	sd	s0,8(sp)
    80006280:	0800                	addi	s0,sp,16
    lk->name = name;
    80006282:	e50c                	sd	a1,8(a0)
    lk->locked = 0;
    80006284:	00052023          	sw	zero,0(a0)
    lk->cpu = 0;
    80006288:	00053823          	sd	zero,16(a0)
}
    8000628c:	6422                	ld	s0,8(sp)
    8000628e:	0141                	addi	sp,sp,16
    80006290:	8082                	ret

0000000080006292 <holding>:

// Check whether this cpu is holding the lock.
// Interrupts must be off.
int holding(struct spinlock *lk) {
    int r;
    r = (lk->locked && lk->cpu == mycpu());
    80006292:	411c                	lw	a5,0(a0)
    80006294:	e399                	bnez	a5,8000629a <holding+0x8>
    80006296:	4501                	li	a0,0
    return r;
}
    80006298:	8082                	ret
int holding(struct spinlock *lk) {
    8000629a:	1101                	addi	sp,sp,-32
    8000629c:	ec06                	sd	ra,24(sp)
    8000629e:	e822                	sd	s0,16(sp)
    800062a0:	e426                	sd	s1,8(sp)
    800062a2:	1000                	addi	s0,sp,32
    r = (lk->locked && lk->cpu == mycpu());
    800062a4:	6904                	ld	s1,16(a0)
    800062a6:	ffffb097          	auipc	ra,0xffffb
    800062aa:	c04080e7          	jalr	-1020(ra) # 80000eaa <mycpu>
    800062ae:	40a48533          	sub	a0,s1,a0
    800062b2:	00153513          	seqz	a0,a0
}
    800062b6:	60e2                	ld	ra,24(sp)
    800062b8:	6442                	ld	s0,16(sp)
    800062ba:	64a2                	ld	s1,8(sp)
    800062bc:	6105                	addi	sp,sp,32
    800062be:	8082                	ret

00000000800062c0 <push_off>:

// push_off/pop_off are like intr_off()/intr_on() except that they are matched:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void push_off(void) {
    800062c0:	1101                	addi	sp,sp,-32
    800062c2:	ec06                	sd	ra,24(sp)
    800062c4:	e822                	sd	s0,16(sp)
    800062c6:	e426                	sd	s1,8(sp)
    800062c8:	1000                	addi	s0,sp,32
    asm volatile("csrr %0, sstatus" : "=r"(x));
    800062ca:	100024f3          	csrr	s1,sstatus
    800062ce:	100027f3          	csrr	a5,sstatus
static inline void intr_off() { w_sstatus(r_sstatus() & ~SSTATUS_SIE); }
    800062d2:	9bf5                	andi	a5,a5,-3
    asm volatile("csrw sstatus, %0" : : "r"(x));
    800062d4:	10079073          	csrw	sstatus,a5
    int old = intr_get();

    intr_off();
    if (mycpu()->noff == 0)
    800062d8:	ffffb097          	auipc	ra,0xffffb
    800062dc:	bd2080e7          	jalr	-1070(ra) # 80000eaa <mycpu>
    800062e0:	5d3c                	lw	a5,120(a0)
    800062e2:	cf89                	beqz	a5,800062fc <push_off+0x3c>
        mycpu()->intena = old;
    mycpu()->noff += 1;
    800062e4:	ffffb097          	auipc	ra,0xffffb
    800062e8:	bc6080e7          	jalr	-1082(ra) # 80000eaa <mycpu>
    800062ec:	5d3c                	lw	a5,120(a0)
    800062ee:	2785                	addiw	a5,a5,1
    800062f0:	dd3c                	sw	a5,120(a0)
}
    800062f2:	60e2                	ld	ra,24(sp)
    800062f4:	6442                	ld	s0,16(sp)
    800062f6:	64a2                	ld	s1,8(sp)
    800062f8:	6105                	addi	sp,sp,32
    800062fa:	8082                	ret
        mycpu()->intena = old;
    800062fc:	ffffb097          	auipc	ra,0xffffb
    80006300:	bae080e7          	jalr	-1106(ra) # 80000eaa <mycpu>
    return (x & SSTATUS_SIE) != 0;
    80006304:	8085                	srli	s1,s1,0x1
    80006306:	8885                	andi	s1,s1,1
    80006308:	dd64                	sw	s1,124(a0)
    8000630a:	bfe9                	j	800062e4 <push_off+0x24>

000000008000630c <acquire>:
void acquire(struct spinlock *lk) {
    8000630c:	1101                	addi	sp,sp,-32
    8000630e:	ec06                	sd	ra,24(sp)
    80006310:	e822                	sd	s0,16(sp)
    80006312:	e426                	sd	s1,8(sp)
    80006314:	1000                	addi	s0,sp,32
    80006316:	84aa                	mv	s1,a0
    push_off(); // disable interrupts to avoid deadlock.
    80006318:	00000097          	auipc	ra,0x0
    8000631c:	fa8080e7          	jalr	-88(ra) # 800062c0 <push_off>
    if (holding(lk))
    80006320:	8526                	mv	a0,s1
    80006322:	00000097          	auipc	ra,0x0
    80006326:	f70080e7          	jalr	-144(ra) # 80006292 <holding>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
    8000632a:	4705                	li	a4,1
    if (holding(lk))
    8000632c:	e115                	bnez	a0,80006350 <acquire+0x44>
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0)
    8000632e:	87ba                	mv	a5,a4
    80006330:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006334:	2781                	sext.w	a5,a5
    80006336:	ffe5                	bnez	a5,8000632e <acquire+0x22>
    __sync_synchronize();
    80006338:	0ff0000f          	fence
    lk->cpu = mycpu();
    8000633c:	ffffb097          	auipc	ra,0xffffb
    80006340:	b6e080e7          	jalr	-1170(ra) # 80000eaa <mycpu>
    80006344:	e888                	sd	a0,16(s1)
}
    80006346:	60e2                	ld	ra,24(sp)
    80006348:	6442                	ld	s0,16(sp)
    8000634a:	64a2                	ld	s1,8(sp)
    8000634c:	6105                	addi	sp,sp,32
    8000634e:	8082                	ret
        panic("acquire");
    80006350:	00002517          	auipc	a0,0x2
    80006354:	44050513          	addi	a0,a0,1088 # 80008790 <etext+0x790>
    80006358:	00000097          	auipc	ra,0x0
    8000635c:	a3a080e7          	jalr	-1478(ra) # 80005d92 <panic>

0000000080006360 <pop_off>:

void pop_off(void) {
    80006360:	1141                	addi	sp,sp,-16
    80006362:	e406                	sd	ra,8(sp)
    80006364:	e022                	sd	s0,0(sp)
    80006366:	0800                	addi	s0,sp,16
    struct cpu *c = mycpu();
    80006368:	ffffb097          	auipc	ra,0xffffb
    8000636c:	b42080e7          	jalr	-1214(ra) # 80000eaa <mycpu>
    asm volatile("csrr %0, sstatus" : "=r"(x));
    80006370:	100027f3          	csrr	a5,sstatus
    return (x & SSTATUS_SIE) != 0;
    80006374:	8b89                	andi	a5,a5,2
    if (intr_get())
    80006376:	e78d                	bnez	a5,800063a0 <pop_off+0x40>
        panic("pop_off - interruptible");
    if (c->noff < 1)
    80006378:	5d3c                	lw	a5,120(a0)
    8000637a:	02f05b63          	blez	a5,800063b0 <pop_off+0x50>
        panic("pop_off");
    c->noff -= 1;
    8000637e:	37fd                	addiw	a5,a5,-1
    80006380:	0007871b          	sext.w	a4,a5
    80006384:	dd3c                	sw	a5,120(a0)
    if (c->noff == 0 && c->intena)
    80006386:	eb09                	bnez	a4,80006398 <pop_off+0x38>
    80006388:	5d7c                	lw	a5,124(a0)
    8000638a:	c799                	beqz	a5,80006398 <pop_off+0x38>
    asm volatile("csrr %0, sstatus" : "=r"(x));
    8000638c:	100027f3          	csrr	a5,sstatus
static inline void intr_on() { w_sstatus(r_sstatus() | SSTATUS_SIE); }
    80006390:	0027e793          	ori	a5,a5,2
    asm volatile("csrw sstatus, %0" : : "r"(x));
    80006394:	10079073          	csrw	sstatus,a5
        intr_on();
}
    80006398:	60a2                	ld	ra,8(sp)
    8000639a:	6402                	ld	s0,0(sp)
    8000639c:	0141                	addi	sp,sp,16
    8000639e:	8082                	ret
        panic("pop_off - interruptible");
    800063a0:	00002517          	auipc	a0,0x2
    800063a4:	3f850513          	addi	a0,a0,1016 # 80008798 <etext+0x798>
    800063a8:	00000097          	auipc	ra,0x0
    800063ac:	9ea080e7          	jalr	-1558(ra) # 80005d92 <panic>
        panic("pop_off");
    800063b0:	00002517          	auipc	a0,0x2
    800063b4:	40050513          	addi	a0,a0,1024 # 800087b0 <etext+0x7b0>
    800063b8:	00000097          	auipc	ra,0x0
    800063bc:	9da080e7          	jalr	-1574(ra) # 80005d92 <panic>

00000000800063c0 <release>:
void release(struct spinlock *lk) {
    800063c0:	1101                	addi	sp,sp,-32
    800063c2:	ec06                	sd	ra,24(sp)
    800063c4:	e822                	sd	s0,16(sp)
    800063c6:	e426                	sd	s1,8(sp)
    800063c8:	1000                	addi	s0,sp,32
    800063ca:	84aa                	mv	s1,a0
    if (!holding(lk))
    800063cc:	00000097          	auipc	ra,0x0
    800063d0:	ec6080e7          	jalr	-314(ra) # 80006292 <holding>
    800063d4:	c115                	beqz	a0,800063f8 <release+0x38>
    lk->cpu = 0;
    800063d6:	0004b823          	sd	zero,16(s1)
    __sync_synchronize();
    800063da:	0ff0000f          	fence
    __sync_lock_release(&lk->locked);
    800063de:	0f50000f          	fence	iorw,ow
    800063e2:	0804a02f          	amoswap.w	zero,zero,(s1)
    pop_off();
    800063e6:	00000097          	auipc	ra,0x0
    800063ea:	f7a080e7          	jalr	-134(ra) # 80006360 <pop_off>
}
    800063ee:	60e2                	ld	ra,24(sp)
    800063f0:	6442                	ld	s0,16(sp)
    800063f2:	64a2                	ld	s1,8(sp)
    800063f4:	6105                	addi	sp,sp,32
    800063f6:	8082                	ret
        panic("release");
    800063f8:	00002517          	auipc	a0,0x2
    800063fc:	3c050513          	addi	a0,a0,960 # 800087b8 <etext+0x7b8>
    80006400:	00000097          	auipc	ra,0x0
    80006404:	992080e7          	jalr	-1646(ra) # 80005d92 <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051573          	csrrw	a0,sscratch,a0
    80007004:	02153423          	sd	ra,40(a0)
    80007008:	02253823          	sd	sp,48(a0)
    8000700c:	02353c23          	sd	gp,56(a0)
    80007010:	04453023          	sd	tp,64(a0)
    80007014:	04553423          	sd	t0,72(a0)
    80007018:	04653823          	sd	t1,80(a0)
    8000701c:	04753c23          	sd	t2,88(a0)
    80007020:	f120                	sd	s0,96(a0)
    80007022:	f524                	sd	s1,104(a0)
    80007024:	fd2c                	sd	a1,120(a0)
    80007026:	e150                	sd	a2,128(a0)
    80007028:	e554                	sd	a3,136(a0)
    8000702a:	e958                	sd	a4,144(a0)
    8000702c:	ed5c                	sd	a5,152(a0)
    8000702e:	0b053023          	sd	a6,160(a0)
    80007032:	0b153423          	sd	a7,168(a0)
    80007036:	0b253823          	sd	s2,176(a0)
    8000703a:	0b353c23          	sd	s3,184(a0)
    8000703e:	0d453023          	sd	s4,192(a0)
    80007042:	0d553423          	sd	s5,200(a0)
    80007046:	0d653823          	sd	s6,208(a0)
    8000704a:	0d753c23          	sd	s7,216(a0)
    8000704e:	0f853023          	sd	s8,224(a0)
    80007052:	0f953423          	sd	s9,232(a0)
    80007056:	0fa53823          	sd	s10,240(a0)
    8000705a:	0fb53c23          	sd	s11,248(a0)
    8000705e:	11c53023          	sd	t3,256(a0)
    80007062:	11d53423          	sd	t4,264(a0)
    80007066:	11e53823          	sd	t5,272(a0)
    8000706a:	11f53c23          	sd	t6,280(a0)
    8000706e:	140022f3          	csrr	t0,sscratch
    80007072:	06553823          	sd	t0,112(a0)
    80007076:	00853103          	ld	sp,8(a0)
    8000707a:	02053203          	ld	tp,32(a0)
    8000707e:	01053283          	ld	t0,16(a0)
    80007082:	00053303          	ld	t1,0(a0)
    80007086:	18031073          	csrw	satp,t1
    8000708a:	12000073          	sfence.vma
    8000708e:	8282                	jr	t0

0000000080007090 <userret>:
    80007090:	18059073          	csrw	satp,a1
    80007094:	12000073          	sfence.vma
    80007098:	07053283          	ld	t0,112(a0)
    8000709c:	14029073          	csrw	sscratch,t0
    800070a0:	02853083          	ld	ra,40(a0)
    800070a4:	03053103          	ld	sp,48(a0)
    800070a8:	03853183          	ld	gp,56(a0)
    800070ac:	04053203          	ld	tp,64(a0)
    800070b0:	04853283          	ld	t0,72(a0)
    800070b4:	05053303          	ld	t1,80(a0)
    800070b8:	05853383          	ld	t2,88(a0)
    800070bc:	7120                	ld	s0,96(a0)
    800070be:	7524                	ld	s1,104(a0)
    800070c0:	7d2c                	ld	a1,120(a0)
    800070c2:	6150                	ld	a2,128(a0)
    800070c4:	6554                	ld	a3,136(a0)
    800070c6:	6958                	ld	a4,144(a0)
    800070c8:	6d5c                	ld	a5,152(a0)
    800070ca:	0a053803          	ld	a6,160(a0)
    800070ce:	0a853883          	ld	a7,168(a0)
    800070d2:	0b053903          	ld	s2,176(a0)
    800070d6:	0b853983          	ld	s3,184(a0)
    800070da:	0c053a03          	ld	s4,192(a0)
    800070de:	0c853a83          	ld	s5,200(a0)
    800070e2:	0d053b03          	ld	s6,208(a0)
    800070e6:	0d853b83          	ld	s7,216(a0)
    800070ea:	0e053c03          	ld	s8,224(a0)
    800070ee:	0e853c83          	ld	s9,232(a0)
    800070f2:	0f053d03          	ld	s10,240(a0)
    800070f6:	0f853d83          	ld	s11,248(a0)
    800070fa:	10053e03          	ld	t3,256(a0)
    800070fe:	10853e83          	ld	t4,264(a0)
    80007102:	11053f03          	ld	t5,272(a0)
    80007106:	11853f83          	ld	t6,280(a0)
    8000710a:	14051573          	csrrw	a0,sscratch,a0
    8000710e:	10200073          	sret
	...
