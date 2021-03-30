.data #�O�����ܼƫŧi
array: .space 400 #�x�s��J���}�C�A�̦h100�ӡA�C�ӬOint�j�p(4byte)�A�ҥH�`�@100*4 = 400
input_string: .space 1024 #�x�s��J�r��A���]�w�j�p�A�_�h�ɭP��������D


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
	###############################�}�CŪ�����q###############################
	print_str("Please input array A:\n") #�L�X��J�}�C����
	
	li $v0, 8 #�]�wsyscall�Ҧ��� Ū���r��
	la $a0, input_string #�N�n�s�񪺰O�����}�g��a0�Ȧs��(syscall�W�w)
	li $a1, 1024 #�]�w�r��Ū���̤j����(syscall�W�w)
	syscall #�I�ssyscall �L�X�r��
	
	li $t0, 0 #t0�Ȧs�������]��string�����Ӧ�m(index)	
	li $t1, 0 #t1�Ȧs���Ȧs�C��Ū�����r��(ascii code)
	li $t2, 0 #t2�Ȧs���x�s���G
	la $s0,array #s0�Ȧs���x�s�}�C���O�����}�A�Ω�]�L�}�C���C��element(index)
	li $s1, 0 #�����ƦrŪ�����ƪ��Ȧs���A�s��}�C���X�Ӥ���
	li $s2, 0 #�����O�Ѥj�Ӥp(0)�ΥѤp�Ӥj(1)�A�Ω�P�_�}�C�O�_�w�ƧǦn
	
	#���F���j��i�H���Q�P�_�}�C�O�_�w�ƧǡA�n���N�}�Y2�ӼƦrŪ�X�A�çP�_�O�Ѥj��p�ΥѤp��j
	
	#Ū���}�C�Ĥ@�ӼƦr
	lb $t1,input_string($t0) #Ū���r�ꪺ�U�@�Ӧr���A�T�{�O�_�w��r�굲��
	beq $t1,'\n',LOOP1_END #�P�_�O�_������A�p�G�O�A�����i�J�j�M���q
	beq $t1,'\0',LOOP1_END #�P�_�O�_���r�굲���A�p�G�O�A�����i�J�j�M���q
	jal read_int #Ū���Ʀrfunction�A���G�s��t2
	sw $t2,($s0) #�qt2Ū�X�A�s�J�}�C�O�����}(s0)
	move $t3,$t2 #�ѩ�t2�����G�|�Q�л\�A�ҥH�ƻs�@����t3�A�Ω󤧫᪺�P�_�j�p
	addi $s1,$s1,1 #�}�C�Ӽ�+1
	addi $s0,$s0,4 #�}�C�O�����}�e���U�@��index����(+1��int������)
	
	#Ū���}�C�ĤG�ӼƦr
	lb $t1,input_string($t0) #Ū���r�ꪺ�U�@�Ӧr���A�T�{�O�_�w��r�굲��
	beq $t1,'\n',LOOP1_END #�P�_�O�_������A�p�G�O�A�����i�J�j�M���q
	beq $t1,'\0',LOOP1_END #�P�_�O�_���r�굲���A�p�G�O�A�����i�J�j�M���q
	jal read_int #Ū���Ʀrfunction�A���G�s��t2
	sw $t2,($s0) #�qt2Ū�X�A�s�J�}�C�O�����}(s0)
	move $t4,$t2 #�ѩ�t2�����G�|�Q�л\�A�ҥH�ƻs�@����t4�A�Ω󤧫᪺�P�_�j�p
	addi $s1,$s1,1 #�}�C�Ӽ�+1
	addi $s0,$s0,4 #�}�C�O�����}�e���U�@��index����(+1��int������)
	
	bgt $t4,$t3,FIRST_SMALL_TO_BIG #�P�_�Y2�ӼƦr�O�Ѥj��p�ΥѤp��j�A����Ū�J���Ʀr�Y���ŦX�����P�_�A�Y�i�T�{�}�C���Ƨ�
	li $s2, 0 #�Ѥj��p�As2�]��0
	j LOOP1 #�קK�]��Ѥp��j���϶��̡A�����i�J�}�CŪ���j��
	FIRST_SMALL_TO_BIG:
	li $s2, 1 #�Ѥp��j�As2�]��1
		
	LOOP1: #�}�CŪ���j��
		lb $t1,input_string($t0) #Ū���r�ꪺ�U�@�Ӧr���A�T�{�O�_�w��r�굲��
		beq $t1,'\n',LOOP1_END #�P�_�O�_������A�p�G�O�A���X�j��A�i�J�j�M���q
		beq $t1,'\0',LOOP1_END #�P�_�O�_���r�굲���A�p�G�O�A���X�j��A�i�J�j�M���q
		jal read_int #Ū���Ʀrfunction�A���G�s��t2
		sw $t2,($s0) #�qt2Ū�X�A�s�J�}�C�O�����}(s0)
		lw $t3,-4($s0) #�N�W�@�ӼƦr�q�}�C����eindex-1�BŪ�X�A�Ω�򥻦��j��Ū�J���Ʀr���
		bgt $t2,$t3,SMALL_TO_BIG #����o��Ū�J�Ʀr�P�W��Ū�J�Ʀr�j�p�A�Y�j��h�i�J�Ѥp��j�϶��A�Ϥ���M
		BIG_TO_SMALL: #�Ѥj��p�϶�
			beq $s2,0,NEXT_LOOP1 #�Y���e�]�O�Ѥj��p�A�h�i�J�~�����j��϶�
			j NOT_SORTED #�Y���e�O�Ѥp��j�A�i�J���ƧǳB�z�϶�
		SMALL_TO_BIG: #�Ѥp��j�϶�
			beq $s2,1,NEXT_LOOP1 #�Y���e�]�O�Ѥp��j�A�h�i�J�~�����j��϶�
			j NOT_SORTED #�Y���e�O�Ѥj��p�A�i�J���ƧǳB�z�϶�
		
		NEXT_LOOP1: #�~�����j��϶�
		addi $s1,$s1,1 #�}�C�Ӽ�+1
		addi $s0,$s0,4 #�}�C�O�����}�e���U�@��index����(+1��int������)
		j LOOP1 #�^��j��_�l�I�A�~�����j��
		NOT_SORTED: #���ƧǳB�z�϶�
		print_str("Error! The array is not sorted.\n") #�L�X���Ƨ�ĵ�i
		j PROGRAM_END #���ƧǡA�G���ζi�J�j�M���q�A�������ܵ{�������϶�
	LOOP1_END: #Ū���j�鵲���A�i�J�j�M���q
	
	###############################�j�M���q###############################
	
	print_str("Please input a key value:\n") #�L�X��J�j�M�ȴ���
	li $v0,5 #�]�wsyscall�Ҧ��� Ū���Ʀr
	syscall	#�I�ssyscall Ū���Ʀr
	li $t0,1 #�����B�J��(step)���Ȧs��
	move $t1,$v0 #Ū�����j�M�Ȧs�bv0�A�s�Jt1
	li $t2,0 #�_�l�j�M���ޭȳ]��0
	move $t3,$s1 #�����j�M���ޭȳ]�� �}�C�Ӽ�
	subi $t3,$t3,1 #�ѩ�}�Cindex�q0��}�C�Ӽ�-1�A�]���N�����j�M���ޭ�-1
	li $t4,0 #�x�s�����j�M���ޭ�
	li $t5,0 #�x�s������
	li $t6,0 #�s�񤤶��ȻP�j�M�Ȫ��j�p���Y�A�����ȸ��j->1�A�j�M�ȸ��j->0
	WHILE1: #�G���j�M�j��
		print_str("Step ") #�L�X�B�J�^��
		print_int($t0) #�L�X�B�J��
		addi $t0,$t0,1 #�B�J��+1
		print_str(": ")	#�L�X�_���P�ť�
		bgt $t2,$t3,NOT_FOUND #�Y�_�l�j�M���ޭȤj�󵲧��j�M���ޭȡA�h�N��䤣��ӷj�M�ȡA�i�J�䤣��϶�
		add $t4,$t3,$t2 #�_�l�j�M���ޭȥ[�W�����j�M���ޭȡA�s�Jt4
		div $t4,$t4,2 #t4���H2�A�H�o�쥻���j�骺�����j�M���ޭ�
		print_str("A[") #�L�X�}�C�W�P���A��(��)
		print_int($t4) #�L�X�����j�M���ޭ�
		print_str("] ") #�L�X���A��(�k)�P�ť�
		mul $s0,$t4,4 #���ޭȥ������W4�~�i�o��O�����}��offset(�첾�q)�A�s�Js0
		lw $t5,array($s0) #�q�}�C�O�����Ū�X�����ȡA�s�Jt5
		bgt $t5,$t1,BIGGER #�Y�����Ȥj��j�M�ȡA�i�J�j��϶�
		blt $t5,$t1,SMALLER #�Y�����Ȥp��j�M�ȡA�i�J�p��϶�
		#�Y���O�j��]���O�p��A�N�O�Ҥ����ȵ���j�M�ȡA�����j�M
		EQUAL: #����϶�
			print_str("= ") #�L�X����P�ť�
			print_int($t1) #�L�X�j�M��
		j WHILE1_END #����N�����~�����j��A�������X�j��
		BIGGER: #�j��϶�
			li $t6,1 #�x�s�����ȻP�j�M�Ȫ��j�p���Y�A�����ȸ��j->1
			print_str("> ") #�L�X�j��Ÿ��P�ť�
		j NEXT_WHILE1 #�����~�����j��϶�
		SMALLER: #�p��϶�
			li $t6,0 #�x�s�����ȻP�j�M�Ȫ��j�p���Y�A�j�M�ȸ��j->0
			print_str("< ") #�L�X�p��Ÿ��P�ť�
		NEXT_WHILE1: #�~�����j��϶�
		print_int($t1) #�L�X�j�M��
		print_str("\n") #�L�X����
		beq $s2,$t6,BACKWARD #�p�G�O[�Ѥj�Ӥp(s2=0)�B�j�M�Ȥj�󤤶���(t6=0)]�Ϊ̬O[�Ѥp�Ӥj(s2=1)�B�j�M�Ȥp�󤤶���(t6=1)]�A�h�i�J���ᨫ�϶�(backward)
		#�p�G�O[�Ѥj�Ӥp(s2=0)�B�j�M�Ȥp�󤤶���(t6=1)]�Ϊ̬O[�Ѥp�Ӥj(s2=1)�B�j�M�Ȥj�󤤶���(t6=0)]�A�h�i�J���e���϶�(forward)
		FORWARD: #���e���϶�
			move $t2,$t4 #�_�l�j�M���ޭȳ]�������j�M���ޭ�
			addi $t2,$t2,1 #�ѩ󤤶��j�M���ޭȤw�P�_�O�_����j�M�ȹL�A�ҥH�q�����j�M���ޭȪ��U�@�ӯ��ޭȥh��
		j WHILE1 #�^��j��_�l�I�A�~�����j��
		BACKWARD: #���ᨫ�϶�
			move $t3,$t4 #�`���j�M���ޭȳ]�������j�M���ޭ�
			subi $t3,$t3,1 #�ѩ󤤶��j�M���ޭȤw�P�_�O�_����j�M�ȹL�A�ҥH�q�����j�M���ޭȪ��W�@�ӯ��ޭȥh��
		j WHILE1 #�^��j��_�l�I�A�~�����j��
		NOT_FOUND: #�䤣��϶�
		print_str("Not found!\n") #�L�X�䤣��j�M�ȴ���
	WHILE1_END: #�G���j�M����
	
	
PROGRAM_END: #�{�������϶�
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
