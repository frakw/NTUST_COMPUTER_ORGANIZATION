	.file	"variable.cpp"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	global_init
	.section	.sdata,"aw"
	.align	2
	.type	global_init, @object
	.size	global_init, 4
global_init:
	.word	87
	.globl	global_non_init
	.section	.sbss,"aw",@nobits
	.align	2
	.type	global_non_init, @object
	.size	global_non_init, 4
global_non_init:
	.zero	4
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	addi	sp,sp,-32
	.cfi_def_cfa_offset 32
	sw	ra,28(sp)
	sw	s0,24(sp)
	.cfi_offset 1, -4
	.cfi_offset 8, -8
	addi	s0,sp,32
	.cfi_def_cfa 8, 0
	li	a5,66
	sw	a5,-20(s0)
	li	a0,40
	call	_Znaj
	mv	a5,a0
	sw	a5,-24(s0)
	call	_Z8functionv
	li	a5,0
	mv	a0,a5
	lw	ra,28(sp)
	.cfi_restore 1
	lw	s0,24(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 32
	addi	sp,sp,32
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.sdata
	.align	2
	.type	_ZZ8functionvE20static_variable_init, @object
	.size	_ZZ8functionvE20static_variable_init, 4
_ZZ8functionvE20static_variable_init:
	.word	1
	.local	_ZZ8functionvE24static_variable_non_init
	.comm	_ZZ8functionvE24static_variable_non_init,4,4
	.text
	.align	1
	.globl	_Z8functionv
	.type	_Z8functionv, @function
_Z8functionv:
.LFB1:
	.cfi_startproc
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sw	s0,12(sp)
	.cfi_offset 8, -4
	addi	s0,sp,16
	.cfi_def_cfa 8, 0
	nop
	lw	s0,12(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 16
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE1:
	.size	_Z8functionv, .-_Z8functionv
	.ident	"GCC: (GNU) 10.2.0"
