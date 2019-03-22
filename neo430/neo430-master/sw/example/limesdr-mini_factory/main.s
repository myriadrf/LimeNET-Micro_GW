
main.elf:     file format elf32-msp430


Disassembly of section .text:

00000000 <__crt0_begin>:
   0:	18 42 e8 ff 	mov	&0xffe8,r8	;0xffe8
   4:	11 42 ea ff 	mov	&0xffea,r1	;0xffea
   8:	02 43       	clr	r2		;
   a:	01 58       	add	r8,	r1	;
   c:	b2 40 00 47 	mov	#18176,	&0xffb8	;#0x4700
  10:	b8 ff 
  12:	39 40 80 ff 	mov	#-128,	r9	;#0xff80

00000016 <__crt0_clr_io>:
  16:	09 93       	cmp	#0,	r9	;r3 As==00
  18:	04 24       	jz	$+10     	;abs 0x22
  1a:	89 43 00 00 	mov	#0,	0(r9)	;r3 As==00
  1e:	29 53       	incd	r9		;
  20:	fa 3f       	jmp	$-10     	;abs 0x16

00000022 <__crt0_clr_dmem>:
  22:	01 98       	cmp	r8,	r1	;
  24:	04 24       	jz	$+10     	;abs 0x2e
  26:	88 43 00 00 	mov	#0,	0(r8)	;r3 As==00
  2a:	28 53       	incd	r8		;
  2c:	fa 3f       	jmp	$-10     	;abs 0x22

0000002e <__crt0_clr_dmem_end>:
  2e:	35 40 d2 09 	mov	#2514,	r5	;#0x09d2
  32:	36 40 d2 09 	mov	#2514,	r6	;#0x09d2
  36:	37 40 00 80 	mov	#-32768,r7	;#0x8000

0000003a <__crt0_cpy_data>:
  3a:	06 95       	cmp	r5,	r6	;
  3c:	04 24       	jz	$+10     	;abs 0x46
  3e:	b7 45 00 00 	mov	@r5+,	0(r7)	;
  42:	27 53       	incd	r7		;
  44:	fa 3f       	jmp	$-10     	;abs 0x3a

00000046 <__crt0_cpy_data_end>:
  46:	32 40 00 40 	mov	#16384,	r2	;#0x4000
  4a:	04 43       	clr	r4		;
  4c:	0a 43       	clr	r10		;
  4e:	0b 43       	clr	r11		;
  50:	0c 43       	clr	r12		;
  52:	0d 43       	clr	r13		;
  54:	0e 43       	clr	r14		;
  56:	0f 43       	clr	r15		;

00000058 <__crt0_start_main>:
  58:	b0 12 8c 01 	call	#396		;#0x018c

0000005c <__crt0_this_is_the_end>:
  5c:	02 43       	clr	r2		;
  5e:	b2 40 00 47 	mov	#18176,	&0xffb8	;#0x4700
  62:	b8 ff 
  64:	32 40 10 00 	mov	#16,	r2	;#0x0010
  68:	03 43       	nop			

0000006a <wishbone_read32>:
  6a:	b2 40 0f 00 	mov	#15,	&0xff90	;#0x000f
  6e:	90 ff 
  70:	82 4c 92 ff 	mov	r12,	&0xff92	;
  74:	82 4d 94 ff 	mov	r13,	&0xff94	;
  78:	3d 40 90 ff 	mov	#-112,	r13	;#0xff90

0000007c <.L2>:
  7c:	2c 4d       	mov	@r13,	r12	;
  7e:	0c 93       	cmp	#0,	r12	;r3 As==00
  80:	fd 3b       	jl	$-4      	;abs 0x7c
  82:	1c 42 9a ff 	mov	&0xff9a,r12	;0xff9a
  86:	1d 42 9c ff 	mov	&0xff9c,r13	;0xff9c
  8a:	30 41       	ret			

0000008c <wishbone_write32>:
  8c:	b2 40 0f 00 	mov	#15,	&0xff90	;#0x000f
  90:	90 ff 
  92:	82 4e 9a ff 	mov	r14,	&0xff9a	;
  96:	82 4f 9c ff 	mov	r15,	&0xff9c	;
  9a:	82 4c 96 ff 	mov	r12,	&0xff96	;
  9e:	82 4d 98 ff 	mov	r13,	&0xff98	;
  a2:	3d 40 90 ff 	mov	#-112,	r13	;#0xff90

000000a6 <.L5>:
  a6:	2c 4d       	mov	@r13,	r12	;
  a8:	0c 93       	cmp	#0,	r12	;r3 As==00
  aa:	fd 3b       	jl	$-4      	;abs 0xa6
  ac:	30 41       	ret			

000000ae <reverse>:
  ae:	0a 12       	push	r10		;
  b0:	4a 4c       	mov.b	r12,	r10	;
  b2:	0c 4a       	mov	r10,	r12	;
  b4:	b0 12 0a 08 	call	#2058		;#0x080a
  b8:	0a 5a       	rla	r10		;
  ba:	0a 5a       	rla	r10		;
  bc:	0a 5a       	rla	r10		;
  be:	0a 5a       	rla	r10		;
  c0:	4a dc       	bis.b	r12,	r10	;
  c2:	3a f0 ff 00 	and	#255,	r10	;#0x00ff
  c6:	0c 4a       	mov	r10,	r12	;
  c8:	b0 12 84 07 	call	#1924		;#0x0784
  cc:	7c f0 33 00 	and.b	#51,	r12	;#0x0033
  d0:	0a 5a       	rla	r10		;
  d2:	0a 5a       	rla	r10		;
  d4:	7a f0 cc ff 	and.b	#-52,	r10	;#0xffcc
  d8:	4a dc       	bis.b	r12,	r10	;
  da:	3a f0 ff 00 	and	#255,	r10	;#0x00ff
  de:	0c 4a       	mov	r10,	r12	;
  e0:	0c 11       	rra	r12		;
  e2:	7c f0 55 00 	and.b	#85,	r12	;#0x0055
  e6:	0a 5a       	rla	r10		;
  e8:	7a f0 aa ff 	and.b	#-86,	r10	;#0xffaa
  ec:	4c da       	bis.b	r10,	r12	;
  ee:	3a 41       	pop	r10		;
  f0:	30 41       	ret			

000000f2 <uart_set_baud.constprop.2>:
  f2:	0a 12       	push	r10		;
  f4:	1e 42 ec ff 	mov	&0xffec,r14	;0xffec
  f8:	1f 42 ee ff 	mov	&0xffee,r15	;0xffee
  fc:	4c 43       	clr.b	r12		;

000000fe <.L9>:
  fe:	0a 4f       	mov	r15,	r10	;
 100:	0f 93       	cmp	#0,	r15	;r3 As==00
 102:	16 20       	jnz	$+46     	;abs 0x130
 104:	3d 40 ff 95 	mov	#-27137,r13	;#0x95ff
 108:	0d 9e       	cmp	r14,	r13	;
 10a:	12 28       	jnc	$+38     	;abs 0x130

0000010c <.L12>:
 10c:	7d 40 ff 00 	mov.b	#255,	r13	;#0x00ff
 110:	0d 9c       	cmp	r12,	r13	;
 112:	14 28       	jnc	$+42     	;abs 0x13c
 114:	0d 4a       	mov	r10,	r13	;
 116:	0d 5a       	add	r10,	r13	;
 118:	0d 5d       	rla	r13		;
 11a:	0d 5d       	rla	r13		;
 11c:	0d 5d       	rla	r13		;
 11e:	0d 5d       	rla	r13		;
 120:	0d 5d       	rla	r13		;
 122:	0d 5d       	rla	r13		;
 124:	0d 5d       	rla	r13		;
 126:	0d dc       	bis	r12,	r13	;
 128:	82 4d a6 ff 	mov	r13,	&0xffa6	;
 12c:	3a 41       	pop	r10		;
 12e:	30 41       	ret			

00000130 <.L10>:
 130:	3e 50 00 6a 	add	#27136,	r14	;#0x6a00
 134:	3f 63       	addc	#-1,	r15	;r3 As==11
 136:	1c 53       	inc	r12		;
 138:	30 40 fe 00 	br	#0x00fe		;

