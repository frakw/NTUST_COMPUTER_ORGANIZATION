.data #記憶體變數宣告
array: .space 400 #儲存輸入的陣列，最多100個，每個是int大小(4byte)，所以總共100*4 = 400
input_string: .space 1024 #儲存輸入字串，須設定大小，否則導致不對齊問題


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
	###############################陣列讀取階段###############################
	print_str("Please input array A:\n") #印出輸入陣列提示
	
	li $v0, 8 #設定syscall模式為 讀取字串
	la $a0, input_string #將要存放的記憶體位址寫到a0暫存器(syscall規定)
	li $a1, 1024 #設定字串讀取最大長度(syscall規定)
	syscall #呼叫syscall 印出字串
	
	li $t0, 0 #t0暫存器紀錄跑到string的哪個位置(index)	
	li $t1, 0 #t1暫存器暫存每次讀取的字元(ascii code)
	li $t2, 0 #t2暫存器儲存結果
	la $s0,array #s0暫存器儲存陣列的記憶體位址，用於跑過陣列的每個element(index)
	li $s1, 0 #紀錄數字讀取次數的暫存器，存放陣列有幾個元素
	li $s2, 0 #紀錄是由大而小(0)或由小而大(1)，用於判斷陣列是否已排序好
	
	#為了讓迴圈可以順利判斷陣列是否已排序，要先將開頭2個數字讀出，並判斷是由大到小或由小到大
	
	#讀取陣列第一個數字
	lb $t1,input_string($t0) #讀取字串的下一個字元，確認是否已到字串結尾
	beq $t1,'\n',LOOP1_END #判斷是否為換行，如果是，直接進入搜尋階段
	beq $t1,'\0',LOOP1_END #判斷是否為字串結尾，如果是，直接進入搜尋階段
	jal read_int #讀取數字function，結果存於t2
	sw $t2,($s0) #從t2讀出，存入陣列記憶體位址(s0)
	move $t3,$t2 #由於t2的結果會被覆蓋，所以複製一份到t3，用於之後的判斷大小
	addi $s1,$s1,1 #陣列個數+1
	addi $s0,$s0,4 #陣列記憶體位址前往下一個index移動(+1個int的長度)
	
	#讀取陣列第二個數字
	lb $t1,input_string($t0) #讀取字串的下一個字元，確認是否已到字串結尾
	beq $t1,'\n',LOOP1_END #判斷是否為換行，如果是，直接進入搜尋階段
	beq $t1,'\0',LOOP1_END #判斷是否為字串結尾，如果是，直接進入搜尋階段
	jal read_int #讀取數字function，結果存於t2
	sw $t2,($s0) #從t2讀出，存入陣列記憶體位址(s0)
	move $t4,$t2 #由於t2的結果會被覆蓋，所以複製一份到t4，用於之後的判斷大小
	addi $s1,$s1,1 #陣列個數+1
	addi $s0,$s0,4 #陣列記憶體位址前往下一個index移動(+1個int的長度)
	
	bgt $t4,$t3,FIRST_SMALL_TO_BIG #判斷頭2個數字是由大到小或由小到大，之後讀入的數字若不符合此次判斷，即可確認陣列未排序
	li $s2, 0 #由大到小，s2設為0
	j LOOP1 #避免跑到由小到大的區塊裡，直接進入陣列讀取迴圈
	FIRST_SMALL_TO_BIG:
	li $s2, 1 #由小到大，s2設為1
		
	LOOP1: #陣列讀取迴圈
		lb $t1,input_string($t0) #讀取字串的下一個字元，確認是否已到字串結尾
		beq $t1,'\n',LOOP1_END #判斷是否為換行，如果是，跳出迴圈，進入搜尋階段
		beq $t1,'\0',LOOP1_END #判斷是否為字串結尾，如果是，跳出迴圈，進入搜尋階段
		jal read_int #讀取數字function，結果存於t2
		sw $t2,($s0) #從t2讀出，存入陣列記憶體位址(s0)
		lw $t3,-4($s0) #將上一個數字從陣列的當前index-1處讀出，用於跟本次迴圈讀入的數字比較
		bgt $t2,$t3,SMALL_TO_BIG #比較這次讀入數字與上次讀入數字大小，若大於則進入由小到大區塊，反之亦然
		BIG_TO_SMALL: #由大到小區塊
			beq $s2,0,NEXT_LOOP1 #若之前也是由大到小，則進入繼續執行迴圈區塊
			j NOT_SORTED #若之前是由小到大，進入未排序處理區塊
		SMALL_TO_BIG: #由小到大區塊
			beq $s2,1,NEXT_LOOP1 #若之前也是由小到大，則進入繼續執行迴圈區塊
			j NOT_SORTED #若之前是由大到小，進入未排序處理區塊
		
		NEXT_LOOP1: #繼續執行迴圈區塊
		addi $s1,$s1,1 #陣列個數+1
		addi $s0,$s0,4 #陣列記憶體位址前往下一個index移動(+1個int的長度)
		j LOOP1 #回到迴圈起始點，繼續執行迴圈
		NOT_SORTED: #未排序處理區塊
		print_str("Error! The array is not sorted.\n") #印出未排序警告
		j PROGRAM_END #未排序，故不用進入搜尋階段，直接跳至程式結束區塊
	LOOP1_END: #讀取迴圈結尾，進入搜尋階段
	
	###############################搜尋階段###############################
	
	print_str("Please input a key value:\n") #印出輸入搜尋值提示
	li $v0,5 #設定syscall模式為 讀取數字
	syscall	#呼叫syscall 讀取數字
	li $t0,1 #紀錄步驟數(step)的暫存器
	move $t1,$v0 #讀取的搜尋值存在v0，存入t1
	li $t2,0 #起始搜尋索引值設為0
	move $t3,$s1 #結尾搜尋索引值設為 陣列個數
	subi $t3,$t3,1 #由於陣列index從0到陣列個數-1，因此將結尾搜尋索引值-1
	li $t4,0 #儲存中間搜尋索引值
	li $t5,0 #儲存中間值
	li $t6,0 #存放中間值與搜尋值的大小關係，中間值較大->1，搜尋值較大->0
	WHILE1: #二分搜尋迴圈
		print_str("Step ") #印出步驟英文
		print_int($t0) #印出步驟數
		addi $t0,$t0,1 #步驟數+1
		print_str(": ")	#印出冒號與空白
		bgt $t2,$t3,NOT_FOUND #若起始搜尋索引值大於結尾搜尋索引值，則代表找不到該搜尋值，進入找不到區塊
		add $t4,$t3,$t2 #起始搜尋索引值加上結尾搜尋索引值，存入t4
		div $t4,$t4,2 #t4除以2，以得到本次迴圈的中間搜尋索引值
		print_str("A[") #印出陣列名與中括號(左)
		print_int($t4) #印出中間搜尋索引值
		print_str("] ") #印出中括號(右)與空白
		mul $s0,$t4,4 #索引值必須乘上4才可得到記憶體位址的offset(位移量)，存入s0
		lw $t5,array($s0) #從陣列記憶體裡讀出中間值，存入t5
		bgt $t5,$t1,BIGGER #若中間值大於搜尋值，進入大於區塊
		blt $t5,$t1,SMALLER #若中間值小於搜尋值，進入小於區塊
		#若不是大於也不是小於，就保證中間值等於搜尋值，結束搜尋
		EQUAL: #等於區塊
			print_str("= ") #印出等於與空白
			print_int($t1) #印出搜尋值
		j WHILE1_END #找到後就不用繼續執行迴圈，直接跳出迴圈
		BIGGER: #大於區塊
			li $t6,1 #儲存中間值與搜尋值的大小關係，中間值較大->1
			print_str("> ") #印出大於符號與空白
		j NEXT_WHILE1 #跳至繼續執行迴圈區塊
		SMALLER: #小於區塊
			li $t6,0 #儲存中間值與搜尋值的大小關係，搜尋值較大->0
			print_str("< ") #印出小於符號與空白
		NEXT_WHILE1: #繼續執行迴圈區塊
		print_int($t1) #印出搜尋值
		print_str("\n") #印出換行
		beq $s2,$t6,BACKWARD #如果是[由大而小(s2=0)且搜尋值大於中間值(t6=0)]或者是[由小而大(s2=1)且搜尋值小於中間值(t6=1)]，則進入往後走區塊(backward)
		#如果是[由大而小(s2=0)且搜尋值小於中間值(t6=1)]或者是[由小而大(s2=1)且搜尋值大於中間值(t6=0)]，則進入往前走區塊(forward)
		FORWARD: #往前走區塊
			move $t2,$t4 #起始搜尋索引值設為中間搜尋索引值
			addi $t2,$t2,1 #由於中間搜尋索引值已判斷是否等於搜尋值過，所以從中間搜尋索引值的下一個索引值去找
		j WHILE1 #回到迴圈起始點，繼續執行迴圈
		BACKWARD: #往後走區塊
			move $t3,$t4 #節尾搜尋索引值設為中間搜尋索引值
			subi $t3,$t3,1 #由於中間搜尋索引值已判斷是否等於搜尋值過，所以從中間搜尋索引值的上一個索引值去找
		j WHILE1 #回到迴圈起始點，繼續執行迴圈
		NOT_FOUND: #找不到區塊
		print_str("Not found!\n") #印出找不到搜尋值提示
	WHILE1_END: #二分搜尋結尾
	
	
PROGRAM_END: #程式結束區塊
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
