
main.elf:     file format elf32-msp430


Disassembly of section .image:

0000f000 <__boot_crt0>:
    f000:	11 42 e8 ff 	mov	&0xffe8,r1	;0xffe8
    f004:	11 52 ea ff 	add	&0xffea,r1	;0xffea
    f008:	b1 3d       	jmp	$+868    	;abs 0xf36c

0000f00a <uart_putc>:
    f00a:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
    f00e:	3d 40 a0 ff 	mov	#-96,	r13	;#0xffa0

0000f012 <.L2>:
    f012:	bd b2 00 00 	bit	#8,	0(r13)	;r2 As==11
    f016:	fd 23       	jnz	$-4      	;abs 0xf012
    f018:	82 4c a4 ff 	mov	r12,	&0xffa4	;
    f01c:	30 41       	ret			

0000f01e <uart_br_print>:
    f01e:	0a 12       	push	r10		;
    f020:	09 12       	push	r9		;
    f022:	08 12       	push	r8		;
    f024:	07 12       	push	r7		;
    f026:	09 4c       	mov	r12,	r9	;
    f028:	38 40 0a f0 	mov	#-4086,	r8	;#0xf00a
    f02c:	77 40 0d 00 	mov.b	#13,	r7	;#0x000d

0000f030 <.L5>:
    f030:	6a 49       	mov.b	@r9,	r10	;
    f032:	0a 93       	cmp	#0,	r10	;r3 As==00
    f034:	02 20       	jnz	$+6      	;abs 0xf03a
    f036:	30 40 88 f5 	br	#0xf588		;

0000f03a <.L7>:
    f03a:	3a 90 0a 00 	cmp	#10,	r10	;#0x000a
    f03e:	02 20       	jnz	$+6      	;abs 0xf044
    f040:	4c 47       	mov.b	r7,	r12	;
    f042:	88 12       	call	r8		;

0000f044 <.L6>:
    f044:	4c 4a       	mov.b	r10,	r12	;
    f046:	88 12       	call	r8		;
    f048:	19 53       	inc	r9		;
    f04a:	30 40 30 f0 	br	#0xf030		;

0000f04e <wishbone_read32>:
    f04e:	b2 40 0f 00 	mov	#15,	&0xff90	;#0x000f
    f052:	90 ff 
    f054:	0e 4c       	mov	r12,	r14	;
    f056:	3e f0 fc ff 	and	#-4,	r14	;#0xfffc
    f05a:	82 4e 92 ff 	mov	r14,	&0xff92	;
    f05e:	82 4d 94 ff 	mov	r13,	&0xff94	;
    f062:	3d 40 90 ff 	mov	#-112,	r13	;#0xff90

0000f066 <.L9>:
    f066:	2c 4d       	mov	@r13,	r12	;
    f068:	0c 93       	cmp	#0,	r12	;r3 As==00
    f06a:	fd 3b       	jl	$-4      	;abs 0xf066
    f06c:	1c 42 9a ff 	mov	&0xff9a,r12	;0xff9a
    f070:	1d 42 9c ff 	mov	&0xff9c,r13	;0xff9c
    f074:	30 41       	ret			

0000f076 <wishbone_write32>:
    f076:	b2 40 0f 00 	mov	#15,	&0xff90	;#0x000f
    f07a:	90 ff 
    f07c:	82 4e 9a ff 	mov	r14,	&0xff9a	;
    f080:	82 4f 9c ff 	mov	r15,	&0xff9c	;
    f084:	82 4c 96 ff 	mov	r12,	&0xff96	;
    f088:	82 4d 98 ff 	mov	r13,	&0xff98	;
    f08c:	3d 40 90 ff 	mov	#-112,	r13	;#0xff90

0000f090 <.L12>:
    f090:	2c 4d       	mov	@r13,	r12	;
    f092:	0c 93       	cmp	#0,	r12	;r3 As==00
    f094:	fd 3b       	jl	$-4      	;abs 0xf090
    f096:	30 41       	ret			

0000f098 <start_app>:
    f098:	0a 12       	push	r10		;
    f09a:	1c 42 fa ff 	mov	&0xfffa,r12	;0xfffa
    f09e:	3a 40 1e f0 	mov	#-4066,	r10	;#0xf01e
    f0a2:	0c 93       	cmp	#0,	r12	;r3 As==00
    f0a4:	0d 24       	jz	$+28     	;abs 0xf0c0

0000f0a6 <.L19>:
    f0a6:	32 40 00 40 	mov	#16384,	r2	;#0x4000
    f0aa:	3c 40 46 f6 	mov	#-2490,	r12	;#0xf646
    f0ae:	8a 12       	call	r10		;
    f0b0:	3c 40 a0 ff 	mov	#-96,	r12	;#0xffa0

0000f0b4 <.L16>:
    f0b4:	bc b2 00 00 	bit	#8,	0(r12)	;r2 As==11
    f0b8:	fd 23       	jnz	$-4      	;abs 0xf0b4

0000f0ba <.L20>:
    f0ba:	00 43       	clr	r0		;
    f0bc:	30 40 ba f0 	br	#0xf0ba		;

0000f0c0 <.L15>:
    f0c0:	3c 40 53 f6 	mov	#-2477,	r12	;#0xf653
    f0c4:	8a 12       	call	r10		;
    f0c6:	3d 40 a4 ff 	mov	#-92,	r13	;#0xffa4

0000f0ca <.L17>:
    f0ca:	2c 4d       	mov	@r13,	r12	;
    f0cc:	0c 93       	cmp	#0,	r12	;r3 As==00
    f0ce:	fd 37       	jge	$-4      	;abs 0xf0ca
    f0d0:	7c 90 79 00 	cmp.b	#121,	r12	;#0x0079
    f0d4:	e8 27       	jz	$-46     	;abs 0xf0a6
    f0d6:	3a 41       	pop	r10		;
    f0d8:	30 41       	ret			

0000f0da <I2C_write.constprop.1>:
    f0da:	0a 12       	push	r10		;
    f0dc:	09 12       	push	r9		;
    f0de:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
    f0e2:	3a 40 76 f0 	mov	#-3978,	r10	;#0xf076
    f0e6:	0e 4c       	mov	r12,	r14	;
    f0e8:	0f 43       	clr	r15		;
    f0ea:	7c 40 6c 00 	mov.b	#108,	r12	;#0x006c
    f0ee:	4d 43       	clr.b	r13		;
    f0f0:	8a 12       	call	r10		;
    f0f2:	7e 40 10 00 	mov.b	#16,	r14	;#0x0010
    f0f6:	4f 43       	clr.b	r15		;
    f0f8:	7c 40 70 00 	mov.b	#112,	r12	;#0x0070
    f0fc:	4d 43       	clr.b	r13		;
    f0fe:	8a 12       	call	r10		;
    f100:	39 40 4e f0 	mov	#-4018,	r9	;#0xf04e