0000013c <.L16>:
 13c:	6a 93       	cmp.b	#2,	r10	;r3 As==10
 13e:	02 24       	jz	$+6      	;abs 0x144
 140:	6a 92       	cmp.b	#4,	r10	;r2 As==10
 142:	07 20       	jnz	$+16     	;abs 0x152

00000144 <.L13>:
 144:	b0 12 0e 08 	call	#2062		;#0x080e

00000148 <.L15>:
 148:	5a 53       	inc.b	r10		;
 14a:	3a f0 ff 00 	and	#255,	r10	;#0x00ff
 14e:	30 40 0c 01 	br	#0x010c		;

00000152 <.L14>:
 152:	12 c3       	clrc			
 154:	0c 10       	rrc	r12		;
 156:	30 40 48 01 	br	#0x0148		;

0000015a <uart_br_print>:
 15a:	3e 40 a0 ff 	mov	#-96,	r14	;#0xffa0
 15e:	3f 40 a4 ff 	mov	#-92,	r15	;#0xffa4

00000162 <.L22>:
 162:	6d 4c       	mov.b	@r12,	r13	;
 164:	0d 93       	cmp	#0,	r13	;r3 As==00
 166:	01 20       	jnz	$+4      	;abs 0x16a
 168:	30 41       	ret			

0000016a <.L26>:
 16a:	3d 90 0a 00 	cmp	#10,	r13	;#0x000a
 16e:	06 20       	jnz	$+14     	;abs 0x17c

00000170 <.L24>:
 170:	be b2 00 00 	bit	#8,	0(r14)	;r2 As==11
 174:	fd 23       	jnz	$-4      	;abs 0x170
 176:	b2 40 0d 00 	mov	#13,	&0xffa4	;#0x000d
 17a:	a4 ff 

0000017c <.L25>:
 17c:	be b2 00 00 	bit	#8,	0(r14)	;r2 As==11
 180:	fd 23       	jnz	$-4      	;abs 0x17c
 182:	8f 4d 00 00 	mov	r13,	0(r15)	;
 186:	1c 53       	inc	r12		;
 188:	30 40 62 01 	br	#0x0162		;

0000018c <main>:
 18c:	0a 12       	push	r10		;
 18e:	09 12       	push	r9		;
 190:	08 12       	push	r8		;
 192:	07 12       	push	r7		;
 194:	06 12       	push	r6		;
 196:	05 12       	push	r5		;
 198:	04 12       	push	r4		;
 19a:	31 82       	sub	#8,	r1	;r2 As==11
 19c:	39 40 f2 00 	mov	#242,	r9	;#0x00f2
 1a0:	89 12       	call	r9		;
 1a2:	92 43 a0 ff 	mov	#1,	&0xffa0	;r3 As==01
 1a6:	3a 40 8c 00 	mov	#140,	r10	;#0x008c
 1aa:	5e 43       	mov.b	#1,	r14	;r3 As==01
 1ac:	4f 43       	clr.b	r15		;
 1ae:	3c 40 0c 04 	mov	#1036,	r12	;#0x040c
 1b2:	4d 43       	clr.b	r13		;
 1b4:	8a 12       	call	r10		;
 1b6:	4e 43       	clr.b	r14		;
 1b8:	4f 43       	clr.b	r15		;
 1ba:	3c 40 0c 04 	mov	#1036,	r12	;#0x040c
 1be:	4d 43       	clr.b	r13		;
 1c0:	8a 12       	call	r10		;
 1c2:	89 12       	call	r9		;
 1c4:	92 43 a0 ff 	mov	#1,	&0xffa0	;r3 As==01
 1c8:	39 40 5a 01 	mov	#346,	r9	;#0x015a
 1cc:	3c 40 a6 08 	mov	#2214,	r12	;#0x08a6
 1d0:	89 12       	call	r9		;
 1d2:	4e 43       	clr.b	r14		;
 1d4:	4f 43       	clr.b	r15		;
 1d6:	7c 40 68 00 	mov.b	#104,	r12	;#0x0068
 1da:	4d 43       	clr.b	r13		;
 1dc:	8a 12       	call	r10		;
 1de:	5e 43       	mov.b	#1,	r14	;r3 As==01
 1e0:	4f 43       	clr.b	r15		;
 1e2:	7c 40 70 00 	mov.b	#112,	r12	;#0x0070
 1e6:	4d 43       	clr.b	r13		;
 1e8:	8a 12       	call	r10		;
 1ea:	7e 40 3c 00 	mov.b	#60,	r14	;#0x003c
 1ee:	4f 43       	clr.b	r15		;
 1f0:	7c 40 60 00 	mov.b	#96,	r12	;#0x0060
 1f4:	4d 43       	clr.b	r13		;
 1f6:	8a 12       	call	r10		;
 1f8:	4e 43       	clr.b	r14		;
 1fa:	4f 43       	clr.b	r15		;
 1fc:	7c 40 64 00 	mov.b	#100,	r12	;#0x0064
 200:	4d 43       	clr.b	r13		;
 202:	8a 12       	call	r10		;
 204:	7e 40 80 00 	mov.b	#128,	r14	;#0x0080
 208:	4f 43       	clr.b	r15		;
 20a:	7c 40 68 00 	mov.b	#104,	r12	;#0x0068
 20e:	4d 43       	clr.b	r13		;
 210:	8a 12       	call	r10		;
 212:	b2 b2 e2 ff 	bit	#8,	&0xffe2	;r2 As==11
 216:	02 20       	jnz	$+6      	;abs 0x21c
 218:	30 40 d8 06 	br	#0x06d8		;
 21c:	44 43       	clr.b	r4		;
 21e:	45 43       	clr.b	r5		;
 220:	4a 43       	clr.b	r10		;
 222:	81 4a 02 00 	mov	r10,	2(r1)	;

00000226 <.L30>:
 226:	39 40 6a 00 	mov	#106,	r9	;#0x006a
 22a:	07 49       	mov	r9,	r7	;

0000022c <.L31>:
 22c:	3c 40 08 04 	mov	#1032,	r12	;#0x0408
 230:	4d 43       	clr.b	r13		;
 232:	89 12       	call	r9		;
 234:	1c b3       	bit	#1,	r12	;r3 As==01
 236:	fa 23       	jnz	$-10     	;abs 0x22c
 238:	b1 40 40 80 	mov	#-32704,0(r1)	;#0x8040
 23c:	00 00 
 23e:	29 41       	mov	@r1,	r9	;
 240:	39 50 40 00 	add	#64,	r9	;#0x0040
 244:	28 41       	mov	@r1,	r8	;

00000246 <.L32>:
 246:	3c 40 08 04 	mov	#1032,	r12	;#0x0408
 24a:	4d 43       	clr.b	r13		;
 24c:	87 12       	call	r7		;
 24e:	06 4c       	mov	r12,	r6	;
 250:	56 f3       	and.b	#1,	r6	;r3 As==01
 252:	06 93       	cmp	#0,	r6	;r3 As==00
 254:	f8 23       	jnz	$-14     	;abs 0x246
 256:	3c 40 04 04 	mov	#1028,	r12	;#0x0404
 25a:	4d 43       	clr.b	r13		;
 25c:	87 12       	call	r7		;
 25e:	2e 41       	mov	@r1,	r14	;
 260:	8e 4c 00 00 	mov	r12,	0(r14)	;
 264:	8e 4d 02 00 	mov	r13,	2(r14)	;
 268:	2e 52       	add	#4,	r14	;r2 As==10
 26a:	81 4e 00 00 	mov	r14,	0(r1)	;
 26e:	09 9e       	cmp	r14,	r9	;
 270:	ea 23       	jnz	$-42     	;abs 0x246
 272:	7e 40 3c 00 	mov.b	#60,	r14	;#0x003c
 276:	0d 46       	mov	r6,	r13	;
 278:	3c 40 04 80 	mov	#-32764,r12	;#0x8004
 27c:	b0 12 92 08 	call	#2194		;#0x0892
 280:	6c 48       	mov.b	@r8,	r12	;
 282:	3d 40 00 80 	mov	#-32768,r13	;#0x8000
 286:	cd 4c 00 00 	mov.b	r12,	0(r13)	;
 28a:	dd 48 02 00 	mov.b	2(r8),	2(r13)	;
 28e:	02 00 
 290:	dd 48 03 00 	mov.b	3(r8),	3(r13)	;
 294:	03 00 
 296:	f2 40 03 00 	mov.b	#3,	&0x8001	;
 29a:	01 80 
 29c:	4c 93       	cmp.b	#0,	r12	;r3 As==00
 29e:	0b 24       	jz	$+24     	;abs 0x2b6
 2a0:	7c 90 53 00 	cmp.b	#83,	r12	;#0x0053
 2a4:	18 24       	jz	$+50     	;abs 0x2d6
 2a6:	3c 40 a5 09 	mov	#2469,	r12	;#0x09a5
 2aa:	b0 12 5a 01 	call	#346		;#0x015a
 2ae:	e2 43 01 80 	mov.b	#2,	&0x8001	;r3 As==10
 2b2:	30 40 f8 02 	br	#0x02f8		;

