
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
        close(fds[1]);
    }
}

// what if you pass ridiculous string pointers to system calls?
void copyinstr1(char *s) {
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
    uint64 addrs[] = {0x80000000LL, 0xffffffffffffffff};

    for (int ai = 0; ai < 2; ai++) {
        uint64 addr = addrs[ai];

        int fd = open((char *)addr, O_CREATE | O_WRONLY);
       8:	20100593          	li	a1,513
       c:	4505                	li	a0,1
       e:	057e                	slli	a0,a0,0x1f
      10:	00006097          	auipc	ra,0x6
      14:	904080e7          	jalr	-1788(ra) # 5914 <open>
        if (fd >= 0) {
      18:	02055063          	bgez	a0,38 <copyinstr1+0x38>
        int fd = open((char *)addr, O_CREATE | O_WRONLY);
      1c:	20100593          	li	a1,513
      20:	557d                	li	a0,-1
      22:	00006097          	auipc	ra,0x6
      26:	8f2080e7          	jalr	-1806(ra) # 5914 <open>
        if (fd >= 0) {
      2a:	55fd                	li	a1,-1
      2c:	00055863          	bgez	a0,3c <copyinstr1+0x3c>
            printf("open(%p) returned %d, not -1\n", addr, fd);
            exit(1);
        }
    }
}
      30:	60a2                	ld	ra,8(sp)
      32:	6402                	ld	s0,0(sp)
      34:	0141                	addi	sp,sp,16
      36:	8082                	ret
        uint64 addr = addrs[ai];
      38:	4585                	li	a1,1
      3a:	05fe                	slli	a1,a1,0x1f
            printf("open(%p) returned %d, not -1\n", addr, fd);
      3c:	862a                	mv	a2,a0
      3e:	00006517          	auipc	a0,0x6
      42:	dca50513          	addi	a0,a0,-566 # 5e08 <malloc+0x104>
      46:	00006097          	auipc	ra,0x6
      4a:	c06080e7          	jalr	-1018(ra) # 5c4c <printf>
            exit(1);
      4e:	4505                	li	a0,1
      50:	00006097          	auipc	ra,0x6
      54:	884080e7          	jalr	-1916(ra) # 58d4 <exit>

0000000000000058 <bsstest>:
// does uninitialized data start out zero?
char uninit[10000];
void bsstest(char *s) {
    int i;

    for (i = 0; i < sizeof(uninit); i++) {
      58:	0000b797          	auipc	a5,0xb
      5c:	97878793          	addi	a5,a5,-1672 # a9d0 <uninit>
      60:	0000d697          	auipc	a3,0xd
      64:	08068693          	addi	a3,a3,128 # d0e0 <buf>
        if (uninit[i] != '\0') {
      68:	0007c703          	lbu	a4,0(a5)
      6c:	e709                	bnez	a4,76 <bsstest+0x1e>
    for (i = 0; i < sizeof(uninit); i++) {
      6e:	0785                	addi	a5,a5,1
      70:	fed79ce3          	bne	a5,a3,68 <bsstest+0x10>
      74:	8082                	ret
void bsstest(char *s) {
      76:	1141                	addi	sp,sp,-16
      78:	e406                	sd	ra,8(sp)
      7a:	e022                	sd	s0,0(sp)
      7c:	0800                	addi	s0,sp,16
            printf("%s: bss test failed\n", s);
      7e:	85aa                	mv	a1,a0
      80:	00006517          	auipc	a0,0x6
      84:	da850513          	addi	a0,a0,-600 # 5e28 <malloc+0x124>
      88:	00006097          	auipc	ra,0x6
      8c:	bc4080e7          	jalr	-1084(ra) # 5c4c <printf>
            exit(1);
      90:	4505                	li	a0,1
      92:	00006097          	auipc	ra,0x6
      96:	842080e7          	jalr	-1982(ra) # 58d4 <exit>

000000000000009a <opentest>:
void opentest(char *s) {
      9a:	1101                	addi	sp,sp,-32
      9c:	ec06                	sd	ra,24(sp)
      9e:	e822                	sd	s0,16(sp)
      a0:	e426                	sd	s1,8(sp)
      a2:	1000                	addi	s0,sp,32
      a4:	84aa                	mv	s1,a0
    fd = open("echo", 0);
      a6:	4581                	li	a1,0
      a8:	00006517          	auipc	a0,0x6
      ac:	d9850513          	addi	a0,a0,-616 # 5e40 <malloc+0x13c>
      b0:	00006097          	auipc	ra,0x6
      b4:	864080e7          	jalr	-1948(ra) # 5914 <open>
    if (fd < 0) {
      b8:	02054663          	bltz	a0,e4 <opentest+0x4a>
    close(fd);
      bc:	00006097          	auipc	ra,0x6
      c0:	840080e7          	jalr	-1984(ra) # 58fc <close>
    fd = open("doesnotexist", 0);
      c4:	4581                	li	a1,0
      c6:	00006517          	auipc	a0,0x6
      ca:	d9a50513          	addi	a0,a0,-614 # 5e60 <malloc+0x15c>
      ce:	00006097          	auipc	ra,0x6
      d2:	846080e7          	jalr	-1978(ra) # 5914 <open>
    if (fd >= 0) {
      d6:	02055563          	bgez	a0,100 <opentest+0x66>
}
      da:	60e2                	ld	ra,24(sp)
      dc:	6442                	ld	s0,16(sp)
      de:	64a2                	ld	s1,8(sp)
      e0:	6105                	addi	sp,sp,32
      e2:	8082                	ret
        printf("%s: open echo failed!\n", s);
      e4:	85a6                	mv	a1,s1
      e6:	00006517          	auipc	a0,0x6
      ea:	d6250513          	addi	a0,a0,-670 # 5e48 <malloc+0x144>
      ee:	00006097          	auipc	ra,0x6
      f2:	b5e080e7          	jalr	-1186(ra) # 5c4c <printf>
        exit(1);
      f6:	4505                	li	a0,1
      f8:	00005097          	auipc	ra,0x5
      fc:	7dc080e7          	jalr	2012(ra) # 58d4 <exit>
        printf("%s: open doesnotexist succeeded!\n", s);
     100:	85a6                	mv	a1,s1
     102:	00006517          	auipc	a0,0x6
     106:	d6e50513          	addi	a0,a0,-658 # 5e70 <malloc+0x16c>
     10a:	00006097          	auipc	ra,0x6
     10e:	b42080e7          	jalr	-1214(ra) # 5c4c <printf>
        exit(1);
     112:	4505                	li	a0,1
     114:	00005097          	auipc	ra,0x5
     118:	7c0080e7          	jalr	1984(ra) # 58d4 <exit>

000000000000011c <truncate2>:
void truncate2(char *s) {
     11c:	7179                	addi	sp,sp,-48
     11e:	f406                	sd	ra,40(sp)
     120:	f022                	sd	s0,32(sp)
     122:	ec26                	sd	s1,24(sp)
     124:	e84a                	sd	s2,16(sp)
     126:	e44e                	sd	s3,8(sp)
     128:	1800                	addi	s0,sp,48
     12a:	89aa                	mv	s3,a0
    unlink("truncfile");
     12c:	00006517          	auipc	a0,0x6
     130:	d6c50513          	addi	a0,a0,-660 # 5e98 <malloc+0x194>
     134:	00005097          	auipc	ra,0x5
     138:	7f0080e7          	jalr	2032(ra) # 5924 <unlink>
    int fd1 = open("truncfile", O_CREATE | O_TRUNC | O_WRONLY);
     13c:	60100593          	li	a1,1537
     140:	00006517          	auipc	a0,0x6
     144:	d5850513          	addi	a0,a0,-680 # 5e98 <malloc+0x194>
     148:	00005097          	auipc	ra,0x5
     14c:	7cc080e7          	jalr	1996(ra) # 5914 <open>
     150:	84aa                	mv	s1,a0
    write(fd1, "abcd", 4);
     152:	4611                	li	a2,4
     154:	00006597          	auipc	a1,0x6
     158:	d5458593          	addi	a1,a1,-684 # 5ea8 <malloc+0x1a4>
     15c:	00005097          	auipc	ra,0x5
     160:	798080e7          	jalr	1944(ra) # 58f4 <write>
    int fd2 = open("truncfile", O_TRUNC | O_WRONLY);
     164:	40100593          	li	a1,1025
     168:	00006517          	auipc	a0,0x6
     16c:	d3050513          	addi	a0,a0,-720 # 5e98 <malloc+0x194>
     170:	00005097          	auipc	ra,0x5
     174:	7a4080e7          	jalr	1956(ra) # 5914 <open>
     178:	892a                	mv	s2,a0
    int n = write(fd1, "x", 1);
     17a:	4605                	li	a2,1
     17c:	00006597          	auipc	a1,0x6
     180:	d3458593          	addi	a1,a1,-716 # 5eb0 <malloc+0x1ac>
     184:	8526                	mv	a0,s1
     186:	00005097          	auipc	ra,0x5
     18a:	76e080e7          	jalr	1902(ra) # 58f4 <write>
    if (n != -1) {
     18e:	57fd                	li	a5,-1
     190:	02f51b63          	bne	a0,a5,1c6 <truncate2+0xaa>
    unlink("truncfile");
     194:	00006517          	auipc	a0,0x6
     198:	d0450513          	addi	a0,a0,-764 # 5e98 <malloc+0x194>
     19c:	00005097          	auipc	ra,0x5
     1a0:	788080e7          	jalr	1928(ra) # 5924 <unlink>
    close(fd1);
     1a4:	8526                	mv	a0,s1
     1a6:	00005097          	auipc	ra,0x5
     1aa:	756080e7          	jalr	1878(ra) # 58fc <close>
    close(fd2);
     1ae:	854a                	mv	a0,s2
     1b0:	00005097          	auipc	ra,0x5
     1b4:	74c080e7          	jalr	1868(ra) # 58fc <close>
}
     1b8:	70a2                	ld	ra,40(sp)
     1ba:	7402                	ld	s0,32(sp)
     1bc:	64e2                	ld	s1,24(sp)
     1be:	6942                	ld	s2,16(sp)
     1c0:	69a2                	ld	s3,8(sp)
     1c2:	6145                	addi	sp,sp,48
     1c4:	8082                	ret
        printf("%s: write returned %d, expected -1\n", s, n);
     1c6:	862a                	mv	a2,a0
     1c8:	85ce                	mv	a1,s3
     1ca:	00006517          	auipc	a0,0x6
     1ce:	cee50513          	addi	a0,a0,-786 # 5eb8 <malloc+0x1b4>
     1d2:	00006097          	auipc	ra,0x6
     1d6:	a7a080e7          	jalr	-1414(ra) # 5c4c <printf>
        exit(1);
     1da:	4505                	li	a0,1
     1dc:	00005097          	auipc	ra,0x5
     1e0:	6f8080e7          	jalr	1784(ra) # 58d4 <exit>

00000000000001e4 <createtest>:
void createtest(char *s) {
     1e4:	7179                	addi	sp,sp,-48
     1e6:	f406                	sd	ra,40(sp)
     1e8:	f022                	sd	s0,32(sp)
     1ea:	ec26                	sd	s1,24(sp)
     1ec:	e84a                	sd	s2,16(sp)
     1ee:	1800                	addi	s0,sp,48
    name[0] = 'a';
     1f0:	06100793          	li	a5,97
     1f4:	fcf40c23          	sb	a5,-40(s0)
    name[2] = '\0';
     1f8:	fc040d23          	sb	zero,-38(s0)
     1fc:	03000493          	li	s1,48
    for (i = 0; i < N; i++) {
     200:	06400913          	li	s2,100
        name[1] = '0' + i;
     204:	fc940ca3          	sb	s1,-39(s0)
        fd = open(name, O_CREATE | O_RDWR);
     208:	20200593          	li	a1,514
     20c:	fd840513          	addi	a0,s0,-40
     210:	00005097          	auipc	ra,0x5
     214:	704080e7          	jalr	1796(ra) # 5914 <open>
        close(fd);
     218:	00005097          	auipc	ra,0x5
     21c:	6e4080e7          	jalr	1764(ra) # 58fc <close>
    for (i = 0; i < N; i++) {
     220:	2485                	addiw	s1,s1,1
     222:	0ff4f493          	zext.b	s1,s1
     226:	fd249fe3          	bne	s1,s2,204 <createtest+0x20>
    name[0] = 'a';
     22a:	06100793          	li	a5,97
     22e:	fcf40c23          	sb	a5,-40(s0)
    name[2] = '\0';
     232:	fc040d23          	sb	zero,-38(s0)
     236:	03000493          	li	s1,48
    for (i = 0; i < N; i++) {
     23a:	06400913          	li	s2,100
        name[1] = '0' + i;
     23e:	fc940ca3          	sb	s1,-39(s0)
        unlink(name);
     242:	fd840513          	addi	a0,s0,-40
     246:	00005097          	auipc	ra,0x5
     24a:	6de080e7          	jalr	1758(ra) # 5924 <unlink>
    for (i = 0; i < N; i++) {
     24e:	2485                	addiw	s1,s1,1
     250:	0ff4f493          	zext.b	s1,s1
     254:	ff2495e3          	bne	s1,s2,23e <createtest+0x5a>
}
     258:	70a2                	ld	ra,40(sp)
     25a:	7402                	ld	s0,32(sp)
     25c:	64e2                	ld	s1,24(sp)
     25e:	6942                	ld	s2,16(sp)
     260:	6145                	addi	sp,sp,48
     262:	8082                	ret

0000000000000264 <bigwrite>:
void bigwrite(char *s) {
     264:	715d                	addi	sp,sp,-80
     266:	e486                	sd	ra,72(sp)
     268:	e0a2                	sd	s0,64(sp)
     26a:	fc26                	sd	s1,56(sp)
     26c:	f84a                	sd	s2,48(sp)
     26e:	f44e                	sd	s3,40(sp)
     270:	f052                	sd	s4,32(sp)
     272:	ec56                	sd	s5,24(sp)
     274:	e85a                	sd	s6,16(sp)
     276:	e45e                	sd	s7,8(sp)
     278:	0880                	addi	s0,sp,80
     27a:	8baa                	mv	s7,a0
    unlink("bigwrite");
     27c:	00006517          	auipc	a0,0x6
     280:	c6450513          	addi	a0,a0,-924 # 5ee0 <malloc+0x1dc>
     284:	00005097          	auipc	ra,0x5
     288:	6a0080e7          	jalr	1696(ra) # 5924 <unlink>
    for (sz = 499; sz < (MAXOPBLOCKS + 2) * BSIZE; sz += 471) {
     28c:	1f300493          	li	s1,499
        fd = open("bigwrite", O_CREATE | O_RDWR);
     290:	00006a97          	auipc	s5,0x6
     294:	c50a8a93          	addi	s5,s5,-944 # 5ee0 <malloc+0x1dc>
            int cc = write(fd, buf, sz);
     298:	0000da17          	auipc	s4,0xd
     29c:	e48a0a13          	addi	s4,s4,-440 # d0e0 <buf>
    for (sz = 499; sz < (MAXOPBLOCKS + 2) * BSIZE; sz += 471) {
     2a0:	6b0d                	lui	s6,0x3
     2a2:	1c9b0b13          	addi	s6,s6,457 # 31c9 <dirtest+0x39>
        fd = open("bigwrite", O_CREATE | O_RDWR);
     2a6:	20200593          	li	a1,514
     2aa:	8556                	mv	a0,s5
     2ac:	00005097          	auipc	ra,0x5
     2b0:	668080e7          	jalr	1640(ra) # 5914 <open>
     2b4:	892a                	mv	s2,a0
        if (fd < 0) {
     2b6:	04054d63          	bltz	a0,310 <bigwrite+0xac>
            int cc = write(fd, buf, sz);
     2ba:	8626                	mv	a2,s1
     2bc:	85d2                	mv	a1,s4
     2be:	00005097          	auipc	ra,0x5
     2c2:	636080e7          	jalr	1590(ra) # 58f4 <write>
     2c6:	89aa                	mv	s3,a0
            if (cc != sz) {
     2c8:	06a49263          	bne	s1,a0,32c <bigwrite+0xc8>
            int cc = write(fd, buf, sz);
     2cc:	8626                	mv	a2,s1
     2ce:	85d2                	mv	a1,s4
     2d0:	854a                	mv	a0,s2
     2d2:	00005097          	auipc	ra,0x5
     2d6:	622080e7          	jalr	1570(ra) # 58f4 <write>
            if (cc != sz) {
     2da:	04951a63          	bne	a0,s1,32e <bigwrite+0xca>
        close(fd);
     2de:	854a                	mv	a0,s2
     2e0:	00005097          	auipc	ra,0x5
     2e4:	61c080e7          	jalr	1564(ra) # 58fc <close>
        unlink("bigwrite");
     2e8:	8556                	mv	a0,s5
     2ea:	00005097          	auipc	ra,0x5
     2ee:	63a080e7          	jalr	1594(ra) # 5924 <unlink>
    for (sz = 499; sz < (MAXOPBLOCKS + 2) * BSIZE; sz += 471) {
     2f2:	1d74849b          	addiw	s1,s1,471
     2f6:	fb6498e3          	bne	s1,s6,2a6 <bigwrite+0x42>
}
     2fa:	60a6                	ld	ra,72(sp)
     2fc:	6406                	ld	s0,64(sp)
     2fe:	74e2                	ld	s1,56(sp)
     300:	7942                	ld	s2,48(sp)
     302:	79a2                	ld	s3,40(sp)
     304:	7a02                	ld	s4,32(sp)
     306:	6ae2                	ld	s5,24(sp)
     308:	6b42                	ld	s6,16(sp)
     30a:	6ba2                	ld	s7,8(sp)
     30c:	6161                	addi	sp,sp,80
     30e:	8082                	ret
            printf("%s: cannot create bigwrite\n", s);
     310:	85de                	mv	a1,s7
     312:	00006517          	auipc	a0,0x6
     316:	bde50513          	addi	a0,a0,-1058 # 5ef0 <malloc+0x1ec>
     31a:	00006097          	auipc	ra,0x6
     31e:	932080e7          	jalr	-1742(ra) # 5c4c <printf>
            exit(1);
     322:	4505                	li	a0,1
     324:	00005097          	auipc	ra,0x5
     328:	5b0080e7          	jalr	1456(ra) # 58d4 <exit>
            if (cc != sz) {
     32c:	89a6                	mv	s3,s1
                printf("%s: write(%d) ret %d\n", s, sz, cc);
     32e:	86aa                	mv	a3,a0
     330:	864e                	mv	a2,s3
     332:	85de                	mv	a1,s7
     334:	00006517          	auipc	a0,0x6
     338:	bdc50513          	addi	a0,a0,-1060 # 5f10 <malloc+0x20c>
     33c:	00006097          	auipc	ra,0x6
     340:	910080e7          	jalr	-1776(ra) # 5c4c <printf>
                exit(1);
     344:	4505                	li	a0,1
     346:	00005097          	auipc	ra,0x5
     34a:	58e080e7          	jalr	1422(ra) # 58d4 <exit>

000000000000034e <copyin>:
void copyin(char *s) {
     34e:	715d                	addi	sp,sp,-80
     350:	e486                	sd	ra,72(sp)
     352:	e0a2                	sd	s0,64(sp)
     354:	fc26                	sd	s1,56(sp)
     356:	f84a                	sd	s2,48(sp)
     358:	f44e                	sd	s3,40(sp)
     35a:	f052                	sd	s4,32(sp)
     35c:	0880                	addi	s0,sp,80
    uint64 addrs[] = {0x80000000LL, 0xffffffffffffffff};
     35e:	4785                	li	a5,1
     360:	07fe                	slli	a5,a5,0x1f
     362:	fcf43023          	sd	a5,-64(s0)
     366:	57fd                	li	a5,-1
     368:	fcf43423          	sd	a5,-56(s0)
    for (int ai = 0; ai < 2; ai++) {
     36c:	fc040913          	addi	s2,s0,-64
        int fd = open("copyin1", O_CREATE | O_WRONLY);
     370:	00006a17          	auipc	s4,0x6
     374:	bb8a0a13          	addi	s4,s4,-1096 # 5f28 <malloc+0x224>
        uint64 addr = addrs[ai];
     378:	00093983          	ld	s3,0(s2)
        int fd = open("copyin1", O_CREATE | O_WRONLY);
     37c:	20100593          	li	a1,513
     380:	8552                	mv	a0,s4
     382:	00005097          	auipc	ra,0x5
     386:	592080e7          	jalr	1426(ra) # 5914 <open>
     38a:	84aa                	mv	s1,a0
        if (fd < 0) {
     38c:	08054863          	bltz	a0,41c <copyin+0xce>
        int n = write(fd, (void *)addr, 8192);
     390:	6609                	lui	a2,0x2
     392:	85ce                	mv	a1,s3
     394:	00005097          	auipc	ra,0x5
     398:	560080e7          	jalr	1376(ra) # 58f4 <write>
        if (n >= 0) {
     39c:	08055d63          	bgez	a0,436 <copyin+0xe8>
        close(fd);
     3a0:	8526                	mv	a0,s1
     3a2:	00005097          	auipc	ra,0x5
     3a6:	55a080e7          	jalr	1370(ra) # 58fc <close>
        unlink("copyin1");
     3aa:	8552                	mv	a0,s4
     3ac:	00005097          	auipc	ra,0x5
     3b0:	578080e7          	jalr	1400(ra) # 5924 <unlink>
        n = write(1, (char *)addr, 8192);
     3b4:	6609                	lui	a2,0x2
     3b6:	85ce                	mv	a1,s3
     3b8:	4505                	li	a0,1
     3ba:	00005097          	auipc	ra,0x5
     3be:	53a080e7          	jalr	1338(ra) # 58f4 <write>
        if (n > 0) {
     3c2:	08a04963          	bgtz	a0,454 <copyin+0x106>
        if (pipe(fds) < 0) {
     3c6:	fb840513          	addi	a0,s0,-72
     3ca:	00005097          	auipc	ra,0x5
     3ce:	51a080e7          	jalr	1306(ra) # 58e4 <pipe>
     3d2:	0a054063          	bltz	a0,472 <copyin+0x124>
        n = write(fds[1], (char *)addr, 8192);
     3d6:	6609                	lui	a2,0x2
     3d8:	85ce                	mv	a1,s3
     3da:	fbc42503          	lw	a0,-68(s0)
     3de:	00005097          	auipc	ra,0x5
     3e2:	516080e7          	jalr	1302(ra) # 58f4 <write>
        if (n > 0) {
     3e6:	0aa04363          	bgtz	a0,48c <copyin+0x13e>
        close(fds[0]);
     3ea:	fb842503          	lw	a0,-72(s0)
     3ee:	00005097          	auipc	ra,0x5
     3f2:	50e080e7          	jalr	1294(ra) # 58fc <close>
        close(fds[1]);
     3f6:	fbc42503          	lw	a0,-68(s0)
     3fa:	00005097          	auipc	ra,0x5
     3fe:	502080e7          	jalr	1282(ra) # 58fc <close>
    for (int ai = 0; ai < 2; ai++) {
     402:	0921                	addi	s2,s2,8
     404:	fd040793          	addi	a5,s0,-48
     408:	f6f918e3          	bne	s2,a5,378 <copyin+0x2a>
}
     40c:	60a6                	ld	ra,72(sp)
     40e:	6406                	ld	s0,64(sp)
     410:	74e2                	ld	s1,56(sp)
     412:	7942                	ld	s2,48(sp)
     414:	79a2                	ld	s3,40(sp)
     416:	7a02                	ld	s4,32(sp)
     418:	6161                	addi	sp,sp,80
     41a:	8082                	ret
            printf("open(copyin1) failed\n");
     41c:	00006517          	auipc	a0,0x6
     420:	b1450513          	addi	a0,a0,-1260 # 5f30 <malloc+0x22c>
     424:	00006097          	auipc	ra,0x6
     428:	828080e7          	jalr	-2008(ra) # 5c4c <printf>
            exit(1);
     42c:	4505                	li	a0,1
     42e:	00005097          	auipc	ra,0x5
     432:	4a6080e7          	jalr	1190(ra) # 58d4 <exit>
            printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
     436:	862a                	mv	a2,a0
     438:	85ce                	mv	a1,s3
     43a:	00006517          	auipc	a0,0x6
     43e:	b0e50513          	addi	a0,a0,-1266 # 5f48 <malloc+0x244>
     442:	00006097          	auipc	ra,0x6
     446:	80a080e7          	jalr	-2038(ra) # 5c4c <printf>
            exit(1);
     44a:	4505                	li	a0,1
     44c:	00005097          	auipc	ra,0x5
     450:	488080e7          	jalr	1160(ra) # 58d4 <exit>
            printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     454:	862a                	mv	a2,a0
     456:	85ce                	mv	a1,s3
     458:	00006517          	auipc	a0,0x6
     45c:	b2050513          	addi	a0,a0,-1248 # 5f78 <malloc+0x274>
     460:	00005097          	auipc	ra,0x5
     464:	7ec080e7          	jalr	2028(ra) # 5c4c <printf>
            exit(1);
     468:	4505                	li	a0,1
     46a:	00005097          	auipc	ra,0x5
     46e:	46a080e7          	jalr	1130(ra) # 58d4 <exit>
            printf("pipe() failed\n");
     472:	00006517          	auipc	a0,0x6
     476:	b3650513          	addi	a0,a0,-1226 # 5fa8 <malloc+0x2a4>
     47a:	00005097          	auipc	ra,0x5
     47e:	7d2080e7          	jalr	2002(ra) # 5c4c <printf>
            exit(1);
     482:	4505                	li	a0,1
     484:	00005097          	auipc	ra,0x5
     488:	450080e7          	jalr	1104(ra) # 58d4 <exit>
            printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     48c:	862a                	mv	a2,a0
     48e:	85ce                	mv	a1,s3
     490:	00006517          	auipc	a0,0x6
     494:	b2850513          	addi	a0,a0,-1240 # 5fb8 <malloc+0x2b4>
     498:	00005097          	auipc	ra,0x5
     49c:	7b4080e7          	jalr	1972(ra) # 5c4c <printf>
            exit(1);
     4a0:	4505                	li	a0,1
     4a2:	00005097          	auipc	ra,0x5
     4a6:	432080e7          	jalr	1074(ra) # 58d4 <exit>

00000000000004aa <copyout>:
void copyout(char *s) {
     4aa:	711d                	addi	sp,sp,-96
     4ac:	ec86                	sd	ra,88(sp)
     4ae:	e8a2                	sd	s0,80(sp)
     4b0:	e4a6                	sd	s1,72(sp)
     4b2:	e0ca                	sd	s2,64(sp)
     4b4:	fc4e                	sd	s3,56(sp)
     4b6:	f852                	sd	s4,48(sp)
     4b8:	f456                	sd	s5,40(sp)
     4ba:	1080                	addi	s0,sp,96
    uint64 addrs[] = {0x80000000LL, 0xffffffffffffffff};
     4bc:	4785                	li	a5,1
     4be:	07fe                	slli	a5,a5,0x1f
     4c0:	faf43823          	sd	a5,-80(s0)
     4c4:	57fd                	li	a5,-1
     4c6:	faf43c23          	sd	a5,-72(s0)
    for (int ai = 0; ai < 2; ai++) {
     4ca:	fb040913          	addi	s2,s0,-80
        int fd = open("README", 0);
     4ce:	00006a17          	auipc	s4,0x6
     4d2:	b1aa0a13          	addi	s4,s4,-1254 # 5fe8 <malloc+0x2e4>
        n = write(fds[1], "x", 1);
     4d6:	00006a97          	auipc	s5,0x6
     4da:	9daa8a93          	addi	s5,s5,-1574 # 5eb0 <malloc+0x1ac>
        uint64 addr = addrs[ai];
     4de:	00093983          	ld	s3,0(s2)
        int fd = open("README", 0);
     4e2:	4581                	li	a1,0
     4e4:	8552                	mv	a0,s4
     4e6:	00005097          	auipc	ra,0x5
     4ea:	42e080e7          	jalr	1070(ra) # 5914 <open>
     4ee:	84aa                	mv	s1,a0
        if (fd < 0) {
     4f0:	08054663          	bltz	a0,57c <copyout+0xd2>
        int n = read(fd, (void *)addr, 8192);
     4f4:	6609                	lui	a2,0x2
     4f6:	85ce                	mv	a1,s3
     4f8:	00005097          	auipc	ra,0x5
     4fc:	3f4080e7          	jalr	1012(ra) # 58ec <read>
        if (n > 0) {
     500:	08a04b63          	bgtz	a0,596 <copyout+0xec>
        close(fd);
     504:	8526                	mv	a0,s1
     506:	00005097          	auipc	ra,0x5
     50a:	3f6080e7          	jalr	1014(ra) # 58fc <close>
        if (pipe(fds) < 0) {
     50e:	fa840513          	addi	a0,s0,-88
     512:	00005097          	auipc	ra,0x5
     516:	3d2080e7          	jalr	978(ra) # 58e4 <pipe>
     51a:	08054d63          	bltz	a0,5b4 <copyout+0x10a>
        n = write(fds[1], "x", 1);
     51e:	4605                	li	a2,1
     520:	85d6                	mv	a1,s5
     522:	fac42503          	lw	a0,-84(s0)
     526:	00005097          	auipc	ra,0x5
     52a:	3ce080e7          	jalr	974(ra) # 58f4 <write>
        if (n != 1) {
     52e:	4785                	li	a5,1
     530:	08f51f63          	bne	a0,a5,5ce <copyout+0x124>
        n = read(fds[0], (void *)addr, 8192);
     534:	6609                	lui	a2,0x2
     536:	85ce                	mv	a1,s3
     538:	fa842503          	lw	a0,-88(s0)
     53c:	00005097          	auipc	ra,0x5
     540:	3b0080e7          	jalr	944(ra) # 58ec <read>
        if (n > 0) {
     544:	0aa04263          	bgtz	a0,5e8 <copyout+0x13e>
        close(fds[0]);
     548:	fa842503          	lw	a0,-88(s0)
     54c:	00005097          	auipc	ra,0x5
     550:	3b0080e7          	jalr	944(ra) # 58fc <close>
        close(fds[1]);
     554:	fac42503          	lw	a0,-84(s0)
     558:	00005097          	auipc	ra,0x5
     55c:	3a4080e7          	jalr	932(ra) # 58fc <close>
    for (int ai = 0; ai < 2; ai++) {
     560:	0921                	addi	s2,s2,8
     562:	fc040793          	addi	a5,s0,-64
     566:	f6f91ce3          	bne	s2,a5,4de <copyout+0x34>
}
     56a:	60e6                	ld	ra,88(sp)
     56c:	6446                	ld	s0,80(sp)
     56e:	64a6                	ld	s1,72(sp)
     570:	6906                	ld	s2,64(sp)
     572:	79e2                	ld	s3,56(sp)
     574:	7a42                	ld	s4,48(sp)
     576:	7aa2                	ld	s5,40(sp)
     578:	6125                	addi	sp,sp,96
     57a:	8082                	ret
            printf("open(README) failed\n");
     57c:	00006517          	auipc	a0,0x6
     580:	a7450513          	addi	a0,a0,-1420 # 5ff0 <malloc+0x2ec>
     584:	00005097          	auipc	ra,0x5
     588:	6c8080e7          	jalr	1736(ra) # 5c4c <printf>
            exit(1);
     58c:	4505                	li	a0,1
     58e:	00005097          	auipc	ra,0x5
     592:	346080e7          	jalr	838(ra) # 58d4 <exit>
            printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     596:	862a                	mv	a2,a0
     598:	85ce                	mv	a1,s3
     59a:	00006517          	auipc	a0,0x6
     59e:	a6e50513          	addi	a0,a0,-1426 # 6008 <malloc+0x304>
     5a2:	00005097          	auipc	ra,0x5
     5a6:	6aa080e7          	jalr	1706(ra) # 5c4c <printf>
            exit(1);
     5aa:	4505                	li	a0,1
     5ac:	00005097          	auipc	ra,0x5
     5b0:	328080e7          	jalr	808(ra) # 58d4 <exit>
            printf("pipe() failed\n");
     5b4:	00006517          	auipc	a0,0x6
     5b8:	9f450513          	addi	a0,a0,-1548 # 5fa8 <malloc+0x2a4>
     5bc:	00005097          	auipc	ra,0x5
     5c0:	690080e7          	jalr	1680(ra) # 5c4c <printf>
            exit(1);
     5c4:	4505                	li	a0,1
     5c6:	00005097          	auipc	ra,0x5
     5ca:	30e080e7          	jalr	782(ra) # 58d4 <exit>
            printf("pipe write failed\n");
     5ce:	00006517          	auipc	a0,0x6
     5d2:	a6a50513          	addi	a0,a0,-1430 # 6038 <malloc+0x334>
     5d6:	00005097          	auipc	ra,0x5
     5da:	676080e7          	jalr	1654(ra) # 5c4c <printf>
            exit(1);
     5de:	4505                	li	a0,1
     5e0:	00005097          	auipc	ra,0x5
     5e4:	2f4080e7          	jalr	756(ra) # 58d4 <exit>
            printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     5e8:	862a                	mv	a2,a0
     5ea:	85ce                	mv	a1,s3
     5ec:	00006517          	auipc	a0,0x6
     5f0:	a6450513          	addi	a0,a0,-1436 # 6050 <malloc+0x34c>
     5f4:	00005097          	auipc	ra,0x5
     5f8:	658080e7          	jalr	1624(ra) # 5c4c <printf>
            exit(1);
     5fc:	4505                	li	a0,1
     5fe:	00005097          	auipc	ra,0x5
     602:	2d6080e7          	jalr	726(ra) # 58d4 <exit>

0000000000000606 <truncate1>:
void truncate1(char *s) {
     606:	711d                	addi	sp,sp,-96
     608:	ec86                	sd	ra,88(sp)
     60a:	e8a2                	sd	s0,80(sp)
     60c:	e4a6                	sd	s1,72(sp)
     60e:	e0ca                	sd	s2,64(sp)
     610:	fc4e                	sd	s3,56(sp)
     612:	f852                	sd	s4,48(sp)
     614:	f456                	sd	s5,40(sp)
     616:	1080                	addi	s0,sp,96
     618:	8aaa                	mv	s5,a0
    unlink("truncfile");
     61a:	00006517          	auipc	a0,0x6
     61e:	87e50513          	addi	a0,a0,-1922 # 5e98 <malloc+0x194>
     622:	00005097          	auipc	ra,0x5
     626:	302080e7          	jalr	770(ra) # 5924 <unlink>
    int fd1 = open("truncfile", O_CREATE | O_WRONLY | O_TRUNC);
     62a:	60100593          	li	a1,1537
     62e:	00006517          	auipc	a0,0x6
     632:	86a50513          	addi	a0,a0,-1942 # 5e98 <malloc+0x194>
     636:	00005097          	auipc	ra,0x5
     63a:	2de080e7          	jalr	734(ra) # 5914 <open>
     63e:	84aa                	mv	s1,a0
    write(fd1, "abcd", 4);
     640:	4611                	li	a2,4
     642:	00006597          	auipc	a1,0x6
     646:	86658593          	addi	a1,a1,-1946 # 5ea8 <malloc+0x1a4>
     64a:	00005097          	auipc	ra,0x5
     64e:	2aa080e7          	jalr	682(ra) # 58f4 <write>
    close(fd1);
     652:	8526                	mv	a0,s1
     654:	00005097          	auipc	ra,0x5
     658:	2a8080e7          	jalr	680(ra) # 58fc <close>
    int fd2 = open("truncfile", O_RDONLY);
     65c:	4581                	li	a1,0
     65e:	00006517          	auipc	a0,0x6
     662:	83a50513          	addi	a0,a0,-1990 # 5e98 <malloc+0x194>
     666:	00005097          	auipc	ra,0x5
     66a:	2ae080e7          	jalr	686(ra) # 5914 <open>
     66e:	84aa                	mv	s1,a0
    int n = read(fd2, buf, sizeof(buf));
     670:	02000613          	li	a2,32
     674:	fa040593          	addi	a1,s0,-96
     678:	00005097          	auipc	ra,0x5
     67c:	274080e7          	jalr	628(ra) # 58ec <read>
    if (n != 4) {
     680:	4791                	li	a5,4
     682:	0cf51e63          	bne	a0,a5,75e <truncate1+0x158>
    fd1 = open("truncfile", O_WRONLY | O_TRUNC);
     686:	40100593          	li	a1,1025
     68a:	00006517          	auipc	a0,0x6
     68e:	80e50513          	addi	a0,a0,-2034 # 5e98 <malloc+0x194>
     692:	00005097          	auipc	ra,0x5
     696:	282080e7          	jalr	642(ra) # 5914 <open>
     69a:	89aa                	mv	s3,a0
    int fd3 = open("truncfile", O_RDONLY);
     69c:	4581                	li	a1,0
     69e:	00005517          	auipc	a0,0x5
     6a2:	7fa50513          	addi	a0,a0,2042 # 5e98 <malloc+0x194>
     6a6:	00005097          	auipc	ra,0x5
     6aa:	26e080e7          	jalr	622(ra) # 5914 <open>
     6ae:	892a                	mv	s2,a0
    n = read(fd3, buf, sizeof(buf));
     6b0:	02000613          	li	a2,32
     6b4:	fa040593          	addi	a1,s0,-96
     6b8:	00005097          	auipc	ra,0x5
     6bc:	234080e7          	jalr	564(ra) # 58ec <read>
     6c0:	8a2a                	mv	s4,a0
    if (n != 0) {
     6c2:	ed4d                	bnez	a0,77c <truncate1+0x176>
    n = read(fd2, buf, sizeof(buf));
     6c4:	02000613          	li	a2,32
     6c8:	fa040593          	addi	a1,s0,-96
     6cc:	8526                	mv	a0,s1
     6ce:	00005097          	auipc	ra,0x5
     6d2:	21e080e7          	jalr	542(ra) # 58ec <read>
     6d6:	8a2a                	mv	s4,a0
    if (n != 0) {
     6d8:	e971                	bnez	a0,7ac <truncate1+0x1a6>
    write(fd1, "abcdef", 6);
     6da:	4619                	li	a2,6
     6dc:	00006597          	auipc	a1,0x6
     6e0:	a0458593          	addi	a1,a1,-1532 # 60e0 <malloc+0x3dc>
     6e4:	854e                	mv	a0,s3
     6e6:	00005097          	auipc	ra,0x5
     6ea:	20e080e7          	jalr	526(ra) # 58f4 <write>
    n = read(fd3, buf, sizeof(buf));
     6ee:	02000613          	li	a2,32
     6f2:	fa040593          	addi	a1,s0,-96
     6f6:	854a                	mv	a0,s2
     6f8:	00005097          	auipc	ra,0x5
     6fc:	1f4080e7          	jalr	500(ra) # 58ec <read>
    if (n != 6) {
     700:	4799                	li	a5,6
     702:	0cf51d63          	bne	a0,a5,7dc <truncate1+0x1d6>
    n = read(fd2, buf, sizeof(buf));
     706:	02000613          	li	a2,32
     70a:	fa040593          	addi	a1,s0,-96
     70e:	8526                	mv	a0,s1
     710:	00005097          	auipc	ra,0x5
     714:	1dc080e7          	jalr	476(ra) # 58ec <read>
    if (n != 2) {
     718:	4789                	li	a5,2
     71a:	0ef51063          	bne	a0,a5,7fa <truncate1+0x1f4>
    unlink("truncfile");
     71e:	00005517          	auipc	a0,0x5
     722:	77a50513          	addi	a0,a0,1914 # 5e98 <malloc+0x194>
     726:	00005097          	auipc	ra,0x5
     72a:	1fe080e7          	jalr	510(ra) # 5924 <unlink>
    close(fd1);
     72e:	854e                	mv	a0,s3
     730:	00005097          	auipc	ra,0x5
     734:	1cc080e7          	jalr	460(ra) # 58fc <close>
    close(fd2);
     738:	8526                	mv	a0,s1
     73a:	00005097          	auipc	ra,0x5
     73e:	1c2080e7          	jalr	450(ra) # 58fc <close>
    close(fd3);
     742:	854a                	mv	a0,s2
     744:	00005097          	auipc	ra,0x5
     748:	1b8080e7          	jalr	440(ra) # 58fc <close>
}
     74c:	60e6                	ld	ra,88(sp)
     74e:	6446                	ld	s0,80(sp)
     750:	64a6                	ld	s1,72(sp)
     752:	6906                	ld	s2,64(sp)
     754:	79e2                	ld	s3,56(sp)
     756:	7a42                	ld	s4,48(sp)
     758:	7aa2                	ld	s5,40(sp)
     75a:	6125                	addi	sp,sp,96
     75c:	8082                	ret
        printf("%s: read %d bytes, wanted 4\n", s, n);
     75e:	862a                	mv	a2,a0
     760:	85d6                	mv	a1,s5
     762:	00006517          	auipc	a0,0x6
     766:	91e50513          	addi	a0,a0,-1762 # 6080 <malloc+0x37c>
     76a:	00005097          	auipc	ra,0x5
     76e:	4e2080e7          	jalr	1250(ra) # 5c4c <printf>
        exit(1);
     772:	4505                	li	a0,1
     774:	00005097          	auipc	ra,0x5
     778:	160080e7          	jalr	352(ra) # 58d4 <exit>
        printf("aaa fd3=%d\n", fd3);
     77c:	85ca                	mv	a1,s2
     77e:	00006517          	auipc	a0,0x6
     782:	92250513          	addi	a0,a0,-1758 # 60a0 <malloc+0x39c>
     786:	00005097          	auipc	ra,0x5
     78a:	4c6080e7          	jalr	1222(ra) # 5c4c <printf>
        printf("%s: read %d bytes, wanted 0\n", s, n);
     78e:	8652                	mv	a2,s4
     790:	85d6                	mv	a1,s5
     792:	00006517          	auipc	a0,0x6
     796:	91e50513          	addi	a0,a0,-1762 # 60b0 <malloc+0x3ac>
     79a:	00005097          	auipc	ra,0x5
     79e:	4b2080e7          	jalr	1202(ra) # 5c4c <printf>
        exit(1);
     7a2:	4505                	li	a0,1
     7a4:	00005097          	auipc	ra,0x5
     7a8:	130080e7          	jalr	304(ra) # 58d4 <exit>
        printf("bbb fd2=%d\n", fd2);
     7ac:	85a6                	mv	a1,s1
     7ae:	00006517          	auipc	a0,0x6
     7b2:	92250513          	addi	a0,a0,-1758 # 60d0 <malloc+0x3cc>
     7b6:	00005097          	auipc	ra,0x5
     7ba:	496080e7          	jalr	1174(ra) # 5c4c <printf>
        printf("%s: read %d bytes, wanted 0\n", s, n);
     7be:	8652                	mv	a2,s4
     7c0:	85d6                	mv	a1,s5
     7c2:	00006517          	auipc	a0,0x6
     7c6:	8ee50513          	addi	a0,a0,-1810 # 60b0 <malloc+0x3ac>
     7ca:	00005097          	auipc	ra,0x5
     7ce:	482080e7          	jalr	1154(ra) # 5c4c <printf>
        exit(1);
     7d2:	4505                	li	a0,1
     7d4:	00005097          	auipc	ra,0x5
     7d8:	100080e7          	jalr	256(ra) # 58d4 <exit>
        printf("%s: read %d bytes, wanted 6\n", s, n);
     7dc:	862a                	mv	a2,a0
     7de:	85d6                	mv	a1,s5
     7e0:	00006517          	auipc	a0,0x6
     7e4:	90850513          	addi	a0,a0,-1784 # 60e8 <malloc+0x3e4>
     7e8:	00005097          	auipc	ra,0x5
     7ec:	464080e7          	jalr	1124(ra) # 5c4c <printf>
        exit(1);
     7f0:	4505                	li	a0,1
     7f2:	00005097          	auipc	ra,0x5
     7f6:	0e2080e7          	jalr	226(ra) # 58d4 <exit>
        printf("%s: read %d bytes, wanted 2\n", s, n);
     7fa:	862a                	mv	a2,a0
     7fc:	85d6                	mv	a1,s5
     7fe:	00006517          	auipc	a0,0x6
     802:	90a50513          	addi	a0,a0,-1782 # 6108 <malloc+0x404>
     806:	00005097          	auipc	ra,0x5
     80a:	446080e7          	jalr	1094(ra) # 5c4c <printf>
        exit(1);
     80e:	4505                	li	a0,1
     810:	00005097          	auipc	ra,0x5
     814:	0c4080e7          	jalr	196(ra) # 58d4 <exit>

0000000000000818 <writetest>:
void writetest(char *s) {
     818:	7139                	addi	sp,sp,-64
     81a:	fc06                	sd	ra,56(sp)
     81c:	f822                	sd	s0,48(sp)
     81e:	f426                	sd	s1,40(sp)
     820:	f04a                	sd	s2,32(sp)
     822:	ec4e                	sd	s3,24(sp)
     824:	e852                	sd	s4,16(sp)
     826:	e456                	sd	s5,8(sp)
     828:	e05a                	sd	s6,0(sp)
     82a:	0080                	addi	s0,sp,64
     82c:	8b2a                	mv	s6,a0
    fd = open("small", O_CREATE | O_RDWR);
     82e:	20200593          	li	a1,514
     832:	00006517          	auipc	a0,0x6
     836:	8f650513          	addi	a0,a0,-1802 # 6128 <malloc+0x424>
     83a:	00005097          	auipc	ra,0x5
     83e:	0da080e7          	jalr	218(ra) # 5914 <open>
    if (fd < 0) {
     842:	0a054d63          	bltz	a0,8fc <writetest+0xe4>
     846:	892a                	mv	s2,a0
     848:	4481                	li	s1,0
        if (write(fd, "aaaaaaaaaa", SZ) != SZ) {
     84a:	00006997          	auipc	s3,0x6
     84e:	90698993          	addi	s3,s3,-1786 # 6150 <malloc+0x44c>
        if (write(fd, "bbbbbbbbbb", SZ) != SZ) {
     852:	00006a97          	auipc	s5,0x6
     856:	936a8a93          	addi	s5,s5,-1738 # 6188 <malloc+0x484>
    for (i = 0; i < N; i++) {
     85a:	06400a13          	li	s4,100
        if (write(fd, "aaaaaaaaaa", SZ) != SZ) {
     85e:	4629                	li	a2,10
     860:	85ce                	mv	a1,s3
     862:	854a                	mv	a0,s2
     864:	00005097          	auipc	ra,0x5
     868:	090080e7          	jalr	144(ra) # 58f4 <write>
     86c:	47a9                	li	a5,10
     86e:	0af51563          	bne	a0,a5,918 <writetest+0x100>
        if (write(fd, "bbbbbbbbbb", SZ) != SZ) {
     872:	4629                	li	a2,10
     874:	85d6                	mv	a1,s5
     876:	854a                	mv	a0,s2
     878:	00005097          	auipc	ra,0x5
     87c:	07c080e7          	jalr	124(ra) # 58f4 <write>
     880:	47a9                	li	a5,10
     882:	0af51a63          	bne	a0,a5,936 <writetest+0x11e>
    for (i = 0; i < N; i++) {
     886:	2485                	addiw	s1,s1,1
     888:	fd449be3          	bne	s1,s4,85e <writetest+0x46>
    close(fd);
     88c:	854a                	mv	a0,s2
     88e:	00005097          	auipc	ra,0x5
     892:	06e080e7          	jalr	110(ra) # 58fc <close>
    fd = open("small", O_RDONLY);
     896:	4581                	li	a1,0
     898:	00006517          	auipc	a0,0x6
     89c:	89050513          	addi	a0,a0,-1904 # 6128 <malloc+0x424>
     8a0:	00005097          	auipc	ra,0x5
     8a4:	074080e7          	jalr	116(ra) # 5914 <open>
     8a8:	84aa                	mv	s1,a0
    if (fd < 0) {
     8aa:	0a054563          	bltz	a0,954 <writetest+0x13c>
    i = read(fd, buf, N * SZ * 2);
     8ae:	7d000613          	li	a2,2000
     8b2:	0000d597          	auipc	a1,0xd
     8b6:	82e58593          	addi	a1,a1,-2002 # d0e0 <buf>
     8ba:	00005097          	auipc	ra,0x5
     8be:	032080e7          	jalr	50(ra) # 58ec <read>
    if (i != N * SZ * 2) {
     8c2:	7d000793          	li	a5,2000
     8c6:	0af51563          	bne	a0,a5,970 <writetest+0x158>
    close(fd);
     8ca:	8526                	mv	a0,s1
     8cc:	00005097          	auipc	ra,0x5
     8d0:	030080e7          	jalr	48(ra) # 58fc <close>
    if (unlink("small") < 0) {
     8d4:	00006517          	auipc	a0,0x6
     8d8:	85450513          	addi	a0,a0,-1964 # 6128 <malloc+0x424>
     8dc:	00005097          	auipc	ra,0x5
     8e0:	048080e7          	jalr	72(ra) # 5924 <unlink>
     8e4:	0a054463          	bltz	a0,98c <writetest+0x174>
}
     8e8:	70e2                	ld	ra,56(sp)
     8ea:	7442                	ld	s0,48(sp)
     8ec:	74a2                	ld	s1,40(sp)
     8ee:	7902                	ld	s2,32(sp)
     8f0:	69e2                	ld	s3,24(sp)
     8f2:	6a42                	ld	s4,16(sp)
     8f4:	6aa2                	ld	s5,8(sp)
     8f6:	6b02                	ld	s6,0(sp)
     8f8:	6121                	addi	sp,sp,64
     8fa:	8082                	ret
        printf("%s: error: creat small failed!\n", s);
     8fc:	85da                	mv	a1,s6
     8fe:	00006517          	auipc	a0,0x6
     902:	83250513          	addi	a0,a0,-1998 # 6130 <malloc+0x42c>
     906:	00005097          	auipc	ra,0x5
     90a:	346080e7          	jalr	838(ra) # 5c4c <printf>
        exit(1);
     90e:	4505                	li	a0,1
     910:	00005097          	auipc	ra,0x5
     914:	fc4080e7          	jalr	-60(ra) # 58d4 <exit>
            printf("%s: error: write aa %d new file failed\n", s, i);
     918:	8626                	mv	a2,s1
     91a:	85da                	mv	a1,s6
     91c:	00006517          	auipc	a0,0x6
     920:	84450513          	addi	a0,a0,-1980 # 6160 <malloc+0x45c>
     924:	00005097          	auipc	ra,0x5
     928:	328080e7          	jalr	808(ra) # 5c4c <printf>
            exit(1);
     92c:	4505                	li	a0,1
     92e:	00005097          	auipc	ra,0x5
     932:	fa6080e7          	jalr	-90(ra) # 58d4 <exit>
            printf("%s: error: write bb %d new file failed\n", s, i);
     936:	8626                	mv	a2,s1
     938:	85da                	mv	a1,s6
     93a:	00006517          	auipc	a0,0x6
     93e:	85e50513          	addi	a0,a0,-1954 # 6198 <malloc+0x494>
     942:	00005097          	auipc	ra,0x5
     946:	30a080e7          	jalr	778(ra) # 5c4c <printf>
            exit(1);
     94a:	4505                	li	a0,1
     94c:	00005097          	auipc	ra,0x5
     950:	f88080e7          	jalr	-120(ra) # 58d4 <exit>
        printf("%s: error: open small failed!\n", s);
     954:	85da                	mv	a1,s6
     956:	00006517          	auipc	a0,0x6
     95a:	86a50513          	addi	a0,a0,-1942 # 61c0 <malloc+0x4bc>
     95e:	00005097          	auipc	ra,0x5
     962:	2ee080e7          	jalr	750(ra) # 5c4c <printf>
        exit(1);
     966:	4505                	li	a0,1
     968:	00005097          	auipc	ra,0x5
     96c:	f6c080e7          	jalr	-148(ra) # 58d4 <exit>
        printf("%s: read failed\n", s);
     970:	85da                	mv	a1,s6
     972:	00006517          	auipc	a0,0x6
     976:	86e50513          	addi	a0,a0,-1938 # 61e0 <malloc+0x4dc>
     97a:	00005097          	auipc	ra,0x5
     97e:	2d2080e7          	jalr	722(ra) # 5c4c <printf>
        exit(1);
     982:	4505                	li	a0,1
     984:	00005097          	auipc	ra,0x5
     988:	f50080e7          	jalr	-176(ra) # 58d4 <exit>
        printf("%s: unlink small failed\n", s);
     98c:	85da                	mv	a1,s6
     98e:	00006517          	auipc	a0,0x6
     992:	86a50513          	addi	a0,a0,-1942 # 61f8 <malloc+0x4f4>
     996:	00005097          	auipc	ra,0x5
     99a:	2b6080e7          	jalr	694(ra) # 5c4c <printf>
        exit(1);
     99e:	4505                	li	a0,1
     9a0:	00005097          	auipc	ra,0x5
     9a4:	f34080e7          	jalr	-204(ra) # 58d4 <exit>

00000000000009a8 <writebig>:
void writebig(char *s) {
     9a8:	7139                	addi	sp,sp,-64
     9aa:	fc06                	sd	ra,56(sp)
     9ac:	f822                	sd	s0,48(sp)
     9ae:	f426                	sd	s1,40(sp)
     9b0:	f04a                	sd	s2,32(sp)
     9b2:	ec4e                	sd	s3,24(sp)
     9b4:	e852                	sd	s4,16(sp)
     9b6:	e456                	sd	s5,8(sp)
     9b8:	0080                	addi	s0,sp,64
     9ba:	8aaa                	mv	s5,a0
    fd = open("big", O_CREATE | O_RDWR);
     9bc:	20200593          	li	a1,514
     9c0:	00006517          	auipc	a0,0x6
     9c4:	85850513          	addi	a0,a0,-1960 # 6218 <malloc+0x514>
     9c8:	00005097          	auipc	ra,0x5
     9cc:	f4c080e7          	jalr	-180(ra) # 5914 <open>
     9d0:	89aa                	mv	s3,a0
    for (i = 0; i < MAXFILE; i++) {
     9d2:	4481                	li	s1,0
        ((int *)buf)[0] = i;
     9d4:	0000c917          	auipc	s2,0xc
     9d8:	70c90913          	addi	s2,s2,1804 # d0e0 <buf>
    for (i = 0; i < MAXFILE; i++) {
     9dc:	10c00a13          	li	s4,268
    if (fd < 0) {
     9e0:	06054c63          	bltz	a0,a58 <writebig+0xb0>
        ((int *)buf)[0] = i;
     9e4:	00992023          	sw	s1,0(s2)
        if (write(fd, buf, BSIZE) != BSIZE) {
     9e8:	40000613          	li	a2,1024
     9ec:	85ca                	mv	a1,s2
     9ee:	854e                	mv	a0,s3
     9f0:	00005097          	auipc	ra,0x5
     9f4:	f04080e7          	jalr	-252(ra) # 58f4 <write>
     9f8:	40000793          	li	a5,1024
     9fc:	06f51c63          	bne	a0,a5,a74 <writebig+0xcc>
    for (i = 0; i < MAXFILE; i++) {
     a00:	2485                	addiw	s1,s1,1
     a02:	ff4491e3          	bne	s1,s4,9e4 <writebig+0x3c>
    close(fd);
     a06:	854e                	mv	a0,s3
     a08:	00005097          	auipc	ra,0x5
     a0c:	ef4080e7          	jalr	-268(ra) # 58fc <close>
    fd = open("big", O_RDONLY);
     a10:	4581                	li	a1,0
     a12:	00006517          	auipc	a0,0x6
     a16:	80650513          	addi	a0,a0,-2042 # 6218 <malloc+0x514>
     a1a:	00005097          	auipc	ra,0x5
     a1e:	efa080e7          	jalr	-262(ra) # 5914 <open>
     a22:	89aa                	mv	s3,a0
    n = 0;
     a24:	4481                	li	s1,0
        i = read(fd, buf, BSIZE);
     a26:	0000c917          	auipc	s2,0xc
     a2a:	6ba90913          	addi	s2,s2,1722 # d0e0 <buf>
    if (fd < 0) {
     a2e:	06054263          	bltz	a0,a92 <writebig+0xea>
        i = read(fd, buf, BSIZE);
     a32:	40000613          	li	a2,1024
     a36:	85ca                	mv	a1,s2
     a38:	854e                	mv	a0,s3
     a3a:	00005097          	auipc	ra,0x5
     a3e:	eb2080e7          	jalr	-334(ra) # 58ec <read>
        if (i == 0) {
     a42:	c535                	beqz	a0,aae <writebig+0x106>
        } else if (i != BSIZE) {
     a44:	40000793          	li	a5,1024
     a48:	0af51f63          	bne	a0,a5,b06 <writebig+0x15e>
        if (((int *)buf)[0] != n) {
     a4c:	00092683          	lw	a3,0(s2)
     a50:	0c969a63          	bne	a3,s1,b24 <writebig+0x17c>
        n++;
     a54:	2485                	addiw	s1,s1,1
        i = read(fd, buf, BSIZE);
     a56:	bff1                	j	a32 <writebig+0x8a>
        printf("%s: error: creat big failed!\n", s);
     a58:	85d6                	mv	a1,s5
     a5a:	00005517          	auipc	a0,0x5
     a5e:	7c650513          	addi	a0,a0,1990 # 6220 <malloc+0x51c>
     a62:	00005097          	auipc	ra,0x5
     a66:	1ea080e7          	jalr	490(ra) # 5c4c <printf>
        exit(1);
     a6a:	4505                	li	a0,1
     a6c:	00005097          	auipc	ra,0x5
     a70:	e68080e7          	jalr	-408(ra) # 58d4 <exit>
            printf("%s: error: write big file failed\n", s, i);
     a74:	8626                	mv	a2,s1
     a76:	85d6                	mv	a1,s5
     a78:	00005517          	auipc	a0,0x5
     a7c:	7c850513          	addi	a0,a0,1992 # 6240 <malloc+0x53c>
     a80:	00005097          	auipc	ra,0x5
     a84:	1cc080e7          	jalr	460(ra) # 5c4c <printf>
            exit(1);
     a88:	4505                	li	a0,1
     a8a:	00005097          	auipc	ra,0x5
     a8e:	e4a080e7          	jalr	-438(ra) # 58d4 <exit>
        printf("%s: error: open big failed!\n", s);
     a92:	85d6                	mv	a1,s5
     a94:	00005517          	auipc	a0,0x5
     a98:	7d450513          	addi	a0,a0,2004 # 6268 <malloc+0x564>
     a9c:	00005097          	auipc	ra,0x5
     aa0:	1b0080e7          	jalr	432(ra) # 5c4c <printf>
        exit(1);
     aa4:	4505                	li	a0,1
     aa6:	00005097          	auipc	ra,0x5
     aaa:	e2e080e7          	jalr	-466(ra) # 58d4 <exit>
            if (n == MAXFILE - 1) {
     aae:	10b00793          	li	a5,267
     ab2:	02f48a63          	beq	s1,a5,ae6 <writebig+0x13e>
    close(fd);
     ab6:	854e                	mv	a0,s3
     ab8:	00005097          	auipc	ra,0x5
     abc:	e44080e7          	jalr	-444(ra) # 58fc <close>
    if (unlink("big") < 0) {
     ac0:	00005517          	auipc	a0,0x5
     ac4:	75850513          	addi	a0,a0,1880 # 6218 <malloc+0x514>
     ac8:	00005097          	auipc	ra,0x5
     acc:	e5c080e7          	jalr	-420(ra) # 5924 <unlink>
     ad0:	06054963          	bltz	a0,b42 <writebig+0x19a>
}
     ad4:	70e2                	ld	ra,56(sp)
     ad6:	7442                	ld	s0,48(sp)
     ad8:	74a2                	ld	s1,40(sp)
     ada:	7902                	ld	s2,32(sp)
     adc:	69e2                	ld	s3,24(sp)
     ade:	6a42                	ld	s4,16(sp)
     ae0:	6aa2                	ld	s5,8(sp)
     ae2:	6121                	addi	sp,sp,64
     ae4:	8082                	ret
                printf("%s: read only %d blocks from big", s, n);
     ae6:	10b00613          	li	a2,267
     aea:	85d6                	mv	a1,s5
     aec:	00005517          	auipc	a0,0x5
     af0:	79c50513          	addi	a0,a0,1948 # 6288 <malloc+0x584>
     af4:	00005097          	auipc	ra,0x5
     af8:	158080e7          	jalr	344(ra) # 5c4c <printf>
                exit(1);
     afc:	4505                	li	a0,1
     afe:	00005097          	auipc	ra,0x5
     b02:	dd6080e7          	jalr	-554(ra) # 58d4 <exit>
            printf("%s: read failed %d\n", s, i);
     b06:	862a                	mv	a2,a0
     b08:	85d6                	mv	a1,s5
     b0a:	00005517          	auipc	a0,0x5
     b0e:	7a650513          	addi	a0,a0,1958 # 62b0 <malloc+0x5ac>
     b12:	00005097          	auipc	ra,0x5
     b16:	13a080e7          	jalr	314(ra) # 5c4c <printf>
            exit(1);
     b1a:	4505                	li	a0,1
     b1c:	00005097          	auipc	ra,0x5
     b20:	db8080e7          	jalr	-584(ra) # 58d4 <exit>
            printf("%s: read content of block %d is %d\n", s, n,
     b24:	8626                	mv	a2,s1
     b26:	85d6                	mv	a1,s5
     b28:	00005517          	auipc	a0,0x5
     b2c:	7a050513          	addi	a0,a0,1952 # 62c8 <malloc+0x5c4>
     b30:	00005097          	auipc	ra,0x5
     b34:	11c080e7          	jalr	284(ra) # 5c4c <printf>
            exit(1);
     b38:	4505                	li	a0,1
     b3a:	00005097          	auipc	ra,0x5
     b3e:	d9a080e7          	jalr	-614(ra) # 58d4 <exit>
        printf("%s: unlink big failed\n", s);
     b42:	85d6                	mv	a1,s5
     b44:	00005517          	auipc	a0,0x5
     b48:	7ac50513          	addi	a0,a0,1964 # 62f0 <malloc+0x5ec>
     b4c:	00005097          	auipc	ra,0x5
     b50:	100080e7          	jalr	256(ra) # 5c4c <printf>
        exit(1);
     b54:	4505                	li	a0,1
     b56:	00005097          	auipc	ra,0x5
     b5a:	d7e080e7          	jalr	-642(ra) # 58d4 <exit>

0000000000000b5e <unlinkread>:
void unlinkread(char *s) {
     b5e:	7179                	addi	sp,sp,-48
     b60:	f406                	sd	ra,40(sp)
     b62:	f022                	sd	s0,32(sp)
     b64:	ec26                	sd	s1,24(sp)
     b66:	e84a                	sd	s2,16(sp)
     b68:	e44e                	sd	s3,8(sp)
     b6a:	1800                	addi	s0,sp,48
     b6c:	89aa                	mv	s3,a0
    fd = open("unlinkread", O_CREATE | O_RDWR);
     b6e:	20200593          	li	a1,514
     b72:	00005517          	auipc	a0,0x5
     b76:	79650513          	addi	a0,a0,1942 # 6308 <malloc+0x604>
     b7a:	00005097          	auipc	ra,0x5
     b7e:	d9a080e7          	jalr	-614(ra) # 5914 <open>
    if (fd < 0) {
     b82:	0e054563          	bltz	a0,c6c <unlinkread+0x10e>
     b86:	84aa                	mv	s1,a0
    write(fd, "hello", SZ);
     b88:	4615                	li	a2,5
     b8a:	00005597          	auipc	a1,0x5
     b8e:	7ae58593          	addi	a1,a1,1966 # 6338 <malloc+0x634>
     b92:	00005097          	auipc	ra,0x5
     b96:	d62080e7          	jalr	-670(ra) # 58f4 <write>
    close(fd);
     b9a:	8526                	mv	a0,s1
     b9c:	00005097          	auipc	ra,0x5
     ba0:	d60080e7          	jalr	-672(ra) # 58fc <close>
    fd = open("unlinkread", O_RDWR);
     ba4:	4589                	li	a1,2
     ba6:	00005517          	auipc	a0,0x5
     baa:	76250513          	addi	a0,a0,1890 # 6308 <malloc+0x604>
     bae:	00005097          	auipc	ra,0x5
     bb2:	d66080e7          	jalr	-666(ra) # 5914 <open>
     bb6:	84aa                	mv	s1,a0
    if (fd < 0) {
     bb8:	0c054863          	bltz	a0,c88 <unlinkread+0x12a>
    if (unlink("unlinkread") != 0) {
     bbc:	00005517          	auipc	a0,0x5
     bc0:	74c50513          	addi	a0,a0,1868 # 6308 <malloc+0x604>
     bc4:	00005097          	auipc	ra,0x5
     bc8:	d60080e7          	jalr	-672(ra) # 5924 <unlink>
     bcc:	ed61                	bnez	a0,ca4 <unlinkread+0x146>
    fd1 = open("unlinkread", O_CREATE | O_RDWR);
     bce:	20200593          	li	a1,514
     bd2:	00005517          	auipc	a0,0x5
     bd6:	73650513          	addi	a0,a0,1846 # 6308 <malloc+0x604>
     bda:	00005097          	auipc	ra,0x5
     bde:	d3a080e7          	jalr	-710(ra) # 5914 <open>
     be2:	892a                	mv	s2,a0
    write(fd1, "yyy", 3);
     be4:	460d                	li	a2,3
     be6:	00005597          	auipc	a1,0x5
     bea:	79a58593          	addi	a1,a1,1946 # 6380 <malloc+0x67c>
     bee:	00005097          	auipc	ra,0x5
     bf2:	d06080e7          	jalr	-762(ra) # 58f4 <write>
    close(fd1);
     bf6:	854a                	mv	a0,s2
     bf8:	00005097          	auipc	ra,0x5
     bfc:	d04080e7          	jalr	-764(ra) # 58fc <close>
    if (read(fd, buf, sizeof(buf)) != SZ) {
     c00:	660d                	lui	a2,0x3
     c02:	0000c597          	auipc	a1,0xc
     c06:	4de58593          	addi	a1,a1,1246 # d0e0 <buf>
     c0a:	8526                	mv	a0,s1
     c0c:	00005097          	auipc	ra,0x5
     c10:	ce0080e7          	jalr	-800(ra) # 58ec <read>
     c14:	4795                	li	a5,5
     c16:	0af51563          	bne	a0,a5,cc0 <unlinkread+0x162>
    if (buf[0] != 'h') {
     c1a:	0000c717          	auipc	a4,0xc
     c1e:	4c674703          	lbu	a4,1222(a4) # d0e0 <buf>
     c22:	06800793          	li	a5,104
     c26:	0af71b63          	bne	a4,a5,cdc <unlinkread+0x17e>
    if (write(fd, buf, 10) != 10) {
     c2a:	4629                	li	a2,10
     c2c:	0000c597          	auipc	a1,0xc
     c30:	4b458593          	addi	a1,a1,1204 # d0e0 <buf>
     c34:	8526                	mv	a0,s1
     c36:	00005097          	auipc	ra,0x5
     c3a:	cbe080e7          	jalr	-834(ra) # 58f4 <write>
     c3e:	47a9                	li	a5,10
     c40:	0af51c63          	bne	a0,a5,cf8 <unlinkread+0x19a>
    close(fd);
     c44:	8526                	mv	a0,s1
     c46:	00005097          	auipc	ra,0x5
     c4a:	cb6080e7          	jalr	-842(ra) # 58fc <close>
    unlink("unlinkread");
     c4e:	00005517          	auipc	a0,0x5
     c52:	6ba50513          	addi	a0,a0,1722 # 6308 <malloc+0x604>
     c56:	00005097          	auipc	ra,0x5
     c5a:	cce080e7          	jalr	-818(ra) # 5924 <unlink>
}
     c5e:	70a2                	ld	ra,40(sp)
     c60:	7402                	ld	s0,32(sp)
     c62:	64e2                	ld	s1,24(sp)
     c64:	6942                	ld	s2,16(sp)
     c66:	69a2                	ld	s3,8(sp)
     c68:	6145                	addi	sp,sp,48
     c6a:	8082                	ret
        printf("%s: create unlinkread failed\n", s);
     c6c:	85ce                	mv	a1,s3
     c6e:	00005517          	auipc	a0,0x5
     c72:	6aa50513          	addi	a0,a0,1706 # 6318 <malloc+0x614>
     c76:	00005097          	auipc	ra,0x5
     c7a:	fd6080e7          	jalr	-42(ra) # 5c4c <printf>
        exit(1);
     c7e:	4505                	li	a0,1
     c80:	00005097          	auipc	ra,0x5
     c84:	c54080e7          	jalr	-940(ra) # 58d4 <exit>
        printf("%s: open unlinkread failed\n", s);
     c88:	85ce                	mv	a1,s3
     c8a:	00005517          	auipc	a0,0x5
     c8e:	6b650513          	addi	a0,a0,1718 # 6340 <malloc+0x63c>
     c92:	00005097          	auipc	ra,0x5
     c96:	fba080e7          	jalr	-70(ra) # 5c4c <printf>
        exit(1);
     c9a:	4505                	li	a0,1
     c9c:	00005097          	auipc	ra,0x5
     ca0:	c38080e7          	jalr	-968(ra) # 58d4 <exit>
        printf("%s: unlink unlinkread failed\n", s);
     ca4:	85ce                	mv	a1,s3
     ca6:	00005517          	auipc	a0,0x5
     caa:	6ba50513          	addi	a0,a0,1722 # 6360 <malloc+0x65c>
     cae:	00005097          	auipc	ra,0x5
     cb2:	f9e080e7          	jalr	-98(ra) # 5c4c <printf>
        exit(1);
     cb6:	4505                	li	a0,1
     cb8:	00005097          	auipc	ra,0x5
     cbc:	c1c080e7          	jalr	-996(ra) # 58d4 <exit>
        printf("%s: unlinkread read failed", s);
     cc0:	85ce                	mv	a1,s3
     cc2:	00005517          	auipc	a0,0x5
     cc6:	6c650513          	addi	a0,a0,1734 # 6388 <malloc+0x684>
     cca:	00005097          	auipc	ra,0x5
     cce:	f82080e7          	jalr	-126(ra) # 5c4c <printf>
        exit(1);
     cd2:	4505                	li	a0,1
     cd4:	00005097          	auipc	ra,0x5
     cd8:	c00080e7          	jalr	-1024(ra) # 58d4 <exit>
        printf("%s: unlinkread wrong data\n", s);
     cdc:	85ce                	mv	a1,s3
     cde:	00005517          	auipc	a0,0x5
     ce2:	6ca50513          	addi	a0,a0,1738 # 63a8 <malloc+0x6a4>
     ce6:	00005097          	auipc	ra,0x5
     cea:	f66080e7          	jalr	-154(ra) # 5c4c <printf>
        exit(1);
     cee:	4505                	li	a0,1
     cf0:	00005097          	auipc	ra,0x5
     cf4:	be4080e7          	jalr	-1052(ra) # 58d4 <exit>
        printf("%s: unlinkread write failed\n", s);
     cf8:	85ce                	mv	a1,s3
     cfa:	00005517          	auipc	a0,0x5
     cfe:	6ce50513          	addi	a0,a0,1742 # 63c8 <malloc+0x6c4>
     d02:	00005097          	auipc	ra,0x5
     d06:	f4a080e7          	jalr	-182(ra) # 5c4c <printf>
        exit(1);
     d0a:	4505                	li	a0,1
     d0c:	00005097          	auipc	ra,0x5
     d10:	bc8080e7          	jalr	-1080(ra) # 58d4 <exit>

0000000000000d14 <linktest>:
void linktest(char *s) {
     d14:	1101                	addi	sp,sp,-32
     d16:	ec06                	sd	ra,24(sp)
     d18:	e822                	sd	s0,16(sp)
     d1a:	e426                	sd	s1,8(sp)
     d1c:	e04a                	sd	s2,0(sp)
     d1e:	1000                	addi	s0,sp,32
     d20:	892a                	mv	s2,a0
    unlink("lf1");
     d22:	00005517          	auipc	a0,0x5
     d26:	6c650513          	addi	a0,a0,1734 # 63e8 <malloc+0x6e4>
     d2a:	00005097          	auipc	ra,0x5
     d2e:	bfa080e7          	jalr	-1030(ra) # 5924 <unlink>
    unlink("lf2");
     d32:	00005517          	auipc	a0,0x5
     d36:	6be50513          	addi	a0,a0,1726 # 63f0 <malloc+0x6ec>
     d3a:	00005097          	auipc	ra,0x5
     d3e:	bea080e7          	jalr	-1046(ra) # 5924 <unlink>
    fd = open("lf1", O_CREATE | O_RDWR);
     d42:	20200593          	li	a1,514
     d46:	00005517          	auipc	a0,0x5
     d4a:	6a250513          	addi	a0,a0,1698 # 63e8 <malloc+0x6e4>
     d4e:	00005097          	auipc	ra,0x5
     d52:	bc6080e7          	jalr	-1082(ra) # 5914 <open>
    if (fd < 0) {
     d56:	10054763          	bltz	a0,e64 <linktest+0x150>
     d5a:	84aa                	mv	s1,a0
    if (write(fd, "hello", SZ) != SZ) {
     d5c:	4615                	li	a2,5
     d5e:	00005597          	auipc	a1,0x5
     d62:	5da58593          	addi	a1,a1,1498 # 6338 <malloc+0x634>
     d66:	00005097          	auipc	ra,0x5
     d6a:	b8e080e7          	jalr	-1138(ra) # 58f4 <write>
     d6e:	4795                	li	a5,5
     d70:	10f51863          	bne	a0,a5,e80 <linktest+0x16c>
    close(fd);
     d74:	8526                	mv	a0,s1
     d76:	00005097          	auipc	ra,0x5
     d7a:	b86080e7          	jalr	-1146(ra) # 58fc <close>
    if (link("lf1", "lf2") < 0) {
     d7e:	00005597          	auipc	a1,0x5
     d82:	67258593          	addi	a1,a1,1650 # 63f0 <malloc+0x6ec>
     d86:	00005517          	auipc	a0,0x5
     d8a:	66250513          	addi	a0,a0,1634 # 63e8 <malloc+0x6e4>
     d8e:	00005097          	auipc	ra,0x5
     d92:	ba6080e7          	jalr	-1114(ra) # 5934 <link>
     d96:	10054363          	bltz	a0,e9c <linktest+0x188>
    unlink("lf1");
     d9a:	00005517          	auipc	a0,0x5
     d9e:	64e50513          	addi	a0,a0,1614 # 63e8 <malloc+0x6e4>
     da2:	00005097          	auipc	ra,0x5
     da6:	b82080e7          	jalr	-1150(ra) # 5924 <unlink>
    if (open("lf1", 0) >= 0) {
     daa:	4581                	li	a1,0
     dac:	00005517          	auipc	a0,0x5
     db0:	63c50513          	addi	a0,a0,1596 # 63e8 <malloc+0x6e4>
     db4:	00005097          	auipc	ra,0x5
     db8:	b60080e7          	jalr	-1184(ra) # 5914 <open>
     dbc:	0e055e63          	bgez	a0,eb8 <linktest+0x1a4>
    fd = open("lf2", 0);
     dc0:	4581                	li	a1,0
     dc2:	00005517          	auipc	a0,0x5
     dc6:	62e50513          	addi	a0,a0,1582 # 63f0 <malloc+0x6ec>
     dca:	00005097          	auipc	ra,0x5
     dce:	b4a080e7          	jalr	-1206(ra) # 5914 <open>
     dd2:	84aa                	mv	s1,a0
    if (fd < 0) {
     dd4:	10054063          	bltz	a0,ed4 <linktest+0x1c0>
    if (read(fd, buf, sizeof(buf)) != SZ) {
     dd8:	660d                	lui	a2,0x3
     dda:	0000c597          	auipc	a1,0xc
     dde:	30658593          	addi	a1,a1,774 # d0e0 <buf>
     de2:	00005097          	auipc	ra,0x5
     de6:	b0a080e7          	jalr	-1270(ra) # 58ec <read>
     dea:	4795                	li	a5,5
     dec:	10f51263          	bne	a0,a5,ef0 <linktest+0x1dc>
    close(fd);
     df0:	8526                	mv	a0,s1
     df2:	00005097          	auipc	ra,0x5
     df6:	b0a080e7          	jalr	-1270(ra) # 58fc <close>
    if (link("lf2", "lf2") >= 0) {
     dfa:	00005597          	auipc	a1,0x5
     dfe:	5f658593          	addi	a1,a1,1526 # 63f0 <malloc+0x6ec>
     e02:	852e                	mv	a0,a1
     e04:	00005097          	auipc	ra,0x5
     e08:	b30080e7          	jalr	-1232(ra) # 5934 <link>
     e0c:	10055063          	bgez	a0,f0c <linktest+0x1f8>
    unlink("lf2");
     e10:	00005517          	auipc	a0,0x5
     e14:	5e050513          	addi	a0,a0,1504 # 63f0 <malloc+0x6ec>
     e18:	00005097          	auipc	ra,0x5
     e1c:	b0c080e7          	jalr	-1268(ra) # 5924 <unlink>
    if (link("lf2", "lf1") >= 0) {
     e20:	00005597          	auipc	a1,0x5
     e24:	5c858593          	addi	a1,a1,1480 # 63e8 <malloc+0x6e4>
     e28:	00005517          	auipc	a0,0x5
     e2c:	5c850513          	addi	a0,a0,1480 # 63f0 <malloc+0x6ec>
     e30:	00005097          	auipc	ra,0x5
     e34:	b04080e7          	jalr	-1276(ra) # 5934 <link>
     e38:	0e055863          	bgez	a0,f28 <linktest+0x214>
    if (link(".", "lf1") >= 0) {
     e3c:	00005597          	auipc	a1,0x5
     e40:	5ac58593          	addi	a1,a1,1452 # 63e8 <malloc+0x6e4>
     e44:	00005517          	auipc	a0,0x5
     e48:	6b450513          	addi	a0,a0,1716 # 64f8 <malloc+0x7f4>
     e4c:	00005097          	auipc	ra,0x5
     e50:	ae8080e7          	jalr	-1304(ra) # 5934 <link>
     e54:	0e055863          	bgez	a0,f44 <linktest+0x230>
}
     e58:	60e2                	ld	ra,24(sp)
     e5a:	6442                	ld	s0,16(sp)
     e5c:	64a2                	ld	s1,8(sp)
     e5e:	6902                	ld	s2,0(sp)
     e60:	6105                	addi	sp,sp,32
     e62:	8082                	ret
        printf("%s: create lf1 failed\n", s);
     e64:	85ca                	mv	a1,s2
     e66:	00005517          	auipc	a0,0x5
     e6a:	59250513          	addi	a0,a0,1426 # 63f8 <malloc+0x6f4>
     e6e:	00005097          	auipc	ra,0x5
     e72:	dde080e7          	jalr	-546(ra) # 5c4c <printf>
        exit(1);
     e76:	4505                	li	a0,1
     e78:	00005097          	auipc	ra,0x5
     e7c:	a5c080e7          	jalr	-1444(ra) # 58d4 <exit>
        printf("%s: write lf1 failed\n", s);
     e80:	85ca                	mv	a1,s2
     e82:	00005517          	auipc	a0,0x5
     e86:	58e50513          	addi	a0,a0,1422 # 6410 <malloc+0x70c>
     e8a:	00005097          	auipc	ra,0x5
     e8e:	dc2080e7          	jalr	-574(ra) # 5c4c <printf>
        exit(1);
     e92:	4505                	li	a0,1
     e94:	00005097          	auipc	ra,0x5
     e98:	a40080e7          	jalr	-1472(ra) # 58d4 <exit>
        printf("%s: link lf1 lf2 failed\n", s);
     e9c:	85ca                	mv	a1,s2
     e9e:	00005517          	auipc	a0,0x5
     ea2:	58a50513          	addi	a0,a0,1418 # 6428 <malloc+0x724>
     ea6:	00005097          	auipc	ra,0x5
     eaa:	da6080e7          	jalr	-602(ra) # 5c4c <printf>
        exit(1);
     eae:	4505                	li	a0,1
     eb0:	00005097          	auipc	ra,0x5
     eb4:	a24080e7          	jalr	-1500(ra) # 58d4 <exit>
        printf("%s: unlinked lf1 but it is still there!\n", s);
     eb8:	85ca                	mv	a1,s2
     eba:	00005517          	auipc	a0,0x5
     ebe:	58e50513          	addi	a0,a0,1422 # 6448 <malloc+0x744>
     ec2:	00005097          	auipc	ra,0x5
     ec6:	d8a080e7          	jalr	-630(ra) # 5c4c <printf>
        exit(1);
     eca:	4505                	li	a0,1
     ecc:	00005097          	auipc	ra,0x5
     ed0:	a08080e7          	jalr	-1528(ra) # 58d4 <exit>
        printf("%s: open lf2 failed\n", s);
     ed4:	85ca                	mv	a1,s2
     ed6:	00005517          	auipc	a0,0x5
     eda:	5a250513          	addi	a0,a0,1442 # 6478 <malloc+0x774>
     ede:	00005097          	auipc	ra,0x5
     ee2:	d6e080e7          	jalr	-658(ra) # 5c4c <printf>
        exit(1);
     ee6:	4505                	li	a0,1
     ee8:	00005097          	auipc	ra,0x5
     eec:	9ec080e7          	jalr	-1556(ra) # 58d4 <exit>
        printf("%s: read lf2 failed\n", s);
     ef0:	85ca                	mv	a1,s2
     ef2:	00005517          	auipc	a0,0x5
     ef6:	59e50513          	addi	a0,a0,1438 # 6490 <malloc+0x78c>
     efa:	00005097          	auipc	ra,0x5
     efe:	d52080e7          	jalr	-686(ra) # 5c4c <printf>
        exit(1);
     f02:	4505                	li	a0,1
     f04:	00005097          	auipc	ra,0x5
     f08:	9d0080e7          	jalr	-1584(ra) # 58d4 <exit>
        printf("%s: link lf2 lf2 succeeded! oops\n", s);
     f0c:	85ca                	mv	a1,s2
     f0e:	00005517          	auipc	a0,0x5
     f12:	59a50513          	addi	a0,a0,1434 # 64a8 <malloc+0x7a4>
     f16:	00005097          	auipc	ra,0x5
     f1a:	d36080e7          	jalr	-714(ra) # 5c4c <printf>
        exit(1);
     f1e:	4505                	li	a0,1
     f20:	00005097          	auipc	ra,0x5
     f24:	9b4080e7          	jalr	-1612(ra) # 58d4 <exit>
        printf("%s: link non-existent succeeded! oops\n", s);
     f28:	85ca                	mv	a1,s2
     f2a:	00005517          	auipc	a0,0x5
     f2e:	5a650513          	addi	a0,a0,1446 # 64d0 <malloc+0x7cc>
     f32:	00005097          	auipc	ra,0x5
     f36:	d1a080e7          	jalr	-742(ra) # 5c4c <printf>
        exit(1);
     f3a:	4505                	li	a0,1
     f3c:	00005097          	auipc	ra,0x5
     f40:	998080e7          	jalr	-1640(ra) # 58d4 <exit>
        printf("%s: link . lf1 succeeded! oops\n", s);
     f44:	85ca                	mv	a1,s2
     f46:	00005517          	auipc	a0,0x5
     f4a:	5ba50513          	addi	a0,a0,1466 # 6500 <malloc+0x7fc>
     f4e:	00005097          	auipc	ra,0x5
     f52:	cfe080e7          	jalr	-770(ra) # 5c4c <printf>
        exit(1);
     f56:	4505                	li	a0,1
     f58:	00005097          	auipc	ra,0x5
     f5c:	97c080e7          	jalr	-1668(ra) # 58d4 <exit>

0000000000000f60 <bigdir>:
void bigdir(char *s) {
     f60:	715d                	addi	sp,sp,-80
     f62:	e486                	sd	ra,72(sp)
     f64:	e0a2                	sd	s0,64(sp)
     f66:	fc26                	sd	s1,56(sp)
     f68:	f84a                	sd	s2,48(sp)
     f6a:	f44e                	sd	s3,40(sp)
     f6c:	f052                	sd	s4,32(sp)
     f6e:	ec56                	sd	s5,24(sp)
     f70:	e85a                	sd	s6,16(sp)
     f72:	0880                	addi	s0,sp,80
     f74:	89aa                	mv	s3,a0
    unlink("bd");
     f76:	00005517          	auipc	a0,0x5
     f7a:	5aa50513          	addi	a0,a0,1450 # 6520 <malloc+0x81c>
     f7e:	00005097          	auipc	ra,0x5
     f82:	9a6080e7          	jalr	-1626(ra) # 5924 <unlink>
    fd = open("bd", O_CREATE);
     f86:	20000593          	li	a1,512
     f8a:	00005517          	auipc	a0,0x5
     f8e:	59650513          	addi	a0,a0,1430 # 6520 <malloc+0x81c>
     f92:	00005097          	auipc	ra,0x5
     f96:	982080e7          	jalr	-1662(ra) # 5914 <open>
    if (fd < 0) {
     f9a:	0c054963          	bltz	a0,106c <bigdir+0x10c>
    close(fd);
     f9e:	00005097          	auipc	ra,0x5
     fa2:	95e080e7          	jalr	-1698(ra) # 58fc <close>
    for (i = 0; i < N; i++) {
     fa6:	4901                	li	s2,0
        name[0] = 'x';
     fa8:	07800a93          	li	s5,120
        if (link("bd", name) != 0) {
     fac:	00005a17          	auipc	s4,0x5
     fb0:	574a0a13          	addi	s4,s4,1396 # 6520 <malloc+0x81c>
    for (i = 0; i < N; i++) {
     fb4:	1f400b13          	li	s6,500
        name[0] = 'x';
     fb8:	fb540823          	sb	s5,-80(s0)
        name[1] = '0' + (i / 64);
     fbc:	41f9571b          	sraiw	a4,s2,0x1f
     fc0:	01a7571b          	srliw	a4,a4,0x1a
     fc4:	012707bb          	addw	a5,a4,s2
     fc8:	4067d69b          	sraiw	a3,a5,0x6
     fcc:	0306869b          	addiw	a3,a3,48
     fd0:	fad408a3          	sb	a3,-79(s0)
        name[2] = '0' + (i % 64);
     fd4:	03f7f793          	andi	a5,a5,63
     fd8:	9f99                	subw	a5,a5,a4
     fda:	0307879b          	addiw	a5,a5,48
     fde:	faf40923          	sb	a5,-78(s0)
        name[3] = '\0';
     fe2:	fa0409a3          	sb	zero,-77(s0)
        if (link("bd", name) != 0) {
     fe6:	fb040593          	addi	a1,s0,-80
     fea:	8552                	mv	a0,s4
     fec:	00005097          	auipc	ra,0x5
     ff0:	948080e7          	jalr	-1720(ra) # 5934 <link>
     ff4:	84aa                	mv	s1,a0
     ff6:	e949                	bnez	a0,1088 <bigdir+0x128>
    for (i = 0; i < N; i++) {
     ff8:	2905                	addiw	s2,s2,1
     ffa:	fb691fe3          	bne	s2,s6,fb8 <bigdir+0x58>
    unlink("bd");
     ffe:	00005517          	auipc	a0,0x5
    1002:	52250513          	addi	a0,a0,1314 # 6520 <malloc+0x81c>
    1006:	00005097          	auipc	ra,0x5
    100a:	91e080e7          	jalr	-1762(ra) # 5924 <unlink>
        name[0] = 'x';
    100e:	07800913          	li	s2,120
    for (i = 0; i < N; i++) {
    1012:	1f400a13          	li	s4,500
        name[0] = 'x';
    1016:	fb240823          	sb	s2,-80(s0)
        name[1] = '0' + (i / 64);
    101a:	41f4d71b          	sraiw	a4,s1,0x1f
    101e:	01a7571b          	srliw	a4,a4,0x1a
    1022:	009707bb          	addw	a5,a4,s1
    1026:	4067d69b          	sraiw	a3,a5,0x6
    102a:	0306869b          	addiw	a3,a3,48
    102e:	fad408a3          	sb	a3,-79(s0)
        name[2] = '0' + (i % 64);
    1032:	03f7f793          	andi	a5,a5,63
    1036:	9f99                	subw	a5,a5,a4
    1038:	0307879b          	addiw	a5,a5,48
    103c:	faf40923          	sb	a5,-78(s0)
        name[3] = '\0';
    1040:	fa0409a3          	sb	zero,-77(s0)
        if (unlink(name) != 0) {
    1044:	fb040513          	addi	a0,s0,-80
    1048:	00005097          	auipc	ra,0x5
    104c:	8dc080e7          	jalr	-1828(ra) # 5924 <unlink>
    1050:	ed21                	bnez	a0,10a8 <bigdir+0x148>
    for (i = 0; i < N; i++) {
    1052:	2485                	addiw	s1,s1,1
    1054:	fd4491e3          	bne	s1,s4,1016 <bigdir+0xb6>
}
    1058:	60a6                	ld	ra,72(sp)
    105a:	6406                	ld	s0,64(sp)
    105c:	74e2                	ld	s1,56(sp)
    105e:	7942                	ld	s2,48(sp)
    1060:	79a2                	ld	s3,40(sp)
    1062:	7a02                	ld	s4,32(sp)
    1064:	6ae2                	ld	s5,24(sp)
    1066:	6b42                	ld	s6,16(sp)
    1068:	6161                	addi	sp,sp,80
    106a:	8082                	ret
        printf("%s: bigdir create failed\n", s);
    106c:	85ce                	mv	a1,s3
    106e:	00005517          	auipc	a0,0x5
    1072:	4ba50513          	addi	a0,a0,1210 # 6528 <malloc+0x824>
    1076:	00005097          	auipc	ra,0x5
    107a:	bd6080e7          	jalr	-1066(ra) # 5c4c <printf>
        exit(1);
    107e:	4505                	li	a0,1
    1080:	00005097          	auipc	ra,0x5
    1084:	854080e7          	jalr	-1964(ra) # 58d4 <exit>
            printf("%s: bigdir link(bd, %s) failed\n", s, name);
    1088:	fb040613          	addi	a2,s0,-80
    108c:	85ce                	mv	a1,s3
    108e:	00005517          	auipc	a0,0x5
    1092:	4ba50513          	addi	a0,a0,1210 # 6548 <malloc+0x844>
    1096:	00005097          	auipc	ra,0x5
    109a:	bb6080e7          	jalr	-1098(ra) # 5c4c <printf>
            exit(1);
    109e:	4505                	li	a0,1
    10a0:	00005097          	auipc	ra,0x5
    10a4:	834080e7          	jalr	-1996(ra) # 58d4 <exit>
            printf("%s: bigdir unlink failed", s);
    10a8:	85ce                	mv	a1,s3
    10aa:	00005517          	auipc	a0,0x5
    10ae:	4be50513          	addi	a0,a0,1214 # 6568 <malloc+0x864>
    10b2:	00005097          	auipc	ra,0x5
    10b6:	b9a080e7          	jalr	-1126(ra) # 5c4c <printf>
            exit(1);
    10ba:	4505                	li	a0,1
    10bc:	00005097          	auipc	ra,0x5
    10c0:	818080e7          	jalr	-2024(ra) # 58d4 <exit>

00000000000010c4 <validatetest>:
void validatetest(char *s) {
    10c4:	7139                	addi	sp,sp,-64
    10c6:	fc06                	sd	ra,56(sp)
    10c8:	f822                	sd	s0,48(sp)
    10ca:	f426                	sd	s1,40(sp)
    10cc:	f04a                	sd	s2,32(sp)
    10ce:	ec4e                	sd	s3,24(sp)
    10d0:	e852                	sd	s4,16(sp)
    10d2:	e456                	sd	s5,8(sp)
    10d4:	e05a                	sd	s6,0(sp)
    10d6:	0080                	addi	s0,sp,64
    10d8:	8b2a                	mv	s6,a0
    for (p = 0; p <= (uint)hi; p += PGSIZE) {
    10da:	4481                	li	s1,0
        if (link("nosuchfile", (char *)p) != -1) {
    10dc:	00005997          	auipc	s3,0x5
    10e0:	4ac98993          	addi	s3,s3,1196 # 6588 <malloc+0x884>
    10e4:	597d                	li	s2,-1
    for (p = 0; p <= (uint)hi; p += PGSIZE) {
    10e6:	6a85                	lui	s5,0x1
    10e8:	00114a37          	lui	s4,0x114
        if (link("nosuchfile", (char *)p) != -1) {
    10ec:	85a6                	mv	a1,s1
    10ee:	854e                	mv	a0,s3
    10f0:	00005097          	auipc	ra,0x5
    10f4:	844080e7          	jalr	-1980(ra) # 5934 <link>
    10f8:	01251f63          	bne	a0,s2,1116 <validatetest+0x52>
    for (p = 0; p <= (uint)hi; p += PGSIZE) {
    10fc:	94d6                	add	s1,s1,s5
    10fe:	ff4497e3          	bne	s1,s4,10ec <validatetest+0x28>
}
    1102:	70e2                	ld	ra,56(sp)
    1104:	7442                	ld	s0,48(sp)
    1106:	74a2                	ld	s1,40(sp)
    1108:	7902                	ld	s2,32(sp)
    110a:	69e2                	ld	s3,24(sp)
    110c:	6a42                	ld	s4,16(sp)
    110e:	6aa2                	ld	s5,8(sp)
    1110:	6b02                	ld	s6,0(sp)
    1112:	6121                	addi	sp,sp,64
    1114:	8082                	ret
            printf("%s: link should not succeed\n", s);
    1116:	85da                	mv	a1,s6
    1118:	00005517          	auipc	a0,0x5
    111c:	48050513          	addi	a0,a0,1152 # 6598 <malloc+0x894>
    1120:	00005097          	auipc	ra,0x5
    1124:	b2c080e7          	jalr	-1236(ra) # 5c4c <printf>
            exit(1);
    1128:	4505                	li	a0,1
    112a:	00004097          	auipc	ra,0x4
    112e:	7aa080e7          	jalr	1962(ra) # 58d4 <exit>

0000000000001132 <pgbug>:
}

// regression test. copyin(), copyout(), and copyinstr() used to cast
// the virtual page address to uint, which (with certain wild system
// call arguments) resulted in a kernel page faults.
void pgbug(char *s) {
    1132:	7179                	addi	sp,sp,-48
    1134:	f406                	sd	ra,40(sp)
    1136:	f022                	sd	s0,32(sp)
    1138:	ec26                	sd	s1,24(sp)
    113a:	1800                	addi	s0,sp,48
    char *argv[1];
    argv[0] = 0;
    113c:	fc043c23          	sd	zero,-40(s0)
    exec((char *)0xeaeb0b5b00002f5e, argv);
    1140:	eaeb14b7          	lui	s1,0xeaeb1
    1144:	b5b48493          	addi	s1,s1,-1189 # ffffffffeaeb0b5b <__BSS_END__+0xffffffffeaea0a6b>
    1148:	04d2                	slli	s1,s1,0x14
    114a:	048d                	addi	s1,s1,3
    114c:	04b2                	slli	s1,s1,0xc
    114e:	f5e48493          	addi	s1,s1,-162
    1152:	fd840593          	addi	a1,s0,-40
    1156:	8526                	mv	a0,s1
    1158:	00004097          	auipc	ra,0x4
    115c:	7b4080e7          	jalr	1972(ra) # 590c <exec>

    pipe((int *)0xeaeb0b5b00002f5e);
    1160:	8526                	mv	a0,s1
    1162:	00004097          	auipc	ra,0x4
    1166:	782080e7          	jalr	1922(ra) # 58e4 <pipe>

    exit(0);
    116a:	4501                	li	a0,0
    116c:	00004097          	auipc	ra,0x4
    1170:	768080e7          	jalr	1896(ra) # 58d4 <exit>

0000000000001174 <badarg>:
    exit(0);
}

// regression test. test whether exec() leaks memory if one of the
// arguments is invalid. the test passes if the kernel doesn't panic.
void badarg(char *s) {
    1174:	7139                	addi	sp,sp,-64
    1176:	fc06                	sd	ra,56(sp)
    1178:	f822                	sd	s0,48(sp)
    117a:	f426                	sd	s1,40(sp)
    117c:	f04a                	sd	s2,32(sp)
    117e:	ec4e                	sd	s3,24(sp)
    1180:	0080                	addi	s0,sp,64
    1182:	64b1                	lui	s1,0xc
    1184:	35048493          	addi	s1,s1,848 # c350 <uninit+0x1980>
    for (int i = 0; i < 50000; i++) {
        char *argv[2];
        argv[0] = (char *)0xffffffff;
    1188:	597d                	li	s2,-1
    118a:	02095913          	srli	s2,s2,0x20
        argv[1] = 0;
        exec("echo", argv);
    118e:	00005997          	auipc	s3,0x5
    1192:	cb298993          	addi	s3,s3,-846 # 5e40 <malloc+0x13c>
        argv[0] = (char *)0xffffffff;
    1196:	fd243023          	sd	s2,-64(s0)
        argv[1] = 0;
    119a:	fc043423          	sd	zero,-56(s0)
        exec("echo", argv);
    119e:	fc040593          	addi	a1,s0,-64
    11a2:	854e                	mv	a0,s3
    11a4:	00004097          	auipc	ra,0x4
    11a8:	768080e7          	jalr	1896(ra) # 590c <exec>
    for (int i = 0; i < 50000; i++) {
    11ac:	34fd                	addiw	s1,s1,-1
    11ae:	f4e5                	bnez	s1,1196 <badarg+0x22>
    }

    exit(0);
    11b0:	4501                	li	a0,0
    11b2:	00004097          	auipc	ra,0x4
    11b6:	722080e7          	jalr	1826(ra) # 58d4 <exit>

00000000000011ba <copyinstr2>:
void copyinstr2(char *s) {
    11ba:	7155                	addi	sp,sp,-208
    11bc:	e586                	sd	ra,200(sp)
    11be:	e1a2                	sd	s0,192(sp)
    11c0:	0980                	addi	s0,sp,208
    for (int i = 0; i < MAXPATH; i++)
    11c2:	f6840793          	addi	a5,s0,-152
    11c6:	fe840693          	addi	a3,s0,-24
        b[i] = 'x';
    11ca:	07800713          	li	a4,120
    11ce:	00e78023          	sb	a4,0(a5)
    for (int i = 0; i < MAXPATH; i++)
    11d2:	0785                	addi	a5,a5,1
    11d4:	fed79de3          	bne	a5,a3,11ce <copyinstr2+0x14>
    b[MAXPATH] = '\0';
    11d8:	fe040423          	sb	zero,-24(s0)
    int ret = unlink(b);
    11dc:	f6840513          	addi	a0,s0,-152
    11e0:	00004097          	auipc	ra,0x4
    11e4:	744080e7          	jalr	1860(ra) # 5924 <unlink>
    if (ret != -1) {
    11e8:	57fd                	li	a5,-1
    11ea:	0ef51063          	bne	a0,a5,12ca <copyinstr2+0x110>
    int fd = open(b, O_CREATE | O_WRONLY);
    11ee:	20100593          	li	a1,513
    11f2:	f6840513          	addi	a0,s0,-152
    11f6:	00004097          	auipc	ra,0x4
    11fa:	71e080e7          	jalr	1822(ra) # 5914 <open>
    if (fd != -1) {
    11fe:	57fd                	li	a5,-1
    1200:	0ef51563          	bne	a0,a5,12ea <copyinstr2+0x130>
    ret = link(b, b);
    1204:	f6840593          	addi	a1,s0,-152
    1208:	852e                	mv	a0,a1
    120a:	00004097          	auipc	ra,0x4
    120e:	72a080e7          	jalr	1834(ra) # 5934 <link>
    if (ret != -1) {
    1212:	57fd                	li	a5,-1
    1214:	0ef51b63          	bne	a0,a5,130a <copyinstr2+0x150>
    char *args[] = {"xx", 0};
    1218:	00006797          	auipc	a5,0x6
    121c:	57878793          	addi	a5,a5,1400 # 7790 <malloc+0x1a8c>
    1220:	f4f43c23          	sd	a5,-168(s0)
    1224:	f6043023          	sd	zero,-160(s0)
    ret = exec(b, args);
    1228:	f5840593          	addi	a1,s0,-168
    122c:	f6840513          	addi	a0,s0,-152
    1230:	00004097          	auipc	ra,0x4
    1234:	6dc080e7          	jalr	1756(ra) # 590c <exec>
    if (ret != -1) {
    1238:	57fd                	li	a5,-1
    123a:	0ef51963          	bne	a0,a5,132c <copyinstr2+0x172>
    int pid = fork();
    123e:	00004097          	auipc	ra,0x4
    1242:	68e080e7          	jalr	1678(ra) # 58cc <fork>
    if (pid < 0) {
    1246:	10054363          	bltz	a0,134c <copyinstr2+0x192>
    if (pid == 0) {
    124a:	12051463          	bnez	a0,1372 <copyinstr2+0x1b8>
    124e:	00008797          	auipc	a5,0x8
    1252:	77a78793          	addi	a5,a5,1914 # 99c8 <big.0>
    1256:	00009697          	auipc	a3,0x9
    125a:	77268693          	addi	a3,a3,1906 # a9c8 <__global_pointer$+0x90c>
            big[i] = 'x';
    125e:	07800713          	li	a4,120
    1262:	00e78023          	sb	a4,0(a5)
        for (int i = 0; i < PGSIZE; i++)
    1266:	0785                	addi	a5,a5,1
    1268:	fed79de3          	bne	a5,a3,1262 <copyinstr2+0xa8>
        big[PGSIZE] = '\0';
    126c:	00009797          	auipc	a5,0x9
    1270:	74078e23          	sb	zero,1884(a5) # a9c8 <__global_pointer$+0x90c>
        char *args2[] = {big, big, big, 0};
    1274:	00007797          	auipc	a5,0x7
    1278:	f6478793          	addi	a5,a5,-156 # 81d8 <malloc+0x24d4>
    127c:	6390                	ld	a2,0(a5)
    127e:	6794                	ld	a3,8(a5)
    1280:	6b98                	ld	a4,16(a5)
    1282:	6f9c                	ld	a5,24(a5)
    1284:	f2c43823          	sd	a2,-208(s0)
    1288:	f2d43c23          	sd	a3,-200(s0)
    128c:	f4e43023          	sd	a4,-192(s0)
    1290:	f4f43423          	sd	a5,-184(s0)
        ret = exec("echo", args2);
    1294:	f3040593          	addi	a1,s0,-208
    1298:	00005517          	auipc	a0,0x5
    129c:	ba850513          	addi	a0,a0,-1112 # 5e40 <malloc+0x13c>
    12a0:	00004097          	auipc	ra,0x4
    12a4:	66c080e7          	jalr	1644(ra) # 590c <exec>
        if (ret != -1) {
    12a8:	57fd                	li	a5,-1
    12aa:	0af50e63          	beq	a0,a5,1366 <copyinstr2+0x1ac>
            printf("exec(echo, BIG) returned %d, not -1\n", fd);
    12ae:	55fd                	li	a1,-1
    12b0:	00005517          	auipc	a0,0x5
    12b4:	39050513          	addi	a0,a0,912 # 6640 <malloc+0x93c>
    12b8:	00005097          	auipc	ra,0x5
    12bc:	994080e7          	jalr	-1644(ra) # 5c4c <printf>
            exit(1);
    12c0:	4505                	li	a0,1
    12c2:	00004097          	auipc	ra,0x4
    12c6:	612080e7          	jalr	1554(ra) # 58d4 <exit>
        printf("unlink(%s) returned %d, not -1\n", b, ret);
    12ca:	862a                	mv	a2,a0
    12cc:	f6840593          	addi	a1,s0,-152
    12d0:	00005517          	auipc	a0,0x5
    12d4:	2e850513          	addi	a0,a0,744 # 65b8 <malloc+0x8b4>
    12d8:	00005097          	auipc	ra,0x5
    12dc:	974080e7          	jalr	-1676(ra) # 5c4c <printf>
        exit(1);
    12e0:	4505                	li	a0,1
    12e2:	00004097          	auipc	ra,0x4
    12e6:	5f2080e7          	jalr	1522(ra) # 58d4 <exit>
        printf("open(%s) returned %d, not -1\n", b, fd);
    12ea:	862a                	mv	a2,a0
    12ec:	f6840593          	addi	a1,s0,-152
    12f0:	00005517          	auipc	a0,0x5
    12f4:	2e850513          	addi	a0,a0,744 # 65d8 <malloc+0x8d4>
    12f8:	00005097          	auipc	ra,0x5
    12fc:	954080e7          	jalr	-1708(ra) # 5c4c <printf>
        exit(1);
    1300:	4505                	li	a0,1
    1302:	00004097          	auipc	ra,0x4
    1306:	5d2080e7          	jalr	1490(ra) # 58d4 <exit>
        printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    130a:	86aa                	mv	a3,a0
    130c:	f6840613          	addi	a2,s0,-152
    1310:	85b2                	mv	a1,a2
    1312:	00005517          	auipc	a0,0x5
    1316:	2e650513          	addi	a0,a0,742 # 65f8 <malloc+0x8f4>
    131a:	00005097          	auipc	ra,0x5
    131e:	932080e7          	jalr	-1742(ra) # 5c4c <printf>
        exit(1);
    1322:	4505                	li	a0,1
    1324:	00004097          	auipc	ra,0x4
    1328:	5b0080e7          	jalr	1456(ra) # 58d4 <exit>
        printf("exec(%s) returned %d, not -1\n", b, fd);
    132c:	567d                	li	a2,-1
    132e:	f6840593          	addi	a1,s0,-152
    1332:	00005517          	auipc	a0,0x5
    1336:	2ee50513          	addi	a0,a0,750 # 6620 <malloc+0x91c>
    133a:	00005097          	auipc	ra,0x5
    133e:	912080e7          	jalr	-1774(ra) # 5c4c <printf>
        exit(1);
    1342:	4505                	li	a0,1
    1344:	00004097          	auipc	ra,0x4
    1348:	590080e7          	jalr	1424(ra) # 58d4 <exit>
        printf("fork failed\n");
    134c:	00005517          	auipc	a0,0x5
    1350:	76c50513          	addi	a0,a0,1900 # 6ab8 <malloc+0xdb4>
    1354:	00005097          	auipc	ra,0x5
    1358:	8f8080e7          	jalr	-1800(ra) # 5c4c <printf>
        exit(1);
    135c:	4505                	li	a0,1
    135e:	00004097          	auipc	ra,0x4
    1362:	576080e7          	jalr	1398(ra) # 58d4 <exit>
        exit(747); // OK
    1366:	2eb00513          	li	a0,747
    136a:	00004097          	auipc	ra,0x4
    136e:	56a080e7          	jalr	1386(ra) # 58d4 <exit>
    int st = 0;
    1372:	f4042a23          	sw	zero,-172(s0)
    wait(&st);
    1376:	f5440513          	addi	a0,s0,-172
    137a:	00004097          	auipc	ra,0x4
    137e:	562080e7          	jalr	1378(ra) # 58dc <wait>
    if (st != 747) {
    1382:	f5442703          	lw	a4,-172(s0)
    1386:	2eb00793          	li	a5,747
    138a:	00f71663          	bne	a4,a5,1396 <copyinstr2+0x1dc>
}
    138e:	60ae                	ld	ra,200(sp)
    1390:	640e                	ld	s0,192(sp)
    1392:	6169                	addi	sp,sp,208
    1394:	8082                	ret
        printf("exec(echo, BIG) succeeded, should have failed\n");
    1396:	00005517          	auipc	a0,0x5
    139a:	2d250513          	addi	a0,a0,722 # 6668 <malloc+0x964>
    139e:	00005097          	auipc	ra,0x5
    13a2:	8ae080e7          	jalr	-1874(ra) # 5c4c <printf>
        exit(1);
    13a6:	4505                	li	a0,1
    13a8:	00004097          	auipc	ra,0x4
    13ac:	52c080e7          	jalr	1324(ra) # 58d4 <exit>

00000000000013b0 <truncate3>:
void truncate3(char *s) {
    13b0:	7159                	addi	sp,sp,-112
    13b2:	f486                	sd	ra,104(sp)
    13b4:	f0a2                	sd	s0,96(sp)
    13b6:	e8ca                	sd	s2,80(sp)
    13b8:	1880                	addi	s0,sp,112
    13ba:	892a                	mv	s2,a0
    close(open("truncfile", O_CREATE | O_TRUNC | O_WRONLY));
    13bc:	60100593          	li	a1,1537
    13c0:	00005517          	auipc	a0,0x5
    13c4:	ad850513          	addi	a0,a0,-1320 # 5e98 <malloc+0x194>
    13c8:	00004097          	auipc	ra,0x4
    13cc:	54c080e7          	jalr	1356(ra) # 5914 <open>
    13d0:	00004097          	auipc	ra,0x4
    13d4:	52c080e7          	jalr	1324(ra) # 58fc <close>
    pid = fork();
    13d8:	00004097          	auipc	ra,0x4
    13dc:	4f4080e7          	jalr	1268(ra) # 58cc <fork>
    if (pid < 0) {
    13e0:	08054463          	bltz	a0,1468 <truncate3+0xb8>
    if (pid == 0) {
    13e4:	e16d                	bnez	a0,14c6 <truncate3+0x116>
    13e6:	eca6                	sd	s1,88(sp)
    13e8:	e4ce                	sd	s3,72(sp)
    13ea:	e0d2                	sd	s4,64(sp)
    13ec:	fc56                	sd	s5,56(sp)
    13ee:	06400993          	li	s3,100
            int fd = open("truncfile", O_WRONLY);
    13f2:	00005a17          	auipc	s4,0x5
    13f6:	aa6a0a13          	addi	s4,s4,-1370 # 5e98 <malloc+0x194>
            int n = write(fd, "1234567890", 10);
    13fa:	00005a97          	auipc	s5,0x5
    13fe:	2cea8a93          	addi	s5,s5,718 # 66c8 <malloc+0x9c4>
            int fd = open("truncfile", O_WRONLY);
    1402:	4585                	li	a1,1
    1404:	8552                	mv	a0,s4
    1406:	00004097          	auipc	ra,0x4
    140a:	50e080e7          	jalr	1294(ra) # 5914 <open>
    140e:	84aa                	mv	s1,a0
            if (fd < 0) {
    1410:	06054e63          	bltz	a0,148c <truncate3+0xdc>
            int n = write(fd, "1234567890", 10);
    1414:	4629                	li	a2,10
    1416:	85d6                	mv	a1,s5
    1418:	00004097          	auipc	ra,0x4
    141c:	4dc080e7          	jalr	1244(ra) # 58f4 <write>
            if (n != 10) {
    1420:	47a9                	li	a5,10
    1422:	08f51363          	bne	a0,a5,14a8 <truncate3+0xf8>
            close(fd);
    1426:	8526                	mv	a0,s1
    1428:	00004097          	auipc	ra,0x4
    142c:	4d4080e7          	jalr	1236(ra) # 58fc <close>
            fd = open("truncfile", O_RDONLY);
    1430:	4581                	li	a1,0
    1432:	8552                	mv	a0,s4
    1434:	00004097          	auipc	ra,0x4
    1438:	4e0080e7          	jalr	1248(ra) # 5914 <open>
    143c:	84aa                	mv	s1,a0
            read(fd, buf, sizeof(buf));
    143e:	02000613          	li	a2,32
    1442:	f9840593          	addi	a1,s0,-104
    1446:	00004097          	auipc	ra,0x4
    144a:	4a6080e7          	jalr	1190(ra) # 58ec <read>
            close(fd);
    144e:	8526                	mv	a0,s1
    1450:	00004097          	auipc	ra,0x4
    1454:	4ac080e7          	jalr	1196(ra) # 58fc <close>
        for (int i = 0; i < 100; i++) {
    1458:	39fd                	addiw	s3,s3,-1
    145a:	fa0994e3          	bnez	s3,1402 <truncate3+0x52>
        exit(0);
    145e:	4501                	li	a0,0
    1460:	00004097          	auipc	ra,0x4
    1464:	474080e7          	jalr	1140(ra) # 58d4 <exit>
    1468:	eca6                	sd	s1,88(sp)
    146a:	e4ce                	sd	s3,72(sp)
    146c:	e0d2                	sd	s4,64(sp)
    146e:	fc56                	sd	s5,56(sp)
        printf("%s: fork failed\n", s);
    1470:	85ca                	mv	a1,s2
    1472:	00005517          	auipc	a0,0x5
    1476:	22650513          	addi	a0,a0,550 # 6698 <malloc+0x994>
    147a:	00004097          	auipc	ra,0x4
    147e:	7d2080e7          	jalr	2002(ra) # 5c4c <printf>
        exit(1);
    1482:	4505                	li	a0,1
    1484:	00004097          	auipc	ra,0x4
    1488:	450080e7          	jalr	1104(ra) # 58d4 <exit>
                printf("%s: open failed\n", s);
    148c:	85ca                	mv	a1,s2
    148e:	00005517          	auipc	a0,0x5
    1492:	22250513          	addi	a0,a0,546 # 66b0 <malloc+0x9ac>
    1496:	00004097          	auipc	ra,0x4
    149a:	7b6080e7          	jalr	1974(ra) # 5c4c <printf>
                exit(1);
    149e:	4505                	li	a0,1
    14a0:	00004097          	auipc	ra,0x4
    14a4:	434080e7          	jalr	1076(ra) # 58d4 <exit>
                printf("%s: write got %d, expected 10\n", s, n);
    14a8:	862a                	mv	a2,a0
    14aa:	85ca                	mv	a1,s2
    14ac:	00005517          	auipc	a0,0x5
    14b0:	22c50513          	addi	a0,a0,556 # 66d8 <malloc+0x9d4>
    14b4:	00004097          	auipc	ra,0x4
    14b8:	798080e7          	jalr	1944(ra) # 5c4c <printf>
                exit(1);
    14bc:	4505                	li	a0,1
    14be:	00004097          	auipc	ra,0x4
    14c2:	416080e7          	jalr	1046(ra) # 58d4 <exit>
    14c6:	eca6                	sd	s1,88(sp)
    14c8:	e4ce                	sd	s3,72(sp)
    14ca:	e0d2                	sd	s4,64(sp)
    14cc:	fc56                	sd	s5,56(sp)
    14ce:	09600993          	li	s3,150
        int fd = open("truncfile", O_CREATE | O_WRONLY | O_TRUNC);
    14d2:	00005a17          	auipc	s4,0x5
    14d6:	9c6a0a13          	addi	s4,s4,-1594 # 5e98 <malloc+0x194>
        int n = write(fd, "xxx", 3);
    14da:	00005a97          	auipc	s5,0x5
    14de:	21ea8a93          	addi	s5,s5,542 # 66f8 <malloc+0x9f4>
        int fd = open("truncfile", O_CREATE | O_WRONLY | O_TRUNC);
    14e2:	60100593          	li	a1,1537
    14e6:	8552                	mv	a0,s4
    14e8:	00004097          	auipc	ra,0x4
    14ec:	42c080e7          	jalr	1068(ra) # 5914 <open>
    14f0:	84aa                	mv	s1,a0
        if (fd < 0) {
    14f2:	04054763          	bltz	a0,1540 <truncate3+0x190>
        int n = write(fd, "xxx", 3);
    14f6:	460d                	li	a2,3
    14f8:	85d6                	mv	a1,s5
    14fa:	00004097          	auipc	ra,0x4
    14fe:	3fa080e7          	jalr	1018(ra) # 58f4 <write>
        if (n != 3) {
    1502:	478d                	li	a5,3
    1504:	04f51c63          	bne	a0,a5,155c <truncate3+0x1ac>
        close(fd);
    1508:	8526                	mv	a0,s1
    150a:	00004097          	auipc	ra,0x4
    150e:	3f2080e7          	jalr	1010(ra) # 58fc <close>
    for (int i = 0; i < 150; i++) {
    1512:	39fd                	addiw	s3,s3,-1
    1514:	fc0997e3          	bnez	s3,14e2 <truncate3+0x132>
    wait(&xstatus);
    1518:	fbc40513          	addi	a0,s0,-68
    151c:	00004097          	auipc	ra,0x4
    1520:	3c0080e7          	jalr	960(ra) # 58dc <wait>
    unlink("truncfile");
    1524:	00005517          	auipc	a0,0x5
    1528:	97450513          	addi	a0,a0,-1676 # 5e98 <malloc+0x194>
    152c:	00004097          	auipc	ra,0x4
    1530:	3f8080e7          	jalr	1016(ra) # 5924 <unlink>
    exit(xstatus);
    1534:	fbc42503          	lw	a0,-68(s0)
    1538:	00004097          	auipc	ra,0x4
    153c:	39c080e7          	jalr	924(ra) # 58d4 <exit>
            printf("%s: open failed\n", s);
    1540:	85ca                	mv	a1,s2
    1542:	00005517          	auipc	a0,0x5
    1546:	16e50513          	addi	a0,a0,366 # 66b0 <malloc+0x9ac>
    154a:	00004097          	auipc	ra,0x4
    154e:	702080e7          	jalr	1794(ra) # 5c4c <printf>
            exit(1);
    1552:	4505                	li	a0,1
    1554:	00004097          	auipc	ra,0x4
    1558:	380080e7          	jalr	896(ra) # 58d4 <exit>
            printf("%s: write got %d, expected 3\n", s, n);
    155c:	862a                	mv	a2,a0
    155e:	85ca                	mv	a1,s2
    1560:	00005517          	auipc	a0,0x5
    1564:	1a050513          	addi	a0,a0,416 # 6700 <malloc+0x9fc>
    1568:	00004097          	auipc	ra,0x4
    156c:	6e4080e7          	jalr	1764(ra) # 5c4c <printf>
            exit(1);
    1570:	4505                	li	a0,1
    1572:	00004097          	auipc	ra,0x4
    1576:	362080e7          	jalr	866(ra) # 58d4 <exit>

000000000000157a <exectest>:
void exectest(char *s) {
    157a:	715d                	addi	sp,sp,-80
    157c:	e486                	sd	ra,72(sp)
    157e:	e0a2                	sd	s0,64(sp)
    1580:	f84a                	sd	s2,48(sp)
    1582:	0880                	addi	s0,sp,80
    1584:	892a                	mv	s2,a0
    char *echoargv[] = {"echo", "OK", 0};
    1586:	00005797          	auipc	a5,0x5
    158a:	8ba78793          	addi	a5,a5,-1862 # 5e40 <malloc+0x13c>
    158e:	fcf43023          	sd	a5,-64(s0)
    1592:	00005797          	auipc	a5,0x5
    1596:	18e78793          	addi	a5,a5,398 # 6720 <malloc+0xa1c>
    159a:	fcf43423          	sd	a5,-56(s0)
    159e:	fc043823          	sd	zero,-48(s0)
    unlink("echo-ok");
    15a2:	00005517          	auipc	a0,0x5
    15a6:	18650513          	addi	a0,a0,390 # 6728 <malloc+0xa24>
    15aa:	00004097          	auipc	ra,0x4
    15ae:	37a080e7          	jalr	890(ra) # 5924 <unlink>
    pid = fork();
    15b2:	00004097          	auipc	ra,0x4
    15b6:	31a080e7          	jalr	794(ra) # 58cc <fork>
    if (pid < 0) {
    15ba:	04054763          	bltz	a0,1608 <exectest+0x8e>
    15be:	fc26                	sd	s1,56(sp)
    15c0:	84aa                	mv	s1,a0
    if (pid == 0) {
    15c2:	ed41                	bnez	a0,165a <exectest+0xe0>
        close(1);
    15c4:	4505                	li	a0,1
    15c6:	00004097          	auipc	ra,0x4
    15ca:	336080e7          	jalr	822(ra) # 58fc <close>
        fd = open("echo-ok", O_CREATE | O_WRONLY);
    15ce:	20100593          	li	a1,513
    15d2:	00005517          	auipc	a0,0x5
    15d6:	15650513          	addi	a0,a0,342 # 6728 <malloc+0xa24>
    15da:	00004097          	auipc	ra,0x4
    15de:	33a080e7          	jalr	826(ra) # 5914 <open>
        if (fd < 0) {
    15e2:	04054263          	bltz	a0,1626 <exectest+0xac>
        if (fd != 1) {
    15e6:	4785                	li	a5,1
    15e8:	04f50d63          	beq	a0,a5,1642 <exectest+0xc8>
            printf("%s: wrong fd\n", s);
    15ec:	85ca                	mv	a1,s2
    15ee:	00005517          	auipc	a0,0x5
    15f2:	15a50513          	addi	a0,a0,346 # 6748 <malloc+0xa44>
    15f6:	00004097          	auipc	ra,0x4
    15fa:	656080e7          	jalr	1622(ra) # 5c4c <printf>
            exit(1);
    15fe:	4505                	li	a0,1
    1600:	00004097          	auipc	ra,0x4
    1604:	2d4080e7          	jalr	724(ra) # 58d4 <exit>
    1608:	fc26                	sd	s1,56(sp)
        printf("%s: fork failed\n", s);
    160a:	85ca                	mv	a1,s2
    160c:	00005517          	auipc	a0,0x5
    1610:	08c50513          	addi	a0,a0,140 # 6698 <malloc+0x994>
    1614:	00004097          	auipc	ra,0x4
    1618:	638080e7          	jalr	1592(ra) # 5c4c <printf>
        exit(1);
    161c:	4505                	li	a0,1
    161e:	00004097          	auipc	ra,0x4
    1622:	2b6080e7          	jalr	694(ra) # 58d4 <exit>
            printf("%s: create failed\n", s);
    1626:	85ca                	mv	a1,s2
    1628:	00005517          	auipc	a0,0x5
    162c:	10850513          	addi	a0,a0,264 # 6730 <malloc+0xa2c>
    1630:	00004097          	auipc	ra,0x4
    1634:	61c080e7          	jalr	1564(ra) # 5c4c <printf>
            exit(1);
    1638:	4505                	li	a0,1
    163a:	00004097          	auipc	ra,0x4
    163e:	29a080e7          	jalr	666(ra) # 58d4 <exit>
        if (exec("echo", echoargv) < 0) {
    1642:	fc040593          	addi	a1,s0,-64
    1646:	00004517          	auipc	a0,0x4
    164a:	7fa50513          	addi	a0,a0,2042 # 5e40 <malloc+0x13c>
    164e:	00004097          	auipc	ra,0x4
    1652:	2be080e7          	jalr	702(ra) # 590c <exec>
    1656:	02054163          	bltz	a0,1678 <exectest+0xfe>
    if (wait(&xstatus) != pid) {
    165a:	fdc40513          	addi	a0,s0,-36
    165e:	00004097          	auipc	ra,0x4
    1662:	27e080e7          	jalr	638(ra) # 58dc <wait>
    1666:	02951763          	bne	a0,s1,1694 <exectest+0x11a>
    if (xstatus != 0)
    166a:	fdc42503          	lw	a0,-36(s0)
    166e:	cd0d                	beqz	a0,16a8 <exectest+0x12e>
        exit(xstatus);
    1670:	00004097          	auipc	ra,0x4
    1674:	264080e7          	jalr	612(ra) # 58d4 <exit>
            printf("%s: exec echo failed\n", s);
    1678:	85ca                	mv	a1,s2
    167a:	00005517          	auipc	a0,0x5
    167e:	0de50513          	addi	a0,a0,222 # 6758 <malloc+0xa54>
    1682:	00004097          	auipc	ra,0x4
    1686:	5ca080e7          	jalr	1482(ra) # 5c4c <printf>
            exit(1);
    168a:	4505                	li	a0,1
    168c:	00004097          	auipc	ra,0x4
    1690:	248080e7          	jalr	584(ra) # 58d4 <exit>
        printf("%s: wait failed!\n", s);
    1694:	85ca                	mv	a1,s2
    1696:	00005517          	auipc	a0,0x5
    169a:	0da50513          	addi	a0,a0,218 # 6770 <malloc+0xa6c>
    169e:	00004097          	auipc	ra,0x4
    16a2:	5ae080e7          	jalr	1454(ra) # 5c4c <printf>
    16a6:	b7d1                	j	166a <exectest+0xf0>
    fd = open("echo-ok", O_RDONLY);
    16a8:	4581                	li	a1,0
    16aa:	00005517          	auipc	a0,0x5
    16ae:	07e50513          	addi	a0,a0,126 # 6728 <malloc+0xa24>
    16b2:	00004097          	auipc	ra,0x4
    16b6:	262080e7          	jalr	610(ra) # 5914 <open>
    if (fd < 0) {
    16ba:	02054a63          	bltz	a0,16ee <exectest+0x174>
    if (read(fd, buf, 2) != 2) {
    16be:	4609                	li	a2,2
    16c0:	fb840593          	addi	a1,s0,-72
    16c4:	00004097          	auipc	ra,0x4
    16c8:	228080e7          	jalr	552(ra) # 58ec <read>
    16cc:	4789                	li	a5,2
    16ce:	02f50e63          	beq	a0,a5,170a <exectest+0x190>
        printf("%s: read failed\n", s);
    16d2:	85ca                	mv	a1,s2
    16d4:	00005517          	auipc	a0,0x5
    16d8:	b0c50513          	addi	a0,a0,-1268 # 61e0 <malloc+0x4dc>
    16dc:	00004097          	auipc	ra,0x4
    16e0:	570080e7          	jalr	1392(ra) # 5c4c <printf>
        exit(1);
    16e4:	4505                	li	a0,1
    16e6:	00004097          	auipc	ra,0x4
    16ea:	1ee080e7          	jalr	494(ra) # 58d4 <exit>
        printf("%s: open failed\n", s);
    16ee:	85ca                	mv	a1,s2
    16f0:	00005517          	auipc	a0,0x5
    16f4:	fc050513          	addi	a0,a0,-64 # 66b0 <malloc+0x9ac>
    16f8:	00004097          	auipc	ra,0x4
    16fc:	554080e7          	jalr	1364(ra) # 5c4c <printf>
        exit(1);
    1700:	4505                	li	a0,1
    1702:	00004097          	auipc	ra,0x4
    1706:	1d2080e7          	jalr	466(ra) # 58d4 <exit>
    unlink("echo-ok");
    170a:	00005517          	auipc	a0,0x5
    170e:	01e50513          	addi	a0,a0,30 # 6728 <malloc+0xa24>
    1712:	00004097          	auipc	ra,0x4
    1716:	212080e7          	jalr	530(ra) # 5924 <unlink>
    if (buf[0] == 'O' && buf[1] == 'K')
    171a:	fb844703          	lbu	a4,-72(s0)
    171e:	04f00793          	li	a5,79
    1722:	00f71863          	bne	a4,a5,1732 <exectest+0x1b8>
    1726:	fb944703          	lbu	a4,-71(s0)
    172a:	04b00793          	li	a5,75
    172e:	02f70063          	beq	a4,a5,174e <exectest+0x1d4>
        printf("%s: wrong output\n", s);
    1732:	85ca                	mv	a1,s2
    1734:	00005517          	auipc	a0,0x5
    1738:	05450513          	addi	a0,a0,84 # 6788 <malloc+0xa84>
    173c:	00004097          	auipc	ra,0x4
    1740:	510080e7          	jalr	1296(ra) # 5c4c <printf>
        exit(1);
    1744:	4505                	li	a0,1
    1746:	00004097          	auipc	ra,0x4
    174a:	18e080e7          	jalr	398(ra) # 58d4 <exit>
        exit(0);
    174e:	4501                	li	a0,0
    1750:	00004097          	auipc	ra,0x4
    1754:	184080e7          	jalr	388(ra) # 58d4 <exit>

0000000000001758 <pipe1>:
void pipe1(char *s) {
    1758:	711d                	addi	sp,sp,-96
    175a:	ec86                	sd	ra,88(sp)
    175c:	e8a2                	sd	s0,80(sp)
    175e:	fc4e                	sd	s3,56(sp)
    1760:	1080                	addi	s0,sp,96
    1762:	89aa                	mv	s3,a0
    if (pipe(fds) != 0) {
    1764:	fa840513          	addi	a0,s0,-88
    1768:	00004097          	auipc	ra,0x4
    176c:	17c080e7          	jalr	380(ra) # 58e4 <pipe>
    1770:	ed3d                	bnez	a0,17ee <pipe1+0x96>
    1772:	e4a6                	sd	s1,72(sp)
    1774:	f852                	sd	s4,48(sp)
    1776:	84aa                	mv	s1,a0
    pid = fork();
    1778:	00004097          	auipc	ra,0x4
    177c:	154080e7          	jalr	340(ra) # 58cc <fork>
    1780:	8a2a                	mv	s4,a0
    if (pid == 0) {
    1782:	c951                	beqz	a0,1816 <pipe1+0xbe>
    } else if (pid > 0) {
    1784:	18a05b63          	blez	a0,191a <pipe1+0x1c2>
    1788:	e0ca                	sd	s2,64(sp)
    178a:	f456                	sd	s5,40(sp)
        close(fds[1]);
    178c:	fac42503          	lw	a0,-84(s0)
    1790:	00004097          	auipc	ra,0x4
    1794:	16c080e7          	jalr	364(ra) # 58fc <close>
        total = 0;
    1798:	8a26                	mv	s4,s1
        cc = 1;
    179a:	4905                	li	s2,1
        while ((n = read(fds[0], buf, cc)) > 0) {
    179c:	0000ca97          	auipc	s5,0xc
    17a0:	944a8a93          	addi	s5,s5,-1724 # d0e0 <buf>
    17a4:	864a                	mv	a2,s2
    17a6:	85d6                	mv	a1,s5
    17a8:	fa842503          	lw	a0,-88(s0)
    17ac:	00004097          	auipc	ra,0x4
    17b0:	140080e7          	jalr	320(ra) # 58ec <read>
    17b4:	10a05a63          	blez	a0,18c8 <pipe1+0x170>
            for (i = 0; i < n; i++) {
    17b8:	0000c717          	auipc	a4,0xc
    17bc:	92870713          	addi	a4,a4,-1752 # d0e0 <buf>
    17c0:	00a4863b          	addw	a2,s1,a0
                if ((buf[i] & 0xff) != (seq++ & 0xff)) {
    17c4:	00074683          	lbu	a3,0(a4)
    17c8:	0ff4f793          	zext.b	a5,s1
    17cc:	2485                	addiw	s1,s1,1
    17ce:	0cf69b63          	bne	a3,a5,18a4 <pipe1+0x14c>
            for (i = 0; i < n; i++) {
    17d2:	0705                	addi	a4,a4,1
    17d4:	fec498e3          	bne	s1,a2,17c4 <pipe1+0x6c>
            total += n;
    17d8:	00aa0a3b          	addw	s4,s4,a0
            cc = cc * 2;
    17dc:	0019179b          	slliw	a5,s2,0x1
    17e0:	0007891b          	sext.w	s2,a5
            if (cc > sizeof(buf))
    17e4:	670d                	lui	a4,0x3
    17e6:	fb277fe3          	bgeu	a4,s2,17a4 <pipe1+0x4c>
                cc = sizeof(buf);
    17ea:	690d                	lui	s2,0x3
    17ec:	bf65                	j	17a4 <pipe1+0x4c>
    17ee:	e4a6                	sd	s1,72(sp)
    17f0:	e0ca                	sd	s2,64(sp)
    17f2:	f852                	sd	s4,48(sp)
    17f4:	f456                	sd	s5,40(sp)
    17f6:	f05a                	sd	s6,32(sp)
    17f8:	ec5e                	sd	s7,24(sp)
        printf("%s: pipe() failed\n", s);
    17fa:	85ce                	mv	a1,s3
    17fc:	00005517          	auipc	a0,0x5
    1800:	fa450513          	addi	a0,a0,-92 # 67a0 <malloc+0xa9c>
    1804:	00004097          	auipc	ra,0x4
    1808:	448080e7          	jalr	1096(ra) # 5c4c <printf>
        exit(1);
    180c:	4505                	li	a0,1
    180e:	00004097          	auipc	ra,0x4
    1812:	0c6080e7          	jalr	198(ra) # 58d4 <exit>
    1816:	e0ca                	sd	s2,64(sp)
    1818:	f456                	sd	s5,40(sp)
    181a:	f05a                	sd	s6,32(sp)
    181c:	ec5e                	sd	s7,24(sp)
        close(fds[0]);
    181e:	fa842503          	lw	a0,-88(s0)
    1822:	00004097          	auipc	ra,0x4
    1826:	0da080e7          	jalr	218(ra) # 58fc <close>
        for (n = 0; n < N; n++) {
    182a:	0000cb17          	auipc	s6,0xc
    182e:	8b6b0b13          	addi	s6,s6,-1866 # d0e0 <buf>
    1832:	416004bb          	negw	s1,s6
    1836:	0ff4f493          	zext.b	s1,s1
    183a:	409b0913          	addi	s2,s6,1033
            if (write(fds[1], buf, SZ) != SZ) {
    183e:	8bda                	mv	s7,s6
        for (n = 0; n < N; n++) {
    1840:	6a85                	lui	s5,0x1
    1842:	42da8a93          	addi	s5,s5,1069 # 142d <truncate3+0x7d>
void pipe1(char *s) {
    1846:	87da                	mv	a5,s6
                buf[i] = seq++;
    1848:	0097873b          	addw	a4,a5,s1
    184c:	00e78023          	sb	a4,0(a5)
            for (i = 0; i < SZ; i++)
    1850:	0785                	addi	a5,a5,1
    1852:	ff279be3          	bne	a5,s2,1848 <pipe1+0xf0>
    1856:	409a0a1b          	addiw	s4,s4,1033
            if (write(fds[1], buf, SZ) != SZ) {
    185a:	40900613          	li	a2,1033
    185e:	85de                	mv	a1,s7
    1860:	fac42503          	lw	a0,-84(s0)
    1864:	00004097          	auipc	ra,0x4
    1868:	090080e7          	jalr	144(ra) # 58f4 <write>
    186c:	40900793          	li	a5,1033
    1870:	00f51c63          	bne	a0,a5,1888 <pipe1+0x130>
        for (n = 0; n < N; n++) {
    1874:	24a5                	addiw	s1,s1,9
    1876:	0ff4f493          	zext.b	s1,s1
    187a:	fd5a16e3          	bne	s4,s5,1846 <pipe1+0xee>
        exit(0);
    187e:	4501                	li	a0,0
    1880:	00004097          	auipc	ra,0x4
    1884:	054080e7          	jalr	84(ra) # 58d4 <exit>
                printf("%s: pipe1 oops 1\n", s);
    1888:	85ce                	mv	a1,s3
    188a:	00005517          	auipc	a0,0x5
    188e:	f2e50513          	addi	a0,a0,-210 # 67b8 <malloc+0xab4>
    1892:	00004097          	auipc	ra,0x4
    1896:	3ba080e7          	jalr	954(ra) # 5c4c <printf>
                exit(1);
    189a:	4505                	li	a0,1
    189c:	00004097          	auipc	ra,0x4
    18a0:	038080e7          	jalr	56(ra) # 58d4 <exit>
                    printf("%s: pipe1 oops 2\n", s);
    18a4:	85ce                	mv	a1,s3
    18a6:	00005517          	auipc	a0,0x5
    18aa:	f2a50513          	addi	a0,a0,-214 # 67d0 <malloc+0xacc>
    18ae:	00004097          	auipc	ra,0x4
    18b2:	39e080e7          	jalr	926(ra) # 5c4c <printf>
                    return;
    18b6:	64a6                	ld	s1,72(sp)
    18b8:	6906                	ld	s2,64(sp)
    18ba:	7a42                	ld	s4,48(sp)
    18bc:	7aa2                	ld	s5,40(sp)
}
    18be:	60e6                	ld	ra,88(sp)
    18c0:	6446                	ld	s0,80(sp)
    18c2:	79e2                	ld	s3,56(sp)
    18c4:	6125                	addi	sp,sp,96
    18c6:	8082                	ret
        if (total != N * SZ) {
    18c8:	6785                	lui	a5,0x1
    18ca:	42d78793          	addi	a5,a5,1069 # 142d <truncate3+0x7d>
    18ce:	02fa0263          	beq	s4,a5,18f2 <pipe1+0x19a>
    18d2:	f05a                	sd	s6,32(sp)
    18d4:	ec5e                	sd	s7,24(sp)
            printf("%s: pipe1 oops 3 total %d\n", total);
    18d6:	85d2                	mv	a1,s4
    18d8:	00005517          	auipc	a0,0x5
    18dc:	f1050513          	addi	a0,a0,-240 # 67e8 <malloc+0xae4>
    18e0:	00004097          	auipc	ra,0x4
    18e4:	36c080e7          	jalr	876(ra) # 5c4c <printf>
            exit(1);
    18e8:	4505                	li	a0,1
    18ea:	00004097          	auipc	ra,0x4
    18ee:	fea080e7          	jalr	-22(ra) # 58d4 <exit>
    18f2:	f05a                	sd	s6,32(sp)
    18f4:	ec5e                	sd	s7,24(sp)
        close(fds[0]);
    18f6:	fa842503          	lw	a0,-88(s0)
    18fa:	00004097          	auipc	ra,0x4
    18fe:	002080e7          	jalr	2(ra) # 58fc <close>
        wait(&xstatus);
    1902:	fa440513          	addi	a0,s0,-92
    1906:	00004097          	auipc	ra,0x4
    190a:	fd6080e7          	jalr	-42(ra) # 58dc <wait>
        exit(xstatus);
    190e:	fa442503          	lw	a0,-92(s0)
    1912:	00004097          	auipc	ra,0x4
    1916:	fc2080e7          	jalr	-62(ra) # 58d4 <exit>
    191a:	e0ca                	sd	s2,64(sp)
    191c:	f456                	sd	s5,40(sp)
    191e:	f05a                	sd	s6,32(sp)
    1920:	ec5e                	sd	s7,24(sp)
        printf("%s: fork() failed\n", s);
    1922:	85ce                	mv	a1,s3
    1924:	00005517          	auipc	a0,0x5
    1928:	ee450513          	addi	a0,a0,-284 # 6808 <malloc+0xb04>
    192c:	00004097          	auipc	ra,0x4
    1930:	320080e7          	jalr	800(ra) # 5c4c <printf>
        exit(1);
    1934:	4505                	li	a0,1
    1936:	00004097          	auipc	ra,0x4
    193a:	f9e080e7          	jalr	-98(ra) # 58d4 <exit>

000000000000193e <exitwait>:
void exitwait(char *s) {
    193e:	7139                	addi	sp,sp,-64
    1940:	fc06                	sd	ra,56(sp)
    1942:	f822                	sd	s0,48(sp)
    1944:	f426                	sd	s1,40(sp)
    1946:	f04a                	sd	s2,32(sp)
    1948:	ec4e                	sd	s3,24(sp)
    194a:	e852                	sd	s4,16(sp)
    194c:	0080                	addi	s0,sp,64
    194e:	8a2a                	mv	s4,a0
    for (i = 0; i < 100; i++) {
    1950:	4901                	li	s2,0
    1952:	06400993          	li	s3,100
        pid = fork();
    1956:	00004097          	auipc	ra,0x4
    195a:	f76080e7          	jalr	-138(ra) # 58cc <fork>
    195e:	84aa                	mv	s1,a0
        if (pid < 0) {
    1960:	02054a63          	bltz	a0,1994 <exitwait+0x56>
        if (pid) {
    1964:	c151                	beqz	a0,19e8 <exitwait+0xaa>
            if (wait(&xstate) != pid) {
    1966:	fcc40513          	addi	a0,s0,-52
    196a:	00004097          	auipc	ra,0x4
    196e:	f72080e7          	jalr	-142(ra) # 58dc <wait>
    1972:	02951f63          	bne	a0,s1,19b0 <exitwait+0x72>
            if (i != xstate) {
    1976:	fcc42783          	lw	a5,-52(s0)
    197a:	05279963          	bne	a5,s2,19cc <exitwait+0x8e>
    for (i = 0; i < 100; i++) {
    197e:	2905                	addiw	s2,s2,1 # 3001 <iputtest+0x2f>
    1980:	fd391be3          	bne	s2,s3,1956 <exitwait+0x18>
}
    1984:	70e2                	ld	ra,56(sp)
    1986:	7442                	ld	s0,48(sp)
    1988:	74a2                	ld	s1,40(sp)
    198a:	7902                	ld	s2,32(sp)
    198c:	69e2                	ld	s3,24(sp)
    198e:	6a42                	ld	s4,16(sp)
    1990:	6121                	addi	sp,sp,64
    1992:	8082                	ret
            printf("%s: fork failed\n", s);
    1994:	85d2                	mv	a1,s4
    1996:	00005517          	auipc	a0,0x5
    199a:	d0250513          	addi	a0,a0,-766 # 6698 <malloc+0x994>
    199e:	00004097          	auipc	ra,0x4
    19a2:	2ae080e7          	jalr	686(ra) # 5c4c <printf>
            exit(1);
    19a6:	4505                	li	a0,1
    19a8:	00004097          	auipc	ra,0x4
    19ac:	f2c080e7          	jalr	-212(ra) # 58d4 <exit>
                printf("%s: wait wrong pid\n", s);
    19b0:	85d2                	mv	a1,s4
    19b2:	00005517          	auipc	a0,0x5
    19b6:	e6e50513          	addi	a0,a0,-402 # 6820 <malloc+0xb1c>
    19ba:	00004097          	auipc	ra,0x4
    19be:	292080e7          	jalr	658(ra) # 5c4c <printf>
                exit(1);
    19c2:	4505                	li	a0,1
    19c4:	00004097          	auipc	ra,0x4
    19c8:	f10080e7          	jalr	-240(ra) # 58d4 <exit>
                printf("%s: wait wrong exit status\n", s);
    19cc:	85d2                	mv	a1,s4
    19ce:	00005517          	auipc	a0,0x5
    19d2:	e6a50513          	addi	a0,a0,-406 # 6838 <malloc+0xb34>
    19d6:	00004097          	auipc	ra,0x4
    19da:	276080e7          	jalr	630(ra) # 5c4c <printf>
                exit(1);
    19de:	4505                	li	a0,1
    19e0:	00004097          	auipc	ra,0x4
    19e4:	ef4080e7          	jalr	-268(ra) # 58d4 <exit>
            exit(i);
    19e8:	854a                	mv	a0,s2
    19ea:	00004097          	auipc	ra,0x4
    19ee:	eea080e7          	jalr	-278(ra) # 58d4 <exit>

00000000000019f2 <twochildren>:
void twochildren(char *s) {
    19f2:	1101                	addi	sp,sp,-32
    19f4:	ec06                	sd	ra,24(sp)
    19f6:	e822                	sd	s0,16(sp)
    19f8:	e426                	sd	s1,8(sp)
    19fa:	e04a                	sd	s2,0(sp)
    19fc:	1000                	addi	s0,sp,32
    19fe:	892a                	mv	s2,a0
    1a00:	3e800493          	li	s1,1000
        int pid1 = fork();
    1a04:	00004097          	auipc	ra,0x4
    1a08:	ec8080e7          	jalr	-312(ra) # 58cc <fork>
        if (pid1 < 0) {
    1a0c:	02054c63          	bltz	a0,1a44 <twochildren+0x52>
        if (pid1 == 0) {
    1a10:	c921                	beqz	a0,1a60 <twochildren+0x6e>
            int pid2 = fork();
    1a12:	00004097          	auipc	ra,0x4
    1a16:	eba080e7          	jalr	-326(ra) # 58cc <fork>
            if (pid2 < 0) {
    1a1a:	04054763          	bltz	a0,1a68 <twochildren+0x76>
            if (pid2 == 0) {
    1a1e:	c13d                	beqz	a0,1a84 <twochildren+0x92>
                wait(0);
    1a20:	4501                	li	a0,0
    1a22:	00004097          	auipc	ra,0x4
    1a26:	eba080e7          	jalr	-326(ra) # 58dc <wait>
                wait(0);
    1a2a:	4501                	li	a0,0
    1a2c:	00004097          	auipc	ra,0x4
    1a30:	eb0080e7          	jalr	-336(ra) # 58dc <wait>
    for (int i = 0; i < 1000; i++) {
    1a34:	34fd                	addiw	s1,s1,-1
    1a36:	f4f9                	bnez	s1,1a04 <twochildren+0x12>
}
    1a38:	60e2                	ld	ra,24(sp)
    1a3a:	6442                	ld	s0,16(sp)
    1a3c:	64a2                	ld	s1,8(sp)
    1a3e:	6902                	ld	s2,0(sp)
    1a40:	6105                	addi	sp,sp,32
    1a42:	8082                	ret
            printf("%s: fork failed\n", s);
    1a44:	85ca                	mv	a1,s2
    1a46:	00005517          	auipc	a0,0x5
    1a4a:	c5250513          	addi	a0,a0,-942 # 6698 <malloc+0x994>
    1a4e:	00004097          	auipc	ra,0x4
    1a52:	1fe080e7          	jalr	510(ra) # 5c4c <printf>
            exit(1);
    1a56:	4505                	li	a0,1
    1a58:	00004097          	auipc	ra,0x4
    1a5c:	e7c080e7          	jalr	-388(ra) # 58d4 <exit>
            exit(0);
    1a60:	00004097          	auipc	ra,0x4
    1a64:	e74080e7          	jalr	-396(ra) # 58d4 <exit>
                printf("%s: fork failed\n", s);
    1a68:	85ca                	mv	a1,s2
    1a6a:	00005517          	auipc	a0,0x5
    1a6e:	c2e50513          	addi	a0,a0,-978 # 6698 <malloc+0x994>
    1a72:	00004097          	auipc	ra,0x4
    1a76:	1da080e7          	jalr	474(ra) # 5c4c <printf>
                exit(1);
    1a7a:	4505                	li	a0,1
    1a7c:	00004097          	auipc	ra,0x4
    1a80:	e58080e7          	jalr	-424(ra) # 58d4 <exit>
                exit(0);
    1a84:	00004097          	auipc	ra,0x4
    1a88:	e50080e7          	jalr	-432(ra) # 58d4 <exit>

0000000000001a8c <forkfork>:
void forkfork(char *s) {
    1a8c:	7179                	addi	sp,sp,-48
    1a8e:	f406                	sd	ra,40(sp)
    1a90:	f022                	sd	s0,32(sp)
    1a92:	ec26                	sd	s1,24(sp)
    1a94:	1800                	addi	s0,sp,48
    1a96:	84aa                	mv	s1,a0
        int pid = fork();
    1a98:	00004097          	auipc	ra,0x4
    1a9c:	e34080e7          	jalr	-460(ra) # 58cc <fork>
        if (pid < 0) {
    1aa0:	04054163          	bltz	a0,1ae2 <forkfork+0x56>
        if (pid == 0) {
    1aa4:	cd29                	beqz	a0,1afe <forkfork+0x72>
        int pid = fork();
    1aa6:	00004097          	auipc	ra,0x4
    1aaa:	e26080e7          	jalr	-474(ra) # 58cc <fork>
        if (pid < 0) {
    1aae:	02054a63          	bltz	a0,1ae2 <forkfork+0x56>
        if (pid == 0) {
    1ab2:	c531                	beqz	a0,1afe <forkfork+0x72>
        wait(&xstatus);
    1ab4:	fdc40513          	addi	a0,s0,-36
    1ab8:	00004097          	auipc	ra,0x4
    1abc:	e24080e7          	jalr	-476(ra) # 58dc <wait>
        if (xstatus != 0) {
    1ac0:	fdc42783          	lw	a5,-36(s0)
    1ac4:	ebbd                	bnez	a5,1b3a <forkfork+0xae>
        wait(&xstatus);
    1ac6:	fdc40513          	addi	a0,s0,-36
    1aca:	00004097          	auipc	ra,0x4
    1ace:	e12080e7          	jalr	-494(ra) # 58dc <wait>
        if (xstatus != 0) {
    1ad2:	fdc42783          	lw	a5,-36(s0)
    1ad6:	e3b5                	bnez	a5,1b3a <forkfork+0xae>
}
    1ad8:	70a2                	ld	ra,40(sp)
    1ada:	7402                	ld	s0,32(sp)
    1adc:	64e2                	ld	s1,24(sp)
    1ade:	6145                	addi	sp,sp,48
    1ae0:	8082                	ret
            printf("%s: fork failed", s);
    1ae2:	85a6                	mv	a1,s1
    1ae4:	00005517          	auipc	a0,0x5
    1ae8:	d7450513          	addi	a0,a0,-652 # 6858 <malloc+0xb54>
    1aec:	00004097          	auipc	ra,0x4
    1af0:	160080e7          	jalr	352(ra) # 5c4c <printf>
            exit(1);
    1af4:	4505                	li	a0,1
    1af6:	00004097          	auipc	ra,0x4
    1afa:	dde080e7          	jalr	-546(ra) # 58d4 <exit>
void forkfork(char *s) {
    1afe:	0c800493          	li	s1,200
                int pid1 = fork();
    1b02:	00004097          	auipc	ra,0x4
    1b06:	dca080e7          	jalr	-566(ra) # 58cc <fork>
                if (pid1 < 0) {
    1b0a:	00054f63          	bltz	a0,1b28 <forkfork+0x9c>
                if (pid1 == 0) {
    1b0e:	c115                	beqz	a0,1b32 <forkfork+0xa6>
                wait(0);
    1b10:	4501                	li	a0,0
    1b12:	00004097          	auipc	ra,0x4
    1b16:	dca080e7          	jalr	-566(ra) # 58dc <wait>
            for (int j = 0; j < 200; j++) {
    1b1a:	34fd                	addiw	s1,s1,-1
    1b1c:	f0fd                	bnez	s1,1b02 <forkfork+0x76>
            exit(0);
    1b1e:	4501                	li	a0,0
    1b20:	00004097          	auipc	ra,0x4
    1b24:	db4080e7          	jalr	-588(ra) # 58d4 <exit>
                    exit(1);
    1b28:	4505                	li	a0,1
    1b2a:	00004097          	auipc	ra,0x4
    1b2e:	daa080e7          	jalr	-598(ra) # 58d4 <exit>
                    exit(0);
    1b32:	00004097          	auipc	ra,0x4
    1b36:	da2080e7          	jalr	-606(ra) # 58d4 <exit>
            printf("%s: fork in child failed", s);
    1b3a:	85a6                	mv	a1,s1
    1b3c:	00005517          	auipc	a0,0x5
    1b40:	d2c50513          	addi	a0,a0,-724 # 6868 <malloc+0xb64>
    1b44:	00004097          	auipc	ra,0x4
    1b48:	108080e7          	jalr	264(ra) # 5c4c <printf>
            exit(1);
    1b4c:	4505                	li	a0,1
    1b4e:	00004097          	auipc	ra,0x4
    1b52:	d86080e7          	jalr	-634(ra) # 58d4 <exit>

0000000000001b56 <reparent2>:
void reparent2(char *s) {
    1b56:	1101                	addi	sp,sp,-32
    1b58:	ec06                	sd	ra,24(sp)
    1b5a:	e822                	sd	s0,16(sp)
    1b5c:	e426                	sd	s1,8(sp)
    1b5e:	1000                	addi	s0,sp,32
    1b60:	32000493          	li	s1,800
        int pid1 = fork();
    1b64:	00004097          	auipc	ra,0x4
    1b68:	d68080e7          	jalr	-664(ra) # 58cc <fork>
        if (pid1 < 0) {
    1b6c:	00054f63          	bltz	a0,1b8a <reparent2+0x34>
        if (pid1 == 0) {
    1b70:	c915                	beqz	a0,1ba4 <reparent2+0x4e>
        wait(0);
    1b72:	4501                	li	a0,0
    1b74:	00004097          	auipc	ra,0x4
    1b78:	d68080e7          	jalr	-664(ra) # 58dc <wait>
    for (int i = 0; i < 800; i++) {
    1b7c:	34fd                	addiw	s1,s1,-1
    1b7e:	f0fd                	bnez	s1,1b64 <reparent2+0xe>
    exit(0);
    1b80:	4501                	li	a0,0
    1b82:	00004097          	auipc	ra,0x4
    1b86:	d52080e7          	jalr	-686(ra) # 58d4 <exit>
            printf("fork failed\n");
    1b8a:	00005517          	auipc	a0,0x5
    1b8e:	f2e50513          	addi	a0,a0,-210 # 6ab8 <malloc+0xdb4>
    1b92:	00004097          	auipc	ra,0x4
    1b96:	0ba080e7          	jalr	186(ra) # 5c4c <printf>
            exit(1);
    1b9a:	4505                	li	a0,1
    1b9c:	00004097          	auipc	ra,0x4
    1ba0:	d38080e7          	jalr	-712(ra) # 58d4 <exit>
            fork();
    1ba4:	00004097          	auipc	ra,0x4
    1ba8:	d28080e7          	jalr	-728(ra) # 58cc <fork>
            fork();
    1bac:	00004097          	auipc	ra,0x4
    1bb0:	d20080e7          	jalr	-736(ra) # 58cc <fork>
            exit(0);
    1bb4:	4501                	li	a0,0
    1bb6:	00004097          	auipc	ra,0x4
    1bba:	d1e080e7          	jalr	-738(ra) # 58d4 <exit>

0000000000001bbe <createdelete>:
void createdelete(char *s) {
    1bbe:	7175                	addi	sp,sp,-144
    1bc0:	e506                	sd	ra,136(sp)
    1bc2:	e122                	sd	s0,128(sp)
    1bc4:	fca6                	sd	s1,120(sp)
    1bc6:	f8ca                	sd	s2,112(sp)
    1bc8:	f4ce                	sd	s3,104(sp)
    1bca:	f0d2                	sd	s4,96(sp)
    1bcc:	ecd6                	sd	s5,88(sp)
    1bce:	e8da                	sd	s6,80(sp)
    1bd0:	e4de                	sd	s7,72(sp)
    1bd2:	e0e2                	sd	s8,64(sp)
    1bd4:	fc66                	sd	s9,56(sp)
    1bd6:	0900                	addi	s0,sp,144
    1bd8:	8caa                	mv	s9,a0
    for (pi = 0; pi < NCHILD; pi++) {
    1bda:	4901                	li	s2,0
    1bdc:	4991                	li	s3,4
        pid = fork();
    1bde:	00004097          	auipc	ra,0x4
    1be2:	cee080e7          	jalr	-786(ra) # 58cc <fork>
    1be6:	84aa                	mv	s1,a0
        if (pid < 0) {
    1be8:	02054f63          	bltz	a0,1c26 <createdelete+0x68>
        if (pid == 0) {
    1bec:	c939                	beqz	a0,1c42 <createdelete+0x84>
    for (pi = 0; pi < NCHILD; pi++) {
    1bee:	2905                	addiw	s2,s2,1
    1bf0:	ff3917e3          	bne	s2,s3,1bde <createdelete+0x20>
    1bf4:	4491                	li	s1,4
        wait(&xstatus);
    1bf6:	f7c40513          	addi	a0,s0,-132
    1bfa:	00004097          	auipc	ra,0x4
    1bfe:	ce2080e7          	jalr	-798(ra) # 58dc <wait>
        if (xstatus != 0)
    1c02:	f7c42903          	lw	s2,-132(s0)
    1c06:	0e091263          	bnez	s2,1cea <createdelete+0x12c>
    for (pi = 0; pi < NCHILD; pi++) {
    1c0a:	34fd                	addiw	s1,s1,-1
    1c0c:	f4ed                	bnez	s1,1bf6 <createdelete+0x38>
    name[0] = name[1] = name[2] = 0;
    1c0e:	f8040123          	sb	zero,-126(s0)
    1c12:	03000993          	li	s3,48
    1c16:	5a7d                	li	s4,-1
    1c18:	07000c13          	li	s8,112
            if ((i == 0 || i >= N / 2) && fd < 0) {
    1c1c:	4b25                	li	s6,9
            } else if ((i >= 1 && i < N / 2) && fd >= 0) {
    1c1e:	4ba1                	li	s7,8
        for (pi = 0; pi < NCHILD; pi++) {
    1c20:	07400a93          	li	s5,116
    1c24:	a28d                	j	1d86 <createdelete+0x1c8>
            printf("fork failed\n", s);
    1c26:	85e6                	mv	a1,s9
    1c28:	00005517          	auipc	a0,0x5
    1c2c:	e9050513          	addi	a0,a0,-368 # 6ab8 <malloc+0xdb4>
    1c30:	00004097          	auipc	ra,0x4
    1c34:	01c080e7          	jalr	28(ra) # 5c4c <printf>
            exit(1);
    1c38:	4505                	li	a0,1
    1c3a:	00004097          	auipc	ra,0x4
    1c3e:	c9a080e7          	jalr	-870(ra) # 58d4 <exit>
            name[0] = 'p' + pi;
    1c42:	0709091b          	addiw	s2,s2,112
    1c46:	f9240023          	sb	s2,-128(s0)
            name[2] = '\0';
    1c4a:	f8040123          	sb	zero,-126(s0)
            for (i = 0; i < N; i++) {
    1c4e:	4951                	li	s2,20
    1c50:	a015                	j	1c74 <createdelete+0xb6>
                    printf("%s: create failed\n", s);
    1c52:	85e6                	mv	a1,s9
    1c54:	00005517          	auipc	a0,0x5
    1c58:	adc50513          	addi	a0,a0,-1316 # 6730 <malloc+0xa2c>
    1c5c:	00004097          	auipc	ra,0x4
    1c60:	ff0080e7          	jalr	-16(ra) # 5c4c <printf>
                    exit(1);
    1c64:	4505                	li	a0,1
    1c66:	00004097          	auipc	ra,0x4
    1c6a:	c6e080e7          	jalr	-914(ra) # 58d4 <exit>
            for (i = 0; i < N; i++) {
    1c6e:	2485                	addiw	s1,s1,1
    1c70:	07248863          	beq	s1,s2,1ce0 <createdelete+0x122>
                name[1] = '0' + i;
    1c74:	0304879b          	addiw	a5,s1,48
    1c78:	f8f400a3          	sb	a5,-127(s0)
                fd = open(name, O_CREATE | O_RDWR);
    1c7c:	20200593          	li	a1,514
    1c80:	f8040513          	addi	a0,s0,-128
    1c84:	00004097          	auipc	ra,0x4
    1c88:	c90080e7          	jalr	-880(ra) # 5914 <open>
                if (fd < 0) {
    1c8c:	fc0543e3          	bltz	a0,1c52 <createdelete+0x94>
                close(fd);
    1c90:	00004097          	auipc	ra,0x4
    1c94:	c6c080e7          	jalr	-916(ra) # 58fc <close>
                if (i > 0 && (i % 2) == 0) {
    1c98:	12905763          	blez	s1,1dc6 <createdelete+0x208>
    1c9c:	0014f793          	andi	a5,s1,1
    1ca0:	f7f9                	bnez	a5,1c6e <createdelete+0xb0>
                    name[1] = '0' + (i / 2);
    1ca2:	01f4d79b          	srliw	a5,s1,0x1f
    1ca6:	9fa5                	addw	a5,a5,s1
    1ca8:	4017d79b          	sraiw	a5,a5,0x1
    1cac:	0307879b          	addiw	a5,a5,48
    1cb0:	f8f400a3          	sb	a5,-127(s0)
                    if (unlink(name) < 0) {
    1cb4:	f8040513          	addi	a0,s0,-128
    1cb8:	00004097          	auipc	ra,0x4
    1cbc:	c6c080e7          	jalr	-916(ra) # 5924 <unlink>
    1cc0:	fa0557e3          	bgez	a0,1c6e <createdelete+0xb0>
                        printf("%s: unlink failed\n", s);
    1cc4:	85e6                	mv	a1,s9
    1cc6:	00005517          	auipc	a0,0x5
    1cca:	bc250513          	addi	a0,a0,-1086 # 6888 <malloc+0xb84>
    1cce:	00004097          	auipc	ra,0x4
    1cd2:	f7e080e7          	jalr	-130(ra) # 5c4c <printf>
                        exit(1);
    1cd6:	4505                	li	a0,1
    1cd8:	00004097          	auipc	ra,0x4
    1cdc:	bfc080e7          	jalr	-1028(ra) # 58d4 <exit>
            exit(0);
    1ce0:	4501                	li	a0,0
    1ce2:	00004097          	auipc	ra,0x4
    1ce6:	bf2080e7          	jalr	-1038(ra) # 58d4 <exit>
            exit(1);
    1cea:	4505                	li	a0,1
    1cec:	00004097          	auipc	ra,0x4
    1cf0:	be8080e7          	jalr	-1048(ra) # 58d4 <exit>
                printf("%s: oops createdelete %s didn't exist\n", s, name);
    1cf4:	f8040613          	addi	a2,s0,-128
    1cf8:	85e6                	mv	a1,s9
    1cfa:	00005517          	auipc	a0,0x5
    1cfe:	ba650513          	addi	a0,a0,-1114 # 68a0 <malloc+0xb9c>
    1d02:	00004097          	auipc	ra,0x4
    1d06:	f4a080e7          	jalr	-182(ra) # 5c4c <printf>
                exit(1);
    1d0a:	4505                	li	a0,1
    1d0c:	00004097          	auipc	ra,0x4
    1d10:	bc8080e7          	jalr	-1080(ra) # 58d4 <exit>
            } else if ((i >= 1 && i < N / 2) && fd >= 0) {
    1d14:	034bff63          	bgeu	s7,s4,1d52 <createdelete+0x194>
            if (fd >= 0)
    1d18:	02055863          	bgez	a0,1d48 <createdelete+0x18a>
        for (pi = 0; pi < NCHILD; pi++) {
    1d1c:	2485                	addiw	s1,s1,1
    1d1e:	0ff4f493          	zext.b	s1,s1
    1d22:	05548a63          	beq	s1,s5,1d76 <createdelete+0x1b8>
            name[0] = 'p' + pi;
    1d26:	f8940023          	sb	s1,-128(s0)
            name[1] = '0' + i;
    1d2a:	f93400a3          	sb	s3,-127(s0)
            fd = open(name, 0);
    1d2e:	4581                	li	a1,0
    1d30:	f8040513          	addi	a0,s0,-128
    1d34:	00004097          	auipc	ra,0x4
    1d38:	be0080e7          	jalr	-1056(ra) # 5914 <open>
            if ((i == 0 || i >= N / 2) && fd < 0) {
    1d3c:	00090463          	beqz	s2,1d44 <createdelete+0x186>
    1d40:	fd2b5ae3          	bge	s6,s2,1d14 <createdelete+0x156>
    1d44:	fa0548e3          	bltz	a0,1cf4 <createdelete+0x136>
                close(fd);
    1d48:	00004097          	auipc	ra,0x4
    1d4c:	bb4080e7          	jalr	-1100(ra) # 58fc <close>
    1d50:	b7f1                	j	1d1c <createdelete+0x15e>
            } else if ((i >= 1 && i < N / 2) && fd >= 0) {
    1d52:	fc0545e3          	bltz	a0,1d1c <createdelete+0x15e>
                printf("%s: oops createdelete %s did exist\n", s, name);
    1d56:	f8040613          	addi	a2,s0,-128
    1d5a:	85e6                	mv	a1,s9
    1d5c:	00005517          	auipc	a0,0x5
    1d60:	b6c50513          	addi	a0,a0,-1172 # 68c8 <malloc+0xbc4>
    1d64:	00004097          	auipc	ra,0x4
    1d68:	ee8080e7          	jalr	-280(ra) # 5c4c <printf>
                exit(1);
    1d6c:	4505                	li	a0,1
    1d6e:	00004097          	auipc	ra,0x4
    1d72:	b66080e7          	jalr	-1178(ra) # 58d4 <exit>
    for (i = 0; i < N; i++) {
    1d76:	2905                	addiw	s2,s2,1
    1d78:	2a05                	addiw	s4,s4,1
    1d7a:	2985                	addiw	s3,s3,1
    1d7c:	0ff9f993          	zext.b	s3,s3
    1d80:	47d1                	li	a5,20
    1d82:	02f90a63          	beq	s2,a5,1db6 <createdelete+0x1f8>
        for (pi = 0; pi < NCHILD; pi++) {
    1d86:	84e2                	mv	s1,s8
    1d88:	bf79                	j	1d26 <createdelete+0x168>
    for (i = 0; i < N; i++) {
    1d8a:	2905                	addiw	s2,s2,1
    1d8c:	0ff97913          	zext.b	s2,s2
    1d90:	2985                	addiw	s3,s3,1
    1d92:	0ff9f993          	zext.b	s3,s3
    1d96:	03490a63          	beq	s2,s4,1dca <createdelete+0x20c>
    name[0] = name[1] = name[2] = 0;
    1d9a:	84d6                	mv	s1,s5
            name[0] = 'p' + i;
    1d9c:	f9240023          	sb	s2,-128(s0)
            name[1] = '0' + i;
    1da0:	f93400a3          	sb	s3,-127(s0)
            unlink(name);
    1da4:	f8040513          	addi	a0,s0,-128
    1da8:	00004097          	auipc	ra,0x4
    1dac:	b7c080e7          	jalr	-1156(ra) # 5924 <unlink>
        for (pi = 0; pi < NCHILD; pi++) {
    1db0:	34fd                	addiw	s1,s1,-1
    1db2:	f4ed                	bnez	s1,1d9c <createdelete+0x1de>
    1db4:	bfd9                	j	1d8a <createdelete+0x1cc>
    1db6:	03000993          	li	s3,48
    1dba:	07000913          	li	s2,112
    name[0] = name[1] = name[2] = 0;
    1dbe:	4a91                	li	s5,4
    for (i = 0; i < N; i++) {
    1dc0:	08400a13          	li	s4,132
    1dc4:	bfd9                	j	1d9a <createdelete+0x1dc>
            for (i = 0; i < N; i++) {
    1dc6:	2485                	addiw	s1,s1,1
    1dc8:	b575                	j	1c74 <createdelete+0xb6>
}
    1dca:	60aa                	ld	ra,136(sp)
    1dcc:	640a                	ld	s0,128(sp)
    1dce:	74e6                	ld	s1,120(sp)
    1dd0:	7946                	ld	s2,112(sp)
    1dd2:	79a6                	ld	s3,104(sp)
    1dd4:	7a06                	ld	s4,96(sp)
    1dd6:	6ae6                	ld	s5,88(sp)
    1dd8:	6b46                	ld	s6,80(sp)
    1dda:	6ba6                	ld	s7,72(sp)
    1ddc:	6c06                	ld	s8,64(sp)
    1dde:	7ce2                	ld	s9,56(sp)
    1de0:	6149                	addi	sp,sp,144
    1de2:	8082                	ret

0000000000001de4 <linkunlink>:
void linkunlink(char *s) {
    1de4:	711d                	addi	sp,sp,-96
    1de6:	ec86                	sd	ra,88(sp)
    1de8:	e8a2                	sd	s0,80(sp)
    1dea:	e4a6                	sd	s1,72(sp)
    1dec:	e0ca                	sd	s2,64(sp)
    1dee:	fc4e                	sd	s3,56(sp)
    1df0:	f852                	sd	s4,48(sp)
    1df2:	f456                	sd	s5,40(sp)
    1df4:	f05a                	sd	s6,32(sp)
    1df6:	ec5e                	sd	s7,24(sp)
    1df8:	e862                	sd	s8,16(sp)
    1dfa:	e466                	sd	s9,8(sp)
    1dfc:	1080                	addi	s0,sp,96
    1dfe:	84aa                	mv	s1,a0
    unlink("x");
    1e00:	00004517          	auipc	a0,0x4
    1e04:	0b050513          	addi	a0,a0,176 # 5eb0 <malloc+0x1ac>
    1e08:	00004097          	auipc	ra,0x4
    1e0c:	b1c080e7          	jalr	-1252(ra) # 5924 <unlink>
    pid = fork();
    1e10:	00004097          	auipc	ra,0x4
    1e14:	abc080e7          	jalr	-1348(ra) # 58cc <fork>
    if (pid < 0) {
    1e18:	02054b63          	bltz	a0,1e4e <linkunlink+0x6a>
    1e1c:	8caa                	mv	s9,a0
    unsigned int x = (pid ? 1 : 97);
    1e1e:	06100913          	li	s2,97
    1e22:	c111                	beqz	a0,1e26 <linkunlink+0x42>
    1e24:	4905                	li	s2,1
    1e26:	06400493          	li	s1,100
        x = x * 1103515245 + 12345;
    1e2a:	41c65a37          	lui	s4,0x41c65
    1e2e:	e6da0a1b          	addiw	s4,s4,-403 # 41c64e6d <__BSS_END__+0x41c54d7d>
    1e32:	698d                	lui	s3,0x3
    1e34:	0399899b          	addiw	s3,s3,57 # 3039 <iputtest+0x67>
        if ((x % 3) == 0) {
    1e38:	4a8d                	li	s5,3
        } else if ((x % 3) == 1) {
    1e3a:	4b85                	li	s7,1
            unlink("x");
    1e3c:	00004b17          	auipc	s6,0x4
    1e40:	074b0b13          	addi	s6,s6,116 # 5eb0 <malloc+0x1ac>
            link("cat", "x");
    1e44:	00005c17          	auipc	s8,0x5
    1e48:	aacc0c13          	addi	s8,s8,-1364 # 68f0 <malloc+0xbec>
    1e4c:	a825                	j	1e84 <linkunlink+0xa0>
        printf("%s: fork failed\n", s);
    1e4e:	85a6                	mv	a1,s1
    1e50:	00005517          	auipc	a0,0x5
    1e54:	84850513          	addi	a0,a0,-1976 # 6698 <malloc+0x994>
    1e58:	00004097          	auipc	ra,0x4
    1e5c:	df4080e7          	jalr	-524(ra) # 5c4c <printf>
        exit(1);
    1e60:	4505                	li	a0,1
    1e62:	00004097          	auipc	ra,0x4
    1e66:	a72080e7          	jalr	-1422(ra) # 58d4 <exit>
            close(open("x", O_RDWR | O_CREATE));
    1e6a:	20200593          	li	a1,514
    1e6e:	855a                	mv	a0,s6
    1e70:	00004097          	auipc	ra,0x4
    1e74:	aa4080e7          	jalr	-1372(ra) # 5914 <open>
    1e78:	00004097          	auipc	ra,0x4
    1e7c:	a84080e7          	jalr	-1404(ra) # 58fc <close>
    for (i = 0; i < 100; i++) {
    1e80:	34fd                	addiw	s1,s1,-1
    1e82:	c895                	beqz	s1,1eb6 <linkunlink+0xd2>
        x = x * 1103515245 + 12345;
    1e84:	034907bb          	mulw	a5,s2,s4
    1e88:	013787bb          	addw	a5,a5,s3
    1e8c:	0007891b          	sext.w	s2,a5
        if ((x % 3) == 0) {
    1e90:	0357f7bb          	remuw	a5,a5,s5
    1e94:	2781                	sext.w	a5,a5
    1e96:	dbf1                	beqz	a5,1e6a <linkunlink+0x86>
        } else if ((x % 3) == 1) {
    1e98:	01778863          	beq	a5,s7,1ea8 <linkunlink+0xc4>
            unlink("x");
    1e9c:	855a                	mv	a0,s6
    1e9e:	00004097          	auipc	ra,0x4
    1ea2:	a86080e7          	jalr	-1402(ra) # 5924 <unlink>
    1ea6:	bfe9                	j	1e80 <linkunlink+0x9c>
            link("cat", "x");
    1ea8:	85da                	mv	a1,s6
    1eaa:	8562                	mv	a0,s8
    1eac:	00004097          	auipc	ra,0x4
    1eb0:	a88080e7          	jalr	-1400(ra) # 5934 <link>
    1eb4:	b7f1                	j	1e80 <linkunlink+0x9c>
    if (pid)
    1eb6:	020c8463          	beqz	s9,1ede <linkunlink+0xfa>
        wait(0);
    1eba:	4501                	li	a0,0
    1ebc:	00004097          	auipc	ra,0x4
    1ec0:	a20080e7          	jalr	-1504(ra) # 58dc <wait>
}
    1ec4:	60e6                	ld	ra,88(sp)
    1ec6:	6446                	ld	s0,80(sp)
    1ec8:	64a6                	ld	s1,72(sp)
    1eca:	6906                	ld	s2,64(sp)
    1ecc:	79e2                	ld	s3,56(sp)
    1ece:	7a42                	ld	s4,48(sp)
    1ed0:	7aa2                	ld	s5,40(sp)
    1ed2:	7b02                	ld	s6,32(sp)
    1ed4:	6be2                	ld	s7,24(sp)
    1ed6:	6c42                	ld	s8,16(sp)
    1ed8:	6ca2                	ld	s9,8(sp)
    1eda:	6125                	addi	sp,sp,96
    1edc:	8082                	ret
        exit(0);
    1ede:	4501                	li	a0,0
    1ee0:	00004097          	auipc	ra,0x4
    1ee4:	9f4080e7          	jalr	-1548(ra) # 58d4 <exit>

0000000000001ee8 <manywrites>:
void manywrites(char *s) {
    1ee8:	711d                	addi	sp,sp,-96
    1eea:	ec86                	sd	ra,88(sp)
    1eec:	e8a2                	sd	s0,80(sp)
    1eee:	e4a6                	sd	s1,72(sp)
    1ef0:	e0ca                	sd	s2,64(sp)
    1ef2:	fc4e                	sd	s3,56(sp)
    1ef4:	f456                	sd	s5,40(sp)
    1ef6:	1080                	addi	s0,sp,96
    1ef8:	8aaa                	mv	s5,a0
    for (int ci = 0; ci < nchildren; ci++) {
    1efa:	4981                	li	s3,0
    1efc:	4911                	li	s2,4
        int pid = fork();
    1efe:	00004097          	auipc	ra,0x4
    1f02:	9ce080e7          	jalr	-1586(ra) # 58cc <fork>
    1f06:	84aa                	mv	s1,a0
        if (pid < 0) {
    1f08:	02054d63          	bltz	a0,1f42 <manywrites+0x5a>
        if (pid == 0) {
    1f0c:	c939                	beqz	a0,1f62 <manywrites+0x7a>
    for (int ci = 0; ci < nchildren; ci++) {
    1f0e:	2985                	addiw	s3,s3,1
    1f10:	ff2997e3          	bne	s3,s2,1efe <manywrites+0x16>
    1f14:	f852                	sd	s4,48(sp)
    1f16:	f05a                	sd	s6,32(sp)
    1f18:	ec5e                	sd	s7,24(sp)
    1f1a:	4491                	li	s1,4
        int st = 0;
    1f1c:	fa042423          	sw	zero,-88(s0)
        wait(&st);
    1f20:	fa840513          	addi	a0,s0,-88
    1f24:	00004097          	auipc	ra,0x4
    1f28:	9b8080e7          	jalr	-1608(ra) # 58dc <wait>
        if (st != 0)
    1f2c:	fa842503          	lw	a0,-88(s0)
    1f30:	10051463          	bnez	a0,2038 <manywrites+0x150>
    for (int ci = 0; ci < nchildren; ci++) {
    1f34:	34fd                	addiw	s1,s1,-1
    1f36:	f0fd                	bnez	s1,1f1c <manywrites+0x34>
    exit(0);
    1f38:	4501                	li	a0,0
    1f3a:	00004097          	auipc	ra,0x4
    1f3e:	99a080e7          	jalr	-1638(ra) # 58d4 <exit>
    1f42:	f852                	sd	s4,48(sp)
    1f44:	f05a                	sd	s6,32(sp)
    1f46:	ec5e                	sd	s7,24(sp)
            printf("fork failed\n");
    1f48:	00005517          	auipc	a0,0x5
    1f4c:	b7050513          	addi	a0,a0,-1168 # 6ab8 <malloc+0xdb4>
    1f50:	00004097          	auipc	ra,0x4
    1f54:	cfc080e7          	jalr	-772(ra) # 5c4c <printf>
            exit(1);
    1f58:	4505                	li	a0,1
    1f5a:	00004097          	auipc	ra,0x4
    1f5e:	97a080e7          	jalr	-1670(ra) # 58d4 <exit>
    1f62:	f852                	sd	s4,48(sp)
    1f64:	f05a                	sd	s6,32(sp)
    1f66:	ec5e                	sd	s7,24(sp)
            name[0] = 'b';
    1f68:	06200793          	li	a5,98
    1f6c:	faf40423          	sb	a5,-88(s0)
            name[1] = 'a' + ci;
    1f70:	0619879b          	addiw	a5,s3,97
    1f74:	faf404a3          	sb	a5,-87(s0)
            name[2] = '\0';
    1f78:	fa040523          	sb	zero,-86(s0)
            unlink(name);
    1f7c:	fa840513          	addi	a0,s0,-88
    1f80:	00004097          	auipc	ra,0x4
    1f84:	9a4080e7          	jalr	-1628(ra) # 5924 <unlink>
    1f88:	4bf9                	li	s7,30
                    int cc = write(fd, buf, sz);
    1f8a:	0000bb17          	auipc	s6,0xb
    1f8e:	156b0b13          	addi	s6,s6,342 # d0e0 <buf>
                for (int i = 0; i < ci + 1; i++) {
    1f92:	8a26                	mv	s4,s1
    1f94:	0209ce63          	bltz	s3,1fd0 <manywrites+0xe8>
                    int fd = open(name, O_CREATE | O_RDWR);
    1f98:	20200593          	li	a1,514
    1f9c:	fa840513          	addi	a0,s0,-88
    1fa0:	00004097          	auipc	ra,0x4
    1fa4:	974080e7          	jalr	-1676(ra) # 5914 <open>
    1fa8:	892a                	mv	s2,a0
                    if (fd < 0) {
    1faa:	04054763          	bltz	a0,1ff8 <manywrites+0x110>
                    int cc = write(fd, buf, sz);
    1fae:	660d                	lui	a2,0x3
    1fb0:	85da                	mv	a1,s6
    1fb2:	00004097          	auipc	ra,0x4
    1fb6:	942080e7          	jalr	-1726(ra) # 58f4 <write>
                    if (cc != sz) {
    1fba:	678d                	lui	a5,0x3
    1fbc:	04f51e63          	bne	a0,a5,2018 <manywrites+0x130>
                    close(fd);
    1fc0:	854a                	mv	a0,s2
    1fc2:	00004097          	auipc	ra,0x4
    1fc6:	93a080e7          	jalr	-1734(ra) # 58fc <close>
                for (int i = 0; i < ci + 1; i++) {
    1fca:	2a05                	addiw	s4,s4,1
    1fcc:	fd49d6e3          	bge	s3,s4,1f98 <manywrites+0xb0>
                unlink(name);
    1fd0:	fa840513          	addi	a0,s0,-88
    1fd4:	00004097          	auipc	ra,0x4
    1fd8:	950080e7          	jalr	-1712(ra) # 5924 <unlink>
            for (int iters = 0; iters < howmany; iters++) {
    1fdc:	3bfd                	addiw	s7,s7,-1
    1fde:	fa0b9ae3          	bnez	s7,1f92 <manywrites+0xaa>
            unlink(name);
    1fe2:	fa840513          	addi	a0,s0,-88
    1fe6:	00004097          	auipc	ra,0x4
    1fea:	93e080e7          	jalr	-1730(ra) # 5924 <unlink>
            exit(0);
    1fee:	4501                	li	a0,0
    1ff0:	00004097          	auipc	ra,0x4
    1ff4:	8e4080e7          	jalr	-1820(ra) # 58d4 <exit>
                        printf("%s: cannot create %s\n", s, name);
    1ff8:	fa840613          	addi	a2,s0,-88
    1ffc:	85d6                	mv	a1,s5
    1ffe:	00005517          	auipc	a0,0x5
    2002:	8fa50513          	addi	a0,a0,-1798 # 68f8 <malloc+0xbf4>
    2006:	00004097          	auipc	ra,0x4
    200a:	c46080e7          	jalr	-954(ra) # 5c4c <printf>
                        exit(1);
    200e:	4505                	li	a0,1
    2010:	00004097          	auipc	ra,0x4
    2014:	8c4080e7          	jalr	-1852(ra) # 58d4 <exit>
                        printf("%s: write(%d) ret %d\n", s, sz, cc);
    2018:	86aa                	mv	a3,a0
    201a:	660d                	lui	a2,0x3
    201c:	85d6                	mv	a1,s5
    201e:	00004517          	auipc	a0,0x4
    2022:	ef250513          	addi	a0,a0,-270 # 5f10 <malloc+0x20c>
    2026:	00004097          	auipc	ra,0x4
    202a:	c26080e7          	jalr	-986(ra) # 5c4c <printf>
                        exit(1);
    202e:	4505                	li	a0,1
    2030:	00004097          	auipc	ra,0x4
    2034:	8a4080e7          	jalr	-1884(ra) # 58d4 <exit>
            exit(st);
    2038:	00004097          	auipc	ra,0x4
    203c:	89c080e7          	jalr	-1892(ra) # 58d4 <exit>

0000000000002040 <forktest>:
void forktest(char *s) {
    2040:	7179                	addi	sp,sp,-48
    2042:	f406                	sd	ra,40(sp)
    2044:	f022                	sd	s0,32(sp)
    2046:	ec26                	sd	s1,24(sp)
    2048:	e84a                	sd	s2,16(sp)
    204a:	e44e                	sd	s3,8(sp)
    204c:	1800                	addi	s0,sp,48
    204e:	89aa                	mv	s3,a0
    for (n = 0; n < N; n++) {
    2050:	4481                	li	s1,0
    2052:	3e800913          	li	s2,1000
        pid = fork();
    2056:	00004097          	auipc	ra,0x4
    205a:	876080e7          	jalr	-1930(ra) # 58cc <fork>
        if (pid < 0)
    205e:	08054263          	bltz	a0,20e2 <forktest+0xa2>
        if (pid == 0)
    2062:	c115                	beqz	a0,2086 <forktest+0x46>
    for (n = 0; n < N; n++) {
    2064:	2485                	addiw	s1,s1,1
    2066:	ff2498e3          	bne	s1,s2,2056 <forktest+0x16>
        printf("%s: fork claimed to work 1000 times!\n", s);
    206a:	85ce                	mv	a1,s3
    206c:	00005517          	auipc	a0,0x5
    2070:	8ec50513          	addi	a0,a0,-1812 # 6958 <malloc+0xc54>
    2074:	00004097          	auipc	ra,0x4
    2078:	bd8080e7          	jalr	-1064(ra) # 5c4c <printf>
        exit(1);
    207c:	4505                	li	a0,1
    207e:	00004097          	auipc	ra,0x4
    2082:	856080e7          	jalr	-1962(ra) # 58d4 <exit>
            exit(0);
    2086:	00004097          	auipc	ra,0x4
    208a:	84e080e7          	jalr	-1970(ra) # 58d4 <exit>
        printf("%s: no fork at all!\n", s);
    208e:	85ce                	mv	a1,s3
    2090:	00005517          	auipc	a0,0x5
    2094:	88050513          	addi	a0,a0,-1920 # 6910 <malloc+0xc0c>
    2098:	00004097          	auipc	ra,0x4
    209c:	bb4080e7          	jalr	-1100(ra) # 5c4c <printf>
        exit(1);
    20a0:	4505                	li	a0,1
    20a2:	00004097          	auipc	ra,0x4
    20a6:	832080e7          	jalr	-1998(ra) # 58d4 <exit>
            printf("%s: wait stopped early\n", s);
    20aa:	85ce                	mv	a1,s3
    20ac:	00005517          	auipc	a0,0x5
    20b0:	87c50513          	addi	a0,a0,-1924 # 6928 <malloc+0xc24>
    20b4:	00004097          	auipc	ra,0x4
    20b8:	b98080e7          	jalr	-1128(ra) # 5c4c <printf>
            exit(1);
    20bc:	4505                	li	a0,1
    20be:	00004097          	auipc	ra,0x4
    20c2:	816080e7          	jalr	-2026(ra) # 58d4 <exit>
        printf("%s: wait got too many\n", s);
    20c6:	85ce                	mv	a1,s3
    20c8:	00005517          	auipc	a0,0x5
    20cc:	87850513          	addi	a0,a0,-1928 # 6940 <malloc+0xc3c>
    20d0:	00004097          	auipc	ra,0x4
    20d4:	b7c080e7          	jalr	-1156(ra) # 5c4c <printf>
        exit(1);
    20d8:	4505                	li	a0,1
    20da:	00003097          	auipc	ra,0x3
    20de:	7fa080e7          	jalr	2042(ra) # 58d4 <exit>
    if (n == 0) {
    20e2:	d4d5                	beqz	s1,208e <forktest+0x4e>
    for (; n > 0; n--) {
    20e4:	00905b63          	blez	s1,20fa <forktest+0xba>
        if (wait(0) < 0) {
    20e8:	4501                	li	a0,0
    20ea:	00003097          	auipc	ra,0x3
    20ee:	7f2080e7          	jalr	2034(ra) # 58dc <wait>
    20f2:	fa054ce3          	bltz	a0,20aa <forktest+0x6a>
    for (; n > 0; n--) {
    20f6:	34fd                	addiw	s1,s1,-1
    20f8:	f8e5                	bnez	s1,20e8 <forktest+0xa8>
    if (wait(0) != -1) {
    20fa:	4501                	li	a0,0
    20fc:	00003097          	auipc	ra,0x3
    2100:	7e0080e7          	jalr	2016(ra) # 58dc <wait>
    2104:	57fd                	li	a5,-1
    2106:	fcf510e3          	bne	a0,a5,20c6 <forktest+0x86>
}
    210a:	70a2                	ld	ra,40(sp)
    210c:	7402                	ld	s0,32(sp)
    210e:	64e2                	ld	s1,24(sp)
    2110:	6942                	ld	s2,16(sp)
    2112:	69a2                	ld	s3,8(sp)
    2114:	6145                	addi	sp,sp,48
    2116:	8082                	ret

0000000000002118 <kernmem>:
void kernmem(char *s) {
    2118:	715d                	addi	sp,sp,-80
    211a:	e486                	sd	ra,72(sp)
    211c:	e0a2                	sd	s0,64(sp)
    211e:	fc26                	sd	s1,56(sp)
    2120:	f84a                	sd	s2,48(sp)
    2122:	f44e                	sd	s3,40(sp)
    2124:	f052                	sd	s4,32(sp)
    2126:	ec56                	sd	s5,24(sp)
    2128:	0880                	addi	s0,sp,80
    212a:	8aaa                	mv	s5,a0
    for (a = (char *)(KERNBASE); a < (char *)(KERNBASE + 2000000); a += 50000) {
    212c:	4485                	li	s1,1
    212e:	04fe                	slli	s1,s1,0x1f
        if (xstatus != -1) // did kernel kill child?
    2130:	5a7d                	li	s4,-1
    for (a = (char *)(KERNBASE); a < (char *)(KERNBASE + 2000000); a += 50000) {
    2132:	69b1                	lui	s3,0xc
    2134:	35098993          	addi	s3,s3,848 # c350 <uninit+0x1980>
    2138:	1003d937          	lui	s2,0x1003d
    213c:	090e                	slli	s2,s2,0x3
    213e:	48090913          	addi	s2,s2,1152 # 1003d480 <__BSS_END__+0x1002d390>
        pid = fork();
    2142:	00003097          	auipc	ra,0x3
    2146:	78a080e7          	jalr	1930(ra) # 58cc <fork>
        if (pid < 0) {
    214a:	02054963          	bltz	a0,217c <kernmem+0x64>
        if (pid == 0) {
    214e:	c529                	beqz	a0,2198 <kernmem+0x80>
        wait(&xstatus);
    2150:	fbc40513          	addi	a0,s0,-68
    2154:	00003097          	auipc	ra,0x3
    2158:	788080e7          	jalr	1928(ra) # 58dc <wait>
        if (xstatus != -1) // did kernel kill child?
    215c:	fbc42783          	lw	a5,-68(s0)
    2160:	05479d63          	bne	a5,s4,21ba <kernmem+0xa2>
    for (a = (char *)(KERNBASE); a < (char *)(KERNBASE + 2000000); a += 50000) {
    2164:	94ce                	add	s1,s1,s3
    2166:	fd249ee3          	bne	s1,s2,2142 <kernmem+0x2a>
}
    216a:	60a6                	ld	ra,72(sp)
    216c:	6406                	ld	s0,64(sp)
    216e:	74e2                	ld	s1,56(sp)
    2170:	7942                	ld	s2,48(sp)
    2172:	79a2                	ld	s3,40(sp)
    2174:	7a02                	ld	s4,32(sp)
    2176:	6ae2                	ld	s5,24(sp)
    2178:	6161                	addi	sp,sp,80
    217a:	8082                	ret
            printf("%s: fork failed\n", s);
    217c:	85d6                	mv	a1,s5
    217e:	00004517          	auipc	a0,0x4
    2182:	51a50513          	addi	a0,a0,1306 # 6698 <malloc+0x994>
    2186:	00004097          	auipc	ra,0x4
    218a:	ac6080e7          	jalr	-1338(ra) # 5c4c <printf>
            exit(1);
    218e:	4505                	li	a0,1
    2190:	00003097          	auipc	ra,0x3
    2194:	744080e7          	jalr	1860(ra) # 58d4 <exit>
            printf("%s: oops could read %x = %x\n", s, a, *a);
    2198:	0004c683          	lbu	a3,0(s1)
    219c:	8626                	mv	a2,s1
    219e:	85d6                	mv	a1,s5
    21a0:	00004517          	auipc	a0,0x4
    21a4:	7e050513          	addi	a0,a0,2016 # 6980 <malloc+0xc7c>
    21a8:	00004097          	auipc	ra,0x4
    21ac:	aa4080e7          	jalr	-1372(ra) # 5c4c <printf>
            exit(1);
    21b0:	4505                	li	a0,1
    21b2:	00003097          	auipc	ra,0x3
    21b6:	722080e7          	jalr	1826(ra) # 58d4 <exit>
            exit(1);
    21ba:	4505                	li	a0,1
    21bc:	00003097          	auipc	ra,0x3
    21c0:	718080e7          	jalr	1816(ra) # 58d4 <exit>

00000000000021c4 <MAXVAplus>:
void MAXVAplus(char *s) {
    21c4:	7179                	addi	sp,sp,-48
    21c6:	f406                	sd	ra,40(sp)
    21c8:	f022                	sd	s0,32(sp)
    21ca:	1800                	addi	s0,sp,48
    volatile uint64 a = MAXVA;
    21cc:	4785                	li	a5,1
    21ce:	179a                	slli	a5,a5,0x26
    21d0:	fcf43c23          	sd	a5,-40(s0)
    for (; a != 0; a <<= 1) {
    21d4:	fd843783          	ld	a5,-40(s0)
    21d8:	c3a1                	beqz	a5,2218 <MAXVAplus+0x54>
    21da:	ec26                	sd	s1,24(sp)
    21dc:	e84a                	sd	s2,16(sp)
    21de:	892a                	mv	s2,a0
        if (xstatus != -1) // did kernel kill child?
    21e0:	54fd                	li	s1,-1
        pid = fork();
    21e2:	00003097          	auipc	ra,0x3
    21e6:	6ea080e7          	jalr	1770(ra) # 58cc <fork>
        if (pid < 0) {
    21ea:	02054b63          	bltz	a0,2220 <MAXVAplus+0x5c>
        if (pid == 0) {
    21ee:	c539                	beqz	a0,223c <MAXVAplus+0x78>
        wait(&xstatus);
    21f0:	fd440513          	addi	a0,s0,-44
    21f4:	00003097          	auipc	ra,0x3
    21f8:	6e8080e7          	jalr	1768(ra) # 58dc <wait>
        if (xstatus != -1) // did kernel kill child?
    21fc:	fd442783          	lw	a5,-44(s0)
    2200:	06979463          	bne	a5,s1,2268 <MAXVAplus+0xa4>
    for (; a != 0; a <<= 1) {
    2204:	fd843783          	ld	a5,-40(s0)
    2208:	0786                	slli	a5,a5,0x1
    220a:	fcf43c23          	sd	a5,-40(s0)
    220e:	fd843783          	ld	a5,-40(s0)
    2212:	fbe1                	bnez	a5,21e2 <MAXVAplus+0x1e>
    2214:	64e2                	ld	s1,24(sp)
    2216:	6942                	ld	s2,16(sp)
}
    2218:	70a2                	ld	ra,40(sp)
    221a:	7402                	ld	s0,32(sp)
    221c:	6145                	addi	sp,sp,48
    221e:	8082                	ret
            printf("%s: fork failed\n", s);
    2220:	85ca                	mv	a1,s2
    2222:	00004517          	auipc	a0,0x4
    2226:	47650513          	addi	a0,a0,1142 # 6698 <malloc+0x994>
    222a:	00004097          	auipc	ra,0x4
    222e:	a22080e7          	jalr	-1502(ra) # 5c4c <printf>
            exit(1);
    2232:	4505                	li	a0,1
    2234:	00003097          	auipc	ra,0x3
    2238:	6a0080e7          	jalr	1696(ra) # 58d4 <exit>
            *(char *)a = 99;
    223c:	fd843783          	ld	a5,-40(s0)
    2240:	06300713          	li	a4,99
    2244:	00e78023          	sb	a4,0(a5) # 3000 <iputtest+0x2e>
            printf("%s: oops wrote %x\n", s, a);
    2248:	fd843603          	ld	a2,-40(s0)
    224c:	85ca                	mv	a1,s2
    224e:	00004517          	auipc	a0,0x4
    2252:	75250513          	addi	a0,a0,1874 # 69a0 <malloc+0xc9c>
    2256:	00004097          	auipc	ra,0x4
    225a:	9f6080e7          	jalr	-1546(ra) # 5c4c <printf>
            exit(1);
    225e:	4505                	li	a0,1
    2260:	00003097          	auipc	ra,0x3
    2264:	674080e7          	jalr	1652(ra) # 58d4 <exit>
            exit(1);
    2268:	4505                	li	a0,1
    226a:	00003097          	auipc	ra,0x3
    226e:	66a080e7          	jalr	1642(ra) # 58d4 <exit>

0000000000002272 <bigargtest>:
void bigargtest(char *s) {
    2272:	7179                	addi	sp,sp,-48
    2274:	f406                	sd	ra,40(sp)
    2276:	f022                	sd	s0,32(sp)
    2278:	ec26                	sd	s1,24(sp)
    227a:	1800                	addi	s0,sp,48
    227c:	84aa                	mv	s1,a0
    unlink("bigarg-ok");
    227e:	00004517          	auipc	a0,0x4
    2282:	73a50513          	addi	a0,a0,1850 # 69b8 <malloc+0xcb4>
    2286:	00003097          	auipc	ra,0x3
    228a:	69e080e7          	jalr	1694(ra) # 5924 <unlink>
    pid = fork();
    228e:	00003097          	auipc	ra,0x3
    2292:	63e080e7          	jalr	1598(ra) # 58cc <fork>
    if (pid == 0) {
    2296:	c121                	beqz	a0,22d6 <bigargtest+0x64>
    } else if (pid < 0) {
    2298:	0a054063          	bltz	a0,2338 <bigargtest+0xc6>
    wait(&xstatus);
    229c:	fdc40513          	addi	a0,s0,-36
    22a0:	00003097          	auipc	ra,0x3
    22a4:	63c080e7          	jalr	1596(ra) # 58dc <wait>
    if (xstatus != 0)
    22a8:	fdc42503          	lw	a0,-36(s0)
    22ac:	e545                	bnez	a0,2354 <bigargtest+0xe2>
    fd = open("bigarg-ok", 0);
    22ae:	4581                	li	a1,0
    22b0:	00004517          	auipc	a0,0x4
    22b4:	70850513          	addi	a0,a0,1800 # 69b8 <malloc+0xcb4>
    22b8:	00003097          	auipc	ra,0x3
    22bc:	65c080e7          	jalr	1628(ra) # 5914 <open>
    if (fd < 0) {
    22c0:	08054e63          	bltz	a0,235c <bigargtest+0xea>
    close(fd);
    22c4:	00003097          	auipc	ra,0x3
    22c8:	638080e7          	jalr	1592(ra) # 58fc <close>
}
    22cc:	70a2                	ld	ra,40(sp)
    22ce:	7402                	ld	s0,32(sp)
    22d0:	64e2                	ld	s1,24(sp)
    22d2:	6145                	addi	sp,sp,48
    22d4:	8082                	ret
    22d6:	00007797          	auipc	a5,0x7
    22da:	5f278793          	addi	a5,a5,1522 # 98c8 <args.1>
    22de:	00007697          	auipc	a3,0x7
    22e2:	6e268693          	addi	a3,a3,1762 # 99c0 <args.1+0xf8>
            args[i] = "bigargs test: failed\n                                  "
    22e6:	00004717          	auipc	a4,0x4
    22ea:	6e270713          	addi	a4,a4,1762 # 69c8 <malloc+0xcc4>
    22ee:	e398                	sd	a4,0(a5)
        for (i = 0; i < MAXARG - 1; i++)
    22f0:	07a1                	addi	a5,a5,8
    22f2:	fed79ee3          	bne	a5,a3,22ee <bigargtest+0x7c>
        args[MAXARG - 1] = 0;
    22f6:	00007597          	auipc	a1,0x7
    22fa:	5d258593          	addi	a1,a1,1490 # 98c8 <args.1>
    22fe:	0e05bc23          	sd	zero,248(a1)
        exec("echo", args);
    2302:	00004517          	auipc	a0,0x4
    2306:	b3e50513          	addi	a0,a0,-1218 # 5e40 <malloc+0x13c>
    230a:	00003097          	auipc	ra,0x3
    230e:	602080e7          	jalr	1538(ra) # 590c <exec>
        fd = open("bigarg-ok", O_CREATE);
    2312:	20000593          	li	a1,512
    2316:	00004517          	auipc	a0,0x4
    231a:	6a250513          	addi	a0,a0,1698 # 69b8 <malloc+0xcb4>
    231e:	00003097          	auipc	ra,0x3
    2322:	5f6080e7          	jalr	1526(ra) # 5914 <open>
        close(fd);
    2326:	00003097          	auipc	ra,0x3
    232a:	5d6080e7          	jalr	1494(ra) # 58fc <close>
        exit(0);
    232e:	4501                	li	a0,0
    2330:	00003097          	auipc	ra,0x3
    2334:	5a4080e7          	jalr	1444(ra) # 58d4 <exit>
        printf("%s: bigargtest: fork failed\n", s);
    2338:	85a6                	mv	a1,s1
    233a:	00004517          	auipc	a0,0x4
    233e:	76e50513          	addi	a0,a0,1902 # 6aa8 <malloc+0xda4>
    2342:	00004097          	auipc	ra,0x4
    2346:	90a080e7          	jalr	-1782(ra) # 5c4c <printf>
        exit(1);
    234a:	4505                	li	a0,1
    234c:	00003097          	auipc	ra,0x3
    2350:	588080e7          	jalr	1416(ra) # 58d4 <exit>
        exit(xstatus);
    2354:	00003097          	auipc	ra,0x3
    2358:	580080e7          	jalr	1408(ra) # 58d4 <exit>
        printf("%s: bigarg test failed!\n", s);
    235c:	85a6                	mv	a1,s1
    235e:	00004517          	auipc	a0,0x4
    2362:	76a50513          	addi	a0,a0,1898 # 6ac8 <malloc+0xdc4>
    2366:	00004097          	auipc	ra,0x4
    236a:	8e6080e7          	jalr	-1818(ra) # 5c4c <printf>
        exit(1);
    236e:	4505                	li	a0,1
    2370:	00003097          	auipc	ra,0x3
    2374:	564080e7          	jalr	1380(ra) # 58d4 <exit>

0000000000002378 <stacktest>:
void stacktest(char *s) {
    2378:	7179                	addi	sp,sp,-48
    237a:	f406                	sd	ra,40(sp)
    237c:	f022                	sd	s0,32(sp)
    237e:	ec26                	sd	s1,24(sp)
    2380:	1800                	addi	s0,sp,48
    2382:	84aa                	mv	s1,a0
    pid = fork();
    2384:	00003097          	auipc	ra,0x3
    2388:	548080e7          	jalr	1352(ra) # 58cc <fork>
    if (pid == 0) {
    238c:	c115                	beqz	a0,23b0 <stacktest+0x38>
    } else if (pid < 0) {
    238e:	04054463          	bltz	a0,23d6 <stacktest+0x5e>
    wait(&xstatus);
    2392:	fdc40513          	addi	a0,s0,-36
    2396:	00003097          	auipc	ra,0x3
    239a:	546080e7          	jalr	1350(ra) # 58dc <wait>
    if (xstatus == -1) // kernel killed child?
    239e:	fdc42503          	lw	a0,-36(s0)
    23a2:	57fd                	li	a5,-1
    23a4:	04f50763          	beq	a0,a5,23f2 <stacktest+0x7a>
        exit(xstatus);
    23a8:	00003097          	auipc	ra,0x3
    23ac:	52c080e7          	jalr	1324(ra) # 58d4 <exit>
    return (x & SSTATUS_SIE) != 0;
}

static inline uint64 r_sp() {
    uint64 x;
    asm volatile("mv %0, sp" : "=r"(x));
    23b0:	870a                	mv	a4,sp
        printf("%s: stacktest: read below stack %p\n", s, *sp);
    23b2:	77fd                	lui	a5,0xfffff
    23b4:	97ba                	add	a5,a5,a4
    23b6:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <__BSS_END__+0xfffffffffffeef10>
    23ba:	85a6                	mv	a1,s1
    23bc:	00004517          	auipc	a0,0x4
    23c0:	72c50513          	addi	a0,a0,1836 # 6ae8 <malloc+0xde4>
    23c4:	00004097          	auipc	ra,0x4
    23c8:	888080e7          	jalr	-1912(ra) # 5c4c <printf>
        exit(1);
    23cc:	4505                	li	a0,1
    23ce:	00003097          	auipc	ra,0x3
    23d2:	506080e7          	jalr	1286(ra) # 58d4 <exit>
        printf("%s: fork failed\n", s);
    23d6:	85a6                	mv	a1,s1
    23d8:	00004517          	auipc	a0,0x4
    23dc:	2c050513          	addi	a0,a0,704 # 6698 <malloc+0x994>
    23e0:	00004097          	auipc	ra,0x4
    23e4:	86c080e7          	jalr	-1940(ra) # 5c4c <printf>
        exit(1);
    23e8:	4505                	li	a0,1
    23ea:	00003097          	auipc	ra,0x3
    23ee:	4ea080e7          	jalr	1258(ra) # 58d4 <exit>
        exit(0);
    23f2:	4501                	li	a0,0
    23f4:	00003097          	auipc	ra,0x3
    23f8:	4e0080e7          	jalr	1248(ra) # 58d4 <exit>

00000000000023fc <copyinstr3>:
void copyinstr3(char *s) {
    23fc:	7179                	addi	sp,sp,-48
    23fe:	f406                	sd	ra,40(sp)
    2400:	f022                	sd	s0,32(sp)
    2402:	ec26                	sd	s1,24(sp)
    2404:	1800                	addi	s0,sp,48
    sbrk(8192);
    2406:	6509                	lui	a0,0x2
    2408:	00003097          	auipc	ra,0x3
    240c:	554080e7          	jalr	1364(ra) # 595c <sbrk>
    uint64 top = (uint64)sbrk(0);
    2410:	4501                	li	a0,0
    2412:	00003097          	auipc	ra,0x3
    2416:	54a080e7          	jalr	1354(ra) # 595c <sbrk>
    if ((top % PGSIZE) != 0) {
    241a:	03451793          	slli	a5,a0,0x34
    241e:	e3c9                	bnez	a5,24a0 <copyinstr3+0xa4>
    top = (uint64)sbrk(0);
    2420:	4501                	li	a0,0
    2422:	00003097          	auipc	ra,0x3
    2426:	53a080e7          	jalr	1338(ra) # 595c <sbrk>
    if (top % PGSIZE) {
    242a:	03451793          	slli	a5,a0,0x34
    242e:	e3d9                	bnez	a5,24b4 <copyinstr3+0xb8>
    char *b = (char *)(top - 1);
    2430:	fff50493          	addi	s1,a0,-1 # 1fff <manywrites+0x117>
    *b = 'x';
    2434:	07800793          	li	a5,120
    2438:	fef50fa3          	sb	a5,-1(a0)
    int ret = unlink(b);
    243c:	8526                	mv	a0,s1
    243e:	00003097          	auipc	ra,0x3
    2442:	4e6080e7          	jalr	1254(ra) # 5924 <unlink>
    if (ret != -1) {
    2446:	57fd                	li	a5,-1
    2448:	08f51363          	bne	a0,a5,24ce <copyinstr3+0xd2>
    int fd = open(b, O_CREATE | O_WRONLY);
    244c:	20100593          	li	a1,513
    2450:	8526                	mv	a0,s1
    2452:	00003097          	auipc	ra,0x3
    2456:	4c2080e7          	jalr	1218(ra) # 5914 <open>
    if (fd != -1) {
    245a:	57fd                	li	a5,-1
    245c:	08f51863          	bne	a0,a5,24ec <copyinstr3+0xf0>
    ret = link(b, b);
    2460:	85a6                	mv	a1,s1
    2462:	8526                	mv	a0,s1
    2464:	00003097          	auipc	ra,0x3
    2468:	4d0080e7          	jalr	1232(ra) # 5934 <link>
    if (ret != -1) {
    246c:	57fd                	li	a5,-1
    246e:	08f51e63          	bne	a0,a5,250a <copyinstr3+0x10e>
    char *args[] = {"xx", 0};
    2472:	00005797          	auipc	a5,0x5
    2476:	31e78793          	addi	a5,a5,798 # 7790 <malloc+0x1a8c>
    247a:	fcf43823          	sd	a5,-48(s0)
    247e:	fc043c23          	sd	zero,-40(s0)
    ret = exec(b, args);
    2482:	fd040593          	addi	a1,s0,-48
    2486:	8526                	mv	a0,s1
    2488:	00003097          	auipc	ra,0x3
    248c:	484080e7          	jalr	1156(ra) # 590c <exec>
    if (ret != -1) {
    2490:	57fd                	li	a5,-1
    2492:	08f51c63          	bne	a0,a5,252a <copyinstr3+0x12e>
}
    2496:	70a2                	ld	ra,40(sp)
    2498:	7402                	ld	s0,32(sp)
    249a:	64e2                	ld	s1,24(sp)
    249c:	6145                	addi	sp,sp,48
    249e:	8082                	ret
        sbrk(PGSIZE - (top % PGSIZE));
    24a0:	0347d513          	srli	a0,a5,0x34
    24a4:	6785                	lui	a5,0x1
    24a6:	40a7853b          	subw	a0,a5,a0
    24aa:	00003097          	auipc	ra,0x3
    24ae:	4b2080e7          	jalr	1202(ra) # 595c <sbrk>
    24b2:	b7bd                	j	2420 <copyinstr3+0x24>
        printf("oops\n");
    24b4:	00004517          	auipc	a0,0x4
    24b8:	65c50513          	addi	a0,a0,1628 # 6b10 <malloc+0xe0c>
    24bc:	00003097          	auipc	ra,0x3
    24c0:	790080e7          	jalr	1936(ra) # 5c4c <printf>
        exit(1);
    24c4:	4505                	li	a0,1
    24c6:	00003097          	auipc	ra,0x3
    24ca:	40e080e7          	jalr	1038(ra) # 58d4 <exit>
        printf("unlink(%s) returned %d, not -1\n", b, ret);
    24ce:	862a                	mv	a2,a0
    24d0:	85a6                	mv	a1,s1
    24d2:	00004517          	auipc	a0,0x4
    24d6:	0e650513          	addi	a0,a0,230 # 65b8 <malloc+0x8b4>
    24da:	00003097          	auipc	ra,0x3
    24de:	772080e7          	jalr	1906(ra) # 5c4c <printf>
        exit(1);
    24e2:	4505                	li	a0,1
    24e4:	00003097          	auipc	ra,0x3
    24e8:	3f0080e7          	jalr	1008(ra) # 58d4 <exit>
        printf("open(%s) returned %d, not -1\n", b, fd);
    24ec:	862a                	mv	a2,a0
    24ee:	85a6                	mv	a1,s1
    24f0:	00004517          	auipc	a0,0x4
    24f4:	0e850513          	addi	a0,a0,232 # 65d8 <malloc+0x8d4>
    24f8:	00003097          	auipc	ra,0x3
    24fc:	754080e7          	jalr	1876(ra) # 5c4c <printf>
        exit(1);
    2500:	4505                	li	a0,1
    2502:	00003097          	auipc	ra,0x3
    2506:	3d2080e7          	jalr	978(ra) # 58d4 <exit>
        printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    250a:	86aa                	mv	a3,a0
    250c:	8626                	mv	a2,s1
    250e:	85a6                	mv	a1,s1
    2510:	00004517          	auipc	a0,0x4
    2514:	0e850513          	addi	a0,a0,232 # 65f8 <malloc+0x8f4>
    2518:	00003097          	auipc	ra,0x3
    251c:	734080e7          	jalr	1844(ra) # 5c4c <printf>
        exit(1);
    2520:	4505                	li	a0,1
    2522:	00003097          	auipc	ra,0x3
    2526:	3b2080e7          	jalr	946(ra) # 58d4 <exit>
        printf("exec(%s) returned %d, not -1\n", b, fd);
    252a:	567d                	li	a2,-1
    252c:	85a6                	mv	a1,s1
    252e:	00004517          	auipc	a0,0x4
    2532:	0f250513          	addi	a0,a0,242 # 6620 <malloc+0x91c>
    2536:	00003097          	auipc	ra,0x3
    253a:	716080e7          	jalr	1814(ra) # 5c4c <printf>
        exit(1);
    253e:	4505                	li	a0,1
    2540:	00003097          	auipc	ra,0x3
    2544:	394080e7          	jalr	916(ra) # 58d4 <exit>

0000000000002548 <rwsbrk>:
void rwsbrk() {
    2548:	1101                	addi	sp,sp,-32
    254a:	ec06                	sd	ra,24(sp)
    254c:	e822                	sd	s0,16(sp)
    254e:	1000                	addi	s0,sp,32
    uint64 a = (uint64)sbrk(8192);
    2550:	6509                	lui	a0,0x2
    2552:	00003097          	auipc	ra,0x3
    2556:	40a080e7          	jalr	1034(ra) # 595c <sbrk>
    if (a == 0xffffffffffffffffLL) {
    255a:	57fd                	li	a5,-1
    255c:	06f50463          	beq	a0,a5,25c4 <rwsbrk+0x7c>
    2560:	e426                	sd	s1,8(sp)
    2562:	84aa                	mv	s1,a0
    if ((uint64)sbrk(-8192) == 0xffffffffffffffffLL) {
    2564:	7579                	lui	a0,0xffffe
    2566:	00003097          	auipc	ra,0x3
    256a:	3f6080e7          	jalr	1014(ra) # 595c <sbrk>
    256e:	57fd                	li	a5,-1
    2570:	06f50963          	beq	a0,a5,25e2 <rwsbrk+0x9a>
    2574:	e04a                	sd	s2,0(sp)
    fd = open("rwsbrk", O_CREATE | O_WRONLY);
    2576:	20100593          	li	a1,513
    257a:	00004517          	auipc	a0,0x4
    257e:	5d650513          	addi	a0,a0,1494 # 6b50 <malloc+0xe4c>
    2582:	00003097          	auipc	ra,0x3
    2586:	392080e7          	jalr	914(ra) # 5914 <open>
    258a:	892a                	mv	s2,a0
    if (fd < 0) {
    258c:	06054963          	bltz	a0,25fe <rwsbrk+0xb6>
    n = write(fd, (void *)(a + 4096), 1024);
    2590:	6785                	lui	a5,0x1
    2592:	94be                	add	s1,s1,a5
    2594:	40000613          	li	a2,1024
    2598:	85a6                	mv	a1,s1
    259a:	00003097          	auipc	ra,0x3
    259e:	35a080e7          	jalr	858(ra) # 58f4 <write>
    25a2:	862a                	mv	a2,a0
    if (n >= 0) {
    25a4:	06054a63          	bltz	a0,2618 <rwsbrk+0xd0>
        printf("write(fd, %p, 1024) returned %d, not -1\n", a + 4096, n);
    25a8:	85a6                	mv	a1,s1
    25aa:	00004517          	auipc	a0,0x4
    25ae:	5c650513          	addi	a0,a0,1478 # 6b70 <malloc+0xe6c>
    25b2:	00003097          	auipc	ra,0x3
    25b6:	69a080e7          	jalr	1690(ra) # 5c4c <printf>
        exit(1);
    25ba:	4505                	li	a0,1
    25bc:	00003097          	auipc	ra,0x3
    25c0:	318080e7          	jalr	792(ra) # 58d4 <exit>
    25c4:	e426                	sd	s1,8(sp)
    25c6:	e04a                	sd	s2,0(sp)
        printf("sbrk(rwsbrk) failed\n");
    25c8:	00004517          	auipc	a0,0x4
    25cc:	55050513          	addi	a0,a0,1360 # 6b18 <malloc+0xe14>
    25d0:	00003097          	auipc	ra,0x3
    25d4:	67c080e7          	jalr	1660(ra) # 5c4c <printf>
        exit(1);
    25d8:	4505                	li	a0,1
    25da:	00003097          	auipc	ra,0x3
    25de:	2fa080e7          	jalr	762(ra) # 58d4 <exit>
    25e2:	e04a                	sd	s2,0(sp)
        printf("sbrk(rwsbrk) shrink failed\n");
    25e4:	00004517          	auipc	a0,0x4
    25e8:	54c50513          	addi	a0,a0,1356 # 6b30 <malloc+0xe2c>
    25ec:	00003097          	auipc	ra,0x3
    25f0:	660080e7          	jalr	1632(ra) # 5c4c <printf>
        exit(1);
    25f4:	4505                	li	a0,1
    25f6:	00003097          	auipc	ra,0x3
    25fa:	2de080e7          	jalr	734(ra) # 58d4 <exit>
        printf("open(rwsbrk) failed\n");
    25fe:	00004517          	auipc	a0,0x4
    2602:	55a50513          	addi	a0,a0,1370 # 6b58 <malloc+0xe54>
    2606:	00003097          	auipc	ra,0x3
    260a:	646080e7          	jalr	1606(ra) # 5c4c <printf>
        exit(1);
    260e:	4505                	li	a0,1
    2610:	00003097          	auipc	ra,0x3
    2614:	2c4080e7          	jalr	708(ra) # 58d4 <exit>
    close(fd);
    2618:	854a                	mv	a0,s2
    261a:	00003097          	auipc	ra,0x3
    261e:	2e2080e7          	jalr	738(ra) # 58fc <close>
    unlink("rwsbrk");
    2622:	00004517          	auipc	a0,0x4
    2626:	52e50513          	addi	a0,a0,1326 # 6b50 <malloc+0xe4c>
    262a:	00003097          	auipc	ra,0x3
    262e:	2fa080e7          	jalr	762(ra) # 5924 <unlink>
    fd = open("README", O_RDONLY);
    2632:	4581                	li	a1,0
    2634:	00004517          	auipc	a0,0x4
    2638:	9b450513          	addi	a0,a0,-1612 # 5fe8 <malloc+0x2e4>
    263c:	00003097          	auipc	ra,0x3
    2640:	2d8080e7          	jalr	728(ra) # 5914 <open>
    2644:	892a                	mv	s2,a0
    if (fd < 0) {
    2646:	02054963          	bltz	a0,2678 <rwsbrk+0x130>
    n = read(fd, (void *)(a + 4096), 10);
    264a:	4629                	li	a2,10
    264c:	85a6                	mv	a1,s1
    264e:	00003097          	auipc	ra,0x3
    2652:	29e080e7          	jalr	670(ra) # 58ec <read>
    2656:	862a                	mv	a2,a0
    if (n >= 0) {
    2658:	02054d63          	bltz	a0,2692 <rwsbrk+0x14a>
        printf("read(fd, %p, 10) returned %d, not -1\n", a + 4096, n);
    265c:	85a6                	mv	a1,s1
    265e:	00004517          	auipc	a0,0x4
    2662:	54250513          	addi	a0,a0,1346 # 6ba0 <malloc+0xe9c>
    2666:	00003097          	auipc	ra,0x3
    266a:	5e6080e7          	jalr	1510(ra) # 5c4c <printf>
        exit(1);
    266e:	4505                	li	a0,1
    2670:	00003097          	auipc	ra,0x3
    2674:	264080e7          	jalr	612(ra) # 58d4 <exit>
        printf("open(rwsbrk) failed\n");
    2678:	00004517          	auipc	a0,0x4
    267c:	4e050513          	addi	a0,a0,1248 # 6b58 <malloc+0xe54>
    2680:	00003097          	auipc	ra,0x3
    2684:	5cc080e7          	jalr	1484(ra) # 5c4c <printf>
        exit(1);
    2688:	4505                	li	a0,1
    268a:	00003097          	auipc	ra,0x3
    268e:	24a080e7          	jalr	586(ra) # 58d4 <exit>
    close(fd);
    2692:	854a                	mv	a0,s2
    2694:	00003097          	auipc	ra,0x3
    2698:	268080e7          	jalr	616(ra) # 58fc <close>
    exit(0);
    269c:	4501                	li	a0,0
    269e:	00003097          	auipc	ra,0x3
    26a2:	236080e7          	jalr	566(ra) # 58d4 <exit>

00000000000026a6 <sbrkbasic>:
void sbrkbasic(char *s) {
    26a6:	7139                	addi	sp,sp,-64
    26a8:	fc06                	sd	ra,56(sp)
    26aa:	f822                	sd	s0,48(sp)
    26ac:	ec4e                	sd	s3,24(sp)
    26ae:	0080                	addi	s0,sp,64
    26b0:	89aa                	mv	s3,a0
    pid = fork();
    26b2:	00003097          	auipc	ra,0x3
    26b6:	21a080e7          	jalr	538(ra) # 58cc <fork>
    if (pid < 0) {
    26ba:	02054f63          	bltz	a0,26f8 <sbrkbasic+0x52>
    if (pid == 0) {
    26be:	e52d                	bnez	a0,2728 <sbrkbasic+0x82>
        a = sbrk(TOOMUCH);
    26c0:	40000537          	lui	a0,0x40000
    26c4:	00003097          	auipc	ra,0x3
    26c8:	298080e7          	jalr	664(ra) # 595c <sbrk>
        if (a == (char *)0xffffffffffffffffL) {
    26cc:	57fd                	li	a5,-1
    26ce:	04f50563          	beq	a0,a5,2718 <sbrkbasic+0x72>
    26d2:	f426                	sd	s1,40(sp)
    26d4:	f04a                	sd	s2,32(sp)
    26d6:	e852                	sd	s4,16(sp)
        for (b = a; b < a + TOOMUCH; b += 4096) {
    26d8:	400007b7          	lui	a5,0x40000
    26dc:	97aa                	add	a5,a5,a0
            *b = 99;
    26de:	06300693          	li	a3,99
        for (b = a; b < a + TOOMUCH; b += 4096) {
    26e2:	6705                	lui	a4,0x1
            *b = 99;
    26e4:	00d50023          	sb	a3,0(a0) # 40000000 <__BSS_END__+0x3ffeff10>
        for (b = a; b < a + TOOMUCH; b += 4096) {
    26e8:	953a                	add	a0,a0,a4
    26ea:	fef51de3          	bne	a0,a5,26e4 <sbrkbasic+0x3e>
        exit(1);
    26ee:	4505                	li	a0,1
    26f0:	00003097          	auipc	ra,0x3
    26f4:	1e4080e7          	jalr	484(ra) # 58d4 <exit>
    26f8:	f426                	sd	s1,40(sp)
    26fa:	f04a                	sd	s2,32(sp)
    26fc:	e852                	sd	s4,16(sp)
        printf("fork failed in sbrkbasic\n");
    26fe:	00004517          	auipc	a0,0x4
    2702:	4ca50513          	addi	a0,a0,1226 # 6bc8 <malloc+0xec4>
    2706:	00003097          	auipc	ra,0x3
    270a:	546080e7          	jalr	1350(ra) # 5c4c <printf>
        exit(1);
    270e:	4505                	li	a0,1
    2710:	00003097          	auipc	ra,0x3
    2714:	1c4080e7          	jalr	452(ra) # 58d4 <exit>
    2718:	f426                	sd	s1,40(sp)
    271a:	f04a                	sd	s2,32(sp)
    271c:	e852                	sd	s4,16(sp)
            exit(0);
    271e:	4501                	li	a0,0
    2720:	00003097          	auipc	ra,0x3
    2724:	1b4080e7          	jalr	436(ra) # 58d4 <exit>
    wait(&xstatus);
    2728:	fcc40513          	addi	a0,s0,-52
    272c:	00003097          	auipc	ra,0x3
    2730:	1b0080e7          	jalr	432(ra) # 58dc <wait>
    if (xstatus == 1) {
    2734:	fcc42703          	lw	a4,-52(s0)
    2738:	4785                	li	a5,1
    273a:	02f70063          	beq	a4,a5,275a <sbrkbasic+0xb4>
    273e:	f426                	sd	s1,40(sp)
    2740:	f04a                	sd	s2,32(sp)
    2742:	e852                	sd	s4,16(sp)
    a = sbrk(0);
    2744:	4501                	li	a0,0
    2746:	00003097          	auipc	ra,0x3
    274a:	216080e7          	jalr	534(ra) # 595c <sbrk>
    274e:	84aa                	mv	s1,a0
    for (i = 0; i < 5000; i++) {
    2750:	4901                	li	s2,0
    2752:	6a05                	lui	s4,0x1
    2754:	388a0a13          	addi	s4,s4,904 # 1388 <copyinstr2+0x1ce>
    2758:	a01d                	j	277e <sbrkbasic+0xd8>
    275a:	f426                	sd	s1,40(sp)
    275c:	f04a                	sd	s2,32(sp)
    275e:	e852                	sd	s4,16(sp)
        printf("%s: too much memory allocated!\n", s);
    2760:	85ce                	mv	a1,s3
    2762:	00004517          	auipc	a0,0x4
    2766:	48650513          	addi	a0,a0,1158 # 6be8 <malloc+0xee4>
    276a:	00003097          	auipc	ra,0x3
    276e:	4e2080e7          	jalr	1250(ra) # 5c4c <printf>
        exit(1);
    2772:	4505                	li	a0,1
    2774:	00003097          	auipc	ra,0x3
    2778:	160080e7          	jalr	352(ra) # 58d4 <exit>
    277c:	84be                	mv	s1,a5
        b = sbrk(1);
    277e:	4505                	li	a0,1
    2780:	00003097          	auipc	ra,0x3
    2784:	1dc080e7          	jalr	476(ra) # 595c <sbrk>
        if (b != a) {
    2788:	04951c63          	bne	a0,s1,27e0 <sbrkbasic+0x13a>
        *b = 1;
    278c:	4785                	li	a5,1
    278e:	00f48023          	sb	a5,0(s1)
        a = b + 1;
    2792:	00148793          	addi	a5,s1,1
    for (i = 0; i < 5000; i++) {
    2796:	2905                	addiw	s2,s2,1
    2798:	ff4912e3          	bne	s2,s4,277c <sbrkbasic+0xd6>
    pid = fork();
    279c:	00003097          	auipc	ra,0x3
    27a0:	130080e7          	jalr	304(ra) # 58cc <fork>
    27a4:	892a                	mv	s2,a0
    if (pid < 0) {
    27a6:	04054e63          	bltz	a0,2802 <sbrkbasic+0x15c>
    c = sbrk(1);
    27aa:	4505                	li	a0,1
    27ac:	00003097          	auipc	ra,0x3
    27b0:	1b0080e7          	jalr	432(ra) # 595c <sbrk>
    c = sbrk(1);
    27b4:	4505                	li	a0,1
    27b6:	00003097          	auipc	ra,0x3
    27ba:	1a6080e7          	jalr	422(ra) # 595c <sbrk>
    if (c != a + 1) {
    27be:	0489                	addi	s1,s1,2
    27c0:	04a48f63          	beq	s1,a0,281e <sbrkbasic+0x178>
        printf("%s: sbrk test failed post-fork\n", s);
    27c4:	85ce                	mv	a1,s3
    27c6:	00004517          	auipc	a0,0x4
    27ca:	48250513          	addi	a0,a0,1154 # 6c48 <malloc+0xf44>
    27ce:	00003097          	auipc	ra,0x3
    27d2:	47e080e7          	jalr	1150(ra) # 5c4c <printf>
        exit(1);
    27d6:	4505                	li	a0,1
    27d8:	00003097          	auipc	ra,0x3
    27dc:	0fc080e7          	jalr	252(ra) # 58d4 <exit>
            printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    27e0:	872a                	mv	a4,a0
    27e2:	86a6                	mv	a3,s1
    27e4:	864a                	mv	a2,s2
    27e6:	85ce                	mv	a1,s3
    27e8:	00004517          	auipc	a0,0x4
    27ec:	42050513          	addi	a0,a0,1056 # 6c08 <malloc+0xf04>
    27f0:	00003097          	auipc	ra,0x3
    27f4:	45c080e7          	jalr	1116(ra) # 5c4c <printf>
            exit(1);
    27f8:	4505                	li	a0,1
    27fa:	00003097          	auipc	ra,0x3
    27fe:	0da080e7          	jalr	218(ra) # 58d4 <exit>
        printf("%s: sbrk test fork failed\n", s);
    2802:	85ce                	mv	a1,s3
    2804:	00004517          	auipc	a0,0x4
    2808:	42450513          	addi	a0,a0,1060 # 6c28 <malloc+0xf24>
    280c:	00003097          	auipc	ra,0x3
    2810:	440080e7          	jalr	1088(ra) # 5c4c <printf>
        exit(1);
    2814:	4505                	li	a0,1
    2816:	00003097          	auipc	ra,0x3
    281a:	0be080e7          	jalr	190(ra) # 58d4 <exit>
    if (pid == 0)
    281e:	00091763          	bnez	s2,282c <sbrkbasic+0x186>
        exit(0);
    2822:	4501                	li	a0,0
    2824:	00003097          	auipc	ra,0x3
    2828:	0b0080e7          	jalr	176(ra) # 58d4 <exit>
    wait(&xstatus);
    282c:	fcc40513          	addi	a0,s0,-52
    2830:	00003097          	auipc	ra,0x3
    2834:	0ac080e7          	jalr	172(ra) # 58dc <wait>
    exit(xstatus);
    2838:	fcc42503          	lw	a0,-52(s0)
    283c:	00003097          	auipc	ra,0x3
    2840:	098080e7          	jalr	152(ra) # 58d4 <exit>

0000000000002844 <sbrkmuch>:
void sbrkmuch(char *s) {
    2844:	7179                	addi	sp,sp,-48
    2846:	f406                	sd	ra,40(sp)
    2848:	f022                	sd	s0,32(sp)
    284a:	ec26                	sd	s1,24(sp)
    284c:	e84a                	sd	s2,16(sp)
    284e:	e44e                	sd	s3,8(sp)
    2850:	e052                	sd	s4,0(sp)
    2852:	1800                	addi	s0,sp,48
    2854:	89aa                	mv	s3,a0
    oldbrk = sbrk(0);
    2856:	4501                	li	a0,0
    2858:	00003097          	auipc	ra,0x3
    285c:	104080e7          	jalr	260(ra) # 595c <sbrk>
    2860:	892a                	mv	s2,a0
    a = sbrk(0);
    2862:	4501                	li	a0,0
    2864:	00003097          	auipc	ra,0x3
    2868:	0f8080e7          	jalr	248(ra) # 595c <sbrk>
    286c:	84aa                	mv	s1,a0
    p = sbrk(amt);
    286e:	06400537          	lui	a0,0x6400
    2872:	9d05                	subw	a0,a0,s1
    2874:	00003097          	auipc	ra,0x3
    2878:	0e8080e7          	jalr	232(ra) # 595c <sbrk>
    if (p != a) {
    287c:	0ca49863          	bne	s1,a0,294c <sbrkmuch+0x108>
    char *eee = sbrk(0);
    2880:	4501                	li	a0,0
    2882:	00003097          	auipc	ra,0x3
    2886:	0da080e7          	jalr	218(ra) # 595c <sbrk>
    288a:	87aa                	mv	a5,a0
    for (char *pp = a; pp < eee; pp += 4096)
    288c:	00a4f963          	bgeu	s1,a0,289e <sbrkmuch+0x5a>
        *pp = 1;
    2890:	4685                	li	a3,1
    for (char *pp = a; pp < eee; pp += 4096)
    2892:	6705                	lui	a4,0x1
        *pp = 1;
    2894:	00d48023          	sb	a3,0(s1)
    for (char *pp = a; pp < eee; pp += 4096)
    2898:	94ba                	add	s1,s1,a4
    289a:	fef4ede3          	bltu	s1,a5,2894 <sbrkmuch+0x50>
    *lastaddr = 99;
    289e:	064007b7          	lui	a5,0x6400
    28a2:	06300713          	li	a4,99
    28a6:	fee78fa3          	sb	a4,-1(a5) # 63fffff <__BSS_END__+0x63eff0f>
    a = sbrk(0);
    28aa:	4501                	li	a0,0
    28ac:	00003097          	auipc	ra,0x3
    28b0:	0b0080e7          	jalr	176(ra) # 595c <sbrk>
    28b4:	84aa                	mv	s1,a0
    c = sbrk(-PGSIZE);
    28b6:	757d                	lui	a0,0xfffff
    28b8:	00003097          	auipc	ra,0x3
    28bc:	0a4080e7          	jalr	164(ra) # 595c <sbrk>
    if (c == (char *)0xffffffffffffffffL) {
    28c0:	57fd                	li	a5,-1
    28c2:	0af50363          	beq	a0,a5,2968 <sbrkmuch+0x124>
    c = sbrk(0);
    28c6:	4501                	li	a0,0
    28c8:	00003097          	auipc	ra,0x3
    28cc:	094080e7          	jalr	148(ra) # 595c <sbrk>
    if (c != a - PGSIZE) {
    28d0:	77fd                	lui	a5,0xfffff
    28d2:	97a6                	add	a5,a5,s1
    28d4:	0af51863          	bne	a0,a5,2984 <sbrkmuch+0x140>
    a = sbrk(0);
    28d8:	4501                	li	a0,0
    28da:	00003097          	auipc	ra,0x3
    28de:	082080e7          	jalr	130(ra) # 595c <sbrk>
    28e2:	84aa                	mv	s1,a0
    c = sbrk(PGSIZE);
    28e4:	6505                	lui	a0,0x1
    28e6:	00003097          	auipc	ra,0x3
    28ea:	076080e7          	jalr	118(ra) # 595c <sbrk>
    28ee:	8a2a                	mv	s4,a0
    if (c != a || sbrk(0) != a + PGSIZE) {
    28f0:	0aa49a63          	bne	s1,a0,29a4 <sbrkmuch+0x160>
    28f4:	4501                	li	a0,0
    28f6:	00003097          	auipc	ra,0x3
    28fa:	066080e7          	jalr	102(ra) # 595c <sbrk>
    28fe:	6785                	lui	a5,0x1
    2900:	97a6                	add	a5,a5,s1
    2902:	0af51163          	bne	a0,a5,29a4 <sbrkmuch+0x160>
    if (*lastaddr == 99) {
    2906:	064007b7          	lui	a5,0x6400
    290a:	fff7c703          	lbu	a4,-1(a5) # 63fffff <__BSS_END__+0x63eff0f>
    290e:	06300793          	li	a5,99
    2912:	0af70963          	beq	a4,a5,29c4 <sbrkmuch+0x180>
    a = sbrk(0);
    2916:	4501                	li	a0,0
    2918:	00003097          	auipc	ra,0x3
    291c:	044080e7          	jalr	68(ra) # 595c <sbrk>
    2920:	84aa                	mv	s1,a0
    c = sbrk(-(sbrk(0) - oldbrk));
    2922:	4501                	li	a0,0
    2924:	00003097          	auipc	ra,0x3
    2928:	038080e7          	jalr	56(ra) # 595c <sbrk>
    292c:	40a9053b          	subw	a0,s2,a0
    2930:	00003097          	auipc	ra,0x3
    2934:	02c080e7          	jalr	44(ra) # 595c <sbrk>
    if (c != a) {
    2938:	0aa49463          	bne	s1,a0,29e0 <sbrkmuch+0x19c>
}
    293c:	70a2                	ld	ra,40(sp)
    293e:	7402                	ld	s0,32(sp)
    2940:	64e2                	ld	s1,24(sp)
    2942:	6942                	ld	s2,16(sp)
    2944:	69a2                	ld	s3,8(sp)
    2946:	6a02                	ld	s4,0(sp)
    2948:	6145                	addi	sp,sp,48
    294a:	8082                	ret
        printf("%s: sbrk test failed to grow big address space; enough phys "
    294c:	85ce                	mv	a1,s3
    294e:	00004517          	auipc	a0,0x4
    2952:	31a50513          	addi	a0,a0,794 # 6c68 <malloc+0xf64>
    2956:	00003097          	auipc	ra,0x3
    295a:	2f6080e7          	jalr	758(ra) # 5c4c <printf>
        exit(1);
    295e:	4505                	li	a0,1
    2960:	00003097          	auipc	ra,0x3
    2964:	f74080e7          	jalr	-140(ra) # 58d4 <exit>
        printf("%s: sbrk could not deallocate\n", s);
    2968:	85ce                	mv	a1,s3
    296a:	00004517          	auipc	a0,0x4
    296e:	34650513          	addi	a0,a0,838 # 6cb0 <malloc+0xfac>
    2972:	00003097          	auipc	ra,0x3
    2976:	2da080e7          	jalr	730(ra) # 5c4c <printf>
        exit(1);
    297a:	4505                	li	a0,1
    297c:	00003097          	auipc	ra,0x3
    2980:	f58080e7          	jalr	-168(ra) # 58d4 <exit>
        printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s,
    2984:	86aa                	mv	a3,a0
    2986:	8626                	mv	a2,s1
    2988:	85ce                	mv	a1,s3
    298a:	00004517          	auipc	a0,0x4
    298e:	34650513          	addi	a0,a0,838 # 6cd0 <malloc+0xfcc>
    2992:	00003097          	auipc	ra,0x3
    2996:	2ba080e7          	jalr	698(ra) # 5c4c <printf>
        exit(1);
    299a:	4505                	li	a0,1
    299c:	00003097          	auipc	ra,0x3
    29a0:	f38080e7          	jalr	-200(ra) # 58d4 <exit>
        printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    29a4:	86d2                	mv	a3,s4
    29a6:	8626                	mv	a2,s1
    29a8:	85ce                	mv	a1,s3
    29aa:	00004517          	auipc	a0,0x4
    29ae:	36650513          	addi	a0,a0,870 # 6d10 <malloc+0x100c>
    29b2:	00003097          	auipc	ra,0x3
    29b6:	29a080e7          	jalr	666(ra) # 5c4c <printf>
        exit(1);
    29ba:	4505                	li	a0,1
    29bc:	00003097          	auipc	ra,0x3
    29c0:	f18080e7          	jalr	-232(ra) # 58d4 <exit>
        printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    29c4:	85ce                	mv	a1,s3
    29c6:	00004517          	auipc	a0,0x4
    29ca:	37a50513          	addi	a0,a0,890 # 6d40 <malloc+0x103c>
    29ce:	00003097          	auipc	ra,0x3
    29d2:	27e080e7          	jalr	638(ra) # 5c4c <printf>
        exit(1);
    29d6:	4505                	li	a0,1
    29d8:	00003097          	auipc	ra,0x3
    29dc:	efc080e7          	jalr	-260(ra) # 58d4 <exit>
        printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    29e0:	86aa                	mv	a3,a0
    29e2:	8626                	mv	a2,s1
    29e4:	85ce                	mv	a1,s3
    29e6:	00004517          	auipc	a0,0x4
    29ea:	39250513          	addi	a0,a0,914 # 6d78 <malloc+0x1074>
    29ee:	00003097          	auipc	ra,0x3
    29f2:	25e080e7          	jalr	606(ra) # 5c4c <printf>
        exit(1);
    29f6:	4505                	li	a0,1
    29f8:	00003097          	auipc	ra,0x3
    29fc:	edc080e7          	jalr	-292(ra) # 58d4 <exit>

0000000000002a00 <sbrkarg>:
void sbrkarg(char *s) {
    2a00:	7179                	addi	sp,sp,-48
    2a02:	f406                	sd	ra,40(sp)
    2a04:	f022                	sd	s0,32(sp)
    2a06:	ec26                	sd	s1,24(sp)
    2a08:	e84a                	sd	s2,16(sp)
    2a0a:	e44e                	sd	s3,8(sp)
    2a0c:	1800                	addi	s0,sp,48
    2a0e:	89aa                	mv	s3,a0
    a = sbrk(PGSIZE);
    2a10:	6505                	lui	a0,0x1
    2a12:	00003097          	auipc	ra,0x3
    2a16:	f4a080e7          	jalr	-182(ra) # 595c <sbrk>
    2a1a:	892a                	mv	s2,a0
    fd = open("sbrk", O_CREATE | O_WRONLY);
    2a1c:	20100593          	li	a1,513
    2a20:	00004517          	auipc	a0,0x4
    2a24:	38050513          	addi	a0,a0,896 # 6da0 <malloc+0x109c>
    2a28:	00003097          	auipc	ra,0x3
    2a2c:	eec080e7          	jalr	-276(ra) # 5914 <open>
    2a30:	84aa                	mv	s1,a0
    unlink("sbrk");
    2a32:	00004517          	auipc	a0,0x4
    2a36:	36e50513          	addi	a0,a0,878 # 6da0 <malloc+0x109c>
    2a3a:	00003097          	auipc	ra,0x3
    2a3e:	eea080e7          	jalr	-278(ra) # 5924 <unlink>
    if (fd < 0) {
    2a42:	0404c163          	bltz	s1,2a84 <sbrkarg+0x84>
    if ((n = write(fd, a, PGSIZE)) < 0) {
    2a46:	6605                	lui	a2,0x1
    2a48:	85ca                	mv	a1,s2
    2a4a:	8526                	mv	a0,s1
    2a4c:	00003097          	auipc	ra,0x3
    2a50:	ea8080e7          	jalr	-344(ra) # 58f4 <write>
    2a54:	04054663          	bltz	a0,2aa0 <sbrkarg+0xa0>
    close(fd);
    2a58:	8526                	mv	a0,s1
    2a5a:	00003097          	auipc	ra,0x3
    2a5e:	ea2080e7          	jalr	-350(ra) # 58fc <close>
    a = sbrk(PGSIZE);
    2a62:	6505                	lui	a0,0x1
    2a64:	00003097          	auipc	ra,0x3
    2a68:	ef8080e7          	jalr	-264(ra) # 595c <sbrk>
    if (pipe((int *)a) != 0) {
    2a6c:	00003097          	auipc	ra,0x3
    2a70:	e78080e7          	jalr	-392(ra) # 58e4 <pipe>
    2a74:	e521                	bnez	a0,2abc <sbrkarg+0xbc>
}
    2a76:	70a2                	ld	ra,40(sp)
    2a78:	7402                	ld	s0,32(sp)
    2a7a:	64e2                	ld	s1,24(sp)
    2a7c:	6942                	ld	s2,16(sp)
    2a7e:	69a2                	ld	s3,8(sp)
    2a80:	6145                	addi	sp,sp,48
    2a82:	8082                	ret
        printf("%s: open sbrk failed\n", s);
    2a84:	85ce                	mv	a1,s3
    2a86:	00004517          	auipc	a0,0x4
    2a8a:	32250513          	addi	a0,a0,802 # 6da8 <malloc+0x10a4>
    2a8e:	00003097          	auipc	ra,0x3
    2a92:	1be080e7          	jalr	446(ra) # 5c4c <printf>
        exit(1);
    2a96:	4505                	li	a0,1
    2a98:	00003097          	auipc	ra,0x3
    2a9c:	e3c080e7          	jalr	-452(ra) # 58d4 <exit>
        printf("%s: write sbrk failed\n", s);
    2aa0:	85ce                	mv	a1,s3
    2aa2:	00004517          	auipc	a0,0x4
    2aa6:	31e50513          	addi	a0,a0,798 # 6dc0 <malloc+0x10bc>
    2aaa:	00003097          	auipc	ra,0x3
    2aae:	1a2080e7          	jalr	418(ra) # 5c4c <printf>
        exit(1);
    2ab2:	4505                	li	a0,1
    2ab4:	00003097          	auipc	ra,0x3
    2ab8:	e20080e7          	jalr	-480(ra) # 58d4 <exit>
        printf("%s: pipe() failed\n", s);
    2abc:	85ce                	mv	a1,s3
    2abe:	00004517          	auipc	a0,0x4
    2ac2:	ce250513          	addi	a0,a0,-798 # 67a0 <malloc+0xa9c>
    2ac6:	00003097          	auipc	ra,0x3
    2aca:	186080e7          	jalr	390(ra) # 5c4c <printf>
        exit(1);
    2ace:	4505                	li	a0,1
    2ad0:	00003097          	auipc	ra,0x3
    2ad4:	e04080e7          	jalr	-508(ra) # 58d4 <exit>

0000000000002ad8 <argptest>:
void argptest(char *s) {
    2ad8:	1101                	addi	sp,sp,-32
    2ada:	ec06                	sd	ra,24(sp)
    2adc:	e822                	sd	s0,16(sp)
    2ade:	e426                	sd	s1,8(sp)
    2ae0:	e04a                	sd	s2,0(sp)
    2ae2:	1000                	addi	s0,sp,32
    2ae4:	892a                	mv	s2,a0
    fd = open("init", O_RDONLY);
    2ae6:	4581                	li	a1,0
    2ae8:	00004517          	auipc	a0,0x4
    2aec:	2f050513          	addi	a0,a0,752 # 6dd8 <malloc+0x10d4>
    2af0:	00003097          	auipc	ra,0x3
    2af4:	e24080e7          	jalr	-476(ra) # 5914 <open>
    if (fd < 0) {
    2af8:	02054b63          	bltz	a0,2b2e <argptest+0x56>
    2afc:	84aa                	mv	s1,a0
    read(fd, sbrk(0) - 1, -1);
    2afe:	4501                	li	a0,0
    2b00:	00003097          	auipc	ra,0x3
    2b04:	e5c080e7          	jalr	-420(ra) # 595c <sbrk>
    2b08:	567d                	li	a2,-1
    2b0a:	fff50593          	addi	a1,a0,-1
    2b0e:	8526                	mv	a0,s1
    2b10:	00003097          	auipc	ra,0x3
    2b14:	ddc080e7          	jalr	-548(ra) # 58ec <read>
    close(fd);
    2b18:	8526                	mv	a0,s1
    2b1a:	00003097          	auipc	ra,0x3
    2b1e:	de2080e7          	jalr	-542(ra) # 58fc <close>
}
    2b22:	60e2                	ld	ra,24(sp)
    2b24:	6442                	ld	s0,16(sp)
    2b26:	64a2                	ld	s1,8(sp)
    2b28:	6902                	ld	s2,0(sp)
    2b2a:	6105                	addi	sp,sp,32
    2b2c:	8082                	ret
        printf("%s: open failed\n", s);
    2b2e:	85ca                	mv	a1,s2
    2b30:	00004517          	auipc	a0,0x4
    2b34:	b8050513          	addi	a0,a0,-1152 # 66b0 <malloc+0x9ac>
    2b38:	00003097          	auipc	ra,0x3
    2b3c:	114080e7          	jalr	276(ra) # 5c4c <printf>
        exit(1);
    2b40:	4505                	li	a0,1
    2b42:	00003097          	auipc	ra,0x3
    2b46:	d92080e7          	jalr	-622(ra) # 58d4 <exit>

0000000000002b4a <sbrkbugs>:
void sbrkbugs(char *s) {
    2b4a:	1141                	addi	sp,sp,-16
    2b4c:	e406                	sd	ra,8(sp)
    2b4e:	e022                	sd	s0,0(sp)
    2b50:	0800                	addi	s0,sp,16
    int pid = fork();
    2b52:	00003097          	auipc	ra,0x3
    2b56:	d7a080e7          	jalr	-646(ra) # 58cc <fork>
    if (pid < 0) {
    2b5a:	02054263          	bltz	a0,2b7e <sbrkbugs+0x34>
    if (pid == 0) {
    2b5e:	ed0d                	bnez	a0,2b98 <sbrkbugs+0x4e>
        int sz = (uint64)sbrk(0);
    2b60:	00003097          	auipc	ra,0x3
    2b64:	dfc080e7          	jalr	-516(ra) # 595c <sbrk>
        sbrk(-sz);
    2b68:	40a0053b          	negw	a0,a0
    2b6c:	00003097          	auipc	ra,0x3
    2b70:	df0080e7          	jalr	-528(ra) # 595c <sbrk>
        exit(0);
    2b74:	4501                	li	a0,0
    2b76:	00003097          	auipc	ra,0x3
    2b7a:	d5e080e7          	jalr	-674(ra) # 58d4 <exit>
        printf("fork failed\n");
    2b7e:	00004517          	auipc	a0,0x4
    2b82:	f3a50513          	addi	a0,a0,-198 # 6ab8 <malloc+0xdb4>
    2b86:	00003097          	auipc	ra,0x3
    2b8a:	0c6080e7          	jalr	198(ra) # 5c4c <printf>
        exit(1);
    2b8e:	4505                	li	a0,1
    2b90:	00003097          	auipc	ra,0x3
    2b94:	d44080e7          	jalr	-700(ra) # 58d4 <exit>
    wait(0);
    2b98:	4501                	li	a0,0
    2b9a:	00003097          	auipc	ra,0x3
    2b9e:	d42080e7          	jalr	-702(ra) # 58dc <wait>
    pid = fork();
    2ba2:	00003097          	auipc	ra,0x3
    2ba6:	d2a080e7          	jalr	-726(ra) # 58cc <fork>
    if (pid < 0) {
    2baa:	02054563          	bltz	a0,2bd4 <sbrkbugs+0x8a>
    if (pid == 0) {
    2bae:	e121                	bnez	a0,2bee <sbrkbugs+0xa4>
        int sz = (uint64)sbrk(0);
    2bb0:	00003097          	auipc	ra,0x3
    2bb4:	dac080e7          	jalr	-596(ra) # 595c <sbrk>
        sbrk(-(sz - 3500));
    2bb8:	6785                	lui	a5,0x1
    2bba:	dac7879b          	addiw	a5,a5,-596 # dac <linktest+0x98>
    2bbe:	40a7853b          	subw	a0,a5,a0
    2bc2:	00003097          	auipc	ra,0x3
    2bc6:	d9a080e7          	jalr	-614(ra) # 595c <sbrk>
        exit(0);
    2bca:	4501                	li	a0,0
    2bcc:	00003097          	auipc	ra,0x3
    2bd0:	d08080e7          	jalr	-760(ra) # 58d4 <exit>
        printf("fork failed\n");
    2bd4:	00004517          	auipc	a0,0x4
    2bd8:	ee450513          	addi	a0,a0,-284 # 6ab8 <malloc+0xdb4>
    2bdc:	00003097          	auipc	ra,0x3
    2be0:	070080e7          	jalr	112(ra) # 5c4c <printf>
        exit(1);
    2be4:	4505                	li	a0,1
    2be6:	00003097          	auipc	ra,0x3
    2bea:	cee080e7          	jalr	-786(ra) # 58d4 <exit>
    wait(0);
    2bee:	4501                	li	a0,0
    2bf0:	00003097          	auipc	ra,0x3
    2bf4:	cec080e7          	jalr	-788(ra) # 58dc <wait>
    pid = fork();
    2bf8:	00003097          	auipc	ra,0x3
    2bfc:	cd4080e7          	jalr	-812(ra) # 58cc <fork>
    if (pid < 0) {
    2c00:	02054a63          	bltz	a0,2c34 <sbrkbugs+0xea>
    if (pid == 0) {
    2c04:	e529                	bnez	a0,2c4e <sbrkbugs+0x104>
        sbrk((10 * 4096 + 2048) - (uint64)sbrk(0));
    2c06:	00003097          	auipc	ra,0x3
    2c0a:	d56080e7          	jalr	-682(ra) # 595c <sbrk>
    2c0e:	67ad                	lui	a5,0xb
    2c10:	8007879b          	addiw	a5,a5,-2048 # a800 <__global_pointer$+0x744>
    2c14:	40a7853b          	subw	a0,a5,a0
    2c18:	00003097          	auipc	ra,0x3
    2c1c:	d44080e7          	jalr	-700(ra) # 595c <sbrk>
        sbrk(-10);
    2c20:	5559                	li	a0,-10
    2c22:	00003097          	auipc	ra,0x3
    2c26:	d3a080e7          	jalr	-710(ra) # 595c <sbrk>
        exit(0);
    2c2a:	4501                	li	a0,0
    2c2c:	00003097          	auipc	ra,0x3
    2c30:	ca8080e7          	jalr	-856(ra) # 58d4 <exit>
        printf("fork failed\n");
    2c34:	00004517          	auipc	a0,0x4
    2c38:	e8450513          	addi	a0,a0,-380 # 6ab8 <malloc+0xdb4>
    2c3c:	00003097          	auipc	ra,0x3
    2c40:	010080e7          	jalr	16(ra) # 5c4c <printf>
        exit(1);
    2c44:	4505                	li	a0,1
    2c46:	00003097          	auipc	ra,0x3
    2c4a:	c8e080e7          	jalr	-882(ra) # 58d4 <exit>
    wait(0);
    2c4e:	4501                	li	a0,0
    2c50:	00003097          	auipc	ra,0x3
    2c54:	c8c080e7          	jalr	-884(ra) # 58dc <wait>
    exit(0);
    2c58:	4501                	li	a0,0
    2c5a:	00003097          	auipc	ra,0x3
    2c5e:	c7a080e7          	jalr	-902(ra) # 58d4 <exit>

0000000000002c62 <sbrklast>:
void sbrklast(char *s) {
    2c62:	7179                	addi	sp,sp,-48
    2c64:	f406                	sd	ra,40(sp)
    2c66:	f022                	sd	s0,32(sp)
    2c68:	ec26                	sd	s1,24(sp)
    2c6a:	e84a                	sd	s2,16(sp)
    2c6c:	e44e                	sd	s3,8(sp)
    2c6e:	e052                	sd	s4,0(sp)
    2c70:	1800                	addi	s0,sp,48
    uint64 top = (uint64)sbrk(0);
    2c72:	4501                	li	a0,0
    2c74:	00003097          	auipc	ra,0x3
    2c78:	ce8080e7          	jalr	-792(ra) # 595c <sbrk>
    if ((top % 4096) != 0)
    2c7c:	03451793          	slli	a5,a0,0x34
    2c80:	ebd9                	bnez	a5,2d16 <sbrklast+0xb4>
    sbrk(4096);
    2c82:	6505                	lui	a0,0x1
    2c84:	00003097          	auipc	ra,0x3
    2c88:	cd8080e7          	jalr	-808(ra) # 595c <sbrk>
    sbrk(10);
    2c8c:	4529                	li	a0,10
    2c8e:	00003097          	auipc	ra,0x3
    2c92:	cce080e7          	jalr	-818(ra) # 595c <sbrk>
    sbrk(-20);
    2c96:	5531                	li	a0,-20
    2c98:	00003097          	auipc	ra,0x3
    2c9c:	cc4080e7          	jalr	-828(ra) # 595c <sbrk>
    top = (uint64)sbrk(0);
    2ca0:	4501                	li	a0,0
    2ca2:	00003097          	auipc	ra,0x3
    2ca6:	cba080e7          	jalr	-838(ra) # 595c <sbrk>
    2caa:	84aa                	mv	s1,a0
    char *p = (char *)(top - 64);
    2cac:	fc050913          	addi	s2,a0,-64 # fc0 <bigdir+0x60>
    p[0] = 'x';
    2cb0:	07800a13          	li	s4,120
    2cb4:	fd450023          	sb	s4,-64(a0)
    p[1] = '\0';
    2cb8:	fc0500a3          	sb	zero,-63(a0)
    int fd = open(p, O_RDWR | O_CREATE);
    2cbc:	20200593          	li	a1,514
    2cc0:	854a                	mv	a0,s2
    2cc2:	00003097          	auipc	ra,0x3
    2cc6:	c52080e7          	jalr	-942(ra) # 5914 <open>
    2cca:	89aa                	mv	s3,a0
    write(fd, p, 1);
    2ccc:	4605                	li	a2,1
    2cce:	85ca                	mv	a1,s2
    2cd0:	00003097          	auipc	ra,0x3
    2cd4:	c24080e7          	jalr	-988(ra) # 58f4 <write>
    close(fd);
    2cd8:	854e                	mv	a0,s3
    2cda:	00003097          	auipc	ra,0x3
    2cde:	c22080e7          	jalr	-990(ra) # 58fc <close>
    fd = open(p, O_RDWR);
    2ce2:	4589                	li	a1,2
    2ce4:	854a                	mv	a0,s2
    2ce6:	00003097          	auipc	ra,0x3
    2cea:	c2e080e7          	jalr	-978(ra) # 5914 <open>
    p[0] = '\0';
    2cee:	fc048023          	sb	zero,-64(s1)
    read(fd, p, 1);
    2cf2:	4605                	li	a2,1
    2cf4:	85ca                	mv	a1,s2
    2cf6:	00003097          	auipc	ra,0x3
    2cfa:	bf6080e7          	jalr	-1034(ra) # 58ec <read>
    if (p[0] != 'x')
    2cfe:	fc04c783          	lbu	a5,-64(s1)
    2d02:	03479463          	bne	a5,s4,2d2a <sbrklast+0xc8>
}
    2d06:	70a2                	ld	ra,40(sp)
    2d08:	7402                	ld	s0,32(sp)
    2d0a:	64e2                	ld	s1,24(sp)
    2d0c:	6942                	ld	s2,16(sp)
    2d0e:	69a2                	ld	s3,8(sp)
    2d10:	6a02                	ld	s4,0(sp)
    2d12:	6145                	addi	sp,sp,48
    2d14:	8082                	ret
        sbrk(4096 - (top % 4096));
    2d16:	0347d513          	srli	a0,a5,0x34
    2d1a:	6785                	lui	a5,0x1
    2d1c:	40a7853b          	subw	a0,a5,a0
    2d20:	00003097          	auipc	ra,0x3
    2d24:	c3c080e7          	jalr	-964(ra) # 595c <sbrk>
    2d28:	bfa9                	j	2c82 <sbrklast+0x20>
        exit(1);
    2d2a:	4505                	li	a0,1
    2d2c:	00003097          	auipc	ra,0x3
    2d30:	ba8080e7          	jalr	-1112(ra) # 58d4 <exit>

0000000000002d34 <sbrk8000>:
void sbrk8000(char *s) {
    2d34:	1141                	addi	sp,sp,-16
    2d36:	e406                	sd	ra,8(sp)
    2d38:	e022                	sd	s0,0(sp)
    2d3a:	0800                	addi	s0,sp,16
    sbrk(0x80000004);
    2d3c:	80000537          	lui	a0,0x80000
    2d40:	0511                	addi	a0,a0,4 # ffffffff80000004 <__BSS_END__+0xffffffff7ffeff14>
    2d42:	00003097          	auipc	ra,0x3
    2d46:	c1a080e7          	jalr	-998(ra) # 595c <sbrk>
    volatile char *top = sbrk(0);
    2d4a:	4501                	li	a0,0
    2d4c:	00003097          	auipc	ra,0x3
    2d50:	c10080e7          	jalr	-1008(ra) # 595c <sbrk>
    *(top - 1) = *(top - 1) + 1;
    2d54:	fff54783          	lbu	a5,-1(a0)
    2d58:	2785                	addiw	a5,a5,1 # 1001 <bigdir+0xa1>
    2d5a:	0ff7f793          	zext.b	a5,a5
    2d5e:	fef50fa3          	sb	a5,-1(a0)
}
    2d62:	60a2                	ld	ra,8(sp)
    2d64:	6402                	ld	s0,0(sp)
    2d66:	0141                	addi	sp,sp,16
    2d68:	8082                	ret

0000000000002d6a <execout>:
}

// test the exec() code that cleans up if it runs out
// of memory. it's really a test that such a condition
// doesn't cause a panic.
void execout(char *s) {
    2d6a:	715d                	addi	sp,sp,-80
    2d6c:	e486                	sd	ra,72(sp)
    2d6e:	e0a2                	sd	s0,64(sp)
    2d70:	fc26                	sd	s1,56(sp)
    2d72:	f84a                	sd	s2,48(sp)
    2d74:	f44e                	sd	s3,40(sp)
    2d76:	f052                	sd	s4,32(sp)
    2d78:	0880                	addi	s0,sp,80
    for (int avail = 0; avail < 15; avail++) {
    2d7a:	4901                	li	s2,0
    2d7c:	49bd                	li	s3,15
        int pid = fork();
    2d7e:	00003097          	auipc	ra,0x3
    2d82:	b4e080e7          	jalr	-1202(ra) # 58cc <fork>
    2d86:	84aa                	mv	s1,a0
        if (pid < 0) {
    2d88:	02054063          	bltz	a0,2da8 <execout+0x3e>
            printf("fork failed\n");
            exit(1);
        } else if (pid == 0) {
    2d8c:	c91d                	beqz	a0,2dc2 <execout+0x58>
            close(1);
            char *args[] = {"echo", "x", 0};
            exec("echo", args);
            exit(0);
        } else {
            wait((int *)0);
    2d8e:	4501                	li	a0,0
    2d90:	00003097          	auipc	ra,0x3
    2d94:	b4c080e7          	jalr	-1204(ra) # 58dc <wait>
    for (int avail = 0; avail < 15; avail++) {
    2d98:	2905                	addiw	s2,s2,1
    2d9a:	ff3912e3          	bne	s2,s3,2d7e <execout+0x14>
        }
    }

    exit(0);
    2d9e:	4501                	li	a0,0
    2da0:	00003097          	auipc	ra,0x3
    2da4:	b34080e7          	jalr	-1228(ra) # 58d4 <exit>
            printf("fork failed\n");
    2da8:	00004517          	auipc	a0,0x4
    2dac:	d1050513          	addi	a0,a0,-752 # 6ab8 <malloc+0xdb4>
    2db0:	00003097          	auipc	ra,0x3
    2db4:	e9c080e7          	jalr	-356(ra) # 5c4c <printf>
            exit(1);
    2db8:	4505                	li	a0,1
    2dba:	00003097          	auipc	ra,0x3
    2dbe:	b1a080e7          	jalr	-1254(ra) # 58d4 <exit>
                if (a == 0xffffffffffffffffLL)
    2dc2:	59fd                	li	s3,-1
                *(char *)(a + 4096 - 1) = 1;
    2dc4:	4a05                	li	s4,1
                uint64 a = (uint64)sbrk(4096);
    2dc6:	6505                	lui	a0,0x1
    2dc8:	00003097          	auipc	ra,0x3
    2dcc:	b94080e7          	jalr	-1132(ra) # 595c <sbrk>
                if (a == 0xffffffffffffffffLL)
    2dd0:	01350763          	beq	a0,s3,2dde <execout+0x74>
                *(char *)(a + 4096 - 1) = 1;
    2dd4:	6785                	lui	a5,0x1
    2dd6:	97aa                	add	a5,a5,a0
    2dd8:	ff478fa3          	sb	s4,-1(a5) # fff <bigdir+0x9f>
            while (1) {
    2ddc:	b7ed                	j	2dc6 <execout+0x5c>
            for (int i = 0; i < avail; i++)
    2dde:	01205a63          	blez	s2,2df2 <execout+0x88>
                sbrk(-4096);
    2de2:	757d                	lui	a0,0xfffff
    2de4:	00003097          	auipc	ra,0x3
    2de8:	b78080e7          	jalr	-1160(ra) # 595c <sbrk>
            for (int i = 0; i < avail; i++)
    2dec:	2485                	addiw	s1,s1,1
    2dee:	ff249ae3          	bne	s1,s2,2de2 <execout+0x78>
            close(1);
    2df2:	4505                	li	a0,1
    2df4:	00003097          	auipc	ra,0x3
    2df8:	b08080e7          	jalr	-1272(ra) # 58fc <close>
            char *args[] = {"echo", "x", 0};
    2dfc:	00003517          	auipc	a0,0x3
    2e00:	04450513          	addi	a0,a0,68 # 5e40 <malloc+0x13c>
    2e04:	faa43c23          	sd	a0,-72(s0)
    2e08:	00003797          	auipc	a5,0x3
    2e0c:	0a878793          	addi	a5,a5,168 # 5eb0 <malloc+0x1ac>
    2e10:	fcf43023          	sd	a5,-64(s0)
    2e14:	fc043423          	sd	zero,-56(s0)
            exec("echo", args);
    2e18:	fb840593          	addi	a1,s0,-72
    2e1c:	00003097          	auipc	ra,0x3
    2e20:	af0080e7          	jalr	-1296(ra) # 590c <exec>
            exit(0);
    2e24:	4501                	li	a0,0
    2e26:	00003097          	auipc	ra,0x3
    2e2a:	aae080e7          	jalr	-1362(ra) # 58d4 <exit>

0000000000002e2e <fourteen>:
void fourteen(char *s) {
    2e2e:	1101                	addi	sp,sp,-32
    2e30:	ec06                	sd	ra,24(sp)
    2e32:	e822                	sd	s0,16(sp)
    2e34:	e426                	sd	s1,8(sp)
    2e36:	1000                	addi	s0,sp,32
    2e38:	84aa                	mv	s1,a0
    if (mkdir("12345678901234") != 0) {
    2e3a:	00004517          	auipc	a0,0x4
    2e3e:	17650513          	addi	a0,a0,374 # 6fb0 <malloc+0x12ac>
    2e42:	00003097          	auipc	ra,0x3
    2e46:	afa080e7          	jalr	-1286(ra) # 593c <mkdir>
    2e4a:	e165                	bnez	a0,2f2a <fourteen+0xfc>
    if (mkdir("12345678901234/123456789012345") != 0) {
    2e4c:	00004517          	auipc	a0,0x4
    2e50:	fbc50513          	addi	a0,a0,-68 # 6e08 <malloc+0x1104>
    2e54:	00003097          	auipc	ra,0x3
    2e58:	ae8080e7          	jalr	-1304(ra) # 593c <mkdir>
    2e5c:	e56d                	bnez	a0,2f46 <fourteen+0x118>
    fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2e5e:	20000593          	li	a1,512
    2e62:	00004517          	auipc	a0,0x4
    2e66:	ffe50513          	addi	a0,a0,-2 # 6e60 <malloc+0x115c>
    2e6a:	00003097          	auipc	ra,0x3
    2e6e:	aaa080e7          	jalr	-1366(ra) # 5914 <open>
    if (fd < 0) {
    2e72:	0e054863          	bltz	a0,2f62 <fourteen+0x134>
    close(fd);
    2e76:	00003097          	auipc	ra,0x3
    2e7a:	a86080e7          	jalr	-1402(ra) # 58fc <close>
    fd = open("12345678901234/12345678901234/12345678901234", 0);
    2e7e:	4581                	li	a1,0
    2e80:	00004517          	auipc	a0,0x4
    2e84:	05850513          	addi	a0,a0,88 # 6ed8 <malloc+0x11d4>
    2e88:	00003097          	auipc	ra,0x3
    2e8c:	a8c080e7          	jalr	-1396(ra) # 5914 <open>
    if (fd < 0) {
    2e90:	0e054763          	bltz	a0,2f7e <fourteen+0x150>
    close(fd);
    2e94:	00003097          	auipc	ra,0x3
    2e98:	a68080e7          	jalr	-1432(ra) # 58fc <close>
    if (mkdir("12345678901234/12345678901234") == 0) {
    2e9c:	00004517          	auipc	a0,0x4
    2ea0:	0ac50513          	addi	a0,a0,172 # 6f48 <malloc+0x1244>
    2ea4:	00003097          	auipc	ra,0x3
    2ea8:	a98080e7          	jalr	-1384(ra) # 593c <mkdir>
    2eac:	c57d                	beqz	a0,2f9a <fourteen+0x16c>
    if (mkdir("123456789012345/12345678901234") == 0) {
    2eae:	00004517          	auipc	a0,0x4
    2eb2:	0f250513          	addi	a0,a0,242 # 6fa0 <malloc+0x129c>
    2eb6:	00003097          	auipc	ra,0x3
    2eba:	a86080e7          	jalr	-1402(ra) # 593c <mkdir>
    2ebe:	cd65                	beqz	a0,2fb6 <fourteen+0x188>
    unlink("123456789012345/12345678901234");
    2ec0:	00004517          	auipc	a0,0x4
    2ec4:	0e050513          	addi	a0,a0,224 # 6fa0 <malloc+0x129c>
    2ec8:	00003097          	auipc	ra,0x3
    2ecc:	a5c080e7          	jalr	-1444(ra) # 5924 <unlink>
    unlink("12345678901234/12345678901234");
    2ed0:	00004517          	auipc	a0,0x4
    2ed4:	07850513          	addi	a0,a0,120 # 6f48 <malloc+0x1244>
    2ed8:	00003097          	auipc	ra,0x3
    2edc:	a4c080e7          	jalr	-1460(ra) # 5924 <unlink>
    unlink("12345678901234/12345678901234/12345678901234");
    2ee0:	00004517          	auipc	a0,0x4
    2ee4:	ff850513          	addi	a0,a0,-8 # 6ed8 <malloc+0x11d4>
    2ee8:	00003097          	auipc	ra,0x3
    2eec:	a3c080e7          	jalr	-1476(ra) # 5924 <unlink>
    unlink("123456789012345/123456789012345/123456789012345");
    2ef0:	00004517          	auipc	a0,0x4
    2ef4:	f7050513          	addi	a0,a0,-144 # 6e60 <malloc+0x115c>
    2ef8:	00003097          	auipc	ra,0x3
    2efc:	a2c080e7          	jalr	-1492(ra) # 5924 <unlink>
    unlink("12345678901234/123456789012345");
    2f00:	00004517          	auipc	a0,0x4
    2f04:	f0850513          	addi	a0,a0,-248 # 6e08 <malloc+0x1104>
    2f08:	00003097          	auipc	ra,0x3
    2f0c:	a1c080e7          	jalr	-1508(ra) # 5924 <unlink>
    unlink("12345678901234");
    2f10:	00004517          	auipc	a0,0x4
    2f14:	0a050513          	addi	a0,a0,160 # 6fb0 <malloc+0x12ac>
    2f18:	00003097          	auipc	ra,0x3
    2f1c:	a0c080e7          	jalr	-1524(ra) # 5924 <unlink>
}
    2f20:	60e2                	ld	ra,24(sp)
    2f22:	6442                	ld	s0,16(sp)
    2f24:	64a2                	ld	s1,8(sp)
    2f26:	6105                	addi	sp,sp,32
    2f28:	8082                	ret
        printf("%s: mkdir 12345678901234 failed\n", s);
    2f2a:	85a6                	mv	a1,s1
    2f2c:	00004517          	auipc	a0,0x4
    2f30:	eb450513          	addi	a0,a0,-332 # 6de0 <malloc+0x10dc>
    2f34:	00003097          	auipc	ra,0x3
    2f38:	d18080e7          	jalr	-744(ra) # 5c4c <printf>
        exit(1);
    2f3c:	4505                	li	a0,1
    2f3e:	00003097          	auipc	ra,0x3
    2f42:	996080e7          	jalr	-1642(ra) # 58d4 <exit>
        printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    2f46:	85a6                	mv	a1,s1
    2f48:	00004517          	auipc	a0,0x4
    2f4c:	ee050513          	addi	a0,a0,-288 # 6e28 <malloc+0x1124>
    2f50:	00003097          	auipc	ra,0x3
    2f54:	cfc080e7          	jalr	-772(ra) # 5c4c <printf>
        exit(1);
    2f58:	4505                	li	a0,1
    2f5a:	00003097          	auipc	ra,0x3
    2f5e:	97a080e7          	jalr	-1670(ra) # 58d4 <exit>
        printf("%s: create 123456789012345/123456789012345/123456789012345 "
    2f62:	85a6                	mv	a1,s1
    2f64:	00004517          	auipc	a0,0x4
    2f68:	f2c50513          	addi	a0,a0,-212 # 6e90 <malloc+0x118c>
    2f6c:	00003097          	auipc	ra,0x3
    2f70:	ce0080e7          	jalr	-800(ra) # 5c4c <printf>
        exit(1);
    2f74:	4505                	li	a0,1
    2f76:	00003097          	auipc	ra,0x3
    2f7a:	95e080e7          	jalr	-1698(ra) # 58d4 <exit>
        printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n",
    2f7e:	85a6                	mv	a1,s1
    2f80:	00004517          	auipc	a0,0x4
    2f84:	f8850513          	addi	a0,a0,-120 # 6f08 <malloc+0x1204>
    2f88:	00003097          	auipc	ra,0x3
    2f8c:	cc4080e7          	jalr	-828(ra) # 5c4c <printf>
        exit(1);
    2f90:	4505                	li	a0,1
    2f92:	00003097          	auipc	ra,0x3
    2f96:	942080e7          	jalr	-1726(ra) # 58d4 <exit>
        printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    2f9a:	85a6                	mv	a1,s1
    2f9c:	00004517          	auipc	a0,0x4
    2fa0:	fcc50513          	addi	a0,a0,-52 # 6f68 <malloc+0x1264>
    2fa4:	00003097          	auipc	ra,0x3
    2fa8:	ca8080e7          	jalr	-856(ra) # 5c4c <printf>
        exit(1);
    2fac:	4505                	li	a0,1
    2fae:	00003097          	auipc	ra,0x3
    2fb2:	926080e7          	jalr	-1754(ra) # 58d4 <exit>
        printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    2fb6:	85a6                	mv	a1,s1
    2fb8:	00004517          	auipc	a0,0x4
    2fbc:	00850513          	addi	a0,a0,8 # 6fc0 <malloc+0x12bc>
    2fc0:	00003097          	auipc	ra,0x3
    2fc4:	c8c080e7          	jalr	-884(ra) # 5c4c <printf>
        exit(1);
    2fc8:	4505                	li	a0,1
    2fca:	00003097          	auipc	ra,0x3
    2fce:	90a080e7          	jalr	-1782(ra) # 58d4 <exit>

0000000000002fd2 <iputtest>:
void iputtest(char *s) {
    2fd2:	1101                	addi	sp,sp,-32
    2fd4:	ec06                	sd	ra,24(sp)
    2fd6:	e822                	sd	s0,16(sp)
    2fd8:	e426                	sd	s1,8(sp)
    2fda:	1000                	addi	s0,sp,32
    2fdc:	84aa                	mv	s1,a0
    if (mkdir("iputdir") < 0) {
    2fde:	00004517          	auipc	a0,0x4
    2fe2:	01a50513          	addi	a0,a0,26 # 6ff8 <malloc+0x12f4>
    2fe6:	00003097          	auipc	ra,0x3
    2fea:	956080e7          	jalr	-1706(ra) # 593c <mkdir>
    2fee:	04054563          	bltz	a0,3038 <iputtest+0x66>
    if (chdir("iputdir") < 0) {
    2ff2:	00004517          	auipc	a0,0x4
    2ff6:	00650513          	addi	a0,a0,6 # 6ff8 <malloc+0x12f4>
    2ffa:	00003097          	auipc	ra,0x3
    2ffe:	94a080e7          	jalr	-1718(ra) # 5944 <chdir>
    3002:	04054963          	bltz	a0,3054 <iputtest+0x82>
    if (unlink("../iputdir") < 0) {
    3006:	00004517          	auipc	a0,0x4
    300a:	03250513          	addi	a0,a0,50 # 7038 <malloc+0x1334>
    300e:	00003097          	auipc	ra,0x3
    3012:	916080e7          	jalr	-1770(ra) # 5924 <unlink>
    3016:	04054d63          	bltz	a0,3070 <iputtest+0x9e>
    if (chdir("/") < 0) {
    301a:	00004517          	auipc	a0,0x4
    301e:	04e50513          	addi	a0,a0,78 # 7068 <malloc+0x1364>
    3022:	00003097          	auipc	ra,0x3
    3026:	922080e7          	jalr	-1758(ra) # 5944 <chdir>
    302a:	06054163          	bltz	a0,308c <iputtest+0xba>
}
    302e:	60e2                	ld	ra,24(sp)
    3030:	6442                	ld	s0,16(sp)
    3032:	64a2                	ld	s1,8(sp)
    3034:	6105                	addi	sp,sp,32
    3036:	8082                	ret
        printf("%s: mkdir failed\n", s);
    3038:	85a6                	mv	a1,s1
    303a:	00004517          	auipc	a0,0x4
    303e:	fc650513          	addi	a0,a0,-58 # 7000 <malloc+0x12fc>
    3042:	00003097          	auipc	ra,0x3
    3046:	c0a080e7          	jalr	-1014(ra) # 5c4c <printf>
        exit(1);
    304a:	4505                	li	a0,1
    304c:	00003097          	auipc	ra,0x3
    3050:	888080e7          	jalr	-1912(ra) # 58d4 <exit>
        printf("%s: chdir iputdir failed\n", s);
    3054:	85a6                	mv	a1,s1
    3056:	00004517          	auipc	a0,0x4
    305a:	fc250513          	addi	a0,a0,-62 # 7018 <malloc+0x1314>
    305e:	00003097          	auipc	ra,0x3
    3062:	bee080e7          	jalr	-1042(ra) # 5c4c <printf>
        exit(1);
    3066:	4505                	li	a0,1
    3068:	00003097          	auipc	ra,0x3
    306c:	86c080e7          	jalr	-1940(ra) # 58d4 <exit>
        printf("%s: unlink ../iputdir failed\n", s);
    3070:	85a6                	mv	a1,s1
    3072:	00004517          	auipc	a0,0x4
    3076:	fd650513          	addi	a0,a0,-42 # 7048 <malloc+0x1344>
    307a:	00003097          	auipc	ra,0x3
    307e:	bd2080e7          	jalr	-1070(ra) # 5c4c <printf>
        exit(1);
    3082:	4505                	li	a0,1
    3084:	00003097          	auipc	ra,0x3
    3088:	850080e7          	jalr	-1968(ra) # 58d4 <exit>
        printf("%s: chdir / failed\n", s);
    308c:	85a6                	mv	a1,s1
    308e:	00004517          	auipc	a0,0x4
    3092:	fe250513          	addi	a0,a0,-30 # 7070 <malloc+0x136c>
    3096:	00003097          	auipc	ra,0x3
    309a:	bb6080e7          	jalr	-1098(ra) # 5c4c <printf>
        exit(1);
    309e:	4505                	li	a0,1
    30a0:	00003097          	auipc	ra,0x3
    30a4:	834080e7          	jalr	-1996(ra) # 58d4 <exit>

00000000000030a8 <exitiputtest>:
void exitiputtest(char *s) {
    30a8:	7179                	addi	sp,sp,-48
    30aa:	f406                	sd	ra,40(sp)
    30ac:	f022                	sd	s0,32(sp)
    30ae:	ec26                	sd	s1,24(sp)
    30b0:	1800                	addi	s0,sp,48
    30b2:	84aa                	mv	s1,a0
    pid = fork();
    30b4:	00003097          	auipc	ra,0x3
    30b8:	818080e7          	jalr	-2024(ra) # 58cc <fork>
    if (pid < 0) {
    30bc:	04054663          	bltz	a0,3108 <exitiputtest+0x60>
    if (pid == 0) {
    30c0:	ed45                	bnez	a0,3178 <exitiputtest+0xd0>
        if (mkdir("iputdir") < 0) {
    30c2:	00004517          	auipc	a0,0x4
    30c6:	f3650513          	addi	a0,a0,-202 # 6ff8 <malloc+0x12f4>
    30ca:	00003097          	auipc	ra,0x3
    30ce:	872080e7          	jalr	-1934(ra) # 593c <mkdir>
    30d2:	04054963          	bltz	a0,3124 <exitiputtest+0x7c>
        if (chdir("iputdir") < 0) {
    30d6:	00004517          	auipc	a0,0x4
    30da:	f2250513          	addi	a0,a0,-222 # 6ff8 <malloc+0x12f4>
    30de:	00003097          	auipc	ra,0x3
    30e2:	866080e7          	jalr	-1946(ra) # 5944 <chdir>
    30e6:	04054d63          	bltz	a0,3140 <exitiputtest+0x98>
        if (unlink("../iputdir") < 0) {
    30ea:	00004517          	auipc	a0,0x4
    30ee:	f4e50513          	addi	a0,a0,-178 # 7038 <malloc+0x1334>
    30f2:	00003097          	auipc	ra,0x3
    30f6:	832080e7          	jalr	-1998(ra) # 5924 <unlink>
    30fa:	06054163          	bltz	a0,315c <exitiputtest+0xb4>
        exit(0);
    30fe:	4501                	li	a0,0
    3100:	00002097          	auipc	ra,0x2
    3104:	7d4080e7          	jalr	2004(ra) # 58d4 <exit>
        printf("%s: fork failed\n", s);
    3108:	85a6                	mv	a1,s1
    310a:	00003517          	auipc	a0,0x3
    310e:	58e50513          	addi	a0,a0,1422 # 6698 <malloc+0x994>
    3112:	00003097          	auipc	ra,0x3
    3116:	b3a080e7          	jalr	-1222(ra) # 5c4c <printf>
        exit(1);
    311a:	4505                	li	a0,1
    311c:	00002097          	auipc	ra,0x2
    3120:	7b8080e7          	jalr	1976(ra) # 58d4 <exit>
            printf("%s: mkdir failed\n", s);
    3124:	85a6                	mv	a1,s1
    3126:	00004517          	auipc	a0,0x4
    312a:	eda50513          	addi	a0,a0,-294 # 7000 <malloc+0x12fc>
    312e:	00003097          	auipc	ra,0x3
    3132:	b1e080e7          	jalr	-1250(ra) # 5c4c <printf>
            exit(1);
    3136:	4505                	li	a0,1
    3138:	00002097          	auipc	ra,0x2
    313c:	79c080e7          	jalr	1948(ra) # 58d4 <exit>
            printf("%s: child chdir failed\n", s);
    3140:	85a6                	mv	a1,s1
    3142:	00004517          	auipc	a0,0x4
    3146:	f4650513          	addi	a0,a0,-186 # 7088 <malloc+0x1384>
    314a:	00003097          	auipc	ra,0x3
    314e:	b02080e7          	jalr	-1278(ra) # 5c4c <printf>
            exit(1);
    3152:	4505                	li	a0,1
    3154:	00002097          	auipc	ra,0x2
    3158:	780080e7          	jalr	1920(ra) # 58d4 <exit>
            printf("%s: unlink ../iputdir failed\n", s);
    315c:	85a6                	mv	a1,s1
    315e:	00004517          	auipc	a0,0x4
    3162:	eea50513          	addi	a0,a0,-278 # 7048 <malloc+0x1344>
    3166:	00003097          	auipc	ra,0x3
    316a:	ae6080e7          	jalr	-1306(ra) # 5c4c <printf>
            exit(1);
    316e:	4505                	li	a0,1
    3170:	00002097          	auipc	ra,0x2
    3174:	764080e7          	jalr	1892(ra) # 58d4 <exit>
    wait(&xstatus);
    3178:	fdc40513          	addi	a0,s0,-36
    317c:	00002097          	auipc	ra,0x2
    3180:	760080e7          	jalr	1888(ra) # 58dc <wait>
    exit(xstatus);
    3184:	fdc42503          	lw	a0,-36(s0)
    3188:	00002097          	auipc	ra,0x2
    318c:	74c080e7          	jalr	1868(ra) # 58d4 <exit>

0000000000003190 <dirtest>:
void dirtest(char *s) {
    3190:	1101                	addi	sp,sp,-32
    3192:	ec06                	sd	ra,24(sp)
    3194:	e822                	sd	s0,16(sp)
    3196:	e426                	sd	s1,8(sp)
    3198:	1000                	addi	s0,sp,32
    319a:	84aa                	mv	s1,a0
    if (mkdir("dir0") < 0) {
    319c:	00004517          	auipc	a0,0x4
    31a0:	f0450513          	addi	a0,a0,-252 # 70a0 <malloc+0x139c>
    31a4:	00002097          	auipc	ra,0x2
    31a8:	798080e7          	jalr	1944(ra) # 593c <mkdir>
    31ac:	04054563          	bltz	a0,31f6 <dirtest+0x66>
    if (chdir("dir0") < 0) {
    31b0:	00004517          	auipc	a0,0x4
    31b4:	ef050513          	addi	a0,a0,-272 # 70a0 <malloc+0x139c>
    31b8:	00002097          	auipc	ra,0x2
    31bc:	78c080e7          	jalr	1932(ra) # 5944 <chdir>
    31c0:	04054963          	bltz	a0,3212 <dirtest+0x82>
    if (chdir("..") < 0) {
    31c4:	00004517          	auipc	a0,0x4
    31c8:	efc50513          	addi	a0,a0,-260 # 70c0 <malloc+0x13bc>
    31cc:	00002097          	auipc	ra,0x2
    31d0:	778080e7          	jalr	1912(ra) # 5944 <chdir>
    31d4:	04054d63          	bltz	a0,322e <dirtest+0x9e>
    if (unlink("dir0") < 0) {
    31d8:	00004517          	auipc	a0,0x4
    31dc:	ec850513          	addi	a0,a0,-312 # 70a0 <malloc+0x139c>
    31e0:	00002097          	auipc	ra,0x2
    31e4:	744080e7          	jalr	1860(ra) # 5924 <unlink>
    31e8:	06054163          	bltz	a0,324a <dirtest+0xba>
}
    31ec:	60e2                	ld	ra,24(sp)
    31ee:	6442                	ld	s0,16(sp)
    31f0:	64a2                	ld	s1,8(sp)
    31f2:	6105                	addi	sp,sp,32
    31f4:	8082                	ret
        printf("%s: mkdir failed\n", s);
    31f6:	85a6                	mv	a1,s1
    31f8:	00004517          	auipc	a0,0x4
    31fc:	e0850513          	addi	a0,a0,-504 # 7000 <malloc+0x12fc>
    3200:	00003097          	auipc	ra,0x3
    3204:	a4c080e7          	jalr	-1460(ra) # 5c4c <printf>
        exit(1);
    3208:	4505                	li	a0,1
    320a:	00002097          	auipc	ra,0x2
    320e:	6ca080e7          	jalr	1738(ra) # 58d4 <exit>
        printf("%s: chdir dir0 failed\n", s);
    3212:	85a6                	mv	a1,s1
    3214:	00004517          	auipc	a0,0x4
    3218:	e9450513          	addi	a0,a0,-364 # 70a8 <malloc+0x13a4>
    321c:	00003097          	auipc	ra,0x3
    3220:	a30080e7          	jalr	-1488(ra) # 5c4c <printf>
        exit(1);
    3224:	4505                	li	a0,1
    3226:	00002097          	auipc	ra,0x2
    322a:	6ae080e7          	jalr	1710(ra) # 58d4 <exit>
        printf("%s: chdir .. failed\n", s);
    322e:	85a6                	mv	a1,s1
    3230:	00004517          	auipc	a0,0x4
    3234:	e9850513          	addi	a0,a0,-360 # 70c8 <malloc+0x13c4>
    3238:	00003097          	auipc	ra,0x3
    323c:	a14080e7          	jalr	-1516(ra) # 5c4c <printf>
        exit(1);
    3240:	4505                	li	a0,1
    3242:	00002097          	auipc	ra,0x2
    3246:	692080e7          	jalr	1682(ra) # 58d4 <exit>
        printf("%s: unlink dir0 failed\n", s);
    324a:	85a6                	mv	a1,s1
    324c:	00004517          	auipc	a0,0x4
    3250:	e9450513          	addi	a0,a0,-364 # 70e0 <malloc+0x13dc>
    3254:	00003097          	auipc	ra,0x3
    3258:	9f8080e7          	jalr	-1544(ra) # 5c4c <printf>
        exit(1);
    325c:	4505                	li	a0,1
    325e:	00002097          	auipc	ra,0x2
    3262:	676080e7          	jalr	1654(ra) # 58d4 <exit>

0000000000003266 <subdir>:
void subdir(char *s) {
    3266:	1101                	addi	sp,sp,-32
    3268:	ec06                	sd	ra,24(sp)
    326a:	e822                	sd	s0,16(sp)
    326c:	e426                	sd	s1,8(sp)
    326e:	e04a                	sd	s2,0(sp)
    3270:	1000                	addi	s0,sp,32
    3272:	892a                	mv	s2,a0
    unlink("ff");
    3274:	00004517          	auipc	a0,0x4
    3278:	fb450513          	addi	a0,a0,-76 # 7228 <malloc+0x1524>
    327c:	00002097          	auipc	ra,0x2
    3280:	6a8080e7          	jalr	1704(ra) # 5924 <unlink>
    if (mkdir("dd") != 0) {
    3284:	00004517          	auipc	a0,0x4
    3288:	e7450513          	addi	a0,a0,-396 # 70f8 <malloc+0x13f4>
    328c:	00002097          	auipc	ra,0x2
    3290:	6b0080e7          	jalr	1712(ra) # 593c <mkdir>
    3294:	38051663          	bnez	a0,3620 <subdir+0x3ba>
    fd = open("dd/ff", O_CREATE | O_RDWR);
    3298:	20200593          	li	a1,514
    329c:	00004517          	auipc	a0,0x4
    32a0:	e7c50513          	addi	a0,a0,-388 # 7118 <malloc+0x1414>
    32a4:	00002097          	auipc	ra,0x2
    32a8:	670080e7          	jalr	1648(ra) # 5914 <open>
    32ac:	84aa                	mv	s1,a0
    if (fd < 0) {
    32ae:	38054763          	bltz	a0,363c <subdir+0x3d6>
    write(fd, "ff", 2);
    32b2:	4609                	li	a2,2
    32b4:	00004597          	auipc	a1,0x4
    32b8:	f7458593          	addi	a1,a1,-140 # 7228 <malloc+0x1524>
    32bc:	00002097          	auipc	ra,0x2
    32c0:	638080e7          	jalr	1592(ra) # 58f4 <write>
    close(fd);
    32c4:	8526                	mv	a0,s1
    32c6:	00002097          	auipc	ra,0x2
    32ca:	636080e7          	jalr	1590(ra) # 58fc <close>
    if (unlink("dd") >= 0) {
    32ce:	00004517          	auipc	a0,0x4
    32d2:	e2a50513          	addi	a0,a0,-470 # 70f8 <malloc+0x13f4>
    32d6:	00002097          	auipc	ra,0x2
    32da:	64e080e7          	jalr	1614(ra) # 5924 <unlink>
    32de:	36055d63          	bgez	a0,3658 <subdir+0x3f2>
    if (mkdir("/dd/dd") != 0) {
    32e2:	00004517          	auipc	a0,0x4
    32e6:	e8e50513          	addi	a0,a0,-370 # 7170 <malloc+0x146c>
    32ea:	00002097          	auipc	ra,0x2
    32ee:	652080e7          	jalr	1618(ra) # 593c <mkdir>
    32f2:	38051163          	bnez	a0,3674 <subdir+0x40e>
    fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    32f6:	20200593          	li	a1,514
    32fa:	00004517          	auipc	a0,0x4
    32fe:	e9e50513          	addi	a0,a0,-354 # 7198 <malloc+0x1494>
    3302:	00002097          	auipc	ra,0x2
    3306:	612080e7          	jalr	1554(ra) # 5914 <open>
    330a:	84aa                	mv	s1,a0
    if (fd < 0) {
    330c:	38054263          	bltz	a0,3690 <subdir+0x42a>
    write(fd, "FF", 2);
    3310:	4609                	li	a2,2
    3312:	00004597          	auipc	a1,0x4
    3316:	eb658593          	addi	a1,a1,-330 # 71c8 <malloc+0x14c4>
    331a:	00002097          	auipc	ra,0x2
    331e:	5da080e7          	jalr	1498(ra) # 58f4 <write>
    close(fd);
    3322:	8526                	mv	a0,s1
    3324:	00002097          	auipc	ra,0x2
    3328:	5d8080e7          	jalr	1496(ra) # 58fc <close>
    fd = open("dd/dd/../ff", 0);
    332c:	4581                	li	a1,0
    332e:	00004517          	auipc	a0,0x4
    3332:	ea250513          	addi	a0,a0,-350 # 71d0 <malloc+0x14cc>
    3336:	00002097          	auipc	ra,0x2
    333a:	5de080e7          	jalr	1502(ra) # 5914 <open>
    333e:	84aa                	mv	s1,a0
    if (fd < 0) {
    3340:	36054663          	bltz	a0,36ac <subdir+0x446>
    cc = read(fd, buf, sizeof(buf));
    3344:	660d                	lui	a2,0x3
    3346:	0000a597          	auipc	a1,0xa
    334a:	d9a58593          	addi	a1,a1,-614 # d0e0 <buf>
    334e:	00002097          	auipc	ra,0x2
    3352:	59e080e7          	jalr	1438(ra) # 58ec <read>
    if (cc != 2 || buf[0] != 'f') {
    3356:	4789                	li	a5,2
    3358:	36f51863          	bne	a0,a5,36c8 <subdir+0x462>
    335c:	0000a717          	auipc	a4,0xa
    3360:	d8474703          	lbu	a4,-636(a4) # d0e0 <buf>
    3364:	06600793          	li	a5,102
    3368:	36f71063          	bne	a4,a5,36c8 <subdir+0x462>
    close(fd);
    336c:	8526                	mv	a0,s1
    336e:	00002097          	auipc	ra,0x2
    3372:	58e080e7          	jalr	1422(ra) # 58fc <close>
    if (link("dd/dd/ff", "dd/dd/ffff") != 0) {
    3376:	00004597          	auipc	a1,0x4
    337a:	eaa58593          	addi	a1,a1,-342 # 7220 <malloc+0x151c>
    337e:	00004517          	auipc	a0,0x4
    3382:	e1a50513          	addi	a0,a0,-486 # 7198 <malloc+0x1494>
    3386:	00002097          	auipc	ra,0x2
    338a:	5ae080e7          	jalr	1454(ra) # 5934 <link>
    338e:	34051b63          	bnez	a0,36e4 <subdir+0x47e>
    if (unlink("dd/dd/ff") != 0) {
    3392:	00004517          	auipc	a0,0x4
    3396:	e0650513          	addi	a0,a0,-506 # 7198 <malloc+0x1494>
    339a:	00002097          	auipc	ra,0x2
    339e:	58a080e7          	jalr	1418(ra) # 5924 <unlink>
    33a2:	34051f63          	bnez	a0,3700 <subdir+0x49a>
    if (open("dd/dd/ff", O_RDONLY) >= 0) {
    33a6:	4581                	li	a1,0
    33a8:	00004517          	auipc	a0,0x4
    33ac:	df050513          	addi	a0,a0,-528 # 7198 <malloc+0x1494>
    33b0:	00002097          	auipc	ra,0x2
    33b4:	564080e7          	jalr	1380(ra) # 5914 <open>
    33b8:	36055263          	bgez	a0,371c <subdir+0x4b6>
    if (chdir("dd") != 0) {
    33bc:	00004517          	auipc	a0,0x4
    33c0:	d3c50513          	addi	a0,a0,-708 # 70f8 <malloc+0x13f4>
    33c4:	00002097          	auipc	ra,0x2
    33c8:	580080e7          	jalr	1408(ra) # 5944 <chdir>
    33cc:	36051663          	bnez	a0,3738 <subdir+0x4d2>
    if (chdir("dd/../../dd") != 0) {
    33d0:	00004517          	auipc	a0,0x4
    33d4:	ee850513          	addi	a0,a0,-280 # 72b8 <malloc+0x15b4>
    33d8:	00002097          	auipc	ra,0x2
    33dc:	56c080e7          	jalr	1388(ra) # 5944 <chdir>
    33e0:	36051a63          	bnez	a0,3754 <subdir+0x4ee>
    if (chdir("dd/../../../dd") != 0) {
    33e4:	00004517          	auipc	a0,0x4
    33e8:	f0450513          	addi	a0,a0,-252 # 72e8 <malloc+0x15e4>
    33ec:	00002097          	auipc	ra,0x2
    33f0:	558080e7          	jalr	1368(ra) # 5944 <chdir>
    33f4:	36051e63          	bnez	a0,3770 <subdir+0x50a>
    if (chdir("./..") != 0) {
    33f8:	00004517          	auipc	a0,0x4
    33fc:	f2050513          	addi	a0,a0,-224 # 7318 <malloc+0x1614>
    3400:	00002097          	auipc	ra,0x2
    3404:	544080e7          	jalr	1348(ra) # 5944 <chdir>
    3408:	38051263          	bnez	a0,378c <subdir+0x526>
    fd = open("dd/dd/ffff", 0);
    340c:	4581                	li	a1,0
    340e:	00004517          	auipc	a0,0x4
    3412:	e1250513          	addi	a0,a0,-494 # 7220 <malloc+0x151c>
    3416:	00002097          	auipc	ra,0x2
    341a:	4fe080e7          	jalr	1278(ra) # 5914 <open>
    341e:	84aa                	mv	s1,a0
    if (fd < 0) {
    3420:	38054463          	bltz	a0,37a8 <subdir+0x542>
    if (read(fd, buf, sizeof(buf)) != 2) {
    3424:	660d                	lui	a2,0x3
    3426:	0000a597          	auipc	a1,0xa
    342a:	cba58593          	addi	a1,a1,-838 # d0e0 <buf>
    342e:	00002097          	auipc	ra,0x2
    3432:	4be080e7          	jalr	1214(ra) # 58ec <read>
    3436:	4789                	li	a5,2
    3438:	38f51663          	bne	a0,a5,37c4 <subdir+0x55e>
    close(fd);
    343c:	8526                	mv	a0,s1
    343e:	00002097          	auipc	ra,0x2
    3442:	4be080e7          	jalr	1214(ra) # 58fc <close>
    if (open("dd/dd/ff", O_RDONLY) >= 0) {
    3446:	4581                	li	a1,0
    3448:	00004517          	auipc	a0,0x4
    344c:	d5050513          	addi	a0,a0,-688 # 7198 <malloc+0x1494>
    3450:	00002097          	auipc	ra,0x2
    3454:	4c4080e7          	jalr	1220(ra) # 5914 <open>
    3458:	38055463          	bgez	a0,37e0 <subdir+0x57a>
    if (open("dd/ff/ff", O_CREATE | O_RDWR) >= 0) {
    345c:	20200593          	li	a1,514
    3460:	00004517          	auipc	a0,0x4
    3464:	f4850513          	addi	a0,a0,-184 # 73a8 <malloc+0x16a4>
    3468:	00002097          	auipc	ra,0x2
    346c:	4ac080e7          	jalr	1196(ra) # 5914 <open>
    3470:	38055663          	bgez	a0,37fc <subdir+0x596>
    if (open("dd/xx/ff", O_CREATE | O_RDWR) >= 0) {
    3474:	20200593          	li	a1,514
    3478:	00004517          	auipc	a0,0x4
    347c:	f6050513          	addi	a0,a0,-160 # 73d8 <malloc+0x16d4>
    3480:	00002097          	auipc	ra,0x2
    3484:	494080e7          	jalr	1172(ra) # 5914 <open>
    3488:	38055863          	bgez	a0,3818 <subdir+0x5b2>
    if (open("dd", O_CREATE) >= 0) {
    348c:	20000593          	li	a1,512
    3490:	00004517          	auipc	a0,0x4
    3494:	c6850513          	addi	a0,a0,-920 # 70f8 <malloc+0x13f4>
    3498:	00002097          	auipc	ra,0x2
    349c:	47c080e7          	jalr	1148(ra) # 5914 <open>
    34a0:	38055a63          	bgez	a0,3834 <subdir+0x5ce>
    if (open("dd", O_RDWR) >= 0) {
    34a4:	4589                	li	a1,2
    34a6:	00004517          	auipc	a0,0x4
    34aa:	c5250513          	addi	a0,a0,-942 # 70f8 <malloc+0x13f4>
    34ae:	00002097          	auipc	ra,0x2
    34b2:	466080e7          	jalr	1126(ra) # 5914 <open>
    34b6:	38055d63          	bgez	a0,3850 <subdir+0x5ea>
    if (open("dd", O_WRONLY) >= 0) {
    34ba:	4585                	li	a1,1
    34bc:	00004517          	auipc	a0,0x4
    34c0:	c3c50513          	addi	a0,a0,-964 # 70f8 <malloc+0x13f4>
    34c4:	00002097          	auipc	ra,0x2
    34c8:	450080e7          	jalr	1104(ra) # 5914 <open>
    34cc:	3a055063          	bgez	a0,386c <subdir+0x606>
    if (link("dd/ff/ff", "dd/dd/xx") == 0) {
    34d0:	00004597          	auipc	a1,0x4
    34d4:	f9858593          	addi	a1,a1,-104 # 7468 <malloc+0x1764>
    34d8:	00004517          	auipc	a0,0x4
    34dc:	ed050513          	addi	a0,a0,-304 # 73a8 <malloc+0x16a4>
    34e0:	00002097          	auipc	ra,0x2
    34e4:	454080e7          	jalr	1108(ra) # 5934 <link>
    34e8:	3a050063          	beqz	a0,3888 <subdir+0x622>
    if (link("dd/xx/ff", "dd/dd/xx") == 0) {
    34ec:	00004597          	auipc	a1,0x4
    34f0:	f7c58593          	addi	a1,a1,-132 # 7468 <malloc+0x1764>
    34f4:	00004517          	auipc	a0,0x4
    34f8:	ee450513          	addi	a0,a0,-284 # 73d8 <malloc+0x16d4>
    34fc:	00002097          	auipc	ra,0x2
    3500:	438080e7          	jalr	1080(ra) # 5934 <link>
    3504:	3a050063          	beqz	a0,38a4 <subdir+0x63e>
    if (link("dd/ff", "dd/dd/ffff") == 0) {
    3508:	00004597          	auipc	a1,0x4
    350c:	d1858593          	addi	a1,a1,-744 # 7220 <malloc+0x151c>
    3510:	00004517          	auipc	a0,0x4
    3514:	c0850513          	addi	a0,a0,-1016 # 7118 <malloc+0x1414>
    3518:	00002097          	auipc	ra,0x2
    351c:	41c080e7          	jalr	1052(ra) # 5934 <link>
    3520:	3a050063          	beqz	a0,38c0 <subdir+0x65a>
    if (mkdir("dd/ff/ff") == 0) {
    3524:	00004517          	auipc	a0,0x4
    3528:	e8450513          	addi	a0,a0,-380 # 73a8 <malloc+0x16a4>
    352c:	00002097          	auipc	ra,0x2
    3530:	410080e7          	jalr	1040(ra) # 593c <mkdir>
    3534:	3a050463          	beqz	a0,38dc <subdir+0x676>
    if (mkdir("dd/xx/ff") == 0) {
    3538:	00004517          	auipc	a0,0x4
    353c:	ea050513          	addi	a0,a0,-352 # 73d8 <malloc+0x16d4>
    3540:	00002097          	auipc	ra,0x2
    3544:	3fc080e7          	jalr	1020(ra) # 593c <mkdir>
    3548:	3a050863          	beqz	a0,38f8 <subdir+0x692>
    if (mkdir("dd/dd/ffff") == 0) {
    354c:	00004517          	auipc	a0,0x4
    3550:	cd450513          	addi	a0,a0,-812 # 7220 <malloc+0x151c>
    3554:	00002097          	auipc	ra,0x2
    3558:	3e8080e7          	jalr	1000(ra) # 593c <mkdir>
    355c:	3a050c63          	beqz	a0,3914 <subdir+0x6ae>
    if (unlink("dd/xx/ff") == 0) {
    3560:	00004517          	auipc	a0,0x4
    3564:	e7850513          	addi	a0,a0,-392 # 73d8 <malloc+0x16d4>
    3568:	00002097          	auipc	ra,0x2
    356c:	3bc080e7          	jalr	956(ra) # 5924 <unlink>
    3570:	3c050063          	beqz	a0,3930 <subdir+0x6ca>
    if (unlink("dd/ff/ff") == 0) {
    3574:	00004517          	auipc	a0,0x4
    3578:	e3450513          	addi	a0,a0,-460 # 73a8 <malloc+0x16a4>
    357c:	00002097          	auipc	ra,0x2
    3580:	3a8080e7          	jalr	936(ra) # 5924 <unlink>
    3584:	3c050463          	beqz	a0,394c <subdir+0x6e6>
    if (chdir("dd/ff") == 0) {
    3588:	00004517          	auipc	a0,0x4
    358c:	b9050513          	addi	a0,a0,-1136 # 7118 <malloc+0x1414>
    3590:	00002097          	auipc	ra,0x2
    3594:	3b4080e7          	jalr	948(ra) # 5944 <chdir>
    3598:	3c050863          	beqz	a0,3968 <subdir+0x702>
    if (chdir("dd/xx") == 0) {
    359c:	00004517          	auipc	a0,0x4
    35a0:	01c50513          	addi	a0,a0,28 # 75b8 <malloc+0x18b4>
    35a4:	00002097          	auipc	ra,0x2
    35a8:	3a0080e7          	jalr	928(ra) # 5944 <chdir>
    35ac:	3c050c63          	beqz	a0,3984 <subdir+0x71e>
    if (unlink("dd/dd/ffff") != 0) {
    35b0:	00004517          	auipc	a0,0x4
    35b4:	c7050513          	addi	a0,a0,-912 # 7220 <malloc+0x151c>
    35b8:	00002097          	auipc	ra,0x2
    35bc:	36c080e7          	jalr	876(ra) # 5924 <unlink>
    35c0:	3e051063          	bnez	a0,39a0 <subdir+0x73a>
    if (unlink("dd/ff") != 0) {
    35c4:	00004517          	auipc	a0,0x4
    35c8:	b5450513          	addi	a0,a0,-1196 # 7118 <malloc+0x1414>
    35cc:	00002097          	auipc	ra,0x2
    35d0:	358080e7          	jalr	856(ra) # 5924 <unlink>
    35d4:	3e051463          	bnez	a0,39bc <subdir+0x756>
    if (unlink("dd") == 0) {
    35d8:	00004517          	auipc	a0,0x4
    35dc:	b2050513          	addi	a0,a0,-1248 # 70f8 <malloc+0x13f4>
    35e0:	00002097          	auipc	ra,0x2
    35e4:	344080e7          	jalr	836(ra) # 5924 <unlink>
    35e8:	3e050863          	beqz	a0,39d8 <subdir+0x772>
    if (unlink("dd/dd") < 0) {
    35ec:	00004517          	auipc	a0,0x4
    35f0:	03c50513          	addi	a0,a0,60 # 7628 <malloc+0x1924>
    35f4:	00002097          	auipc	ra,0x2
    35f8:	330080e7          	jalr	816(ra) # 5924 <unlink>
    35fc:	3e054c63          	bltz	a0,39f4 <subdir+0x78e>
    if (unlink("dd") < 0) {
    3600:	00004517          	auipc	a0,0x4
    3604:	af850513          	addi	a0,a0,-1288 # 70f8 <malloc+0x13f4>
    3608:	00002097          	auipc	ra,0x2
    360c:	31c080e7          	jalr	796(ra) # 5924 <unlink>
    3610:	40054063          	bltz	a0,3a10 <subdir+0x7aa>
}
    3614:	60e2                	ld	ra,24(sp)
    3616:	6442                	ld	s0,16(sp)
    3618:	64a2                	ld	s1,8(sp)
    361a:	6902                	ld	s2,0(sp)
    361c:	6105                	addi	sp,sp,32
    361e:	8082                	ret
        printf("%s: mkdir dd failed\n", s);
    3620:	85ca                	mv	a1,s2
    3622:	00004517          	auipc	a0,0x4
    3626:	ade50513          	addi	a0,a0,-1314 # 7100 <malloc+0x13fc>
    362a:	00002097          	auipc	ra,0x2
    362e:	622080e7          	jalr	1570(ra) # 5c4c <printf>
        exit(1);
    3632:	4505                	li	a0,1
    3634:	00002097          	auipc	ra,0x2
    3638:	2a0080e7          	jalr	672(ra) # 58d4 <exit>
        printf("%s: create dd/ff failed\n", s);
    363c:	85ca                	mv	a1,s2
    363e:	00004517          	auipc	a0,0x4
    3642:	ae250513          	addi	a0,a0,-1310 # 7120 <malloc+0x141c>
    3646:	00002097          	auipc	ra,0x2
    364a:	606080e7          	jalr	1542(ra) # 5c4c <printf>
        exit(1);
    364e:	4505                	li	a0,1
    3650:	00002097          	auipc	ra,0x2
    3654:	284080e7          	jalr	644(ra) # 58d4 <exit>
        printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    3658:	85ca                	mv	a1,s2
    365a:	00004517          	auipc	a0,0x4
    365e:	ae650513          	addi	a0,a0,-1306 # 7140 <malloc+0x143c>
    3662:	00002097          	auipc	ra,0x2
    3666:	5ea080e7          	jalr	1514(ra) # 5c4c <printf>
        exit(1);
    366a:	4505                	li	a0,1
    366c:	00002097          	auipc	ra,0x2
    3670:	268080e7          	jalr	616(ra) # 58d4 <exit>
        printf("subdir mkdir dd/dd failed\n", s);
    3674:	85ca                	mv	a1,s2
    3676:	00004517          	auipc	a0,0x4
    367a:	b0250513          	addi	a0,a0,-1278 # 7178 <malloc+0x1474>
    367e:	00002097          	auipc	ra,0x2
    3682:	5ce080e7          	jalr	1486(ra) # 5c4c <printf>
        exit(1);
    3686:	4505                	li	a0,1
    3688:	00002097          	auipc	ra,0x2
    368c:	24c080e7          	jalr	588(ra) # 58d4 <exit>
        printf("%s: create dd/dd/ff failed\n", s);
    3690:	85ca                	mv	a1,s2
    3692:	00004517          	auipc	a0,0x4
    3696:	b1650513          	addi	a0,a0,-1258 # 71a8 <malloc+0x14a4>
    369a:	00002097          	auipc	ra,0x2
    369e:	5b2080e7          	jalr	1458(ra) # 5c4c <printf>
        exit(1);
    36a2:	4505                	li	a0,1
    36a4:	00002097          	auipc	ra,0x2
    36a8:	230080e7          	jalr	560(ra) # 58d4 <exit>
        printf("%s: open dd/dd/../ff failed\n", s);
    36ac:	85ca                	mv	a1,s2
    36ae:	00004517          	auipc	a0,0x4
    36b2:	b3250513          	addi	a0,a0,-1230 # 71e0 <malloc+0x14dc>
    36b6:	00002097          	auipc	ra,0x2
    36ba:	596080e7          	jalr	1430(ra) # 5c4c <printf>
        exit(1);
    36be:	4505                	li	a0,1
    36c0:	00002097          	auipc	ra,0x2
    36c4:	214080e7          	jalr	532(ra) # 58d4 <exit>
        printf("%s: dd/dd/../ff wrong content\n", s);
    36c8:	85ca                	mv	a1,s2
    36ca:	00004517          	auipc	a0,0x4
    36ce:	b3650513          	addi	a0,a0,-1226 # 7200 <malloc+0x14fc>
    36d2:	00002097          	auipc	ra,0x2
    36d6:	57a080e7          	jalr	1402(ra) # 5c4c <printf>
        exit(1);
    36da:	4505                	li	a0,1
    36dc:	00002097          	auipc	ra,0x2
    36e0:	1f8080e7          	jalr	504(ra) # 58d4 <exit>
        printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    36e4:	85ca                	mv	a1,s2
    36e6:	00004517          	auipc	a0,0x4
    36ea:	b4a50513          	addi	a0,a0,-1206 # 7230 <malloc+0x152c>
    36ee:	00002097          	auipc	ra,0x2
    36f2:	55e080e7          	jalr	1374(ra) # 5c4c <printf>
        exit(1);
    36f6:	4505                	li	a0,1
    36f8:	00002097          	auipc	ra,0x2
    36fc:	1dc080e7          	jalr	476(ra) # 58d4 <exit>
        printf("%s: unlink dd/dd/ff failed\n", s);
    3700:	85ca                	mv	a1,s2
    3702:	00004517          	auipc	a0,0x4
    3706:	b5650513          	addi	a0,a0,-1194 # 7258 <malloc+0x1554>
    370a:	00002097          	auipc	ra,0x2
    370e:	542080e7          	jalr	1346(ra) # 5c4c <printf>
        exit(1);
    3712:	4505                	li	a0,1
    3714:	00002097          	auipc	ra,0x2
    3718:	1c0080e7          	jalr	448(ra) # 58d4 <exit>
        printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    371c:	85ca                	mv	a1,s2
    371e:	00004517          	auipc	a0,0x4
    3722:	b5a50513          	addi	a0,a0,-1190 # 7278 <malloc+0x1574>
    3726:	00002097          	auipc	ra,0x2
    372a:	526080e7          	jalr	1318(ra) # 5c4c <printf>
        exit(1);
    372e:	4505                	li	a0,1
    3730:	00002097          	auipc	ra,0x2
    3734:	1a4080e7          	jalr	420(ra) # 58d4 <exit>
        printf("%s: chdir dd failed\n", s);
    3738:	85ca                	mv	a1,s2
    373a:	00004517          	auipc	a0,0x4
    373e:	b6650513          	addi	a0,a0,-1178 # 72a0 <malloc+0x159c>
    3742:	00002097          	auipc	ra,0x2
    3746:	50a080e7          	jalr	1290(ra) # 5c4c <printf>
        exit(1);
    374a:	4505                	li	a0,1
    374c:	00002097          	auipc	ra,0x2
    3750:	188080e7          	jalr	392(ra) # 58d4 <exit>
        printf("%s: chdir dd/../../dd failed\n", s);
    3754:	85ca                	mv	a1,s2
    3756:	00004517          	auipc	a0,0x4
    375a:	b7250513          	addi	a0,a0,-1166 # 72c8 <malloc+0x15c4>
    375e:	00002097          	auipc	ra,0x2
    3762:	4ee080e7          	jalr	1262(ra) # 5c4c <printf>
        exit(1);
    3766:	4505                	li	a0,1
    3768:	00002097          	auipc	ra,0x2
    376c:	16c080e7          	jalr	364(ra) # 58d4 <exit>
        printf("chdir dd/../../dd failed\n", s);
    3770:	85ca                	mv	a1,s2
    3772:	00004517          	auipc	a0,0x4
    3776:	b8650513          	addi	a0,a0,-1146 # 72f8 <malloc+0x15f4>
    377a:	00002097          	auipc	ra,0x2
    377e:	4d2080e7          	jalr	1234(ra) # 5c4c <printf>
        exit(1);
    3782:	4505                	li	a0,1
    3784:	00002097          	auipc	ra,0x2
    3788:	150080e7          	jalr	336(ra) # 58d4 <exit>
        printf("%s: chdir ./.. failed\n", s);
    378c:	85ca                	mv	a1,s2
    378e:	00004517          	auipc	a0,0x4
    3792:	b9250513          	addi	a0,a0,-1134 # 7320 <malloc+0x161c>
    3796:	00002097          	auipc	ra,0x2
    379a:	4b6080e7          	jalr	1206(ra) # 5c4c <printf>
        exit(1);
    379e:	4505                	li	a0,1
    37a0:	00002097          	auipc	ra,0x2
    37a4:	134080e7          	jalr	308(ra) # 58d4 <exit>
        printf("%s: open dd/dd/ffff failed\n", s);
    37a8:	85ca                	mv	a1,s2
    37aa:	00004517          	auipc	a0,0x4
    37ae:	b8e50513          	addi	a0,a0,-1138 # 7338 <malloc+0x1634>
    37b2:	00002097          	auipc	ra,0x2
    37b6:	49a080e7          	jalr	1178(ra) # 5c4c <printf>
        exit(1);
    37ba:	4505                	li	a0,1
    37bc:	00002097          	auipc	ra,0x2
    37c0:	118080e7          	jalr	280(ra) # 58d4 <exit>
        printf("%s: read dd/dd/ffff wrong len\n", s);
    37c4:	85ca                	mv	a1,s2
    37c6:	00004517          	auipc	a0,0x4
    37ca:	b9250513          	addi	a0,a0,-1134 # 7358 <malloc+0x1654>
    37ce:	00002097          	auipc	ra,0x2
    37d2:	47e080e7          	jalr	1150(ra) # 5c4c <printf>
        exit(1);
    37d6:	4505                	li	a0,1
    37d8:	00002097          	auipc	ra,0x2
    37dc:	0fc080e7          	jalr	252(ra) # 58d4 <exit>
        printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    37e0:	85ca                	mv	a1,s2
    37e2:	00004517          	auipc	a0,0x4
    37e6:	b9650513          	addi	a0,a0,-1130 # 7378 <malloc+0x1674>
    37ea:	00002097          	auipc	ra,0x2
    37ee:	462080e7          	jalr	1122(ra) # 5c4c <printf>
        exit(1);
    37f2:	4505                	li	a0,1
    37f4:	00002097          	auipc	ra,0x2
    37f8:	0e0080e7          	jalr	224(ra) # 58d4 <exit>
        printf("%s: create dd/ff/ff succeeded!\n", s);
    37fc:	85ca                	mv	a1,s2
    37fe:	00004517          	auipc	a0,0x4
    3802:	bba50513          	addi	a0,a0,-1094 # 73b8 <malloc+0x16b4>
    3806:	00002097          	auipc	ra,0x2
    380a:	446080e7          	jalr	1094(ra) # 5c4c <printf>
        exit(1);
    380e:	4505                	li	a0,1
    3810:	00002097          	auipc	ra,0x2
    3814:	0c4080e7          	jalr	196(ra) # 58d4 <exit>
        printf("%s: create dd/xx/ff succeeded!\n", s);
    3818:	85ca                	mv	a1,s2
    381a:	00004517          	auipc	a0,0x4
    381e:	bce50513          	addi	a0,a0,-1074 # 73e8 <malloc+0x16e4>
    3822:	00002097          	auipc	ra,0x2
    3826:	42a080e7          	jalr	1066(ra) # 5c4c <printf>
        exit(1);
    382a:	4505                	li	a0,1
    382c:	00002097          	auipc	ra,0x2
    3830:	0a8080e7          	jalr	168(ra) # 58d4 <exit>
        printf("%s: create dd succeeded!\n", s);
    3834:	85ca                	mv	a1,s2
    3836:	00004517          	auipc	a0,0x4
    383a:	bd250513          	addi	a0,a0,-1070 # 7408 <malloc+0x1704>
    383e:	00002097          	auipc	ra,0x2
    3842:	40e080e7          	jalr	1038(ra) # 5c4c <printf>
        exit(1);
    3846:	4505                	li	a0,1
    3848:	00002097          	auipc	ra,0x2
    384c:	08c080e7          	jalr	140(ra) # 58d4 <exit>
        printf("%s: open dd rdwr succeeded!\n", s);
    3850:	85ca                	mv	a1,s2
    3852:	00004517          	auipc	a0,0x4
    3856:	bd650513          	addi	a0,a0,-1066 # 7428 <malloc+0x1724>
    385a:	00002097          	auipc	ra,0x2
    385e:	3f2080e7          	jalr	1010(ra) # 5c4c <printf>
        exit(1);
    3862:	4505                	li	a0,1
    3864:	00002097          	auipc	ra,0x2
    3868:	070080e7          	jalr	112(ra) # 58d4 <exit>
        printf("%s: open dd wronly succeeded!\n", s);
    386c:	85ca                	mv	a1,s2
    386e:	00004517          	auipc	a0,0x4
    3872:	bda50513          	addi	a0,a0,-1062 # 7448 <malloc+0x1744>
    3876:	00002097          	auipc	ra,0x2
    387a:	3d6080e7          	jalr	982(ra) # 5c4c <printf>
        exit(1);
    387e:	4505                	li	a0,1
    3880:	00002097          	auipc	ra,0x2
    3884:	054080e7          	jalr	84(ra) # 58d4 <exit>
        printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    3888:	85ca                	mv	a1,s2
    388a:	00004517          	auipc	a0,0x4
    388e:	bee50513          	addi	a0,a0,-1042 # 7478 <malloc+0x1774>
    3892:	00002097          	auipc	ra,0x2
    3896:	3ba080e7          	jalr	954(ra) # 5c4c <printf>
        exit(1);
    389a:	4505                	li	a0,1
    389c:	00002097          	auipc	ra,0x2
    38a0:	038080e7          	jalr	56(ra) # 58d4 <exit>
        printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    38a4:	85ca                	mv	a1,s2
    38a6:	00004517          	auipc	a0,0x4
    38aa:	bfa50513          	addi	a0,a0,-1030 # 74a0 <malloc+0x179c>
    38ae:	00002097          	auipc	ra,0x2
    38b2:	39e080e7          	jalr	926(ra) # 5c4c <printf>
        exit(1);
    38b6:	4505                	li	a0,1
    38b8:	00002097          	auipc	ra,0x2
    38bc:	01c080e7          	jalr	28(ra) # 58d4 <exit>
        printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    38c0:	85ca                	mv	a1,s2
    38c2:	00004517          	auipc	a0,0x4
    38c6:	c0650513          	addi	a0,a0,-1018 # 74c8 <malloc+0x17c4>
    38ca:	00002097          	auipc	ra,0x2
    38ce:	382080e7          	jalr	898(ra) # 5c4c <printf>
        exit(1);
    38d2:	4505                	li	a0,1
    38d4:	00002097          	auipc	ra,0x2
    38d8:	000080e7          	jalr	ra # 58d4 <exit>
        printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    38dc:	85ca                	mv	a1,s2
    38de:	00004517          	auipc	a0,0x4
    38e2:	c1250513          	addi	a0,a0,-1006 # 74f0 <malloc+0x17ec>
    38e6:	00002097          	auipc	ra,0x2
    38ea:	366080e7          	jalr	870(ra) # 5c4c <printf>
        exit(1);
    38ee:	4505                	li	a0,1
    38f0:	00002097          	auipc	ra,0x2
    38f4:	fe4080e7          	jalr	-28(ra) # 58d4 <exit>
        printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    38f8:	85ca                	mv	a1,s2
    38fa:	00004517          	auipc	a0,0x4
    38fe:	c1650513          	addi	a0,a0,-1002 # 7510 <malloc+0x180c>
    3902:	00002097          	auipc	ra,0x2
    3906:	34a080e7          	jalr	842(ra) # 5c4c <printf>
        exit(1);
    390a:	4505                	li	a0,1
    390c:	00002097          	auipc	ra,0x2
    3910:	fc8080e7          	jalr	-56(ra) # 58d4 <exit>
        printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    3914:	85ca                	mv	a1,s2
    3916:	00004517          	auipc	a0,0x4
    391a:	c1a50513          	addi	a0,a0,-998 # 7530 <malloc+0x182c>
    391e:	00002097          	auipc	ra,0x2
    3922:	32e080e7          	jalr	814(ra) # 5c4c <printf>
        exit(1);
    3926:	4505                	li	a0,1
    3928:	00002097          	auipc	ra,0x2
    392c:	fac080e7          	jalr	-84(ra) # 58d4 <exit>
        printf("%s: unlink dd/xx/ff succeeded!\n", s);
    3930:	85ca                	mv	a1,s2
    3932:	00004517          	auipc	a0,0x4
    3936:	c2650513          	addi	a0,a0,-986 # 7558 <malloc+0x1854>
    393a:	00002097          	auipc	ra,0x2
    393e:	312080e7          	jalr	786(ra) # 5c4c <printf>
        exit(1);
    3942:	4505                	li	a0,1
    3944:	00002097          	auipc	ra,0x2
    3948:	f90080e7          	jalr	-112(ra) # 58d4 <exit>
        printf("%s: unlink dd/ff/ff succeeded!\n", s);
    394c:	85ca                	mv	a1,s2
    394e:	00004517          	auipc	a0,0x4
    3952:	c2a50513          	addi	a0,a0,-982 # 7578 <malloc+0x1874>
    3956:	00002097          	auipc	ra,0x2
    395a:	2f6080e7          	jalr	758(ra) # 5c4c <printf>
        exit(1);
    395e:	4505                	li	a0,1
    3960:	00002097          	auipc	ra,0x2
    3964:	f74080e7          	jalr	-140(ra) # 58d4 <exit>
        printf("%s: chdir dd/ff succeeded!\n", s);
    3968:	85ca                	mv	a1,s2
    396a:	00004517          	auipc	a0,0x4
    396e:	c2e50513          	addi	a0,a0,-978 # 7598 <malloc+0x1894>
    3972:	00002097          	auipc	ra,0x2
    3976:	2da080e7          	jalr	730(ra) # 5c4c <printf>
        exit(1);
    397a:	4505                	li	a0,1
    397c:	00002097          	auipc	ra,0x2
    3980:	f58080e7          	jalr	-168(ra) # 58d4 <exit>
        printf("%s: chdir dd/xx succeeded!\n", s);
    3984:	85ca                	mv	a1,s2
    3986:	00004517          	auipc	a0,0x4
    398a:	c3a50513          	addi	a0,a0,-966 # 75c0 <malloc+0x18bc>
    398e:	00002097          	auipc	ra,0x2
    3992:	2be080e7          	jalr	702(ra) # 5c4c <printf>
        exit(1);
    3996:	4505                	li	a0,1
    3998:	00002097          	auipc	ra,0x2
    399c:	f3c080e7          	jalr	-196(ra) # 58d4 <exit>
        printf("%s: unlink dd/dd/ff failed\n", s);
    39a0:	85ca                	mv	a1,s2
    39a2:	00004517          	auipc	a0,0x4
    39a6:	8b650513          	addi	a0,a0,-1866 # 7258 <malloc+0x1554>
    39aa:	00002097          	auipc	ra,0x2
    39ae:	2a2080e7          	jalr	674(ra) # 5c4c <printf>
        exit(1);
    39b2:	4505                	li	a0,1
    39b4:	00002097          	auipc	ra,0x2
    39b8:	f20080e7          	jalr	-224(ra) # 58d4 <exit>
        printf("%s: unlink dd/ff failed\n", s);
    39bc:	85ca                	mv	a1,s2
    39be:	00004517          	auipc	a0,0x4
    39c2:	c2250513          	addi	a0,a0,-990 # 75e0 <malloc+0x18dc>
    39c6:	00002097          	auipc	ra,0x2
    39ca:	286080e7          	jalr	646(ra) # 5c4c <printf>
        exit(1);
    39ce:	4505                	li	a0,1
    39d0:	00002097          	auipc	ra,0x2
    39d4:	f04080e7          	jalr	-252(ra) # 58d4 <exit>
        printf("%s: unlink non-empty dd succeeded!\n", s);
    39d8:	85ca                	mv	a1,s2
    39da:	00004517          	auipc	a0,0x4
    39de:	c2650513          	addi	a0,a0,-986 # 7600 <malloc+0x18fc>
    39e2:	00002097          	auipc	ra,0x2
    39e6:	26a080e7          	jalr	618(ra) # 5c4c <printf>
        exit(1);
    39ea:	4505                	li	a0,1
    39ec:	00002097          	auipc	ra,0x2
    39f0:	ee8080e7          	jalr	-280(ra) # 58d4 <exit>
        printf("%s: unlink dd/dd failed\n", s);
    39f4:	85ca                	mv	a1,s2
    39f6:	00004517          	auipc	a0,0x4
    39fa:	c3a50513          	addi	a0,a0,-966 # 7630 <malloc+0x192c>
    39fe:	00002097          	auipc	ra,0x2
    3a02:	24e080e7          	jalr	590(ra) # 5c4c <printf>
        exit(1);
    3a06:	4505                	li	a0,1
    3a08:	00002097          	auipc	ra,0x2
    3a0c:	ecc080e7          	jalr	-308(ra) # 58d4 <exit>
        printf("%s: unlink dd failed\n", s);
    3a10:	85ca                	mv	a1,s2
    3a12:	00004517          	auipc	a0,0x4
    3a16:	c3e50513          	addi	a0,a0,-962 # 7650 <malloc+0x194c>
    3a1a:	00002097          	auipc	ra,0x2
    3a1e:	232080e7          	jalr	562(ra) # 5c4c <printf>
        exit(1);
    3a22:	4505                	li	a0,1
    3a24:	00002097          	auipc	ra,0x2
    3a28:	eb0080e7          	jalr	-336(ra) # 58d4 <exit>

0000000000003a2c <rmdot>:
void rmdot(char *s) {
    3a2c:	1101                	addi	sp,sp,-32
    3a2e:	ec06                	sd	ra,24(sp)
    3a30:	e822                	sd	s0,16(sp)
    3a32:	e426                	sd	s1,8(sp)
    3a34:	1000                	addi	s0,sp,32
    3a36:	84aa                	mv	s1,a0
    if (mkdir("dots") != 0) {
    3a38:	00004517          	auipc	a0,0x4
    3a3c:	c3050513          	addi	a0,a0,-976 # 7668 <malloc+0x1964>
    3a40:	00002097          	auipc	ra,0x2
    3a44:	efc080e7          	jalr	-260(ra) # 593c <mkdir>
    3a48:	e549                	bnez	a0,3ad2 <rmdot+0xa6>
    if (chdir("dots") != 0) {
    3a4a:	00004517          	auipc	a0,0x4
    3a4e:	c1e50513          	addi	a0,a0,-994 # 7668 <malloc+0x1964>
    3a52:	00002097          	auipc	ra,0x2
    3a56:	ef2080e7          	jalr	-270(ra) # 5944 <chdir>
    3a5a:	e951                	bnez	a0,3aee <rmdot+0xc2>
    if (unlink(".") == 0) {
    3a5c:	00003517          	auipc	a0,0x3
    3a60:	a9c50513          	addi	a0,a0,-1380 # 64f8 <malloc+0x7f4>
    3a64:	00002097          	auipc	ra,0x2
    3a68:	ec0080e7          	jalr	-320(ra) # 5924 <unlink>
    3a6c:	cd59                	beqz	a0,3b0a <rmdot+0xde>
    if (unlink("..") == 0) {
    3a6e:	00003517          	auipc	a0,0x3
    3a72:	65250513          	addi	a0,a0,1618 # 70c0 <malloc+0x13bc>
    3a76:	00002097          	auipc	ra,0x2
    3a7a:	eae080e7          	jalr	-338(ra) # 5924 <unlink>
    3a7e:	c545                	beqz	a0,3b26 <rmdot+0xfa>
    if (chdir("/") != 0) {
    3a80:	00003517          	auipc	a0,0x3
    3a84:	5e850513          	addi	a0,a0,1512 # 7068 <malloc+0x1364>
    3a88:	00002097          	auipc	ra,0x2
    3a8c:	ebc080e7          	jalr	-324(ra) # 5944 <chdir>
    3a90:	e94d                	bnez	a0,3b42 <rmdot+0x116>
    if (unlink("dots/.") == 0) {
    3a92:	00004517          	auipc	a0,0x4
    3a96:	c3e50513          	addi	a0,a0,-962 # 76d0 <malloc+0x19cc>
    3a9a:	00002097          	auipc	ra,0x2
    3a9e:	e8a080e7          	jalr	-374(ra) # 5924 <unlink>
    3aa2:	cd55                	beqz	a0,3b5e <rmdot+0x132>
    if (unlink("dots/..") == 0) {
    3aa4:	00004517          	auipc	a0,0x4
    3aa8:	c5450513          	addi	a0,a0,-940 # 76f8 <malloc+0x19f4>
    3aac:	00002097          	auipc	ra,0x2
    3ab0:	e78080e7          	jalr	-392(ra) # 5924 <unlink>
    3ab4:	c179                	beqz	a0,3b7a <rmdot+0x14e>
    if (unlink("dots") != 0) {
    3ab6:	00004517          	auipc	a0,0x4
    3aba:	bb250513          	addi	a0,a0,-1102 # 7668 <malloc+0x1964>
    3abe:	00002097          	auipc	ra,0x2
    3ac2:	e66080e7          	jalr	-410(ra) # 5924 <unlink>
    3ac6:	e961                	bnez	a0,3b96 <rmdot+0x16a>
}
    3ac8:	60e2                	ld	ra,24(sp)
    3aca:	6442                	ld	s0,16(sp)
    3acc:	64a2                	ld	s1,8(sp)
    3ace:	6105                	addi	sp,sp,32
    3ad0:	8082                	ret
        printf("%s: mkdir dots failed\n", s);
    3ad2:	85a6                	mv	a1,s1
    3ad4:	00004517          	auipc	a0,0x4
    3ad8:	b9c50513          	addi	a0,a0,-1124 # 7670 <malloc+0x196c>
    3adc:	00002097          	auipc	ra,0x2
    3ae0:	170080e7          	jalr	368(ra) # 5c4c <printf>
        exit(1);
    3ae4:	4505                	li	a0,1
    3ae6:	00002097          	auipc	ra,0x2
    3aea:	dee080e7          	jalr	-530(ra) # 58d4 <exit>
        printf("%s: chdir dots failed\n", s);
    3aee:	85a6                	mv	a1,s1
    3af0:	00004517          	auipc	a0,0x4
    3af4:	b9850513          	addi	a0,a0,-1128 # 7688 <malloc+0x1984>
    3af8:	00002097          	auipc	ra,0x2
    3afc:	154080e7          	jalr	340(ra) # 5c4c <printf>
        exit(1);
    3b00:	4505                	li	a0,1
    3b02:	00002097          	auipc	ra,0x2
    3b06:	dd2080e7          	jalr	-558(ra) # 58d4 <exit>
        printf("%s: rm . worked!\n", s);
    3b0a:	85a6                	mv	a1,s1
    3b0c:	00004517          	auipc	a0,0x4
    3b10:	b9450513          	addi	a0,a0,-1132 # 76a0 <malloc+0x199c>
    3b14:	00002097          	auipc	ra,0x2
    3b18:	138080e7          	jalr	312(ra) # 5c4c <printf>
        exit(1);
    3b1c:	4505                	li	a0,1
    3b1e:	00002097          	auipc	ra,0x2
    3b22:	db6080e7          	jalr	-586(ra) # 58d4 <exit>
        printf("%s: rm .. worked!\n", s);
    3b26:	85a6                	mv	a1,s1
    3b28:	00004517          	auipc	a0,0x4
    3b2c:	b9050513          	addi	a0,a0,-1136 # 76b8 <malloc+0x19b4>
    3b30:	00002097          	auipc	ra,0x2
    3b34:	11c080e7          	jalr	284(ra) # 5c4c <printf>
        exit(1);
    3b38:	4505                	li	a0,1
    3b3a:	00002097          	auipc	ra,0x2
    3b3e:	d9a080e7          	jalr	-614(ra) # 58d4 <exit>
        printf("%s: chdir / failed\n", s);
    3b42:	85a6                	mv	a1,s1
    3b44:	00003517          	auipc	a0,0x3
    3b48:	52c50513          	addi	a0,a0,1324 # 7070 <malloc+0x136c>
    3b4c:	00002097          	auipc	ra,0x2
    3b50:	100080e7          	jalr	256(ra) # 5c4c <printf>
        exit(1);
    3b54:	4505                	li	a0,1
    3b56:	00002097          	auipc	ra,0x2
    3b5a:	d7e080e7          	jalr	-642(ra) # 58d4 <exit>
        printf("%s: unlink dots/. worked!\n", s);
    3b5e:	85a6                	mv	a1,s1
    3b60:	00004517          	auipc	a0,0x4
    3b64:	b7850513          	addi	a0,a0,-1160 # 76d8 <malloc+0x19d4>
    3b68:	00002097          	auipc	ra,0x2
    3b6c:	0e4080e7          	jalr	228(ra) # 5c4c <printf>
        exit(1);
    3b70:	4505                	li	a0,1
    3b72:	00002097          	auipc	ra,0x2
    3b76:	d62080e7          	jalr	-670(ra) # 58d4 <exit>
        printf("%s: unlink dots/.. worked!\n", s);
    3b7a:	85a6                	mv	a1,s1
    3b7c:	00004517          	auipc	a0,0x4
    3b80:	b8450513          	addi	a0,a0,-1148 # 7700 <malloc+0x19fc>
    3b84:	00002097          	auipc	ra,0x2
    3b88:	0c8080e7          	jalr	200(ra) # 5c4c <printf>
        exit(1);
    3b8c:	4505                	li	a0,1
    3b8e:	00002097          	auipc	ra,0x2
    3b92:	d46080e7          	jalr	-698(ra) # 58d4 <exit>
        printf("%s: unlink dots failed!\n", s);
    3b96:	85a6                	mv	a1,s1
    3b98:	00004517          	auipc	a0,0x4
    3b9c:	b8850513          	addi	a0,a0,-1144 # 7720 <malloc+0x1a1c>
    3ba0:	00002097          	auipc	ra,0x2
    3ba4:	0ac080e7          	jalr	172(ra) # 5c4c <printf>
        exit(1);
    3ba8:	4505                	li	a0,1
    3baa:	00002097          	auipc	ra,0x2
    3bae:	d2a080e7          	jalr	-726(ra) # 58d4 <exit>

0000000000003bb2 <dirfile>:
void dirfile(char *s) {
    3bb2:	1101                	addi	sp,sp,-32
    3bb4:	ec06                	sd	ra,24(sp)
    3bb6:	e822                	sd	s0,16(sp)
    3bb8:	e426                	sd	s1,8(sp)
    3bba:	e04a                	sd	s2,0(sp)
    3bbc:	1000                	addi	s0,sp,32
    3bbe:	892a                	mv	s2,a0
    fd = open("dirfile", O_CREATE);
    3bc0:	20000593          	li	a1,512
    3bc4:	00004517          	auipc	a0,0x4
    3bc8:	b7c50513          	addi	a0,a0,-1156 # 7740 <malloc+0x1a3c>
    3bcc:	00002097          	auipc	ra,0x2
    3bd0:	d48080e7          	jalr	-696(ra) # 5914 <open>
    if (fd < 0) {
    3bd4:	0e054d63          	bltz	a0,3cce <dirfile+0x11c>
    close(fd);
    3bd8:	00002097          	auipc	ra,0x2
    3bdc:	d24080e7          	jalr	-732(ra) # 58fc <close>
    if (chdir("dirfile") == 0) {
    3be0:	00004517          	auipc	a0,0x4
    3be4:	b6050513          	addi	a0,a0,-1184 # 7740 <malloc+0x1a3c>
    3be8:	00002097          	auipc	ra,0x2
    3bec:	d5c080e7          	jalr	-676(ra) # 5944 <chdir>
    3bf0:	cd6d                	beqz	a0,3cea <dirfile+0x138>
    fd = open("dirfile/xx", 0);
    3bf2:	4581                	li	a1,0
    3bf4:	00004517          	auipc	a0,0x4
    3bf8:	b9450513          	addi	a0,a0,-1132 # 7788 <malloc+0x1a84>
    3bfc:	00002097          	auipc	ra,0x2
    3c00:	d18080e7          	jalr	-744(ra) # 5914 <open>
    if (fd >= 0) {
    3c04:	10055163          	bgez	a0,3d06 <dirfile+0x154>
    fd = open("dirfile/xx", O_CREATE);
    3c08:	20000593          	li	a1,512
    3c0c:	00004517          	auipc	a0,0x4
    3c10:	b7c50513          	addi	a0,a0,-1156 # 7788 <malloc+0x1a84>
    3c14:	00002097          	auipc	ra,0x2
    3c18:	d00080e7          	jalr	-768(ra) # 5914 <open>
    if (fd >= 0) {
    3c1c:	10055363          	bgez	a0,3d22 <dirfile+0x170>
    if (mkdir("dirfile/xx") == 0) {
    3c20:	00004517          	auipc	a0,0x4
    3c24:	b6850513          	addi	a0,a0,-1176 # 7788 <malloc+0x1a84>
    3c28:	00002097          	auipc	ra,0x2
    3c2c:	d14080e7          	jalr	-748(ra) # 593c <mkdir>
    3c30:	10050763          	beqz	a0,3d3e <dirfile+0x18c>
    if (unlink("dirfile/xx") == 0) {
    3c34:	00004517          	auipc	a0,0x4
    3c38:	b5450513          	addi	a0,a0,-1196 # 7788 <malloc+0x1a84>
    3c3c:	00002097          	auipc	ra,0x2
    3c40:	ce8080e7          	jalr	-792(ra) # 5924 <unlink>
    3c44:	10050b63          	beqz	a0,3d5a <dirfile+0x1a8>
    if (link("README", "dirfile/xx") == 0) {
    3c48:	00004597          	auipc	a1,0x4
    3c4c:	b4058593          	addi	a1,a1,-1216 # 7788 <malloc+0x1a84>
    3c50:	00002517          	auipc	a0,0x2
    3c54:	39850513          	addi	a0,a0,920 # 5fe8 <malloc+0x2e4>
    3c58:	00002097          	auipc	ra,0x2
    3c5c:	cdc080e7          	jalr	-804(ra) # 5934 <link>
    3c60:	10050b63          	beqz	a0,3d76 <dirfile+0x1c4>
    if (unlink("dirfile") != 0) {
    3c64:	00004517          	auipc	a0,0x4
    3c68:	adc50513          	addi	a0,a0,-1316 # 7740 <malloc+0x1a3c>
    3c6c:	00002097          	auipc	ra,0x2
    3c70:	cb8080e7          	jalr	-840(ra) # 5924 <unlink>
    3c74:	10051f63          	bnez	a0,3d92 <dirfile+0x1e0>
    fd = open(".", O_RDWR);
    3c78:	4589                	li	a1,2
    3c7a:	00003517          	auipc	a0,0x3
    3c7e:	87e50513          	addi	a0,a0,-1922 # 64f8 <malloc+0x7f4>
    3c82:	00002097          	auipc	ra,0x2
    3c86:	c92080e7          	jalr	-878(ra) # 5914 <open>
    if (fd >= 0) {
    3c8a:	12055263          	bgez	a0,3dae <dirfile+0x1fc>
    fd = open(".", 0);
    3c8e:	4581                	li	a1,0
    3c90:	00003517          	auipc	a0,0x3
    3c94:	86850513          	addi	a0,a0,-1944 # 64f8 <malloc+0x7f4>
    3c98:	00002097          	auipc	ra,0x2
    3c9c:	c7c080e7          	jalr	-900(ra) # 5914 <open>
    3ca0:	84aa                	mv	s1,a0
    if (write(fd, "x", 1) > 0) {
    3ca2:	4605                	li	a2,1
    3ca4:	00002597          	auipc	a1,0x2
    3ca8:	20c58593          	addi	a1,a1,524 # 5eb0 <malloc+0x1ac>
    3cac:	00002097          	auipc	ra,0x2
    3cb0:	c48080e7          	jalr	-952(ra) # 58f4 <write>
    3cb4:	10a04b63          	bgtz	a0,3dca <dirfile+0x218>
    close(fd);
    3cb8:	8526                	mv	a0,s1
    3cba:	00002097          	auipc	ra,0x2
    3cbe:	c42080e7          	jalr	-958(ra) # 58fc <close>
}
    3cc2:	60e2                	ld	ra,24(sp)
    3cc4:	6442                	ld	s0,16(sp)
    3cc6:	64a2                	ld	s1,8(sp)
    3cc8:	6902                	ld	s2,0(sp)
    3cca:	6105                	addi	sp,sp,32
    3ccc:	8082                	ret
        printf("%s: create dirfile failed\n", s);
    3cce:	85ca                	mv	a1,s2
    3cd0:	00004517          	auipc	a0,0x4
    3cd4:	a7850513          	addi	a0,a0,-1416 # 7748 <malloc+0x1a44>
    3cd8:	00002097          	auipc	ra,0x2
    3cdc:	f74080e7          	jalr	-140(ra) # 5c4c <printf>
        exit(1);
    3ce0:	4505                	li	a0,1
    3ce2:	00002097          	auipc	ra,0x2
    3ce6:	bf2080e7          	jalr	-1038(ra) # 58d4 <exit>
        printf("%s: chdir dirfile succeeded!\n", s);
    3cea:	85ca                	mv	a1,s2
    3cec:	00004517          	auipc	a0,0x4
    3cf0:	a7c50513          	addi	a0,a0,-1412 # 7768 <malloc+0x1a64>
    3cf4:	00002097          	auipc	ra,0x2
    3cf8:	f58080e7          	jalr	-168(ra) # 5c4c <printf>
        exit(1);
    3cfc:	4505                	li	a0,1
    3cfe:	00002097          	auipc	ra,0x2
    3d02:	bd6080e7          	jalr	-1066(ra) # 58d4 <exit>
        printf("%s: create dirfile/xx succeeded!\n", s);
    3d06:	85ca                	mv	a1,s2
    3d08:	00004517          	auipc	a0,0x4
    3d0c:	a9050513          	addi	a0,a0,-1392 # 7798 <malloc+0x1a94>
    3d10:	00002097          	auipc	ra,0x2
    3d14:	f3c080e7          	jalr	-196(ra) # 5c4c <printf>
        exit(1);
    3d18:	4505                	li	a0,1
    3d1a:	00002097          	auipc	ra,0x2
    3d1e:	bba080e7          	jalr	-1094(ra) # 58d4 <exit>
        printf("%s: create dirfile/xx succeeded!\n", s);
    3d22:	85ca                	mv	a1,s2
    3d24:	00004517          	auipc	a0,0x4
    3d28:	a7450513          	addi	a0,a0,-1420 # 7798 <malloc+0x1a94>
    3d2c:	00002097          	auipc	ra,0x2
    3d30:	f20080e7          	jalr	-224(ra) # 5c4c <printf>
        exit(1);
    3d34:	4505                	li	a0,1
    3d36:	00002097          	auipc	ra,0x2
    3d3a:	b9e080e7          	jalr	-1122(ra) # 58d4 <exit>
        printf("%s: mkdir dirfile/xx succeeded!\n", s);
    3d3e:	85ca                	mv	a1,s2
    3d40:	00004517          	auipc	a0,0x4
    3d44:	a8050513          	addi	a0,a0,-1408 # 77c0 <malloc+0x1abc>
    3d48:	00002097          	auipc	ra,0x2
    3d4c:	f04080e7          	jalr	-252(ra) # 5c4c <printf>
        exit(1);
    3d50:	4505                	li	a0,1
    3d52:	00002097          	auipc	ra,0x2
    3d56:	b82080e7          	jalr	-1150(ra) # 58d4 <exit>
        printf("%s: unlink dirfile/xx succeeded!\n", s);
    3d5a:	85ca                	mv	a1,s2
    3d5c:	00004517          	auipc	a0,0x4
    3d60:	a8c50513          	addi	a0,a0,-1396 # 77e8 <malloc+0x1ae4>
    3d64:	00002097          	auipc	ra,0x2
    3d68:	ee8080e7          	jalr	-280(ra) # 5c4c <printf>
        exit(1);
    3d6c:	4505                	li	a0,1
    3d6e:	00002097          	auipc	ra,0x2
    3d72:	b66080e7          	jalr	-1178(ra) # 58d4 <exit>
        printf("%s: link to dirfile/xx succeeded!\n", s);
    3d76:	85ca                	mv	a1,s2
    3d78:	00004517          	auipc	a0,0x4
    3d7c:	a9850513          	addi	a0,a0,-1384 # 7810 <malloc+0x1b0c>
    3d80:	00002097          	auipc	ra,0x2
    3d84:	ecc080e7          	jalr	-308(ra) # 5c4c <printf>
        exit(1);
    3d88:	4505                	li	a0,1
    3d8a:	00002097          	auipc	ra,0x2
    3d8e:	b4a080e7          	jalr	-1206(ra) # 58d4 <exit>
        printf("%s: unlink dirfile failed!\n", s);
    3d92:	85ca                	mv	a1,s2
    3d94:	00004517          	auipc	a0,0x4
    3d98:	aa450513          	addi	a0,a0,-1372 # 7838 <malloc+0x1b34>
    3d9c:	00002097          	auipc	ra,0x2
    3da0:	eb0080e7          	jalr	-336(ra) # 5c4c <printf>
        exit(1);
    3da4:	4505                	li	a0,1
    3da6:	00002097          	auipc	ra,0x2
    3daa:	b2e080e7          	jalr	-1234(ra) # 58d4 <exit>
        printf("%s: open . for writing succeeded!\n", s);
    3dae:	85ca                	mv	a1,s2
    3db0:	00004517          	auipc	a0,0x4
    3db4:	aa850513          	addi	a0,a0,-1368 # 7858 <malloc+0x1b54>
    3db8:	00002097          	auipc	ra,0x2
    3dbc:	e94080e7          	jalr	-364(ra) # 5c4c <printf>
        exit(1);
    3dc0:	4505                	li	a0,1
    3dc2:	00002097          	auipc	ra,0x2
    3dc6:	b12080e7          	jalr	-1262(ra) # 58d4 <exit>
        printf("%s: write . succeeded!\n", s);
    3dca:	85ca                	mv	a1,s2
    3dcc:	00004517          	auipc	a0,0x4
    3dd0:	ab450513          	addi	a0,a0,-1356 # 7880 <malloc+0x1b7c>
    3dd4:	00002097          	auipc	ra,0x2
    3dd8:	e78080e7          	jalr	-392(ra) # 5c4c <printf>
        exit(1);
    3ddc:	4505                	li	a0,1
    3dde:	00002097          	auipc	ra,0x2
    3de2:	af6080e7          	jalr	-1290(ra) # 58d4 <exit>

0000000000003de6 <iref>:
void iref(char *s) {
    3de6:	7139                	addi	sp,sp,-64
    3de8:	fc06                	sd	ra,56(sp)
    3dea:	f822                	sd	s0,48(sp)
    3dec:	f426                	sd	s1,40(sp)
    3dee:	f04a                	sd	s2,32(sp)
    3df0:	ec4e                	sd	s3,24(sp)
    3df2:	e852                	sd	s4,16(sp)
    3df4:	e456                	sd	s5,8(sp)
    3df6:	e05a                	sd	s6,0(sp)
    3df8:	0080                	addi	s0,sp,64
    3dfa:	8b2a                	mv	s6,a0
    3dfc:	03300913          	li	s2,51
        if (mkdir("irefd") != 0) {
    3e00:	00004a17          	auipc	s4,0x4
    3e04:	a98a0a13          	addi	s4,s4,-1384 # 7898 <malloc+0x1b94>
        mkdir("");
    3e08:	00003497          	auipc	s1,0x3
    3e0c:	59848493          	addi	s1,s1,1432 # 73a0 <malloc+0x169c>
        link("README", "");
    3e10:	00002a97          	auipc	s5,0x2
    3e14:	1d8a8a93          	addi	s5,s5,472 # 5fe8 <malloc+0x2e4>
        fd = open("xx", O_CREATE);
    3e18:	00004997          	auipc	s3,0x4
    3e1c:	97898993          	addi	s3,s3,-1672 # 7790 <malloc+0x1a8c>
    3e20:	a891                	j	3e74 <iref+0x8e>
            printf("%s: mkdir irefd failed\n", s);
    3e22:	85da                	mv	a1,s6
    3e24:	00004517          	auipc	a0,0x4
    3e28:	a7c50513          	addi	a0,a0,-1412 # 78a0 <malloc+0x1b9c>
    3e2c:	00002097          	auipc	ra,0x2
    3e30:	e20080e7          	jalr	-480(ra) # 5c4c <printf>
            exit(1);
    3e34:	4505                	li	a0,1
    3e36:	00002097          	auipc	ra,0x2
    3e3a:	a9e080e7          	jalr	-1378(ra) # 58d4 <exit>
            printf("%s: chdir irefd failed\n", s);
    3e3e:	85da                	mv	a1,s6
    3e40:	00004517          	auipc	a0,0x4
    3e44:	a7850513          	addi	a0,a0,-1416 # 78b8 <malloc+0x1bb4>
    3e48:	00002097          	auipc	ra,0x2
    3e4c:	e04080e7          	jalr	-508(ra) # 5c4c <printf>
            exit(1);
    3e50:	4505                	li	a0,1
    3e52:	00002097          	auipc	ra,0x2
    3e56:	a82080e7          	jalr	-1406(ra) # 58d4 <exit>
            close(fd);
    3e5a:	00002097          	auipc	ra,0x2
    3e5e:	aa2080e7          	jalr	-1374(ra) # 58fc <close>
    3e62:	a889                	j	3eb4 <iref+0xce>
        unlink("xx");
    3e64:	854e                	mv	a0,s3
    3e66:	00002097          	auipc	ra,0x2
    3e6a:	abe080e7          	jalr	-1346(ra) # 5924 <unlink>
    for (i = 0; i < NINODE + 1; i++) {
    3e6e:	397d                	addiw	s2,s2,-1
    3e70:	06090063          	beqz	s2,3ed0 <iref+0xea>
        if (mkdir("irefd") != 0) {
    3e74:	8552                	mv	a0,s4
    3e76:	00002097          	auipc	ra,0x2
    3e7a:	ac6080e7          	jalr	-1338(ra) # 593c <mkdir>
    3e7e:	f155                	bnez	a0,3e22 <iref+0x3c>
        if (chdir("irefd") != 0) {
    3e80:	8552                	mv	a0,s4
    3e82:	00002097          	auipc	ra,0x2
    3e86:	ac2080e7          	jalr	-1342(ra) # 5944 <chdir>
    3e8a:	f955                	bnez	a0,3e3e <iref+0x58>
        mkdir("");
    3e8c:	8526                	mv	a0,s1
    3e8e:	00002097          	auipc	ra,0x2
    3e92:	aae080e7          	jalr	-1362(ra) # 593c <mkdir>
        link("README", "");
    3e96:	85a6                	mv	a1,s1
    3e98:	8556                	mv	a0,s5
    3e9a:	00002097          	auipc	ra,0x2
    3e9e:	a9a080e7          	jalr	-1382(ra) # 5934 <link>
        fd = open("", O_CREATE);
    3ea2:	20000593          	li	a1,512
    3ea6:	8526                	mv	a0,s1
    3ea8:	00002097          	auipc	ra,0x2
    3eac:	a6c080e7          	jalr	-1428(ra) # 5914 <open>
        if (fd >= 0)
    3eb0:	fa0555e3          	bgez	a0,3e5a <iref+0x74>
        fd = open("xx", O_CREATE);
    3eb4:	20000593          	li	a1,512
    3eb8:	854e                	mv	a0,s3
    3eba:	00002097          	auipc	ra,0x2
    3ebe:	a5a080e7          	jalr	-1446(ra) # 5914 <open>
        if (fd >= 0)
    3ec2:	fa0541e3          	bltz	a0,3e64 <iref+0x7e>
            close(fd);
    3ec6:	00002097          	auipc	ra,0x2
    3eca:	a36080e7          	jalr	-1482(ra) # 58fc <close>
    3ece:	bf59                	j	3e64 <iref+0x7e>
    3ed0:	03300493          	li	s1,51
        chdir("..");
    3ed4:	00003997          	auipc	s3,0x3
    3ed8:	1ec98993          	addi	s3,s3,492 # 70c0 <malloc+0x13bc>
        unlink("irefd");
    3edc:	00004917          	auipc	s2,0x4
    3ee0:	9bc90913          	addi	s2,s2,-1604 # 7898 <malloc+0x1b94>
        chdir("..");
    3ee4:	854e                	mv	a0,s3
    3ee6:	00002097          	auipc	ra,0x2
    3eea:	a5e080e7          	jalr	-1442(ra) # 5944 <chdir>
        unlink("irefd");
    3eee:	854a                	mv	a0,s2
    3ef0:	00002097          	auipc	ra,0x2
    3ef4:	a34080e7          	jalr	-1484(ra) # 5924 <unlink>
    for (i = 0; i < NINODE + 1; i++) {
    3ef8:	34fd                	addiw	s1,s1,-1
    3efa:	f4ed                	bnez	s1,3ee4 <iref+0xfe>
    chdir("/");
    3efc:	00003517          	auipc	a0,0x3
    3f00:	16c50513          	addi	a0,a0,364 # 7068 <malloc+0x1364>
    3f04:	00002097          	auipc	ra,0x2
    3f08:	a40080e7          	jalr	-1472(ra) # 5944 <chdir>
}
    3f0c:	70e2                	ld	ra,56(sp)
    3f0e:	7442                	ld	s0,48(sp)
    3f10:	74a2                	ld	s1,40(sp)
    3f12:	7902                	ld	s2,32(sp)
    3f14:	69e2                	ld	s3,24(sp)
    3f16:	6a42                	ld	s4,16(sp)
    3f18:	6aa2                	ld	s5,8(sp)
    3f1a:	6b02                	ld	s6,0(sp)
    3f1c:	6121                	addi	sp,sp,64
    3f1e:	8082                	ret

0000000000003f20 <openiputtest>:
void openiputtest(char *s) {
    3f20:	7179                	addi	sp,sp,-48
    3f22:	f406                	sd	ra,40(sp)
    3f24:	f022                	sd	s0,32(sp)
    3f26:	ec26                	sd	s1,24(sp)
    3f28:	1800                	addi	s0,sp,48
    3f2a:	84aa                	mv	s1,a0
    if (mkdir("oidir") < 0) {
    3f2c:	00004517          	auipc	a0,0x4
    3f30:	9a450513          	addi	a0,a0,-1628 # 78d0 <malloc+0x1bcc>
    3f34:	00002097          	auipc	ra,0x2
    3f38:	a08080e7          	jalr	-1528(ra) # 593c <mkdir>
    3f3c:	04054263          	bltz	a0,3f80 <openiputtest+0x60>
    pid = fork();
    3f40:	00002097          	auipc	ra,0x2
    3f44:	98c080e7          	jalr	-1652(ra) # 58cc <fork>
    if (pid < 0) {
    3f48:	04054a63          	bltz	a0,3f9c <openiputtest+0x7c>
    if (pid == 0) {
    3f4c:	e93d                	bnez	a0,3fc2 <openiputtest+0xa2>
        int fd = open("oidir", O_RDWR);
    3f4e:	4589                	li	a1,2
    3f50:	00004517          	auipc	a0,0x4
    3f54:	98050513          	addi	a0,a0,-1664 # 78d0 <malloc+0x1bcc>
    3f58:	00002097          	auipc	ra,0x2
    3f5c:	9bc080e7          	jalr	-1604(ra) # 5914 <open>
        if (fd >= 0) {
    3f60:	04054c63          	bltz	a0,3fb8 <openiputtest+0x98>
            printf("%s: open directory for write succeeded\n", s);
    3f64:	85a6                	mv	a1,s1
    3f66:	00004517          	auipc	a0,0x4
    3f6a:	98a50513          	addi	a0,a0,-1654 # 78f0 <malloc+0x1bec>
    3f6e:	00002097          	auipc	ra,0x2
    3f72:	cde080e7          	jalr	-802(ra) # 5c4c <printf>
            exit(1);
    3f76:	4505                	li	a0,1
    3f78:	00002097          	auipc	ra,0x2
    3f7c:	95c080e7          	jalr	-1700(ra) # 58d4 <exit>
        printf("%s: mkdir oidir failed\n", s);
    3f80:	85a6                	mv	a1,s1
    3f82:	00004517          	auipc	a0,0x4
    3f86:	95650513          	addi	a0,a0,-1706 # 78d8 <malloc+0x1bd4>
    3f8a:	00002097          	auipc	ra,0x2
    3f8e:	cc2080e7          	jalr	-830(ra) # 5c4c <printf>
        exit(1);
    3f92:	4505                	li	a0,1
    3f94:	00002097          	auipc	ra,0x2
    3f98:	940080e7          	jalr	-1728(ra) # 58d4 <exit>
        printf("%s: fork failed\n", s);
    3f9c:	85a6                	mv	a1,s1
    3f9e:	00002517          	auipc	a0,0x2
    3fa2:	6fa50513          	addi	a0,a0,1786 # 6698 <malloc+0x994>
    3fa6:	00002097          	auipc	ra,0x2
    3faa:	ca6080e7          	jalr	-858(ra) # 5c4c <printf>
        exit(1);
    3fae:	4505                	li	a0,1
    3fb0:	00002097          	auipc	ra,0x2
    3fb4:	924080e7          	jalr	-1756(ra) # 58d4 <exit>
        exit(0);
    3fb8:	4501                	li	a0,0
    3fba:	00002097          	auipc	ra,0x2
    3fbe:	91a080e7          	jalr	-1766(ra) # 58d4 <exit>
    sleep(1);
    3fc2:	4505                	li	a0,1
    3fc4:	00002097          	auipc	ra,0x2
    3fc8:	9a0080e7          	jalr	-1632(ra) # 5964 <sleep>
    if (unlink("oidir") != 0) {
    3fcc:	00004517          	auipc	a0,0x4
    3fd0:	90450513          	addi	a0,a0,-1788 # 78d0 <malloc+0x1bcc>
    3fd4:	00002097          	auipc	ra,0x2
    3fd8:	950080e7          	jalr	-1712(ra) # 5924 <unlink>
    3fdc:	cd19                	beqz	a0,3ffa <openiputtest+0xda>
        printf("%s: unlink failed\n", s);
    3fde:	85a6                	mv	a1,s1
    3fe0:	00003517          	auipc	a0,0x3
    3fe4:	8a850513          	addi	a0,a0,-1880 # 6888 <malloc+0xb84>
    3fe8:	00002097          	auipc	ra,0x2
    3fec:	c64080e7          	jalr	-924(ra) # 5c4c <printf>
        exit(1);
    3ff0:	4505                	li	a0,1
    3ff2:	00002097          	auipc	ra,0x2
    3ff6:	8e2080e7          	jalr	-1822(ra) # 58d4 <exit>
    wait(&xstatus);
    3ffa:	fdc40513          	addi	a0,s0,-36
    3ffe:	00002097          	auipc	ra,0x2
    4002:	8de080e7          	jalr	-1826(ra) # 58dc <wait>
    exit(xstatus);
    4006:	fdc42503          	lw	a0,-36(s0)
    400a:	00002097          	auipc	ra,0x2
    400e:	8ca080e7          	jalr	-1846(ra) # 58d4 <exit>

0000000000004012 <forkforkfork>:
void forkforkfork(char *s) {
    4012:	1101                	addi	sp,sp,-32
    4014:	ec06                	sd	ra,24(sp)
    4016:	e822                	sd	s0,16(sp)
    4018:	e426                	sd	s1,8(sp)
    401a:	1000                	addi	s0,sp,32
    401c:	84aa                	mv	s1,a0
    unlink("stopforking");
    401e:	00004517          	auipc	a0,0x4
    4022:	8fa50513          	addi	a0,a0,-1798 # 7918 <malloc+0x1c14>
    4026:	00002097          	auipc	ra,0x2
    402a:	8fe080e7          	jalr	-1794(ra) # 5924 <unlink>
    int pid = fork();
    402e:	00002097          	auipc	ra,0x2
    4032:	89e080e7          	jalr	-1890(ra) # 58cc <fork>
    if (pid < 0) {
    4036:	04054563          	bltz	a0,4080 <forkforkfork+0x6e>
    if (pid == 0) {
    403a:	c12d                	beqz	a0,409c <forkforkfork+0x8a>
    sleep(20); // two seconds
    403c:	4551                	li	a0,20
    403e:	00002097          	auipc	ra,0x2
    4042:	926080e7          	jalr	-1754(ra) # 5964 <sleep>
    close(open("stopforking", O_CREATE | O_RDWR));
    4046:	20200593          	li	a1,514
    404a:	00004517          	auipc	a0,0x4
    404e:	8ce50513          	addi	a0,a0,-1842 # 7918 <malloc+0x1c14>
    4052:	00002097          	auipc	ra,0x2
    4056:	8c2080e7          	jalr	-1854(ra) # 5914 <open>
    405a:	00002097          	auipc	ra,0x2
    405e:	8a2080e7          	jalr	-1886(ra) # 58fc <close>
    wait(0);
    4062:	4501                	li	a0,0
    4064:	00002097          	auipc	ra,0x2
    4068:	878080e7          	jalr	-1928(ra) # 58dc <wait>
    sleep(10); // one second
    406c:	4529                	li	a0,10
    406e:	00002097          	auipc	ra,0x2
    4072:	8f6080e7          	jalr	-1802(ra) # 5964 <sleep>
}
    4076:	60e2                	ld	ra,24(sp)
    4078:	6442                	ld	s0,16(sp)
    407a:	64a2                	ld	s1,8(sp)
    407c:	6105                	addi	sp,sp,32
    407e:	8082                	ret
        printf("%s: fork failed", s);
    4080:	85a6                	mv	a1,s1
    4082:	00002517          	auipc	a0,0x2
    4086:	7d650513          	addi	a0,a0,2006 # 6858 <malloc+0xb54>
    408a:	00002097          	auipc	ra,0x2
    408e:	bc2080e7          	jalr	-1086(ra) # 5c4c <printf>
        exit(1);
    4092:	4505                	li	a0,1
    4094:	00002097          	auipc	ra,0x2
    4098:	840080e7          	jalr	-1984(ra) # 58d4 <exit>
            int fd = open("stopforking", 0);
    409c:	00004497          	auipc	s1,0x4
    40a0:	87c48493          	addi	s1,s1,-1924 # 7918 <malloc+0x1c14>
    40a4:	4581                	li	a1,0
    40a6:	8526                	mv	a0,s1
    40a8:	00002097          	auipc	ra,0x2
    40ac:	86c080e7          	jalr	-1940(ra) # 5914 <open>
            if (fd >= 0) {
    40b0:	02055763          	bgez	a0,40de <forkforkfork+0xcc>
            if (fork() < 0) {
    40b4:	00002097          	auipc	ra,0x2
    40b8:	818080e7          	jalr	-2024(ra) # 58cc <fork>
    40bc:	fe0554e3          	bgez	a0,40a4 <forkforkfork+0x92>
                close(open("stopforking", O_CREATE | O_RDWR));
    40c0:	20200593          	li	a1,514
    40c4:	00004517          	auipc	a0,0x4
    40c8:	85450513          	addi	a0,a0,-1964 # 7918 <malloc+0x1c14>
    40cc:	00002097          	auipc	ra,0x2
    40d0:	848080e7          	jalr	-1976(ra) # 5914 <open>
    40d4:	00002097          	auipc	ra,0x2
    40d8:	828080e7          	jalr	-2008(ra) # 58fc <close>
    40dc:	b7e1                	j	40a4 <forkforkfork+0x92>
                exit(0);
    40de:	4501                	li	a0,0
    40e0:	00001097          	auipc	ra,0x1
    40e4:	7f4080e7          	jalr	2036(ra) # 58d4 <exit>

00000000000040e8 <killstatus>:
void killstatus(char *s) {
    40e8:	7139                	addi	sp,sp,-64
    40ea:	fc06                	sd	ra,56(sp)
    40ec:	f822                	sd	s0,48(sp)
    40ee:	f426                	sd	s1,40(sp)
    40f0:	f04a                	sd	s2,32(sp)
    40f2:	ec4e                	sd	s3,24(sp)
    40f4:	e852                	sd	s4,16(sp)
    40f6:	0080                	addi	s0,sp,64
    40f8:	8a2a                	mv	s4,a0
    40fa:	06400913          	li	s2,100
        if (xst != -1) {
    40fe:	59fd                	li	s3,-1
        int pid1 = fork();
    4100:	00001097          	auipc	ra,0x1
    4104:	7cc080e7          	jalr	1996(ra) # 58cc <fork>
    4108:	84aa                	mv	s1,a0
        if (pid1 < 0) {
    410a:	02054f63          	bltz	a0,4148 <killstatus+0x60>
        if (pid1 == 0) {
    410e:	c939                	beqz	a0,4164 <killstatus+0x7c>
        sleep(1);
    4110:	4505                	li	a0,1
    4112:	00002097          	auipc	ra,0x2
    4116:	852080e7          	jalr	-1966(ra) # 5964 <sleep>
        kill(pid1);
    411a:	8526                	mv	a0,s1
    411c:	00001097          	auipc	ra,0x1
    4120:	7e8080e7          	jalr	2024(ra) # 5904 <kill>
        wait(&xst);
    4124:	fcc40513          	addi	a0,s0,-52
    4128:	00001097          	auipc	ra,0x1
    412c:	7b4080e7          	jalr	1972(ra) # 58dc <wait>
        if (xst != -1) {
    4130:	fcc42783          	lw	a5,-52(s0)
    4134:	03379d63          	bne	a5,s3,416e <killstatus+0x86>
    for (int i = 0; i < 100; i++) {
    4138:	397d                	addiw	s2,s2,-1
    413a:	fc0913e3          	bnez	s2,4100 <killstatus+0x18>
    exit(0);
    413e:	4501                	li	a0,0
    4140:	00001097          	auipc	ra,0x1
    4144:	794080e7          	jalr	1940(ra) # 58d4 <exit>
            printf("%s: fork failed\n", s);
    4148:	85d2                	mv	a1,s4
    414a:	00002517          	auipc	a0,0x2
    414e:	54e50513          	addi	a0,a0,1358 # 6698 <malloc+0x994>
    4152:	00002097          	auipc	ra,0x2
    4156:	afa080e7          	jalr	-1286(ra) # 5c4c <printf>
            exit(1);
    415a:	4505                	li	a0,1
    415c:	00001097          	auipc	ra,0x1
    4160:	778080e7          	jalr	1912(ra) # 58d4 <exit>
                getpid();
    4164:	00001097          	auipc	ra,0x1
    4168:	7f0080e7          	jalr	2032(ra) # 5954 <getpid>
            while (1) {
    416c:	bfe5                	j	4164 <killstatus+0x7c>
            printf("%s: status should be -1\n", s);
    416e:	85d2                	mv	a1,s4
    4170:	00003517          	auipc	a0,0x3
    4174:	7b850513          	addi	a0,a0,1976 # 7928 <malloc+0x1c24>
    4178:	00002097          	auipc	ra,0x2
    417c:	ad4080e7          	jalr	-1324(ra) # 5c4c <printf>
            exit(1);
    4180:	4505                	li	a0,1
    4182:	00001097          	auipc	ra,0x1
    4186:	752080e7          	jalr	1874(ra) # 58d4 <exit>

000000000000418a <preempt>:
void preempt(char *s) {
    418a:	7139                	addi	sp,sp,-64
    418c:	fc06                	sd	ra,56(sp)
    418e:	f822                	sd	s0,48(sp)
    4190:	f426                	sd	s1,40(sp)
    4192:	f04a                	sd	s2,32(sp)
    4194:	ec4e                	sd	s3,24(sp)
    4196:	e852                	sd	s4,16(sp)
    4198:	0080                	addi	s0,sp,64
    419a:	892a                	mv	s2,a0
    pid1 = fork();
    419c:	00001097          	auipc	ra,0x1
    41a0:	730080e7          	jalr	1840(ra) # 58cc <fork>
    if (pid1 < 0) {
    41a4:	00054563          	bltz	a0,41ae <preempt+0x24>
    41a8:	84aa                	mv	s1,a0
    if (pid1 == 0)
    41aa:	e105                	bnez	a0,41ca <preempt+0x40>
        for (;;)
    41ac:	a001                	j	41ac <preempt+0x22>
        printf("%s: fork failed", s);
    41ae:	85ca                	mv	a1,s2
    41b0:	00002517          	auipc	a0,0x2
    41b4:	6a850513          	addi	a0,a0,1704 # 6858 <malloc+0xb54>
    41b8:	00002097          	auipc	ra,0x2
    41bc:	a94080e7          	jalr	-1388(ra) # 5c4c <printf>
        exit(1);
    41c0:	4505                	li	a0,1
    41c2:	00001097          	auipc	ra,0x1
    41c6:	712080e7          	jalr	1810(ra) # 58d4 <exit>
    pid2 = fork();
    41ca:	00001097          	auipc	ra,0x1
    41ce:	702080e7          	jalr	1794(ra) # 58cc <fork>
    41d2:	89aa                	mv	s3,a0
    if (pid2 < 0) {
    41d4:	00054463          	bltz	a0,41dc <preempt+0x52>
    if (pid2 == 0)
    41d8:	e105                	bnez	a0,41f8 <preempt+0x6e>
        for (;;)
    41da:	a001                	j	41da <preempt+0x50>
        printf("%s: fork failed\n", s);
    41dc:	85ca                	mv	a1,s2
    41de:	00002517          	auipc	a0,0x2
    41e2:	4ba50513          	addi	a0,a0,1210 # 6698 <malloc+0x994>
    41e6:	00002097          	auipc	ra,0x2
    41ea:	a66080e7          	jalr	-1434(ra) # 5c4c <printf>
        exit(1);
    41ee:	4505                	li	a0,1
    41f0:	00001097          	auipc	ra,0x1
    41f4:	6e4080e7          	jalr	1764(ra) # 58d4 <exit>
    pipe(pfds);
    41f8:	fc840513          	addi	a0,s0,-56
    41fc:	00001097          	auipc	ra,0x1
    4200:	6e8080e7          	jalr	1768(ra) # 58e4 <pipe>
    pid3 = fork();
    4204:	00001097          	auipc	ra,0x1
    4208:	6c8080e7          	jalr	1736(ra) # 58cc <fork>
    420c:	8a2a                	mv	s4,a0
    if (pid3 < 0) {
    420e:	02054e63          	bltz	a0,424a <preempt+0xc0>
    if (pid3 == 0) {
    4212:	e525                	bnez	a0,427a <preempt+0xf0>
        close(pfds[0]);
    4214:	fc842503          	lw	a0,-56(s0)
    4218:	00001097          	auipc	ra,0x1
    421c:	6e4080e7          	jalr	1764(ra) # 58fc <close>
        if (write(pfds[1], "x", 1) != 1)
    4220:	4605                	li	a2,1
    4222:	00002597          	auipc	a1,0x2
    4226:	c8e58593          	addi	a1,a1,-882 # 5eb0 <malloc+0x1ac>
    422a:	fcc42503          	lw	a0,-52(s0)
    422e:	00001097          	auipc	ra,0x1
    4232:	6c6080e7          	jalr	1734(ra) # 58f4 <write>
    4236:	4785                	li	a5,1
    4238:	02f51763          	bne	a0,a5,4266 <preempt+0xdc>
        close(pfds[1]);
    423c:	fcc42503          	lw	a0,-52(s0)
    4240:	00001097          	auipc	ra,0x1
    4244:	6bc080e7          	jalr	1724(ra) # 58fc <close>
        for (;;)
    4248:	a001                	j	4248 <preempt+0xbe>
        printf("%s: fork failed\n", s);
    424a:	85ca                	mv	a1,s2
    424c:	00002517          	auipc	a0,0x2
    4250:	44c50513          	addi	a0,a0,1100 # 6698 <malloc+0x994>
    4254:	00002097          	auipc	ra,0x2
    4258:	9f8080e7          	jalr	-1544(ra) # 5c4c <printf>
        exit(1);
    425c:	4505                	li	a0,1
    425e:	00001097          	auipc	ra,0x1
    4262:	676080e7          	jalr	1654(ra) # 58d4 <exit>
            printf("%s: preempt write error", s);
    4266:	85ca                	mv	a1,s2
    4268:	00003517          	auipc	a0,0x3
    426c:	6e050513          	addi	a0,a0,1760 # 7948 <malloc+0x1c44>
    4270:	00002097          	auipc	ra,0x2
    4274:	9dc080e7          	jalr	-1572(ra) # 5c4c <printf>
    4278:	b7d1                	j	423c <preempt+0xb2>
    close(pfds[1]);
    427a:	fcc42503          	lw	a0,-52(s0)
    427e:	00001097          	auipc	ra,0x1
    4282:	67e080e7          	jalr	1662(ra) # 58fc <close>
    if (read(pfds[0], buf, sizeof(buf)) != 1) {
    4286:	660d                	lui	a2,0x3
    4288:	00009597          	auipc	a1,0x9
    428c:	e5858593          	addi	a1,a1,-424 # d0e0 <buf>
    4290:	fc842503          	lw	a0,-56(s0)
    4294:	00001097          	auipc	ra,0x1
    4298:	658080e7          	jalr	1624(ra) # 58ec <read>
    429c:	4785                	li	a5,1
    429e:	02f50363          	beq	a0,a5,42c4 <preempt+0x13a>
        printf("%s: preempt read error", s);
    42a2:	85ca                	mv	a1,s2
    42a4:	00003517          	auipc	a0,0x3
    42a8:	6bc50513          	addi	a0,a0,1724 # 7960 <malloc+0x1c5c>
    42ac:	00002097          	auipc	ra,0x2
    42b0:	9a0080e7          	jalr	-1632(ra) # 5c4c <printf>
}
    42b4:	70e2                	ld	ra,56(sp)
    42b6:	7442                	ld	s0,48(sp)
    42b8:	74a2                	ld	s1,40(sp)
    42ba:	7902                	ld	s2,32(sp)
    42bc:	69e2                	ld	s3,24(sp)
    42be:	6a42                	ld	s4,16(sp)
    42c0:	6121                	addi	sp,sp,64
    42c2:	8082                	ret
    close(pfds[0]);
    42c4:	fc842503          	lw	a0,-56(s0)
    42c8:	00001097          	auipc	ra,0x1
    42cc:	634080e7          	jalr	1588(ra) # 58fc <close>
    printf("kill... ");
    42d0:	00003517          	auipc	a0,0x3
    42d4:	6a850513          	addi	a0,a0,1704 # 7978 <malloc+0x1c74>
    42d8:	00002097          	auipc	ra,0x2
    42dc:	974080e7          	jalr	-1676(ra) # 5c4c <printf>
    kill(pid1);
    42e0:	8526                	mv	a0,s1
    42e2:	00001097          	auipc	ra,0x1
    42e6:	622080e7          	jalr	1570(ra) # 5904 <kill>
    kill(pid2);
    42ea:	854e                	mv	a0,s3
    42ec:	00001097          	auipc	ra,0x1
    42f0:	618080e7          	jalr	1560(ra) # 5904 <kill>
    kill(pid3);
    42f4:	8552                	mv	a0,s4
    42f6:	00001097          	auipc	ra,0x1
    42fa:	60e080e7          	jalr	1550(ra) # 5904 <kill>
    printf("wait... ");
    42fe:	00003517          	auipc	a0,0x3
    4302:	68a50513          	addi	a0,a0,1674 # 7988 <malloc+0x1c84>
    4306:	00002097          	auipc	ra,0x2
    430a:	946080e7          	jalr	-1722(ra) # 5c4c <printf>
    wait(0);
    430e:	4501                	li	a0,0
    4310:	00001097          	auipc	ra,0x1
    4314:	5cc080e7          	jalr	1484(ra) # 58dc <wait>
    wait(0);
    4318:	4501                	li	a0,0
    431a:	00001097          	auipc	ra,0x1
    431e:	5c2080e7          	jalr	1474(ra) # 58dc <wait>
    wait(0);
    4322:	4501                	li	a0,0
    4324:	00001097          	auipc	ra,0x1
    4328:	5b8080e7          	jalr	1464(ra) # 58dc <wait>
    432c:	b761                	j	42b4 <preempt+0x12a>

000000000000432e <reparent>:
void reparent(char *s) {
    432e:	7179                	addi	sp,sp,-48
    4330:	f406                	sd	ra,40(sp)
    4332:	f022                	sd	s0,32(sp)
    4334:	ec26                	sd	s1,24(sp)
    4336:	e84a                	sd	s2,16(sp)
    4338:	e44e                	sd	s3,8(sp)
    433a:	e052                	sd	s4,0(sp)
    433c:	1800                	addi	s0,sp,48
    433e:	89aa                	mv	s3,a0
    int master_pid = getpid();
    4340:	00001097          	auipc	ra,0x1
    4344:	614080e7          	jalr	1556(ra) # 5954 <getpid>
    4348:	8a2a                	mv	s4,a0
    434a:	0c800913          	li	s2,200
        int pid = fork();
    434e:	00001097          	auipc	ra,0x1
    4352:	57e080e7          	jalr	1406(ra) # 58cc <fork>
    4356:	84aa                	mv	s1,a0
        if (pid < 0) {
    4358:	02054263          	bltz	a0,437c <reparent+0x4e>
        if (pid) {
    435c:	cd21                	beqz	a0,43b4 <reparent+0x86>
            if (wait(0) != pid) {
    435e:	4501                	li	a0,0
    4360:	00001097          	auipc	ra,0x1
    4364:	57c080e7          	jalr	1404(ra) # 58dc <wait>
    4368:	02951863          	bne	a0,s1,4398 <reparent+0x6a>
    for (int i = 0; i < 200; i++) {
    436c:	397d                	addiw	s2,s2,-1
    436e:	fe0910e3          	bnez	s2,434e <reparent+0x20>
    exit(0);
    4372:	4501                	li	a0,0
    4374:	00001097          	auipc	ra,0x1
    4378:	560080e7          	jalr	1376(ra) # 58d4 <exit>
            printf("%s: fork failed\n", s);
    437c:	85ce                	mv	a1,s3
    437e:	00002517          	auipc	a0,0x2
    4382:	31a50513          	addi	a0,a0,794 # 6698 <malloc+0x994>
    4386:	00002097          	auipc	ra,0x2
    438a:	8c6080e7          	jalr	-1850(ra) # 5c4c <printf>
            exit(1);
    438e:	4505                	li	a0,1
    4390:	00001097          	auipc	ra,0x1
    4394:	544080e7          	jalr	1348(ra) # 58d4 <exit>
                printf("%s: wait wrong pid\n", s);
    4398:	85ce                	mv	a1,s3
    439a:	00002517          	auipc	a0,0x2
    439e:	48650513          	addi	a0,a0,1158 # 6820 <malloc+0xb1c>
    43a2:	00002097          	auipc	ra,0x2
    43a6:	8aa080e7          	jalr	-1878(ra) # 5c4c <printf>
                exit(1);
    43aa:	4505                	li	a0,1
    43ac:	00001097          	auipc	ra,0x1
    43b0:	528080e7          	jalr	1320(ra) # 58d4 <exit>
            int pid2 = fork();
    43b4:	00001097          	auipc	ra,0x1
    43b8:	518080e7          	jalr	1304(ra) # 58cc <fork>
            if (pid2 < 0) {
    43bc:	00054763          	bltz	a0,43ca <reparent+0x9c>
            exit(0);
    43c0:	4501                	li	a0,0
    43c2:	00001097          	auipc	ra,0x1
    43c6:	512080e7          	jalr	1298(ra) # 58d4 <exit>
                kill(master_pid);
    43ca:	8552                	mv	a0,s4
    43cc:	00001097          	auipc	ra,0x1
    43d0:	538080e7          	jalr	1336(ra) # 5904 <kill>
                exit(1);
    43d4:	4505                	li	a0,1
    43d6:	00001097          	auipc	ra,0x1
    43da:	4fe080e7          	jalr	1278(ra) # 58d4 <exit>

00000000000043de <sbrkfail>:
void sbrkfail(char *s) {
    43de:	7119                	addi	sp,sp,-128
    43e0:	fc86                	sd	ra,120(sp)
    43e2:	f8a2                	sd	s0,112(sp)
    43e4:	f4a6                	sd	s1,104(sp)
    43e6:	f0ca                	sd	s2,96(sp)
    43e8:	ecce                	sd	s3,88(sp)
    43ea:	e8d2                	sd	s4,80(sp)
    43ec:	e4d6                	sd	s5,72(sp)
    43ee:	0100                	addi	s0,sp,128
    43f0:	8aaa                	mv	s5,a0
    if (pipe(fds) != 0) {
    43f2:	fb040513          	addi	a0,s0,-80
    43f6:	00001097          	auipc	ra,0x1
    43fa:	4ee080e7          	jalr	1262(ra) # 58e4 <pipe>
    43fe:	e901                	bnez	a0,440e <sbrkfail+0x30>
    4400:	f8040493          	addi	s1,s0,-128
    4404:	fa840993          	addi	s3,s0,-88
    4408:	8926                	mv	s2,s1
        if (pids[i] != -1)
    440a:	5a7d                	li	s4,-1
    440c:	a085                	j	446c <sbrkfail+0x8e>
        printf("%s: pipe() failed\n", s);
    440e:	85d6                	mv	a1,s5
    4410:	00002517          	auipc	a0,0x2
    4414:	39050513          	addi	a0,a0,912 # 67a0 <malloc+0xa9c>
    4418:	00002097          	auipc	ra,0x2
    441c:	834080e7          	jalr	-1996(ra) # 5c4c <printf>
        exit(1);
    4420:	4505                	li	a0,1
    4422:	00001097          	auipc	ra,0x1
    4426:	4b2080e7          	jalr	1202(ra) # 58d4 <exit>
            sbrk(BIG - (uint64)sbrk(0));
    442a:	00001097          	auipc	ra,0x1
    442e:	532080e7          	jalr	1330(ra) # 595c <sbrk>
    4432:	064007b7          	lui	a5,0x6400
    4436:	40a7853b          	subw	a0,a5,a0
    443a:	00001097          	auipc	ra,0x1
    443e:	522080e7          	jalr	1314(ra) # 595c <sbrk>
            write(fds[1], "x", 1);
    4442:	4605                	li	a2,1
    4444:	00002597          	auipc	a1,0x2
    4448:	a6c58593          	addi	a1,a1,-1428 # 5eb0 <malloc+0x1ac>
    444c:	fb442503          	lw	a0,-76(s0)
    4450:	00001097          	auipc	ra,0x1
    4454:	4a4080e7          	jalr	1188(ra) # 58f4 <write>
                sleep(1000);
    4458:	3e800513          	li	a0,1000
    445c:	00001097          	auipc	ra,0x1
    4460:	508080e7          	jalr	1288(ra) # 5964 <sleep>
            for (;;)
    4464:	bfd5                	j	4458 <sbrkfail+0x7a>
    for (i = 0; i < sizeof(pids) / sizeof(pids[0]); i++) {
    4466:	0911                	addi	s2,s2,4
    4468:	03390563          	beq	s2,s3,4492 <sbrkfail+0xb4>
        if ((pids[i] = fork()) == 0) {
    446c:	00001097          	auipc	ra,0x1
    4470:	460080e7          	jalr	1120(ra) # 58cc <fork>
    4474:	00a92023          	sw	a0,0(s2)
    4478:	d94d                	beqz	a0,442a <sbrkfail+0x4c>
        if (pids[i] != -1)
    447a:	ff4506e3          	beq	a0,s4,4466 <sbrkfail+0x88>
            read(fds[0], &scratch, 1);
    447e:	4605                	li	a2,1
    4480:	faf40593          	addi	a1,s0,-81
    4484:	fb042503          	lw	a0,-80(s0)
    4488:	00001097          	auipc	ra,0x1
    448c:	464080e7          	jalr	1124(ra) # 58ec <read>
    4490:	bfd9                	j	4466 <sbrkfail+0x88>
    c = sbrk(PGSIZE);
    4492:	6505                	lui	a0,0x1
    4494:	00001097          	auipc	ra,0x1
    4498:	4c8080e7          	jalr	1224(ra) # 595c <sbrk>
    449c:	8a2a                	mv	s4,a0
        if (pids[i] == -1)
    449e:	597d                	li	s2,-1
    44a0:	a021                	j	44a8 <sbrkfail+0xca>
    for (i = 0; i < sizeof(pids) / sizeof(pids[0]); i++) {
    44a2:	0491                	addi	s1,s1,4
    44a4:	01348f63          	beq	s1,s3,44c2 <sbrkfail+0xe4>
        if (pids[i] == -1)
    44a8:	4088                	lw	a0,0(s1)
    44aa:	ff250ce3          	beq	a0,s2,44a2 <sbrkfail+0xc4>
        kill(pids[i]);
    44ae:	00001097          	auipc	ra,0x1
    44b2:	456080e7          	jalr	1110(ra) # 5904 <kill>
        wait(0);
    44b6:	4501                	li	a0,0
    44b8:	00001097          	auipc	ra,0x1
    44bc:	424080e7          	jalr	1060(ra) # 58dc <wait>
    44c0:	b7cd                	j	44a2 <sbrkfail+0xc4>
    if (c == (char *)0xffffffffffffffffL) {
    44c2:	57fd                	li	a5,-1
    44c4:	04fa0163          	beq	s4,a5,4506 <sbrkfail+0x128>
    pid = fork();
    44c8:	00001097          	auipc	ra,0x1
    44cc:	404080e7          	jalr	1028(ra) # 58cc <fork>
    44d0:	84aa                	mv	s1,a0
    if (pid < 0) {
    44d2:	04054863          	bltz	a0,4522 <sbrkfail+0x144>
    if (pid == 0) {
    44d6:	c525                	beqz	a0,453e <sbrkfail+0x160>
    wait(&xstatus);
    44d8:	fbc40513          	addi	a0,s0,-68
    44dc:	00001097          	auipc	ra,0x1
    44e0:	400080e7          	jalr	1024(ra) # 58dc <wait>
    if (xstatus != -1 && xstatus != 2)
    44e4:	fbc42783          	lw	a5,-68(s0)
    44e8:	577d                	li	a4,-1
    44ea:	00e78563          	beq	a5,a4,44f4 <sbrkfail+0x116>
    44ee:	4709                	li	a4,2
    44f0:	08e79d63          	bne	a5,a4,458a <sbrkfail+0x1ac>
}
    44f4:	70e6                	ld	ra,120(sp)
    44f6:	7446                	ld	s0,112(sp)
    44f8:	74a6                	ld	s1,104(sp)
    44fa:	7906                	ld	s2,96(sp)
    44fc:	69e6                	ld	s3,88(sp)
    44fe:	6a46                	ld	s4,80(sp)
    4500:	6aa6                	ld	s5,72(sp)
    4502:	6109                	addi	sp,sp,128
    4504:	8082                	ret
        printf("%s: failed sbrk leaked memory\n", s);
    4506:	85d6                	mv	a1,s5
    4508:	00003517          	auipc	a0,0x3
    450c:	49050513          	addi	a0,a0,1168 # 7998 <malloc+0x1c94>
    4510:	00001097          	auipc	ra,0x1
    4514:	73c080e7          	jalr	1852(ra) # 5c4c <printf>
        exit(1);
    4518:	4505                	li	a0,1
    451a:	00001097          	auipc	ra,0x1
    451e:	3ba080e7          	jalr	954(ra) # 58d4 <exit>
        printf("%s: fork failed\n", s);
    4522:	85d6                	mv	a1,s5
    4524:	00002517          	auipc	a0,0x2
    4528:	17450513          	addi	a0,a0,372 # 6698 <malloc+0x994>
    452c:	00001097          	auipc	ra,0x1
    4530:	720080e7          	jalr	1824(ra) # 5c4c <printf>
        exit(1);
    4534:	4505                	li	a0,1
    4536:	00001097          	auipc	ra,0x1
    453a:	39e080e7          	jalr	926(ra) # 58d4 <exit>
        a = sbrk(0);
    453e:	4501                	li	a0,0
    4540:	00001097          	auipc	ra,0x1
    4544:	41c080e7          	jalr	1052(ra) # 595c <sbrk>
    4548:	892a                	mv	s2,a0
        sbrk(10 * BIG);
    454a:	3e800537          	lui	a0,0x3e800
    454e:	00001097          	auipc	ra,0x1
    4552:	40e080e7          	jalr	1038(ra) # 595c <sbrk>
        for (i = 0; i < 10 * BIG; i += PGSIZE) {
    4556:	87ca                	mv	a5,s2
    4558:	3e800737          	lui	a4,0x3e800
    455c:	993a                	add	s2,s2,a4
    455e:	6705                	lui	a4,0x1
            n += *(a + i);
    4560:	0007c683          	lbu	a3,0(a5) # 6400000 <__BSS_END__+0x63eff10>
    4564:	9cb5                	addw	s1,s1,a3
        for (i = 0; i < 10 * BIG; i += PGSIZE) {
    4566:	97ba                	add	a5,a5,a4
    4568:	fef91ce3          	bne	s2,a5,4560 <sbrkfail+0x182>
        printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    456c:	8626                	mv	a2,s1
    456e:	85d6                	mv	a1,s5
    4570:	00003517          	auipc	a0,0x3
    4574:	44850513          	addi	a0,a0,1096 # 79b8 <malloc+0x1cb4>
    4578:	00001097          	auipc	ra,0x1
    457c:	6d4080e7          	jalr	1748(ra) # 5c4c <printf>
        exit(1);
    4580:	4505                	li	a0,1
    4582:	00001097          	auipc	ra,0x1
    4586:	352080e7          	jalr	850(ra) # 58d4 <exit>
        exit(1);
    458a:	4505                	li	a0,1
    458c:	00001097          	auipc	ra,0x1
    4590:	348080e7          	jalr	840(ra) # 58d4 <exit>

0000000000004594 <mem>:
void mem(char *s) {
    4594:	7139                	addi	sp,sp,-64
    4596:	fc06                	sd	ra,56(sp)
    4598:	f822                	sd	s0,48(sp)
    459a:	f426                	sd	s1,40(sp)
    459c:	f04a                	sd	s2,32(sp)
    459e:	ec4e                	sd	s3,24(sp)
    45a0:	0080                	addi	s0,sp,64
    45a2:	89aa                	mv	s3,a0
    if ((pid = fork()) == 0) {
    45a4:	00001097          	auipc	ra,0x1
    45a8:	328080e7          	jalr	808(ra) # 58cc <fork>
        m1 = 0;
    45ac:	4481                	li	s1,0
        while ((m2 = malloc(10001)) != 0) {
    45ae:	6909                	lui	s2,0x2
    45b0:	71190913          	addi	s2,s2,1809 # 2711 <sbrkbasic+0x6b>
    if ((pid = fork()) == 0) {
    45b4:	c115                	beqz	a0,45d8 <mem+0x44>
        wait(&xstatus);
    45b6:	fcc40513          	addi	a0,s0,-52
    45ba:	00001097          	auipc	ra,0x1
    45be:	322080e7          	jalr	802(ra) # 58dc <wait>
        if (xstatus == -1) {
    45c2:	fcc42503          	lw	a0,-52(s0)
    45c6:	57fd                	li	a5,-1
    45c8:	06f50363          	beq	a0,a5,462e <mem+0x9a>
        exit(xstatus);
    45cc:	00001097          	auipc	ra,0x1
    45d0:	308080e7          	jalr	776(ra) # 58d4 <exit>
            *(char **)m2 = m1;
    45d4:	e104                	sd	s1,0(a0)
            m1 = m2;
    45d6:	84aa                	mv	s1,a0
        while ((m2 = malloc(10001)) != 0) {
    45d8:	854a                	mv	a0,s2
    45da:	00001097          	auipc	ra,0x1
    45de:	72a080e7          	jalr	1834(ra) # 5d04 <malloc>
    45e2:	f96d                	bnez	a0,45d4 <mem+0x40>
        while (m1) {
    45e4:	c881                	beqz	s1,45f4 <mem+0x60>
            m2 = *(char **)m1;
    45e6:	8526                	mv	a0,s1
    45e8:	6084                	ld	s1,0(s1)
            free(m1);
    45ea:	00001097          	auipc	ra,0x1
    45ee:	698080e7          	jalr	1688(ra) # 5c82 <free>
        while (m1) {
    45f2:	f8f5                	bnez	s1,45e6 <mem+0x52>
        m1 = malloc(1024 * 20);
    45f4:	6515                	lui	a0,0x5
    45f6:	00001097          	auipc	ra,0x1
    45fa:	70e080e7          	jalr	1806(ra) # 5d04 <malloc>
        if (m1 == 0) {
    45fe:	c911                	beqz	a0,4612 <mem+0x7e>
        free(m1);
    4600:	00001097          	auipc	ra,0x1
    4604:	682080e7          	jalr	1666(ra) # 5c82 <free>
        exit(0);
    4608:	4501                	li	a0,0
    460a:	00001097          	auipc	ra,0x1
    460e:	2ca080e7          	jalr	714(ra) # 58d4 <exit>
            printf("couldn't allocate mem?!!\n", s);
    4612:	85ce                	mv	a1,s3
    4614:	00003517          	auipc	a0,0x3
    4618:	3d450513          	addi	a0,a0,980 # 79e8 <malloc+0x1ce4>
    461c:	00001097          	auipc	ra,0x1
    4620:	630080e7          	jalr	1584(ra) # 5c4c <printf>
            exit(1);
    4624:	4505                	li	a0,1
    4626:	00001097          	auipc	ra,0x1
    462a:	2ae080e7          	jalr	686(ra) # 58d4 <exit>
            exit(0);
    462e:	4501                	li	a0,0
    4630:	00001097          	auipc	ra,0x1
    4634:	2a4080e7          	jalr	676(ra) # 58d4 <exit>

0000000000004638 <sharedfd>:
void sharedfd(char *s) {
    4638:	7159                	addi	sp,sp,-112
    463a:	f486                	sd	ra,104(sp)
    463c:	f0a2                	sd	s0,96(sp)
    463e:	e0d2                	sd	s4,64(sp)
    4640:	1880                	addi	s0,sp,112
    4642:	8a2a                	mv	s4,a0
    unlink("sharedfd");
    4644:	00003517          	auipc	a0,0x3
    4648:	3c450513          	addi	a0,a0,964 # 7a08 <malloc+0x1d04>
    464c:	00001097          	auipc	ra,0x1
    4650:	2d8080e7          	jalr	728(ra) # 5924 <unlink>
    fd = open("sharedfd", O_CREATE | O_RDWR);
    4654:	20200593          	li	a1,514
    4658:	00003517          	auipc	a0,0x3
    465c:	3b050513          	addi	a0,a0,944 # 7a08 <malloc+0x1d04>
    4660:	00001097          	auipc	ra,0x1
    4664:	2b4080e7          	jalr	692(ra) # 5914 <open>
    if (fd < 0) {
    4668:	06054063          	bltz	a0,46c8 <sharedfd+0x90>
    466c:	eca6                	sd	s1,88(sp)
    466e:	e8ca                	sd	s2,80(sp)
    4670:	e4ce                	sd	s3,72(sp)
    4672:	fc56                	sd	s5,56(sp)
    4674:	f85a                	sd	s6,48(sp)
    4676:	f45e                	sd	s7,40(sp)
    4678:	892a                	mv	s2,a0
    pid = fork();
    467a:	00001097          	auipc	ra,0x1
    467e:	252080e7          	jalr	594(ra) # 58cc <fork>
    4682:	89aa                	mv	s3,a0
    memset(buf, pid == 0 ? 'c' : 'p', sizeof(buf));
    4684:	07000593          	li	a1,112
    4688:	e119                	bnez	a0,468e <sharedfd+0x56>
    468a:	06300593          	li	a1,99
    468e:	4629                	li	a2,10
    4690:	fa040513          	addi	a0,s0,-96
    4694:	00001097          	auipc	ra,0x1
    4698:	046080e7          	jalr	70(ra) # 56da <memset>
    469c:	3e800493          	li	s1,1000
        if (write(fd, buf, sizeof(buf)) != sizeof(buf)) {
    46a0:	4629                	li	a2,10
    46a2:	fa040593          	addi	a1,s0,-96
    46a6:	854a                	mv	a0,s2
    46a8:	00001097          	auipc	ra,0x1
    46ac:	24c080e7          	jalr	588(ra) # 58f4 <write>
    46b0:	47a9                	li	a5,10
    46b2:	02f51f63          	bne	a0,a5,46f0 <sharedfd+0xb8>
    for (i = 0; i < N; i++) {
    46b6:	34fd                	addiw	s1,s1,-1
    46b8:	f4e5                	bnez	s1,46a0 <sharedfd+0x68>
    if (pid == 0) {
    46ba:	04099963          	bnez	s3,470c <sharedfd+0xd4>
        exit(0);
    46be:	4501                	li	a0,0
    46c0:	00001097          	auipc	ra,0x1
    46c4:	214080e7          	jalr	532(ra) # 58d4 <exit>
    46c8:	eca6                	sd	s1,88(sp)
    46ca:	e8ca                	sd	s2,80(sp)
    46cc:	e4ce                	sd	s3,72(sp)
    46ce:	fc56                	sd	s5,56(sp)
    46d0:	f85a                	sd	s6,48(sp)
    46d2:	f45e                	sd	s7,40(sp)
        printf("%s: cannot open sharedfd for writing", s);
    46d4:	85d2                	mv	a1,s4
    46d6:	00003517          	auipc	a0,0x3
    46da:	34250513          	addi	a0,a0,834 # 7a18 <malloc+0x1d14>
    46de:	00001097          	auipc	ra,0x1
    46e2:	56e080e7          	jalr	1390(ra) # 5c4c <printf>
        exit(1);
    46e6:	4505                	li	a0,1
    46e8:	00001097          	auipc	ra,0x1
    46ec:	1ec080e7          	jalr	492(ra) # 58d4 <exit>
            printf("%s: write sharedfd failed\n", s);
    46f0:	85d2                	mv	a1,s4
    46f2:	00003517          	auipc	a0,0x3
    46f6:	34e50513          	addi	a0,a0,846 # 7a40 <malloc+0x1d3c>
    46fa:	00001097          	auipc	ra,0x1
    46fe:	552080e7          	jalr	1362(ra) # 5c4c <printf>
            exit(1);
    4702:	4505                	li	a0,1
    4704:	00001097          	auipc	ra,0x1
    4708:	1d0080e7          	jalr	464(ra) # 58d4 <exit>
        wait(&xstatus);
    470c:	f9c40513          	addi	a0,s0,-100
    4710:	00001097          	auipc	ra,0x1
    4714:	1cc080e7          	jalr	460(ra) # 58dc <wait>
        if (xstatus != 0)
    4718:	f9c42983          	lw	s3,-100(s0)
    471c:	00098763          	beqz	s3,472a <sharedfd+0xf2>
            exit(xstatus);
    4720:	854e                	mv	a0,s3
    4722:	00001097          	auipc	ra,0x1
    4726:	1b2080e7          	jalr	434(ra) # 58d4 <exit>
    close(fd);
    472a:	854a                	mv	a0,s2
    472c:	00001097          	auipc	ra,0x1
    4730:	1d0080e7          	jalr	464(ra) # 58fc <close>
    fd = open("sharedfd", 0);
    4734:	4581                	li	a1,0
    4736:	00003517          	auipc	a0,0x3
    473a:	2d250513          	addi	a0,a0,722 # 7a08 <malloc+0x1d04>
    473e:	00001097          	auipc	ra,0x1
    4742:	1d6080e7          	jalr	470(ra) # 5914 <open>
    4746:	8baa                	mv	s7,a0
    nc = np = 0;
    4748:	8ace                	mv	s5,s3
    if (fd < 0) {
    474a:	02054563          	bltz	a0,4774 <sharedfd+0x13c>
    474e:	faa40913          	addi	s2,s0,-86
            if (buf[i] == 'c')
    4752:	06300493          	li	s1,99
            if (buf[i] == 'p')
    4756:	07000b13          	li	s6,112
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
    475a:	4629                	li	a2,10
    475c:	fa040593          	addi	a1,s0,-96
    4760:	855e                	mv	a0,s7
    4762:	00001097          	auipc	ra,0x1
    4766:	18a080e7          	jalr	394(ra) # 58ec <read>
    476a:	02a05f63          	blez	a0,47a8 <sharedfd+0x170>
    476e:	fa040793          	addi	a5,s0,-96
    4772:	a01d                	j	4798 <sharedfd+0x160>
        printf("%s: cannot open sharedfd for reading\n", s);
    4774:	85d2                	mv	a1,s4
    4776:	00003517          	auipc	a0,0x3
    477a:	2ea50513          	addi	a0,a0,746 # 7a60 <malloc+0x1d5c>
    477e:	00001097          	auipc	ra,0x1
    4782:	4ce080e7          	jalr	1230(ra) # 5c4c <printf>
        exit(1);
    4786:	4505                	li	a0,1
    4788:	00001097          	auipc	ra,0x1
    478c:	14c080e7          	jalr	332(ra) # 58d4 <exit>
                nc++;
    4790:	2985                	addiw	s3,s3,1
        for (i = 0; i < sizeof(buf); i++) {
    4792:	0785                	addi	a5,a5,1
    4794:	fd2783e3          	beq	a5,s2,475a <sharedfd+0x122>
            if (buf[i] == 'c')
    4798:	0007c703          	lbu	a4,0(a5)
    479c:	fe970ae3          	beq	a4,s1,4790 <sharedfd+0x158>
            if (buf[i] == 'p')
    47a0:	ff6719e3          	bne	a4,s6,4792 <sharedfd+0x15a>
                np++;
    47a4:	2a85                	addiw	s5,s5,1
    47a6:	b7f5                	j	4792 <sharedfd+0x15a>
    close(fd);
    47a8:	855e                	mv	a0,s7
    47aa:	00001097          	auipc	ra,0x1
    47ae:	152080e7          	jalr	338(ra) # 58fc <close>
    unlink("sharedfd");
    47b2:	00003517          	auipc	a0,0x3
    47b6:	25650513          	addi	a0,a0,598 # 7a08 <malloc+0x1d04>
    47ba:	00001097          	auipc	ra,0x1
    47be:	16a080e7          	jalr	362(ra) # 5924 <unlink>
    if (nc == N * SZ && np == N * SZ) {
    47c2:	6789                	lui	a5,0x2
    47c4:	71078793          	addi	a5,a5,1808 # 2710 <sbrkbasic+0x6a>
    47c8:	00f99763          	bne	s3,a5,47d6 <sharedfd+0x19e>
    47cc:	6789                	lui	a5,0x2
    47ce:	71078793          	addi	a5,a5,1808 # 2710 <sbrkbasic+0x6a>
    47d2:	02fa8063          	beq	s5,a5,47f2 <sharedfd+0x1ba>
        printf("%s: nc/np test fails\n", s);
    47d6:	85d2                	mv	a1,s4
    47d8:	00003517          	auipc	a0,0x3
    47dc:	2b050513          	addi	a0,a0,688 # 7a88 <malloc+0x1d84>
    47e0:	00001097          	auipc	ra,0x1
    47e4:	46c080e7          	jalr	1132(ra) # 5c4c <printf>
        exit(1);
    47e8:	4505                	li	a0,1
    47ea:	00001097          	auipc	ra,0x1
    47ee:	0ea080e7          	jalr	234(ra) # 58d4 <exit>
        exit(0);
    47f2:	4501                	li	a0,0
    47f4:	00001097          	auipc	ra,0x1
    47f8:	0e0080e7          	jalr	224(ra) # 58d4 <exit>

00000000000047fc <fourfiles>:
void fourfiles(char *s) {
    47fc:	7135                	addi	sp,sp,-160
    47fe:	ed06                	sd	ra,152(sp)
    4800:	e922                	sd	s0,144(sp)
    4802:	e526                	sd	s1,136(sp)
    4804:	e14a                	sd	s2,128(sp)
    4806:	fcce                	sd	s3,120(sp)
    4808:	f8d2                	sd	s4,112(sp)
    480a:	f4d6                	sd	s5,104(sp)
    480c:	f0da                	sd	s6,96(sp)
    480e:	ecde                	sd	s7,88(sp)
    4810:	e8e2                	sd	s8,80(sp)
    4812:	e4e6                	sd	s9,72(sp)
    4814:	e0ea                	sd	s10,64(sp)
    4816:	fc6e                	sd	s11,56(sp)
    4818:	1100                	addi	s0,sp,160
    481a:	8caa                	mv	s9,a0
    char *names[] = {"f0", "f1", "f2", "f3"};
    481c:	00003797          	auipc	a5,0x3
    4820:	28478793          	addi	a5,a5,644 # 7aa0 <malloc+0x1d9c>
    4824:	f6f43823          	sd	a5,-144(s0)
    4828:	00003797          	auipc	a5,0x3
    482c:	28078793          	addi	a5,a5,640 # 7aa8 <malloc+0x1da4>
    4830:	f6f43c23          	sd	a5,-136(s0)
    4834:	00003797          	auipc	a5,0x3
    4838:	27c78793          	addi	a5,a5,636 # 7ab0 <malloc+0x1dac>
    483c:	f8f43023          	sd	a5,-128(s0)
    4840:	00003797          	auipc	a5,0x3
    4844:	27878793          	addi	a5,a5,632 # 7ab8 <malloc+0x1db4>
    4848:	f8f43423          	sd	a5,-120(s0)
    for (pi = 0; pi < NCHILD; pi++) {
    484c:	f7040b93          	addi	s7,s0,-144
    char *names[] = {"f0", "f1", "f2", "f3"};
    4850:	895e                	mv	s2,s7
    for (pi = 0; pi < NCHILD; pi++) {
    4852:	4481                	li	s1,0
    4854:	4a11                	li	s4,4
        fname = names[pi];
    4856:	00093983          	ld	s3,0(s2)
        unlink(fname);
    485a:	854e                	mv	a0,s3
    485c:	00001097          	auipc	ra,0x1
    4860:	0c8080e7          	jalr	200(ra) # 5924 <unlink>
        pid = fork();
    4864:	00001097          	auipc	ra,0x1
    4868:	068080e7          	jalr	104(ra) # 58cc <fork>
        if (pid < 0) {
    486c:	04054063          	bltz	a0,48ac <fourfiles+0xb0>
        if (pid == 0) {
    4870:	cd21                	beqz	a0,48c8 <fourfiles+0xcc>
    for (pi = 0; pi < NCHILD; pi++) {
    4872:	2485                	addiw	s1,s1,1
    4874:	0921                	addi	s2,s2,8
    4876:	ff4490e3          	bne	s1,s4,4856 <fourfiles+0x5a>
    487a:	4491                	li	s1,4
        wait(&xstatus);
    487c:	f6c40513          	addi	a0,s0,-148
    4880:	00001097          	auipc	ra,0x1
    4884:	05c080e7          	jalr	92(ra) # 58dc <wait>
        if (xstatus != 0)
    4888:	f6c42a83          	lw	s5,-148(s0)
    488c:	0c0a9863          	bnez	s5,495c <fourfiles+0x160>
    for (pi = 0; pi < NCHILD; pi++) {
    4890:	34fd                	addiw	s1,s1,-1
    4892:	f4ed                	bnez	s1,487c <fourfiles+0x80>
    4894:	03000b13          	li	s6,48
        while ((n = read(fd, buf, sizeof(buf))) > 0) {
    4898:	00009a17          	auipc	s4,0x9
    489c:	848a0a13          	addi	s4,s4,-1976 # d0e0 <buf>
        if (total != N * SZ) {
    48a0:	6d05                	lui	s10,0x1
    48a2:	770d0d13          	addi	s10,s10,1904 # 1770 <pipe1+0x18>
    for (i = 0; i < NCHILD; i++) {
    48a6:	03400d93          	li	s11,52
    48aa:	a22d                	j	49d4 <fourfiles+0x1d8>
            printf("fork failed\n", s);
    48ac:	85e6                	mv	a1,s9
    48ae:	00002517          	auipc	a0,0x2
    48b2:	20a50513          	addi	a0,a0,522 # 6ab8 <malloc+0xdb4>
    48b6:	00001097          	auipc	ra,0x1
    48ba:	396080e7          	jalr	918(ra) # 5c4c <printf>
            exit(1);
    48be:	4505                	li	a0,1
    48c0:	00001097          	auipc	ra,0x1
    48c4:	014080e7          	jalr	20(ra) # 58d4 <exit>
            fd = open(fname, O_CREATE | O_RDWR);
    48c8:	20200593          	li	a1,514
    48cc:	854e                	mv	a0,s3
    48ce:	00001097          	auipc	ra,0x1
    48d2:	046080e7          	jalr	70(ra) # 5914 <open>
    48d6:	892a                	mv	s2,a0
            if (fd < 0) {
    48d8:	04054763          	bltz	a0,4926 <fourfiles+0x12a>
            memset(buf, '0' + pi, SZ);
    48dc:	1f400613          	li	a2,500
    48e0:	0304859b          	addiw	a1,s1,48
    48e4:	00008517          	auipc	a0,0x8
    48e8:	7fc50513          	addi	a0,a0,2044 # d0e0 <buf>
    48ec:	00001097          	auipc	ra,0x1
    48f0:	dee080e7          	jalr	-530(ra) # 56da <memset>
    48f4:	44b1                	li	s1,12
                if ((n = write(fd, buf, SZ)) != SZ) {
    48f6:	00008997          	auipc	s3,0x8
    48fa:	7ea98993          	addi	s3,s3,2026 # d0e0 <buf>
    48fe:	1f400613          	li	a2,500
    4902:	85ce                	mv	a1,s3
    4904:	854a                	mv	a0,s2
    4906:	00001097          	auipc	ra,0x1
    490a:	fee080e7          	jalr	-18(ra) # 58f4 <write>
    490e:	85aa                	mv	a1,a0
    4910:	1f400793          	li	a5,500
    4914:	02f51763          	bne	a0,a5,4942 <fourfiles+0x146>
            for (i = 0; i < N; i++) {
    4918:	34fd                	addiw	s1,s1,-1
    491a:	f0f5                	bnez	s1,48fe <fourfiles+0x102>
            exit(0);
    491c:	4501                	li	a0,0
    491e:	00001097          	auipc	ra,0x1
    4922:	fb6080e7          	jalr	-74(ra) # 58d4 <exit>
                printf("create failed\n", s);
    4926:	85e6                	mv	a1,s9
    4928:	00003517          	auipc	a0,0x3
    492c:	19850513          	addi	a0,a0,408 # 7ac0 <malloc+0x1dbc>
    4930:	00001097          	auipc	ra,0x1
    4934:	31c080e7          	jalr	796(ra) # 5c4c <printf>
                exit(1);
    4938:	4505                	li	a0,1
    493a:	00001097          	auipc	ra,0x1
    493e:	f9a080e7          	jalr	-102(ra) # 58d4 <exit>
                    printf("write failed %d\n", n);
    4942:	00003517          	auipc	a0,0x3
    4946:	18e50513          	addi	a0,a0,398 # 7ad0 <malloc+0x1dcc>
    494a:	00001097          	auipc	ra,0x1
    494e:	302080e7          	jalr	770(ra) # 5c4c <printf>
                    exit(1);
    4952:	4505                	li	a0,1
    4954:	00001097          	auipc	ra,0x1
    4958:	f80080e7          	jalr	-128(ra) # 58d4 <exit>
            exit(xstatus);
    495c:	8556                	mv	a0,s5
    495e:	00001097          	auipc	ra,0x1
    4962:	f76080e7          	jalr	-138(ra) # 58d4 <exit>
                    printf("wrong char\n", s);
    4966:	85e6                	mv	a1,s9
    4968:	00003517          	auipc	a0,0x3
    496c:	18050513          	addi	a0,a0,384 # 7ae8 <malloc+0x1de4>
    4970:	00001097          	auipc	ra,0x1
    4974:	2dc080e7          	jalr	732(ra) # 5c4c <printf>
                    exit(1);
    4978:	4505                	li	a0,1
    497a:	00001097          	auipc	ra,0x1
    497e:	f5a080e7          	jalr	-166(ra) # 58d4 <exit>
            total += n;
    4982:	00a9093b          	addw	s2,s2,a0
        while ((n = read(fd, buf, sizeof(buf))) > 0) {
    4986:	660d                	lui	a2,0x3
    4988:	85d2                	mv	a1,s4
    498a:	854e                	mv	a0,s3
    498c:	00001097          	auipc	ra,0x1
    4990:	f60080e7          	jalr	-160(ra) # 58ec <read>
    4994:	02a05063          	blez	a0,49b4 <fourfiles+0x1b8>
    4998:	00008797          	auipc	a5,0x8
    499c:	74878793          	addi	a5,a5,1864 # d0e0 <buf>
    49a0:	00f506b3          	add	a3,a0,a5
                if (buf[j] != '0' + i) {
    49a4:	0007c703          	lbu	a4,0(a5)
    49a8:	fa971fe3          	bne	a4,s1,4966 <fourfiles+0x16a>
            for (j = 0; j < n; j++) {
    49ac:	0785                	addi	a5,a5,1
    49ae:	fed79be3          	bne	a5,a3,49a4 <fourfiles+0x1a8>
    49b2:	bfc1                	j	4982 <fourfiles+0x186>
        close(fd);
    49b4:	854e                	mv	a0,s3
    49b6:	00001097          	auipc	ra,0x1
    49ba:	f46080e7          	jalr	-186(ra) # 58fc <close>
        if (total != N * SZ) {
    49be:	03a91863          	bne	s2,s10,49ee <fourfiles+0x1f2>
        unlink(fname);
    49c2:	8562                	mv	a0,s8
    49c4:	00001097          	auipc	ra,0x1
    49c8:	f60080e7          	jalr	-160(ra) # 5924 <unlink>
    for (i = 0; i < NCHILD; i++) {
    49cc:	0ba1                	addi	s7,s7,8
    49ce:	2b05                	addiw	s6,s6,1
    49d0:	03bb0d63          	beq	s6,s11,4a0a <fourfiles+0x20e>
        fname = names[i];
    49d4:	000bbc03          	ld	s8,0(s7)
        fd = open(fname, 0);
    49d8:	4581                	li	a1,0
    49da:	8562                	mv	a0,s8
    49dc:	00001097          	auipc	ra,0x1
    49e0:	f38080e7          	jalr	-200(ra) # 5914 <open>
    49e4:	89aa                	mv	s3,a0
        total = 0;
    49e6:	8956                	mv	s2,s5
                if (buf[j] != '0' + i) {
    49e8:	000b049b          	sext.w	s1,s6
        while ((n = read(fd, buf, sizeof(buf))) > 0) {
    49ec:	bf69                	j	4986 <fourfiles+0x18a>
            printf("wrong length %d\n", total);
    49ee:	85ca                	mv	a1,s2
    49f0:	00003517          	auipc	a0,0x3
    49f4:	10850513          	addi	a0,a0,264 # 7af8 <malloc+0x1df4>
    49f8:	00001097          	auipc	ra,0x1
    49fc:	254080e7          	jalr	596(ra) # 5c4c <printf>
            exit(1);
    4a00:	4505                	li	a0,1
    4a02:	00001097          	auipc	ra,0x1
    4a06:	ed2080e7          	jalr	-302(ra) # 58d4 <exit>
}
    4a0a:	60ea                	ld	ra,152(sp)
    4a0c:	644a                	ld	s0,144(sp)
    4a0e:	64aa                	ld	s1,136(sp)
    4a10:	690a                	ld	s2,128(sp)
    4a12:	79e6                	ld	s3,120(sp)
    4a14:	7a46                	ld	s4,112(sp)
    4a16:	7aa6                	ld	s5,104(sp)
    4a18:	7b06                	ld	s6,96(sp)
    4a1a:	6be6                	ld	s7,88(sp)
    4a1c:	6c46                	ld	s8,80(sp)
    4a1e:	6ca6                	ld	s9,72(sp)
    4a20:	6d06                	ld	s10,64(sp)
    4a22:	7de2                	ld	s11,56(sp)
    4a24:	610d                	addi	sp,sp,160
    4a26:	8082                	ret

0000000000004a28 <concreate>:
void concreate(char *s) {
    4a28:	7135                	addi	sp,sp,-160
    4a2a:	ed06                	sd	ra,152(sp)
    4a2c:	e922                	sd	s0,144(sp)
    4a2e:	e526                	sd	s1,136(sp)
    4a30:	e14a                	sd	s2,128(sp)
    4a32:	fcce                	sd	s3,120(sp)
    4a34:	f8d2                	sd	s4,112(sp)
    4a36:	f4d6                	sd	s5,104(sp)
    4a38:	f0da                	sd	s6,96(sp)
    4a3a:	ecde                	sd	s7,88(sp)
    4a3c:	1100                	addi	s0,sp,160
    4a3e:	89aa                	mv	s3,a0
    file[0] = 'C';
    4a40:	04300793          	li	a5,67
    4a44:	faf40423          	sb	a5,-88(s0)
    file[2] = '\0';
    4a48:	fa040523          	sb	zero,-86(s0)
    for (i = 0; i < N; i++) {
    4a4c:	4901                	li	s2,0
        if (pid && (i % 3) == 1) {
    4a4e:	4b0d                	li	s6,3
    4a50:	4a85                	li	s5,1
            link("C0", file);
    4a52:	00003b97          	auipc	s7,0x3
    4a56:	0beb8b93          	addi	s7,s7,190 # 7b10 <malloc+0x1e0c>
    for (i = 0; i < N; i++) {
    4a5a:	02800a13          	li	s4,40
    4a5e:	acc9                	j	4d30 <concreate+0x308>
            link("C0", file);
    4a60:	fa840593          	addi	a1,s0,-88
    4a64:	855e                	mv	a0,s7
    4a66:	00001097          	auipc	ra,0x1
    4a6a:	ece080e7          	jalr	-306(ra) # 5934 <link>
        if (pid == 0) {
    4a6e:	a465                	j	4d16 <concreate+0x2ee>
        } else if (pid == 0 && (i % 5) == 1) {
    4a70:	4795                	li	a5,5
    4a72:	02f9693b          	remw	s2,s2,a5
    4a76:	4785                	li	a5,1
    4a78:	02f90b63          	beq	s2,a5,4aae <concreate+0x86>
            fd = open(file, O_CREATE | O_RDWR);
    4a7c:	20200593          	li	a1,514
    4a80:	fa840513          	addi	a0,s0,-88
    4a84:	00001097          	auipc	ra,0x1
    4a88:	e90080e7          	jalr	-368(ra) # 5914 <open>
            if (fd < 0) {
    4a8c:	26055c63          	bgez	a0,4d04 <concreate+0x2dc>
                printf("concreate create %s failed\n", file);
    4a90:	fa840593          	addi	a1,s0,-88
    4a94:	00003517          	auipc	a0,0x3
    4a98:	08450513          	addi	a0,a0,132 # 7b18 <malloc+0x1e14>
    4a9c:	00001097          	auipc	ra,0x1
    4aa0:	1b0080e7          	jalr	432(ra) # 5c4c <printf>
                exit(1);
    4aa4:	4505                	li	a0,1
    4aa6:	00001097          	auipc	ra,0x1
    4aaa:	e2e080e7          	jalr	-466(ra) # 58d4 <exit>
            link("C0", file);
    4aae:	fa840593          	addi	a1,s0,-88
    4ab2:	00003517          	auipc	a0,0x3
    4ab6:	05e50513          	addi	a0,a0,94 # 7b10 <malloc+0x1e0c>
    4aba:	00001097          	auipc	ra,0x1
    4abe:	e7a080e7          	jalr	-390(ra) # 5934 <link>
            exit(0);
    4ac2:	4501                	li	a0,0
    4ac4:	00001097          	auipc	ra,0x1
    4ac8:	e10080e7          	jalr	-496(ra) # 58d4 <exit>
                exit(1);
    4acc:	4505                	li	a0,1
    4ace:	00001097          	auipc	ra,0x1
    4ad2:	e06080e7          	jalr	-506(ra) # 58d4 <exit>
    memset(fa, 0, sizeof(fa));
    4ad6:	02800613          	li	a2,40
    4ada:	4581                	li	a1,0
    4adc:	f8040513          	addi	a0,s0,-128
    4ae0:	00001097          	auipc	ra,0x1
    4ae4:	bfa080e7          	jalr	-1030(ra) # 56da <memset>
    fd = open(".", 0);
    4ae8:	4581                	li	a1,0
    4aea:	00002517          	auipc	a0,0x2
    4aee:	a0e50513          	addi	a0,a0,-1522 # 64f8 <malloc+0x7f4>
    4af2:	00001097          	auipc	ra,0x1
    4af6:	e22080e7          	jalr	-478(ra) # 5914 <open>
    4afa:	892a                	mv	s2,a0
    n = 0;
    4afc:	8aa6                	mv	s5,s1
        if (de.name[0] == 'C' && de.name[2] == '\0') {
    4afe:	04300a13          	li	s4,67
            if (i < 0 || i >= sizeof(fa)) {
    4b02:	02700b13          	li	s6,39
            fa[i] = 1;
    4b06:	4b85                	li	s7,1
    while (read(fd, &de, sizeof(de)) > 0) {
    4b08:	4641                	li	a2,16
    4b0a:	f7040593          	addi	a1,s0,-144
    4b0e:	854a                	mv	a0,s2
    4b10:	00001097          	auipc	ra,0x1
    4b14:	ddc080e7          	jalr	-548(ra) # 58ec <read>
    4b18:	08a05263          	blez	a0,4b9c <concreate+0x174>
        if (de.inum == 0)
    4b1c:	f7045783          	lhu	a5,-144(s0)
    4b20:	d7e5                	beqz	a5,4b08 <concreate+0xe0>
        if (de.name[0] == 'C' && de.name[2] == '\0') {
    4b22:	f7244783          	lbu	a5,-142(s0)
    4b26:	ff4791e3          	bne	a5,s4,4b08 <concreate+0xe0>
    4b2a:	f7444783          	lbu	a5,-140(s0)
    4b2e:	ffe9                	bnez	a5,4b08 <concreate+0xe0>
            i = de.name[1] - '0';
    4b30:	f7344783          	lbu	a5,-141(s0)
    4b34:	fd07879b          	addiw	a5,a5,-48
    4b38:	0007871b          	sext.w	a4,a5
            if (i < 0 || i >= sizeof(fa)) {
    4b3c:	02eb6063          	bltu	s6,a4,4b5c <concreate+0x134>
            if (fa[i]) {
    4b40:	fb070793          	addi	a5,a4,-80 # fb0 <bigdir+0x50>
    4b44:	97a2                	add	a5,a5,s0
    4b46:	fd07c783          	lbu	a5,-48(a5)
    4b4a:	eb8d                	bnez	a5,4b7c <concreate+0x154>
            fa[i] = 1;
    4b4c:	fb070793          	addi	a5,a4,-80
    4b50:	00878733          	add	a4,a5,s0
    4b54:	fd770823          	sb	s7,-48(a4)
            n++;
    4b58:	2a85                	addiw	s5,s5,1
    4b5a:	b77d                	j	4b08 <concreate+0xe0>
                printf("%s: concreate weird file %s\n", s, de.name);
    4b5c:	f7240613          	addi	a2,s0,-142
    4b60:	85ce                	mv	a1,s3
    4b62:	00003517          	auipc	a0,0x3
    4b66:	fd650513          	addi	a0,a0,-42 # 7b38 <malloc+0x1e34>
    4b6a:	00001097          	auipc	ra,0x1
    4b6e:	0e2080e7          	jalr	226(ra) # 5c4c <printf>
                exit(1);
    4b72:	4505                	li	a0,1
    4b74:	00001097          	auipc	ra,0x1
    4b78:	d60080e7          	jalr	-672(ra) # 58d4 <exit>
                printf("%s: concreate duplicate file %s\n", s, de.name);
    4b7c:	f7240613          	addi	a2,s0,-142
    4b80:	85ce                	mv	a1,s3
    4b82:	00003517          	auipc	a0,0x3
    4b86:	fd650513          	addi	a0,a0,-42 # 7b58 <malloc+0x1e54>
    4b8a:	00001097          	auipc	ra,0x1
    4b8e:	0c2080e7          	jalr	194(ra) # 5c4c <printf>
                exit(1);
    4b92:	4505                	li	a0,1
    4b94:	00001097          	auipc	ra,0x1
    4b98:	d40080e7          	jalr	-704(ra) # 58d4 <exit>
    close(fd);
    4b9c:	854a                	mv	a0,s2
    4b9e:	00001097          	auipc	ra,0x1
    4ba2:	d5e080e7          	jalr	-674(ra) # 58fc <close>
    if (n != N) {
    4ba6:	02800793          	li	a5,40
    4baa:	00fa9763          	bne	s5,a5,4bb8 <concreate+0x190>
        if (((i % 3) == 0 && pid == 0) || ((i % 3) == 1 && pid != 0)) {
    4bae:	4a8d                	li	s5,3
    4bb0:	4b05                	li	s6,1
    for (i = 0; i < N; i++) {
    4bb2:	02800a13          	li	s4,40
    4bb6:	a8c9                	j	4c88 <concreate+0x260>
        printf("%s: concreate not enough files in directory listing\n", s);
    4bb8:	85ce                	mv	a1,s3
    4bba:	00003517          	auipc	a0,0x3
    4bbe:	fc650513          	addi	a0,a0,-58 # 7b80 <malloc+0x1e7c>
    4bc2:	00001097          	auipc	ra,0x1
    4bc6:	08a080e7          	jalr	138(ra) # 5c4c <printf>
        exit(1);
    4bca:	4505                	li	a0,1
    4bcc:	00001097          	auipc	ra,0x1
    4bd0:	d08080e7          	jalr	-760(ra) # 58d4 <exit>
            printf("%s: fork failed\n", s);
    4bd4:	85ce                	mv	a1,s3
    4bd6:	00002517          	auipc	a0,0x2
    4bda:	ac250513          	addi	a0,a0,-1342 # 6698 <malloc+0x994>
    4bde:	00001097          	auipc	ra,0x1
    4be2:	06e080e7          	jalr	110(ra) # 5c4c <printf>
            exit(1);
    4be6:	4505                	li	a0,1
    4be8:	00001097          	auipc	ra,0x1
    4bec:	cec080e7          	jalr	-788(ra) # 58d4 <exit>
            close(open(file, 0));
    4bf0:	4581                	li	a1,0
    4bf2:	fa840513          	addi	a0,s0,-88
    4bf6:	00001097          	auipc	ra,0x1
    4bfa:	d1e080e7          	jalr	-738(ra) # 5914 <open>
    4bfe:	00001097          	auipc	ra,0x1
    4c02:	cfe080e7          	jalr	-770(ra) # 58fc <close>
            close(open(file, 0));
    4c06:	4581                	li	a1,0
    4c08:	fa840513          	addi	a0,s0,-88
    4c0c:	00001097          	auipc	ra,0x1
    4c10:	d08080e7          	jalr	-760(ra) # 5914 <open>
    4c14:	00001097          	auipc	ra,0x1
    4c18:	ce8080e7          	jalr	-792(ra) # 58fc <close>
            close(open(file, 0));
    4c1c:	4581                	li	a1,0
    4c1e:	fa840513          	addi	a0,s0,-88
    4c22:	00001097          	auipc	ra,0x1
    4c26:	cf2080e7          	jalr	-782(ra) # 5914 <open>
    4c2a:	00001097          	auipc	ra,0x1
    4c2e:	cd2080e7          	jalr	-814(ra) # 58fc <close>
            close(open(file, 0));
    4c32:	4581                	li	a1,0
    4c34:	fa840513          	addi	a0,s0,-88
    4c38:	00001097          	auipc	ra,0x1
    4c3c:	cdc080e7          	jalr	-804(ra) # 5914 <open>
    4c40:	00001097          	auipc	ra,0x1
    4c44:	cbc080e7          	jalr	-836(ra) # 58fc <close>
            close(open(file, 0));
    4c48:	4581                	li	a1,0
    4c4a:	fa840513          	addi	a0,s0,-88
    4c4e:	00001097          	auipc	ra,0x1
    4c52:	cc6080e7          	jalr	-826(ra) # 5914 <open>
    4c56:	00001097          	auipc	ra,0x1
    4c5a:	ca6080e7          	jalr	-858(ra) # 58fc <close>
            close(open(file, 0));
    4c5e:	4581                	li	a1,0
    4c60:	fa840513          	addi	a0,s0,-88
    4c64:	00001097          	auipc	ra,0x1
    4c68:	cb0080e7          	jalr	-848(ra) # 5914 <open>
    4c6c:	00001097          	auipc	ra,0x1
    4c70:	c90080e7          	jalr	-880(ra) # 58fc <close>
        if (pid == 0)
    4c74:	08090363          	beqz	s2,4cfa <concreate+0x2d2>
            wait(0);
    4c78:	4501                	li	a0,0
    4c7a:	00001097          	auipc	ra,0x1
    4c7e:	c62080e7          	jalr	-926(ra) # 58dc <wait>
    for (i = 0; i < N; i++) {
    4c82:	2485                	addiw	s1,s1,1
    4c84:	0f448563          	beq	s1,s4,4d6e <concreate+0x346>
        file[1] = '0' + i;
    4c88:	0304879b          	addiw	a5,s1,48
    4c8c:	faf404a3          	sb	a5,-87(s0)
        pid = fork();
    4c90:	00001097          	auipc	ra,0x1
    4c94:	c3c080e7          	jalr	-964(ra) # 58cc <fork>
    4c98:	892a                	mv	s2,a0
        if (pid < 0) {
    4c9a:	f2054de3          	bltz	a0,4bd4 <concreate+0x1ac>
        if (((i % 3) == 0 && pid == 0) || ((i % 3) == 1 && pid != 0)) {
    4c9e:	0354e73b          	remw	a4,s1,s5
    4ca2:	00a767b3          	or	a5,a4,a0
    4ca6:	2781                	sext.w	a5,a5
    4ca8:	d7a1                	beqz	a5,4bf0 <concreate+0x1c8>
    4caa:	01671363          	bne	a4,s6,4cb0 <concreate+0x288>
    4cae:	f129                	bnez	a0,4bf0 <concreate+0x1c8>
            unlink(file);
    4cb0:	fa840513          	addi	a0,s0,-88
    4cb4:	00001097          	auipc	ra,0x1
    4cb8:	c70080e7          	jalr	-912(ra) # 5924 <unlink>
            unlink(file);
    4cbc:	fa840513          	addi	a0,s0,-88
    4cc0:	00001097          	auipc	ra,0x1
    4cc4:	c64080e7          	jalr	-924(ra) # 5924 <unlink>
            unlink(file);
    4cc8:	fa840513          	addi	a0,s0,-88
    4ccc:	00001097          	auipc	ra,0x1
    4cd0:	c58080e7          	jalr	-936(ra) # 5924 <unlink>
            unlink(file);
    4cd4:	fa840513          	addi	a0,s0,-88
    4cd8:	00001097          	auipc	ra,0x1
    4cdc:	c4c080e7          	jalr	-948(ra) # 5924 <unlink>
            unlink(file);
    4ce0:	fa840513          	addi	a0,s0,-88
    4ce4:	00001097          	auipc	ra,0x1
    4ce8:	c40080e7          	jalr	-960(ra) # 5924 <unlink>
            unlink(file);
    4cec:	fa840513          	addi	a0,s0,-88
    4cf0:	00001097          	auipc	ra,0x1
    4cf4:	c34080e7          	jalr	-972(ra) # 5924 <unlink>
    4cf8:	bfb5                	j	4c74 <concreate+0x24c>
            exit(0);
    4cfa:	4501                	li	a0,0
    4cfc:	00001097          	auipc	ra,0x1
    4d00:	bd8080e7          	jalr	-1064(ra) # 58d4 <exit>
            close(fd);
    4d04:	00001097          	auipc	ra,0x1
    4d08:	bf8080e7          	jalr	-1032(ra) # 58fc <close>
        if (pid == 0) {
    4d0c:	bb5d                	j	4ac2 <concreate+0x9a>
            close(fd);
    4d0e:	00001097          	auipc	ra,0x1
    4d12:	bee080e7          	jalr	-1042(ra) # 58fc <close>
            wait(&xstatus);
    4d16:	f6c40513          	addi	a0,s0,-148
    4d1a:	00001097          	auipc	ra,0x1
    4d1e:	bc2080e7          	jalr	-1086(ra) # 58dc <wait>
            if (xstatus != 0)
    4d22:	f6c42483          	lw	s1,-148(s0)
    4d26:	da0493e3          	bnez	s1,4acc <concreate+0xa4>
    for (i = 0; i < N; i++) {
    4d2a:	2905                	addiw	s2,s2,1
    4d2c:	db4905e3          	beq	s2,s4,4ad6 <concreate+0xae>
        file[1] = '0' + i;
    4d30:	0309079b          	addiw	a5,s2,48
    4d34:	faf404a3          	sb	a5,-87(s0)
        unlink(file);
    4d38:	fa840513          	addi	a0,s0,-88
    4d3c:	00001097          	auipc	ra,0x1
    4d40:	be8080e7          	jalr	-1048(ra) # 5924 <unlink>
        pid = fork();
    4d44:	00001097          	auipc	ra,0x1
    4d48:	b88080e7          	jalr	-1144(ra) # 58cc <fork>
        if (pid && (i % 3) == 1) {
    4d4c:	d20502e3          	beqz	a0,4a70 <concreate+0x48>
    4d50:	036967bb          	remw	a5,s2,s6
    4d54:	d15786e3          	beq	a5,s5,4a60 <concreate+0x38>
            fd = open(file, O_CREATE | O_RDWR);
    4d58:	20200593          	li	a1,514
    4d5c:	fa840513          	addi	a0,s0,-88
    4d60:	00001097          	auipc	ra,0x1
    4d64:	bb4080e7          	jalr	-1100(ra) # 5914 <open>
            if (fd < 0) {
    4d68:	fa0553e3          	bgez	a0,4d0e <concreate+0x2e6>
    4d6c:	b315                	j	4a90 <concreate+0x68>
}
    4d6e:	60ea                	ld	ra,152(sp)
    4d70:	644a                	ld	s0,144(sp)
    4d72:	64aa                	ld	s1,136(sp)
    4d74:	690a                	ld	s2,128(sp)
    4d76:	79e6                	ld	s3,120(sp)
    4d78:	7a46                	ld	s4,112(sp)
    4d7a:	7aa6                	ld	s5,104(sp)
    4d7c:	7b06                	ld	s6,96(sp)
    4d7e:	6be6                	ld	s7,88(sp)
    4d80:	610d                	addi	sp,sp,160
    4d82:	8082                	ret

0000000000004d84 <bigfile>:
void bigfile(char *s) {
    4d84:	7139                	addi	sp,sp,-64
    4d86:	fc06                	sd	ra,56(sp)
    4d88:	f822                	sd	s0,48(sp)
    4d8a:	f426                	sd	s1,40(sp)
    4d8c:	f04a                	sd	s2,32(sp)
    4d8e:	ec4e                	sd	s3,24(sp)
    4d90:	e852                	sd	s4,16(sp)
    4d92:	e456                	sd	s5,8(sp)
    4d94:	0080                	addi	s0,sp,64
    4d96:	8aaa                	mv	s5,a0
    unlink("bigfile.dat");
    4d98:	00003517          	auipc	a0,0x3
    4d9c:	e2050513          	addi	a0,a0,-480 # 7bb8 <malloc+0x1eb4>
    4da0:	00001097          	auipc	ra,0x1
    4da4:	b84080e7          	jalr	-1148(ra) # 5924 <unlink>
    fd = open("bigfile.dat", O_CREATE | O_RDWR);
    4da8:	20200593          	li	a1,514
    4dac:	00003517          	auipc	a0,0x3
    4db0:	e0c50513          	addi	a0,a0,-500 # 7bb8 <malloc+0x1eb4>
    4db4:	00001097          	auipc	ra,0x1
    4db8:	b60080e7          	jalr	-1184(ra) # 5914 <open>
    4dbc:	89aa                	mv	s3,a0
    for (i = 0; i < N; i++) {
    4dbe:	4481                	li	s1,0
        memset(buf, i, SZ);
    4dc0:	00008917          	auipc	s2,0x8
    4dc4:	32090913          	addi	s2,s2,800 # d0e0 <buf>
    for (i = 0; i < N; i++) {
    4dc8:	4a51                	li	s4,20
    if (fd < 0) {
    4dca:	0a054063          	bltz	a0,4e6a <bigfile+0xe6>
        memset(buf, i, SZ);
    4dce:	25800613          	li	a2,600
    4dd2:	85a6                	mv	a1,s1
    4dd4:	854a                	mv	a0,s2
    4dd6:	00001097          	auipc	ra,0x1
    4dda:	904080e7          	jalr	-1788(ra) # 56da <memset>
        if (write(fd, buf, SZ) != SZ) {
    4dde:	25800613          	li	a2,600
    4de2:	85ca                	mv	a1,s2
    4de4:	854e                	mv	a0,s3
    4de6:	00001097          	auipc	ra,0x1
    4dea:	b0e080e7          	jalr	-1266(ra) # 58f4 <write>
    4dee:	25800793          	li	a5,600
    4df2:	08f51a63          	bne	a0,a5,4e86 <bigfile+0x102>
    for (i = 0; i < N; i++) {
    4df6:	2485                	addiw	s1,s1,1
    4df8:	fd449be3          	bne	s1,s4,4dce <bigfile+0x4a>
    close(fd);
    4dfc:	854e                	mv	a0,s3
    4dfe:	00001097          	auipc	ra,0x1
    4e02:	afe080e7          	jalr	-1282(ra) # 58fc <close>
    fd = open("bigfile.dat", 0);
    4e06:	4581                	li	a1,0
    4e08:	00003517          	auipc	a0,0x3
    4e0c:	db050513          	addi	a0,a0,-592 # 7bb8 <malloc+0x1eb4>
    4e10:	00001097          	auipc	ra,0x1
    4e14:	b04080e7          	jalr	-1276(ra) # 5914 <open>
    4e18:	8a2a                	mv	s4,a0
    total = 0;
    4e1a:	4981                	li	s3,0
    for (i = 0;; i++) {
    4e1c:	4481                	li	s1,0
        cc = read(fd, buf, SZ / 2);
    4e1e:	00008917          	auipc	s2,0x8
    4e22:	2c290913          	addi	s2,s2,706 # d0e0 <buf>
    if (fd < 0) {
    4e26:	06054e63          	bltz	a0,4ea2 <bigfile+0x11e>
        cc = read(fd, buf, SZ / 2);
    4e2a:	12c00613          	li	a2,300
    4e2e:	85ca                	mv	a1,s2
    4e30:	8552                	mv	a0,s4
    4e32:	00001097          	auipc	ra,0x1
    4e36:	aba080e7          	jalr	-1350(ra) # 58ec <read>
        if (cc < 0) {
    4e3a:	08054263          	bltz	a0,4ebe <bigfile+0x13a>
        if (cc == 0)
    4e3e:	c971                	beqz	a0,4f12 <bigfile+0x18e>
        if (cc != SZ / 2) {
    4e40:	12c00793          	li	a5,300
    4e44:	08f51b63          	bne	a0,a5,4eda <bigfile+0x156>
        if (buf[0] != i / 2 || buf[SZ / 2 - 1] != i / 2) {
    4e48:	01f4d79b          	srliw	a5,s1,0x1f
    4e4c:	9fa5                	addw	a5,a5,s1
    4e4e:	4017d79b          	sraiw	a5,a5,0x1
    4e52:	00094703          	lbu	a4,0(s2)
    4e56:	0af71063          	bne	a4,a5,4ef6 <bigfile+0x172>
    4e5a:	12b94703          	lbu	a4,299(s2)
    4e5e:	08f71c63          	bne	a4,a5,4ef6 <bigfile+0x172>
        total += cc;
    4e62:	12c9899b          	addiw	s3,s3,300
    for (i = 0;; i++) {
    4e66:	2485                	addiw	s1,s1,1
        cc = read(fd, buf, SZ / 2);
    4e68:	b7c9                	j	4e2a <bigfile+0xa6>
        printf("%s: cannot create bigfile", s);
    4e6a:	85d6                	mv	a1,s5
    4e6c:	00003517          	auipc	a0,0x3
    4e70:	d5c50513          	addi	a0,a0,-676 # 7bc8 <malloc+0x1ec4>
    4e74:	00001097          	auipc	ra,0x1
    4e78:	dd8080e7          	jalr	-552(ra) # 5c4c <printf>
        exit(1);
    4e7c:	4505                	li	a0,1
    4e7e:	00001097          	auipc	ra,0x1
    4e82:	a56080e7          	jalr	-1450(ra) # 58d4 <exit>
            printf("%s: write bigfile failed\n", s);
    4e86:	85d6                	mv	a1,s5
    4e88:	00003517          	auipc	a0,0x3
    4e8c:	d6050513          	addi	a0,a0,-672 # 7be8 <malloc+0x1ee4>
    4e90:	00001097          	auipc	ra,0x1
    4e94:	dbc080e7          	jalr	-580(ra) # 5c4c <printf>
            exit(1);
    4e98:	4505                	li	a0,1
    4e9a:	00001097          	auipc	ra,0x1
    4e9e:	a3a080e7          	jalr	-1478(ra) # 58d4 <exit>
        printf("%s: cannot open bigfile\n", s);
    4ea2:	85d6                	mv	a1,s5
    4ea4:	00003517          	auipc	a0,0x3
    4ea8:	d6450513          	addi	a0,a0,-668 # 7c08 <malloc+0x1f04>
    4eac:	00001097          	auipc	ra,0x1
    4eb0:	da0080e7          	jalr	-608(ra) # 5c4c <printf>
        exit(1);
    4eb4:	4505                	li	a0,1
    4eb6:	00001097          	auipc	ra,0x1
    4eba:	a1e080e7          	jalr	-1506(ra) # 58d4 <exit>
            printf("%s: read bigfile failed\n", s);
    4ebe:	85d6                	mv	a1,s5
    4ec0:	00003517          	auipc	a0,0x3
    4ec4:	d6850513          	addi	a0,a0,-664 # 7c28 <malloc+0x1f24>
    4ec8:	00001097          	auipc	ra,0x1
    4ecc:	d84080e7          	jalr	-636(ra) # 5c4c <printf>
            exit(1);
    4ed0:	4505                	li	a0,1
    4ed2:	00001097          	auipc	ra,0x1
    4ed6:	a02080e7          	jalr	-1534(ra) # 58d4 <exit>
            printf("%s: short read bigfile\n", s);
    4eda:	85d6                	mv	a1,s5
    4edc:	00003517          	auipc	a0,0x3
    4ee0:	d6c50513          	addi	a0,a0,-660 # 7c48 <malloc+0x1f44>
    4ee4:	00001097          	auipc	ra,0x1
    4ee8:	d68080e7          	jalr	-664(ra) # 5c4c <printf>
            exit(1);
    4eec:	4505                	li	a0,1
    4eee:	00001097          	auipc	ra,0x1
    4ef2:	9e6080e7          	jalr	-1562(ra) # 58d4 <exit>
            printf("%s: read bigfile wrong data\n", s);
    4ef6:	85d6                	mv	a1,s5
    4ef8:	00003517          	auipc	a0,0x3
    4efc:	d6850513          	addi	a0,a0,-664 # 7c60 <malloc+0x1f5c>
    4f00:	00001097          	auipc	ra,0x1
    4f04:	d4c080e7          	jalr	-692(ra) # 5c4c <printf>
            exit(1);
    4f08:	4505                	li	a0,1
    4f0a:	00001097          	auipc	ra,0x1
    4f0e:	9ca080e7          	jalr	-1590(ra) # 58d4 <exit>
    close(fd);
    4f12:	8552                	mv	a0,s4
    4f14:	00001097          	auipc	ra,0x1
    4f18:	9e8080e7          	jalr	-1560(ra) # 58fc <close>
    if (total != N * SZ) {
    4f1c:	678d                	lui	a5,0x3
    4f1e:	ee078793          	addi	a5,a5,-288 # 2ee0 <fourteen+0xb2>
    4f22:	02f99363          	bne	s3,a5,4f48 <bigfile+0x1c4>
    unlink("bigfile.dat");
    4f26:	00003517          	auipc	a0,0x3
    4f2a:	c9250513          	addi	a0,a0,-878 # 7bb8 <malloc+0x1eb4>
    4f2e:	00001097          	auipc	ra,0x1
    4f32:	9f6080e7          	jalr	-1546(ra) # 5924 <unlink>
}
    4f36:	70e2                	ld	ra,56(sp)
    4f38:	7442                	ld	s0,48(sp)
    4f3a:	74a2                	ld	s1,40(sp)
    4f3c:	7902                	ld	s2,32(sp)
    4f3e:	69e2                	ld	s3,24(sp)
    4f40:	6a42                	ld	s4,16(sp)
    4f42:	6aa2                	ld	s5,8(sp)
    4f44:	6121                	addi	sp,sp,64
    4f46:	8082                	ret
        printf("%s: read bigfile wrong total\n", s);
    4f48:	85d6                	mv	a1,s5
    4f4a:	00003517          	auipc	a0,0x3
    4f4e:	d3650513          	addi	a0,a0,-714 # 7c80 <malloc+0x1f7c>
    4f52:	00001097          	auipc	ra,0x1
    4f56:	cfa080e7          	jalr	-774(ra) # 5c4c <printf>
        exit(1);
    4f5a:	4505                	li	a0,1
    4f5c:	00001097          	auipc	ra,0x1
    4f60:	978080e7          	jalr	-1672(ra) # 58d4 <exit>

0000000000004f64 <fsfull>:
void fsfull() {
    4f64:	7135                	addi	sp,sp,-160
    4f66:	ed06                	sd	ra,152(sp)
    4f68:	e922                	sd	s0,144(sp)
    4f6a:	e526                	sd	s1,136(sp)
    4f6c:	e14a                	sd	s2,128(sp)
    4f6e:	fcce                	sd	s3,120(sp)
    4f70:	f8d2                	sd	s4,112(sp)
    4f72:	f4d6                	sd	s5,104(sp)
    4f74:	f0da                	sd	s6,96(sp)
    4f76:	ecde                	sd	s7,88(sp)
    4f78:	e8e2                	sd	s8,80(sp)
    4f7a:	e4e6                	sd	s9,72(sp)
    4f7c:	e0ea                	sd	s10,64(sp)
    4f7e:	1100                	addi	s0,sp,160
    printf("fsfull test\n");
    4f80:	00003517          	auipc	a0,0x3
    4f84:	d2050513          	addi	a0,a0,-736 # 7ca0 <malloc+0x1f9c>
    4f88:	00001097          	auipc	ra,0x1
    4f8c:	cc4080e7          	jalr	-828(ra) # 5c4c <printf>
    for (nfiles = 0;; nfiles++) {
    4f90:	4481                	li	s1,0
        name[0] = 'f';
    4f92:	06600d13          	li	s10,102
        name[1] = '0' + nfiles / 1000;
    4f96:	3e800c13          	li	s8,1000
        name[2] = '0' + (nfiles % 1000) / 100;
    4f9a:	06400b93          	li	s7,100
        name[3] = '0' + (nfiles % 100) / 10;
    4f9e:	4b29                	li	s6,10
        printf("writing %s\n", name);
    4fa0:	00003c97          	auipc	s9,0x3
    4fa4:	d10c8c93          	addi	s9,s9,-752 # 7cb0 <malloc+0x1fac>
        name[0] = 'f';
    4fa8:	f7a40023          	sb	s10,-160(s0)
        name[1] = '0' + nfiles / 1000;
    4fac:	0384c7bb          	divw	a5,s1,s8
    4fb0:	0307879b          	addiw	a5,a5,48
    4fb4:	f6f400a3          	sb	a5,-159(s0)
        name[2] = '0' + (nfiles % 1000) / 100;
    4fb8:	0384e7bb          	remw	a5,s1,s8
    4fbc:	0377c7bb          	divw	a5,a5,s7
    4fc0:	0307879b          	addiw	a5,a5,48
    4fc4:	f6f40123          	sb	a5,-158(s0)
        name[3] = '0' + (nfiles % 100) / 10;
    4fc8:	0374e7bb          	remw	a5,s1,s7
    4fcc:	0367c7bb          	divw	a5,a5,s6
    4fd0:	0307879b          	addiw	a5,a5,48
    4fd4:	f6f401a3          	sb	a5,-157(s0)
        name[4] = '0' + (nfiles % 10);
    4fd8:	0364e7bb          	remw	a5,s1,s6
    4fdc:	0307879b          	addiw	a5,a5,48
    4fe0:	f6f40223          	sb	a5,-156(s0)
        name[5] = '\0';
    4fe4:	f60402a3          	sb	zero,-155(s0)
        printf("writing %s\n", name);
    4fe8:	f6040593          	addi	a1,s0,-160
    4fec:	8566                	mv	a0,s9
    4fee:	00001097          	auipc	ra,0x1
    4ff2:	c5e080e7          	jalr	-930(ra) # 5c4c <printf>
        int fd = open(name, O_CREATE | O_RDWR);
    4ff6:	20200593          	li	a1,514
    4ffa:	f6040513          	addi	a0,s0,-160
    4ffe:	00001097          	auipc	ra,0x1
    5002:	916080e7          	jalr	-1770(ra) # 5914 <open>
    5006:	892a                	mv	s2,a0
        if (fd < 0) {
    5008:	0a055563          	bgez	a0,50b2 <fsfull+0x14e>
            printf("open %s failed\n", name);
    500c:	f6040593          	addi	a1,s0,-160
    5010:	00003517          	auipc	a0,0x3
    5014:	cb050513          	addi	a0,a0,-848 # 7cc0 <malloc+0x1fbc>
    5018:	00001097          	auipc	ra,0x1
    501c:	c34080e7          	jalr	-972(ra) # 5c4c <printf>
    while (nfiles >= 0) {
    5020:	0604c363          	bltz	s1,5086 <fsfull+0x122>
        name[0] = 'f';
    5024:	06600b13          	li	s6,102
        name[1] = '0' + nfiles / 1000;
    5028:	3e800a13          	li	s4,1000
        name[2] = '0' + (nfiles % 1000) / 100;
    502c:	06400993          	li	s3,100
        name[3] = '0' + (nfiles % 100) / 10;
    5030:	4929                	li	s2,10
    while (nfiles >= 0) {
    5032:	5afd                	li	s5,-1
        name[0] = 'f';
    5034:	f7640023          	sb	s6,-160(s0)
        name[1] = '0' + nfiles / 1000;
    5038:	0344c7bb          	divw	a5,s1,s4
    503c:	0307879b          	addiw	a5,a5,48
    5040:	f6f400a3          	sb	a5,-159(s0)
        name[2] = '0' + (nfiles % 1000) / 100;
    5044:	0344e7bb          	remw	a5,s1,s4
    5048:	0337c7bb          	divw	a5,a5,s3
    504c:	0307879b          	addiw	a5,a5,48
    5050:	f6f40123          	sb	a5,-158(s0)
        name[3] = '0' + (nfiles % 100) / 10;
    5054:	0334e7bb          	remw	a5,s1,s3
    5058:	0327c7bb          	divw	a5,a5,s2
    505c:	0307879b          	addiw	a5,a5,48
    5060:	f6f401a3          	sb	a5,-157(s0)
        name[4] = '0' + (nfiles % 10);
    5064:	0324e7bb          	remw	a5,s1,s2
    5068:	0307879b          	addiw	a5,a5,48
    506c:	f6f40223          	sb	a5,-156(s0)
        name[5] = '\0';
    5070:	f60402a3          	sb	zero,-155(s0)
        unlink(name);
    5074:	f6040513          	addi	a0,s0,-160
    5078:	00001097          	auipc	ra,0x1
    507c:	8ac080e7          	jalr	-1876(ra) # 5924 <unlink>
        nfiles--;
    5080:	34fd                	addiw	s1,s1,-1
    while (nfiles >= 0) {
    5082:	fb5499e3          	bne	s1,s5,5034 <fsfull+0xd0>
    printf("fsfull test finished\n");
    5086:	00003517          	auipc	a0,0x3
    508a:	c5a50513          	addi	a0,a0,-934 # 7ce0 <malloc+0x1fdc>
    508e:	00001097          	auipc	ra,0x1
    5092:	bbe080e7          	jalr	-1090(ra) # 5c4c <printf>
}
    5096:	60ea                	ld	ra,152(sp)
    5098:	644a                	ld	s0,144(sp)
    509a:	64aa                	ld	s1,136(sp)
    509c:	690a                	ld	s2,128(sp)
    509e:	79e6                	ld	s3,120(sp)
    50a0:	7a46                	ld	s4,112(sp)
    50a2:	7aa6                	ld	s5,104(sp)
    50a4:	7b06                	ld	s6,96(sp)
    50a6:	6be6                	ld	s7,88(sp)
    50a8:	6c46                	ld	s8,80(sp)
    50aa:	6ca6                	ld	s9,72(sp)
    50ac:	6d06                	ld	s10,64(sp)
    50ae:	610d                	addi	sp,sp,160
    50b0:	8082                	ret
        int total = 0;
    50b2:	4981                	li	s3,0
            int cc = write(fd, buf, BSIZE);
    50b4:	00008a97          	auipc	s5,0x8
    50b8:	02ca8a93          	addi	s5,s5,44 # d0e0 <buf>
            if (cc < BSIZE)
    50bc:	3ff00a13          	li	s4,1023
            int cc = write(fd, buf, BSIZE);
    50c0:	40000613          	li	a2,1024
    50c4:	85d6                	mv	a1,s5
    50c6:	854a                	mv	a0,s2
    50c8:	00001097          	auipc	ra,0x1
    50cc:	82c080e7          	jalr	-2004(ra) # 58f4 <write>
            if (cc < BSIZE)
    50d0:	00aa5563          	bge	s4,a0,50da <fsfull+0x176>
            total += cc;
    50d4:	00a989bb          	addw	s3,s3,a0
        while (1) {
    50d8:	b7e5                	j	50c0 <fsfull+0x15c>
        printf("wrote %d bytes\n", total);
    50da:	85ce                	mv	a1,s3
    50dc:	00003517          	auipc	a0,0x3
    50e0:	bf450513          	addi	a0,a0,-1036 # 7cd0 <malloc+0x1fcc>
    50e4:	00001097          	auipc	ra,0x1
    50e8:	b68080e7          	jalr	-1176(ra) # 5c4c <printf>
        close(fd);
    50ec:	854a                	mv	a0,s2
    50ee:	00001097          	auipc	ra,0x1
    50f2:	80e080e7          	jalr	-2034(ra) # 58fc <close>
        if (total == 0)
    50f6:	f20985e3          	beqz	s3,5020 <fsfull+0xbc>
    for (nfiles = 0;; nfiles++) {
    50fa:	2485                	addiw	s1,s1,1
    50fc:	b575                	j	4fa8 <fsfull+0x44>

00000000000050fe <badwrite>:
void badwrite(char *s) {
    50fe:	7179                	addi	sp,sp,-48
    5100:	f406                	sd	ra,40(sp)
    5102:	f022                	sd	s0,32(sp)
    5104:	ec26                	sd	s1,24(sp)
    5106:	e84a                	sd	s2,16(sp)
    5108:	e44e                	sd	s3,8(sp)
    510a:	e052                	sd	s4,0(sp)
    510c:	1800                	addi	s0,sp,48
    unlink("junk");
    510e:	00003517          	auipc	a0,0x3
    5112:	bea50513          	addi	a0,a0,-1046 # 7cf8 <malloc+0x1ff4>
    5116:	00001097          	auipc	ra,0x1
    511a:	80e080e7          	jalr	-2034(ra) # 5924 <unlink>
    511e:	25800913          	li	s2,600
        int fd = open("junk", O_CREATE | O_WRONLY);
    5122:	00003997          	auipc	s3,0x3
    5126:	bd698993          	addi	s3,s3,-1066 # 7cf8 <malloc+0x1ff4>
        write(fd, (char *)0xffffffffffL, 1);
    512a:	5a7d                	li	s4,-1
    512c:	018a5a13          	srli	s4,s4,0x18
        int fd = open("junk", O_CREATE | O_WRONLY);
    5130:	20100593          	li	a1,513
    5134:	854e                	mv	a0,s3
    5136:	00000097          	auipc	ra,0x0
    513a:	7de080e7          	jalr	2014(ra) # 5914 <open>
    513e:	84aa                	mv	s1,a0
        if (fd < 0) {
    5140:	06054b63          	bltz	a0,51b6 <badwrite+0xb8>
        write(fd, (char *)0xffffffffffL, 1);
    5144:	4605                	li	a2,1
    5146:	85d2                	mv	a1,s4
    5148:	00000097          	auipc	ra,0x0
    514c:	7ac080e7          	jalr	1964(ra) # 58f4 <write>
        close(fd);
    5150:	8526                	mv	a0,s1
    5152:	00000097          	auipc	ra,0x0
    5156:	7aa080e7          	jalr	1962(ra) # 58fc <close>
        unlink("junk");
    515a:	854e                	mv	a0,s3
    515c:	00000097          	auipc	ra,0x0
    5160:	7c8080e7          	jalr	1992(ra) # 5924 <unlink>
    for (int i = 0; i < assumed_free; i++) {
    5164:	397d                	addiw	s2,s2,-1
    5166:	fc0915e3          	bnez	s2,5130 <badwrite+0x32>
    int fd = open("junk", O_CREATE | O_WRONLY);
    516a:	20100593          	li	a1,513
    516e:	00003517          	auipc	a0,0x3
    5172:	b8a50513          	addi	a0,a0,-1142 # 7cf8 <malloc+0x1ff4>
    5176:	00000097          	auipc	ra,0x0
    517a:	79e080e7          	jalr	1950(ra) # 5914 <open>
    517e:	84aa                	mv	s1,a0
    if (fd < 0) {
    5180:	04054863          	bltz	a0,51d0 <badwrite+0xd2>
    if (write(fd, "x", 1) != 1) {
    5184:	4605                	li	a2,1
    5186:	00001597          	auipc	a1,0x1
    518a:	d2a58593          	addi	a1,a1,-726 # 5eb0 <malloc+0x1ac>
    518e:	00000097          	auipc	ra,0x0
    5192:	766080e7          	jalr	1894(ra) # 58f4 <write>
    5196:	4785                	li	a5,1
    5198:	04f50963          	beq	a0,a5,51ea <badwrite+0xec>
        printf("write failed\n");
    519c:	00003517          	auipc	a0,0x3
    51a0:	b7c50513          	addi	a0,a0,-1156 # 7d18 <malloc+0x2014>
    51a4:	00001097          	auipc	ra,0x1
    51a8:	aa8080e7          	jalr	-1368(ra) # 5c4c <printf>
        exit(1);
    51ac:	4505                	li	a0,1
    51ae:	00000097          	auipc	ra,0x0
    51b2:	726080e7          	jalr	1830(ra) # 58d4 <exit>
            printf("open junk failed\n");
    51b6:	00003517          	auipc	a0,0x3
    51ba:	b4a50513          	addi	a0,a0,-1206 # 7d00 <malloc+0x1ffc>
    51be:	00001097          	auipc	ra,0x1
    51c2:	a8e080e7          	jalr	-1394(ra) # 5c4c <printf>
            exit(1);
    51c6:	4505                	li	a0,1
    51c8:	00000097          	auipc	ra,0x0
    51cc:	70c080e7          	jalr	1804(ra) # 58d4 <exit>
        printf("open junk failed\n");
    51d0:	00003517          	auipc	a0,0x3
    51d4:	b3050513          	addi	a0,a0,-1232 # 7d00 <malloc+0x1ffc>
    51d8:	00001097          	auipc	ra,0x1
    51dc:	a74080e7          	jalr	-1420(ra) # 5c4c <printf>
        exit(1);
    51e0:	4505                	li	a0,1
    51e2:	00000097          	auipc	ra,0x0
    51e6:	6f2080e7          	jalr	1778(ra) # 58d4 <exit>
    close(fd);
    51ea:	8526                	mv	a0,s1
    51ec:	00000097          	auipc	ra,0x0
    51f0:	710080e7          	jalr	1808(ra) # 58fc <close>
    unlink("junk");
    51f4:	00003517          	auipc	a0,0x3
    51f8:	b0450513          	addi	a0,a0,-1276 # 7cf8 <malloc+0x1ff4>
    51fc:	00000097          	auipc	ra,0x0
    5200:	728080e7          	jalr	1832(ra) # 5924 <unlink>
    exit(0);
    5204:	4501                	li	a0,0
    5206:	00000097          	auipc	ra,0x0
    520a:	6ce080e7          	jalr	1742(ra) # 58d4 <exit>

000000000000520e <countfree>:
// use sbrk() to count how many free physical memory pages there are.
// touches the pages to force allocation.
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int countfree() {
    520e:	7139                	addi	sp,sp,-64
    5210:	fc06                	sd	ra,56(sp)
    5212:	f822                	sd	s0,48(sp)
    5214:	0080                	addi	s0,sp,64
    int fds[2];

    if (pipe(fds) < 0) {
    5216:	fc840513          	addi	a0,s0,-56
    521a:	00000097          	auipc	ra,0x0
    521e:	6ca080e7          	jalr	1738(ra) # 58e4 <pipe>
    5222:	06054a63          	bltz	a0,5296 <countfree+0x88>
        printf("pipe() failed in countfree()\n");
        exit(1);
    }

    int pid = fork();
    5226:	00000097          	auipc	ra,0x0
    522a:	6a6080e7          	jalr	1702(ra) # 58cc <fork>

    if (pid < 0) {
    522e:	08054463          	bltz	a0,52b6 <countfree+0xa8>
        printf("fork failed in countfree()\n");
        exit(1);
    }

    if (pid == 0) {
    5232:	e55d                	bnez	a0,52e0 <countfree+0xd2>
    5234:	f426                	sd	s1,40(sp)
    5236:	f04a                	sd	s2,32(sp)
    5238:	ec4e                	sd	s3,24(sp)
        close(fds[0]);
    523a:	fc842503          	lw	a0,-56(s0)
    523e:	00000097          	auipc	ra,0x0
    5242:	6be080e7          	jalr	1726(ra) # 58fc <close>

        while (1) {
            uint64 a = (uint64)sbrk(4096);
            if (a == 0xffffffffffffffff) {
    5246:	597d                	li	s2,-1
                break;
            }

            // modify the memory to make sure it's really allocated.
            *(char *)(a + 4096 - 1) = 1;
    5248:	4485                	li	s1,1

            // report back one more page.
            if (write(fds[1], "x", 1) != 1) {
    524a:	00001997          	auipc	s3,0x1
    524e:	c6698993          	addi	s3,s3,-922 # 5eb0 <malloc+0x1ac>
            uint64 a = (uint64)sbrk(4096);
    5252:	6505                	lui	a0,0x1
    5254:	00000097          	auipc	ra,0x0
    5258:	708080e7          	jalr	1800(ra) # 595c <sbrk>
            if (a == 0xffffffffffffffff) {
    525c:	07250d63          	beq	a0,s2,52d6 <countfree+0xc8>
            *(char *)(a + 4096 - 1) = 1;
    5260:	6785                	lui	a5,0x1
    5262:	97aa                	add	a5,a5,a0
    5264:	fe978fa3          	sb	s1,-1(a5) # fff <bigdir+0x9f>
            if (write(fds[1], "x", 1) != 1) {
    5268:	8626                	mv	a2,s1
    526a:	85ce                	mv	a1,s3
    526c:	fcc42503          	lw	a0,-52(s0)
    5270:	00000097          	auipc	ra,0x0
    5274:	684080e7          	jalr	1668(ra) # 58f4 <write>
    5278:	fc950de3          	beq	a0,s1,5252 <countfree+0x44>
                printf("write() failed in countfree()\n");
    527c:	00003517          	auipc	a0,0x3
    5280:	aec50513          	addi	a0,a0,-1300 # 7d68 <malloc+0x2064>
    5284:	00001097          	auipc	ra,0x1
    5288:	9c8080e7          	jalr	-1592(ra) # 5c4c <printf>
                exit(1);
    528c:	4505                	li	a0,1
    528e:	00000097          	auipc	ra,0x0
    5292:	646080e7          	jalr	1606(ra) # 58d4 <exit>
    5296:	f426                	sd	s1,40(sp)
    5298:	f04a                	sd	s2,32(sp)
    529a:	ec4e                	sd	s3,24(sp)
        printf("pipe() failed in countfree()\n");
    529c:	00003517          	auipc	a0,0x3
    52a0:	a8c50513          	addi	a0,a0,-1396 # 7d28 <malloc+0x2024>
    52a4:	00001097          	auipc	ra,0x1
    52a8:	9a8080e7          	jalr	-1624(ra) # 5c4c <printf>
        exit(1);
    52ac:	4505                	li	a0,1
    52ae:	00000097          	auipc	ra,0x0
    52b2:	626080e7          	jalr	1574(ra) # 58d4 <exit>
    52b6:	f426                	sd	s1,40(sp)
    52b8:	f04a                	sd	s2,32(sp)
    52ba:	ec4e                	sd	s3,24(sp)
        printf("fork failed in countfree()\n");
    52bc:	00003517          	auipc	a0,0x3
    52c0:	a8c50513          	addi	a0,a0,-1396 # 7d48 <malloc+0x2044>
    52c4:	00001097          	auipc	ra,0x1
    52c8:	988080e7          	jalr	-1656(ra) # 5c4c <printf>
        exit(1);
    52cc:	4505                	li	a0,1
    52ce:	00000097          	auipc	ra,0x0
    52d2:	606080e7          	jalr	1542(ra) # 58d4 <exit>
            }
        }

        exit(0);
    52d6:	4501                	li	a0,0
    52d8:	00000097          	auipc	ra,0x0
    52dc:	5fc080e7          	jalr	1532(ra) # 58d4 <exit>
    52e0:	f426                	sd	s1,40(sp)
    }

    close(fds[1]);
    52e2:	fcc42503          	lw	a0,-52(s0)
    52e6:	00000097          	auipc	ra,0x0
    52ea:	616080e7          	jalr	1558(ra) # 58fc <close>

    int n = 0;
    52ee:	4481                	li	s1,0
    while (1) {
        char c;
        int cc = read(fds[0], &c, 1);
    52f0:	4605                	li	a2,1
    52f2:	fc740593          	addi	a1,s0,-57
    52f6:	fc842503          	lw	a0,-56(s0)
    52fa:	00000097          	auipc	ra,0x0
    52fe:	5f2080e7          	jalr	1522(ra) # 58ec <read>
        if (cc < 0) {
    5302:	00054563          	bltz	a0,530c <countfree+0xfe>
            printf("read() failed in countfree()\n");
            exit(1);
        }
        if (cc == 0)
    5306:	c115                	beqz	a0,532a <countfree+0x11c>
            break;
        n += 1;
    5308:	2485                	addiw	s1,s1,1
    while (1) {
    530a:	b7dd                	j	52f0 <countfree+0xe2>
    530c:	f04a                	sd	s2,32(sp)
    530e:	ec4e                	sd	s3,24(sp)
            printf("read() failed in countfree()\n");
    5310:	00003517          	auipc	a0,0x3
    5314:	a7850513          	addi	a0,a0,-1416 # 7d88 <malloc+0x2084>
    5318:	00001097          	auipc	ra,0x1
    531c:	934080e7          	jalr	-1740(ra) # 5c4c <printf>
            exit(1);
    5320:	4505                	li	a0,1
    5322:	00000097          	auipc	ra,0x0
    5326:	5b2080e7          	jalr	1458(ra) # 58d4 <exit>
    }

    close(fds[0]);
    532a:	fc842503          	lw	a0,-56(s0)
    532e:	00000097          	auipc	ra,0x0
    5332:	5ce080e7          	jalr	1486(ra) # 58fc <close>
    wait((int *)0);
    5336:	4501                	li	a0,0
    5338:	00000097          	auipc	ra,0x0
    533c:	5a4080e7          	jalr	1444(ra) # 58dc <wait>

    return n;
}
    5340:	8526                	mv	a0,s1
    5342:	74a2                	ld	s1,40(sp)
    5344:	70e2                	ld	ra,56(sp)
    5346:	7442                	ld	s0,48(sp)
    5348:	6121                	addi	sp,sp,64
    534a:	8082                	ret

000000000000534c <run>:

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int run(void f(char *), char *s) {
    534c:	7179                	addi	sp,sp,-48
    534e:	f406                	sd	ra,40(sp)
    5350:	f022                	sd	s0,32(sp)
    5352:	ec26                	sd	s1,24(sp)
    5354:	e84a                	sd	s2,16(sp)
    5356:	1800                	addi	s0,sp,48
    5358:	84aa                	mv	s1,a0
    535a:	892e                	mv	s2,a1
    int pid;
    int xstatus;

    printf("test %s: ", s);
    535c:	00003517          	auipc	a0,0x3
    5360:	a4c50513          	addi	a0,a0,-1460 # 7da8 <malloc+0x20a4>
    5364:	00001097          	auipc	ra,0x1
    5368:	8e8080e7          	jalr	-1816(ra) # 5c4c <printf>
    if ((pid = fork()) < 0) {
    536c:	00000097          	auipc	ra,0x0
    5370:	560080e7          	jalr	1376(ra) # 58cc <fork>
    5374:	02054e63          	bltz	a0,53b0 <run+0x64>
        printf("runtest: fork error\n");
        exit(1);
    }
    if (pid == 0) {
    5378:	c929                	beqz	a0,53ca <run+0x7e>
        f(s);
        exit(0);
    } else {
        wait(&xstatus);
    537a:	fdc40513          	addi	a0,s0,-36
    537e:	00000097          	auipc	ra,0x0
    5382:	55e080e7          	jalr	1374(ra) # 58dc <wait>
        if (xstatus != 0)
    5386:	fdc42783          	lw	a5,-36(s0)
    538a:	c7b9                	beqz	a5,53d8 <run+0x8c>
            printf("FAILED\n");
    538c:	00003517          	auipc	a0,0x3
    5390:	a4450513          	addi	a0,a0,-1468 # 7dd0 <malloc+0x20cc>
    5394:	00001097          	auipc	ra,0x1
    5398:	8b8080e7          	jalr	-1864(ra) # 5c4c <printf>
        else
            printf("OK\n");
        return xstatus == 0;
    539c:	fdc42503          	lw	a0,-36(s0)
    }
}
    53a0:	00153513          	seqz	a0,a0
    53a4:	70a2                	ld	ra,40(sp)
    53a6:	7402                	ld	s0,32(sp)
    53a8:	64e2                	ld	s1,24(sp)
    53aa:	6942                	ld	s2,16(sp)
    53ac:	6145                	addi	sp,sp,48
    53ae:	8082                	ret
        printf("runtest: fork error\n");
    53b0:	00003517          	auipc	a0,0x3
    53b4:	a0850513          	addi	a0,a0,-1528 # 7db8 <malloc+0x20b4>
    53b8:	00001097          	auipc	ra,0x1
    53bc:	894080e7          	jalr	-1900(ra) # 5c4c <printf>
        exit(1);
    53c0:	4505                	li	a0,1
    53c2:	00000097          	auipc	ra,0x0
    53c6:	512080e7          	jalr	1298(ra) # 58d4 <exit>
        f(s);
    53ca:	854a                	mv	a0,s2
    53cc:	9482                	jalr	s1
        exit(0);
    53ce:	4501                	li	a0,0
    53d0:	00000097          	auipc	ra,0x0
    53d4:	504080e7          	jalr	1284(ra) # 58d4 <exit>
            printf("OK\n");
    53d8:	00003517          	auipc	a0,0x3
    53dc:	a0050513          	addi	a0,a0,-1536 # 7dd8 <malloc+0x20d4>
    53e0:	00001097          	auipc	ra,0x1
    53e4:	86c080e7          	jalr	-1940(ra) # 5c4c <printf>
    53e8:	bf55                	j	539c <run+0x50>

00000000000053ea <main>:

int main(int argc, char *argv[]) {
    53ea:	bd010113          	addi	sp,sp,-1072
    53ee:	42113423          	sd	ra,1064(sp)
    53f2:	42813023          	sd	s0,1056(sp)
    53f6:	41313423          	sd	s3,1032(sp)
    53fa:	43010413          	addi	s0,sp,1072
    53fe:	89aa                	mv	s3,a0
    int continuous = 0;
    char *justone = 0;

    if (argc == 2 && strcmp(argv[1], "-c") == 0) {
    5400:	4789                	li	a5,2
    5402:	0af50a63          	beq	a0,a5,54b6 <main+0xcc>
        continuous = 1;
    } else if (argc == 2 && strcmp(argv[1], "-C") == 0) {
        continuous = 2;
    } else if (argc == 2 && argv[1][0] != '-') {
        justone = argv[1];
    } else if (argc > 1) {
    5406:	4785                	li	a5,1
    5408:	16a7c263          	blt	a5,a0,556c <main+0x182>
    char *justone = 0;
    540c:	4981                	li	s3,0
    540e:	40913c23          	sd	s1,1048(sp)
    5412:	41213823          	sd	s2,1040(sp)
    5416:	41413023          	sd	s4,1024(sp)
    541a:	3f513c23          	sd	s5,1016(sp)
    541e:	3f613823          	sd	s6,1008(sp)
    }

    struct test {
        void (*f)(char *);
        char *s;
    } tests[] = {
    5422:	00003797          	auipc	a5,0x3
    5426:	dd678793          	addi	a5,a5,-554 # 81f8 <malloc+0x24f4>
    542a:	bd040713          	addi	a4,s0,-1072
    542e:	00003317          	auipc	t1,0x3
    5432:	1ba30313          	addi	t1,t1,442 # 85e8 <malloc+0x28e4>
    5436:	0007b883          	ld	a7,0(a5)
    543a:	0087b803          	ld	a6,8(a5)
    543e:	6b88                	ld	a0,16(a5)
    5440:	6f8c                	ld	a1,24(a5)
    5442:	7390                	ld	a2,32(a5)
    5444:	7794                	ld	a3,40(a5)
    5446:	01173023          	sd	a7,0(a4)
    544a:	01073423          	sd	a6,8(a4)
    544e:	eb08                	sd	a0,16(a4)
    5450:	ef0c                	sd	a1,24(a4)
    5452:	f310                	sd	a2,32(a4)
    5454:	f714                	sd	a3,40(a4)
    5456:	03078793          	addi	a5,a5,48
    545a:	03070713          	addi	a4,a4,48
    545e:	fc679ce3          	bne	a5,t1,5436 <main+0x4c>
                    exit(1);
            }
        }
    }

    printf("usertests starting\n");
    5462:	00003517          	auipc	a0,0x3
    5466:	a3650513          	addi	a0,a0,-1482 # 7e98 <malloc+0x2194>
    546a:	00000097          	auipc	ra,0x0
    546e:	7e2080e7          	jalr	2018(ra) # 5c4c <printf>
    int free0 = countfree();
    5472:	00000097          	auipc	ra,0x0
    5476:	d9c080e7          	jalr	-612(ra) # 520e <countfree>
    547a:	8aaa                	mv	s5,a0
    int free1 = 0;
    int fail = 0;
    for (struct test *t = tests; t->s != 0; t++) {
    547c:	bd843903          	ld	s2,-1064(s0)
    5480:	bd040493          	addi	s1,s0,-1072
    int fail = 0;
    5484:	4a01                	li	s4,0
        if ((justone == 0) || strcmp(t->s, justone) == 0) {
            if (!run(t->f, t->s))
                fail = 1;
    5486:	4b05                	li	s6,1
    for (struct test *t = tests; t->s != 0; t++) {
    5488:	14091163          	bnez	s2,55ca <main+0x1e0>
    }

    if (fail) {
        printf("SOME TESTS FAILED\n");
        exit(1);
    } else if ((free1 = countfree()) < free0) {
    548c:	00000097          	auipc	ra,0x0
    5490:	d82080e7          	jalr	-638(ra) # 520e <countfree>
    5494:	85aa                	mv	a1,a0
    5496:	17555b63          	bge	a0,s5,560c <main+0x222>
        printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    549a:	8656                	mv	a2,s5
    549c:	00003517          	auipc	a0,0x3
    54a0:	9b450513          	addi	a0,a0,-1612 # 7e50 <malloc+0x214c>
    54a4:	00000097          	auipc	ra,0x0
    54a8:	7a8080e7          	jalr	1960(ra) # 5c4c <printf>
        exit(1);
    54ac:	4505                	li	a0,1
    54ae:	00000097          	auipc	ra,0x0
    54b2:	426080e7          	jalr	1062(ra) # 58d4 <exit>
    54b6:	40913c23          	sd	s1,1048(sp)
    54ba:	41213823          	sd	s2,1040(sp)
    54be:	41413023          	sd	s4,1024(sp)
    54c2:	3f513c23          	sd	s5,1016(sp)
    54c6:	3f613823          	sd	s6,1008(sp)
    54ca:	84ae                	mv	s1,a1
    if (argc == 2 && strcmp(argv[1], "-c") == 0) {
    54cc:	00003597          	auipc	a1,0x3
    54d0:	91458593          	addi	a1,a1,-1772 # 7de0 <malloc+0x20dc>
    54d4:	6488                	ld	a0,8(s1)
    54d6:	00000097          	auipc	ra,0x0
    54da:	1ae080e7          	jalr	430(ra) # 5684 <strcmp>
    54de:	e525                	bnez	a0,5546 <main+0x15c>
        continuous = 1;
    54e0:	4985                	li	s3,1
    } tests[] = {
    54e2:	00003797          	auipc	a5,0x3
    54e6:	d1678793          	addi	a5,a5,-746 # 81f8 <malloc+0x24f4>
    54ea:	bd040713          	addi	a4,s0,-1072
    54ee:	00003317          	auipc	t1,0x3
    54f2:	0fa30313          	addi	t1,t1,250 # 85e8 <malloc+0x28e4>
    54f6:	0007b883          	ld	a7,0(a5)
    54fa:	0087b803          	ld	a6,8(a5)
    54fe:	6b88                	ld	a0,16(a5)
    5500:	6f8c                	ld	a1,24(a5)
    5502:	7390                	ld	a2,32(a5)
    5504:	7794                	ld	a3,40(a5)
    5506:	01173023          	sd	a7,0(a4)
    550a:	01073423          	sd	a6,8(a4)
    550e:	eb08                	sd	a0,16(a4)
    5510:	ef0c                	sd	a1,24(a4)
    5512:	f310                	sd	a2,32(a4)
    5514:	f714                	sd	a3,40(a4)
    5516:	03078793          	addi	a5,a5,48
    551a:	03070713          	addi	a4,a4,48
    551e:	fc679ce3          	bne	a5,t1,54f6 <main+0x10c>
        printf("continuous usertests starting\n");
    5522:	00003517          	auipc	a0,0x3
    5526:	98e50513          	addi	a0,a0,-1650 # 7eb0 <malloc+0x21ac>
    552a:	00000097          	auipc	ra,0x0
    552e:	722080e7          	jalr	1826(ra) # 5c4c <printf>
                printf("SOME TESTS FAILED\n");
    5532:	00003a97          	auipc	s5,0x3
    5536:	906a8a93          	addi	s5,s5,-1786 # 7e38 <malloc+0x2134>
                if (continuous != 2)
    553a:	4a09                	li	s4,2
                printf("FAILED -- lost %d free pages\n", free0 - free1);
    553c:	00003b17          	auipc	s6,0x3
    5540:	8dcb0b13          	addi	s6,s6,-1828 # 7e18 <malloc+0x2114>
    5544:	a8f5                	j	5640 <main+0x256>
    } else if (argc == 2 && strcmp(argv[1], "-C") == 0) {
    5546:	00003597          	auipc	a1,0x3
    554a:	8a258593          	addi	a1,a1,-1886 # 7de8 <malloc+0x20e4>
    554e:	6488                	ld	a0,8(s1)
    5550:	00000097          	auipc	ra,0x0
    5554:	134080e7          	jalr	308(ra) # 5684 <strcmp>
    5558:	d549                	beqz	a0,54e2 <main+0xf8>
    } else if (argc == 2 && argv[1][0] != '-') {
    555a:	0084b983          	ld	s3,8(s1)
    555e:	0009c703          	lbu	a4,0(s3)
    5562:	02d00793          	li	a5,45
    5566:	eaf71ee3          	bne	a4,a5,5422 <main+0x38>
    556a:	a819                	j	5580 <main+0x196>
    556c:	40913c23          	sd	s1,1048(sp)
    5570:	41213823          	sd	s2,1040(sp)
    5574:	41413023          	sd	s4,1024(sp)
    5578:	3f513c23          	sd	s5,1016(sp)
    557c:	3f613823          	sd	s6,1008(sp)
        printf("Usage: usertests [-c] [testname]\n");
    5580:	00003517          	auipc	a0,0x3
    5584:	87050513          	addi	a0,a0,-1936 # 7df0 <malloc+0x20ec>
    5588:	00000097          	auipc	ra,0x0
    558c:	6c4080e7          	jalr	1732(ra) # 5c4c <printf>
        exit(1);
    5590:	4505                	li	a0,1
    5592:	00000097          	auipc	ra,0x0
    5596:	342080e7          	jalr	834(ra) # 58d4 <exit>
                    exit(1);
    559a:	4505                	li	a0,1
    559c:	00000097          	auipc	ra,0x0
    55a0:	338080e7          	jalr	824(ra) # 58d4 <exit>
                printf("FAILED -- lost %d free pages\n", free0 - free1);
    55a4:	40a905bb          	subw	a1,s2,a0
    55a8:	855a                	mv	a0,s6
    55aa:	00000097          	auipc	ra,0x0
    55ae:	6a2080e7          	jalr	1698(ra) # 5c4c <printf>
                if (continuous != 2)
    55b2:	09498763          	beq	s3,s4,5640 <main+0x256>
                    exit(1);
    55b6:	4505                	li	a0,1
    55b8:	00000097          	auipc	ra,0x0
    55bc:	31c080e7          	jalr	796(ra) # 58d4 <exit>
    for (struct test *t = tests; t->s != 0; t++) {
    55c0:	04c1                	addi	s1,s1,16
    55c2:	0084b903          	ld	s2,8(s1)
    55c6:	02090463          	beqz	s2,55ee <main+0x204>
        if ((justone == 0) || strcmp(t->s, justone) == 0) {
    55ca:	00098963          	beqz	s3,55dc <main+0x1f2>
    55ce:	85ce                	mv	a1,s3
    55d0:	854a                	mv	a0,s2
    55d2:	00000097          	auipc	ra,0x0
    55d6:	0b2080e7          	jalr	178(ra) # 5684 <strcmp>
    55da:	f17d                	bnez	a0,55c0 <main+0x1d6>
            if (!run(t->f, t->s))
    55dc:	85ca                	mv	a1,s2
    55de:	6088                	ld	a0,0(s1)
    55e0:	00000097          	auipc	ra,0x0
    55e4:	d6c080e7          	jalr	-660(ra) # 534c <run>
    55e8:	fd61                	bnez	a0,55c0 <main+0x1d6>
                fail = 1;
    55ea:	8a5a                	mv	s4,s6
    55ec:	bfd1                	j	55c0 <main+0x1d6>
    if (fail) {
    55ee:	e80a0fe3          	beqz	s4,548c <main+0xa2>
        printf("SOME TESTS FAILED\n");
    55f2:	00003517          	auipc	a0,0x3
    55f6:	84650513          	addi	a0,a0,-1978 # 7e38 <malloc+0x2134>
    55fa:	00000097          	auipc	ra,0x0
    55fe:	652080e7          	jalr	1618(ra) # 5c4c <printf>
        exit(1);
    5602:	4505                	li	a0,1
    5604:	00000097          	auipc	ra,0x0
    5608:	2d0080e7          	jalr	720(ra) # 58d4 <exit>
    } else {
        printf("ALL TESTS PASSED\n");
    560c:	00003517          	auipc	a0,0x3
    5610:	87450513          	addi	a0,a0,-1932 # 7e80 <malloc+0x217c>
    5614:	00000097          	auipc	ra,0x0
    5618:	638080e7          	jalr	1592(ra) # 5c4c <printf>
        exit(0);
    561c:	4501                	li	a0,0
    561e:	00000097          	auipc	ra,0x0
    5622:	2b6080e7          	jalr	694(ra) # 58d4 <exit>
                printf("SOME TESTS FAILED\n");
    5626:	8556                	mv	a0,s5
    5628:	00000097          	auipc	ra,0x0
    562c:	624080e7          	jalr	1572(ra) # 5c4c <printf>
                if (continuous != 2)
    5630:	f74995e3          	bne	s3,s4,559a <main+0x1b0>
            int free1 = countfree();
    5634:	00000097          	auipc	ra,0x0
    5638:	bda080e7          	jalr	-1062(ra) # 520e <countfree>
            if (free1 < free0) {
    563c:	f72544e3          	blt	a0,s2,55a4 <main+0x1ba>
            int free0 = countfree();
    5640:	00000097          	auipc	ra,0x0
    5644:	bce080e7          	jalr	-1074(ra) # 520e <countfree>
    5648:	892a                	mv	s2,a0
            for (struct test *t = tests; t->s != 0; t++) {
    564a:	bd843583          	ld	a1,-1064(s0)
    564e:	d1fd                	beqz	a1,5634 <main+0x24a>
    5650:	bd040493          	addi	s1,s0,-1072
                if (!run(t->f, t->s)) {
    5654:	6088                	ld	a0,0(s1)
    5656:	00000097          	auipc	ra,0x0
    565a:	cf6080e7          	jalr	-778(ra) # 534c <run>
    565e:	d561                	beqz	a0,5626 <main+0x23c>
            for (struct test *t = tests; t->s != 0; t++) {
    5660:	04c1                	addi	s1,s1,16
    5662:	648c                	ld	a1,8(s1)
    5664:	f9e5                	bnez	a1,5654 <main+0x26a>
    5666:	b7f9                	j	5634 <main+0x24a>

0000000000005668 <strcpy>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "user/user.h"

char *strcpy(char *s, const char *t) {
    5668:	1141                	addi	sp,sp,-16
    566a:	e422                	sd	s0,8(sp)
    566c:	0800                	addi	s0,sp,16
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    566e:	87aa                	mv	a5,a0
    5670:	0585                	addi	a1,a1,1
    5672:	0785                	addi	a5,a5,1
    5674:	fff5c703          	lbu	a4,-1(a1)
    5678:	fee78fa3          	sb	a4,-1(a5)
    567c:	fb75                	bnez	a4,5670 <strcpy+0x8>
        ;
    return os;
}
    567e:	6422                	ld	s0,8(sp)
    5680:	0141                	addi	sp,sp,16
    5682:	8082                	ret

0000000000005684 <strcmp>:

int strcmp(const char *p, const char *q) {
    5684:	1141                	addi	sp,sp,-16
    5686:	e422                	sd	s0,8(sp)
    5688:	0800                	addi	s0,sp,16
    while (*p && *p == *q)
    568a:	00054783          	lbu	a5,0(a0)
    568e:	cb91                	beqz	a5,56a2 <strcmp+0x1e>
    5690:	0005c703          	lbu	a4,0(a1)
    5694:	00f71763          	bne	a4,a5,56a2 <strcmp+0x1e>
        p++, q++;
    5698:	0505                	addi	a0,a0,1
    569a:	0585                	addi	a1,a1,1
    while (*p && *p == *q)
    569c:	00054783          	lbu	a5,0(a0)
    56a0:	fbe5                	bnez	a5,5690 <strcmp+0xc>
    return (uchar)*p - (uchar)*q;
    56a2:	0005c503          	lbu	a0,0(a1)
}
    56a6:	40a7853b          	subw	a0,a5,a0
    56aa:	6422                	ld	s0,8(sp)
    56ac:	0141                	addi	sp,sp,16
    56ae:	8082                	ret

00000000000056b0 <strlen>:

uint strlen(const char *s) {
    56b0:	1141                	addi	sp,sp,-16
    56b2:	e422                	sd	s0,8(sp)
    56b4:	0800                	addi	s0,sp,16
    int n;

    for (n = 0; s[n]; n++)
    56b6:	00054783          	lbu	a5,0(a0)
    56ba:	cf91                	beqz	a5,56d6 <strlen+0x26>
    56bc:	0505                	addi	a0,a0,1
    56be:	87aa                	mv	a5,a0
    56c0:	86be                	mv	a3,a5
    56c2:	0785                	addi	a5,a5,1
    56c4:	fff7c703          	lbu	a4,-1(a5)
    56c8:	ff65                	bnez	a4,56c0 <strlen+0x10>
    56ca:	40a6853b          	subw	a0,a3,a0
    56ce:	2505                	addiw	a0,a0,1
        ;
    return n;
}
    56d0:	6422                	ld	s0,8(sp)
    56d2:	0141                	addi	sp,sp,16
    56d4:	8082                	ret
    for (n = 0; s[n]; n++)
    56d6:	4501                	li	a0,0
    56d8:	bfe5                	j	56d0 <strlen+0x20>

00000000000056da <memset>:

void *memset(void *dst, int c, uint n) {
    56da:	1141                	addi	sp,sp,-16
    56dc:	e422                	sd	s0,8(sp)
    56de:	0800                	addi	s0,sp,16
    char *cdst = (char *)dst;
    int i;
    for (i = 0; i < n; i++) {
    56e0:	ca19                	beqz	a2,56f6 <memset+0x1c>
    56e2:	87aa                	mv	a5,a0
    56e4:	1602                	slli	a2,a2,0x20
    56e6:	9201                	srli	a2,a2,0x20
    56e8:	00a60733          	add	a4,a2,a0
        cdst[i] = c;
    56ec:	00b78023          	sb	a1,0(a5)
    for (i = 0; i < n; i++) {
    56f0:	0785                	addi	a5,a5,1
    56f2:	fee79de3          	bne	a5,a4,56ec <memset+0x12>
    }
    return dst;
}
    56f6:	6422                	ld	s0,8(sp)
    56f8:	0141                	addi	sp,sp,16
    56fa:	8082                	ret

00000000000056fc <strchr>:

char *strchr(const char *s, char c) {
    56fc:	1141                	addi	sp,sp,-16
    56fe:	e422                	sd	s0,8(sp)
    5700:	0800                	addi	s0,sp,16
    for (; *s; s++)
    5702:	00054783          	lbu	a5,0(a0)
    5706:	cb99                	beqz	a5,571c <strchr+0x20>
        if (*s == c)
    5708:	00f58763          	beq	a1,a5,5716 <strchr+0x1a>
    for (; *s; s++)
    570c:	0505                	addi	a0,a0,1
    570e:	00054783          	lbu	a5,0(a0)
    5712:	fbfd                	bnez	a5,5708 <strchr+0xc>
            return (char *)s;
    return 0;
    5714:	4501                	li	a0,0
}
    5716:	6422                	ld	s0,8(sp)
    5718:	0141                	addi	sp,sp,16
    571a:	8082                	ret
    return 0;
    571c:	4501                	li	a0,0
    571e:	bfe5                	j	5716 <strchr+0x1a>

0000000000005720 <gets>:

char *gets(char *buf, int max) {
    5720:	711d                	addi	sp,sp,-96
    5722:	ec86                	sd	ra,88(sp)
    5724:	e8a2                	sd	s0,80(sp)
    5726:	e4a6                	sd	s1,72(sp)
    5728:	e0ca                	sd	s2,64(sp)
    572a:	fc4e                	sd	s3,56(sp)
    572c:	f852                	sd	s4,48(sp)
    572e:	f456                	sd	s5,40(sp)
    5730:	f05a                	sd	s6,32(sp)
    5732:	ec5e                	sd	s7,24(sp)
    5734:	1080                	addi	s0,sp,96
    5736:	8baa                	mv	s7,a0
    5738:	8a2e                	mv	s4,a1
    int i, cc;
    char c;

    for (i = 0; i + 1 < max;) {
    573a:	892a                	mv	s2,a0
    573c:	4481                	li	s1,0
        cc = read(0, &c, 1);
        if (cc < 1)
            break;
        buf[i++] = c;
        if (c == '\n' || c == '\r')
    573e:	4aa9                	li	s5,10
    5740:	4b35                	li	s6,13
    for (i = 0; i + 1 < max;) {
    5742:	89a6                	mv	s3,s1
    5744:	2485                	addiw	s1,s1,1
    5746:	0344d863          	bge	s1,s4,5776 <gets+0x56>
        cc = read(0, &c, 1);
    574a:	4605                	li	a2,1
    574c:	faf40593          	addi	a1,s0,-81
    5750:	4501                	li	a0,0
    5752:	00000097          	auipc	ra,0x0
    5756:	19a080e7          	jalr	410(ra) # 58ec <read>
        if (cc < 1)
    575a:	00a05e63          	blez	a0,5776 <gets+0x56>
        buf[i++] = c;
    575e:	faf44783          	lbu	a5,-81(s0)
    5762:	00f90023          	sb	a5,0(s2)
        if (c == '\n' || c == '\r')
    5766:	01578763          	beq	a5,s5,5774 <gets+0x54>
    576a:	0905                	addi	s2,s2,1
    576c:	fd679be3          	bne	a5,s6,5742 <gets+0x22>
        buf[i++] = c;
    5770:	89a6                	mv	s3,s1
    5772:	a011                	j	5776 <gets+0x56>
    5774:	89a6                	mv	s3,s1
            break;
    }
    buf[i] = '\0';
    5776:	99de                	add	s3,s3,s7
    5778:	00098023          	sb	zero,0(s3)
    return buf;
}
    577c:	855e                	mv	a0,s7
    577e:	60e6                	ld	ra,88(sp)
    5780:	6446                	ld	s0,80(sp)
    5782:	64a6                	ld	s1,72(sp)
    5784:	6906                	ld	s2,64(sp)
    5786:	79e2                	ld	s3,56(sp)
    5788:	7a42                	ld	s4,48(sp)
    578a:	7aa2                	ld	s5,40(sp)
    578c:	7b02                	ld	s6,32(sp)
    578e:	6be2                	ld	s7,24(sp)
    5790:	6125                	addi	sp,sp,96
    5792:	8082                	ret

0000000000005794 <stat>:

int stat(const char *n, struct stat *st) {
    5794:	1101                	addi	sp,sp,-32
    5796:	ec06                	sd	ra,24(sp)
    5798:	e822                	sd	s0,16(sp)
    579a:	e04a                	sd	s2,0(sp)
    579c:	1000                	addi	s0,sp,32
    579e:	892e                	mv	s2,a1
    int fd;
    int r;

    fd = open(n, O_RDONLY);
    57a0:	4581                	li	a1,0
    57a2:	00000097          	auipc	ra,0x0
    57a6:	172080e7          	jalr	370(ra) # 5914 <open>
    if (fd < 0)
    57aa:	02054663          	bltz	a0,57d6 <stat+0x42>
    57ae:	e426                	sd	s1,8(sp)
    57b0:	84aa                	mv	s1,a0
        return -1;
    r = fstat(fd, st);
    57b2:	85ca                	mv	a1,s2
    57b4:	00000097          	auipc	ra,0x0
    57b8:	178080e7          	jalr	376(ra) # 592c <fstat>
    57bc:	892a                	mv	s2,a0
    close(fd);
    57be:	8526                	mv	a0,s1
    57c0:	00000097          	auipc	ra,0x0
    57c4:	13c080e7          	jalr	316(ra) # 58fc <close>
    return r;
    57c8:	64a2                	ld	s1,8(sp)
}
    57ca:	854a                	mv	a0,s2
    57cc:	60e2                	ld	ra,24(sp)
    57ce:	6442                	ld	s0,16(sp)
    57d0:	6902                	ld	s2,0(sp)
    57d2:	6105                	addi	sp,sp,32
    57d4:	8082                	ret
        return -1;
    57d6:	597d                	li	s2,-1
    57d8:	bfcd                	j	57ca <stat+0x36>

00000000000057da <atoi>:

int atoi(const char *s) {
    57da:	1141                	addi	sp,sp,-16
    57dc:	e422                	sd	s0,8(sp)
    57de:	0800                	addi	s0,sp,16
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
    57e0:	00054683          	lbu	a3,0(a0)
    57e4:	fd06879b          	addiw	a5,a3,-48
    57e8:	0ff7f793          	zext.b	a5,a5
    57ec:	4625                	li	a2,9
    57ee:	02f66863          	bltu	a2,a5,581e <atoi+0x44>
    57f2:	872a                	mv	a4,a0
    n = 0;
    57f4:	4501                	li	a0,0
        n = n * 10 + *s++ - '0';
    57f6:	0705                	addi	a4,a4,1
    57f8:	0025179b          	slliw	a5,a0,0x2
    57fc:	9fa9                	addw	a5,a5,a0
    57fe:	0017979b          	slliw	a5,a5,0x1
    5802:	9fb5                	addw	a5,a5,a3
    5804:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    5808:	00074683          	lbu	a3,0(a4)
    580c:	fd06879b          	addiw	a5,a3,-48
    5810:	0ff7f793          	zext.b	a5,a5
    5814:	fef671e3          	bgeu	a2,a5,57f6 <atoi+0x1c>
    return n;
}
    5818:	6422                	ld	s0,8(sp)
    581a:	0141                	addi	sp,sp,16
    581c:	8082                	ret
    n = 0;
    581e:	4501                	li	a0,0
    5820:	bfe5                	j	5818 <atoi+0x3e>

0000000000005822 <memmove>:

void *memmove(void *vdst, const void *vsrc, int n) {
    5822:	1141                	addi	sp,sp,-16
    5824:	e422                	sd	s0,8(sp)
    5826:	0800                	addi	s0,sp,16
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    5828:	02b57463          	bgeu	a0,a1,5850 <memmove+0x2e>
        while (n-- > 0)
    582c:	00c05f63          	blez	a2,584a <memmove+0x28>
    5830:	1602                	slli	a2,a2,0x20
    5832:	9201                	srli	a2,a2,0x20
    5834:	00c507b3          	add	a5,a0,a2
    dst = vdst;
    5838:	872a                	mv	a4,a0
            *dst++ = *src++;
    583a:	0585                	addi	a1,a1,1
    583c:	0705                	addi	a4,a4,1
    583e:	fff5c683          	lbu	a3,-1(a1)
    5842:	fed70fa3          	sb	a3,-1(a4)
        while (n-- > 0)
    5846:	fef71ae3          	bne	a4,a5,583a <memmove+0x18>
        src += n;
        while (n-- > 0)
            *--dst = *--src;
    }
    return vdst;
}
    584a:	6422                	ld	s0,8(sp)
    584c:	0141                	addi	sp,sp,16
    584e:	8082                	ret
        dst += n;
    5850:	00c50733          	add	a4,a0,a2
        src += n;
    5854:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    5856:	fec05ae3          	blez	a2,584a <memmove+0x28>
    585a:	fff6079b          	addiw	a5,a2,-1 # 2fff <iputtest+0x2d>
    585e:	1782                	slli	a5,a5,0x20
    5860:	9381                	srli	a5,a5,0x20
    5862:	fff7c793          	not	a5,a5
    5866:	97ba                	add	a5,a5,a4
            *--dst = *--src;
    5868:	15fd                	addi	a1,a1,-1
    586a:	177d                	addi	a4,a4,-1
    586c:	0005c683          	lbu	a3,0(a1)
    5870:	00d70023          	sb	a3,0(a4)
        while (n-- > 0)
    5874:	fee79ae3          	bne	a5,a4,5868 <memmove+0x46>
    5878:	bfc9                	j	584a <memmove+0x28>

000000000000587a <memcmp>:

int memcmp(const void *s1, const void *s2, uint n) {
    587a:	1141                	addi	sp,sp,-16
    587c:	e422                	sd	s0,8(sp)
    587e:	0800                	addi	s0,sp,16
    const char *p1 = s1, *p2 = s2;
    while (n-- > 0) {
    5880:	ca05                	beqz	a2,58b0 <memcmp+0x36>
    5882:	fff6069b          	addiw	a3,a2,-1
    5886:	1682                	slli	a3,a3,0x20
    5888:	9281                	srli	a3,a3,0x20
    588a:	0685                	addi	a3,a3,1
    588c:	96aa                	add	a3,a3,a0
        if (*p1 != *p2) {
    588e:	00054783          	lbu	a5,0(a0)
    5892:	0005c703          	lbu	a4,0(a1)
    5896:	00e79863          	bne	a5,a4,58a6 <memcmp+0x2c>
            return *p1 - *p2;
        }
        p1++;
    589a:	0505                	addi	a0,a0,1
        p2++;
    589c:	0585                	addi	a1,a1,1
    while (n-- > 0) {
    589e:	fed518e3          	bne	a0,a3,588e <memcmp+0x14>
    }
    return 0;
    58a2:	4501                	li	a0,0
    58a4:	a019                	j	58aa <memcmp+0x30>
            return *p1 - *p2;
    58a6:	40e7853b          	subw	a0,a5,a4
}
    58aa:	6422                	ld	s0,8(sp)
    58ac:	0141                	addi	sp,sp,16
    58ae:	8082                	ret
    return 0;
    58b0:	4501                	li	a0,0
    58b2:	bfe5                	j	58aa <memcmp+0x30>

00000000000058b4 <memcpy>:

void *memcpy(void *dst, const void *src, uint n) {
    58b4:	1141                	addi	sp,sp,-16
    58b6:	e406                	sd	ra,8(sp)
    58b8:	e022                	sd	s0,0(sp)
    58ba:	0800                	addi	s0,sp,16
    return memmove(dst, src, n);
    58bc:	00000097          	auipc	ra,0x0
    58c0:	f66080e7          	jalr	-154(ra) # 5822 <memmove>
}
    58c4:	60a2                	ld	ra,8(sp)
    58c6:	6402                	ld	s0,0(sp)
    58c8:	0141                	addi	sp,sp,16
    58ca:	8082                	ret

00000000000058cc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    58cc:	4885                	li	a7,1
 ecall
    58ce:	00000073          	ecall
 ret
    58d2:	8082                	ret

00000000000058d4 <exit>:
.global exit
exit:
 li a7, SYS_exit
    58d4:	4889                	li	a7,2
 ecall
    58d6:	00000073          	ecall
 ret
    58da:	8082                	ret

00000000000058dc <wait>:
.global wait
wait:
 li a7, SYS_wait
    58dc:	488d                	li	a7,3
 ecall
    58de:	00000073          	ecall
 ret
    58e2:	8082                	ret

00000000000058e4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    58e4:	4891                	li	a7,4
 ecall
    58e6:	00000073          	ecall
 ret
    58ea:	8082                	ret

00000000000058ec <read>:
.global read
read:
 li a7, SYS_read
    58ec:	4895                	li	a7,5
 ecall
    58ee:	00000073          	ecall
 ret
    58f2:	8082                	ret

00000000000058f4 <write>:
.global write
write:
 li a7, SYS_write
    58f4:	48c1                	li	a7,16
 ecall
    58f6:	00000073          	ecall
 ret
    58fa:	8082                	ret

00000000000058fc <close>:
.global close
close:
 li a7, SYS_close
    58fc:	48d5                	li	a7,21
 ecall
    58fe:	00000073          	ecall
 ret
    5902:	8082                	ret

0000000000005904 <kill>:
.global kill
kill:
 li a7, SYS_kill
    5904:	4899                	li	a7,6
 ecall
    5906:	00000073          	ecall
 ret
    590a:	8082                	ret

000000000000590c <exec>:
.global exec
exec:
 li a7, SYS_exec
    590c:	489d                	li	a7,7
 ecall
    590e:	00000073          	ecall
 ret
    5912:	8082                	ret

0000000000005914 <open>:
.global open
open:
 li a7, SYS_open
    5914:	48bd                	li	a7,15
 ecall
    5916:	00000073          	ecall
 ret
    591a:	8082                	ret

000000000000591c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    591c:	48c5                	li	a7,17
 ecall
    591e:	00000073          	ecall
 ret
    5922:	8082                	ret

0000000000005924 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    5924:	48c9                	li	a7,18
 ecall
    5926:	00000073          	ecall
 ret
    592a:	8082                	ret

000000000000592c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    592c:	48a1                	li	a7,8
 ecall
    592e:	00000073          	ecall
 ret
    5932:	8082                	ret

0000000000005934 <link>:
.global link
link:
 li a7, SYS_link
    5934:	48cd                	li	a7,19
 ecall
    5936:	00000073          	ecall
 ret
    593a:	8082                	ret

000000000000593c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    593c:	48d1                	li	a7,20
 ecall
    593e:	00000073          	ecall
 ret
    5942:	8082                	ret

0000000000005944 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    5944:	48a5                	li	a7,9
 ecall
    5946:	00000073          	ecall
 ret
    594a:	8082                	ret

000000000000594c <dup>:
.global dup
dup:
 li a7, SYS_dup
    594c:	48a9                	li	a7,10
 ecall
    594e:	00000073          	ecall
 ret
    5952:	8082                	ret

0000000000005954 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    5954:	48ad                	li	a7,11
 ecall
    5956:	00000073          	ecall
 ret
    595a:	8082                	ret

000000000000595c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    595c:	48b1                	li	a7,12
 ecall
    595e:	00000073          	ecall
 ret
    5962:	8082                	ret

0000000000005964 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    5964:	48b5                	li	a7,13
 ecall
    5966:	00000073          	ecall
 ret
    596a:	8082                	ret

000000000000596c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    596c:	48b9                	li	a7,14
 ecall
    596e:	00000073          	ecall
 ret
    5972:	8082                	ret

0000000000005974 <trace>:
.global trace
trace:
 li a7, SYS_trace
    5974:	48d9                	li	a7,22
 ecall
    5976:	00000073          	ecall
 ret
    597a:	8082                	ret

000000000000597c <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
    597c:	48dd                	li	a7,23
 ecall
    597e:	00000073          	ecall
 ret
    5982:	8082                	ret

0000000000005984 <putc>:

#include <stdarg.h>

static char digits[] = "0123456789ABCDEF";

static void putc(int fd, char c) { write(fd, &c, 1); }
    5984:	1101                	addi	sp,sp,-32
    5986:	ec06                	sd	ra,24(sp)
    5988:	e822                	sd	s0,16(sp)
    598a:	1000                	addi	s0,sp,32
    598c:	feb407a3          	sb	a1,-17(s0)
    5990:	4605                	li	a2,1
    5992:	fef40593          	addi	a1,s0,-17
    5996:	00000097          	auipc	ra,0x0
    599a:	f5e080e7          	jalr	-162(ra) # 58f4 <write>
    599e:	60e2                	ld	ra,24(sp)
    59a0:	6442                	ld	s0,16(sp)
    59a2:	6105                	addi	sp,sp,32
    59a4:	8082                	ret

00000000000059a6 <printint>:

static void printint(int fd, int xx, int base, int sgn) {
    59a6:	7139                	addi	sp,sp,-64
    59a8:	fc06                	sd	ra,56(sp)
    59aa:	f822                	sd	s0,48(sp)
    59ac:	f426                	sd	s1,40(sp)
    59ae:	0080                	addi	s0,sp,64
    59b0:	84aa                	mv	s1,a0
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if (sgn && xx < 0) {
    59b2:	c299                	beqz	a3,59b8 <printint+0x12>
    59b4:	0805cb63          	bltz	a1,5a4a <printint+0xa4>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    59b8:	2581                	sext.w	a1,a1
    neg = 0;
    59ba:	4881                	li	a7,0
    59bc:	fc040693          	addi	a3,s0,-64
    }

    i = 0;
    59c0:	4701                	li	a4,0
    do {
        buf[i++] = digits[x % base];
    59c2:	2601                	sext.w	a2,a2
    59c4:	00003517          	auipc	a0,0x3
    59c8:	c7c50513          	addi	a0,a0,-900 # 8640 <digits>
    59cc:	883a                	mv	a6,a4
    59ce:	2705                	addiw	a4,a4,1
    59d0:	02c5f7bb          	remuw	a5,a1,a2
    59d4:	1782                	slli	a5,a5,0x20
    59d6:	9381                	srli	a5,a5,0x20
    59d8:	97aa                	add	a5,a5,a0
    59da:	0007c783          	lbu	a5,0(a5)
    59de:	00f68023          	sb	a5,0(a3)
    } while ((x /= base) != 0);
    59e2:	0005879b          	sext.w	a5,a1
    59e6:	02c5d5bb          	divuw	a1,a1,a2
    59ea:	0685                	addi	a3,a3,1
    59ec:	fec7f0e3          	bgeu	a5,a2,59cc <printint+0x26>
    if (neg)
    59f0:	00088c63          	beqz	a7,5a08 <printint+0x62>
        buf[i++] = '-';
    59f4:	fd070793          	addi	a5,a4,-48
    59f8:	00878733          	add	a4,a5,s0
    59fc:	02d00793          	li	a5,45
    5a00:	fef70823          	sb	a5,-16(a4)
    5a04:	0028071b          	addiw	a4,a6,2

    while (--i >= 0)
    5a08:	02e05c63          	blez	a4,5a40 <printint+0x9a>
    5a0c:	f04a                	sd	s2,32(sp)
    5a0e:	ec4e                	sd	s3,24(sp)
    5a10:	fc040793          	addi	a5,s0,-64
    5a14:	00e78933          	add	s2,a5,a4
    5a18:	fff78993          	addi	s3,a5,-1
    5a1c:	99ba                	add	s3,s3,a4
    5a1e:	377d                	addiw	a4,a4,-1
    5a20:	1702                	slli	a4,a4,0x20
    5a22:	9301                	srli	a4,a4,0x20
    5a24:	40e989b3          	sub	s3,s3,a4
        putc(fd, buf[i]);
    5a28:	fff94583          	lbu	a1,-1(s2)
    5a2c:	8526                	mv	a0,s1
    5a2e:	00000097          	auipc	ra,0x0
    5a32:	f56080e7          	jalr	-170(ra) # 5984 <putc>
    while (--i >= 0)
    5a36:	197d                	addi	s2,s2,-1
    5a38:	ff3918e3          	bne	s2,s3,5a28 <printint+0x82>
    5a3c:	7902                	ld	s2,32(sp)
    5a3e:	69e2                	ld	s3,24(sp)
}
    5a40:	70e2                	ld	ra,56(sp)
    5a42:	7442                	ld	s0,48(sp)
    5a44:	74a2                	ld	s1,40(sp)
    5a46:	6121                	addi	sp,sp,64
    5a48:	8082                	ret
        x = -xx;
    5a4a:	40b005bb          	negw	a1,a1
        neg = 1;
    5a4e:	4885                	li	a7,1
        x = -xx;
    5a50:	b7b5                	j	59bc <printint+0x16>

0000000000005a52 <vprintf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void vprintf(int fd, const char *fmt, va_list ap) {
    5a52:	715d                	addi	sp,sp,-80
    5a54:	e486                	sd	ra,72(sp)
    5a56:	e0a2                	sd	s0,64(sp)
    5a58:	f84a                	sd	s2,48(sp)
    5a5a:	0880                	addi	s0,sp,80
    char *s;
    int c, i, state;

    state = 0;
    for (i = 0; fmt[i]; i++) {
    5a5c:	0005c903          	lbu	s2,0(a1)
    5a60:	1a090a63          	beqz	s2,5c14 <vprintf+0x1c2>
    5a64:	fc26                	sd	s1,56(sp)
    5a66:	f44e                	sd	s3,40(sp)
    5a68:	f052                	sd	s4,32(sp)
    5a6a:	ec56                	sd	s5,24(sp)
    5a6c:	e85a                	sd	s6,16(sp)
    5a6e:	e45e                	sd	s7,8(sp)
    5a70:	8aaa                	mv	s5,a0
    5a72:	8bb2                	mv	s7,a2
    5a74:	00158493          	addi	s1,a1,1
    state = 0;
    5a78:	4981                	li	s3,0
            if (c == '%') {
                state = '%';
            } else {
                putc(fd, c);
            }
        } else if (state == '%') {
    5a7a:	02500a13          	li	s4,37
    5a7e:	4b55                	li	s6,21
    5a80:	a839                	j	5a9e <vprintf+0x4c>
                putc(fd, c);
    5a82:	85ca                	mv	a1,s2
    5a84:	8556                	mv	a0,s5
    5a86:	00000097          	auipc	ra,0x0
    5a8a:	efe080e7          	jalr	-258(ra) # 5984 <putc>
    5a8e:	a019                	j	5a94 <vprintf+0x42>
        } else if (state == '%') {
    5a90:	01498d63          	beq	s3,s4,5aaa <vprintf+0x58>
    for (i = 0; fmt[i]; i++) {
    5a94:	0485                	addi	s1,s1,1
    5a96:	fff4c903          	lbu	s2,-1(s1)
    5a9a:	16090763          	beqz	s2,5c08 <vprintf+0x1b6>
        if (state == 0) {
    5a9e:	fe0999e3          	bnez	s3,5a90 <vprintf+0x3e>
            if (c == '%') {
    5aa2:	ff4910e3          	bne	s2,s4,5a82 <vprintf+0x30>
                state = '%';
    5aa6:	89d2                	mv	s3,s4
    5aa8:	b7f5                	j	5a94 <vprintf+0x42>
            if (c == 'd') {
    5aaa:	13490463          	beq	s2,s4,5bd2 <vprintf+0x180>
    5aae:	f9d9079b          	addiw	a5,s2,-99
    5ab2:	0ff7f793          	zext.b	a5,a5
    5ab6:	12fb6763          	bltu	s6,a5,5be4 <vprintf+0x192>
    5aba:	f9d9079b          	addiw	a5,s2,-99
    5abe:	0ff7f713          	zext.b	a4,a5
    5ac2:	12eb6163          	bltu	s6,a4,5be4 <vprintf+0x192>
    5ac6:	00271793          	slli	a5,a4,0x2
    5aca:	00003717          	auipc	a4,0x3
    5ace:	b1e70713          	addi	a4,a4,-1250 # 85e8 <malloc+0x28e4>
    5ad2:	97ba                	add	a5,a5,a4
    5ad4:	439c                	lw	a5,0(a5)
    5ad6:	97ba                	add	a5,a5,a4
    5ad8:	8782                	jr	a5
                printint(fd, va_arg(ap, int), 10, 1);
    5ada:	008b8913          	addi	s2,s7,8
    5ade:	4685                	li	a3,1
    5ae0:	4629                	li	a2,10
    5ae2:	000ba583          	lw	a1,0(s7)
    5ae6:	8556                	mv	a0,s5
    5ae8:	00000097          	auipc	ra,0x0
    5aec:	ebe080e7          	jalr	-322(ra) # 59a6 <printint>
    5af0:	8bca                	mv	s7,s2
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
                putc(fd, c);
            }
            state = 0;
    5af2:	4981                	li	s3,0
    5af4:	b745                	j	5a94 <vprintf+0x42>
                printint(fd, va_arg(ap, uint64), 10, 0);
    5af6:	008b8913          	addi	s2,s7,8
    5afa:	4681                	li	a3,0
    5afc:	4629                	li	a2,10
    5afe:	000ba583          	lw	a1,0(s7)
    5b02:	8556                	mv	a0,s5
    5b04:	00000097          	auipc	ra,0x0
    5b08:	ea2080e7          	jalr	-350(ra) # 59a6 <printint>
    5b0c:	8bca                	mv	s7,s2
            state = 0;
    5b0e:	4981                	li	s3,0
    5b10:	b751                	j	5a94 <vprintf+0x42>
                printint(fd, va_arg(ap, int), 16, 0);
    5b12:	008b8913          	addi	s2,s7,8
    5b16:	4681                	li	a3,0
    5b18:	4641                	li	a2,16
    5b1a:	000ba583          	lw	a1,0(s7)
    5b1e:	8556                	mv	a0,s5
    5b20:	00000097          	auipc	ra,0x0
    5b24:	e86080e7          	jalr	-378(ra) # 59a6 <printint>
    5b28:	8bca                	mv	s7,s2
            state = 0;
    5b2a:	4981                	li	s3,0
    5b2c:	b7a5                	j	5a94 <vprintf+0x42>
    5b2e:	e062                	sd	s8,0(sp)
                printptr(fd, va_arg(ap, uint64));
    5b30:	008b8c13          	addi	s8,s7,8
    5b34:	000bb983          	ld	s3,0(s7)
    putc(fd, '0');
    5b38:	03000593          	li	a1,48
    5b3c:	8556                	mv	a0,s5
    5b3e:	00000097          	auipc	ra,0x0
    5b42:	e46080e7          	jalr	-442(ra) # 5984 <putc>
    putc(fd, 'x');
    5b46:	07800593          	li	a1,120
    5b4a:	8556                	mv	a0,s5
    5b4c:	00000097          	auipc	ra,0x0
    5b50:	e38080e7          	jalr	-456(ra) # 5984 <putc>
    5b54:	4941                	li	s2,16
        putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5b56:	00003b97          	auipc	s7,0x3
    5b5a:	aeab8b93          	addi	s7,s7,-1302 # 8640 <digits>
    5b5e:	03c9d793          	srli	a5,s3,0x3c
    5b62:	97de                	add	a5,a5,s7
    5b64:	0007c583          	lbu	a1,0(a5)
    5b68:	8556                	mv	a0,s5
    5b6a:	00000097          	auipc	ra,0x0
    5b6e:	e1a080e7          	jalr	-486(ra) # 5984 <putc>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    5b72:	0992                	slli	s3,s3,0x4
    5b74:	397d                	addiw	s2,s2,-1
    5b76:	fe0914e3          	bnez	s2,5b5e <vprintf+0x10c>
                printptr(fd, va_arg(ap, uint64));
    5b7a:	8be2                	mv	s7,s8
            state = 0;
    5b7c:	4981                	li	s3,0
    5b7e:	6c02                	ld	s8,0(sp)
    5b80:	bf11                	j	5a94 <vprintf+0x42>
                s = va_arg(ap, char *);
    5b82:	008b8993          	addi	s3,s7,8
    5b86:	000bb903          	ld	s2,0(s7)
                if (s == 0)
    5b8a:	02090163          	beqz	s2,5bac <vprintf+0x15a>
                while (*s != 0) {
    5b8e:	00094583          	lbu	a1,0(s2)
    5b92:	c9a5                	beqz	a1,5c02 <vprintf+0x1b0>
                    putc(fd, *s);
    5b94:	8556                	mv	a0,s5
    5b96:	00000097          	auipc	ra,0x0
    5b9a:	dee080e7          	jalr	-530(ra) # 5984 <putc>
                    s++;
    5b9e:	0905                	addi	s2,s2,1
                while (*s != 0) {
    5ba0:	00094583          	lbu	a1,0(s2)
    5ba4:	f9e5                	bnez	a1,5b94 <vprintf+0x142>
                s = va_arg(ap, char *);
    5ba6:	8bce                	mv	s7,s3
            state = 0;
    5ba8:	4981                	li	s3,0
    5baa:	b5ed                	j	5a94 <vprintf+0x42>
                    s = "(null)";
    5bac:	00002917          	auipc	s2,0x2
    5bb0:	62490913          	addi	s2,s2,1572 # 81d0 <malloc+0x24cc>
                while (*s != 0) {
    5bb4:	02800593          	li	a1,40
    5bb8:	bff1                	j	5b94 <vprintf+0x142>
                putc(fd, va_arg(ap, uint));
    5bba:	008b8913          	addi	s2,s7,8
    5bbe:	000bc583          	lbu	a1,0(s7)
    5bc2:	8556                	mv	a0,s5
    5bc4:	00000097          	auipc	ra,0x0
    5bc8:	dc0080e7          	jalr	-576(ra) # 5984 <putc>
    5bcc:	8bca                	mv	s7,s2
            state = 0;
    5bce:	4981                	li	s3,0
    5bd0:	b5d1                	j	5a94 <vprintf+0x42>
                putc(fd, c);
    5bd2:	02500593          	li	a1,37
    5bd6:	8556                	mv	a0,s5
    5bd8:	00000097          	auipc	ra,0x0
    5bdc:	dac080e7          	jalr	-596(ra) # 5984 <putc>
            state = 0;
    5be0:	4981                	li	s3,0
    5be2:	bd4d                	j	5a94 <vprintf+0x42>
                putc(fd, '%');
    5be4:	02500593          	li	a1,37
    5be8:	8556                	mv	a0,s5
    5bea:	00000097          	auipc	ra,0x0
    5bee:	d9a080e7          	jalr	-614(ra) # 5984 <putc>
                putc(fd, c);
    5bf2:	85ca                	mv	a1,s2
    5bf4:	8556                	mv	a0,s5
    5bf6:	00000097          	auipc	ra,0x0
    5bfa:	d8e080e7          	jalr	-626(ra) # 5984 <putc>
            state = 0;
    5bfe:	4981                	li	s3,0
    5c00:	bd51                	j	5a94 <vprintf+0x42>
                s = va_arg(ap, char *);
    5c02:	8bce                	mv	s7,s3
            state = 0;
    5c04:	4981                	li	s3,0
    5c06:	b579                	j	5a94 <vprintf+0x42>
    5c08:	74e2                	ld	s1,56(sp)
    5c0a:	79a2                	ld	s3,40(sp)
    5c0c:	7a02                	ld	s4,32(sp)
    5c0e:	6ae2                	ld	s5,24(sp)
    5c10:	6b42                	ld	s6,16(sp)
    5c12:	6ba2                	ld	s7,8(sp)
        }
    }
}
    5c14:	60a6                	ld	ra,72(sp)
    5c16:	6406                	ld	s0,64(sp)
    5c18:	7942                	ld	s2,48(sp)
    5c1a:	6161                	addi	sp,sp,80
    5c1c:	8082                	ret

0000000000005c1e <fprintf>:

void fprintf(int fd, const char *fmt, ...) {
    5c1e:	715d                	addi	sp,sp,-80
    5c20:	ec06                	sd	ra,24(sp)
    5c22:	e822                	sd	s0,16(sp)
    5c24:	1000                	addi	s0,sp,32
    5c26:	e010                	sd	a2,0(s0)
    5c28:	e414                	sd	a3,8(s0)
    5c2a:	e818                	sd	a4,16(s0)
    5c2c:	ec1c                	sd	a5,24(s0)
    5c2e:	03043023          	sd	a6,32(s0)
    5c32:	03143423          	sd	a7,40(s0)
    va_list ap;

    va_start(ap, fmt);
    5c36:	fe843423          	sd	s0,-24(s0)
    vprintf(fd, fmt, ap);
    5c3a:	8622                	mv	a2,s0
    5c3c:	00000097          	auipc	ra,0x0
    5c40:	e16080e7          	jalr	-490(ra) # 5a52 <vprintf>
}
    5c44:	60e2                	ld	ra,24(sp)
    5c46:	6442                	ld	s0,16(sp)
    5c48:	6161                	addi	sp,sp,80
    5c4a:	8082                	ret

0000000000005c4c <printf>:

void printf(const char *fmt, ...) {
    5c4c:	711d                	addi	sp,sp,-96
    5c4e:	ec06                	sd	ra,24(sp)
    5c50:	e822                	sd	s0,16(sp)
    5c52:	1000                	addi	s0,sp,32
    5c54:	e40c                	sd	a1,8(s0)
    5c56:	e810                	sd	a2,16(s0)
    5c58:	ec14                	sd	a3,24(s0)
    5c5a:	f018                	sd	a4,32(s0)
    5c5c:	f41c                	sd	a5,40(s0)
    5c5e:	03043823          	sd	a6,48(s0)
    5c62:	03143c23          	sd	a7,56(s0)
    va_list ap;

    va_start(ap, fmt);
    5c66:	00840613          	addi	a2,s0,8
    5c6a:	fec43423          	sd	a2,-24(s0)
    vprintf(1, fmt, ap);
    5c6e:	85aa                	mv	a1,a0
    5c70:	4505                	li	a0,1
    5c72:	00000097          	auipc	ra,0x0
    5c76:	de0080e7          	jalr	-544(ra) # 5a52 <vprintf>
}
    5c7a:	60e2                	ld	ra,24(sp)
    5c7c:	6442                	ld	s0,16(sp)
    5c7e:	6125                	addi	sp,sp,96
    5c80:	8082                	ret

0000000000005c82 <free>:
typedef union header Header;

static Header base;
static Header *freep;

void free(void *ap) {
    5c82:	1141                	addi	sp,sp,-16
    5c84:	e422                	sd	s0,8(sp)
    5c86:	0800                	addi	s0,sp,16
    Header *bp, *p;

    bp = (Header *)ap - 1;
    5c88:	ff050693          	addi	a3,a0,-16
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5c8c:	00004797          	auipc	a5,0x4
    5c90:	c347b783          	ld	a5,-972(a5) # 98c0 <freep>
    5c94:	a02d                	j	5cbe <free+0x3c>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
            break;
    if (bp + bp->s.size == p->s.ptr) {
        bp->s.size += p->s.ptr->s.size;
    5c96:	4618                	lw	a4,8(a2)
    5c98:	9f2d                	addw	a4,a4,a1
    5c9a:	fee52c23          	sw	a4,-8(a0)
        bp->s.ptr = p->s.ptr->s.ptr;
    5c9e:	6398                	ld	a4,0(a5)
    5ca0:	6310                	ld	a2,0(a4)
    5ca2:	a83d                	j	5ce0 <free+0x5e>
    } else
        bp->s.ptr = p->s.ptr;
    if (p + p->s.size == bp) {
        p->s.size += bp->s.size;
    5ca4:	ff852703          	lw	a4,-8(a0)
    5ca8:	9f31                	addw	a4,a4,a2
    5caa:	c798                	sw	a4,8(a5)
        p->s.ptr = bp->s.ptr;
    5cac:	ff053683          	ld	a3,-16(a0)
    5cb0:	a091                	j	5cf4 <free+0x72>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5cb2:	6398                	ld	a4,0(a5)
    5cb4:	00e7e463          	bltu	a5,a4,5cbc <free+0x3a>
    5cb8:	00e6ea63          	bltu	a3,a4,5ccc <free+0x4a>
void free(void *ap) {
    5cbc:	87ba                	mv	a5,a4
    for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5cbe:	fed7fae3          	bgeu	a5,a3,5cb2 <free+0x30>
    5cc2:	6398                	ld	a4,0(a5)
    5cc4:	00e6e463          	bltu	a3,a4,5ccc <free+0x4a>
        if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5cc8:	fee7eae3          	bltu	a5,a4,5cbc <free+0x3a>
    if (bp + bp->s.size == p->s.ptr) {
    5ccc:	ff852583          	lw	a1,-8(a0)
    5cd0:	6390                	ld	a2,0(a5)
    5cd2:	02059813          	slli	a6,a1,0x20
    5cd6:	01c85713          	srli	a4,a6,0x1c
    5cda:	9736                	add	a4,a4,a3
    5cdc:	fae60de3          	beq	a2,a4,5c96 <free+0x14>
        bp->s.ptr = p->s.ptr->s.ptr;
    5ce0:	fec53823          	sd	a2,-16(a0)
    if (p + p->s.size == bp) {
    5ce4:	4790                	lw	a2,8(a5)
    5ce6:	02061593          	slli	a1,a2,0x20
    5cea:	01c5d713          	srli	a4,a1,0x1c
    5cee:	973e                	add	a4,a4,a5
    5cf0:	fae68ae3          	beq	a3,a4,5ca4 <free+0x22>
        p->s.ptr = bp->s.ptr;
    5cf4:	e394                	sd	a3,0(a5)
    } else
        p->s.ptr = bp;
    freep = p;
    5cf6:	00004717          	auipc	a4,0x4
    5cfa:	bcf73523          	sd	a5,-1078(a4) # 98c0 <freep>
}
    5cfe:	6422                	ld	s0,8(sp)
    5d00:	0141                	addi	sp,sp,16
    5d02:	8082                	ret

0000000000005d04 <malloc>:
    hp->s.size = nu;
    free((void *)(hp + 1));
    return freep;
}

void *malloc(uint nbytes) {
    5d04:	7139                	addi	sp,sp,-64
    5d06:	fc06                	sd	ra,56(sp)
    5d08:	f822                	sd	s0,48(sp)
    5d0a:	f426                	sd	s1,40(sp)
    5d0c:	ec4e                	sd	s3,24(sp)
    5d0e:	0080                	addi	s0,sp,64
    Header *p, *prevp;
    uint nunits;

    nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;
    5d10:	02051493          	slli	s1,a0,0x20
    5d14:	9081                	srli	s1,s1,0x20
    5d16:	04bd                	addi	s1,s1,15
    5d18:	8091                	srli	s1,s1,0x4
    5d1a:	0014899b          	addiw	s3,s1,1
    5d1e:	0485                	addi	s1,s1,1
    if ((prevp = freep) == 0) {
    5d20:	00004517          	auipc	a0,0x4
    5d24:	ba053503          	ld	a0,-1120(a0) # 98c0 <freep>
    5d28:	c915                	beqz	a0,5d5c <malloc+0x58>
        base.s.ptr = freep = prevp = &base;
        base.s.size = 0;
    }
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
    5d2a:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits) {
    5d2c:	4798                	lw	a4,8(a5)
    5d2e:	08977e63          	bgeu	a4,s1,5dca <malloc+0xc6>
    5d32:	f04a                	sd	s2,32(sp)
    5d34:	e852                	sd	s4,16(sp)
    5d36:	e456                	sd	s5,8(sp)
    5d38:	e05a                	sd	s6,0(sp)
    if (nu < 4096)
    5d3a:	8a4e                	mv	s4,s3
    5d3c:	0009871b          	sext.w	a4,s3
    5d40:	6685                	lui	a3,0x1
    5d42:	00d77363          	bgeu	a4,a3,5d48 <malloc+0x44>
    5d46:	6a05                	lui	s4,0x1
    5d48:	000a0b1b          	sext.w	s6,s4
    p = sbrk(nu * sizeof(Header));
    5d4c:	004a1a1b          	slliw	s4,s4,0x4
                p->s.size = nunits;
            }
            freep = prevp;
            return (void *)(p + 1);
        }
        if (p == freep)
    5d50:	00004917          	auipc	s2,0x4
    5d54:	b7090913          	addi	s2,s2,-1168 # 98c0 <freep>
    if (p == (char *)-1)
    5d58:	5afd                	li	s5,-1
    5d5a:	a091                	j	5d9e <malloc+0x9a>
    5d5c:	f04a                	sd	s2,32(sp)
    5d5e:	e852                	sd	s4,16(sp)
    5d60:	e456                	sd	s5,8(sp)
    5d62:	e05a                	sd	s6,0(sp)
        base.s.ptr = freep = prevp = &base;
    5d64:	0000a797          	auipc	a5,0xa
    5d68:	37c78793          	addi	a5,a5,892 # 100e0 <base>
    5d6c:	00004717          	auipc	a4,0x4
    5d70:	b4f73a23          	sd	a5,-1196(a4) # 98c0 <freep>
    5d74:	e39c                	sd	a5,0(a5)
        base.s.size = 0;
    5d76:	0007a423          	sw	zero,8(a5)
        if (p->s.size >= nunits) {
    5d7a:	b7c1                	j	5d3a <malloc+0x36>
                prevp->s.ptr = p->s.ptr;
    5d7c:	6398                	ld	a4,0(a5)
    5d7e:	e118                	sd	a4,0(a0)
    5d80:	a08d                	j	5de2 <malloc+0xde>
    hp->s.size = nu;
    5d82:	01652423          	sw	s6,8(a0)
    free((void *)(hp + 1));
    5d86:	0541                	addi	a0,a0,16
    5d88:	00000097          	auipc	ra,0x0
    5d8c:	efa080e7          	jalr	-262(ra) # 5c82 <free>
    return freep;
    5d90:	00093503          	ld	a0,0(s2)
            if ((p = morecore(nunits)) == 0)
    5d94:	c13d                	beqz	a0,5dfa <malloc+0xf6>
    for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr) {
    5d96:	611c                	ld	a5,0(a0)
        if (p->s.size >= nunits) {
    5d98:	4798                	lw	a4,8(a5)
    5d9a:	02977463          	bgeu	a4,s1,5dc2 <malloc+0xbe>
        if (p == freep)
    5d9e:	00093703          	ld	a4,0(s2)
    5da2:	853e                	mv	a0,a5
    5da4:	fef719e3          	bne	a4,a5,5d96 <malloc+0x92>
    p = sbrk(nu * sizeof(Header));
    5da8:	8552                	mv	a0,s4
    5daa:	00000097          	auipc	ra,0x0
    5dae:	bb2080e7          	jalr	-1102(ra) # 595c <sbrk>
    if (p == (char *)-1)
    5db2:	fd5518e3          	bne	a0,s5,5d82 <malloc+0x7e>
                return 0;
    5db6:	4501                	li	a0,0
    5db8:	7902                	ld	s2,32(sp)
    5dba:	6a42                	ld	s4,16(sp)
    5dbc:	6aa2                	ld	s5,8(sp)
    5dbe:	6b02                	ld	s6,0(sp)
    5dc0:	a03d                	j	5dee <malloc+0xea>
    5dc2:	7902                	ld	s2,32(sp)
    5dc4:	6a42                	ld	s4,16(sp)
    5dc6:	6aa2                	ld	s5,8(sp)
    5dc8:	6b02                	ld	s6,0(sp)
            if (p->s.size == nunits)
    5dca:	fae489e3          	beq	s1,a4,5d7c <malloc+0x78>
                p->s.size -= nunits;
    5dce:	4137073b          	subw	a4,a4,s3
    5dd2:	c798                	sw	a4,8(a5)
                p += p->s.size;
    5dd4:	02071693          	slli	a3,a4,0x20
    5dd8:	01c6d713          	srli	a4,a3,0x1c
    5ddc:	97ba                	add	a5,a5,a4
                p->s.size = nunits;
    5dde:	0137a423          	sw	s3,8(a5)
            freep = prevp;
    5de2:	00004717          	auipc	a4,0x4
    5de6:	aca73f23          	sd	a0,-1314(a4) # 98c0 <freep>
            return (void *)(p + 1);
    5dea:	01078513          	addi	a0,a5,16
    }
}
    5dee:	70e2                	ld	ra,56(sp)
    5df0:	7442                	ld	s0,48(sp)
    5df2:	74a2                	ld	s1,40(sp)
    5df4:	69e2                	ld	s3,24(sp)
    5df6:	6121                	addi	sp,sp,64
    5df8:	8082                	ret
    5dfa:	7902                	ld	s2,32(sp)
    5dfc:	6a42                	ld	s4,16(sp)
    5dfe:	6aa2                	ld	s5,8(sp)
    5e00:	6b02                	ld	s6,0(sp)
    5e02:	b7f5                	j	5dee <malloc+0xea>