0000f104 <.L24>:
    f104:	7c 40 70 00 	mov.b	#112,	r12	;#0x0070
    f108:	4d 43       	clr.b	r13		;
    f10a:	89 12       	call	r9		;
    f10c:	0a 4c       	mov	r12,	r10	;
    f10e:	6a f3       	and.b	#2,	r10	;r3 As==10
    f110:	0a 93       	cmp	#0,	r10	;r3 As==00
    f112:	f8 23       	jnz	$-14     	;abs 0xf104
    f114:	7c 40 70 00 	mov.b	#112,	r12	;#0x0070
    f118:	4d 43       	clr.b	r13		;
    f11a:	89 12       	call	r9		;
    f11c:	b0 12 0c f6 	call	#-2548		;#0xf60c
    f120:	5c f3       	and.b	#1,	r12	;r3 As==01
    f122:	0d 4a       	mov	r10,	r13	;
    f124:	30 40 8c f5 	br	#0xf58c		;

0000f128 <I2C_start.constprop.3>:
    f128:	0a 12       	push	r10		;
    f12a:	3a 40 76 f0 	mov	#-3978,	r10	;#0xf076
    f12e:	0e 4c       	mov	r12,	r14	;
    f130:	3e 50 a0 00 	add	#160,	r14	;#0x00a0
    f134:	0f 4d       	mov	r13,	r15	;
    f136:	0f 63       	adc	r15		;
    f138:	7c 40 6c 00 	mov.b	#108,	r12	;#0x006c
    f13c:	4d 43       	clr.b	r13		;
    f13e:	8a 12       	call	r10		;
    f140:	7e 40 90 00 	mov.b	#144,	r14	;#0x0090
    f144:	4f 43       	clr.b	r15		;
    f146:	7c 40 70 00 	mov.b	#112,	r12	;#0x0070
    f14a:	4d 43       	clr.b	r13		;
    f14c:	8a 12       	call	r10		;
    f14e:	3a 40 4e f0 	mov	#-4018,	r10	;#0xf04e

0000f152 <.L27>:
    f152:	7c 40 70 00 	mov.b	#112,	r12	;#0x0070
    f156:	4d 43       	clr.b	r13		;
    f158:	8a 12       	call	r10		;
    f15a:	2c b3       	bit	#2,	r12	;r3 As==10
    f15c:	fa 23       	jnz	$-10     	;abs 0xf152
    f15e:	7c 40 70 00 	mov.b	#112,	r12	;#0x0070
    f162:	4d 43       	clr.b	r13		;
    f164:	8a 12       	call	r10		;
    f166:	b0 12 0c f6 	call	#-2548		;#0xf60c
    f16a:	5c f3       	and.b	#1,	r12	;r3 As==01
    f16c:	3a 41       	pop	r10		;
    f16e:	30 41       	ret			

0000f170 <timer_irq_handler>:
    f170:	92 53 fc ff 	inc	&0xfffc		;
    f174:	92 e3 ac ff 	xor	#1,	&0xffac	;r3 As==01
    f178:	00 13       	reti			

0000f17a <uart_print_hex_byte>:
    f17a:	0a 12       	push	r10		;
    f17c:	09 12       	push	r9		;
    f17e:	4a 4c       	mov.b	r12,	r10	;
    f180:	0c 4a       	mov	r10,	r12	;
    f182:	b0 12 be f5 	call	#-2626		;#0xf5be
    f186:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
    f18a:	7d 40 09 00 	mov.b	#9,	r13	;
    f18e:	4d 9c       	cmp.b	r12,	r13	;
    f190:	13 28       	jnc	$+40     	;abs 0xf1b8
    f192:	7c 50 30 00 	add.b	#48,	r12	;#0x0030

0000f196 <.L35>:
    f196:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
    f19a:	39 40 0a f0 	mov	#-4086,	r9	;#0xf00a
    f19e:	89 12       	call	r9		;
    f1a0:	4c 4a       	mov.b	r10,	r12	;
    f1a2:	7c f0 0f 00 	and.b	#15,	r12	;#0x000f
    f1a6:	7d 40 09 00 	mov.b	#9,	r13	;
    f1aa:	4d 9c       	cmp.b	r12,	r13	;
    f1ac:	09 28       	jnc	$+20     	;abs 0xf1c0
    f1ae:	3c 50 30 00 	add	#48,	r12	;#0x0030

0000f1b2 <.L34>:
    f1b2:	89 12       	call	r9		;
    f1b4:	30 40 8c f5 	br	#0xf58c		;

0000f1b8 <.L31>:
    f1b8:	7c 50 37 00 	add.b	#55,	r12	;#0x0037
    f1bc:	30 40 96 f1 	br	#0xf196		;

0000f1c0 <.L33>:
    f1c0:	3c 50 37 00 	add	#55,	r12	;#0x0037
    f1c4:	30 40 b2 f1 	br	#0xf1b2		;

0000f1c8 <uart_print_hex_word>:
    f1c8:	0a 12       	push	r10		;
    f1ca:	09 12       	push	r9		;
    f1cc:	09 4c       	mov	r12,	r9	;
    f1ce:	b0 12 ae f5 	call	#-2642		;#0xf5ae
    f1d2:	3a 40 7a f1 	mov	#-3718,	r10	;#0xf17a
    f1d6:	8a 12       	call	r10		;
    f1d8:	4c 49       	mov.b	r9,	r12	;
    f1da:	8a 12       	call	r10		;
    f1dc:	30 40 8c f5 	br	#0xf58c		;

0000f1e0 <system_error>:
    f1e0:	0a 12       	push	r10		;
    f1e2:	4a 4c       	mov.b	r12,	r10	;
    f1e4:	3c 40 82 f6 	mov	#-2430,	r12	;#0xf682
    f1e8:	b0 12 1e f0 	call	#-4066		;#0xf01e
    f1ec:	4c 4a       	mov.b	r10,	r12	;
    f1ee:	b0 12 7a f1 	call	#-3718		;#0xf17a
    f1f2:	02 43       	clr	r2		;
    f1f4:	92 43 ac ff 	mov	#1,	&0xffac	;r3 As==01