000002b6 <.L35>:
 2b6:	e2 43 08 80 	mov.b	#2,	&0x8008	;r3 As==10
 2ba:	f2 40 16 00 	mov.b	#22,	&0x8009	;#0x0016
 2be:	09 80 
 2c0:	d2 43 0a 80 	mov.b	#1,	&0x800a	;r3 As==01
 2c4:	f2 40 03 00 	mov.b	#3,	&0x800b	;
 2c8:	0b 80 
 2ca:	d2 43 0c 80 	mov.b	#1,	&0x800c	;r3 As==01

000002ce <.L99>:
 2ce:	d2 43 01 80 	mov.b	#1,	&0x8001	;r3 As==01
 2d2:	30 40 f8 02 	br	#0x02f8		;

000002d6 <.L36>:
 2d6:	5c 48 08 00 	mov.b	8(r8),	r12	;
 2da:	5c 93       	cmp.b	#1,	r12	;r3 As==01
 2dc:	3f 24       	jz	$+128    	;abs 0x35c
 2de:	4c 93       	cmp.b	#0,	r12	;r3 As==00
 2e0:	08 24       	jz	$+18     	;abs 0x2f2
 2e2:	6c 93       	cmp.b	#2,	r12	;r3 As==10
 2e4:	f4 23       	jnz	$-22     	;abs 0x2ce
 2e6:	d2 43 01 80 	mov.b	#1,	&0x8001	;r3 As==01
 2ea:	91 43 02 00 	mov	#1,	2(r1)	;r3 As==01
 2ee:	30 40 f8 02 	br	#0x02f8		;

000002f2 <.L40>:
 2f2:	f2 40 05 00 	mov.b	#5,	&0x8001	;
 2f6:	01 80 

000002f8 <.L37>:
 2f8:	49 43       	clr.b	r9		;
 2fa:	38 40 00 80 	mov	#-32768,r8	;#0x8000
 2fe:	36 40 8c 00 	mov	#140,	r6	;#0x008c
 302:	07 46       	mov	r6,	r7	;

00000304 <.L69>:
 304:	0c 49       	mov	r9,	r12	;
 306:	0c 59       	add	r9,	r12	;
 308:	0c 5c       	rla	r12		;
 30a:	0c 58       	add	r8,	r12	;
 30c:	2e 4c       	mov	@r12,	r14	;
 30e:	1f 4c 02 00 	mov	2(r12),	r15	;
 312:	3c 40 00 04 	mov	#1024,	r12	;#0x0400
 316:	4d 43       	clr.b	r13		;
 318:	86 12       	call	r6		;
 31a:	19 53       	inc	r9		;
 31c:	39 90 10 00 	cmp	#16,	r9	;#0x0010
 320:	f1 23       	jnz	$-28     	;abs 0x304
 322:	81 93 02 00 	cmp	#0,	2(r1)	;r3 As==00
 326:	7f 27       	jz	$-256    	;abs 0x226
 328:	5e 43       	mov.b	#1,	r14	;r3 As==01
 32a:	4f 43       	clr.b	r15		;
 32c:	7c 40 24 00 	mov.b	#36,	r12	;#0x0024
 330:	4d 43       	clr.b	r13		;
 332:	86 12       	call	r6		;
 334:	36 40 6a 00 	mov	#106,	r6	;#0x006a
 338:	78 40 2c 00 	mov.b	#44,	r8	;#0x002c
 33c:	49 43       	clr.b	r9		;

0000033e <.L71>:
 33e:	0c 48       	mov	r8,	r12	;
 340:	0d 49       	mov	r9,	r13	;
 342:	86 12       	call	r6		;
 344:	1c 93       	cmp	#1,	r12	;r3 As==01
 346:	02 20       	jnz	$+6      	;abs 0x34c
 348:	0d 93       	cmp	#0,	r13	;r3 As==00
 34a:	f9 27       	jz	$-12     	;abs 0x33e

0000034c <.L82>:
 34c:	5e 43       	mov.b	#1,	r14	;r3 As==01
 34e:	4f 43       	clr.b	r15		;
 350:	7c 40 20 00 	mov.b	#32,	r12	;#0x0020
 354:	4d 43       	clr.b	r13		;
 356:	87 12       	call	r7		;
 358:	30 40 26 02 	br	#0x0226		;

0000035c <.L39>:
 35c:	5c 48 09 00 	mov.b	9(r8),	r12	;
 360:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
 364:	0d 43       	clr	r13		;
 366:	7e 40 18 00 	mov.b	#24,	r14	;#0x0018
 36a:	b0 12 64 07 	call	#1892		;#0x0764
 36e:	09 4c       	mov	r12,	r9	;
 370:	06 4d       	mov	r13,	r6	;
 372:	5c 48 0a 00 	mov.b	10(r8),	r12	;0x0000a
 376:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
 37a:	0d 43       	clr	r13		;
 37c:	7e 40 10 00 	mov.b	#16,	r14	;#0x0010
 380:	b0 12 64 07 	call	#1892		;#0x0764
 384:	0c d9       	bis	r9,	r12	;
 386:	0d d6       	bis	r6,	r13	;
 388:	5e 48 0c 00 	mov.b	12(r8),	r14	;0x0000c
 38c:	0c de       	bis	r14,	r12	;
 38e:	5e 48 0b 00 	mov.b	11(r8),	r14	;0x0000b
 392:	3e f0 ff 00 	and	#255,	r14	;#0x00ff
 396:	0f 43       	clr	r15		;
 398:	0e 5e       	rla	r14		;
 39a:	0f 6f       	rlc	r15		;
 39c:	0e 5e       	rla	r14		;
 39e:	0f 6f       	rlc	r15		;
 3a0:	0e 5e       	rla	r14		;
 3a2:	0f 6f       	rlc	r15		;
 3a4:	0e 5e       	rla	r14		;
 3a6:	0f 6f       	rlc	r15		;
 3a8:	0e 5e       	rla	r14		;
 3aa:	0f 6f       	rlc	r15		;
 3ac:	0e 5e       	rla	r14		;
 3ae:	0f 6f       	rlc	r15		;
 3b0:	0e 5e       	rla	r14		;
 3b2:	0f 6f       	rlc	r15		;
 3b4:	0e 5e       	rla	r14		;
 3b6:	0f 6f       	rlc	r15		;
 3b8:	0e dc       	bis	r12,	r14	;
 3ba:	0d df       	bis	r15,	r13	;
 3bc:	0d de       	bis	r14,	r13	;
 3be:	0d 93       	cmp	#0,	r13	;r3 As==00
 3c0:	02 20       	jnz	$+6      	;abs 0x3c6
 3c2:	7a 40 0a 00 	mov.b	#10,	r10	;#0x000a

