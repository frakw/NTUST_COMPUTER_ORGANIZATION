.data #�O�����ܼƫŧi
array: .space 400 #�x�s��J���}�C�A�̦h100�ӡA�C�ӬOint�j�p(4byte)�A�ҥH�`�@100*4 = 400
input_string: .space 1024 #�x�s��J�r��


.macro print_int (%x) #�Ω�L�X�Ʀr�������A²�Ƶ{���X
li $v0,1 #�]�wsyscall�Ҧ��� �L�X�Ʀr
add $a0,$zero,%x #�N%x�Ȧs�����ȼg��a0�Ȧs��(syscall�W�w)
syscall #�I�ssyscall �L�X�Ʀr
.end_macro

.macro print_str (%str) #�Ω�L�X�r�ꪺ�����A²�Ƶ{���X
.data
myLabel: .asciiz %str #�ŧi�Ȧs���r��
.text
li $v0, 4 #�]�wsyscall�Ҧ��� �L�X�r��
la $a0, myLabel #�N�r�ꪺ�O�����}�g��a0�Ȧs��(syscall�W�w)
syscall #�I�ssyscall �L�X�r��
.end_macro


.text #�ջy�{���X
	print_str("Please input array A:\n")
	
	li $v0, 8 #�]�wsyscall�Ҧ��� Ū���r��
	la $a0, input_string #�N�n�s�񪺰O�����}�g��a0�Ȧs��(syscall�W�w)
	li $a1, 1024 #�]�w�r��Ū���̤j����(syscall�W�w)
	syscall
	
	li $t0, 0 #t0�Ȧs�������]��string�����Ӧ�m(index)	
	li $t1, 0 #t1�Ȧs���Ȧs�C��Ū�����r��(ascii code)
	li $t2, 0 #t2�Ȧs���x�s���G
	la $s0,array #s0�Ȧs���x�s�}�C���O�����}�A�Ω�]�L�}�C���C��element(index)
	li $s1, 0 #�����ƦrŪ�����ƪ��Ȧs���A�s��}�C���X�Ӥ���
	li $s2, 0 #�����O�Ѥj�Ӥp(0)�ΥѤp�Ӥj(1)�A�Ω�P�_�}�C�O�_�w�ƧǦn
	
	lb $t1,input_string($t0)
	beq $t1,'\n',LOOP1_END
	beq $t1,'\0',LOOP1_END
	jal read_int
	sw $t2,($s0)
	move $t3,$t2
	addi $s1,$s1,1
	addi $s0,$s0,4
	
	
	lb $t1,input_string($t0)
	beq $t1,'\n',LOOP1_END
	beq $t1,'\0',LOOP1_END
	jal read_int
	sw $t2,($s0)
	move $t4,$t2
	addi $s1,$s1,1
	addi $s0,$s0,4
	
	bgt $t4,$t3,FIRST_SMALL_TO_BIG
	j LOOP1
	FIRST_SMALL_TO_BIG:
	li $s2, 1
		
	LOOP1:
		lb $t1,input_string($t0)
		beq $t1,'\n',LOOP1_END
		beq $t1,'\0',LOOP1_END
		jal read_int
		sw $t2,($s0)
		lw $t3,-4($s0)
		bgt $t2,$t3,SMALL_TO_BIG
		BIG_TO_SMALL:
			beq $s2,0,NEXT_LOOP1
			j NOT_SORTED
		SMALL_TO_BIG:
			beq $s2,1,NEXT_LOOP1
			j NOT_SORTED
		
		NEXT_LOOP1:
		addi $s1,$s1,1
		addi $s0,$s0,4
		j LOOP1
		NOT_SORTED:
		print_str("Error! The array is not sorted.\n")
		j PROGRAM_END
	LOOP1_END:
	
	#print_int($s1)
	print_str("Please input a key value:\n")
	li $v0,5
	syscall	
	li $t0,1
	move $t1,$v0
	li $t2,0
	move $t3,$s1
	subi $t3,$t3,1
	li $t6,0 #greater(1) or smaller(0)
	WHILE1:
		print_str("Step ")
		print_int($t0)
		addi $t0,$t0,1
		print_str(": ")		
		bgt $t2,$t3,NOT_FOUND
		add $t4,$t3,$t2
		div $t4,$t4,2
		print_str("A[")
		print_int($t4)
		print_str("] ")
		mul $s0,$t4,4
		lw $t5,array($s0)
		bgt $t5,$t1,BIGGER
		blt $t5,$t1,SMALLER
		EQUAL:
			print_str("= ")
			print_int($t1)
		j WHILE1_END
		BIGGER:
			li $t6,1
			print_str("> ")
		j NEXT_WHILE1
		SMALLER:
			li $t6,0
			print_str("< ")
		NEXT_WHILE1:
		print_int($t1)
		print_str("\n")
		beq $s2,$t6,BACKWARD
		FORWARD:
			move $t2,$t4
			addi $t2,$t2,1
		j WHILE1
		BACKWARD:
			move $t3,$t4
			subi $t3,$t3,1
		j WHILE1
		NOT_FOUND:
		print_str("Not found!\n")
	WHILE1_END:
	
	
