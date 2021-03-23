.data #�O�����ܼƫŧi
vector_A: .space 32 #�x�sA�V�q���}�C�A���K�ӡA�C�ӬOint�j�p(4byte)�A�ҥH�`�@8*4 = 32
vector_B: .space 32 #�x�sB�V�q���}�C�A���K�ӡA�C�ӬOint�j�p(4byte)�A�ҥH�`�@8*4 = 32
input_string: .asciiz "" #�x�s��J�r��

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
main:
	print_str("Please input vector A:\n") #�L�X��J�V�qA���ܦr��

	li $v0, 8 #�]�wsyscall�Ҧ��� Ū���r��
	la $a0, input_string #�N�n�s�񪺰O�����}�g��a0�Ȧs��(syscall�W�w)
	li $a1, 1024 #�]�w�r��Ū���̤j����(syscall�W�w)
	syscall

	li $t0, 0 #t0�Ȧs�������]��string�����Ӧ�m(index)	
	li $t1, 0 #t1�Ȧs���Ȧs�C��Ū�����r��(ascii code)
	li $t2, 0 #t2�Ȧs���x�s���G
	la $s0,vector_A #s0�Ȧs���x�s�}�C���O�����}�A�Ω�]�L�}�C���C��element(index)
	li $s1, 0 #for loop �]8�� �A�������ƪ��Ȧs���A�k�s�H����j��
	
	LOOP1: #1���j��AŪ��A�V�q
		li $t2, 0 #�CŪ�@�ӼƦr��N���G���]�^�s�A�~�i����U���֥[
		bgt $s1,7,EXIT1 #�p�G�w�g�]�F�K��(�j��7)�A�N���X�j��(����1���j�鵲��)
		jal read_int #�I�s�ƦrŪ��funciton        	
		sw $t2,($s0) #�qt2�Ȧs�����X���G
		addi $s0, $s0,4 #s0�Ȧs���s���O�����}+4�A�۷��s���}�C��index+1
		addi $s1,$s1,1 #�j�馸��+1
		j LOOP1 #���^1���j��}�Y
	EXIT1: #1���j�鵲��
	
	print_str("Please input vector B:\n") #�L�X��J�V�qB���ܦr��
	
	li $v0, 8 #�]�wsyscall�Ҧ��� Ū���r��
	la $a0, input_string #�N�n�s�񪺰O�����}�g��a0�Ȧs��(syscall�W�w)
	li $a1, 1024 #�]�w�r��Ū���̤j����(syscall�W�w)
	syscall
	
	li $t0, 0 #t0�Ȧs�������]��string�����Ӧ�m(index)	
	li $t1, 0 #t1�Ȧs���Ȧs�C��Ū�����r��(ascii code)
	li $t2, 0 #t2�Ȧs���x�s���G
	la $s0,vector_B #s0�Ȧs���x�s�}�C���O�����}�A�Ω�]�L�}�C���C��element(index)
	li $s1, 0 #for loop �]8�� �A�������ƪ��Ȧs���A�k�s�H����j��
	
	LOOP2: #2���j��AŪ��B�V�q
		li $t2, 0 #�CŪ�@�ӼƦr��N���G���]�^�s�A�~�i����U���֥[
		bgt $s1,7,EXIT2 #�p�G�w�g�]�F�K��(�j��7)�A�N���X�j��(����2���j�鵲��)
		jal read_int #�I�s�ƦrŪ��funciton        	
		sw $t2,($s0) #�qt2�Ȧs�����X���G
		addi $s0, $s0,4 #s0�Ȧs���s���O�����}+4�A�۷��s���}�C��index+1
		addi $s1,$s1,1 #�j�馸��+1
		j LOOP2 #���^2���j��}�Y
	EXIT2: #2���j�鵲��
	
	print_str("A+B = (") #�[�k��X���ܦr��	

	li $s1, 0 #s1�O�������ƪ��Ȧs���A�k�s�H����j��
	la $s4,vector_A #s4�Ȧs���x�sA�V�q�}�C���O�����}�A�Ω�]�L�}�C���C��element(index)
	la $s5,vector_B #s5�Ȧs���x�sB�V�q�}�C���O�����}�A�Ω�]�L�}�C���C��element(index)
	LOOP3: #3���j��A����[�k�æL�X
		bgt $s1,6,EXIT3 #���F�קK�̫�@�ӼƦr�ᦳ�r���A�B�~�B�z���A�p�G�w�g�]�F7��(�j��6)�A�N���X�j��(����3���j�鵲��)
		lw $t6,($s4) #�q�O�����}Ū�X�Ʀr(A�V�q��element)�s��t6�Ȧs��
		lw $t7,($s5) #�q�O�����}Ū�X�Ʀr(B�V�q��element)�s��t7�Ȧs��
		add $t2,$t6,$t7 #�ۥ[2�ӼƦr��s��t2�Ȧs��
		print_int($t2) #�L�X�ۥ[�����G
		print_str(",") #�L�X�r��
		addi $s4,$s4,4 #s4�Ȧs���s���O�����}+4�A�۷��s��A�V�q�}�C��index+1
		addi $s5,$s5,4 #s5�Ȧs���s���O�����}+4�A�۷��s��B�V�q�}�C��index+1
		addi $s1,$s1,1 #�j�馸��+1
		j LOOP3 #���^3���j��}�Y
	EXIT3: #3���j�鵲��
		lw $t6,($s4) #�q�O�����}Ū�X�Ʀr(A�V�q��element)�s��t6�Ȧs��
		lw $t7,($s5) #�q�O�����}Ū�X�Ʀr(B�V�q��element)�s��t7�Ȧs��
		add $t2,$t6,$t7  #�ۥ[2�ӼƦr��s��t2�Ȧs��
        print_int($t2) #�L�X�ۥ[�����G
	print_str(")\n") #��X�k�A���P����
	
	print_str("A-B = (") #��k��X���ܦr��
	
	li $s1,0 #for loop �]8�� �A�������ƪ��Ȧs���A�k�s�H����j��
	la $s4,vector_A #s4�Ȧs���x�sA�V�q�}�C���O�����}�A�Ω�]�L�}�C���C��element(index)
	la $s5,vector_B #s5�Ȧs���x�sB�V�q�}�C���O�����}�A�Ω�]�L�}�C���C��element(index)
	LOOP4: #4���j��A�����k�æL�X
		bgt $s1,6,EXIT4 #���F�קK�̫�@�ӼƦr�ᦳ�r���A�B�~�B�z���A�p�G�w�g�]�F7��(�j��6)�A�N���X�j��(����4���j�鵲��)
		lw $t6,($s4) #�q�O�����}Ū�X�Ʀr(A�V�q��element)�s��t6�Ȧs��
		lw $t7,($s5) #�q�O�����}Ū�X�Ʀr(B�V�q��element)�s��t7�Ȧs��
		sub $t2,$t6,$t7 #�۴�2�ӼƦr��s��t2�Ȧs��
 		print_int($t2) #�L�X�۴�۴���G
		print_str(",") #�L�X�r��
		addi $s4,$s4,4 #s4�Ȧs���s���O�����}+4�A�۷��s��A�V�q�}�C��index+1
		addi $s5,$s5,4 #s5�Ȧs���s���O�����}+4�A�۷��s��B�V�q�}�C��index+1
		addi $s1,$s1,1 #�j�馸��+1
		j LOOP4 #���^4���j��}�Y
	EXIT4: #4���j�鵲��
		lw $t6,($s4) #�q�O�����}Ū�X�Ʀr(A�V�q��element)�s��t6�Ȧs��
		lw $t7,($s5) #�q�O�����}Ū�X�Ʀr(B�V�q��element)�s��t7�Ȧs��
		sub $t2,$t6,$t7  #�۴�2�ӼƦr��s��t2�Ȧs��
		print_int($t2) #�L�X�۴���G
	print_str(")\n") #��X�k�A���P����
	
	print_str("A*B = ")  #���k��X���ܦr��
	
	li $s1, 0 #for loop �]8�� �A�������ƪ��Ȧs��
	li $t2, 0 #�V�q���k���G�s��t2�Ȧs���A�n���k�s�~�i���T�֥[
	la $s4,vector_A #s4�Ȧs���x�sA�V�q�}�C���O�����}�A�Ω�]�L�}�C���C��element(index)
	la $s5,vector_B #s5�Ȧs���x�sB�V�q�}�C���O�����}�A�Ω�]�L�}�C���C��element(index)
	LOOP5: #5���j��A����V�q���k�æL�X
		bgt $s1,7,EXIT5 #�p�G�w�g�]�F8��(�j��7)�A�N���X�j��(����5���j�鵲��)
		lw $t6,($s4) #�q�O�����}Ū�X�Ʀr(A�V�q��element)�s��t6�Ȧs��
		lw $t7,($s5) #�q�O�����}Ū�X�Ʀr(B�V�q��element)�s��t7�Ȧs��
		mul $t3,$t6,$t7 #�ۭ��᪺���G�s��t3�Ȧs��
		add $t2,$t2,$t3 #�[�W���e�p�⪺���G(�֥[)�A�V�q���k
		addi $s4,$s4,4 #s4�Ȧs���s���O�����}+4�A�۷��s��A�V�q�}�C��index+1
		addi $s5,$s5,4 #s5�Ȧs���s���O�����}+4�A�۷��s��B�V�q�}�C��index+1
		addi $s1,$s1,1 #�j�馸��+1
		j LOOP5 #���^5���j��}�Y
	EXIT5: #5���j�鵲��
	print_int($t2) #�L�X�V�q���k���G