000003c6 <.L42>:
 3c6:	c2 93 4d 80 	cmp.b	#0,	&0x804d	;r3 As==00
 3ca:	77 25       	jz	$+752    	;abs 0x6ba
 3cc:	78 40 40 00 	mov.b	#64,	r8	;#0x0040
 3d0:	49 43       	clr.b	r9		;
 3d2:	36 40 5a 01 	mov	#346,	r6	;#0x015a

000003d6 <.L73>:
 3d6:	4c 4a       	mov.b	r10,	r12	;
 3d8:	7a 90 0e 00 	cmp.b	#14,	r10	;#0x000e
 3dc:	a6 24       	jz	$+334    	;abs 0x52a
 3de:	7d 40 0e 00 	mov.b	#14,	r13	;#0x000e
 3e2:	4d 9a       	cmp.b	r10,	r13	;
 3e4:	4c 28       	jnc	$+154    	;abs 0x47e
 3e6:	7a 90 0b 00 	cmp.b	#11,	r10	;#0x000b
 3ea:	18 24       	jz	$+50     	;abs 0x41c
 3ec:	3a 40 8c 00 	mov	#140,	r10	;#0x008c
 3f0:	7c 90 0d 00 	cmp.b	#13,	r12	;#0x000d
 3f4:	8c 24       	jz	$+282    	;abs 0x50e
 3f6:	7c 90 0a 00 	cmp.b	#10,	r12	;#0x000a
 3fa:	3b 20       	jnz	$+120    	;abs 0x472
 3fc:	3e 43       	mov	#-1,	r14	;r3 As==11
 3fe:	3f 40 7f f6 	mov	#-2433,	r15	;#0xf67f
 402:	7c 40 44 00 	mov.b	#68,	r12	;#0x0044
 406:	4d 43       	clr.b	r13		;
 408:	8a 12       	call	r10		;
 40a:	3e 43       	mov	#-1,	r14	;r3 As==11
 40c:	3f 40 5f f6 	mov	#-2465,	r15	;#0xf65f
 410:	7c 40 44 00 	mov.b	#68,	r12	;#0x0044
 414:	4d 43       	clr.b	r13		;
 416:	8a 12       	call	r10		;
 418:	44 43       	clr.b	r4		;
 41a:	45 43       	clr.b	r5		;

0000041c <.L47>:
 41c:	0c 48       	mov	r8,	r12	;
 41e:	0d 49       	mov	r9,	r13	;
 420:	87 12       	call	r7		;
 422:	7c f0 13 00 	and.b	#19,	r12	;#0x0013
 426:	3c 90 10 00 	cmp	#16,	r12	;#0x0010
 42a:	6d 20       	jnz	$+220    	;abs 0x506
 42c:	3e 43       	mov	#-1,	r14	;r3 As==11
 42e:	3f 40 7f f6 	mov	#-2433,	r15	;#0xf67f
 432:	7c 40 44 00 	mov.b	#68,	r12	;#0x0044
 436:	4d 43       	clr.b	r13		;
 438:	b0 12 8c 00 	call	#140		;#0x008c
 43c:	3c 40 f3 08 	mov	#2291,	r12	;#0x08f3
 440:	86 12       	call	r6		;
 442:	7a 40 0d 00 	mov.b	#13,	r10	;#0x000d

00000446 <.L53>:
 446:	0c 48       	mov	r8,	r12	;
 448:	0d 49       	mov	r9,	r13	;
 44a:	87 12       	call	r7		;
 44c:	7c f0 13 00 	and.b	#19,	r12	;#0x0013
 450:	1c 93       	cmp	#1,	r12	;r3 As==01
 452:	05 20       	jnz	$+12     	;abs 0x45e
 454:	3c 40 00 09 	mov	#2304,	r12	;#0x0900
 458:	86 12       	call	r6		;
 45a:	7a 40 0b 00 	mov.b	#11,	r10	;#0x000b

0000045e <.L54>:
 45e:	0c 48       	mov	r8,	r12	;
 460:	0d 49       	mov	r9,	r13	;
 462:	87 12       	call	r7		;
 464:	3c b0 13 00 	bit	#19,	r12	;#0x0013
 468:	b6 23       	jnz	$-146    	;abs 0x3d6
 46a:	3c 40 0e 09 	mov	#2318,	r12	;#0x090e

0000046e <.L102>:
 46e:	b0 12 5a 01 	call	#346		;#0x015a

00000472 <.L44>:
 472:	f2 40 05 00 	mov.b	#5,	&0x8001	;
 476:	01 80 

00000478 <.L103>:
 478:	4a 43       	clr.b	r10		;
 47a:	30 40 f8 02 	br	#0x02f8		;

0000047e <.L46>:
 47e:	7a 90 11 00 	cmp.b	#17,	r10	;#0x0011
 482:	16 24       	jz	$+46     	;abs 0x4b0
 484:	7a 90 14 00 	cmp.b	#20,	r10	;#0x0014
 488:	82 24       	jz	$+262    	;abs 0x58e
 48a:	7a 90 10 00 	cmp.b	#16,	r10	;#0x0010
 48e:	f1 23       	jnz	$-28     	;abs 0x472
 490:	3a 40 8c 00 	mov	#140,	r10	;#0x008c
 494:	3e 43       	mov	#-1,	r14	;r3 As==11
 496:	3f 40 7f f6 	mov	#-2433,	r15	;#0xf67f
 49a:	7c 40 44 00 	mov.b	#68,	r12	;#0x0044
 49e:	4d 43       	clr.b	r13		;
 4a0:	8a 12       	call	r10		;
 4a2:	3e 43       	mov	#-1,	r14	;r3 As==11
 4a4:	3f 40 2f f6 	mov	#-2513,	r15	;#0xf62f
 4a8:	7c 40 44 00 	mov.b	#68,	r12	;#0x0044
 4ac:	4d 43       	clr.b	r13		;
 4ae:	8a 12       	call	r10		;

000004b0 <.L50>:
 4b0:	0c 48       	mov	r8,	r12	;
 4b2:	0d 49       	mov	r9,	r13	;
 4b4:	87 12       	call	r7		;
 4b6:	7c f0 13 00 	and.b	#19,	r12	;#0x0013
 4ba:	3c 90 10 00 	cmp	#16,	r12	;#0x0010
 4be:	63 20       	jnz	$+200    	;abs 0x586
 4c0:	3e 43       	mov	#-1,	r14	;r3 As==11
 4c2:	3f 40 7f f6 	mov	#-2433,	r15	;#0xf67f
 4c6:	7c 40 44 00 	mov.b	#68,	r12	;#0x0044
 4ca:	4d 43       	clr.b	r13		;
 4cc:	b0 12 8c 00 	call	#140		;#0x008c
 4d0:	3c 40 58 09 	mov	#2392,	r12	;#0x0958
 4d4:	86 12       	call	r6		;
 4d6:	7a 40 14 00 	mov.b	#20,	r10	;#0x0014

000004da <.L58>:
 4da:	0c 48       	mov	r8,	r12	;
 4dc:	0d 49       	mov	r9,	r13	;
 4de:	87 12       	call	r7		;
 4e0:	7c f0 13 00 	and.b	#19,	r12	;#0x0013
 4e4:	1c 93       	cmp	#1,	r12	;r3 As==01
 4e6:	05 20       	jnz	$+12     	;abs 0x4f2
 4e8:	3c 40 68 09 	mov	#2408,	r12	;#0x0968
 4ec:	86 12       	call	r6		;
 4ee:	7a 40 11 00 	mov.b	#17,	r10	;#0x0011

000004f2 <.L59>:
 4f2:	0c 48       	mov	r8,	r12	;
 4f4:	0d 49       	mov	r9,	r13	;
 4f6:	87 12       	call	r7		;
 4f8:	3c b0 13 00 	bit	#19,	r12	;#0x0013
 4fc:	6c 23       	jnz	$-294    	;abs 0x3d6
 4fe:	3c 40 79 09 	mov	#2425,	r12	;#0x0979
 502:	30 40 6e 04 	br	#0x046e		;

00000506 <.L75>:
 506:	7a 40 0b 00 	mov.b	#11,	r10	;#0x000b
 50a:	30 40 46 04 	br	#0x0446		;