0000f1f8 <.L38>:
    f1f8:	30 40 f8 f1 	br	#0xf1f8		;

0000f1fc <get_image_word>:
    f1fc:	0a 12       	push	r10		;
    f1fe:	09 12       	push	r9		;
    f200:	08 12       	push	r8		;
    f202:	07 12       	push	r7		;
    f204:	06 12       	push	r6		;
    f206:	4d 93       	cmp.b	#0,	r13	;r3 As==00
    f208:	11 20       	jnz	$+36     	;abs 0xf22c
    f20a:	3c 40 a4 ff 	mov	#-92,	r12	;#0xffa4
    f20e:	0e 4c       	mov	r12,	r14	;

0000f210 <.L41>:
    f210:	2d 4c       	mov	@r12,	r13	;
    f212:	0d 93       	cmp	#0,	r13	;r3 As==00
    f214:	fd 37       	jge	$-4      	;abs 0xf210

0000f216 <.L42>:
    f216:	2c 4e       	mov	@r14,	r12	;
    f218:	0c 93       	cmp	#0,	r12	;r3 As==00
    f21a:	fd 37       	jge	$-4      	;abs 0xf216
    f21c:	7d f0 ff 00 	and.b	#255,	r13	;#0x00ff
    f220:	8d 10       	swpb	r13		;
    f222:	7c f0 ff 00 	and.b	#255,	r12	;#0x00ff
    f226:	0c dd       	bis	r13,	r12	;

0000f228 <.L39>:
    f228:	30 40 86 f5 	br	#0xf586		;

0000f22c <.L40>:
    f22c:	0a 4c       	mov	r12,	r10	;
    f22e:	3a 50 04 04 	add	#1028,	r10	;#0x0404
    f232:	39 40 28 f1 	mov	#-3800,	r9	;#0xf128
    f236:	4c 43       	clr.b	r12		;
    f238:	4d 43       	clr.b	r13		;
    f23a:	89 12       	call	r9		;
    f23c:	0c 4a       	mov	r10,	r12	;
    f23e:	b0 12 ae f5 	call	#-2642		;#0xf5ae
    f242:	38 40 da f0 	mov	#-3878,	r8	;#0xf0da
    f246:	88 12       	call	r8		;
    f248:	4c 4a       	mov.b	r10,	r12	;
    f24a:	88 12       	call	r8		;
    f24c:	5c 43       	mov.b	#1,	r12	;r3 As==01
    f24e:	4d 43       	clr.b	r13		;
    f250:	89 12       	call	r9		;
    f252:	3a 40 76 f0 	mov	#-3978,	r10	;#0xf076
    f256:	7e 40 20 00 	mov.b	#32,	r14	;#0x0020
    f25a:	4f 43       	clr.b	r15		;
    f25c:	7c 40 70 00 	mov.b	#112,	r12	;#0x0070
    f260:	4d 43       	clr.b	r13		;
    f262:	8a 12       	call	r10		;
    f264:	39 40 4e f0 	mov	#-4018,	r9	;#0xf04e
    f268:	76 40 70 00 	mov.b	#112,	r6	;#0x0070
    f26c:	47 43       	clr.b	r7		;
    f26e:	08 49       	mov	r9,	r8	;

0000f270 <.L44>:
    f270:	0c 46       	mov	r6,	r12	;
    f272:	0d 47       	mov	r7,	r13	;
    f274:	89 12       	call	r9		;
    f276:	2c b3       	bit	#2,	r12	;r3 As==10
    f278:	fb 23       	jnz	$-8      	;abs 0xf270
    f27a:	7c 40 6c 00 	mov.b	#108,	r12	;#0x006c
    f27e:	4d 43       	clr.b	r13		;
    f280:	89 12       	call	r9		;
    f282:	49 4c       	mov.b	r12,	r9	;
    f284:	7e 40 68 00 	mov.b	#104,	r14	;#0x0068
    f288:	4f 43       	clr.b	r15		;
    f28a:	7c 40 70 00 	mov.b	#112,	r12	;#0x0070
    f28e:	4d 43       	clr.b	r13		;
    f290:	8a 12       	call	r10		;
    f292:	76 40 70 00 	mov.b	#112,	r6	;#0x0070
    f296:	47 43       	clr.b	r7		;

0000f298 <.L45>:
    f298:	0c 46       	mov	r6,	r12	;
    f29a:	0d 47       	mov	r7,	r13	;
    f29c:	88 12       	call	r8		;
    f29e:	2c b3       	bit	#2,	r12	;r3 As==10
    f2a0:	fb 23       	jnz	$-8      	;abs 0xf298
    f2a2:	7c 40 6c 00 	mov.b	#108,	r12	;#0x006c
    f2a6:	4d 43       	clr.b	r13		;
    f2a8:	88 12       	call	r8		;
    f2aa:	89 10       	swpb	r9		;
    f2ac:	3c f0 ff 00 	and	#255,	r12	;#0x00ff
    f2b0:	0c d9       	bis	r9,	r12	;
    f2b2:	30 40 28 f2 	br	#0xf228		;

0000f2b6 <get_image>:
    f2b6:	0a 12       	push	r10		;
    f2b8:	09 12       	push	r9		;
    f2ba:	08 12       	push	r8		;
    f2bc:	07 12       	push	r7		;
    f2be:	06 12       	push	r6		;
    f2c0:	05 12       	push	r5		;
    f2c2:	04 12       	push	r4		;
    f2c4:	21 83       	decd	r1		;
    f2c6:	49 4c       	mov.b	r12,	r9	;
    f2c8:	b2 b0 00 01 	bit	#256,	&0xffe2	;#0x0100
    f2cc:	e2 ff 
    f2ce:	03 24       	jz	$+8      	;abs 0xf2d6
    f2d0:	5c 43       	mov.b	#1,	r12	;r3 As==01

0000f2d2 <.L64>:
    f2d2:	b0 12 e0 f1 	call	#-3616		;#0xf1e0

0000f2d6 <.L51>:
    f2d6:	37 40 1e f0 	mov	#-4066,	r7	;#0xf01e
    f2da:	09 93       	cmp	#0,	r9	;r3 As==00
    f2dc:	0f 20       	jnz	$+32     	;abs 0xf2fc
    f2de:	3c 40 8b f6 	mov	#-2421,	r12	;#0xf68b