li $v0, 10 #�]�wsyscall�Ҧ��� ���}�{��
syscall #�I�ssyscall ���}�{��


read_int: #Ū���Ʀrfunction
	addi $sp, $sp, -4 #�ЫإXstack�Apush stack
	sw $ra, 0($sp) #�x�sreturn�I�s��m
	
	add $t4,$a0,$t0 #�r��Ū����O�����}�s�ba0�A�[�Windex(t0) offset�첾�q��o�쥿�T�O�����}�A�s�Jt4�Ȧs��
	lb $t1,0($t4) #�q�O�����}�����X1byte�r��(char�Bascii code)�A�s��t1�Ȧs��
	addi $t0,$t0,1 #�r���m+1�A���U�@�����jŪ���U�Ӧr��
	IF_1: bne $t1,'-',ELSEIF_1_1 #�p�G�Ӧr�����t���ɡA���jŪ���U�h�A��^�e���W-1
		jal read_int #���j�I�sŪ���Ʀrfunction
		mul $t2,$t2,-1 #���j���G���W-1
	j ENDIF_1 #����if����

	ELSEIF_1_1: bne $t1,',',ELSEIF_1_2 #�p�G�Ӧr�����r���ɡA�������j
		
	j ENDIF_1 #����if����

	ELSEIF_1_2: bne $t1,'\n',ELSE_1 #�p�G�Ӧr��������ɡA�������j
		
	j ENDIF_1 #����if����
	
	ELSE_1: #�p�G�Ӧr�����Ʀr�ɡA�N���e���j���֥[���G���W10�A�å[�W�sŪ�����Ʀr�A�M���~�򻼰jŪ���U�h
		sub $t1,$t1,'0' #�N�Ʀr�r�������Ʀr0�r���o��Ʀr�A�r����Ʀr
		mul $t2,$t2,10 #�N���e���j���֥[���G���W10
		add $t2,$t2,$t1 #�[�W�sŪ�����Ʀr		
		jal read_int #���j�I�sŪ���Ʀrfunction
	j ENDIF_1 #����if����

	ENDIF_1: #if����
	
	lw $ra, 0($sp) #�qstack��Ū��return�I�s��m
	addi $sp, $sp,4 #�M��stack�Apop stack
jr $ra #��^�I�s��m