0000050e <.L48>:
 50e:	3e 43       	mov	#-1,	r14	;r3 As==11
 510:	3f 40 7f f6 	mov	#-2433,	r15	;#0xf67f
 514:	7c 40 44 00 	mov.b	#68,	r12	;#0x0044
 518:	4d 43       	clr.b	r13		;
 51a:	8a 12       	call	r10		;
 51c:	3e 43       	mov	#-1,	r14	;r3 As==11
 51e:	3f 40 1f f6 	mov	#-2529,	r15	;#0xf61f
 522:	7c 40 44 00 	mov.b	#68,	r12	;#0x0044
 526:	4d 43       	clr.b	r13		;
 528:	8a 12       	call	r10		;

0000052a <.L45>:
 52a:	0c 48       	mov	r8,	r12	;
 52c:	0d 49       	mov	r9,	r13	;
 52e:	87 12       	call	r7		;
 530:	0a 4c       	mov	r12,	r10	;
 532:	7a f0 13 00 	and.b	#19,	r10	;#0x0013
 536:	3a 90 10 00 	cmp	#16,	r10	;#0x0010
 53a:	21 20       	jnz	$+68     	;abs 0x57e
 53c:	3e 43       	mov	#-1,	r14	;r3 As==11
 53e:	3f 40 7f f6 	mov	#-2433,	r15	;#0xf67f
 542:	7c 40 44 00 	mov.b	#68,	r12	;#0x0044
 546:	4d 43       	clr.b	r13		;
 548:	b0 12 8c 00 	call	#140		;#0x008c
 54c:	3c 40 21 09 	mov	#2337,	r12	;#0x0921
 550:	86 12       	call	r6		;

00000552 <.L56>:
 552:	0c 48       	mov	r8,	r12	;
 554:	0d 49       	mov	r9,	r13	;
 556:	87 12       	call	r7		;
 558:	7c f0 13 00 	and.b	#19,	r12	;#0x0013
 55c:	1c 93       	cmp	#1,	r12	;r3 As==01
 55e:	05 20       	jnz	$+12     	;abs 0x56a
 560:	3c 40 31 09 	mov	#2353,	r12	;#0x0931
 564:	86 12       	call	r6		;
 566:	7a 40 0e 00 	mov.b	#14,	r10	;#0x000e

0000056a <.L57>:
 56a:	0c 48       	mov	r8,	r12	;
 56c:	0d 49       	mov	r9,	r13	;
 56e:	87 12       	call	r7		;
 570:	3c b0 13 00 	bit	#19,	r12	;#0x0013
 574:	30 23       	jnz	$-414    	;abs 0x3d6
 576:	3c 40 42 09 	mov	#2370,	r12	;#0x0942
 57a:	30 40 6e 04 	br	#0x046e		;

0000057e <.L76>:
 57e:	7a 40 0e 00 	mov.b	#14,	r10	;#0x000e
 582:	30 40 52 05 	br	#0x0552		;

00000586 <.L77>:
 586:	7a 40 11 00 	mov.b	#17,	r10	;#0x0011
 58a:	30 40 da 04 	br	#0x04da		;

0000058e <.L51>:
 58e:	38 40 60 80 	mov	#-32672,r8	;#0x8060
 592:	36 40 ae 00 	mov	#174,	r6	;#0x00ae

00000596 <.L67>:
 596:	6c 48       	mov.b	@r8,	r12	;
 598:	86 12       	call	r6		;
 59a:	47 4c       	mov.b	r12,	r7	;
 59c:	5c 48 01 00 	mov.b	1(r8),	r12	;
 5a0:	86 12       	call	r6		;
 5a2:	c1 4c 04 00 	mov.b	r12,	4(r1)	;
 5a6:	5c 48 02 00 	mov.b	2(r8),	r12	;
 5aa:	86 12       	call	r6		;
 5ac:	49 4c       	mov.b	r12,	r9	;
 5ae:	5c 48 03 00 	mov.b	3(r8),	r12	;
 5b2:	86 12       	call	r6		;
 5b4:	c1 4c 05 00 	mov.b	r12,	5(r1)	;
 5b8:	6c 43       	mov.b	#2,	r12	;r3 As==10
 5ba:	0c 95       	cmp	r5,	r12	;
 5bc:	74 28       	jnc	$+234    	;abs 0x6a6
 5be:	25 93       	cmp	#2,	r5	;r3 As==10
 5c0:	04 20       	jnz	$+10     	;abs 0x5ca
 5c2:	3e 40 ff 2f 	mov	#12287,	r14	;#0x2fff
 5c6:	0e 94       	cmp	r4,	r14	;
 5c8:	6e 28       	jnc	$+222    	;abs 0x6a6

000005ca <.L79>:
 5ca:	4c 47       	mov.b	r7,	r12	;
 5cc:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
 5d0:	0d 43       	clr	r13		;
 5d2:	7e 40 18 00 	mov.b	#24,	r14	;#0x0018
 5d6:	b0 12 64 07 	call	#1892		;#0x0764
 5da:	07 4c       	mov	r12,	r7	;
 5dc:	81 4d 06 00 	mov	r13,	6(r1)	;
 5e0:	5c 41 04 00 	mov.b	4(r1),	r12	;
 5e4:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
 5e8:	0d 43       	clr	r13		;
 5ea:	7e 40 10 00 	mov.b	#16,	r14	;#0x0010
 5ee:	b0 12 64 07 	call	#1892		;#0x0764
 5f2:	0c d7       	bis	r7,	r12	;
 5f4:	17 41 06 00 	mov	6(r1),	r7	;
 5f8:	07 dd       	bis	r13,	r7	;
 5fa:	5e 41 05 00 	mov.b	5(r1),	r14	;
 5fe:	3e f0 ff 00 	and	#255,	r14	;#0x00ff
 602:	0f 43       	clr	r15		;
 604:	0b 4c       	mov	r12,	r11	;
 606:	0b de       	bis	r14,	r11	;
 608:	4e 49       	mov.b	r9,	r14	;
 60a:	3e f0 ff 00 	and	#255,	r14	;#0x00ff
 60e:	0f 43       	clr	r15		;
 610:	0d 4e       	mov	r14,	r13	;
 612:	0d 5e       	add	r14,	r13	;
 614:	0f 6f       	rlc	r15		;
 616:	0d 5d       	rla	r13		;
 618:	0f 6f       	rlc	r15		;
 61a:	0d 5d       	rla	r13		;
 61c:	0f 6f       	rlc	r15		;
 61e:	0d 5d       	rla	r13		;
 620:	0f 6f       	rlc	r15		;
 622:	0d 5d       	rla	r13		;
 624:	0f 6f       	rlc	r15		;
 626:	0d 5d       	rla	r13		;
 628:	0f 6f       	rlc	r15		;
 62a:	0d 5d       	rla	r13		;
 62c:	0f 6f       	rlc	r15		;
 62e:	0d 5d       	rla	r13		;
 630:	0f 6f       	rlc	r15		;
 632:	0c 44       	mov	r4,	r12	;
 634:	0c 54       	add	r4,	r12	;
 636:	09 45       	mov	r5,	r9	;
 638:	09 65       	addc	r5,	r9	;
 63a:	0c 5c       	rla	r12		;
 63c:	09 69       	rlc	r9		;
 63e:	0e 4b       	mov	r11,	r14	;
 640:	0e dd       	bis	r13,	r14	;
 642:	0f d7       	bis	r7,	r15	;
 644:	0c 53       	add	#0,	r12	;r3 As==00
 646:	0d 49       	mov	r9,	r13	;
 648:	3d 60 10 00 	addc	#16,	r13	;#0x0010
 64c:	b0 12 8c 00 	call	#140		;#0x008c
 650:	37 40 6a 00 	mov	#106,	r7	;#0x006a
 654:	09 47       	mov	r7,	r9	;