0000f2e2 <.L63>:
    f2e2:	87 12       	call	r7		;
    f2e4:	3a 40 fc f1 	mov	#-3588,	r10	;#0xf1fc
    f2e8:	4d 49       	mov.b	r9,	r13	;
    f2ea:	4c 43       	clr.b	r12		;
    f2ec:	8a 12       	call	r10		;
    f2ee:	04 4a       	mov	r10,	r4	;
    f2f0:	3c 90 fe ca 	cmp	#-13570,r12	;#0xcafe
    f2f4:	07 24       	jz	$+16     	;abs 0xf304
    f2f6:	6c 43       	mov.b	#2,	r12	;r3 As==10
    f2f8:	30 40 d2 f2 	br	#0xf2d2		;

0000f2fc <.L52>:
    f2fc:	3c 40 9f f6 	mov	#-2401,	r12	;#0xf69f
    f300:	30 40 e2 f2 	br	#0xf2e2		;

0000f304 <.L54>:
    f304:	4d 49       	mov.b	r9,	r13	;
    f306:	6c 43       	mov.b	#2,	r12	;r3 As==10
    f308:	8a 12       	call	r10		;
    f30a:	06 4c       	mov	r12,	r6	;
    f30c:	4d 49       	mov.b	r9,	r13	;
    f30e:	6c 42       	mov.b	#4,	r12	;r2 As==10
    f310:	8a 12       	call	r10		;
    f312:	81 4c 00 00 	mov	r12,	0(r1)	;
    f316:	15 42 e6 ff 	mov	&0xffe6,r5	;0xffe6
    f31a:	05 96       	cmp	r6,	r5	;
    f31c:	16 2c       	jc	$+46     	;abs 0xf34a
    f31e:	6c 42       	mov.b	#4,	r12	;r2 As==10
    f320:	30 40 d2 f2 	br	#0xf2d2		;

0000f324 <.L56>:
    f324:	4d 49       	mov.b	r9,	r13	;
    f326:	84 12       	call	r4		;
    f328:	08 ec       	xor	r12,	r8	;
    f32a:	8a 4c 00 00 	mov	r12,	0(r10)	;
    f32e:	2a 53       	incd	r10		;

0000f330 <.L55>:
    f330:	0d 4a       	mov	r10,	r13	;
    f332:	0c 4a       	mov	r10,	r12	;
    f334:	3c 50 06 00 	add	#6,	r12	;
    f338:	0a 96       	cmp	r6,	r10	;
    f33a:	f4 2b       	jnc	$-22     	;abs 0xf324

0000f33c <.L57>:
    f33c:	0d 95       	cmp	r5,	r13	;
    f33e:	09 28       	jnc	$+20     	;abs 0xf352
    f340:	28 91       	cmp	@r1,	r8	;
    f342:	0c 24       	jz	$+26     	;abs 0xf35c
    f344:	7c 42       	mov.b	#8,	r12	;r2 As==11
    f346:	30 40 d2 f2 	br	#0xf2d2		;

0000f34a <.L60>:
    f34a:	48 43       	clr.b	r8		;
    f34c:	0a 48       	mov	r8,	r10	;
    f34e:	30 40 30 f3 	br	#0xf330		;

0000f352 <.L58>:
    f352:	8d 43 00 00 	mov	#0,	0(r13)	;r3 As==00
    f356:	2d 53       	incd	r13		;
    f358:	30 40 3c f3 	br	#0xf33c		;

0000f35c <.L62>:
    f35c:	3c 40 ab f6 	mov	#-2389,	r12	;#0xf6ab
    f360:	87 12       	call	r7		;
    f362:	92 43 fa ff 	mov	#1,	&0xfffa	;r3 As==01
    f366:	21 53       	incd	r1		;
    f368:	30 40 82 f5 	br	#0xf582		;

0000f36c <main>:
    f36c:	0a 12       	push	r10		;
    f36e:	09 12       	push	r9		;
    f370:	08 12       	push	r8		;
    f372:	07 12       	push	r7		;
    f374:	06 12       	push	r6		;
    f376:	b2 40 00 47 	mov	#18176,	&0xffb8	;#0x4700
    f37a:	b8 ff 
    f37c:	32 40 00 c0 	mov	#-16384,r2	;#0xc000
    f380:	92 43 90 ff 	mov	#1,	&0xff90	;r3 As==01
    f384:	82 43 fa ff 	mov	#0,	&0xfffa	;r3 As==00
    f388:	b2 40 70 f1 	mov	#-3728,	&0xfff8	;#0xf170
    f38c:	f8 ff 
    f38e:	92 43 ac ff 	mov	#1,	&0xffac	;r3 As==01
    f392:	82 43 a0 ff 	mov	#0,	&0xffa0	;r3 As==00
    f396:	1e 42 ec ff 	mov	&0xffec,r14	;0xffec
    f39a:	1f 42 ee ff 	mov	&0xffee,r15	;0xffee
    f39e:	4c 43       	clr.b	r12		;

0000f3a0 <.L66>:
    f3a0:	0a 4f       	mov	r15,	r10	;
    f3a2:	0f 93       	cmp	#0,	r15	;r3 As==00
    f3a4:	b6 20       	jnz	$+366    	;abs 0xf512
    f3a6:	3d 40 ff 95 	mov	#-27137,r13	;#0x95ff
    f3aa:	0d 9e       	cmp	r14,	r13	;
    f3ac:	b2 28       	jnc	$+358    	;abs 0xf512

0000f3ae <.L69>:
    f3ae:	7d 40 ff 00 	mov.b	#255,	r13	;#0x00ff
    f3b2:	0d 9c       	cmp	r12,	r13	;
    f3b4:	b4 28       	jnc	$+362    	;abs 0xf51e
    f3b6:	0d 4a       	mov	r10,	r13	;
    f3b8:	0d 5a       	add	r10,	r13	;
    f3ba:	0d 5d       	rla	r13		;
    f3bc:	0d 5d       	rla	r13		;
    f3be:	0d 5d       	rla	r13		;
    f3c0:	0d 5d       	rla	r13		;
    f3c2:	0d 5d       	rla	r13		;
    f3c4:	0d 5d       	rla	r13		;
    f3c6:	0d 5d       	rla	r13		;
    f3c8:	0d dc       	bis	r12,	r13	;
    f3ca:	82 4d a6 ff 	mov	r13,	&0xffa6	;
    f3ce:	b2 40 81 02 	mov	#641,	&0xffa0	;#0x0281
    f3d2:	a0 ff 
    f3d4:	82 43 a2 ff 	mov	#0,	&0xffa2	;r3 As==00
    f3d8:	3c 40 a0 ff 	mov	#-96,	r12	;#0xffa0

