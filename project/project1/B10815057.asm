.data #�O�����ܼƫŧi
input_weight: .asciiz "Please input your weight in kilogram:\n" #��J�魫���ܦr��
input_height: .asciiz "Please input your height in centimeter:\n" #��J�������ܦr��
output_BMI: .asciiz "Your BMI is " #��XBMI�e���ܦr��
overweight: .asciiz ". You are overweight.\n" #�L�����ܦr��
normal: .asciiz ".\n" #���`���ܦr��
underweight: .asciiz ". You are underweight.\n" #�L�����ܦr��
.text #�ջy�{���X
main:
#####################################IO���ܨ�Ū�������魫#####################################
la $a0, input_weight #�N��J�魫���ܦr��O�����}�g��a0�Ȧs��(syscall�W�w)
li $v0, 4 #�]�wsyscall�Ҧ��� �L�X�r��
syscall #�I�ssyscall �L�X�r��

li $v0, 5 #�]�wsyscall�Ҧ��� Ū�����
syscall #�I�ssyscall Ū�����
move $t0,$v0 #Ū���᪺�ƭȦs�bv0�Ȧs���A�Nv0����Ƽg�Jt0


la $a0, input_height #�N��J�������ܦr��O�����}�g��a0�Ȧs��(syscall�W�w)
li $v0, 4 #�]�wsyscall�Ҧ��� �L�X�r��
syscall #�I�ssyscall �L�X�r��

li $v0, 5 #�]�wsyscall�Ҧ��� Ū�����
syscall #�I�ssyscall Ū�����
move $t1,$v0 #Ū���᪺�ƭȦs�bv0�Ȧs���A�Nv0����Ƽg�Jt1
##################################################################################

#####################################�p��BMI �æs�Jt0�Ȧs��#####################################
mul $t0,$t0,10000 #�魫��10000��s�^t0�Ȧs���A�۷�� t0 *= 10000
mul $t1,$t1,$t1 #���������s�^t1�Ȧs���A�۷�� t1 = t1*t1
div $t0,$t0,$t1 #t0���Ht1��NBMI���G�s�Jt0�Ȧs���A�۷�� t0 = t0/t1
########################################################################################

#################################��XBMI �çP�_�O�_�L���ιL��#######################################
la $a0, output_BMI #�N��XBMI�e���ܦr��O�����}�g��a0�Ȧs��(syscall�W�w)
li $v0, 4 #�]�wsyscall�Ҧ��� �L�X�r��
syscall #�I�ssyscall �L�X�r��

move $a0,$t0 #���F�L�X�Ʀr�A�NBMI�ȥ�t0�g��a0 (syscall�W�w)
li $v0, 1 #�]�wsyscall�Ҧ��� �L�X�Ʀr
syscall #�I�ssyscall �L�X�Ʀr

IF:
blt $t0,24,ELSEIF #�p�GBMI�p��24����ELSEIF���ҡA�p�G�j�󵥩�h����U�@��
la $a0, overweight #�N�L�����ܦr��O�����}�g��a0�Ȧs��(syscall�W�w)
j ENDIF #���ܱ���P�_(if...else if...else)��

ELSEIF:
bgt $t0,18,ELSE  #�p�GBMI�j��18����ELSE���ҡA�p�G�p�󵥩�h����U�@��
la $a0, underweight #�N�L�����ܦr��O�����}�g��a0�Ȧs��(syscall�W�w)
j ENDIF #���ܱ���P�_(if...else if...else)��

ELSE:
la $a0, normal #�N���`���ܦr��(�L���ܡA�Ȧ��y��)�O�����}�g��a0�Ȧs��(syscall�W�w)
j ENDIF #���ܱ���P�_(if...else if...else)��

ENDIF:
li $v0, 4 #�]�wsyscall�Ҧ��� �L�X�r��
syscall #�I�ssyscall �L�X�r��
########################################################################################

li $v0, 10 #�]�wsyscall�Ҧ��� ���}�{��
syscall #�I�ssyscall ���}�{��