00000656 <.L62>:
 656:	7c 40 40 00 	mov.b	#64,	r12	;#0x0040
 65a:	4d 43       	clr.b	r13		;
 65c:	87 12       	call	r7		;
 65e:	7c f0 0b 00 	and.b	#11,	r12	;#0x000b
 662:	2c 93       	cmp	#2,	r12	;r3 As==10
 664:	f8 27       	jz	$-14     	;abs 0x656
 666:	7c 40 40 00 	mov.b	#64,	r12	;#0x0040
 66a:	4d 43       	clr.b	r13		;
 66c:	89 12       	call	r9		;
 66e:	3c b0 0b 00 	bit	#11,	r12	;#0x000b
 672:	08 20       	jnz	$+18     	;abs 0x684
 674:	3c 40 8f 09 	mov	#2447,	r12	;#0x098f
 678:	b0 12 5a 01 	call	#346		;#0x015a
 67c:	34 40 60 ae 	mov	#-20896,r4	;#0xae60
 680:	75 40 0a 00 	mov.b	#10,	r5	;#0x000a

00000684 <.L64>:
 684:	7c 40 40 00 	mov.b	#64,	r12	;#0x0040
 688:	4d 43       	clr.b	r13		;
 68a:	89 12       	call	r9		;
 68c:	34 90 ff 1f 	cmp	#8191,	r4	;#0x1fff
 690:	02 20       	jnz	$+6      	;abs 0x696
 692:	05 93       	cmp	#0,	r5	;r3 As==00
 694:	0d 24       	jz	$+28     	;abs 0x6b0

00000696 <.L81>:
 696:	14 53       	inc	r4		;
 698:	05 63       	adc	r5		;

0000069a <.L65>:
 69a:	28 52       	add	#4,	r8	;r2 As==10
 69c:	81 98 00 00 	cmp	r8,	0(r1)	;
 6a0:	7a 23       	jnz	$-266    	;abs 0x596
 6a2:	30 40 ce 02 	br	#0x02ce		;

000006a6 <.L60>:
 6a6:	f2 40 05 00 	mov.b	#5,	&0x8001	;
 6aa:	01 80 
 6ac:	30 40 9a 06 	br	#0x069a		;

000006b0 <.L100>:
 6b0:	34 40 00 28 	mov	#10240,	r4	;#0x2800
 6b4:	55 43       	mov.b	#1,	r5	;r3 As==01
 6b6:	30 40 9a 06 	br	#0x069a		;

000006ba <.L43>:
 6ba:	3e 43       	mov	#-1,	r14	;r3 As==11
 6bc:	3f 43       	mov	#-1,	r15	;r3 As==11
 6be:	7c 40 44 00 	mov.b	#68,	r12	;#0x0044
 6c2:	4d 43       	clr.b	r13		;
 6c4:	b0 12 8c 00 	call	#140		;#0x008c
 6c8:	d2 43 01 80 	mov.b	#1,	&0x8001	;r3 As==01
 6cc:	3c 40 b7 09 	mov	#2487,	r12	;#0x09b7
 6d0:	b0 12 5a 01 	call	#346		;#0x015a
 6d4:	30 40 78 04 	br	#0x0478		;

000006d8 <.L101>:
 6d8:	3c 40 d2 08 	mov	#2258,	r12	;#0x08d2
 6dc:	89 12       	call	r9		;
 6de:	5c 43       	mov.b	#1,	r12	;r3 As==01
 6e0:	31 52       	add	#8,	r1	;r2 As==11
 6e2:	30 40 e6 06 	br	#0x06e6		;

000006e6 <__mspabi_func_epilog_7>:
 6e6:	34 41       	pop	r4		;

000006e8 <__mspabi_func_epilog_6>:
 6e8:	35 41       	pop	r5		;

000006ea <__mspabi_func_epilog_5>:
 6ea:	36 41       	pop	r6		;

000006ec <__mspabi_func_epilog_4>:
 6ec:	37 41       	pop	r7		;

000006ee <__mspabi_func_epilog_3>:
 6ee:	38 41       	pop	r8		;

000006f0 <__mspabi_func_epilog_2>:
 6f0:	39 41       	pop	r9		;

000006f2 <__mspabi_func_epilog_1>:
 6f2:	3a 41       	pop	r10		;
 6f4:	30 41       	ret			

000006f6 <__mspabi_slli_15>:
 6f6:	0c 5c       	rla	r12		;

000006f8 <__mspabi_slli_14>:
 6f8:	0c 5c       	rla	r12		;

000006fa <__mspabi_slli_13>:
 6fa:	0c 5c       	rla	r12		;

000006fc <__mspabi_slli_12>:
 6fc:	0c 5c       	rla	r12		;

000006fe <__mspabi_slli_11>:
 6fe:	0c 5c       	rla	r12		;

00000700 <__mspabi_slli_10>:
 700:	0c 5c       	rla	r12		;

00000702 <__mspabi_slli_9>:
 702:	0c 5c       	rla	r12		;

00000704 <__mspabi_slli_8>:
 704:	0c 5c       	rla	r12		;

00000706 <__mspabi_slli_7>:
 706:	0c 5c       	rla	r12		;

00000708 <__mspabi_slli_6>:
 708:	0c 5c       	rla	r12		;

0000070a <__mspabi_slli_5>:
 70a:	0c 5c       	rla	r12		;

0000070c <__mspabi_slli_4>:
 70c:	0c 5c       	rla	r12		;

0000070e <__mspabi_slli_3>:
 70e:	0c 5c       	rla	r12		;

00000710 <__mspabi_slli_2>:
 710:	0c 5c       	rla	r12		;

00000712 <__mspabi_slli_1>:
 712:	0c 5c       	rla	r12		;
 714:	30 41       	ret			

00000716 <.L11>:
 716:	3d 53       	add	#-1,	r13	;r3 As==11
 718:	0c 5c       	rla	r12		;

0000071a <__mspabi_slli>:
 71a:	0d 93       	cmp	#0,	r13	;r3 As==00
 71c:	fc 23       	jnz	$-6      	;abs 0x716
 71e:	30 41       	ret			

00000720 <__mspabi_slll_15>:
 720:	0c 5c       	rla	r12		;
 722:	0d 6d       	rlc	r13		;

00000724 <__mspabi_slll_14>:
 724:	0c 5c       	rla	r12		;
 726:	0d 6d       	rlc	r13		;

00000728 <__mspabi_slll_13>:
 728:	0c 5c       	rla	r12		;
 72a:	0d 6d       	rlc	r13		;

0000072c <__mspabi_slll_12>:
 72c:	0c 5c       	rla	r12		;
 72e:	0d 6d       	rlc	r13		;

00000730 <__mspabi_slll_11>:
 730:	0c 5c       	rla	r12		;
 732:	0d 6d       	rlc	r13		;

00000734 <__mspabi_slll_10>:
 734:	0c 5c       	rla	r12		;
 736:	0d 6d       	rlc	r13		;

00000738 <__mspabi_slll_9>:
 738:	0c 5c       	rla	r12		;
 73a:	0d 6d       	rlc	r13		;

0000073c <__mspabi_slll_8>:
 73c:	0c 5c       	rla	r12		;
 73e:	0d 6d       	rlc	r13		;

00000740 <__mspabi_slll_7>:
 740:	0c 5c       	rla	r12		;
 742:	0d 6d       	rlc	r13		;

00000744 <__mspabi_slll_6>:
 744:	0c 5c       	rla	r12		;
 746:	0d 6d       	rlc	r13		;

00000748 <__mspabi_slll_5>:
 748:	0c 5c       	rla	r12		;
 74a:	0d 6d       	rlc	r13		;

0000074c <__mspabi_slll_4>:
 74c:	0c 5c       	rla	r12		;
 74e:	0d 6d       	rlc	r13		;

00000750 <__mspabi_slll_3>:
 750:	0c 5c       	rla	r12		;
 752:	0d 6d       	rlc	r13		;

00000754 <__mspabi_slll_2>:
 754:	0c 5c       	rla	r12		;
 756:	0d 6d       	rlc	r13		;

00000758 <__mspabi_slll_1>:
 758:	0c 5c       	rla	r12		;
 75a:	0d 6d       	rlc	r13		;
 75c:	30 41       	ret			

0000075e <.L12>:
 75e:	3e 53       	add	#-1,	r14	;r3 As==11
 760:	0c 5c       	rla	r12		;
 762:	0d 6d       	rlc	r13		;

