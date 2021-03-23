.data #�O�����ܼƫŧi
vector_A: .space 32
vector_B: .space 32


input_command_A: .asciiz "Please input vector A:\n" #��J�魫���ܦr��
input_string_A: .asciiz ""


#.word 0,0,0,0,0,0,0,0
input_command_B: .asciiz "Please input vector B:\n" #��J�������ܦr��
input_string_B: .asciiz ""

output_plus: .asciiz  #��XBMI�e���ܦr��
output_minus: .asciiz "A+B = (" #��XBMI�e���ܦr��
output_multiply: .asciiz "A*B = " #��XBMI�e���ܦr��
output_end: .asciiz ")\n"

.macro print_int (%x)
li $v0, 1
add $a0, $zero, %x
syscall
.end_macro

.macro print_str (%str)
.data
myLabel: .asciiz %str
.text
li $v0, 4
la $a0, myLabel
syscall
.end_macro


.text #�ջy�{���X

main:
	print_str("Please input vector A:\n")

	la $a0, input_string_A
	li $a1, 1024
	li $v0, 8
	syscall

	li $t0, 0 #index of string
	li $t1, 0 #a temp character in string

	addi $s1, $zero,0
	addi $t2, $zero,0 #result of read_int
	la $s0,vector_A
	LOOP1:
        	addi $t2, $zero,0 #result of read_int
            	bgt $s1,7,EXIT1
        	jal read_int
        	
        	sw 	$t2,($s0)        	
		addi 	$s0, $s0,4
        	addi 	$s1,$s1,1
        	j LOOP1
	EXIT1:
	
	print_str("Please input vector B:\n")
	
	la $a0, input_string_B
	li $a1, 1024
	li $v0, 8
	syscall
	
	li $t0, 0 #index of string
	li $t1, 0 #a temp character in string
	addi $s1, $zero,0
	addi $t2, $zero,0 #result of read_int
	la $s0,vector_B
	LOOP2:
        	addi $t2, $zero,0 #result of read_int
            	bgt $s1,7,EXIT2
        	jal read_int
        	
        	sw 	$t2,($s0)
		addi 	$s0, $s0,4
        	addi 	$s1,$s1,1
        	j LOOP2
	EXIT2:
	
	print_str("A+B = (")
	
	li $t0, 0 #index of string
	li $t1, 0 #a temp character in string
	addi $s1, $zero,0
	addi $t2, $zero,0 #result of plus
	la $s4, vector_A
	la $s5, vector_B
	LOOP3:

            	bgt $s1,6,EXIT3
            	lw $t6,($s4)
            	lw $t7,($s5)
            	add $t2,$t6,$t7
        	print_int($t2)
        	print_str(",")
            	addi $s4, $s4,4
            	addi $s5, $s5,4
            	addi $s1,$s1,1
        	j LOOP3
	EXIT3:
		lw $t6,($s4)
            	lw $t7,($s5)
        	add $t2,$t6,$t7
        	print_int($t2)
	print_str(")\n")
	
	print_str("A-B = (")
	
	li $t0, 0 #index of string
	li $t1, 0 #a temp character in string
	addi $s1, $zero,0
	addi $t2, $zero,0 #result of plus
	la $s4, vector_A
	la $s5, vector_B
	LOOP4:

            	bgt $s1,6,EXIT4
            	lw $t6,($s4)
            	lw $t7,($s5)
            	sub $t2,$t6,$t7
        	print_int($t2)
        	print_str(",")
            	addi $s4, $s4,4
            	addi $s5, $s5,4
            	addi $s1,$s1,1
        	j LOOP4
	EXIT4:
		lw $t6,($s4)
            	lw $t7,($s5)
        	sub $t2,$t6,$t7
        	print_int($t2)
	print_str(")\n")
	
	print_str("A*B = ")
	
	li $t0, 0 #index of string
	li $t1, 0 #a temp character in string
	addi $s1, $zero,0
	addi $t2, $zero,0 #result of plus
	la $s4, vector_A
	la $s5, vector_B
	LOOP5:

            	bgt $s1,7,EXIT5
            	lw $t6,($s4)
            	lw $t7,($s5)
            	mul $t3,$t6,$t7
            	add $t2,$t2,$t3
            	addi $s4, $s4,4
            	addi $s5, $s5,4
            	addi $s1,$s1,1
        	j LOOP5
	EXIT5:
	print_int($t2)

li $v0, 10 #�]�wsyscall�Ҧ��� ���}�{��
syscall #�I�ssyscall ���}�{��


read_int:
	addi $sp, $sp, -4 # �s�ySTACK
	sw $ra, 0($sp) # �x�s Return ��m
	
	add $t4,$a0,$t0	
	lb $t1,0($t4)
	addi $t0,$t0,1
	IF_1: bne $t1,'-',ELSEIF_1_1 #�t��
		jal read_int
		mul $t2,$t2,-1
	j ENDIF_1

	ELSEIF_1_1: bne $t1,',',ELSEIF_1_2#�r��
		
	j ENDIF_1

	ELSEIF_1_2: bne $t1,'\n',ELSE_1#����
		
	j ENDIF_1
	
	ELSE_1:#�Ʀr
		#print_int(3)
		sub $t1,$t1,'0'
		mul $t2,$t2,10
		add $t2,$t2,$t1
		
		jal read_int
	j ENDIF_1


	ENDIF_1:
	
	
	lw $ra, 0($sp) # �q STACK Ū�� Return ��m
	addi $sp, $sp,4 # �M�� STACK
jr $ra

