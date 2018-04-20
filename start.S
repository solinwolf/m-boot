
	.word 0x2000
	.word 0x0
	.word 0x0
	.word 0x0
.globl _start
_start: b	reset
	ldr	pc, _undefined_instruction
	ldr	pc, _software_interrupt
	ldr	pc, _prefetch_abort
	ldr	pc, _data_abort
	ldr	pc, _not_used
	ldr	pc, _irq
	ldr	pc, _fiq

_undefined_instruction:
	.word undefined_instruction
_software_interrupt:
	.word software_interrupt
_prefetch_abort:
	.word prefetch_abort
_data_abort:
	.word data_abort
_not_used:
	.word not_used
_irq:
	.word irq
_fiq:
	.word fiq
	
	
reset:
#if 0
	/*
	 * set the cpu to SVC32 mode and IRQ & FIQ disable
	 */
	mrs	r0, cpsr
	bic	r0, r0, #0x3f
	orr	r0, r0, #0xd3
	msr	cpsr, r0
#else//*****ly
	mrs	r0, cpsr
	bic	r0, r0, #0x1f
	orr	r0, r0, #0xd3
	msr	cpsr,r0
#endif
#if 1 //*****ly
cache_init:
	mrc	p15, 0, r0, c0, c0, 0	@ read main ID register
	and	r1, r0, #0x00f00000	@ variant
	and	r2, r0, #0x0000000f	@ revision
	orr	r2, r2, r1, lsr #20-4	@ combine variant and revision
	cmp	r2, #0x30
	mrceq	p15, 0, r0, c1, c0, 1	@ read ACTLR
	orreq	r0, r0, #0x6		@ Enable DP1(2), DP2(1)
	mcreq	p15, 0, r0, c1, c0, 1	@ write ACTLR
	/*
	 * Invalidate L1 I/D
	 */
	mov	r0, #0			@ set up for MCR
	mcr	p15, 0, r0, c8, c7, 0	@ invalidate TLBs
	mcr	p15, 0, r0, c7, c5, 0	@ invalidate icache

	/*
	 * disable MMU stuff and caches
	 */
	mrc	p15, 0, r0, c1, c0, 0
	bic	r0, r0, #0x00002000	@ clear bits 13 (--V-)
	bic	r0, r0, #0x00000007	@ clear bits 2:0 (-CAM)
	orr	r0, r0, #0x00001000	@ set bit 12 (---I) Icache
	orr	r0, r0, #0x00000002	@ set bit 1  (--A-) Align
	orr	r0, r0, #0x00000800	@ set bit 11 (Z---) BTB
	mcr	p15, 0, r0, c1, c0, 0
#endif


    /* LED Test Code */
	#if 1
	ldr r0, =0x11000100  /* GPL2(0)  */
	ldr r1, =0x00000001  /* GPL2(0 output high	*/
	str r1, [r0]
	
	ldr r0, =0x11000104  /* GPL2(0)  */
	ldr r1, =0x00000000  /* GPL2(0 output high	*/
	str r1, [r0]
	
	ldr r0, =0x11000060  /* GPK2(0)  */
	ldr r1, =0x00000010  /* GPK2(0 output high	*/
	str r1, [r0]
	
	ldr r0, =0x11000064  /* GPK2(0)  */
	ldr r1, =0x00000002  /* GPK2(0 output high	*/
	str r1, [r0]


    #endif
	#if 1
	@disable watch dog
    ldr r0, =0x10060000
    mov r1,#0
    str r1, [r0]
halt:
	b halt
	#endif

undefined_instruction:
	nop
	
software_interrupt:
	nop
	
prefetch_abort:
	nop
data_abort:
	nop
not_used:
	nop
irq:
	nop
fiq:
	nop
	