00000764 <__mspabi_slll>:
 764:	0e 93       	cmp	#0,	r14	;r3 As==00
 766:	fb 23       	jnz	$-8      	;abs 0x75e
 768:	30 41       	ret			

0000076a <__mspabi_srai_15>:
 76a:	0c 11       	rra	r12		;

0000076c <__mspabi_srai_14>:
 76c:	0c 11       	rra	r12		;

0000076e <__mspabi_srai_13>:
 76e:	0c 11       	rra	r12		;

00000770 <__mspabi_srai_12>:
 770:	0c 11       	rra	r12		;

00000772 <__mspabi_srai_11>:
 772:	0c 11       	rra	r12		;

00000774 <__mspabi_srai_10>:
 774:	0c 11       	rra	r12		;

00000776 <__mspabi_srai_9>:
 776:	0c 11       	rra	r12		;

00000778 <__mspabi_srai_8>:
 778:	0c 11       	rra	r12		;

0000077a <__mspabi_srai_7>:
 77a:	0c 11       	rra	r12		;

0000077c <__mspabi_srai_6>:
 77c:	0c 11       	rra	r12		;

0000077e <__mspabi_srai_5>:
 77e:	0c 11       	rra	r12		;

00000780 <__mspabi_srai_4>:
 780:	0c 11       	rra	r12		;

00000782 <__mspabi_srai_3>:
 782:	0c 11       	rra	r12		;

00000784 <__mspabi_srai_2>:
 784:	0c 11       	rra	r12		;

00000786 <__mspabi_srai_1>:
 786:	0c 11       	rra	r12		;
 788:	30 41       	ret			

0000078a <.L11>:
 78a:	3d 53       	add	#-1,	r13	;r3 As==11
 78c:	0c 11       	rra	r12		;

0000078e <__mspabi_srai>:
 78e:	0d 93       	cmp	#0,	r13	;r3 As==00
 790:	fc 23       	jnz	$-6      	;abs 0x78a
 792:	30 41       	ret			

00000794 <__mspabi_sral_15>:
 794:	0d 11       	rra	r13		;
 796:	0c 10       	rrc	r12		;

00000798 <__mspabi_sral_14>:
 798:	0d 11       	rra	r13		;
 79a:	0c 10       	rrc	r12		;

0000079c <__mspabi_sral_13>:
 79c:	0d 11       	rra	r13		;
 79e:	0c 10       	rrc	r12		;

000007a0 <__mspabi_sral_12>:
 7a0:	0d 11       	rra	r13		;
 7a2:	0c 10       	rrc	r12		;

000007a4 <__mspabi_sral_11>:
 7a4:	0d 11       	rra	r13		;
 7a6:	0c 10       	rrc	r12		;

000007a8 <__mspabi_sral_10>:
 7a8:	0d 11       	rra	r13		;
 7aa:	0c 10       	rrc	r12		;

000007ac <__mspabi_sral_9>:
 7ac:	0d 11       	rra	r13		;
 7ae:	0c 10       	rrc	r12		;

000007b0 <__mspabi_sral_8>:
 7b0:	0d 11       	rra	r13		;
 7b2:	0c 10       	rrc	r12		;

000007b4 <__mspabi_sral_7>:
 7b4:	0d 11       	rra	r13		;
 7b6:	0c 10       	rrc	r12		;

000007b8 <__mspabi_sral_6>:
 7b8:	0d 11       	rra	r13		;
 7ba:	0c 10       	rrc	r12		;

000007bc <__mspabi_sral_5>:
 7bc:	0d 11       	rra	r13		;
 7be:	0c 10       	rrc	r12		;

000007c0 <__mspabi_sral_4>:
 7c0:	0d 11       	rra	r13		;
 7c2:	0c 10       	rrc	r12		;

000007c4 <__mspabi_sral_3>:
 7c4:	0d 11       	rra	r13		;
 7c6:	0c 10       	rrc	r12		;

000007c8 <__mspabi_sral_2>:
 7c8:	0d 11       	rra	r13		;
 7ca:	0c 10       	rrc	r12		;

000007cc <__mspabi_sral_1>:
 7cc:	0d 11       	rra	r13		;
 7ce:	0c 10       	rrc	r12		;
 7d0:	30 41       	ret			

000007d2 <.L12>:
 7d2:	3e 53       	add	#-1,	r14	;r3 As==11
 7d4:	0d 11       	rra	r13		;
 7d6:	0c 10       	rrc	r12		;

000007d8 <__mspabi_sral>:
 7d8:	0e 93       	cmp	#0,	r14	;r3 As==00
 7da:	fb 23       	jnz	$-8      	;abs 0x7d2
 7dc:	30 41       	ret			

000007de <__mspabi_srli_15>:
 7de:	12 c3       	clrc			
 7e0:	0c 10       	rrc	r12		;

000007e2 <__mspabi_srli_14>:
 7e2:	12 c3       	clrc			
 7e4:	0c 10       	rrc	r12		;

000007e6 <__mspabi_srli_13>:
 7e6:	12 c3       	clrc			
 7e8:	0c 10       	rrc	r12		;

000007ea <__mspabi_srli_12>:
 7ea:	12 c3       	clrc			
 7ec:	0c 10       	rrc	r12		;

000007ee <__mspabi_srli_11>:
 7ee:	12 c3       	clrc			
 7f0:	0c 10       	rrc	r12		;

000007f2 <__mspabi_srli_10>:
 7f2:	12 c3       	clrc			
 7f4:	0c 10       	rrc	r12		;

000007f6 <__mspabi_srli_9>:
 7f6:	12 c3       	clrc			
 7f8:	0c 10       	rrc	r12		;

000007fa <__mspabi_srli_8>:
 7fa:	12 c3       	clrc			
 7fc:	0c 10       	rrc	r12		;

000007fe <__mspabi_srli_7>:
 7fe:	12 c3       	clrc			
 800:	0c 10       	rrc	r12		;

00000802 <__mspabi_srli_6>:
 802:	12 c3       	clrc			
 804:	0c 10       	rrc	r12		;

00000806 <__mspabi_srli_5>:
 806:	12 c3       	clrc			
 808:	0c 10       	rrc	r12		;

0000080a <__mspabi_srli_4>:
 80a:	12 c3       	clrc			
 80c:	0c 10       	rrc	r12		;

0000080e <__mspabi_srli_3>:
 80e:	12 c3       	clrc			
 810:	0c 10       	rrc	r12		;

00000812 <__mspabi_srli_2>:
 812:	12 c3       	clrc			
 814:	0c 10       	rrc	r12		;

00000816 <__mspabi_srli_1>:
 816:	12 c3       	clrc			
 818:	0c 10       	rrc	r12		;
 81a:	30 41       	ret			

0000081c <.L11>:
 81c:	3d 53       	add	#-1,	r13	;r3 As==11
 81e:	12 c3       	clrc			
 820:	0c 10       	rrc	r12		;

00000822 <__mspabi_srli>:
 822:	0d 93       	cmp	#0,	r13	;r3 As==00
 824:	fb 23       	jnz	$-8      	;abs 0x81c
 826:	30 41       	ret			

00000828 <__mspabi_srll_15>:
 828:	12 c3       	clrc			
 82a:	0d 10       	rrc	r13		;
 82c:	0c 10       	rrc	r12		;

0000082e <__mspabi_srll_14>:
 82e:	12 c3       	clrc			
 830:	0d 10       	rrc	r13		;
 832:	0c 10       	rrc	r12		;

00000834 <__mspabi_srll_13>:
 834:	12 c3       	clrc			
 836:	0d 10       	rrc	r13		;
 838:	0c 10       	rrc	r12		;

0000083a <__mspabi_srll_12>:
 83a:	12 c3       	clrc			
 83c:	0d 10       	rrc	r13		;
 83e:	0c 10       	rrc	r12		;

00000840 <__mspabi_srll_11>:
 840:	12 c3       	clrc			
 842:	0d 10       	rrc	r13		;
 844:	0c 10       	rrc	r12		;

