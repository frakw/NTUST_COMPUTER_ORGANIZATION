.data #記憶體變數宣告
input_weight: .asciiz "Please input your weight in kilogram:\n" #輸入體重提示字串
input_height: .asciiz "Please input your height in centimeter:\n" #輸入身高提示字串
output_BMI: .asciiz "Your BMI is " #輸出BMI前提示字串
overweight: .asciiz ". You are overweight.\n" #過重提示字串
normal: .asciiz ".\n" #正常提示字串
underweight: .asciiz ". You are underweight.\n" #過輕提示字串
.text #組語程式碼
main:
#####################################IO提示並讀取身高體重#####################################
la $a0, input_weight #將輸入體重提示字串記憶體位址寫到a0暫存器(syscall規定)
li $v0, 4 #設定syscall模式為 印出字串
syscall #呼叫syscall 印出字串

li $v0, 5 #設定syscall模式為 讀取整數
syscall #呼叫syscall 讀取整數
move $t0,$v0 #讀取後的數值存在v0暫存器，將v0的資料寫入t0


la $a0, input_height #將輸入身高提示字串記憶體位址寫到a0暫存器(syscall規定)
li $v0, 4 #設定syscall模式為 印出字串
syscall #呼叫syscall 印出字串

li $v0, 5 #設定syscall模式為 讀取整數
syscall #呼叫syscall 讀取整數
move $t1,$v0 #讀取後的數值存在v0暫存器，將v0的資料寫入t1
##################################################################################

#####################################計算BMI 並存入t0暫存器#####################################
mul $t0,$t0,10000 #體重乘10000後存回t0暫存器，相當於 t0 *= 10000
mul $t1,$t1,$t1 #身高平方後存回t1暫存器，相當於 t1 = t1*t1
div $t0,$t0,$t1 #t0除以t1後將BMI結果存入t0暫存器，相當於 t0 = t0/t1
########################################################################################

#################################輸出BMI 並判斷是否過輕或過重#######################################
la $a0, output_BMI #將輸出BMI前提示字串記憶體位址寫到a0暫存器(syscall規定)
li $v0, 4 #設定syscall模式為 印出字串
syscall #呼叫syscall 印出字串

move $a0,$t0 #為了印出數字，將BMI值由t0寫到a0 (syscall規定)
li $v0, 1 #設定syscall模式為 印出數字
syscall #呼叫syscall 印出數字

IF:
blt $t0,24,ELSEIF #如果BMI小於24跳至ELSEIF標籤，如果大於等於則執行下一行
la $a0, overweight #將過重提示字串記憶體位址寫到a0暫存器(syscall規定)
j ENDIF #跳至條件判斷(if...else if...else)後

ELSEIF:
bgt $t0,18,ELSE  #如果BMI大於18跳至ELSE標籤，如果小於等於則執行下一行
la $a0, underweight #將過輕提示字串記憶體位址寫到a0暫存器(syscall規定)
j ENDIF #跳至條件判斷(if...else if...else)後

ELSE:
la $a0, normal #將正常提示字串(無提示，僅有句號)記憶體位址寫到a0暫存器(syscall規定)
j ENDIF #跳至條件判斷(if...else if...else)後

ENDIF:
li $v0, 4 #設定syscall模式為 印出字串
syscall #呼叫syscall 印出字串
########################################################################################

li $v0, 10 #設定syscall模式為 離開程式
syscall #呼叫syscall 離開程式