.data #記憶體變數宣告
vector_A: .space 32 #儲存A向量的陣列，有八個，每個是int大小(4byte)，所以總共8*4 = 32
vector_B: .space 32 #儲存B向量的陣列，有八個，每個是int大小(4byte)，所以總共8*4 = 32
input_string: .asciiz "" #儲存輸入字串

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
main:
	print_str("Please input vector A:\n") #印出輸入向量A提示字串

	li $v0, 8 #設定syscall模式為 讀取字串
	la $a0, input_string #將要存放的記憶體位址寫到a0暫存器(syscall規定)
	li $a1, 1024 #設定字串讀取最大長度(syscall規定)
	syscall

	li $t0, 0 #t0暫存器紀錄跑到string的哪個位置(index)	
	li $t1, 0 #t1暫存器暫存每次讀取的字元(ascii code)
	li $t2, 0 #t2暫存器儲存結果
	la $s0,vector_A #s0暫存器儲存陣列的記憶體位址，用於跑過陣列的每個element(index)
	li $s1, 0 #for loop 跑8次 ，紀錄次數的暫存器，歸零以執行迴圈
	
	LOOP1: #1號迴圈，讀取A向量
		li $t2, 0 #每讀一個數字後將結果重設回零，才可執行下次累加
		bgt $s1,7,EXIT1 #如果已經跑了八次(大於7)，就跳出迴圈(跳到1號迴圈結尾)
		jal read_int #呼叫數字讀取funciton        	
		sw $t2,($s0) #從t2暫存器取出結果
		addi $s0, $s0,4 #s0暫存器存的記憶體位址+4，相當於存取陣列的index+1
		addi $s1,$s1,1 #迴圈次數+1
		j LOOP1 #跳回1號迴圈開頭
	EXIT1: #1號迴圈結尾
	
	print_str("Please input vector B:\n") #印出輸入向量B提示字串
	
	li $v0, 8 #設定syscall模式為 讀取字串
	la $a0, input_string #將要存放的記憶體位址寫到a0暫存器(syscall規定)
	li $a1, 1024 #設定字串讀取最大長度(syscall規定)
	syscall
	
	li $t0, 0 #t0暫存器紀錄跑到string的哪個位置(index)	
	li $t1, 0 #t1暫存器暫存每次讀取的字元(ascii code)
	li $t2, 0 #t2暫存器儲存結果
	la $s0,vector_B #s0暫存器儲存陣列的記憶體位址，用於跑過陣列的每個element(index)
	li $s1, 0 #for loop 跑8次 ，紀錄次數的暫存器，歸零以執行迴圈
	
	LOOP2: #2號迴圈，讀取B向量
		li $t2, 0 #每讀一個數字後將結果重設回零，才可執行下次累加
		bgt $s1,7,EXIT2 #如果已經跑了八次(大於7)，就跳出迴圈(跳到2號迴圈結尾)
		jal read_int #呼叫數字讀取funciton        	
		sw $t2,($s0) #從t2暫存器取出結果
		addi $s0, $s0,4 #s0暫存器存的記憶體位址+4，相當於存取陣列的index+1
		addi $s1,$s1,1 #迴圈次數+1
		j LOOP2 #跳回2號迴圈開頭
	EXIT2: #2號迴圈結尾
	
	print_str("A+B = (") #加法輸出提示字串	

	li $s1, 0 #s1是紀錄次數的暫存器，歸零以執行迴圈
	la $s4,vector_A #s4暫存器儲存A向量陣列的記憶體位址，用於跑過陣列的每個element(index)
	la $s5,vector_B #s5暫存器儲存B向量陣列的記憶體位址，用於跑過陣列的每個element(index)
	LOOP3: #3號迴圈，執行加法並印出
		bgt $s1,6,EXIT3 #為了避免最後一個數字後有逗號，額外處理它，如果已經跑了7次(大於6)，就跳出迴圈(跳到3號迴圈結尾)
		lw $t6,($s4) #從記憶體位址讀出數字(A向量的element)存到t6暫存器
		lw $t7,($s5) #從記憶體位址讀出數字(B向量的element)存到t7暫存器
		add $t2,$t6,$t7 #相加2個數字後存到t2暫存器
		print_int($t2) #印出相加的結果
		print_str(",") #印出逗號
		addi $s4,$s4,4 #s4暫存器存的記憶體位址+4，相當於存取A向量陣列的index+1
		addi $s5,$s5,4 #s5暫存器存的記憶體位址+4，相當於存取B向量陣列的index+1
		addi $s1,$s1,1 #迴圈次數+1
		j LOOP3 #跳回3號迴圈開頭
	EXIT3: #3號迴圈結尾
		lw $t6,($s4) #從記憶體位址讀出數字(A向量的element)存到t6暫存器
		lw $t7,($s5) #從記憶體位址讀出數字(B向量的element)存到t7暫存器
		add $t2,$t6,$t7  #相加2個數字後存到t2暫存器
        print_int($t2) #印出相加的結果
	print_str(")\n") #輸出右括號與換行
	
	print_str("A-B = (") #減法輸出提示字串
	
	li $s1,0 #for loop 跑8次 ，紀錄次數的暫存器，歸零以執行迴圈
	la $s4,vector_A #s4暫存器儲存A向量陣列的記憶體位址，用於跑過陣列的每個element(index)
	la $s5,vector_B #s5暫存器儲存B向量陣列的記憶體位址，用於跑過陣列的每個element(index)
	LOOP4: #4號迴圈，執行減法並印出
		bgt $s1,6,EXIT4 #為了避免最後一個數字後有逗號，額外處理它，如果已經跑了7次(大於6)，就跳出迴圈(跳到4號迴圈結尾)
		lw $t6,($s4) #從記憶體位址讀出數字(A向量的element)存到t6暫存器
		lw $t7,($s5) #從記憶體位址讀出數字(B向量的element)存到t7暫存器
		sub $t2,$t6,$t7 #相減2個數字後存到t2暫存器
 		print_int($t2) #印出相減相減的結果
		print_str(",") #印出逗號
		addi $s4,$s4,4 #s4暫存器存的記憶體位址+4，相當於存取A向量陣列的index+1
		addi $s5,$s5,4 #s5暫存器存的記憶體位址+4，相當於存取B向量陣列的index+1
		addi $s1,$s1,1 #迴圈次數+1
		j LOOP4 #跳回4號迴圈開頭
	EXIT4: #4號迴圈結尾
		lw $t6,($s4) #從記憶體位址讀出數字(A向量的element)存到t6暫存器
		lw $t7,($s5) #從記憶體位址讀出數字(B向量的element)存到t7暫存器
		sub $t2,$t6,$t7  #相減2個數字後存到t2暫存器
		print_int($t2) #印出相減的結果
	print_str(")\n") #輸出右括號與換行
	
	print_str("A*B = ")  #乘法輸出提示字串
	
	li $s1, 0 #for loop 跑8次 ，紀錄次數的暫存器
	li $t2, 0 #向量乘法結果存於t2暫存器，要先歸零才可正確累加
	la $s4,vector_A #s4暫存器儲存A向量陣列的記憶體位址，用於跑過陣列的每個element(index)
	la $s5,vector_B #s5暫存器儲存B向量陣列的記憶體位址，用於跑過陣列的每個element(index)
	LOOP5: #5號迴圈，執行向量乘法並印出
		bgt $s1,7,EXIT5 #如果已經跑了8次(大於7)，就跳出迴圈(跳到5號迴圈結尾)
		lw $t6,($s4) #從記憶體位址讀出數字(A向量的element)存到t6暫存器
		lw $t7,($s5) #從記憶體位址讀出數字(B向量的element)存到t7暫存器
		mul $t3,$t6,$t7 #相乘後的結果存到t3暫存器
		add $t2,$t2,$t3 #加上之前計算的結果(累加)，向量乘法
		addi $s4,$s4,4 #s4暫存器存的記憶體位址+4，相當於存取A向量陣列的index+1
		addi $s5,$s5,4 #s5暫存器存的記憶體位址+4，相當於存取B向量陣列的index+1
		addi $s1,$s1,1 #迴圈次數+1
		j LOOP5 #跳回5號迴圈開頭
	EXIT5: #5號迴圈結尾
	print_int($t2) #印出向量乘法結果