00000846 <__mspabi_srll_10>:
 846:	12 c3       	clrc			
 848:	0d 10       	rrc	r13		;
 84a:	0c 10       	rrc	r12		;

0000084c <__mspabi_srll_9>:
 84c:	12 c3       	clrc			
 84e:	0d 10       	rrc	r13		;
 850:	0c 10       	rrc	r12		;

00000852 <__mspabi_srll_8>:
 852:	12 c3       	clrc			
 854:	0d 10       	rrc	r13		;
 856:	0c 10       	rrc	r12		;

00000858 <__mspabi_srll_7>:
 858:	12 c3       	clrc			
 85a:	0d 10       	rrc	r13		;
 85c:	0c 10       	rrc	r12		;

0000085e <__mspabi_srll_6>:
 85e:	12 c3       	clrc			
 860:	0d 10       	rrc	r13		;
 862:	0c 10       	rrc	r12		;

00000864 <__mspabi_srll_5>:
 864:	12 c3       	clrc			
 866:	0d 10       	rrc	r13		;
 868:	0c 10       	rrc	r12		;

0000086a <__mspabi_srll_4>:
 86a:	12 c3       	clrc			
 86c:	0d 10       	rrc	r13		;
 86e:	0c 10       	rrc	r12		;

00000870 <__mspabi_srll_3>:
 870:	12 c3       	clrc			
 872:	0d 10       	rrc	r13		;
 874:	0c 10       	rrc	r12		;

00000876 <__mspabi_srll_2>:
 876:	12 c3       	clrc			
 878:	0d 10       	rrc	r13		;
 87a:	0c 10       	rrc	r12		;

0000087c <__mspabi_srll_1>:
 87c:	12 c3       	clrc			
 87e:	0d 10       	rrc	r13		;
 880:	0c 10       	rrc	r12		;
 882:	30 41       	ret			

00000884 <.L12>:
 884:	3e 53       	add	#-1,	r14	;r3 As==11
 886:	12 c3       	clrc			
 888:	0d 10       	rrc	r13		;
 88a:	0c 10       	rrc	r12		;

0000088c <__mspabi_srll>:
 88c:	0e 93       	cmp	#0,	r14	;r3 As==00
 88e:	fa 23       	jnz	$-10     	;abs 0x884
 890:	30 41       	ret			

00000892 <memset>:
 892:	0f 4c       	mov	r12,	r15	;
 894:	0e 5c       	add	r12,	r14	;

00000896 <.L2>:
 896:	0f 9e       	cmp	r14,	r15	;
 898:	01 20       	jnz	$+4      	;abs 0x89c

0000089a <.Loc.104.1>:
 89a:	30 41       	ret			

0000089c <.L3>:
 89c:	cf 4d 00 00 	mov.b	r13,	0(r15)	;
 8a0:	1f 53       	inc	r15		;

000008a2 <.LVL4>:
 8a2:	30 40 96 08 	br	#0x0896		;

Disassembly of section .rodata:

000008a6 <_etext-0x12c>:
 8a6:	0a 4c       	mov	r12,	r10	;
 8a8:	69 6d       	addc.b	@r13,	r9	;
 8aa:	65 4e       	mov.b	@r14,	r5	;
 8ac:	45 54       	add.b	r4,	r5	;
 8ae:	2d 4d       	mov	@r13,	r13	;
 8b0:	69 63       	addc.b	#2,	r9	;r3 As==10
 8b2:	72 6f       	addc.b	@r15+,	r2	;
 8b4:	20 46       	br	@r6		;
 8b6:	61 63       	addc.b	#2,	r1	;r3 As==10
 8b8:	74 6f       	addc.b	@r15+,	r4	;
 8ba:	72 79       	subc.b	@r9+,	r2	;
 8bc:	20 46       	br	@r6		;
 8be:	69 72       	subc.b	#4,	r9	;r2 As==10
 8c0:	6d 77       	subc.b	@r7,	r13	;
 8c2:	61 72       	subc.b	#4,	r1	;r2 As==10
 8c4:	65 20       	jnz	$+204    	;abs 0x990
 8c6:	56 65 72 73 	addc.b	29554(r5),r6	;0x07372
 8ca:	69 6f       	addc.b	@r15,	r9	;
 8cc:	6e 3a       	jl	$-802    	;abs 0x5aa
 8ce:	20 32       	jn	$-958    	;abs 0x510
 8d0:	0a 00       	mova	@r0,	r10	;
 8d2:	45 72       	subc.b	r2,	r5	;
 8d4:	72 6f       	addc.b	@r15+,	r2	;
 8d6:	72 21       	jnz	$+742    	;abs 0xbbc
 8d8:	20 4e       	br	@r14		;
 8da:	6f 20       	jnz	$+224    	;abs 0x9ba
 8dc:	47 50       	add.b	r0,	r7	;
 8de:	49 4f       	mov.b	r15,	r9	;
 8e0:	20 75       	subc	@r5,	r0	;
 8e2:	6e 69       	addc.b	@r9,	r14	;
 8e4:	74 20       	jnz	$+234    	;abs 0x9ce
 8e6:	
Disassembly of section .bss:

00008000 <__bssstart>:
    8000:	00 00       	beq			
    8002:	00 00       	beq			
    8004:	00 00       	beq			
    8006:	00 00       	beq			
    8008:	00 00       	beq			
    800a:	00 00       	beq			
    800c:	00 00       	beq			
    800e:	00 00       	beq			
    8010:	00 00       	beq			
    8012:	00 00       	beq			
    8014:	00 00       	beq			
    8016:	00 00       	beq			
    8018:	00 00       	beq			
    801a:	00 00       	beq			
    801c:	00 00       	beq			
    801e:	00 00       	beq			
    8020:	00 00       	beq			
    8022:	00 00       	beq			
    8024:	00 00       	beq			
    8026:	00 00       	beq			
    8028:	00 00       	beq			
    802a:	00 00       	beq			
    802c:	00 00       	beq			
    802e:	00 00       	beq			
    8030:	00 00       	beq			
    8032:	00 00       	beq			
    8034:	00 00       	beq			
    8036:	00 00       	beq			
    8038:	00 00       	beq			
    803a:	00 00       	beq			
    803c:	00 00       	beq			
    803e:	00 00       	beq			

00008040 <glEp0Buffer_Rx>:
    8040:	00 00       	beq			
    8042:	00 00       	beq			
    8044:	00 00       	beq			
    8046:	00 00       	beq			
    8048:	00 00       	beq			
    804a:	00 00       	beq			
    804c:	00 00       	beq			
    804e:	00 00       	beq			
    8050:	00 00       	beq			
    8052:	00 00       	beq			
    8054:	00 00       	beq			
    8056:	00 00       	beq			
    8058:	00 00       	beq			
    805a:	00 00       	beq			
    805c:	00 00       	beq			
    805e:	00 00       	beq			
    8060:	00 00       	beq			
    8062:	00 00       	beq			
    8064:	00 00       	beq			
    8066:	00 00       	beq			
    8068:	00 00       	beq			
    806a:	00 00       	beq			
    806c:	00 00       	beq			
    806e:	00 00       	beq			
    8070:	00 00       	beq			
    8072:	00 00       	beq			
    8074:	00 00       	beq			
    8076:	00 00       	beq			
    8078:	00 00       	beq			
    807a:	00 00       	beq			
    807c:	00 00       	beq			
    807e:	00 00       	beq			

Disassembly of section .MP430.attributes:

00000000 <.MP430.attributes>:
   0:	41 16       	popm.a	#5,	r5	;20-bit words
   2:	00 00       	beq			
   4:	00 6d       	addc	r13,	r0	;
   6:	
Disassembly of section .comment:

00000000 <.comment>:
   0:	47 43       	clr.b	r7		;
   2:	43 3a       	jl	$-888    	;abs 0xfffffc8a
   4:	20 28       	jnc	$+66     	;abs 0x46
   6:	4d 69       	addc.b	r9,	r13	;
   8:	74 74       	subc.b	@r4+,	r4	;
   a:	6f 20       	jnz	$+224    	;abs 0xea
   c:	