0000f3dc <.L74>:
    f3dc:	2d 4c       	mov	@r12,	r13	;
    f3de:	7d f0 40 00 	and.b	#64,	r13	;#0x0040
    f3e2:	0d 93       	cmp	#0,	r13	;r3 As==00
    f3e4:	fb 23       	jnz	$-8      	;abs 0xf3dc
    f3e6:	1c 42 a2 ff 	mov	&0xffa2,r12	;0xffa2
    f3ea:	1c 42 a4 ff 	mov	&0xffa4,r12	;0xffa4
    f3ee:	82 4d b0 ff 	mov	r13,	&0xffb0	;
    f3f2:	37 40 ee ff 	mov	#-18,	r7	;#0xffee
    f3f6:	2c 47       	mov	@r7,	r12	;
    f3f8:	0c 5c       	rla	r12		;
    f3fa:	0c 5c       	rla	r12		;
    f3fc:	3c 53       	add	#-1,	r12	;r3 As==11
    f3fe:	82 4c b4 ff 	mov	r12,	&0xffb4	;
    f402:	b2 40 7f 00 	mov	#127,	&0xffb0	;#0x007f
    f406:	b0 ff 
    f408:	82 4d b2 ff 	mov	r13,	&0xffb2	;
    f40c:	38 40 fc ff 	mov	#-4,	r8	;#0xfffc
    f410:	88 4d 00 00 	mov	r13,	0(r8)	;
    f414:	32 d0 00 40 	bis	#16384,	r2	;#0x4000
    f418:	32 d2       	eint			
    f41a:	3a 40 76 f0 	mov	#-3978,	r10	;#0xf076
    f41e:	4e 43       	clr.b	r14		;
    f420:	4f 43       	clr.b	r15		;
    f422:	7c 40 68 00 	mov.b	#104,	r12	;#0x0068
    f426:	4d 43       	clr.b	r13		;
    f428:	8a 12       	call	r10		;
    f42a:	5e 43       	mov.b	#1,	r14	;r3 As==01
    f42c:	4f 43       	clr.b	r15		;
    f42e:	7c 40 70 00 	mov.b	#112,	r12	;#0x0070
    f432:	4d 43       	clr.b	r13		;
    f434:	8a 12       	call	r10		;
    f436:	7e 40 3c 00 	mov.b	#60,	r14	;#0x003c
    f43a:	4f 43       	clr.b	r15		;
    f43c:	7c 40 60 00 	mov.b	#96,	r12	;#0x0060
    f440:	4d 43       	clr.b	r13		;
    f442:	8a 12       	call	r10		;
    f444:	4e 43       	clr.b	r14		;
    f446:	4f 43       	clr.b	r15		;
    f448:	7c 40 64 00 	mov.b	#100,	r12	;#0x0064
    f44c:	4d 43       	clr.b	r13		;
    f44e:	8a 12       	call	r10		;
    f450:	7e 40 80 00 	mov.b	#128,	r14	;#0x0080
    f454:	4f 43       	clr.b	r15		;
    f456:	7c 40 68 00 	mov.b	#104,	r12	;#0x0068
    f45a:	4d 43       	clr.b	r13		;
    f45c:	8a 12       	call	r10		;
    f45e:	3a 40 1e f0 	mov	#-4066,	r10	;#0xf01e
    f462:	3c 40 ae f6 	mov	#-2386,	r12	;#0xf6ae
    f466:	8a 12       	call	r10		;
    f468:	3c 40 e0 f6 	mov	#-2336,	r12	;#0xf6e0
    f46c:	8a 12       	call	r10		;
    f46e:	39 40 c8 f1 	mov	#-3640,	r9	;#0xf1c8
    f472:	1c 42 e0 ff 	mov	&0xffe0,r12	;0xffe0
    f476:	89 12       	call	r9		;
    f478:	3c 40 23 f7 	mov	#-2269,	r12	;#0xf723
    f47c:	8a 12       	call	r10		;
    f47e:	2c 47       	mov	@r7,	r12	;
    f480:	89 12       	call	r9		;
    f482:	1c 42 ec ff 	mov	&0xffec,r12	;0xffec
    f486:	89 12       	call	r9		;
    f488:	3c 40 2c f7 	mov	#-2260,	r12	;#0xf72c
    f48c:	8a 12       	call	r10		;
    f48e:	1c 42 e6 ff 	mov	&0xffe6,r12	;0xffe6
    f492:	89 12       	call	r9		;
    f494:	3c 40 35 f7 	mov	#-2251,	r12	;#0xf735
    f498:	8a 12       	call	r10		;
    f49a:	1c 42 ea ff 	mov	&0xffea,r12	;0xffea
    f49e:	89 12       	call	r9		;
    f4a0:	3c 40 3e f7 	mov	#-2242,	r12	;#0xf73e
    f4a4:	8a 12       	call	r10		;
    f4a6:	1c 42 e2 ff 	mov	&0xffe2,r12	;0xffe2
    f4aa:	89 12       	call	r9		;
    f4ac:	3c 40 47 f7 	mov	#-2233,	r12	;#0xf747
    f4b0:	8a 12       	call	r10		;
    f4b2:	09 4a       	mov	r10,	r9	;
    f4b4:	37 40 b6 f2 	mov	#-3402,	r7	;#0xf2b6
    f4b8:	36 40 98 f0 	mov	#-3944,	r6	;#0xf098

0000f4bc <.L76>:
    f4bc:	2c 48       	mov	@r8,	r12	;
    f4be:	1c 93       	cmp	#1,	r12	;r3 As==01
    f4c0:	05 20       	jnz	$+12     	;abs 0xf4cc
    f4c2:	87 12       	call	r7		;
    f4c4:	3c 40 6e f7 	mov	#-2194,	r12	;#0xf76e
    f4c8:	89 12       	call	r9		;
    f4ca:	86 12       	call	r6		;