li $v0, 10 #設定syscall模式為 離開程式
syscall #呼叫syscall 離開程式


read_int: #讀取數字function
	addi $sp, $sp, -4 #創建出stack，push stack
	sw $ra, 0($sp) #儲存return呼叫位置
	
	add $t4,$a0,$t0 #字串讀取後記憶體位址存在a0，加上index(t0) offset位移量後得到正確記憶體位址，存入t4暫存器
	lb $t1,0($t4) #從記憶體位址中取出1byte字元(char、ascii code)，存到t1暫存器
	addi $t0,$t0,1 #字串位置+1，讓下一次遞迴讀取下個字元
	IF_1: bne $t1,'-',ELSEIF_1_1 #如果該字元為負號時，遞迴讀取下去，返回前乘上-1
		jal read_int #遞迴呼叫讀取數字function
		mul $t2,$t2,-1 #遞迴結果乘上-1
	j ENDIF_1 #跳至if結尾

	ELSEIF_1_1: bne $t1,',',ELSEIF_1_2 #如果該字元為逗號時，結束遞迴
		
	j ENDIF_1 #跳至if結尾

	ELSEIF_1_2: bne $t1,'\n',ELSE_1 #如果該字元為換行時，結束遞迴
		
	j ENDIF_1 #跳至if結尾
	
	ELSE_1: #如果該字元為數字時，將之前遞迴的累加結果乘上10，並加上新讀取的數字，然後繼續遞迴讀取下去
		sub $t1,$t1,'0' #將數字字元扣掉數字0字元得到數字，字元轉數字
		mul $t2,$t2,10 #將之前遞迴的累加結果乘上10
		add $t2,$t2,$t1 #加上新讀取的數字		
		jal read_int #遞迴呼叫讀取數字function
	j ENDIF_1 #跳至if結尾

	ENDIF_1: #if結尾
	
	lw $ra, 0($sp) #從stack裡讀取return呼叫位置
	addi $sp, $sp,4 #清除stack，pop stack
jr $ra #返回呼叫位置