PROGRAM_END:
li $v0, 10 #�]�wsyscall�Ҧ��� ���}�{��
syscall #�I�ssyscall ���}�{��

read_int:#Ū���Ʀrfunction�A�D�n�O�Ω��t2�Ȧs���k�s�A�H�קK�I�s���j�e�S���k�s
	addi $sp, $sp, -4 #�ЫإXstack�Apush stack
	sw $ra, 0($sp) #�x�sreturn�I�s��m
	li $t2, 0 #��t2�Ȧs���k�s
	jal read_int_recursive #�I�s���jŪ���Ʀr
	lw $ra, 0($sp) #�qstack��Ū��return�I�s��m
	addi $sp, $sp,4 #�M��stack�Apop stack
jr $ra #��^�I�s��m


read_int_recursive: #���jŪ���Ҧ��Ʀrfunction
	addi $sp, $sp, -4 #�ЫإXstack�Apush stack
	sw $ra, 0($sp) #�x�sreturn�I�s��m
	
	add $t4,$a0,$t0 #�r��Ū����O�����}�s�ba0�A�[�Windex(t0) offset�첾�q��o�쥿�T�O�����}�A�s�Jt4�Ȧs��
	lb $t1,0($t4) #�q�O�����}�����X1byte�r��(char�Bascii code)�A�s��t1�Ȧs��
	addi $t0,$t0,1 #�r���m+1�A���U�@�����jŪ���U�Ӧr��
	IF_1: bne $t1,'-',ELSEIF_1_1 #�p�G�Ӧr�����t���ɡA���jŪ���U�h�A��^�e���W-1
		jal read_int_recursive #���j�I�sŪ���Ʀrfunction
		mul $t2,$t2,-1 #���j���G���W-1
	j ENDIF_1 #����if����

	ELSEIF_1_1: bne $t1,',',ELSEIF_1_2 #�p�G�Ӧr�����r���ɡA�������j
		
	j ENDIF_1 #����if����

	ELSEIF_1_2: bne $t1,'\n',ELSEIF_1_3 #�p�G�Ӧr��������ɡA�������j
		
	j ENDIF_1 #����if����
	
	ELSEIF_1_3: bne $t1,'\0',ELSE_1 #�p�G�Ӧr�����r��ɡA�������j�A�ñN�r��Ū��index-1�A�קK����Ū���ɶW�X�d��
			subi $t0,$t0,1 #�r��Ū��index-1�A�קK����Ū���ɶW�X�d��
	j ENDIF_1 #����if����
	
	ELSE_1: #�p�G�Ӧr�����Ʀr�ɡA�N���e���j���֥[���G���W10�A�å[�W�sŪ�����Ʀr�A�M���~�򻼰jŪ���U�h
		sub $t1,$t1,'0' #�N�Ʀr�r�������Ʀr0�r���o��Ʀr�A�r����Ʀr
		mul $t2,$t2,10 #�N���e���j���֥[���G���W10
		add $t2,$t2,$t1 #�[�W�sŪ�����Ʀr		
		jal read_int_recursive #���j�I�sŪ���Ʀrfunction
	j ENDIF_1 #����if����

	ENDIF_1: #if����
	
	lw $ra, 0($sp) #�qstack��Ū��return�I�s��m
	addi $sp, $sp,4 #�M��stack�Apop stack
jr $ra #��^�I�s��m