0000f4cc <.L75>:
    f4cc:	3a 40 a4 ff 	mov	#-92,	r10	;#0xffa4
    f4d0:	2c 4a       	mov	@r10,	r12	;
    f4d2:	0c 93       	cmp	#0,	r12	;r3 As==00
    f4d4:	f3 37       	jge	$-24     	;abs 0xf4bc
    f4d6:	3c 40 70 f7 	mov	#-2192,	r12	;#0xf770
    f4da:	89 12       	call	r9		;
    f4dc:	3c 40 7b f7 	mov	#-2181,	r12	;#0xf77b
    f4e0:	89 12       	call	r9		;
    f4e2:	08 4a       	mov	r10,	r8	;
    f4e4:	37 40 0a f0 	mov	#-4086,	r7	;#0xf00a
    f4e8:	36 40 98 f0 	mov	#-3944,	r6	;#0xf098

0000f4ec <.L77>:
    f4ec:	3c 40 e1 f7 	mov	#-2079,	r12	;#0xf7e1
    f4f0:	89 12       	call	r9		;

0000f4f2 <.L78>:
    f4f2:	2c 48       	mov	@r8,	r12	;
    f4f4:	0c 93       	cmp	#0,	r12	;r3 As==00
    f4f6:	fd 37       	jge	$-4      	;abs 0xf4f2
    f4f8:	4a 4c       	mov.b	r12,	r10	;
    f4fa:	4c 4a       	mov.b	r10,	r12	;
    f4fc:	87 12       	call	r7		;
    f4fe:	3c 40 6e f7 	mov	#-2194,	r12	;#0xf76e
    f502:	89 12       	call	r9		;
    f504:	7a 90 72 00 	cmp.b	#114,	r10	;#0x0072
    f508:	19 20       	jnz	$+52     	;abs 0xf53c
    f50a:	30 40 00 f0 	br	#0xf000		;
    f50e:	30 40 ec f4 	br	#0xf4ec		;

0000f512 <.L67>:
    f512:	3e 50 00 6a 	add	#27136,	r14	;#0x6a00
    f516:	3f 63       	addc	#-1,	r15	;r3 As==11
    f518:	1c 53       	inc	r12		;
    f51a:	30 40 a0 f3 	br	#0xf3a0		;

0000f51e <.L73>:
    f51e:	6a 93       	cmp.b	#2,	r10	;r3 As==10
    f520:	02 24       	jz	$+6      	;abs 0xf526
    f522:	6a 92       	cmp.b	#4,	r10	;r2 As==10
    f524:	07 20       	jnz	$+16     	;abs 0xf534

0000f526 <.L70>:
    f526:	b0 12 c2 f5 	call	#-2622		;#0xf5c2

0000f52a <.L72>:
    f52a:	5a 53       	inc.b	r10		;
    f52c:	3a f0 ff 00 	and	#255,	r10	;#0x00ff
    f530:	30 40 ae f3 	br	#0xf3ae		;

0000f534 <.L71>:
    f534:	12 c3       	clrc			
    f536:	0c 10       	rrc	r12		;
    f538:	30 40 2a f5 	br	#0xf52a		;

0000f53c <.L79>:
    f53c:	7a 90 68 00 	cmp.b	#104,	r10	;#0x0068
    f540:	05 20       	jnz	$+12     	;abs 0xf54c
    f542:	3c 40 7b f7 	mov	#-2181,	r12	;#0xf77b

0000f546 <.L95>:
    f546:	89 12       	call	r9		;
    f548:	30 40 ec f4 	br	#0xf4ec		;

0000f54c <.L81>:
    f54c:	7a 90 75 00 	cmp.b	#117,	r10	;#0x0075
    f550:	05 20       	jnz	$+12     	;abs 0xf55c
    f552:	4c 43       	clr.b	r12		;

0000f554 <.L96>:
    f554:	b0 12 b6 f2 	call	#-3402		;#0xf2b6
    f558:	30 40 ec f4 	br	#0xf4ec		;

0000f55c <.L82>:
    f55c:	7a 90 70 00 	cmp.b	#112,	r10	;#0x0070
    f560:	c5 27       	jz	$-116    	;abs 0xf4ec
    f562:	7a 90 65 00 	cmp.b	#101,	r10	;#0x0065
    f566:	03 20       	jnz	$+8      	;abs 0xf56e
    f568:	5c 43       	mov.b	#1,	r12	;r3 As==01
    f56a:	30 40 54 f5 	br	#0xf554		;

0000f56e <.L83>:
    f56e:	7a 90 73 00 	cmp.b	#115,	r10	;#0x0073
    f572:	03 20       	jnz	$+8      	;abs 0xf57a
    f574:	86 12       	call	r6		;
    f576:	30 40 ec f4 	br	#0xf4ec		;

0000f57a <.L84>:
    f57a:	3c 40 e9 f7 	mov	#-2071,	r12	;#0xf7e9
    f57e:	30 40 46 f5 	br	#0xf546		;

0000f582 <__mspabi_func_epilog_7>:
    f582:	34 41       	pop	r4		;

0000f584 <__mspabi_func_epilog_6>:
    f584:	35 41       	pop	r5		;

0000f586 <__mspabi_func_epilog_5>:
    f586:	36 41       	pop	r6		;

0000f588 <__mspabi_func_epilog_4>:
    f588:	37 41       	pop	r7		;

0000f58a <__mspabi_func_epilog_3>:
    f58a:	38 41       	pop	r8		;

0000f58c <__mspabi_func_epilog_2>:
    f58c:	39 41       	pop	r9		;

0000f58e <__mspabi_func_epilog_1>:
    f58e:	3a 41       	pop	r10		;
    f590:	30 41       	ret			

0000f592 <__mspabi_srli_15>:
    f592:	12 c3       	clrc			
    f594:	0c 10       	rrc	r12		;

0000f596 <__mspabi_srli_14>:
    f596:	12 c3       	clrc			
    f598:	0c 10       	rrc	r12		;

0000f59a <__mspabi_srli_13>:
    f59a:	12 c3       	clrc			
    f59c:	0c 10       	rrc	r12		;

0000f59e <__mspabi_srli_12>:
    f59e:	12 c3       	clrc			
    f5a0:	0c 10       	rrc	r12		;

0000f5a2 <__mspabi_srli_11>:
    f5a2:	12 c3       	clrc			
    f5a4:	0c 10       	rrc	r12		;

0000f5a6 <__mspabi_srli_10>:
    f5a6:	12 c3       	clrc			
    f5a8:	0c 10       	rrc	r12		;

0000f5aa <__mspabi_srli_9>:
    f5aa:	12 c3       	clrc			
    f5ac:	0c 10       	rrc	r12		;

0000f5ae <__mspabi_srli_8>:
    f5ae:	12 c3       	clrc			
    f5b0:	0c 10       	rrc	r12		;

