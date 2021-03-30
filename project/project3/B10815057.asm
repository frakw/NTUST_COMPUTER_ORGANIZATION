.data #記憶體變數宣告
array: .space 400 #儲存輸入的陣列，最多100個，每個是int大小(4byte)，所以總共100*4 = 400
input_string: .space 1024 #儲存輸入字串


.macro print_int (%x) #用於印出數字的巨集，簡化程式碼
li $v0,1 #設定syscall模式為 印出數字
add $a0,$zero,%x #將%x暫存器的值寫到a0暫存器(syscall規定)
syscall #呼叫syscall 印出數字
.end_macro

.macro print_str (%str) #用於印出字串的巨集，簡化程式碼
.data
myLabel: .asciiz %str #宣告暫存的字串
.text
li $v0, 4 #設定syscall模式為 印出字串
la $a0, myLabel #將字串的記憶體位址寫到a0暫存器(syscall規定)
syscall #呼叫syscall 印出字串
.end_macro


.text #組語程式碼
	print_str("Please input array A:\n")
	
	li $v0, 8 #設定syscall模式為 讀取字串
	la $a0, input_string #將要存放的記憶體位址寫到a0暫存器(syscall規定)
	li $a1, 1024 #設定字串讀取最大長度(syscall規定)
	syscall
	
	li $t0, 0 #t0暫存器紀錄跑到string的哪個位置(index)	
	li $t1, 0 #t1暫存器暫存每次讀取的字元(ascii code)
	li $t2, 0 #t2暫存器儲存結果
	la $s0,array #s0暫存器儲存陣列的記憶體位址，用於跑過陣列的每個element(index)
	li $s1, 0 #紀錄數字讀取次數的暫存器，存放陣列有幾個元素
	li $s2, 0 #紀錄是由大而小(0)或由小而大(1)，用於判斷陣列是否已排序好
	
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
li $v0, 10 #設定syscall模式為 離開程式
syscall #呼叫syscall 離開程式

read_int:#讀取數字function，主要是用於把t2暫存器歸零，以避免呼叫遞迴前沒有歸零
	addi $sp, $sp, -4 #創建出stack，push stack
	sw $ra, 0($sp) #儲存return呼叫位置
	li $t2, 0 #把t2暫存器歸零
	jal read_int_recursive #呼叫遞迴讀取數字
	lw $ra, 0($sp) #從stack裡讀取return呼叫位置
	addi $sp, $sp,4 #清除stack，pop stack
jr $ra #返回呼叫位置


read_int_recursive: #遞迴讀取所有數字function
	addi $sp, $sp, -4 #創建出stack，push stack
	sw $ra, 0($sp) #儲存return呼叫位置
	
	add $t4,$a0,$t0 #字串讀取後記憶體位址存在a0，加上index(t0) offset位移量後得到正確記憶體位址，存入t4暫存器
	lb $t1,0($t4) #從記憶體位址中取出1byte字元(char、ascii code)，存到t1暫存器
	addi $t0,$t0,1 #字串位置+1，讓下一次遞迴讀取下個字元
	IF_1: bne $t1,'-',ELSEIF_1_1 #如果該字元為負號時，遞迴讀取下去，返回前乘上-1
		jal read_int_recursive #遞迴呼叫讀取數字function
		mul $t2,$t2,-1 #遞迴結果乘上-1
	j ENDIF_1 #跳至if結尾

	ELSEIF_1_1: bne $t1,',',ELSEIF_1_2 #如果該字元為逗號時，結束遞迴
		
	j ENDIF_1 #跳至if結尾

	ELSEIF_1_2: bne $t1,'\n',ELSEIF_1_3 #如果該字元為換行時，結束遞迴
		
	j ENDIF_1 #跳至if結尾
	
	ELSEIF_1_3: bne $t1,'\0',ELSE_1 #如果該字元為字串時，結束遞迴，並將字串讀取index-1，避免之後讀取時超出範圍
			subi $t0,$t0,1 #字串讀取index-1，避免之後讀取時超出範圍
	j ENDIF_1 #跳至if結尾
	
	ELSE_1: #如果該字元為數字時，將之前遞迴的累加結果乘上10，並加上新讀取的數字，然後繼續遞迴讀取下去
		sub $t1,$t1,'0' #將數字字元扣掉數字0字元得到數字，字元轉數字
		mul $t2,$t2,10 #將之前遞迴的累加結果乘上10
		add $t2,$t2,$t1 #加上新讀取的數字		
		jal read_int_recursive #遞迴呼叫讀取數字function
	j ENDIF_1 #跳至if結尾

	ENDIF_1: #if結尾
	
	lw $ra, 0($sp) #從stack裡讀取return呼叫位置
	addi $sp, $sp,4 #清除stack，pop stack
jr $ra #返回呼叫位置
