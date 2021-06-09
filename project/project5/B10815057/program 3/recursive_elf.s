	.file	"recursive.cpp"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.srodata,"a"
	.align	2
	.type	_ZStL19piecewise_construct, @object
	.size	_ZStL19piecewise_construct, 1
_ZStL19piecewise_construct:
	.zero	1
	.text
	.align	1
	.type	_ZL20__gthread_key_deletei, @function
_ZL20__gthread_key_deletei:
.LFB484:
	.cfi_startproc
	addi	sp,sp,-32
	.cfi_def_cfa_offset 32
	sw	s0,28(sp)
	.cfi_offset 8, -4
	addi	s0,sp,32
	.cfi_def_cfa 8, 0
	sw	a0,-20(s0)
	li	a5,0
	mv	a0,a5
	lw	s0,28(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 32
	addi	sp,sp,32
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE484:
	.size	_ZL20__gthread_key_deletei, .-_ZL20__gthread_key_deletei
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,4
	.align	1
	.globl	_Z3fibi
	.type	_Z3fibi, @function
_Z3fibi:
.LFB1540:
	.cfi_startproc
	addi	sp,sp,-32
	.cfi_def_cfa_offset 32
	sw	ra,28(sp)
	sw	s0,24(sp)
	sw	s1,20(sp)
	.cfi_offset 1, -4
	.cfi_offset 8, -8
	.cfi_offset 9, -12
	addi	s0,sp,32
	.cfi_def_cfa 8, 0
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	bne	a5,zero,.L4
	li	a5,0
	j	.L5
.L4:
	lw	a4,-20(s0)
	li	a5,1
	bne	a4,a5,.L6
	li	a5,1
	j	.L5
.L6:
	lw	a5,-20(s0)
	addi	a5,a5,-1
	mv	a0,a5
	call	_Z3fibi
	mv	s1,a0
	lw	a5,-20(s0)
	addi	a5,a5,-2
	mv	a0,a5
	call	_Z3fibi
	mv	a5,a0
	add	a5,s1,a5
.L5:
	mv	a0,a5
	lw	ra,28(sp)
	.cfi_restore 1
	lw	s0,24(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 32
	lw	s1,20(sp)
	.cfi_restore 9
	addi	sp,sp,32
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE1540:
	.size	_Z3fibi, .-_Z3fibi
	.section	.rodata
	.align	2
.LC0:
	.string	"Please input an integer to show the last value of Fibonacci Sequence :\n"
	.align	2
.LC1:
	.string	"The Fibonacci Sequence is "
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
.LFB1541:
	.cfi_startproc
	addi	sp,sp,-32
	.cfi_def_cfa_offset 32
	sw	ra,28(sp)
	sw	s0,24(sp)
	sw	s1,20(sp)
	.cfi_offset 1, -4
	.cfi_offset 8, -8
	.cfi_offset 9, -12
	addi	s0,sp,32
	.cfi_def_cfa 8, 0
	lui	a5,%hi(.LC0)
	addi	a1,a5,%lo(.LC0)
	lui	a5,%hi(_ZSt4cout)
	addi	a0,a5,%lo(_ZSt4cout)
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	addi	a5,s0,-20
	mv	a1,a5
	lui	a5,%hi(_ZSt3cin)
	addi	a0,a5,%lo(_ZSt3cin)
	call	_ZNSirsERi
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	lui	a5,%hi(_ZSt4cout)
	addi	a0,a5,%lo(_ZSt4cout)
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	mv	s1,a0
	lw	a5,-20(s0)
	mv	a0,a5
	call	_Z3fibi
	mv	a5,a0
	mv	a1,a5
	mv	a0,s1
	call	_ZNSolsEi
	mv	a4,a0
	lui	a5,%hi(_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_)
	addi	a1,a5,%lo(_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_)
	mv	a0,a4
	call	_ZNSolsEPFRSoS_E
	li	a5,0
	mv	a0,a5
	lw	ra,28(sp)
	.cfi_restore 1
	lw	s0,24(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 32
	lw	s1,20(sp)
	.cfi_restore 9
	addi	sp,sp,32
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE1541:
	.size	main, .-main
	.align	1
	.type	_Z41__static_initialization_and_destruction_0ii, @function
_Z41__static_initialization_and_destruction_0ii:
.LFB2045:
	.cfi_startproc
	addi	sp,sp,-32
	.cfi_def_cfa_offset 32
	sw	ra,28(sp)
	sw	s0,24(sp)
	.cfi_offset 1, -4
	.cfi_offset 8, -8
	addi	s0,sp,32
	.cfi_def_cfa 8, 0
	sw	a0,-20(s0)
	sw	a1,-24(s0)
	lw	a4,-20(s0)
	li	a5,1
	bne	a4,a5,.L11
	lw	a4,-24(s0)
	li	a5,65536
	addi	a5,a5,-1
	bne	a4,a5,.L11
	lui	a5,%hi(_ZStL8__ioinit)
	addi	a0,a5,%lo(_ZStL8__ioinit)
	call	_ZNSt8ios_base4InitC1Ev
	lui	a5,%hi(__dso_handle)
	addi	a2,a5,%lo(__dso_handle)
	lui	a5,%hi(_ZStL8__ioinit)
	addi	a1,a5,%lo(_ZStL8__ioinit)
	lui	a5,%hi(_ZNSt8ios_base4InitD1Ev)
	addi	a0,a5,%lo(_ZNSt8ios_base4InitD1Ev)
	call	__cxa_atexit
.L11:
	nop
	lw	ra,28(sp)
	.cfi_restore 1
	lw	s0,24(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 32
	addi	sp,sp,32
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE2045:
	.size	_Z41__static_initialization_and_destruction_0ii, .-_Z41__static_initialization_and_destruction_0ii
	.align	1
	.type	_GLOBAL__sub_I__Z3fibi, @function
_GLOBAL__sub_I__Z3fibi:
.LFB2046:
	.cfi_startproc
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sw	ra,12(sp)
	sw	s0,8(sp)
	.cfi_offset 1, -4
	.cfi_offset 8, -8
	addi	s0,sp,16
	.cfi_def_cfa 8, 0
	li	a5,65536
	addi	a1,a5,-1
	li	a0,1
	call	_Z41__static_initialization_and_destruction_0ii
	lw	ra,12(sp)
	.cfi_restore 1
	lw	s0,8(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 16
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE2046:
	.size	_GLOBAL__sub_I__Z3fibi, .-_GLOBAL__sub_I__Z3fibi
	.section	.init_array,"aw"
	.align	2
	.word	_GLOBAL__sub_I__Z3fibi
	.hidden	__dso_handle
	.ident	"GCC: (GNU) 10.2.0"