0000f5b2 <__mspabi_srli_7>:
    f5b2:	12 c3       	clrc			
    f5b4:	0c 10       	rrc	r12		;

0000f5b6 <__mspabi_srli_6>:
    f5b6:	12 c3       	clrc			
    f5b8:	0c 10       	rrc	r12		;

0000f5ba <__mspabi_srli_5>:
    f5ba:	12 c3       	clrc			
    f5bc:	0c 10       	rrc	r12		;

0000f5be <__mspabi_srli_4>:
    f5be:	12 c3       	clrc			
    f5c0:	0c 10       	rrc	r12		;

0000f5c2 <__mspabi_srli_3>:
    f5c2:	12 c3       	clrc			
    f5c4:	0c 10       	rrc	r12		;

0000f5c6 <__mspabi_srli_2>:
    f5c6:	12 c3       	clrc			
    f5c8:	0c 10       	rrc	r12		;

0000f5ca <__mspabi_srli_1>:
    f5ca:	12 c3       	clrc			
    f5cc:	0c 10       	rrc	r12		;
    f5ce:	30 41       	ret			

0000f5d0 <.L11>:
    f5d0:	3d 53       	add	#-1,	r13	;r3 As==11
    f5d2:	12 c3       	clrc			
    f5d4:	0c 10       	rrc	r12		;

0000f5d6 <__mspabi_srli>:
    f5d6:	0d 93       	cmp	#0,	r13	;r3 As==00
    f5d8:	fb 23       	jnz	$-8      	;abs 0xf5d0
    f5da:	30 41       	ret			

0000f5dc <__mspabi_srll_15>:
    f5dc:	12 c3       	clrc			
    f5de:	0d 10       	rrc	r13		;
    f5e0:	0c 10       	rrc	r12		;

0000f5e2 <__mspabi_srll_14>:
    f5e2:	12 c3       	clrc			
    f5e4:	0d 10       	rrc	r13		;
    f5e6:	0c 10       	rrc	r12		;

0000f5e8 <__mspabi_srll_13>:
    f5e8:	12 c3       	clrc			
    f5ea:	0d 10       	rrc	r13		;
    f5ec:	0c 10       	rrc	r12		;

0000f5ee <__mspabi_srll_12>:
    f5ee:	12 c3       	clrc			
    f5f0:	0d 10       	rrc	r13		;
    f5f2:	0c 10       	rrc	r12		;

0000f5f4 <__mspabi_srll_11>:
    f5f4:	12 c3       	clrc			
    f5f6:	0d 10       	rrc	r13		;
    f5f8:	0c 10       	rrc	r12		;

0000f5fa <__mspabi_srll_10>:
    f5fa:	12 c3       	clrc			
    f5fc:	0d 10       	rrc	r13		;
    f5fe:	0c 10       	rrc	r12		;

0000f600 <__mspabi_srll_9>:
    f600:	12 c3       	clrc			
    f602:	0d 10       	rrc	r13		;
    f604:	0c 10       	rrc	r12		;

0000f606 <__mspabi_srll_8>:
    f606:	12 c3       	clrc			
    f608:	0d 10       	rrc	r13		;
    f60a:	0c 10       	rrc	r12		;

0000f60c <__mspabi_srll_7>:
    f60c:	12 c3       	clrc			
    f60e:	0d 10       	rrc	r13		;
    f610:	0c 10       	rrc	r12		;

0000f612 <__mspabi_srll_6>:
    f612:	12 c3       	clrc			
    f614:	0d 10       	rrc	r13		;
    f616:	0c 10       	rrc	r12		;

0000f618 <__mspabi_srll_5>:
    f618:	12 c3       	clrc			
    f61a:	0d 10       	rrc	r13		;
    f61c:	0c 10       	rrc	r12		;

0000f61e <__mspabi_srll_4>:
    f61e:	12 c3       	clrc			
    f620:	0d 10       	rrc	r13		;
    f622:	0c 10       	rrc	r12		;

0000f624 <__mspabi_srll_3>:
    f624:	12 c3       	clrc			
    f626:	0d 10       	rrc	r13		;
    f628:	0c 10       	rrc	r12		;

0000f62a <__mspabi_srll_2>:
    f62a:	12 c3       	clrc			
    f62c:	0d 10       	rrc	r13		;
    f62e:	0c 10       	rrc	r12		;

0000f630 <__mspabi_srll_1>:
    f630:	12 c3       	clrc			
    f632:	0d 10       	rrc	r13		;
    f634:	0c 10       	rrc	r12		;
    f636:	30 41       	ret			

0000f638 <.L12>:
    f638:	3e 53       	add	#-1,	r14	;r3 As==11
    f63a:	12 c3       	clrc			
    f63c:	0d 10       	rrc	r13		;
    f63e:	0c 10       	rrc	r12		;

0000f640 <__mspabi_srll>:
    f640:	0e 93       	cmp	#0,	r14	;r3 As==00
    f642:	fa 23       	jnz	$-10     	;abs 0xf638
    f644:	30 41       	ret			
    f646:	42 6f       	addc.b	r15,	r2	;
    f648:	6f 74       	subc.b	@r4,	r15	;
    f64a:	69 6e       	addc.b	@r14,	r9	;
    f64c:	67 2e       	jc	$-816    	;abs 0xf31c
    f64e:	2e 2e       	jc	$-930    	;abs 0xf2ac
    f650:	0a 0a       	mova	@r10,	r10	;
    f652:	00 50       	rla	r0		;
    f654:	6f 74       	subc.b	@r4,	r15	;
    f656:	65 6e       	addc.b	@r14,	r5	;
    f658:	74 69       	addc.b	@r9+,	r4	;
    f65a:	61 6c       	addc.b	@r12,	r1	;
    f65c:	6c 79       	subc.b	@r9,	r12	;
    f65e:	20 69       	addc	@r9,	r0	;
    f660:	6e 76       	subc.b	@r6,	r14	;
    f662:	61 6c       	addc.b	@r12,	r1	;
    f664:	69 64       	addc.b	@r4,	r9	;
    f666:	20 69       	addc	@r9,	r0	;
    f668:	6d 61       	addc.b	@r1,	r13	;
    f66a:	67 65       	addc.b	@r5,	r7	;
    f66c:	2e 20       	jnz	$+94     	;abs 0xf6ca
    f66e:	42 6f       	addc.b	r15,	r2	;
    f670:	6f 74       	subc.b	@r4,	r15	;
    f672:	20 61       	addc	@r1,	r0	;
    f674:	6e 79       	subc.b	@r9,	r14	;
    f676:	77 61       	addc.b	@r1+,	r7	;
    f678:	79 20       	jnz	$+244    	;abs 0xf76c
    f67a:	28 79       	subc	@r9,	r8	;
    f67c:	2f 6e       	addc	@r14,	r15	;
    f67e:	29 3f       	jmp	$-428    	;abs 0xf4d2
    f680:	20 00 07 0a 	bra	&2567		;0x00a07
    f684:	45 52       	add.b	r2,	r5	;
    f686:	52 4f 52 20 	mov.b	8274(r15),r2	;0x02052
    f68a:	00 41       	br	r1		;
    f68c:	77 61       	addc.b	@r1+,	r7	;
    f68e:	69 74       	subc.b	@r4,	r9	;
    f690:	69 6e       	addc.b	@r14,	r9	;
    f692:	67 20       	jnz	$+208    	;abs 0xf762
    f694:	42 49       	mov.b	r9,	r2	;
    f696:	4e 45       	mov.b	r5,	r14	;
    f698:	58 45 2e 2e 	mov.b	11822(r5),r8	;0x02e2e
    f69c:	2e 20       	jnz	$+94     	;abs 0xf6fa
    f69e:	00 4c       	br	r12		;
    f6a0:	6f 61       	addc.b	@r1,	r15	;
    f6a2:	64 69       	addc.b	@r9,	r4	;
    f6a4:	6e 67       	addc.b	@r7,	r14	;
    f6a6:	2e 2e       	jc	$-930    	;abs 0xf304
    f6a8:	2e 20       	jnz	$+94     	;abs 0xf706
    f6aa:	00 4f       	br	r15		;
    f6ac:	4b 00       	rrcm.a	#1,	r11	;
    f6ae:	0a 0a       	mova	@r10,	r10	;
    f6b0:	4e 45       	mov.b	r5,	r14	;
    f6b2:	4f 34       	jge	$+160    	;abs 0xf752
    f6b4:	33 30       	jn	$+104    	;abs 0xf71c
    f6b6:	20 42       	br	#4		;r2 As==10
    f6b8:	6f 6f       	addc.b	@r15,	r15	;
    f6ba:	74 6c       	addc.b	@r12+,	r4	;
    f6bc:	6f 61       	addc.b	@r1,	r15	;
    f6be:	64 65       	addc.b	@r5,	r4	;
    f6c0:	72 20       	jnz	$+230    	;abs 0xf7a6
    f6c2:	56 32       	jn	$-850    	;abs 0xf370
    f6c4:	30 31       	jn	$+610    	;abs 0xf926
    f6c6:	37 31       	jn	$+624    	;abs 0xf936
    f6c8:	32 32       	jn	$-922    	;abs 0xf32e
    f6ca:	38 20       	jnz	$+114    	;abs 0xf73c
    f6cc:	62 79       	subc.b	@r9,	r2	;
    f6ce:	20 53       	incd	r0		;
    f6d0:	74 65       	addc.b	@r5+,	r4	;
    f6d2:	70 68       	addc.b	@r8+,	r0	;
    f6d4:	61 6e       	addc.b	@r14,	r1	;
    f6d6:	20 4e       	br	@r14		;
    f6d8:	6f 6c       	addc.b	@r12,	r15	;
    f6da:	74 69       	addc.b	@r9+,	r4	;
    f6dc:	6e 67       	addc.b	@r7,	r14	;
    f6de:	0a 00       	mova	@r0,	r10	;
    f6e0:	41 64       	addc.b	r4,	r1	;
    f6e2:	6f 70       	subc.b	@r0,	r15	;
    f6e4:	74 65       	addc.b	@r5+,	r4	;
    f6e6:	64 20       	jnz	$+202    	;abs 0xf7b0
    f6e8:	66 6f       	addc.b	@r15,	r6	;
    f6ea:	72 20       	jnz	$+230    	;abs 0xf7d0
    f6ec:	49 32       	jn	$-876    	;abs 0xf380
    f6ee:	43 20       	jnz	$+136    	;abs 0xf776
    f6f0:	45 45       	mov.b	r5,	r5	;
    f6f2:	50 52 4f 4d 	add.b	&0x4d4f,r0	;0x4d4f
    f6f6:	20 62       	addc	#4,	r0	;r2 As==10
    f6f8:	79 20       	jnz	$+244    	;abs 0xf7ec
    f6fa:	5a 79 64 72 	subc.b	29284(r9),r10	;0x07264
    f6fe:	75 6e       	addc.b	@r14+,	r5	;
    f700:	61 73       	subc.b	#2,	r1	;r3 As==10
    f702:	20 54       	add	@r4,	r0	;
    f704:	61 6d       	addc.b	@r13,	r1	;
    f706:	6f 73       	subc.b	#2,	r15	;r3 As==10
    f708:	65 76       	subc.b	@r6,	r5	;
    f70a:	69 63       	addc.b	#2,	r9	;r3 As==10
    f70c:	69 75       	subc.b	@r5,	r9	;
    f70e:	73 20       	jnz	$+232    	;abs 0xf7f6
    f710:	56 32       	jn	$-850    	;abs 0xf3be
    f712:	30 31       	jn	$+610    	;abs 0xf974
    f714:	38 30       	jn	$+114    	;abs 0xf786
    f716:	31 31       	jn	$+612    	;abs 0xf97a
    f718:	37 0a 0a 48 	mova	18442(r10),r7	;0x0480a
    f71c:	57 56 3a 20 	add.b	8250(r6),r7	;0x0203a
    f720:	30 78       	subc	@r8+,	r0	;
    f722:	00 0a       	bra	@r10		;
    f724:	
Disassembly of section .comment:

00000000 <.comment>:
   0:	47 43       	clr.b	r7		;
   2:	43 3a       	jl	$-888    	;abs 0xfffffc8a
   4:	20 28       	jnc	$+66     	;abs 0x46
   6:	4d 69       	addc.b	r9,	r13	;
   8:	74 74       	subc.b	@r4+,	r4	;
   a:	6f 20       	jnz	$+224    	;abs 0xea
   c:	
Disassembly of section .MSP430.attributes:

00000000 <.MSP430.attributes>:
   0:	41 16       	popm.a	#5,	r5	;20-bit words
   2:	00 00       	beq			
   4:	00 6d       	addc	r13,	r0	;
   6:	